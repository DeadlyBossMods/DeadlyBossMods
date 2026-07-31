---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local stringUtils = private:GetPrototype("StringUtils")
local tableUtils = private:GetPrototype("TableUtils")
local difficulties = private:GetPrototype("Difficulties")
local test = private:GetPrototype("DBMTest")
local checkEntry, removeEntry = tableUtils.checkEntry, tableUtils.removeEntry

---@class CombatDetection: DBMModule
local module = private:NewModule("CombatDetection")

local inCombat = {} ---@type DBMMod[]
local combatInfo = {} ---@type table<integer, CombatInfo[]>
local bossIds, autoRespondSpam, bossHealth, bossHealthuIdCache = {}, {}, {}, {}
private.combatDetectionState = {
	inCombat = inCombat,
	combatInfo = combatInfo,
	bossIds = bossIds,
	autoRespondSpam = autoRespondSpam,
	bossHealth = bossHealth,
	bossHealthuIdCache = bossHealthuIdCache,
}

local lastCombatStarted = GetTime()
local lastValidCombat = 0
local combatInitialized, healthCombatInitialized = false, false
local watchFrameRestore, questieWatchRestore, bossuIdFound = false, false, false
local delayedFunction

local playerName = UnitName("player")
local normalizedPlayerRealm = GetRealmName():gsub("[%s-]+", "")
local tinsert, twipe = table.insert, table.wipe
local pairs, ipairs, type, select = pairs, ipairs, type, select
local GetTime = GetTime
local mhuge, mmin, mmax = math.huge, math.min, math.max
local UnitGUID, UnitHealth, UnitHealthMax = UnitGUID, UnitHealth, UnitHealthMax
local UnitAffectingCombat, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit
local IsInRaid, IsInGroup, IsInInstance = IsInRaid, IsInGroup, IsInInstance
local InCombatLockdown = InCombatLockdown
local GetNumGroupMembers = GetNumGroupMembers
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local C_TimerAfter = C_Timer.After

local checkWipe, checkBossHealth, checkCustomBossHealth

