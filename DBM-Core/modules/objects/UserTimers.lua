---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = DBM

local L = DBM_CORE_L

local stringUtils = private:GetPrototype("StringUtils")
local difficulties = private:GetPrototype("Difficulties")

------------------------
--  Break/Pull Timer  --
------------------------

do
	local GetItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
	local function checkForActualPull()
		-- We don't need to check `RecordOnlyBosses` as it's already checked in where this function is called
		-- If you have more than 1 mob, keep logging
		-- If you're in mythic+, keep logging
		-- Otherwise, stop logging post-pull timer ended
		if not DBM:InCombat() and difficulties.difficultyIndex ~= 8 then
			DBM:StopLogging()
		end
	end
	local dummyMod -- dummy mod for the pull timer
	---@param self DBM
	---@param sender string
	---@param timer any string or number only, but luaLS bitches if I actually tell it that
	---@param blizzardTimer boolean?
	local function pullTimerStart(self, sender, timer, blizzardTimer)
		if not timer then return end
		if not blizzardTimer then return end--Ignore old DBM version comms
		local unitId
		if sender then--Blizzard cancel events triggered by system (such as encounter start) have no sender
			unitId = self:GetRaidUnitIdByGuid(sender)
			sender = self:GetUnitFullName(unitId) or sender
			local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
			if (self:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or private.IsEncounterInProgress() then
				return
			end
		end
		--Abort if mapID filter is enabled and sender actually sent a mapID. if no mapID is sent, it's always passed through (IE BW pull timers)
		if unitId then
			local senderMapID = IsInInstance() and select(-1, UnitPosition(unitId)) or C_Map.GetBestMapForUnit(unitId) or 0
			local playerMapID = IsInInstance() and select(-1, UnitPosition("player")) or C_Map.GetBestMapForUnit("player") or 0
			if self.Options.DontShowPTNoID and senderMapID and playerMapID and senderMapID ~= playerMapID then return end
		end
		timer = tonumber(timer or 0)
		--We want to permit 0 itself, but block anything negative number or anything between 0 and 3 or anything longer than minute
		if (timer > 0 and timer < 3) then--timer > 60 or
			return
		end
		if timer <= 0 or self:AntiSpam(1, "PT" .. (sender or "SYSTEM")) then--prevent double pull timer from BW and other mods that are sending D4 and D5 at same time (DELETE AntiSpam Later)
			if not dummyMod then
				local threshold = self.Options.PTCountThreshold2
				threshold = floor(threshold)
				---@class DBMDummyMod: DBMMod
				dummyMod = self:NewMod("PullTimerCountdownDummy")
				dummyMod.isDummyMod = true
				self:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
				dummyMod.text = dummyMod:NewAnnounce("%s", 1, "132349")
				dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
				dummyMod.timer = dummyMod:NewTimer(20, "%s", "132349", nil, nil, 0, nil, nil, self.Options.DontPlayPTCountdown and 0 or 4, threshold, nil, nil, nil, nil, nil, nil, "pull")
			end
			--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not self.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_PULL)
				dummyMod.timer:Stop()
			end
			dummyMod.text:Cancel()
			if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
			self:FlashClientIcon()
			if not self.Options.DontShowPT2 then
				dummyMod.timer:Start(timer, L.TIMER_PULL)
			end
			if not self.Options.DontShowPTText and timer then
				if not self:IsPostMidnight() then
					local target = unitId and DBM:GetUnitFullName(unitId.."target")
					if target and not DBM:GetRaidRoster(target) then
						dummyMod.text:Show(L.ANNOUNCE_PULL_TARGET:format(target, timer, sender))
						dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW_TARGET:format(target))
					else
						dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
						dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
					end
				else
					dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
				end
			end
			if self.Options.EventSoundPullTimer and self.Options.EventSoundPullTimer ~= "" and self.Options.EventSoundPullTimer ~= "None" then
				self:PlaySoundFile(self.Options.EventSoundPullTimer, nil, true)
			end
			if self.Options.RecordOnlyBosses then
				self:StartLogging(timer, checkForActualPull)--Start logging here to catch pre pots.
			end
			if private.isRetail then
				if not InCombatLockdown() and not self.PrivateAuras:IsRegistered() then
					--Locked down in combat, so we try to do it early in pull timer
					self.PrivateAuras:RegisterAllUnits()
				end
			end
			if private.isRetail and self.Options.CheckGear and not private.testBuild then
				local bagilvl, equippedilvl = GetAverageItemLevel()
				local difference = bagilvl - equippedilvl
				local weapon = GetInventoryItemLink("player", 16)
				local fishingPole = false
				if weapon then
					local _, _, _, _, _, _, type = GetItemInfo(weapon)
					if type and type == L.GEAR_FISHING_POLE then
						fishingPole = true
					end
				end
				if IsInRaid() and difference >= 18 then
					dummyMod.geartext:Show(L.GEAR_WARNING:format(floor(difference)))
				elseif IsInRaid() and (not weapon or fishingPole) then
					dummyMod.geartext:Show(L.GEAR_WARNING_WEAPON)
				end
			end
		end
	end

	local function pullTimerStop()
		if dummyMod then
			dummyMod.timer:Stop()
			dummyMod.text:Cancel()
		end
	end
	private.pullTimerStop = pullTimerStop

	function DBM:START_PLAYER_COUNTDOWN(initiatedByGuid, timeSeconds)
		if self:hasanysecretvalues(initiatedByGuid, timeSeconds) then
			return
		end
		--Ignore this event in combat
		if self:InCombat() then return end
