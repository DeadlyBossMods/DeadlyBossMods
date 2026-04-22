---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = DBM

local L = DBM_CORE_L
local CL = DBM_COMMON_L

local difficulties = private:GetPrototype("Difficulties")
local tableUtils = private:GetPrototype("TableUtils")

local checkEntry, removeEntry = tableUtils.checkEntry, tableUtils.removeEntry
local mrandom = math.random
local SendChatMessage = C_ChatInfo.SendChatMessage or SendChatMessage -- Classic has C_ChatInfo but not C_ChatInfo.SendChatMessage, need to use global for classic
local BNSendWhisper = C_BattleNet and C_BattleNet.SendWhisper or BNSendWhisper
local playerName, playerRealm = UnitName("player"), GetRealmName()
local normalizedPlayerRealm = playerRealm:gsub("[%s-]+", "")
local cSyncSender, eeSyncSender = {}, {}
local eeSyncReceived, cSyncReceived, updateSubNotificationDisplayed = 0, 0, 0
local newerVersionPerson, newersubVersionPerson, forceDisablePerson, iconSetRevision, iconSetPerson = {}, {}, {}, {}, {}
local handleSync
local PForceDisable = 24--When this is incremented, trigger force disable regardless of major patch
-- Localize frequently accessed private namespace items for performance (avoid table lookups on hot paths)
local DBMPrefix = private.DBMPrefix
local DBMSyncProtocol = private.DBMSyncProtocol
local isRetail = private.isRetail
local isClassic = private.isClassic
local isBCC = private.isBCC
local isWrath = private.isWrath
local isCata = private.isCata
local isMop = private.isMop
local testBuild = private.testBuild
local fakeBWVersion = private.fakeBWVersion
local fakeBWHash = private.fakeBWHash
local IsEncounterInProgress = private.IsEncounterInProgress
local checkForSafeSender = private.checkForSafeSender
private.updateNotificationDisplayed = 0
private.showConstantReminder = 0
private.lastBossEngage = {}
private.lastBossDefeat = {}

function DBM:ResetCombatVariables()
	cSyncSender = {}
	cSyncReceived = 0
	eeSyncSender = {}
	eeSyncReceived = 0
	table.wipe(iconSetRevision)
	table.wipe(iconSetPerson)
end

function DBM:ResetVersionCheck(name)
	if name then
		removeEntry(newerVersionPerson, name)
		removeEntry(newersubVersionPerson, name)
		removeEntry(forceDisablePerson, name)
	else
		table.wipe(newerVersionPerson)
		table.wipe(newersubVersionPerson)
		table.wipe(forceDisablePerson)
	end
end

---Automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
---@param protocol number
---@param prefix string
---@param msg any
---@param priority string ChatThrottleLib sync priority
---@param isLogged boolean?
local function sendSync(protocol, prefix, msg, priority, isLogged)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if DBM:IsEnabled() or prefix == "V" or prefix == "H" then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		local sendChannel = "SOLO"
		if not IsTrialAccount() then
			if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
				sendChannel = "INSTANCE_CHAT"
			else
				if IsInRaid() then
					sendChannel = "RAID"
				elseif IsInGroup(1) then
					sendChannel = "PARTY"
				end
			end
		end
		if sendChannel == "SOLO" then
			handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
		else
			if isLogged then
				ChatThrottleLib:SendAddonMessageLogged(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
			else
				ChatThrottleLib:SendAddonMessage(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
			end
		end
	end
end
private.sendSync = sendSync

---Wrapper to send non logged and logged syncs to a specific player via whisper
---@param protocol number
---@param prefix string
---@param msg any
---@param whisperTarget string
---@param priority string ChatThrottleLib sync priority
---@param isLogged boolean?
local function sendWhisperSync(protocol, prefix, msg, whisperTarget, priority, isLogged)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	local fullname = playerName .. "-" .. normalizedPlayerRealm
	if isLogged then
		ChatThrottleLib:SendAddonMessageLogged(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "WHISPER", whisperTarget)
	else
		ChatThrottleLib:SendAddonMessage(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "WHISPER", whisperTarget)
	end
end
private.sendWhisperSync = sendWhisperSync

---Customized syncing specifically for guild comms
---@param protocol number
---@param prefix string
---@param msg any
local function sendGuildSync(protocol, prefix, msg)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if IsInGuild() and (DBM:IsEnabled() or prefix == "V" or prefix == "H") then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		ChatThrottleLib:SendAddonMessage("NORMAL", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
end
private.sendGuildSync = sendGuildSync

---Sync Object specifically for out in the world sync messages that have different rules than standard syncs
---@param self DBM
---@param protocol number
---@param prefix string
---@param msg any
---@param noBNet boolean?
local function SendWorldSync(self, protocol, prefix, msg, noBNet)
	if not DBM:IsEnabled() then return end--Block all world syncs if force disabled
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	DBM:Debug("SendWorldSync running for " .. prefix)
	local fullname = playerName .. "-" .. normalizedPlayerRealm
	local sendChannel = "SOLO"
	if not IsTrialAccount() then
		if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
			sendChannel = "INSTANCE_CHAT"
		else
			if IsInRaid() then
				sendChannel = "RAID"
			elseif IsInGroup(1) then
				sendChannel = "PARTY"
			end
		end
	end
	if sendChannel == "SOLO" then
		handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
	else
		ChatThrottleLib:SendAddonMessage("ALERT", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
	end
	if IsInGuild() then
		ChatThrottleLib:SendAddonMessage("ALERT", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
	if self.Options.EnableWBSharing and not noBNet then
		local _, numBNetOnline = BNGetNumFriends()
		local connectedServers = GetAutoCompleteRealms()
		for i = 1, numBNetOnline do
			local gameAccountID, isOnline, realmName
			local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
			if accountInfo then
				gameAccountID, isOnline, realmName = accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.isOnline, accountInfo.gameAccountInfo.realmName
			end
			if gameAccountID and isOnline and realmName then
				local sameRealm = false
				if connectedServers then
					for j = 1, #connectedServers do
						if realmName == connectedServers[j] then
							sameRealm = true
							break
						end
					end
				else
					if realmName == playerRealm or realmName == normalizedPlayerRealm then
						sameRealm = true
					end
				end
				if sameRealm then
					ChatThrottleLib:BNSendGameData("NORMAL", DBMPrefix, DBMSyncProtocol .. "\t" .. prefix .. "\t" .. msg, "WHISPER", gameAccountID)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
				end
			end
		end
	end
end
private.SendWorldSync = SendWorldSync

---Automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
---@param prefix string
---@param msg any
---@param channel string
---@param priority string ChatThrottleLib sync priority
local function sendBWSync(prefix, msg, channel, priority)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if DBM:IsEnabled() and not IsTrialAccount() then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		ChatThrottleLib:SendAddonMessage(priority, "BigWigs", prefix .. "^" .. msg, channel)
	end
end
private.sendBWSync = sendBWSync

-- sends a whisper to a player by their character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if DBM:MidRestrictionsActive() then return end--Block all in instance chat messages in Midnight Alpha
	if IsTrialAccount() then return end
	if type(target) == "number" then
		if not BNIsSelf(target) then -- Never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
		end
	elseif type(target) == "string" then
		SendChatMessage(msg, "WHISPER", nil, target) -- Whispering to ourselves here is okay and somewhat useful for whisper-warnings
	end
end
private.sendWhisper = sendWhisper

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

do
	local DBMZoneCombatScanner = private:GetModule("TrashCombatScanningModule")

	local syncHandlers, whisperSyncHandlers, guildSyncHandlers = {}, {}, {}

	-- DBM uses the following prefixes since 4.1 as pre-4.1 sync code is going to be incompatible anyway, so this is the perfect opportunity to throw away the old and long names
	-- M = Mod
	-- C = Combat start
	-- ZC = Zone Combat
	-- GC = Guild Combat Start
	-- IS = Icon set info
	-- K = Kill
	-- H = Hi!
	-- V = Incoming version information
	-- U = User Timer
	-- PT = Pull Timer (for sound effects, the timer itself is still sent as a normal timer)
	-- RT = Request Timers
	-- CI = Combat Info
	-- TR = Timer Recovery
	-- IR = Instance Info Request
	-- IRE = Instance Info Requested Ended/Canceled
	-- II = Instance Info
	-- WBE = World Boss engage info
	-- WBD = World Boss defeat info
	-- WBA = World Buff Activation
	-- RLO = Raid Leader Override
	-- NS = Note Share

	syncHandlers["M"] = function(sender, _, mod, revision, event, ...)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["NS"] = function(sender, _, modid, modvar, text, abilityName)
		if sender == playerName then return end
		if DBM.Options.BlockNoteShare or InCombatLockdown() or UnitAffectingCombat("player") or IsFalling() then return end--or DBM:GetRaidRank(sender) == 0
		if IsInGroup(2) and IsInInstance() then return end
		--^^You are in LFR, BG, or LFG. Block note syncs. They shouldn't be sendable, but in case someone edits DBM^^
		local mod = DBM:GetModByName(modid or "")
		local ability = abilityName or CL.UNKNOWN
		if mod and modvar and text and text ~= "" then
			if DBM:AntiSpam(5, modvar) then--Don't allow calling same note more than once per 5 seconds
				DBM:AddMsg(L.NOTE_SHARE_SUCCESS:format(sender, ability))
				DBM:AddMsg(("|Hgarrmission:DBM:noteshare:%s:%s:%s:%s:%s|h|cff3588ff[%s]|r|h"):format(modid, modvar, ability, text, sender, L.NOTE_SHARE_LINK))
--				DBM:ShowNoteEditor(mod, modvar, ability, text, sender)
			else
				DBM:Debug(sender .. " is attempting to send too many notes so notes are being throttled")
			end
		else
			DBM:AddMsg(L.NOTE_SHARE_FAIL:format(sender, ability))
		end
	end

	syncHandlers["C"] = function(sender, _, delay, mod, modRevision, startHp, dbmRevision, modHFRevision, event)
		if not DBM:IsEnabled() or sender == playerName then return end
		if private.LastInstanceType == "pvp" then return end
		if private.LastInstanceType == "none" and (not UnitAffectingCombat("player") or DBM:InCombat()) then--world boss
			local senderuId = DBM:GetRaidUnitId(sender)
			if not senderuId then return end--Should never happen, but just in case. If happens, MANY "C" syncs are sent. losing 1 no big deal.
			local playerZone = select(-1, UnitPosition("player"))
			local senderZone = select(-1, UnitPosition(senderuId))
			if playerZone ~= senderZone then return end--not same zone
		end
		if not cSyncSender[sender] then
			cSyncSender[sender] = true
			cSyncReceived = cSyncReceived + 1
			if cSyncReceived > 2 then -- need at least 3 sync to combat start. (for security)
				local lag = select(4, GetNetStats()) / 1000
				delay = tonumber(delay or 0) or 0
				---@diagnostic disable-next-line: param-type-mismatch
				mod = DBM:GetModByName(mod or "")
				modRevision = tonumber(modRevision or 0) or 0
				dbmRevision = tonumber(dbmRevision or 0) or 0
				modHFRevision = tonumber(modHFRevision or 0) or 0
				startHp = tonumber(startHp or -1) or -1
				if dbmRevision < 10481 then return end
				local LastInstanceMapID = DBM:GetCurrentArea()
				if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not (DBM:InCombat() and mod.noMultiBoss) then
					DBM:StartCombat(mod, delay + lag, "SYNC from - " .. sender, true, startHp, event)
					if mod.revision < modHFRevision then--mod.revision because we want to compare to OUR revision not senders
						--There is a newer RELEASE version of DBM out that has this mods fixes that we do not possess
						if DBM.HighestRelease >= modHFRevision and DBM.ReleaseRevision < modHFRevision then
							private.showConstantReminder = 2
							if DBM:AntiSpam(3, "HOTFIX") then
								DBM:AddMsg(L.UPDATEREMINDER_HOTFIX)
							end
						else--This mods fixes are in an alpha version
							if DBM:AntiSpam(3, "HOTFIX") then
								DBM:AddMsg(L.UPDATEREMINDER_HOTFIX_ALPHA)
							end
						end
					end
				end
			end
		end
	end

	syncHandlers["ZC"] = function(sender, _, guid, cid)
		DBMZoneCombatScanner:OnSync(sender, guid, tonumber(cid))
	end

	syncHandlers["RLO"] = function(sender, protocol, statusWhisper, guildStatus, raidIcons, chatBubbles)
		if (DBM:GetRaidRank(sender) ~= 2 or not IsInGroup()) then return end--If not on group, we're probably sender, don't disable status. IF not leader, someone is trying to spoof this, block that too
		if not protocol or protocol ~= 2 then return end--Ignore old versions
		DBM:Debug("Raid leader override comm Received")
		statusWhisper, guildStatus, raidIcons, chatBubbles = tonumber(statusWhisper) or 0, tonumber(guildStatus) or 0, tonumber(raidIcons) or 0, tonumber(chatBubbles) or 0
		local activated = false
		if statusWhisper == 1 then
			activated = true
			private.statusWhisperDisabled = true
		end
		if guildStatus == 1 then
			activated = true
			private.statusGuildDisabled = true
		end
		if raidIcons == 1 then
			activated = true
			private.raidIconsDisabled = true
		end
		if chatBubbles == 1 then
			activated = true
			private.chatBubblesDisabled = true
		end
		if activated then
			DBM:AddMsg(L.OVERRIDE_ACTIVATED)
		end
	end

	syncHandlers["IS"] = function(_, _, guid, ver, optionName)
		ver = tonumber(ver) or 0
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			private.canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			private.canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or CL.UNKNOWN
		DBM:Debug(name .. " was elected icon setter for " .. optionName, 2)
	end

	syncHandlers["K"] = function(_, _, cId, difficulty)
		if not difficulty then return end
		difficulty = tonumber(difficulty)
		--Ignore kill events sent from wrong difficulty (such as a player doing same raid at same time in another difficulty)
		if difficulty ~= difficulties.difficultyIndex then return end
		if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "none" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["EE"] = function(sender, _, eId, success, mod, modRevision)
		if select(2, IsInInstance()) == "pvp" then return end
		eId = tonumber(eId or "")
		success = tonumber(success)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and eId and success and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not eeSyncSender[sender] then
			eeSyncSender[sender] = true
			eeSyncReceived = eeSyncReceived + 1
			if eeSyncReceived > (isRetail and 2 or 0) then -- need at least 3 person to combat end. (for security) (only 1 on classic because classic breaks too badly otherwise)
				DBM:EndCombat(mod, success == 0, nil, "ENCOUNTER_END synced")
			end
		end
	end

	syncHandlers["BT"] = function(sender, _, timer)
		if DBM.Options.DontShowUserTimers then return end--or not private.isWrath
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "BT" .. sender) then
			--For some reason LuaLS is really stupid here. despite fact for it to be IMPOSSIBLE for timer to be anything but a valid number
			--It expects an extra number check for no reason at all
			---@diagnostic disable-next-line: param-type-mismatch
			private.breakTimerStart(DBM, timer, sender)
		end
	end

	whisperSyncHandlers["BTR3"] = function(sender, _, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		DBM:Unschedule(DBM.RequestTimers)--IF we got BTR3 sync, then we know immediately RequestTimers was successful, so abort others
		if DBM:InCombat() then return end
		if DBT:GetBar(L.TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		--For some reason LuaLS is really stupid here. despite fact for it to be IMPOSSIBLE for timer to be anything but a valid number
		--It expects an extra number check for no reason at all
		---@diagnostic disable-next-line: param-type-mismatch
		private.breakTimerStart(DBM, timer, sender, true)--, nil, true
	end

	local function SendVersion(guild)
		--Due to increasing addon comm throttling in instances, guild version sharing is disabled in instances to reduce comms
		if guild and not IsInInstance() then
			local message
			if not isRetail and DBM.classicSubVersion then
				message = ("%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, tostring(PForceDisable), tostring(DBM.classicSubVersion))
				private.sendGuildSync(3, "GV", message)
			else
				message = ("%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, tostring(PForceDisable))
				private.sendGuildSync(2, "GV", message)
			end
			return
		end
		if DBM.Options.FakeBWVersion and not DBM:IsEnabled() and not IsTrialAccount() then
			private.sendBWSync("V", ("%d^%s"):format(fakeBWVersion, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY", "NORMAL")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		private.sendSync(3, "V", ("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), tostring(PForceDisable), tostring(DBM.classicSubVersion or 0), tostring(DBM.dungeonSubVersion or 0)), "NORMAL")
	end

	local function HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		if version > DBM.Revision then -- Update reminder
			--Core Version Handling
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
					if (forceDisable > PForceDisable) and not checkEntry(forceDisablePerson, sender) then
						forceDisablePerson[#forceDisablePerson + 1] = sender
						DBM:Debug("Newer force disable detected from " .. sender .. " : Rev - " .. forceDisable, 3)
					end
				end
				if #newerVersionPerson == 2 and private.updateNotificationDisplayed < 2 then--Only requires 2 for update notification.
					if DBM.HighestRelease < version then
						DBM.HighestRelease = version--Increase HighestRelease
						DBM.NewerVersion = displayVersion--Apply NewerVersion
						--UGLY hack to get release version number instead of alpha one
						if DBM.NewerVersion:find("alpha") then
							local temp1, _ = string.split(" ", DBM.NewerVersion)--Strip down to just version, no alpha
							if temp1 then
								local temp3, temp4, temp5 = string.split(".", temp1)--Strip version down to 3 numbers
								local patchVersion = temp5 and tonumber(temp5)
								if temp3 and temp4 and patchVersion then
									patchVersion = patchVersion - 1
									DBM.NewerVersion = temp3 .. "." .. temp4 .. "." .. tostring(patchVersion)
								end
							end
						end
					end
					--Find min revision.
					private.updateNotificationDisplayed = 2
					DBM:AddMsg(L.UPDATEREMINDER_HEADER:match("([^\n]*)"))
					DBM:AddMsg(L.UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, DBM:ShowRealDate(version)))
					private.showConstantReminder = 1
				elseif #newerVersionPerson >= 3 and private.updateNotificationDisplayed < 3 then--The following code requires at least THREE people to send that higher revision. That should be more than adequate
					--Disable if out of date and at least 3 players sent a higher forceDisable revision
					if not testBuild and #forceDisablePerson == 3 then
						-- Start days check
						local curseDate = tostring(version)
						local daysPerMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
						local year, month, day = tonumber(curseDate:sub(1, 4)), tonumber(curseDate:sub(5, 6)), tonumber(curseDate:sub(7, 8))
						if day + 2 > daysPerMonth[month] then
							day = day + 2 - daysPerMonth[month]
							month = month + 1
						else
							day = day + 2
						end
						if month > 12 then
							month = 1
							year = year + 1
						end
						local currentDateTable = date("*t")
						if currentDateTable.year < year or currentDateTable.month < month or currentDateTable.day < day then
							return
						end
						-- End days check
						private.updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					--Disallow out of date to run during beta/ptr what so ever regardless of forceDisable revision
					elseif testBuild then
						private.updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					end
				end
			end
		end
		if not isRetail and type(classicSubVers) == 'number' and classicSubVers > DBM.classicSubVersion then -- Update reminder
			if #newersubVersionPerson < 4 then
				if not checkEntry(newersubVersionPerson, sender) then
					newersubVersionPerson[#newersubVersionPerson + 1] = sender
					DBM:Debug("Newer classic subversion detected from " .. sender .. " : Rev - " .. classicSubVers .. ", Rev Diff - " .. (classicSubVers - DBM.classicSubVersion), 3)
				end
				if #newersubVersionPerson == 2 and updateSubNotificationDisplayed < 2 then--Only requires 2 for update notification.
					updateSubNotificationDisplayed = 2
					local checkedSubmodule = isMop and "DBM-Raids-MoP" or isCata and "DBM-Raids-Cata" or isWrath and "DBM-Raids-WoTLK" or isBCC and "DBM-Raids-BC" or "DBM-Raids-Vanilla"
					DBM:AddMsg(L.UPDATEREMINDER_HEADER_SUBMODULE:match("\n(.*)"):format(checkedSubmodule, classicSubVers))
					private.showConstantReminder = 1
				end
			end
		end
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function()
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	guildSyncHandlers["GH"] = function()
		if DBM.ReleaseRevision >= DBM.HighestRelease then--Do not send version to guild if it's not up to date, since this is only used for update notification
			DBM:Unschedule(SendVersion, true)
			--Throttle so we don't needlessly send tons of comms
			--For every 50 players online, DBM has an increasingly lower chance of replying to a version check request. This is because only 3 people actually need to reply
			--50 people or less, 100% chance anyone who saw request will reply
			--100 people on, only 50% chance DBM users replies to request
			--150 people on, only 33% chance a DBM user replies to request
			--1000 people online, only 5% chance a DBM user replies to request
			local _, online = GetNumGuildMembers()
			local chances = (online or 1) / 50
			if chances < 1 then chances = 1 end
			if mrandom(1, chances) == 1 then
				DBM:Schedule(5, SendVersion, true)--Send version if 5 seconds have past since last "Hi" sync
			end
		end
	end

	syncHandlers["BV"] = function(sender, _, version, hash)--Parsed from bigwigs V7+
		if version and DBM:GetRaidRoster(sender) then
			private.setRaidMemberProperties(sender, {
				bwversion = version,
				bwhash = hash or ""
			})
		end
	end

	syncHandlers["V"] = function(sender, protocol, revision, version, displayVersion, locale, iconEnabled, forceDisable, classicSubVers, dungeonSubVers)
		revision, version, classicSubVers, dungeonSubVers = tonumber(revision), tonumber(version), tonumber(classicSubVers), tonumber(dungeonSubVers) or 0
		if protocol < 3 then return end
		--Nil it out on retail, replace with string on classic versions
		if classicSubVers and classicSubVers == 0 then
			if isRetail then
				classicSubVers = nil
			else
				classicSubVers = L.MOD_MISSING
			end
		end
		if dungeonSubVers and dungeonSubVers == 0 then
			dungeonSubVers = L.NOT_INSTALLED
		end
		forceDisable = tonumber(forceDisable) or 0
		if revision and version and displayVersion and DBM:GetRaidRoster(sender) then
			local properties = {
				revision = revision,
				version = version,
				displayVersion = displayVersion,
				dungeonSubVers = dungeonSubVers,
				locale = locale,
				enabledIcons = iconEnabled or "false"
			}
			if not isRetail then
				properties.classicSubVers = classicSubVers
			end
			private.setRaidMemberProperties(sender, properties)
			DBM:Debug("Received version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	guildSyncHandlers["GV"] = function(sender, _, revision, version, displayVersion, forceDisable, classicSubVers)
		revision, version, forceDisable, classicSubVers = tonumber(revision), tonumber(version), tonumber(forceDisable) or 0, tonumber(classicSubVers)
		--Nil it out on retail, replace with string on classic versions
		if classicSubVers and classicSubVers == 0 then
			if isRetail then
				classicSubVers = nil
			else
				classicSubVers = L.MOD_MISSING
			end
		end
		if revision and version and displayVersion then
			DBM:Debug("Received G version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision) .. ", Display Version " .. displayVersion, 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		end
	end

	syncHandlers["U"] = function(sender, _, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM.Options.DontShowUserTimers then return end
		if DBM:GetRaidRank(sender) == 0 or difficulties.difficultyIndex == 7 or difficulties.difficultyIndex == 17 then return end
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	whisperSyncHandlers["UW"] = function(sender, _, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM.Options.DontShowUserTimers then return end
		if DBM:GetRaidRank(sender) == 0 or difficulties.difficultyIndex == 7 or difficulties.difficultyIndex == 17 then return end--Block in LFR, or if not an assistant
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	guildSyncHandlers["GCB"] = function(_, protocol, modId, difficulty, difficultyModifier, name, groupLeader)
		if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
		if not protocol or protocol ~= 4 then return end--Ignore old versions
		if DBM:AntiSpam(isRetail and 10 or 20, "GCB") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not isClassic and not isBCC then
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6 .. "+ (" .. difficultyModifier .. ")"
					else
						difficultyName = PLAYER_DIFFICULTY6 .. "+"
					end
				elseif difficulty == 3 or difficulty == 175 then
					difficultyName = RAID_DIFFICULTY1
				elseif difficulty == 4 or difficulty == 176 then
					difficultyName = RAID_DIFFICULTY2
				elseif difficulty == 5 or difficulty == 193 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 6 or difficulty == 194 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(difficultyName .. " - " .. bossName, groupLeader))-- "%s has been engaged by %s's guild group"
			else--Vanilla and TBC single format raids
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(bossName, groupLeader))
			end
		end
	end

	guildSyncHandlers["GCE"] = function(_, protocol, modId, wipe, time, difficulty, difficultyModifier, name, groupLeader, wipeHP)
		if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
		if not protocol or protocol ~= 9 then return end--Ignore old versions
		if DBM:AntiSpam(isRetail and 10 or 20, "GCE") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not isClassic and not isBCC then
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6 .. "+ (" .. difficultyModifier .. ")"
					else
						difficultyName = PLAYER_DIFFICULTY6 .. "+"
					end
				elseif difficulty == 3 or difficulty == 175 then
					difficultyName = RAID_DIFFICULTY1
				elseif difficulty == 4 or difficulty == 176 then
					difficultyName = RAID_DIFFICULTY2
				elseif difficulty == 5 or difficulty == 193 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 6 or difficulty == 194 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				if wipe == "1" then
					if DBM:IsPostMidnight() then
						DBM:AddMsg(L.GUILD_COMBAT_ENDED:format(groupLeader or CL.UNKNOWN, difficultyName .. " - " .. bossName, time))
					else
						DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, difficultyName .. " - " .. bossName, wipeHP, time))--"%s's Guild group has wiped on %s (%s) after %s.
					end
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(difficultyName .. " - " .. bossName, groupLeader or CL.UNKNOWN, time))--"%s has been defeated by %s's guild group after %s!"
				end
			else--Vanilla and TBC single format raids
				if wipe == "1" then
					if wipeHP then
						DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, bossName, wipeHP, time))
					else
						DBM:AddMsg(L.GUILD_COMBAT_ENDED:format(groupLeader or CL.UNKNOWN, bossName, time))
					end
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(bossName, groupLeader or CL.UNKNOWN, time))
				end
			end
		end
	end

	guildSyncHandlers["WBE"] = function(sender, protocol, modId, realm, health, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if private.lastBossEngage[modId .. realm] and (GetTime() - private.lastBossEngage[modId .. realm] < 30) then return end--We recently got a sync about this boss on this realm, so do nothing.
		private.lastBossEngage[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
		end
	end

	guildSyncHandlers["WBD"] = function(sender, protocol, modId, realm, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if private.lastBossDefeat[modId .. realm] and (GetTime() - private.lastBossDefeat[modId .. realm] < 30) then return end
		private.lastBossDefeat[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, sender))
		end
	end

	guildSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		if not protocol or protocol ~= 4 or isRetail then return end--Ignore old versions
		if private.lastBossEngage[bossName .. faction] and (GetTime() - private.lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		private.lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and not DBM:InCombat() then
			local factionText = faction == "Alliance" and FACTION_ALLIANCE or faction == "Horde" and FACTION_HORDE or CL.BOTH
			local buffName, _, buffIcon = DBM:GetSpellInfo(tonumber(spellId) or 0)
			DBM:AddMsg(L.WORLDBUFF_STARTED:format(buffName or CL.UNKNOWN, factionText, sender))
			DBM:PlaySoundFile(DBM.Options.RaidWarningSound, true)
			time = tonumber(time)
			if time then
				DBT:CreateBar(time, buffName or CL.UNKNOWN, buffIcon or 136106)
			end
		end
	end

	whisperSyncHandlers["WBE"] = function(sender, protocol, modId, realm, health, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if private.lastBossEngage[modId .. realm] and (GetTime() - private.lastBossEngage[modId .. realm] < 30) then return end
		private.lastBossEngage[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and (isRetail and not IsEncounterInProgress() or not DBM:InCombat()) then
			local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
			local toonName = gameAccountInfo and gameAccountInfo.characterName or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
		end
	end

	whisperSyncHandlers["WBD"] = function(sender, protocol, modId, realm, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if private.lastBossDefeat[modId .. realm] and (GetTime() - private.lastBossDefeat[modId .. realm] < 30) then return end
		private.lastBossDefeat[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and (isRetail and not IsEncounterInProgress() or not DBM:InCombat()) then
			local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
			local toonName = gameAccountInfo and gameAccountInfo.characterName or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, toonName))
		end
	end

	whisperSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		if not protocol or protocol ~= 4 or isRetail then return end--Ignore old versions
		if private.lastBossEngage[bossName .. faction] and (GetTime() - private.lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		private.lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and not DBM:InCombat() then
			local factionText = faction == "Alliance" and FACTION_ALLIANCE or faction == "Horde" and FACTION_HORDE or CL.BOTH
			local buffName, _, buffIcon = DBM:GetSpellInfo(tonumber(spellId) or 0)
			DBM:AddMsg(L.WORLDBUFF_STARTED:format(buffName or CL.UNKNOWN, factionText, sender))
			DBM:PlaySoundFile(DBM.Options.RaidWarningSound, true)
			time = tonumber(time)
			if time then
				DBT:CreateBar(time, buffName or CL.UNKNOWN, buffIcon or 136106)
			end
		end
	end

	whisperSyncHandlers["RT"] = function(sender)
		if UnitInBattleground("player") then
			DBM:SendPVPTimers(sender)
		else
			DBM:SendTimers(sender)
		end
	end

	whisperSyncHandlers["CI"] = function(sender, _, mod, time)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["TR"] = function(sender, _, mod, timeLeft, totalTime, id, paused, ...)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, paused and paused == "1" and true or false, ...)
		end
	end

	whisperSyncHandlers["VI"] = function(sender, _, mod, name, value)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		value = tonumber(value) or value
		if mod and name and value then
			DBM:ReceiveVariableInfo(sender, mod, name, value)
		end
	end

	--Function to correct a blizzard bug where off realm players have realm name stripped
	--Had to be custom function due to bugs with two players with same name on different realms
	--local function VerifyRaidName(apiName, SyncedName)
	--	local _, serverName = string.split("-", SyncedName)
	--	if serverName and serverName ~= playerRealm and serverName ~= normalizedPlayerRealm then
	--		return SyncedName--Use synced name with realm added back on
	--	else
	--		return apiName--Use api name without realm
	--	end
	--end

	handleSync = function(channel, sender, _, protocol, prefix, ...)--dbmSender unused for now
		protocol = tonumber(protocol)
		if not protocol then
			return
		end
		if protocol < DBMSyncProtocol then
			return
		end
		if not prefix then
			return
		end
		local handler
		--Can only be from a friend
		if channel == "BN_WHISPER" then
			handler = whisperSyncHandlers[prefix]
		--Whisper syncs sent from non friends are automatically rejected if not from a friend or someone in your group
		elseif channel == "WHISPER" and sender ~= playerName then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			if (checkForSafeSender(sender, true) or DBM:GetRaidUnitId(sender)) then--Sender passes safety check, or is in group
				handler = whisperSyncHandlers[prefix]
			end
		elseif channel == "GUILD" then
			handler = guildSyncHandlers[prefix]
		else-- Instance, Raid, Party
			handler = syncHandlers[prefix]
		end
		if handler then
			--if dbmSender then
			--	--Strip spaces from realm name, since this is what Unit Tokens expect
			--	--(newer versions of DBM do this on send, but we double check for older versions)
			--	dbmSender = dbmSender:gsub("[%s-]+", "")--Needs to be fixed, if this is ever uncommented as right now it'd strip realm
			--	sender = VerifyRaidName(sender, dbmSender)
			--end
			return handler(sender, protocol, ...)
		end
	end

	local function GetCorrectSender(senderOne, senderTwo)
		local correctSender = senderOne
		if senderOne:find("-") then--first sender arg has realm name
			correctSender = Ambiguate(senderOne, "none")
		elseif senderTwo and senderTwo:find("-") then--Second sender arg has realm name
			correctSender = Ambiguate(senderTwo, "none")
		end
		return correctSender
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, senderOne, senderTwo)
		if prefix == DBMPrefix and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" or channel == "GUILD") then
			if self:issecretvalue(msg) then
				return
			end
			local correctSender = GetCorrectSender(senderOne, senderTwo)
			handleSync(channel, correctSender, strsplit("\t", msg))
		elseif prefix == "BigWigs" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT") then
			if self:issecretvalue(msg) then
				return
			end
			local bwPrefix, bwMsg, extra = strsplit("^", msg)
			if bwPrefix and bwMsg then
				local correctSender = GetCorrectSender(senderOne, senderTwo)
				if bwPrefix == "V" and extra then--Nil check "extra" to avoid error from older version
					local verString, hash = bwMsg, extra
					local version = tonumber(verString) or 0
					if version == 0 then return end--Just a query
					handleSync(channel, correctSender, nil, DBMSyncProtocol, "BV", version, hash)--Prefix changed, so it's not handled by DBMs "V" handler
					if version > fakeBWVersion then--Newer revision found, upgrade!
						private.fakeBWVersion = version
						private.fakeBWHash = hash
						-- Update local upvalues to stay in sync
						fakeBWVersion = version
						fakeBWHash = hash
					end
				elseif bwPrefix == "Q" then--Version request prefix
					self:Unschedule(SendVersion)
					self:Schedule(3, SendVersion)
				elseif bwPrefix == "B" then--Boss Mod Sync
					local inCombat = private.getInCombat()
					for i = #inCombat, 1, -1 do
						local mod = inCombat[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, correctSender)
						end
					end
					local oocBWComms = private.getOOCBWComms()
					for i = 1, #oocBWComms do
						local mod = oocBWComms[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, correctSender)
						end
					end
				end
			end
		elseif prefix == "Transcriptor" and msg then
			if self:issecretvalue(msg) then
				return
			end
			local correctSender = GetCorrectSender(senderOne, senderTwo)
			local inCombat = private.getInCombat()
			for i = #inCombat, 1, -1 do
				local mod = inCombat[i]
				if mod and mod.OnTranscriptorSync then
					mod:OnTranscriptorSync(msg, correctSender)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if msg:find("spell:") and (DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging())) then
				local spellId = string.match(msg, "spell:(%d+)") or CL.UNKNOWN
				local spellName = string.match(msg, "h%[(.-)%]|h") or CL.UNKNOWN
				local message = "RAID_BOSS_WHISPER on " .. correctSender .. " with spell of " .. spellName .. " (" .. spellId .. ")"
				self:Debug(message)
			end
		end
	end
	DBM.CHAT_MSG_ADDON_LOGGED = DBM.CHAT_MSG_ADDON

	function DBM:BN_CHAT_MSG_ADDON(prefix, msg, _, sender)
		if prefix == DBMPrefix and msg then
			handleSync("BN_WHISPER", sender, nil, strsplit("\t", msg))
		end
	end
end
