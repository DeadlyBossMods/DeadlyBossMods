local mod	= DBM:NewMod(2733, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(240435)
mod:SetEncounterID(3176)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--NOTE, https://www.wowhead.com/spell=1270949/desolation has event ID of 361 on this fight but doesn't exist?
--TODO, add remaining private auras? most of em are just basic stacks and stuff anchor kinda handles better since we can't warn for stacks
--TODO, do adds have timeline timers? i very much doubt it, possibly see if timers are fixed after spawn and start on spawn
local specWarnShadowsAdvance			= mod:NewSpecialWarningCount(1262776, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnDarkUpheaval				= mod:NewSpecialWarningCount(1249251, nil, nil, nil, 2, 2)
local specWarnUmbralCollapse			= mod:NewSpecialWarningCount(1249265, nil, DBM_COMMON_L.GROUPSOAK, nil, 2, 2)
local specWarnOblivionWrath				= mod:NewSpecialWarningDodgeCount(1260712, nil, nil, nil, 2, 2)
local specWarnVoidFall					= mod:NewSpecialWarningCount(1258880, nil, 28405, nil, 2, 2)
local specWarnMarchofEndless			= mod:NewSpecialWarningSpell(1260203, nil, nil, nil, 3, 2)--Enrage?
local specWarnPitchBulwark				= mod:NewSpecialWarningInterrupt(1255702, false, nil, nil, 1, 2)--Probably spammy

local timerShadowsAdvanceCD				= mod:NewCDCountTimer(20.5, 1262776, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerDarkUpheavalCD				= mod:NewCDCountTimer(20.5, 1249251, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerUmbralCollapseCD				= mod:NewCDCountTimer(20.5, 1249265, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 3)
local timerOblivionWrathCD				= mod:NewCDCountTimer(20.5, 1260712, nil, nil, nil, 3)
local timerVoidFallCD					= mod:NewCDCountTimer(20.5, 1258880, 28405, nil, nil, 2)--Shortname "Knockback"
local timerVoidMarkCD					= mod:NewCDCountTimer(20.5, 1280023, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.MAGIC_ICON)

mod:AddPrivateAuraSoundOption(1249265, true, 1249265, 1, 2)--Umbral Collapse
mod:AddPrivateAuraSoundOption(1280023, true, 1280023, 1, 1)--Void Marked
mod:AddPrivateAuraSoundOption(1283069, true, 1283069, 1, 3)--Weakened
mod:AddPrivateAuraSoundOption(1275059, true, 1275059, 1, 1)--Black Miasma

mod.vb.shadowCount = 0
mod.vb.upheavalCount = 0
mod.vb.CollapseCount = 0
mod.vb.oblivionCount = 0
mod.vb.voidFallCount = 0
mod.vb.voidMarkCount = 0
local badStateDetected = false
local next72IsShadow = false
local cachedEventIDs = {}

function mod:OnLimitedCombatStart()
	table.wipe(cachedEventIDs)
	self.vb.shadowCount = 1
	self.vb.upheavalCount = 1
	self.vb.CollapseCount = 1
	self.vb.oblivionCount = 1
	self.vb.voidFallCount = 1
	self.vb.voidMarkCount = 1
	next72IsShadow = false
	if DBM.Options.HardcodedTimer and self:IsDifficulty("lfr", "normal", "heroic") and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		--Blizz API fallbacks
		specWarnShadowsAdvance:SetAlert({194, 195}, "mobsoon", 2, 2)
		timerShadowsAdvanceCD:SetTimeline({194, 195})
		specWarnDarkUpheaval:SetAlert(196, "aesoon", 2, 2)
		timerDarkUpheavalCD:SetTimeline(196)
		specWarnUmbralCollapse:SetAlert(197, "gathershare", 2, 2)
		timerUmbralCollapseCD:SetTimeline(197)
		specWarnOblivionWrath:SetAlert(198, "watchstep", 2, 2)
		timerOblivionWrathCD:SetTimeline(198)
		specWarnVoidFall:SetAlert({199, 209}, "carefly", 2, 2)
		timerVoidFallCD:SetTimeline({199, 209})
		specWarnMarchofEndless:SetAlert(200, "stilldanger", 2, 4)
		specWarnPitchBulwark:SetAlert(201, "kickcast", 2, 2, 0)
		timerVoidMarkCD:SetTimeline(419)
	end

	self:EnablePrivateAuraSound({1249265,1260203}, "helpsoak", 2)--or gathershare?
	self:EnablePrivateAuraSound(1280023, "darknessyou", 19)
	self:EnablePrivateAuraSound(1283069, "fixateyou", 19)
	self:EnablePrivateAuraSound(1275059, "curseyou", 19)
end

function mod:OnCombatEnd()
	table.wipe(cachedEventIDs)
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param eventID number
	local function timersEasy(self, timer, eventID, timeInCombat)
		--Logic confirmed against normal, heroic, and LFR
		if timer == 4 or timer == 36 then--Dark Upheaval
			timerDarkUpheavalCD:TLStart(timer, eventID, self.vb.upheavalCount)
			cachedEventIDs[eventID] = "upheaval"
		elseif timer == 48 or timer == 18 then--Oblivion's Wrath
			timerOblivionWrathCD:TLStart(timer, eventID, self.vb.oblivionCount)
			cachedEventIDs[eventID] = "oblivion"
		elseif timer == 125 then--Void Fall
			timerVoidFallCD:TLStart(timer, eventID, self.vb.voidFallCount)
			cachedEventIDs[eventID] = "voidfall"
			if timeInCombat >= 2 then
				next72IsShadow = true
			end
		elseif timer == 84 or timer == 12 then--Shadow's Advance
			--Blizzard starts two shadows advance on pull, it's only time 84 exists
			--We need to deal with special count handling to work around this quirk
			if timer == 84 then
				--Increment count by 1 since it'll start in parallel to the initial 12 second bar
				timerShadowsAdvanceCD:TLStart(timer, eventID, self.vb.shadowCount+1)
			else
				timerShadowsAdvanceCD:TLStart(timer, eventID, self.vb.shadowCount)
			end
			cachedEventIDs[eventID] = "shadow"
		elseif timer == 20 then--Umbral Collapse
			timerUmbralCollapseCD:TLStart(timer, eventID, self.vb.CollapseCount)
			cachedEventIDs[eventID] = "collapse"
		elseif timer == 72 then--Can be Shadow's Advance or Umbral Collapse in this pull
			if next72IsShadow then
				timerShadowsAdvanceCD:TLStart(timer, eventID, self.vb.shadowCount)
				cachedEventIDs[eventID] = "shadow"
				next72IsShadow = false
			else
				timerUmbralCollapseCD:TLStart(timer, eventID, self.vb.CollapseCount)
				cachedEventIDs[eventID] = "collapse"
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			badStateDetected = true
			if DBM.Options.IgnoreBlizzAPI then
				DBM.Options.IgnoreBlizzAPI = false
				DBM:FireEvent("DBM_ResumeBlizzAPI")
			end
			self:UnregisterShortTermEvents()
			DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end
	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
--		local eventState = C_EncounterTimeline.GetEventState(eventID)
		local timer = math.floor(eventInfo.duration + 0.5)
		local timeInCombat = GetTime() - self.combatInfo.pull
		if not badStateDetected then
			if self:IsDifficulty("lfr", "normal", "heroic") then
				timersEasy(self, timer, eventID, timeInCombat)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then--Finished (A bar that's ending, meaning now the cast should be happening soon)
			local eventType = cachedEventIDs[eventID]
			if eventType then
				if eventType == "upheaval" then
					self.vb.upheavalCount = self.vb.upheavalCount + 1
					specWarnDarkUpheaval:Show(self.vb.upheavalCount)
					specWarnDarkUpheaval:Play("aesoon")
				elseif eventType == "oblivion" then
					self.vb.oblivionCount = self.vb.oblivionCount + 1
					specWarnOblivionWrath:Show(self.vb.oblivionCount)
					specWarnOblivionWrath:Play("watchstep")
				elseif eventType == "voidfall" then
					self.vb.voidFallCount = self.vb.voidFallCount + 1
					specWarnVoidFall:Show(self.vb.voidFallCount)
					specWarnVoidFall:Play("carefly")
				elseif eventType == "shadow" then
					self.vb.shadowCount = self.vb.shadowCount + 1
					specWarnShadowsAdvance:Show(self.vb.shadowCount)
					specWarnShadowsAdvance:Play("mobsoon")
				elseif eventType == "collapse" then
					self.vb.CollapseCount = self.vb.CollapseCount + 1
					specWarnUmbralCollapse:Show(self.vb.CollapseCount)
					specWarnUmbralCollapse:Play("gathershare")
				end
				cachedEventIDs[eventID] = nil
			end
		elseif eventState == 3 then--Canceled/removed
			cachedEventIDs[eventID] = nil
		end
	end
end