--		if timeSeconds > 60 then--treat as a break timer
--			private.breakTimerStart(self, timeSeconds, initiatedBy, true)
--		else--Treat as a pull timer
			--In TWW, initiatedByName is in a diff place. We solve this by simply checking new location cause that'll be nil on live
			pullTimerStart(self, initiatedByGuid, timeSeconds, true)
--		end
	end

	function DBM:CANCEL_PLAYER_COUNTDOWN(initiatedByGuid)
		if self:issecretvalue(initiatedByGuid) then
			return
		end
		--when CANCEL_PLAYER_COUNTDOWN is called by ENCOUNTER_START, sender is nil
--		private.breakTimerStart(self, 0, initiatedBy, true)
		--In TWW, initiatedByName is in a diff place. We solve this by simply checking new location cause that'll be nil on live
		pullTimerStart(self, initiatedByGuid, 0, true)
	end
end

do
	local dummyMod2 -- dummy mod for the break timer

	---@param self DBM
	local function resetBreakTimer(self)
		self.Options.RestoreSettingBreakTimer = nil
	end

	---@param self DBM
	---@param timer number
	---@param sender string
	---@param isRecovery boolean?
	local function breakTimerStart(self, timer, sender, isRecovery)
		local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
		if not isRecovery and ((self:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or private.IsEncounterInProgress()) then
			return
		end
		if not dummyMod2 then
			local threshold = self.Options.PTCountThreshold2
			threshold = floor(threshold)
			---@class DBMDummyMod2: DBMMod
			dummyMod2 = self:NewMod("BreakTimerCountdownDummy")
			dummyMod2.isDummyMod = true
			self:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
			dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, private.isRetail and "237538" or "136106")
			--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
			dummyMod2.timer = dummyMod2:NewTimer(20, L.TIMER_BREAK, private.isRetail and "237538" or "136106", nil, nil, 0, nil, nil, self.Options.DontPlayPTCountdown and 0 or 1, threshold, nil, nil, nil, nil, nil, nil, "break")
		end
		--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not self.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_BREAK)
			dummyMod2.timer:Stop()
		end
		dummyMod2.text:Cancel()
		self.Options.RestoreSettingBreakTimer = nil
		self:Unschedule(resetBreakTimer)
		if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
		self.Options.RestoreSettingBreakTimer = timer .. "/" .. time()
		if not self.Options.DontShowPT2 then
			dummyMod2.timer:Start(timer)
		end
		if not self.Options.DontShowPTText then
			---@type number, string|number
			local hour, minute = GetGameTime()
			minute = minute + (timer / 60)
			if minute >= 60 then
				hour = hour + 1
				minute = minute - 60
			end
			minute = floor(minute)
			if minute < 10 then
				minute = tostring(0 .. minute)
			end
			dummyMod2.text:Show(L.BREAK_START:format(stringUtils.strFromTime(timer) .. " (" .. hour .. ":" .. minute .. ")", sender))
			if timer / 60 > 10 then dummyMod2.text:Schedule(timer - 10 * 60, L.BREAK_MIN:format(10)) end
			if timer / 60 > 5 then dummyMod2.text:Schedule(timer - 5 * 60, L.BREAK_MIN:format(5)) end
			if timer / 60 > 2 then dummyMod2.text:Schedule(timer - 2 * 60, L.BREAK_MIN:format(2)) end
			if timer / 60 > 1 then dummyMod2.text:Schedule(timer - 1 * 60, L.BREAK_MIN:format(1)) end
			dummyMod2.text:Schedule(timer, L.ANNOUNCE_BREAK_OVER:format(hour .. ":" .. minute))
		end
		self:Schedule(timer, resetBreakTimer, self)
	end
	private.breakTimerStart = breakTimerStart
end