function module:RegisterCoreEvents()
	DBM:RegisterSafeEvents("PLAYER_REGEN_DISABLED", "ENCOUNTER_START", "ENCOUNTER_END", "BOSS_KILL")
	if private.isRetail then
		DBM:RegisterSafeEvents("SCENARIO_COMPLETED", "UNIT_HEALTH mouseover target focus player")
	elseif private.isClassic or private.isMop then
		DBM:RegisterEvents("UNIT_HEALTH_FREQUENT mouseover target player targettarget")
	else
		DBM:RegisterEvents("UNIT_HEALTH_FREQUENT mouseover target focus player targettarget")
	end
	if not DBM:IsPostMidnight() then
		DBM:RegisterEvents("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	end
end

function module:StartInitializationTimers()
	C_TimerAfter(1.5, function()
		combatInitialized = true
	end)
	C_TimerAfter(20, function()--Delay UNIT_HEALTH combat start for 20 sec. (not to break Timer Recovery stuff)
		healthCombatInitialized = true
	end)
end

function module:SetPlayerName(name)
	playerName = name
end

function module:ClearSpamTimers(time)
	lastCombatStarted = time
	lastValidCombat = time
end

function DBM:SCENARIO_COMPLETED()
	if #inCombat > 0 and (C_Scenario.IsInScenario() or test.Mocks and test.Mocks.IsInScenario()) then
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if v.inScenario then
				self:EndCombat(v, nil, nil, "SCENARIO_COMPLETED")
			end
		end
	end
end


--Scenario mods
function DBM:ScenarioCheck(delay)
	if self:IsEnabled() and combatInfo[self:GetCurrentArea()] then
		for _, v in ipairs(combatInfo[self:GetCurrentArea()]) do
			if (v.type == "scenario") and checkEntry(v.msgs, self:GetCurrentArea()) then
				self:StartCombat(v.mod, delay or 0, "LOADING_SCREEN_DISABLED")
			end
		end
	end
end


----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		--Iterate over all raid/party members and their targets
		local uId = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local id = (i == 0 and "target") or uId .. i .. "target"
			if not DBM:issecretunit(id) then
				local guid = UnitGUID(id)
				if guid and DBM:IsCreatureGUID(guid) then
					targetList[DBM:GetCIDFromGUID(guid)] = id
				end
			end
		end
		--Iterate over active nameplates
		for _, frame in pairs(C_NamePlate.GetNamePlates()) do
			local foundUnit = frame.namePlateUnitToken
			--Not sure if found unit itself returns secret or not, so double check for now before passing to secret unit
			if foundUnit and not DBM:issecretvalue(foundUnit) and not DBM:issecretunit(foundUnit) then
				if UnitAffectingCombat(foundUnit) then
					local guid = UnitGUID(foundUnit)
					if guid and DBM:IsCreatureGUID(guid) then
						targetList[DBM:GetCIDFromGUID(guid)] = foundUnit
					end
				end
			end
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	---@param mod DBMMod
	---@param mob number Mob CreatureId
	---@param delay number
	local function scanForCombat(mod, mob, delay)
		if not checkEntry(inCombat, mob) then
			buildTargetList()
			if targetList[mob] then
				if mod.noFriendlyEngagement and UnitIsFriend("player", targetList[mob]) then return end
				if delay > 0 and UnitAffectingCombat(targetList[mob]) and not (UnitPlayerOrPetInRaid(targetList[mob]) or UnitPlayerOrPetInParty(targetList[mob])) then
					DBM:StartCombat(mod, delay, "PLAYER_REGEN_DISABLED")
				elseif (delay == 0) then
					DBM:StartCombat(mod, 0, "PLAYER_REGEN_DISABLED_AND_MESSAGE")
				end
			end
			clearTargetList()
		end
	end

	---@param mob number Mob CreatureId
	---@param combatInfo CombatInfo
	local function checkForPull(mob, combatInfo)
		healthCombatInitialized = false
		--This just can't be avoided, trying to save cpu by using C_TimerAfter broke this
		--This needs the redundancy and ability to pass args.
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5)
		if not private.isRetail then
			DBM:Schedule(1.25, scanForCombat, combatInfo.mod, mob, 1.25)
		end
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2)
		C_TimerAfter(2.1, function()
			healthCombatInitialized = true
		end)
	end

	function DBM:PLAYER_REGEN_DISABLED()
		lastCombatStarted = GetTime()
		local optionsFrame = _G["DBM_GUI_OptionsFrame"]
		if optionsFrame and optionsFrame:IsShown() then
			optionsFrame:Hide()
		end
		if not combatInitialized then return end
		-- detects a boss pull based on combat state, this is required for legacy or outdoor bosses that do not fire ENCOUNTER_START event on engage
		if self:IsEnabled() and combatInfo[self:GetCurrentArea()] then
			if not private.isRetail or not IsInInstance() then
				for _, v in ipairs(combatInfo[self:GetCurrentArea()]) do
					if v.type:find("combat") and not v.noRegenDetection and not (#inCombat > 0 and v.noMultiBoss) then
						if v.multiMobPullDetection then
							for _, mob in ipairs(v.multiMobPullDetection) do
								if checkForPull(mob, v) then
									break
								end
							end
						else
							checkForPull(v.mob, v)
						end
					end
				end
			end
		end
		--Prio the afk warning if afk
		if not private.isRetail and (self.Options.AFKHealthWarning2 and not private.IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(3, "AFK")) then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			local path = 566558--Nightelf Bell
			if not private.voiceSessionDisabled and not self:IsNoneValue(voice) then
				path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
			end
			self:PlaySoundFile(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		elseif self.Options.EnteringCombatAlert and not private.IsEncounterInProgress() and self:AntiSpam(10, "COMBAT") then
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			if not private.voiceSessionDisabled and not self:IsNoneValue(voice) and private.swFilterDisabled >= 17 then
				self:PlaySoundFile("Interface\\AddOns\\DBM-VP" .. voice .. "\\enteringcombat.ogg")
				self:AddMsg(L.ENTERING_COMBAT)--Shown with no sound cause voice played
			else
				self:AddMsg(L.ENTERING_COMBAT, nil, true)--Played using generic sound
			end
		end
	end

	function module.PLAYER_REGEN_ENABLED()
		local self = DBM
		if delayedFunction then--Will throw error if not a function, purposely not doing and type(delayedFunction) == "function" for now to make sure code works though because it always should be function
			delayedFunction()
			delayedFunction = nil
		end
		if watchFrameRestore then
			if private.isRetail or private.isCata or private.isMop then
				ObjectiveTracker_Expand()
			elseif private.isWrath then
				WatchFrame:Show()
			else -- Classic Era / BCC
				QuestWatchFrame:Show()
			end
			watchFrameRestore = false
		end
		local QuestieLoader = _G["QuestieLoader"]
		if QuestieLoader then
			local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
			if QuestieTracker and questieWatchRestore and QuestieTracker.Enable then
				QuestieTracker:Enable()
				questieWatchRestore = false
			end
		end
		if self.Options.LeavingCombatAlert and not private.IsEncounterInProgress() and self:AntiSpam(10, "LEAVINGCOMBAT") then
			local voice = DBM.Options.ChosenVoicePack2
			if not private.voiceSessionDisabled and not self:IsNoneValue(voice) and private.swFilterDisabled >= 17 then
				self:PlaySoundFile("Interface\\AddOns\\DBM-VP" .. voice .. "\\leavingcombat.ogg")
				self:AddMsg(L.LEAVING_COMBAT)--Shown with no sound cause voice played
			else
				self:AddMsg(L.LEAVING_COMBAT, nil, true)--Played using generic sound
			end
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		local i = 1
		repeat
			local bossUnitId = "boss" .. i
			local bossGUID = not UnitIsDead(bossUnitId) and UnitGUID(bossUnitId) -- check for UnitIsVisible maybe?
			local bossCId = bossGUID and DBM:GetCIDFromGUID(bossGUID)
			if bossCId and (type(cId) == "number" and cId == bossCId or type(cId) == "table" and checkEntry(cId, bossCId)) then
				return true
			end
			i = i + 1
		until not bossGUID
	end

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if not private.isTimerRequestInProgress() then--do not start ieeu combat if timer request is progressing. (not to break Timer Recovery stuff)
			if self:IsEnabled() and combatInfo[self:GetCurrentArea()] then
				for _, v in ipairs(combatInfo[self:GetCurrentArea()]) do
					if not v.noIEEUDetection and not (#inCombat > 0 and v.noMultiBoss) then
						if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
							self:StartCombat(v.mod, 0, "IEEU")
						end
					end
				end
			end
		end
	end

	function DBM:ENCOUNTER_START(encounterID, name, difficulty, size)
		private:StartDebugLogFight()
		self:Debug("|cffff8800ENCOUNTER_START: |r event fired: " .. encounterID .. " " .. name .. " " .. difficulty .. " " .. size, 1, nil, nil, true)
		if self:IsEnabled() then
			--Only nag in raids on engage
			if IsInRaid() then
				self:CheckAvailableMods()
			end
			if self.BattleRezTimer then
				self.BattleRezTimer:CheckSupported()
			end
			if combatInfo[self:GetCurrentArea()] then
				for _, v in ipairs(combatInfo[self:GetCurrentArea()]) do
					if not v.noESDetection and not (#inCombat > 0 and v.noMultiBoss) then
						if v.multiEncounterPullDetection then
							for _, eId in ipairs(v.multiEncounterPullDetection) do
								if encounterID == eId then
									self:StartCombat(v.mod, 0, "ENCOUNTER_START")
									return
								end
							end
						elseif encounterID == v.eId then
							self:StartCombat(v.mod, 0, "ENCOUNTER_START")
							return
						end
					end
				end
			end
		end
	end

	---@param mod DBMMod
	---@param encounterUnitStatus table?
	---@return number?
	local function getEncounterWipeHealth(mod, encounterUnitStatus)
		local function roundToHundredth(value)
			return math.floor(value * 10000 + 0.5) / 100
		end
		if type(encounterUnitStatus) ~= "table" then
			return nil
		end
		if mod.mainBoss then
			for i = 1, #encounterUnitStatus do
				local unitInfo = encounterUnitStatus[i]
				if type(unitInfo) == "table" and unitInfo.creatureID == mod.mainBoss and type(unitInfo.remainingHealthPercent) == "number" then
					return roundToHundredth(unitInfo.remainingHealthPercent)
				end
			end
		end
		if mod.onlyHighest then
			local highest
			for i = 1, #encounterUnitStatus do
				local unitInfo = encounterUnitStatus[i]
				if type(unitInfo) == "table" and type(unitInfo.remainingHealthPercent) == "number" then
					highest = highest and mmax(highest, unitInfo.remainingHealthPercent) or unitInfo.remainingHealthPercent
				end
			end
			if highest then
				return roundToHundredth(highest)
			end
		end
		for i = 1, #encounterUnitStatus do
			local unitInfo = encounterUnitStatus[i]
			if type(unitInfo) == "table" and type(unitInfo.remainingHealthPercent) == "number" then
				return roundToHundredth(unitInfo.remainingHealthPercent)
			end
		end
		return nil
	end

	function DBM:ENCOUNTER_END(encounterID, name, difficulty, size, success, encounterUnitStatus)
		self:Debug("|cffff8800ENCOUNTER_END: |r event fired: " .. encounterID .. " " .. name .. " " .. difficulty .. " " .. size .. " " .. success, 1, nil, nil, true)
		private:EndDebugLogFight()
		if success == 0 then
			--Only nag on wipes (in any content)
			self:CheckAvailableMods()
		end
		if self.BattleRezTimer then
			self.BattleRezTimer:CheckSupported()
		end
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noEEDetection then return end
			if not self:IsPostMidnight() and v.respawnTime and success == 0 then--No special hacks needed for bad wrath ENCOUNTER_END. Only mods that define respawnTime have a timer, since variable per boss.
				local timerEnabled = self.Options.ShowRespawn and not self.Options.DontShowEventTimers
				name = string.split(",", name)
				if timerEnabled then
					DBT:CreateBar(v.respawnTime, L.TIMER_RESPAWN:format(name), private.isRetail and 237538 or 136106)--Interface\\Icons\\Spell_Holy_BorrowedTime, Spell_nature_timestop
				end
				self:FireEvent("DBM_TimerBegin", "DBMRespawnTimer", L.TIMER_RESPAWN:format(name), v.respawnTime, private.isRetail and "237538" or "136106", "extratimer", nil, 0, v.id, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
			end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, success == 0, nil, "ENCOUNTER_END", getEncounterWipeHealth(v, encounterUnitStatus))
						if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
							private.sendSync(private.DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
						end
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, success == 0, nil, "ENCOUNTER_END", getEncounterWipeHealth(v, encounterUnitStatus))
				if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
					private.sendSync(private.DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
				end
				return
			end
		end
	end

	function DBM:BOSS_KILL(encounterID, name)
		self:Debug("|cffffff00BOSS_KILL: |r event fired: " .. encounterID .. " " .. name, 1, nil, nil, true, true)
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noBKDetection then return end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, nil, nil, "BOSS_KILL")
						if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
							private.sendSync(private.DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
						end
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, nil, nil, "BOSS_KILL")
				if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
					private.sendSync(private.DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
				end
				return
			end
		end
	end

	local function checkExpressionList(exp, str)
		for _, v in ipairs(exp) do
			if str:match(v) then
				return true
			end
		end
		return false
	end

	---called for all mob chat events
	---@param type string
	---@param msg string
	function module.OnMonsterMessage(type, msg)
		local self = DBM
		-- pull detection
		if DBM:IsEnabled() and combatInfo[DBM:GetCurrentArea()] then
			for _, v in ipairs(combatInfo[DBM:GetCurrentArea()]) do
				if v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) and not (#inCombat > 0 and v.noMultiBoss) then
					self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif v.type == "combat_" .. type .. "find" and tContains(v.msgs, msg) or v.type == "combat_" .. type and checkEntry(v.msgs, msg) and not (#inCombat > 0 and v.noMultiBoss) then
					if IsInInstance() then--Indoor boss that uses both combat and message for combat, so in other words (such as hodir), don't require "target" of boss for yell like scanForCombat does for World Bosses
						self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
					else--World Boss
						scanForCombat(v.mod, v.mob, 0)
						if v.mod.readyCheckQuestId and (self.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) and v.mod.readyCheckMaxLevel >= private.playerLevel then
							self:FlashClientIcon()
							self:PlaySoundFile(567478, true)
						end
					end
				end
			end
		end
		-- kill detection (wipe detection would also be nice to have)
		-- todo: add sync
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.combatInfo.killType == type and v.combatInfo.killMsgs[msg] then
				self:EndCombat(v, nil, nil, "onMonsterMessage")
			end
		end
	end

	function DBM:PLAYER_REGEN_ENABLED()
		module.PLAYER_REGEN_ENABLED()
		private.onZonePlayerRegenEnabled(self)
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
		if self:issecretvalue(msg) then
			if target then
				self:Debug("|cffff0000CHAT_MSG_MONSTER_YELL: |r fired: '" .. msg .. "' with sender of " .. npc .. " while looking at " .. target, 3, nil, nil, true, true)
			else
				self:Debug("|cffff0000CHAT_MSG_MONSTER_YELL: |r fired: '" .. msg .. "' with sender of " .. npc, 3, nil, nil, true, true)
			end
			return
		end
		if private.IsEncounterInProgress() or (IsInInstance() and InCombatLockdown()) then--Too many 5 mans/old raids don't properly return encounterinprogress
			local targetName = target or "nil"
			if targetName ~= "nil" then
				local playerClass = self:GetRaidClass(targetName)
				if playerClass then
					local playerColor = RAID_CLASS_COLORS[playerClass]
					if playerColor then
						targetName = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, targetName, 0.41 * 255, 0.8 * 255, 0.94 * 255)
					end
				end
			end
			self:Debug("|cffff0000CHAT_MSG_MONSTER_YELL: |r from " .. npc .. " while looking at " .. targetName, 3, nil, nil, true, true)
		end
		if private.isClassic and not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.hordeOny) then
				private.SendWorldSync(self, 4, "WBA", "Onyxia\tHorde\t22888\t15\t4")
			elseif msg:find(L.WORLD_BUFFS.allianceOny) then
				private.SendWorldSync(self, 4, "WBA", "Onyxia\tAlliance\t22888\t15\t4")
			elseif msg:find(L.WORLD_BUFFS.hordeNef) then
				private.SendWorldSync(self, 4, "WBA", "Nefarian\tHorde\t22888\t16\t4")
			elseif msg:find(L.WORLD_BUFFS.allianceNef) then
				private.SendWorldSync(self, 4, "WBA", "Nefarian\tAlliance\t22888\t16\t4")
			elseif msg:find(L.WORLD_BUFFS.rendHead) then
				private.SendWorldSync(self, 4, "WBA", "rendBlackhand\tHorde\t16609\t7\t4")
			elseif msg:find(L.WORLD_BUFFS.zgHeartYojamba) then
				-- zg buff transcripts https://gist.github.com/venuatu/18174f0e98759f83b9834574371b8d20
				-- 28.58, 28.67, 27.77, 29.39, 28.67, 29.03, 28.12, 28.19, 29.61
				private.SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t28\t4")
			elseif msg:find(L.WORLD_BUFFS.zgHeartBooty) then
				-- 48.7, 49.76, 50.64, 49.42, 49.8, 50.67, 50.94, 51.06
				private.SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t49\t4")
			elseif msg:find(L.WORLD_BUFFS.blackfathomBoon) then
				--private.SendWorldSync(self, 4, "WBA", "Blackfathom\tBoth\t430947\t6\t4")
			end
		end
		return module.OnMonsterMessage("yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		if self:issecretvalue(msg) then
			self:Debug("|cffffa500CHAT_MSG_MONSTER_EMOTE: |r fired: " .. msg, 3, nil, nil, true, true)
			return
		end
		return module.OnMonsterMessage("emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, sender, ...)
		if self:issecretvalue(msg) then
			--Still send the debug to debuglog
			self:Debug("|cffffff00CHAT_MSG_RAID_BOSS_EMOTE: |r fired: " .. msg .. " with sender of " .. sender, 3, nil, nil, true, true)
			return
		end
		module.OnMonsterMessage("emote", msg)
		local id = msg:match("|Hspell:([^|]+)|h")
		if id then
			local spellId = tonumber(id)
			if spellId then
				local spellName = self:GetSpellName(spellId) or CL.UNKNOWN
				self:Debug("|cffffff00CHAT_MSG_RAID_BOSS_EMOTE: |r fired: " .. sender .. "'s " .. spellName .. "(" .. spellId .. ")", 3, nil, nil, true, true)
			end
		end
		return self:FilterRaidBossEmote(msg, sender, ...)
	end

	function DBM:RAID_BOSS_EMOTE(msg, ...)--This is a mirror of above prototype only it has less args, both still exist for some reason.
		if self:issecretvalue(msg) then
			return
		end
		module.OnMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:RAID_BOSS_WHISPER(msg)
		if self:issecretvalue(msg) then
			self:Debug("RAID_BOSS_WHISPER fired: " .. msg, 2, nil, nil, true, true)
			return
		end
		--Make it easier for devs to detect whispers they are unable to see
		--TINTERFACE\\ICONS\\ability_socererking_arcanewrath.blp:20|t You have been branded by |cFFF00000|Hspell:156238|h[Arcane Wrath]|h|r!"
		if msg and msg ~= "" and #msg < 255 and IsInGroup() and not _G["BigWigs"] and not IsTrialAccount() then
			ChatThrottleLib:SendAddonMessage("ALERT", "Transcriptor", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")--Alert prio used since time accuracy is paramount for accurate logging
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		if self:issecretvalue(msg) then
			self:Debug("CHAT_MSG_MONSTER_SAY fired: " .. msg, 3, nil, nil, true, true)
			return
		end
		if private.isClassic and not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.zgHeart) then
				-- 51.01 51.82 51.85 51.53
				private.SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t51\t4")
			end
		end
		return module.OnMonsterMessage("say", msg)
	end

end

do
	local autoLog = false
	local autoTLog = false

	function DBM:StartLogging(timer, checkFunc, force)
		self:Unschedule(DBM.StopLogging)
		if self:IsLogableContent(force) then
			if self.Options.AutologBosses then
				if not LoggingCombat() then
					autoLog = true
					self:AddMsg("|cffffff00" .. COMBATLOGENABLED .. "|r")
					LoggingCombat(true)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if self.Options.AdvancedAutologBosses and transcriptor then
				if not transcriptor:IsLogging() then
					autoTLog = true
					self:AddMsg("|cffffff00" .. L.TRANSCRIPTOR_LOG_START .. "|r")
					transcriptor:StartLog(1)
				end
			end
			if checkFunc and (autoLog or autoTLog) then
				self:Unschedule(checkFunc)
				self:Schedule(timer + 10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
			end
		end
	end

	function DBM:StopLogging()
		if self.Options.AutologBosses and LoggingCombat() and autoLog then
			autoLog = false
			self:AddMsg("|cffffff00" .. COMBATLOGDISABLED .. "|r")
			LoggingCombat(false)
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor and autoTLog then
			if transcriptor:IsLogging() then
				autoTLog = false
				self:AddMsg("|cffffff00" .. L.TRANSCRIPTOR_LOG_END .. "|r")
				transcriptor:StopLog(1)
			end
		end
	end
end

---------------------------
--  Kill/Wipe Detection  --
---------------------------

do
	---@param self DBM
	---@param confirm boolean?
	---@param confirmTime number?
	function checkWipe(self, confirm, confirmTime)
		if #inCombat > 0 then
			difficulties:RefreshCache()
			--hack for no iEEU information is provided.
			if not bossuIdFound then
				for i = 1, 10 do
					if UnitExists("boss" .. i) then
						bossuIdFound = true
						break
					end
				end
			end
			local wipe -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
			if (private.isRetail and IsInScenarioGroup()) or (difficulties.difficultyIndex == 11) or (difficulties.difficultyIndex == 12) or (difficulties.difficultyIndex == 208) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
				wipe = 0
			elseif private.IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
				wipe = 0
			elseif difficulties.savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
				wipe = 0
			elseif bossuIdFound and private.LastInstanceType == "raid" then -- Combat started by IEEU and no boss exist and no EncounterProgress marked, that means wipe
				wipe = 2
				for i = 1, 10 do
					if UnitExists("boss" .. i) then
						wipe = 0 -- Boss found. No wipe
						break
					end
				end
			else -- Unit combat status detection. No combat unit in your party and no EncounterProgress marked, that means wipe
				wipe = 1
				local uId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "player") or uId .. i
					if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
						wipe = 0 -- Someone still in combat. No wipe
						break
					end
				end
			end
			if wipe == 0 then
				lastValidCombat = GetTime()--Time stamp last valid in combat
				self:Schedule(3, checkWipe, self)
			elseif confirm then
				local timeSinceValid = GetTime() - lastValidCombat
				if timeSinceValid > confirmTime then
					for i = #inCombat, 1, -1 do
						local mod = inCombat[i]
						if not mod.noStatistics then
							self:Debug("You wiped. Reason : " .. (wipe == 1 and "No combat unit found in your party." or "No boss found : " .. (wipe or "nil")))
						end
						self:EndCombat(mod, true, nil, "checkWipe")
					end
				else--Have not reached required out of combat time yet, check again every 3 seconds until we do
					self:Schedule(3, checkWipe, self, true, confirmTime)
				end
			else
				local maxDelayTime = (difficulties.savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
				for _, v in ipairs(inCombat) do
					maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
				end
				self:Schedule(3, checkWipe, self, true, maxDelayTime)
			end
		end
	end

	---@param self DBM
	---@param mod DBMMod
	function checkBossHealth(self, mod)
		if #inCombat > 0 then
			for _, v in ipairs(inCombat) do
				if not v.multiMobPullDetection or v.mainBoss then
					self:GetBossHP(v.mainBoss or v.combatInfo.mob or -1, mod.onlyHighest)
				else
					for _, mob in ipairs(v.multiMobPullDetection) do
						self:GetBossHP(mob, mod.onlyHighest)
					end
				end
			end
			self:Schedule(mod.bossHealthUpdateTime or 1, checkBossHealth, self, mod)
		end
	end

	---@param self DBM
	---@param mod DBMMod
	function checkCustomBossHealth(self, mod)
		mod:CustomHealthUpdate()
		self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
	end

	---Delayed Guild Combat sync object so we allow time for RL to disable them
	local function delayedGCSync(modId, difficultyIndex, difficultyModifier, name, thisTime, isWipe, wipeHP)
		if not DBM:IsEnabled() then return end
		if not private.statusGuildDisabled and private.updateNotificationDisplayed == 0 then
			if thisTime then--End combat event
				if isWipe then
					if wipeHP then
						private.sendGuildSync(11, "GCE", modId .. "\t1\t" .. thisTime .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. private.lastGroupLeader .. "\t" .. wipeHP)
					else
						private.sendGuildSync(11, "GCE", modId .. "\t1\t" .. thisTime .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. private.lastGroupLeader)
					end
				else
					private.sendGuildSync(11, "GCE", modId .. "\t0\t" .. thisTime .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. private.lastGroupLeader)
				end
			else
				private.sendGuildSync(4, "GCB", modId .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. private.lastGroupLeader)
			end
		end
	end

	---@param mod DBMMod
	---@param delay number
	---@param event string?
	---@param synced boolean?
	---@param syncedStartHp number?
	---@param syncedEvent string?
	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp, syncedEvent)
		---@class DBMMod
		mod = mod
		if not checkEntry(inCombat, mod) then
			if DBM.TaintedByTests then
				self:AddMsg(L.DBM_TAINTED_BY_TESTS) -- Shows this early in case tests messed with some filters below
			end
			if not mod.Options.Enabled then return end
			if not mod.combatInfo then return end
			if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
				return
			end
			--Hack to disable modules from activating in timewalking difficulty that have duplicate non timewalking difficulty mods
			--ie Cookie
			if mod.combatInfo.DisableInTimewalking and difficulties.savedDifficulty == 24 then
				return
			end
			if mod.combatInfo.RequiresTimewalking and difficulties.savedDifficulty ~= 24 then
				return
			end
			--HACK: makes sure that we don't detect a false pull if the event fires again when the boss dies...
			if mod.lastKillTime and GetTime() - mod.lastKillTime < (mod.reCombatTime or 120) and event ~= "LOADING_SCREEN_DISABLED" then return end
			if mod.lastWipeTime and GetTime() - mod.lastWipeTime < (event == "ENCOUNTER_START" and 3 or mod.reCombatTime2 or 20) and event ~= "LOADING_SCREEN_DISABLED" then return end
			if event then
				self:Debug("StartCombat called by : " .. event .. ". DBM:GetCurrentArea() is " .. self:GetCurrentArea(), 1, nil, nil, true, true)
				if event ~= "ENCOUNTER_START" then
					self:Debug("This event is started by " .. event .. ". Review ENCOUNTER_START event to ensure if this is still needed", 2)
				end
			else
				self:Debug("StartCombat called by individual mod or unknown reason. DBM:GetCurrentArea() is " .. self:GetCurrentArea())
				event = ""
			end
			--check completed. starting combat
			test:Trace(mod, "StartCombat", event)
			tinsert(inCombat, mod)
			-- Pull time is always considered as in combat, this makes sure checkWipe() triggers only after the minimum time without combat has passed since start.
			lastValidCombat = GetTime()
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			if mod.inCombatOnlySafeEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterSafeEvents(unpack(mod.inCombatOnlySafeEvents))
			end
			--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
			if not mod.stats and not mod.noStatistics then
				self:AddMsg(L.BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
			elseif event == "TIMER_RECOVERY" then --add a lag time to delay when TIMER_RECOVERY
				delay = delay + select(4, GetNetStats()) / 1000
			end
			--set mod default info
			difficulties:RefreshCache(true)
			local name = mod.combatInfo.name
			local modId = mod.id
			if private.isRetail then
				if mod.addon and mod.addon.type == "SCENARIO" and (C_Scenario.IsInScenario() or test.Mocks and test.Mocks.IsInScenario()) and not mod.soloChallenge then
					mod.inScenario = true
				end
				-- Cache timeline countdown duration once per pull.
				-- nil/unset treated as default 5000. Any value besides 5000/10000 disables custom countdown registration.
				local highlightDuration = tonumber(GetCVar("encounterTimelineHighlightDuration")) or 5000
				mod.tlCountValue = (highlightDuration == 5000 or highlightDuration == 10000) and highlightDuration or nil
			end
			mod.engagedDiff = difficulties.savedDifficulty
			mod.engagedDiffText = difficulties.difficultyText
			mod.engagedDiffIndex = difficulties.difficultyIndex
			mod.engagedDiffModifier = difficulties.difficultyModifier
			mod.inCombat = true
			---@class CombatInfo
			local combatInfo = mod.combatInfo
			combatInfo.pull = GetTime() - (delay or 0)
			bossuIdFound = event == "IEEU"
			if mod.minCombatTime then
				self:Schedule(mmax((mod.minCombatTime - delay), 3), checkWipe, self)
			else
				self:Schedule(3, checkWipe, self)
			end
			--get boss hp at pull
			if not private.isRetail and syncedStartHp and syncedStartHp < 1 then
				syncedStartHp = syncedStartHp * 100
			end
			local startHp = private.isRetail and 90 or syncedStartHp or mod:GetBossHP(mod.mainBoss or mod.combatInfo.mob or -1) or 100
			--check boss engaged first?
			if (difficulties.savedDifficulty == "worldboss" and startHp < 98) or (event == "UNIT_HEALTH" and delay > 4) or event == "TIMER_RECOVERY" then--Boss was not full health when engaged, disable combat start timer and kill record
				mod.ignoreBestkill = true
			elseif mod.inScenario then
				local scenarioType, currentStage, numStages = C_Scenario.GetInfo()
				--Delves start in stage 2 of 3 because stage 1 is "entering" apparently.
				if currentStage > (scenarioType == "Delves" and 2 or 1) and numStages > 1 then
					mod.ignoreBestkill = true
				end
			else--Reset ignoreBestkill after wipe
				mod.ignoreBestkill = false
				--It was a clean pull, so cancel any RequestTimers which might fire after boss was pulled if boss was pulled right after mod load
				--Only want timer recovery on in progress bosses, not clean pulls
				if startHp > 98 and (difficulties.savedDifficulty == "worldboss" or event == "IEEU") or event == "ENCOUNTER_START" then
					self:Unschedule(self.RequestTimers)
				end
			end
			if not mod.inScenario then
				if self.Options.DisableSFX and GetCVar("Sound_EnableSFX") == "1" then
					SetCVar("Sound_EnableSFX", 0)
					self.Options.RestoreSettingSFX = true
				end
				if self.Options.DisableAmbiance and GetCVar("Sound_EnableAmbience") == "1" then
					SetCVar("Sound_EnableAmbience", 0)
					self.Options.RestoreSettingAmbiance = true
				end
				if self.Options.DisableMusic and GetCVar("Sound_EnableMusic") == "1" then
					SetCVar("Sound_EnableMusic", 0)
					self.Options.RestoreSettingMusic = true
				end
				--boss health info scheduler
				if not private.isRetail then
					if mod.CustomHealthUpdate then
						self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
					else
						self:Schedule(mod.bossHealthUpdateTime or 1, checkBossHealth, self, mod)
					end
				end
			end
			--process global options
			self:HideBlizzardEvents(1)
			if self.Options.RecordOnlyBosses then
				self:StartLogging(0)
			end
			local trackedAchievements
			--TODO, is MoP classic still using the old path? will TBC when it launches on aniversary
			if private.isClassic or private.isBCC then
				trackedAchievements = false
			elseif private.isWrath or private.isCata then
				trackedAchievements = (GetNumTrackedAchievements() > 0)
			else
				trackedAchievements = (C_ContentTracking and C_ContentTracking.GetTrackedIDs(2)[1])
			end
			if self.Options.HideObjectivesFrame and mod.addon and mod.addon.type ~= "SCENARIO" and not trackedAchievements and difficulties.difficultyIndex ~= 8 and not InCombatLockdown() then
				if private.isRetail or private.isCata or private.isMop then--Do nothing due to taint and breaking
					--if ObjectiveTrackerFrame:IsVisible() then
					--	ObjectiveTracker_Collapse()
					--	watchFrameRestore = true
					--end
				else
					if WatchFrame then
						if WatchFrame:IsVisible() then
							WatchFrame:Hide()
							watchFrameRestore = true
						end
					elseif QuestWatchFrame:IsVisible() then -- Classic Era / BCC
						QuestWatchFrame:Hide()
						watchFrameRestore = true
					end
					local QuestieLoader = _G["QuestieLoader"]
					if QuestieLoader then
						local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
						local Questie = _G["Questie"] or QuestieLoader:ImportModule("Questie")
						if QuestieTracker and Questie and Questie.db.global.trackerEnabled and QuestieTracker.Disable then
							--Will only hide questie tracker if it's not already hidden.
							QuestieTracker:Disable()
							questieWatchRestore = true
						end
					end
				end
			end
			self:FireEvent("DBM_Pull", mod, delay, synced, startHp)
			self:FlashClientIcon()
			self:UpdateMapRestrictions()
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats and not mod.noStatistics then
					if not mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] then mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] = 0 end
					mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill and not mod.noStatistics then
					local bestTime
					if difficulties.difficultyIndex == 8 or difficulties.difficultyIndex == 208 or difficulties.difficultyIndex == 226 then--Mythic+/Challenge Mode, Delves, and sod Molten Core
						local bestRank = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestRank"] or 0
						if bestRank == difficulties.difficultyModifier then
							--Don't show speed kill timer if not our highest rank. DBM only stores highest rank
							bestTime = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestTime"]
						end
					else
						bestTime = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestTime"]
					end
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, L.SPEED_KILL_TIMER_TEXT, private.isRetail and "237538" or "136106", nil, false)
						speedTimer:Start()
					end
				end
				--update boss left
				if mod.numBoss then
					mod.vb.bossLeft = mod.numBoss
				end
				--Update Elected Icon Setter
				self:ElectIconSetter(mod)
				--call OnCombatStart
				if not self:IsPostMidnight() then
					if mod.OnCombatStart then
						local startEvent = syncedEvent or event
						local nonZeroDelay = delay or 0
						if nonZeroDelay == 0 then
							nonZeroDelay = 0.000001
						end
						mod:OnCombatStart(nonZeroDelay, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
					end
				else
					--call OnLimitedCombatStart (for mods that need to start separate oncombat start rules for retail vs classic due to retail restrictions)
					if mod.OnLimitedCombatStart then
						local startEvent = syncedEvent or event
						local nonZeroDelay = delay or 0
						if nonZeroDelay == 0 then
							nonZeroDelay = 0.000001
						end
						mod:OnLimitedCombatStart(nonZeroDelay, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
					end
					if self.Options.HideBlizzardTimeline then
						--Temporary. Will be removed in a future patch when api for supporting sounds works without forcing this
						C_CVar.SetCVar("encounterTimelineEnabled", "1")
						EncounterTimeline.TrackView:SetAlpha(0)
						EncounterTimeline.TimerView:SetAlpha(0)
					end
				end
				--send "C" sync
				if not synced and not mod.soloChallenge then
					private.sendSync(private.DBMSyncProtocol, "C", (delay or 0) .. "\t" .. modId .. "\t" .. (mod.revision or 0) .. "\t" .. startHp .. "\t" .. tostring(self.Revision) .. "\t" .. (mod.hotfixNoticeRev or 0) .. "\t" .. event, "ALERT")
				end
				if UnitIsGroupLeader("player") then
					--Global disables require normal, heroic, mythic raid on retail, or 10 man normal, 25 man normal, 40 man normal, 10 man heroic, or 25 man heroic on classic
					if difficulties.difficultyIndex == 14 or difficulties.difficultyIndex == 15 or difficulties.difficultyIndex == 16 or difficulties.difficultyIndex == 175 or difficulties.difficultyIndex == 176 or difficulties.difficultyIndex == 186 or difficulties.difficultyIndex == 193 or difficulties.difficultyIndex == 194 then
						local statusWhisper, guildStatus, raidIcons, chatBubbles = self.Options.DisableStatusWhisper and 1 or 0, self.Options.DisableGuildStatus and 1 or 0, self.Options.DisableRaidIcons and 1 or 0, self.Options.DisableChatBubbles and 1 or 0
						if statusWhisper ~= 0 or guildStatus ~= 0 or raidIcons ~= 0 or chatBubbles ~= 0 then
							private.sendSync(2, "RLO", statusWhisper .. "\t" .. guildStatus .. "\t" .. raidIcons .. "\t" .. chatBubbles, "ALERT")
						end
					end
				end
				--Ora3 is deprecated, this should be replaced with DBMs checks when they're added
				--if self.Options.AnnounceConsumables then

				--end
				--show engage message
				if self.Options.ShowEngageMessage and not mod.noStatistics then
					if mod.ignoreBestkill and (difficulties.savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(L.COMBAT_STARTED_IN_PROGRESS:format(difficulties.difficultyText .. name))
					elseif mod.ignoreBestkill and mod.inScenario then
						self:AddMsg(L.SCENARIO_STARTED_IN_PROGRESS:format(difficulties.difficultyText .. name))
					else
						if mod.addon and mod.addon.type == "SCENARIO" then
							self:AddMsg(L.SCENARIO_STARTED:format(difficulties.difficultyText .. name))
						else
							self:AddMsg(L.COMBAT_STARTED:format(difficulties.difficultyText .. name))
							local check = not private.statusGuildDisabled and (private.isRetail and ((difficulties.difficultyIndex == 8 or difficulties.difficultyIndex == 14 or difficulties.difficultyIndex == 15 or difficulties.difficultyIndex == 16) and InGuildParty()) or difficulties.difficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10)
							if check and not self.Options.DisableGuildStatus then--Only send relevant content, not guild beating down lich king or LFR.
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, difficulties.difficultyIndex, difficulties.difficultyModifier, name)
							end
						end
					end
				end
				--stop pull count
				private.pullTimerStop()
				if self.Options.EventSoundEngage2 and self.Options.EventSoundEngage2 ~= "" and not self:IsNoneValue(self.Options.EventSoundEngage2) then
					self:PlaySoundFile(self.Options.EventSoundEngage2, nil, true)
				end
				if not mod.inScenario and self.Options.EventSoundMusic and not self:IsNoneValue(self.Options.EventSoundMusic) and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (difficulties.savedDifficulty == "mythic" or difficulties.savedDifficulty == "challenge")) and not mod.noStatistics and not self.Options.RestoreSettingMusic then
					self:FireEvent("DBM_MusicStart", "BossEncounter")
					if not self.Options.RestoreSettingCustomMusic then
						self.Options.RestoreSettingCustomMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
						if self.Options.RestoreSettingCustomMusic == 0 then
							SetCVar("Sound_EnableMusic", 1)
						else
							self.Options.RestoreSettingCustomMusic = nil--Don't actually need it
						end
					end
					local path = "MISSING"
					if self.Options.EventSoundMusic == "Random" then
						local usedTable = self.Options.EventSoundMusicCombined and self:GetMusic() or self:GetBattleMusic()
						if #usedTable >= 3 then
							local random = fastrandom(3, #usedTable)
							---@diagnostic disable-next-line: cast-local-type
							path = usedTable[random].value
						end
					else
						path = self.Options.EventSoundMusic
					end
					if path ~= "MISSING" then
						PlayMusic(path)
						self.Options.musicPlaying = true
						--self:Debug("Starting combat music with file: " .. path)
					end
				end
			else
				self:AddMsg(L.COMBAT_STATE_RECOVERED:format(difficulties.difficultyText .. name, stringUtils.strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if difficulties.savedDifficulty == "worldboss" and mod.WBEsync then
				if private.lastBossEngage[modId .. normalizedPlayerRealm] and (GetTime() - private.lastBossEngage[modId .. normalizedPlayerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
				private.lastBossEngage[modId .. normalizedPlayerRealm] = GetTime()--Update last engage time, that way we ignore our own sync
				private.SendWorldSync(self, 8, "WBE", modId .. "\t" .. normalizedPlayerRealm .. "\t" .. startHp .. "\t" .. name)
			end
		end
	end

	function DBM:UNIT_HEALTH(uId)
		if self:issecretunit(uId) then
			return
		end
		local cId = self:GetUnitCreatureId(uId)
		local health = 10--above 2 less than 97, so the usual classic checks will succeed on retail as always "in progress world boss"
		if not private.isRetail then
			--Health is always secret on enemies, even outdoors
			local currentHealth, maxHealth = UnitHealth(uId), UnitHealthMax(uId)
			if maxHealth ~= 0 then
				health = currentHealth / maxHealth * 100
			end
		end
		if health < 2 then return end -- no worthy of combat start if health is below 2%
		if self:IsEnabled() then
			if cId ~= 0 and not bossHealth[cId] and bossIds[cId] and UnitAffectingCombat(uId) and not (UnitPlayerOrPetInRaid(uId) or UnitPlayerOrPetInParty(uId)) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				if combatInfo[self:GetCurrentArea()] then
					for _, v in ipairs(combatInfo[self:GetCurrentArea()]) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) and not (#inCombat > 0 and v.noMultiBoss) then
							if v.mod.noFriendlyEngagement and UnitIsFriend("player", uId) then return end
							-- Delay set, > 97% = 0.5 (consider as normal pulling), max delay limited to 20s.
							self:StartCombat(v.mod, health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20), "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if private.isRetail then return end
			if UnitIsUnit("player", uId) and health < 100 and not private.IsEncounterInProgress() then
				--PRIO afk alert first (still disabled on retail because UnitIsAFK is restricted in combat)
				if self.Options.AFKHealthWarning2 and (health < (private.isHardcoreServer and 95 or 85)) and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then
					local voice = DBM.Options.ChosenVoicePack2
					local path = 566558--Nightelf Bell
					if not private.voiceSessionDisabled and not self:IsNoneValue(voice) then
						path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
					end
					self:PlaySoundFile(path)
					self:AddMsg(L.AFK_WARNING:format(health))
				--Low health warning
				elseif self.Options.HealthWarningLow and health < 35 and self:AntiSpam(5, "LOWHEALTH") then
					local voice = DBM.Options.ChosenVoicePack2
					local path = 566558--Nightelf Bell
					if not private.voiceSessionDisabled and not self:IsNoneValue(voice) then
						path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
					end
					self:PlaySoundFile(path)
					self:AddMsg(L.LOWHEALTH_WARNING:format(health))
				end
			end
		end
	end
	DBM.UNIT_HEALTH_FREQUENT = DBM.UNIT_HEALTH

	---@param mod DBMMod
	---@param wipe boolean?
	---@param srmIncluded boolean? unregister all events including SPELL_AURA_REMOVED events
	---@param event string?
	---@param wipeHealthPct any Not sure if it's sent as secret or not yet, so allowing any for now
	function DBM:EndCombat(mod, wipe, srmIncluded, event, wipeHealthPct)
		---@class DBMMod
		mod = mod
		if removeEntry(inCombat, mod) then
			test:Trace(mod, "EndCombat", event)
			local scenario = mod.addon and mod.addon.type == "SCENARIO" and not mod.soloChallenge
			if (mod.inCombatOnlyEvents or mod.inCombatOnlySafeEvents) and mod.inCombatOnlyEventsRegistered then
				if srmIncluded then
					mod:UnregisterInCombatEvents(false, true)
				else
					mod:UnregisterInCombatEvents()
					self:Schedule(2, mod.UnregisterInCombatEvents, mod, true) -- 2 seconds should be enough for all auras to fade
				end
				self:Schedule(3, mod.Stop, mod) -- Remove accident started timers.
				mod.inCombatOnlyEventsRegistered = nil
				if mod.OnCombatEnd then
					self:Schedule(3, mod.OnCombatEnd, mod, wipe, true) -- Remove accidentally shown frames
				end
			end
			if mod.updateInterval then
				mod:UnregisterOnUpdateHandler()
			end
			mod:Stop()
			if DBM.InfoFrame and DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Hide()
			end
			if mod.tlTimerEvents then
				mod:DisableTimelineOptions()
			end
			if mod.tlSoundEvents then
				mod:DisableAlertOptions()
			end
			if self.Options.IgnoreBlizzAPI then
				self.Options.IgnoreBlizzAPI = false
				self:FireEvent("DBM_ResumeBlizzAPI")
			end
			self.Options.DisableSWSound = false
			self.Options.fixBlizzApi = false
			if event then
				self:Debug("EndCombat called by : " .. event .. ". DBM:GetCurrentArea() is " .. self:GetCurrentArea(), 2, nil, nil, true)
			end
			if private.enableIcons and not self.Options.DontSetIcons and not self.Options.DontRestoreIcons then
				-- restore saved previous icon
				for uId, icon in pairs(mod.iconRestore) do
					SetRaidTarget(uId, icon)
				end
				twipe(mod.iconRestore)
			end
			mod.inCombat = false
			if mod.combatInfo.killMobs then
				for i, _ in pairs(mod.combatInfo.killMobs) do
					mod.combatInfo.killMobs[i] = true
				end
			end
			difficulties:RefreshCache(true)
			--Fix stupid classic behavior where wipes only happen after release which causes all the instance difficulty info to be wrong
			--This uses stored values from engage first, and only current values as fallback
			local usedDifficulty = mod.engagedDiff or difficulties.savedDifficulty
			local usedDifficultyText = mod.engagedDiffText or difficulties.difficultyText
			local usedDifficultyIndex = mod.engagedDiffIndex or difficulties.difficultyIndex
			local usedDifficultyModifier = mod.engagedDiffModifier or difficulties.difficultyModifier or 0
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats and not mod.noStatistics then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local wipeHP
				if not self:IsPostMidnight() then
					local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
					wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
					if mod.vb.phase then
						wipeHP = wipeHP .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
					end
					if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
						local bossesKilled = mod.numBoss - mod.vb.bossLeft
						wipeHP = wipeHP .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
					end
				else
					wipeHP = wipeHealthPct and tostring(wipeHealthPct) or CL.UNKNOWN
				end
				local totalPulls = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"]
				local totalKills = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime)))
						else
							if self:IsPostMidnight() and self:GetTOC() < 120007 then
								--In 12.0.7, we inherit wipeHP from new blizzard api
								self:AddMsg(L.COMBAT_ENDED:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime)))
							else
								self:AddMsg(L.COMBAT_ENDED_AT:format(usedDifficultyText .. name, wipeHP, stringUtils.strFromTime(thisTime)))
							end
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT_LONG:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
						else
							if self:IsPostMidnight() and self:GetTOC() < 120007 then
								--In 12.0.7, we inherit wipeHP from new blizzard api
								self:AddMsg(L.COMBAT_ENDED_LONG:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
							else
								self:AddMsg(L.COMBAT_ENDED_AT_LONG:format(usedDifficultyText .. name, wipeHP, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
							end
							local check = private.isRetail and
								((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or
								usedDifficultyIndex ~= 1 and self:GetNumGuildPlayersInZone() >= 10 -- Classic
							if check and not self.Options.DisableGuildStatus then
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, difficulties.difficultyModifier, name, stringUtils.strFromTime(thisTime), true, wipeHP)
							end
						end
					end
					if self.Options.EventSoundWipe and not self:IsNoneValue(self.Options.EventSoundWipe) and self.Options.EventSoundWipe ~= "" then
						if self.Options.EventSoundWipe == "Random" then
							local defeatSounds = self:GetDefeatSounds()
							if #defeatSounds >= 3 then
								self:PlaySoundFile(defeatSounds[fastrandom(3, #defeatSounds)].value)
							end
						else
							self:PlaySoundFile(self.Options.EventSoundWipe, nil, true)
						end
					end
				end
				if private.showConstantReminder == 2 and IsInGroup() then
					private.showConstantReminder = 1
					--Show message any time this is a mod that has a newer hotfix revision and it's a wipe
					--These people need to know the wipe could very well be their fault.
					self:AddMsg(L.OUT_OF_DATE_NAG)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or private.chatPrefixShort .. L.WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, usedDifficultyText .. (name or ""), totalPulls - totalKills)
						else
							msg = msg or private.chatPrefixShort .. L.WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, usedDifficultyText .. (name or ""), wipeHP, totalPulls - totalKills)
						end
					else
						if scenario then
							msg = msg or private.chatPrefixShort .. L.WHISPER_SCENARIO_END_WIPE:format(playerName, usedDifficultyText .. (name or ""))
						else
							msg = msg or private.chatPrefixShort .. L.WHISPER_COMBAT_END_WIPE_AT:format(playerName, usedDifficultyText .. (name or ""), wipeHP)
						end
					end
					private.sendWhisper(k, msg)
				end
				self:FireEvent("DBM_Wipe", mod)
			elseif not wipe and mod.stats and not mod.noStatistics then
				mod.lastKillTime = GetTime()
				local thisTime = GetTime() - (mod.combatInfo.pull or 0)
				local lastTime = mod.stats[difficulties.statVarTable[usedDifficulty] .. "LastTime"]
				local bestTime = mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"]
				if not mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] or mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] < 0 then mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] + 1
				if mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] > mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] then mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[difficulties.statVarTable[usedDifficulty] .. "LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = thisTime
					else
						if usedDifficultyIndex == 8 or usedDifficultyIndex == 208 or usedDifficultyIndex == 226 then--Mythic+/Challenge Mode, Delves, and sod Molten Core
							if mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] > usedDifficultyModifier then--Don't save time stats at all
								--DO nothing
							elseif mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] < usedDifficultyModifier then--Update best time and best rank, even if best time is lower (for a lower rank)
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] = usedDifficultyModifier--Update best rank
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = thisTime--Write this time no matter what.
							else--Best rank must match current rank, so update time normally
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
							end
						else
							mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
						end
					end
				end
				local totalKills = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"]
				if self.Options.ShowDefeatMessage then
					local msg
					local thisTimeString = thisTime and stringUtils.strFromTime(thisTime)
					if not mod.combatInfo.pull then--was a bad pull so we ignored thisTime, should never happen
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(usedDifficultyText .. name, CL.UNKNOWN)
						else
							msg = L.BOSS_DOWN:format(usedDifficultyText .. name, CL.UNKNOWN)
						end
					elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
						if scenario then
							msg = L.SCENARIO_COMPLETE_I:format(usedDifficultyText .. name, totalKills)
						else
							msg = L.BOSS_DOWN_I:format(usedDifficultyText .. name, totalKills)
						end
					elseif not lastTime then
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(usedDifficultyText .. name, thisTimeString)
						else
							msg = L.BOSS_DOWN:format(usedDifficultyText .. name, thisTimeString)
						end
					elseif thisTime < (bestTime or mhuge) then
						if scenario then
							msg = L.SCENARIO_COMPLETE_NR:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_NR:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(bestTime), totalKills)
						end
					else
						if scenario then
							msg = L.SCENARIO_COMPLETE_L:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(lastTime), stringUtils.strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_L:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(lastTime), stringUtils.strFromTime(bestTime), totalKills)
						end
					end
					local check = not private.statusGuildDisabled and (private.isRetail and ((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or usedDifficultyIndex ~= 1 and self:GetNumGuildPlayersInZone() >= 10) -- Classic
					if not scenario and thisTimeString and check and not self.Options.DisableGuildStatus and private.updateNotificationDisplayed == 0 then
						self:Unschedule(delayedGCSync, modId)
						self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, usedDifficultyModifier, name, thisTimeString)
					end
					self:Schedule(1, self.AddMsg, self, msg)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or private.chatPrefixShort .. L.WHISPER_SCENARIO_END_KILL_STATS:format(playerName, usedDifficultyText .. (name or ""), totalKills)
						else
							msg = msg or private.chatPrefixShort .. L.WHISPER_COMBAT_END_KILL_STATS:format(playerName, usedDifficultyText .. (name or ""), totalKills)
						end
					else
						if scenario then
							msg = msg or private.chatPrefixShort .. L.WHISPER_SCENARIO_END_KILL:format(playerName, usedDifficultyText .. (name or ""))
						else
							msg = msg or private.chatPrefixShort .. L.WHISPER_COMBAT_END_KILL:format(playerName, usedDifficultyText .. (name or ""))
						end
					end
					private.sendWhisper(k, msg)
				end
				self:FireEvent("DBM_Kill", mod)
				if usedDifficulty == "worldboss" and mod.WBEsync then
					if private.lastBossDefeat[modId .. normalizedPlayerRealm] and (GetTime() - private.lastBossDefeat[modId .. normalizedPlayerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					private.lastBossDefeat[modId .. normalizedPlayerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					private.SendWorldSync(self, 8, "WBD", modId .. "\t" .. normalizedPlayerRealm .. "\t" .. name)
				end
				if self.Options.EventSoundVictory2 and not self:IsNoneValue(self.Options.EventSoundVictory2) and self.Options.EventSoundVictory2 ~= "" and difficulties.difficultyIndex ~= 232 then--No victory in duos
					if self.Options.EventSoundVictory2 == "Random" then
						local victorySounds = self:GetVictorySounds()
						if #victorySounds >= 3 then
							self:PlaySoundFile(victorySounds[fastrandom(3, #victorySounds)].value)
						end
					else
						self:PlaySoundFile(self.Options.EventSoundVictory2, nil, true)
					end
				end
			end
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe or false) end
			if mod.OnLeavingCombat then delayedFunction = mod.OnLeavingCombat end
			mod.engagedDiff = nil
			mod.engagedDiffText = nil
			mod.engagedDiffIndex = nil
			mod.engagedDiffModifier = nil
			mod.vb.stageTotality = nil
			if #inCombat == 0 then--prevent error if you pulled multiple boss. (Earth, Wind and Fire)
				private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false
				if self.Options.RecordOnlyBosses then
					self:Schedule(10, self.StopLogging, self)--small delay to catch kill/died combatlog events
				end
				self:HideBlizzardEvents(0)
				self:Unschedule(checkBossHealth)
				self:Unschedule(checkCustomBossHealth)
				self.Arrow:Hide()
				if not InCombatLockdown() then
					if watchFrameRestore then
						if private.isRetail or private.isCata or private.isMop then
							--ObjectiveTracker_Expand()
						elseif private.isWrath then
							WatchFrame:Show()
						else -- Classic Era / BCC
							QuestWatchFrame:Show()
						end
						watchFrameRestore = false
					end
					local QuestieLoader = _G["QuestieLoader"]
					if QuestieLoader then
						local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
						if QuestieTracker and questieWatchRestore and QuestieTracker.Enable then
							QuestieTracker:Enable()
							questieWatchRestore = false
						end
					end
				end
				if self.Options.RestoreSettingSFX then
					SetCVar("Sound_EnableSFX", 1)
					self.Options.RestoreSettingSFX = nil
				end
				if self.Options.RestoreSettingAmbiance then
					SetCVar("Sound_EnableAmbience", 1)
					self.Options.RestoreSettingAmbiance = nil
				end
				if self.Options.RestoreSettingMusic then
					SetCVar("Sound_EnableMusic", 1)
					self.Options.RestoreSettingMusic = nil
				end
				--cache table
				twipe(autoRespondSpam)
				twipe(bossHealth)
				twipe(bossHealthuIdCache)
				--sync table
				twipe(private.canSetIcons)
				self:ResetCombatVariables()
				bossuIdFound = false
				self:CreatePizzaTimer(0, "", nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
				self:TransitionToDungeonBGM(false, true)
				self:Schedule(22, self.TransitionToDungeonBGM, self)
				if private.syncPendingZoneAuraSounds then
					private.syncPendingZoneAuraSounds()
				end
				--module cleanup
				private:ClearModuleTasks()
			end
		end
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if not v.combatInfo then
			return
		end
		if v.combatInfo.noBossDeathKill then return end
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				private.sendSync(private.DBMSyncProtocol, "K", cId .. "\t" .. difficulties.difficultyIndex, "ALERT")
			end
			v.combatInfo.killMobs[cId] = false
			if v.numBoss and (v.vb.bossLeft or 0) > 0 then
				v.vb.bossLeft = (v.vb.bossLeft or v.numBoss) - 1
				self:Debug("Boss left - " .. v.vb.bossLeft .. "/" .. v.numBoss, 2)
			end
			local allMobsDown = true
			for _, k in pairs(v.combatInfo.killMobs) do
				if k then
					allMobsDown = false
					break
				end
			end
			if allMobsDown and not v.multiIDSingleBoss then--More hacks. don't let combat end for mutli CID single bosses
				self:EndCombat(v, nil, nil, "All Mobs Down")
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				private.sendSync(private.DBMSyncProtocol, "K", cId .. "\t" .. difficulties.difficultyIndex, "ALERT")
			end
			self:EndCombat(v, nil, nil, "Main CID Down")
		end
	end
end


--------------
--  Combat  --
--------------
---@meta
---@alias combatTypes
---|"combat": Default Option. Triggers Combat on ENCOUNTER_START, INSTANCE_ENCOUNTER_ENGAGE_UNIT, UNIT_HEALTH, PLAYER_REGEN_DISABLED
---|"yell": Triggers Combat on CHAT_MSG_MONSTER_YELL
---|"say": Triggers Combat on CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY
---|"emote": Triggers Combat on CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE
---|"yell_regex": Triggers Combat on CHAT_MSG_MONSTER_YELL using regex matching
---|"say_regex": Triggers Combat on CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY using regex matching
---|"emote_regex": Triggers Combat on CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE using regex matching
---|"combat_yell": Same as combat, but also uses CHAT_MSG_MONSTER_YELL exact matching
---|"combat_say": Same as combat, but also uses CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY exact matching
---|"combat_emote": Same as combat, but also uses CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE exact matching
---|"combat_yellfind": Same as combat, but also uses CHAT_MSG_MONSTER_YELL loose matching
---|"combat_sayfind": Same as combat, but also uses CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY loose matching
---|"combat_emotefind": Same as combat, but also uses CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE loose matching
---|"scenario": Tells mod to treat an entire scenario as combat
---@param cType combatTypes
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	---@class CombatInfo
	local info = {
		type = cType,
		mob = self.creatureId,
		eId = self.encounterId,
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
	end
	if self.multiEncounterPullDetection then
		info.multiEncounterPullDetection = self.multiEncounterPullDetection
	end
	if self.noESDetection then
		info.noESDetection = self.noESDetection
	end
	if self.noEEDetection then
		info.noEEDetection = self.noEEDetection
	end
	if self.noBKDetection then
		info.noBKDetection = self.noBKDetection
	end
	if self.noIEEUDetection then
		info.noIEEUDetection = self.noIEEUDetection
	end
	if self.noFriendlyEngagement then
		info.noFriendlyEngagement = self.noFriendlyEngagement
	end
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.DisableInTimewalking then
		info.DisableInTimewalking = self.DisableInTimewalking
	end
	if self.RequiresTimewalking then
		info.RequiresTimewalking = self.RequiresTimewalking
	end
	if self.noMultiBoss then
		info.noMultiBoss = self.noMultiBoss
	end
	if self.WBEsync then
		info.WBEsync = self.WBEsync
	end
	if self.noBossDeathKill then
		info.noBossDeathKill = self.noBossDeathKill
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for _, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for v in pairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		tinsert(combatInfo[v], info)
	end
end

---Needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	if msgType == "kill" then
		if select("#", ...) > 0 then -- calling this method with 0 IDs means "use the values from SetCreatureID", this is already done by RegisterCombat as calling RegisterKill should be optional --> mod:RegisterKill("kill") with no IDs is never necessary
			self.combatInfo.killMobs = {}
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if type(v) == "number" then
					self.combatInfo.killMobs[v] = true
				end
			end
		end
	else
		---@class CombatInfo
		local combatInfo = self.combatInfo
		combatInfo.killType = msgType
		combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			combatInfo.killMsgs[v] = true
		end
	end
end

function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	---@class CombatInfo
	local combatInfo = self.combatInfo
	combatInfo.noCombatInVehicle = not flag
end

---Used to set creature IDs this mod will scan for Boss Health and legacy or backup combat detection methods
function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
			if not self.multiIDSingleBoss then
				self.numBoss = #self.multiMobPullDetection
				if self.inCombat then
					--Called mid combat, fix some variables
					self.vb.bossLeft = self.numBoss
				end
			else
				self.numBoss = 1
			end
		end
	else
		self.numBoss = 1
		if self.combatInfo then
			--Called mid combat, update combatinfo mob for boss health and win detection
			self.combatInfo.mob = self.creatureId
		end
	end
	for i = 1, select("#", ...) do
		local cId = select(i, ...)
		if bossIds[cId] then
			DBM:Debug("Duplicate mods for cId " .. cId .. ": " .. self.id .. ", " .. bossIds[cId].id)
		end
		bossIds[cId] = self
	end
end

---Used to set Encounter IDs this mod will pass to ENCOUNTER_START/ENCOUNTER_END/BOSS_KILL
function bossModPrototype:SetEncounterID(...)
	self.encounterId = ...
	if select("#", ...) > 1 then
		self.multiEncounterPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiEncounterPullDetection = self.multiEncounterPullDetection
		end
	end
	if self.localization.general.name == self.id then
		self.localization.general.name = DBM:GetGeneratedLocales("encounter")[...] or self.localization.general.name
	end
end

---Used to disable ENCOUNTER_START from detecting boss combat
function bossModPrototype:DisableESCombatDetection()
	self.noESDetection = true
	if self.combatInfo then
		self.combatInfo.noESDetection = true
	end
end

---Used to disable ENCOUNTER_END for kill detection
function bossModPrototype:DisableEEKillDetection()
	self.noEEDetection = true
	if self.combatInfo then
		self.combatInfo.noEEDetection = true
	end
end

---Used to disable BOSS_KILL for kill detection
function bossModPrototype:DisableBKKillDetection()
	self.noBKDetection = true
	if self.combatInfo then
		self.combatInfo.noBKDetection = true
	end
end

---Used to disable INSTANCE_ENCOUNTER_ENGAGE_UNIT from detecting boss combat
function bossModPrototype:DisableIEEUCombatDetection()
	self.noIEEUDetection = true
	if self.combatInfo then
		self.combatInfo.noIEEUDetection = true
	end
end

---Used to prevent engaging a boss that's friendly
function bossModPrototype:DisableFriendlyDetection()
	self.noFriendlyEngagement = true
	if self.combatInfo then
		self.combatInfo.noFriendlyEngagement = true
	end
end

---Used to disable using PLAYER_REGEN_DISABLED from detecting boss combat
function bossModPrototype:DisableRegenDetection()
	self.noRegenDetection = true
	if self.combatInfo then
		self.combatInfo.noRegenDetection = true
	end
end

---Used to disable timewalking bosses in non timewalking dungeons that have different variants of same with same ID, in same instance
function bossModPrototype:DisableInTimeWalking()
	self.DisableInTimewalking = true
	if self.combatInfo then
		self.combatInfo.DisableInTimewalking = true
	end
end

---Used to disable non timewalking bosses in timewalking dungeons that have different variants of same with same ID, in same instance
function bossModPrototype:RequiresTimeWalking()
	self.RequiresTimewalking = true
	if self.combatInfo then
		self.combatInfo.RequiresTimewalking = true
	end
end

function bossModPrototype:DisableMultiBossPulls()
	self.noMultiBoss = true
	if self.combatInfo then
		self.combatInfo.noMultiBoss = true
	end
end

---Used to permit mod from sending syncs for world bosses.
function bossModPrototype:EnableWBEngageSync()
	self.WBEsync = true
	if self.combatInfo then
		self.combatInfo.WBEsync = true
	end
end

---Used when a bosses death condition should be ignored (maybe they die repeatedly for example)
function bossModPrototype:DisableBossDeathKill()
	self.noBossDeathKill = true
	if self.combatInfo then
		self.combatInfo.noBossDeathKill = true
	end
end

---Used when a boss is scripted in a hacky way that their creature Id changes mid fight, and we want to treat multiple IDs as a single boss
function bossModPrototype:SetMultiIDSingleBoss()
	self.multiIDSingleBoss = true
end

---Used for knowing if a specific mod is engaged
function bossModPrototype:IsInCombat()
	return self.inCombat
end

---Used for checking if any person in group is in any kind of combat
---@param self DBMModOrDBM
function DBM:GroupInCombat()
	local combatFound = false
	--Any Boss engaged
	if private.IsEncounterInProgress() then
		combatFound = true
	end
	--Self in Combat
	if InCombatLockdown() or UnitAffectingCombat("player") then
		combatFound = true
	end
	--Any Other group member in combat
	if not combatFound then
		for uId in DBM:GetGroupMembers() do
			if UnitAffectingCombat(uId) then
				combatFound = true
				break
			end
		end
	end
	return combatFound
end
bossModPrototype.GroupInCombat = DBM.GroupInCombat


---Sets minimum amount of time before a pull is concidered valid.
---@param t number
function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

---Needs to be called after RegisterCombat
---<br>Sets time out of combat required before a module should declare a wipe
---@param t number
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	---@class CombatInfo
	local combatInfo = self.combatInfo
	combatInfo.wipeTimer = t
end

---Used to specify amount of time before allowing a boss to be pulled again.
---@param t number? used to specify recombat time after a kill.
---@param t2 number? used to specify recombat time after a wipe
function bossModPrototype:SetReCombatTime(t, t2)
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function DBM:InCombat()
	return #inCombat > 0
end

