if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2883, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3429)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, see if fixation has a timer, it's not a core ability but a sub of another so probably not
--TODO, https://www.wowhead.com/ptr/spell=1287227/blighted-toxin has an encounter event ID of 669 and 681 but is not in journal
--TODO, Guillotine target. might be one ID for timeline event and another for actual primary target?
--TODO, https://www.wowhead.com/ptr/spell=1286308/shadowfang has an encounter event ID of 683 but is not in journal
--TODO confirm Gloombomb has a personal alert, if it doesn't it needs to be aoe one
--TODO, threat check to see WHICH tank is aiming frontal (Soul Severing) and give them a different audio from everyone else who is just dodging it
--TODO, refine audio for second step of Toxic Deluge?
--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
local specWarnUnnervingFixation			= mod:NewSpecialWarningYou(1285911, nil, nil, nil, 1, 19, nil, nil, "fixateyou")
local specWarnFangsoftheCrucible		= mod:NewSpecialWarningCount(1282487, nil, nil, nil, 2, 2, nil, nil, "specialsoon")
local specWarnGuilotine					= mod:NewSpecialWarningCount(1283485, nil, nil, nil, 2, 2, nil, nil, "helpsoak")
local specWarnVenomfang					= mod:NewSpecialWarningCount(1282281, "RemovePoison", nil, nil, 2, 2, nil, nil, "helpdispel")
local specWarnAxegrinder				= mod:NewSpecialWarningDodgeCount(1283832, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnEternalNightfall			= mod:NewSpecialWarningCount(1286918, nil, nil, nil, 3, 2, nil, nil, "attackshield")
local specWarnGloombomb					= mod:NewSpecialWarningYou(1286895, nil, nil, nil, 1, 2, nil, nil, "bombyou")
local specWarnDeathmarch				= mod:NewSpecialWarningCount(1289900, nil, nil, nil, 2, 2, nil, nil, "findmc")
local specWarnSoulSevering				= mod:NewSpecialWarningCount(1286573, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 2 tank sever
local specWarnSpiritcackle				= mod:NewSpecialWarningSwitchCount(1286441, nil, nil, nil, 1, 2, nil, nil, "killmob")
local specWarnDefilementoftheCrucible	= mod:NewSpecialWarningCount(1298381, nil, nil, nil, 2, 2, nil, nil, "specialsoon")--Stage 2 empowered version of Fang of the Crucible, same spellid but different encounter event ID
local specWarnGrimGuillotine			= mod:NewSpecialWarningCount(1299266, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Stage 2 empowered version of Guillotine, same spellid but different encounter event ID
local specWarnSever						= mod:NewSpecialWarningCount(1299680, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 1 tank sever
local specWarnToxicDeluge				= mod:NewSpecialWarningCount(1299960, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnBlightedSevering			= mod:NewSpecialWarningCount(1287227, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 3 tank sever

local timerFangsoftheCrucibleCD			= mod:NewCDCountTimer(20.5, 1282487, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGuilotineCD					= mod:NewCDCountTimer(20.5, 1283485, nil, nil, nil, 3)
local timerVenomfangCD					= mod:NewCDCountTimer(20.5, 1282281, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)
local timerAxegrinderCD					= mod:NewCDCountTimer(20.5, 1283832, nil, nil, nil, 3)
local timerEternalNightfallCD			= mod:NewCDCountTimer(20.5, 1286918, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerGloombombCD					= mod:NewCDCountTimer(20.5, 1286895, nil, nil, nil, 3)
local timerDeathmarchCD					= mod:NewCDCountTimer(20.5, 1289900, nil, nil, nil, 3)
local timerSoulSeveringCD				= mod:NewCDCountTimer(20.5, 1286573, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK)
local timerSpiritcackleCD				= mod:NewCDCountTimer(20.5, 1286441, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDefilementoftheCrucibleCD	= mod:NewCDCountTimer(20.5, 1298381, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGrimGuillotineCD				= mod:NewCDCountTimer(20.5, 1299266, nil, nil, nil, 3)
local timerSeverCD						= mod:NewCDCountTimer(20.5, 1299680, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerToxicDelugeCD				= mod:NewCDCountTimer(20.5, 1299960, nil, nil, nil, 3)
local timerBlightedSeveringCD			= mod:NewCDCountTimer(20.5, 1287227, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

mod.vb.CrucibleCount = 0--Used for fangs AND defilement. Reset on stage 2 start
mod.vb.GuilotineCount = 0--Used for guillotine AND grim guillotine. Reset on stage 2 start
mod.vb.VenomfangCount = 0
mod.vb.AxegrinderCount = 0
mod.vb.EternalNightfallCount = 0
mod.vb.GloombombCount = 0
mod.vb.DeathmarchCount = 0
mod.vb.SeverCount = 0--Used for all 3 versions of tank sever. Reset on stage 2 and stage 3 start
mod.vb.SpiritcackleCount = 0
mod.vb.ToxicDelugeCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then

		end
		if self:CheckDispelFilter("poison") then
			specWarnVenomfang:SetAlert(679, "helpdispel", 2, 2)
		end
		specWarnUnnervingFixation:SetAlert(667, "fixateyou", 19, 2, 0)
		specWarnFangsoftheCrucible:SetAlert(677, "specialsoon", 2, 2)
		specWarnGuilotine:SetAlert(678, "helpsoak", 2, 2)
		specWarnAxegrinder:SetAlert(680, "watchstep", 2, 2)
		specWarnEternalNightfall:SetAlert(682, "attackshield", 2, 2)
		specWarnGloombomb:SetAlert(684, "bombyou", 2, 2, 0)
		specWarnDeathmarch:SetAlert(685, "findmc", 2, 2)
		specWarnSoulSevering:SetAlert(686, "frontal", 15, 2)
		specWarnSpiritcackle:SetAlert(687, "killmob", 2, 2)
		specWarnDefilementoftheCrucible:SetAlert(794, "specialsoon", 2, 2)
		specWarnGrimGuillotine:SetAlert(803, "helpsoak", 2, 2)
		specWarnSever:SetAlert(811, "frontal", 15, 2)
		specWarnToxicDeluge:SetAlert(812, "watchstep", 2, 2)
		specWarnBlightedSevering:SetAlert(898, "frontal", 15, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerFangsoftheCrucibleCD:SetTimeline(677, onlyColor)
	timerGuilotineCD:SetTimeline(678, onlyColor)
	timerVenomfangCD:SetTimeline(679, onlyColor)
	timerAxegrinderCD:SetTimeline(680, onlyColor)
	timerEternalNightfallCD:SetTimeline(682, onlyColor)
	timerGloombombCD:SetTimeline(684, onlyColor)
	timerDeathmarchCD:SetTimeline(685, onlyColor)
	timerSoulSeveringCD:SetTimeline(686, onlyColor)
	timerSpiritcackleCD:SetTimeline(687, onlyColor)
	timerDefilementoftheCrucibleCD:SetTimeline(794, onlyColor)
	timerGrimGuillotineCD:SetTimeline(803, onlyColor)
	timerSeverCD:SetTimeline(811, onlyColor)
	timerToxicDelugeCD:SetTimeline(812, onlyColor)
	timerBlightedSeveringCD:SetTimeline(898, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.CrucibleCount = 1
	self.vb.GuilotineCount = 1
	self.vb.VenomfangCount = 1
	self.vb.AxegrinderCount = 1
	self.vb.EternalNightfallCount = 1
	self.vb.GloombombCount = 1
	self.vb.DeathmarchCount = 1
	self.vb.SeverCount = 1
	self.vb.SpiritcackleCount = 0
	self.vb.ToxicDelugeCount = 1
	--Hardcode features first
	--if DBM.Options.HardcodedTimer and not badStateDetected then
	--	--self:SetStage(1)
	--	self:IgnoreBlizzardAPI()
	--	self:RegisterShortTermEvents(
	--		"ENCOUNTER_TIMELINE_EVENT_ADDED",
	--		"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
	--	)
	--	if DBM.Options.HideDBMBars then
	--		setFallback(self, true)
	--	end
	--else
		setFallback(self)
	--end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

--[[
do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersAll(self, timer, timerExact, eventID)
		local handled
		if timer == 114 then
			handled = true
			timerWaterJetCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "waterjet", "tankWaterCount"))
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	--Note, bar state changing and canceling is handled by core

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			timersAll(self, timer, timerExact, eventID)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if not eventCount then return end
			if eventType == "waterjet" then
				--specWarnWaterJet:Show(eventCount, "lineyou")
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
--]]