---@param timer number --time in minutes
function DBM:CreateBreakTimer(timer)
	if private.IsEncounterInProgress() then
		return self:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if self:MidRestrictionsActive() then
		return self:AddMsg(L.NO_COMMS)
	end
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (self:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return self:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if timer > 60 then
		return self:AddMsg(L.BREAK_USAGE)
	end
	timer = timer * 60
	--Make sure 1 minute break timer is sent as a break timer and not a pull timer
	--if timer == 60 then
	--	timer = 61
	--end
	--if not private.isWrath then
	--	--Send blizzard countdown timer that all users see (including modless)
	--	C_PartyInfo.DoCountdown(timer)
	--	DBM:Debug("Sending Blizzard Countdown Timer")
	--else
	private.sendSync(private.DBMSyncProtocol, "BT", timer, "ALERT")
	self:Debug("Sending DBM Break Timer")
	--end
end

---@param timer number --time in seconds
function DBM:CreatePullTimer(timer)
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (self:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return self:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if (InCombatLockdown() and private.isRetail) or private.IsEncounterInProgress() then
		return self:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if timer > 0 and timer < 3 then
		return self:AddMsg(L.PULL_TIME_TOO_SHORT)
	end
	--if timer > 60 then
	--	return DBM:AddMsg(L.PULL_TIME_TOO_LONG)
	--end
	--Send blizzard countdown timer that all users see (including modless)
	C_PartyInfo.DoCountdown(timer)
	self:Debug("Sending Blizzard Countdown Timer")
end

-------------------
--  Pizza Timer  --
-------------------
do

	local activeLoopTimerText = nil -- normalized text of the currently running looping pizza timer

	local function loopTimer(time, text, broadcast, sender)
		DBM:CreatePizzaTimer(time, text, broadcast, sender, true)
	end

	---Applies the same normalization used when creating pizza timer bars:
	---truncates to 16 chars and replaces %t with the current target name.
	---@param text string
	---@return string
	local function normalizeTimerText(text)
		text = text:sub(1, 16)
		--No UnitName in instances at all in midnight
		if not (DBM:IsPostMidnight() and IsInInstance()) then
			text = text:gsub("%%t", UnitName("target") or "<no target>")
		end
		return text
	end

	local ignore = {}
	---Standard Pizza Timer
	---@param time number --time in seconds
	---@param text string --timer text
	---@param broadcast boolean? --if it should be broadcast to the raid
	---@param sender any --who sent it (if it was started by sync)
	---@param loop boolean? --if the timer should loop indefinitely
	---@param terminate boolean? --if this is true, terminates the timer
	---@param whisperTarget any
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, loop, terminate, whisperTarget)
		if terminate or time == 0 then
			self:Unschedule(loopTimer)
			-- Cancel the tracked looping timer (handles endloop/auto-terminate with empty text)
			local prevLoopText = activeLoopTimerText
			if prevLoopText then
				DBT:CancelBar(prevLoopText)
				activeLoopTimerText = nil
			end
			-- Also cancel using the normalized version of the provided text (handles non-loop cancels)
			if text ~= "" then
				local cancelText = normalizeTimerText(text)
				-- Avoid double-canceling if the provided text refers to the same bar as the tracked loop timer
				if cancelText ~= prevLoopText then
					DBT:CancelBar(cancelText)
				end
			end
			self:FireEvent("DBM_TimerStop", "DBMPizzaTimer")
			-- Fire cancelation of pizza timer
			if broadcast and not IsTrialAccount() and not self:MidRestrictionsActive() then
				text = normalizeTimerText(text)
				if whisperTarget then
					private.sendWhisperSync(private.DBMSyncProtocol, "UW", ("0\t%s"):format(text), whisperTarget, "ALERT", true)
				else
					private.sendSync(private.DBMSyncProtocol, "U", ("0\t%s"):format(text), "ALERT", true)
				end
			end
			return
		end
		if sender and ignore[sender] then return end
		text = normalizeTimerText(text)
		if time < 3 then
			self:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		DBT:CreateBar(time, text, private.isRetail and 237538 or 134376)
		DBM:FireEvent("DBM_TimerBegin", "DBMPizzaTimer", text, time, private.isRetail and "237538" or "134376", "pizzatimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
		if broadcast then
			if whisperTarget then
				--no dbm function uses whisper for pizza timers
				--this allows weak aura creators or other modders to use the pizza timer object unicast via whisper instead of spamming group sync channels
				private.sendWhisperSync(private.DBMSyncProtocol, "UW", ("%s\t%s"):format(time, text), whisperTarget, "ALERT", true)
			else
				private.sendSync(private.DBMSyncProtocol, "U", ("%s\t%s"):format(time, text), "ALERT", true)
			end
		end
		if sender then self:ShowPizzaInfo(text, sender) end
		if loop then
			activeLoopTimerText = text -- text was normalized by normalizeTimerText above
			self:Unschedule(loopTimer)--Only one loop timer supported at once doing this, but much cleaner this way
			self:Schedule(time, loopTimer, time, text, broadcast, sender)
		end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	if self.Options.ShowPizzaMessage then
		self:AddMsg(L.PIZZA_SYNC_INFO:format(sender, id))
	end
end
