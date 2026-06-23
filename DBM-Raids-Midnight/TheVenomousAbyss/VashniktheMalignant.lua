if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2882, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3455)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, verify theory on adaptive infection (theory that main ID is only for timer and sub IDs for specific type of infection gained)
--TODO, find way to improve personal alerts
--TODO, https://www.wowhead.com/ptr/spell=1280881/toxic-outpouring and https://www.wowhead.com/ptr/spell=1280871/toxic-outpouring exists with ID of 758/769 but isn't in journal
--TODO, https://www.wowhead.com/ptr/spell=1296335/desquamating-venom exists with ID of 766 but isn't in journal
--TODO, a lot of figuring out which abiliteis have timers and which ones don't. which ones are repeating during each infection and which ones are passive
DBM:RegisterAltSpellName(1281907, DBM_COMMON_L.DEBUFFS)--Plague Froth --> Debuffs
local warnAdaptiveInfection				= mod:NewCountAnnounce(1282114, 2)--Hardcode only
local warnToxicOutpouring				= mod:NewCountAnnounce(1280881, 2)--Hardcode only, likely not used
local warnImbibeToxin					= mod:NewCountAnnounce(1283164, 2)--Hardcode only

local specWarnDrippingFangs				= mod:NewSpecialWarningCount(1280935, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnMalignantCatalyst			= mod:NewSpecialWarningSoakCount(1282509, nil, nil, nil, 2, 2, nil, nil, "helpsoak")
local specWarnPlagueFroth				= mod:NewSpecialWarningCount(1281907, nil, nil, nil, 2, 15, nil, nil, "incomingdebuff")
local specWarnStygianInfection			= mod:NewSpecialWarningCount(1294994, nil, nil, nil, 2, 2, nil, nil, "phasechange")--Sub ability to Adaptive Infection
local specWarnSiphoningInfection		= mod:NewSpecialWarningCount(1295224, nil, nil, nil, 2, 2, nil, nil, "gathershare")--Sub ability to Adaptive Infection
local specWarnExplodingInfection		= mod:NewSpecialWarningCount(1295173, nil, nil, nil, 2, 2, nil, nil, "phasechange")--Sub ability to Adaptive Infection
local specWarnStygianBurst				= mod:NewSpecialWarningCount(1302489, nil, nil, nil, 2, 2, nil, nil, "watchstep")

local timerDrippingFangsCD				= mod:NewCDCountTimer(20.5, 1280935, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAdaptiveInfectionCD			= mod:NewCDCountTimer(20.5, 1282114, nil, nil, nil, 6)
local timerMalignantCatalystCD			= mod:NewCDCountTimer(20.5, 1282509, nil, nil, nil, 5)
local timerPlagueFrothCD				= mod:NewCDCountTimer(20.5, 1281907, nil, nil, nil, 3)
local timerToxicOutpouringCD			= mod:NewCDCountTimer(20.5, 1280881, nil, nil, nil, 5)--likely not used
local timerImbibeToxinCD				= mod:NewCDCountTimer(20.5, 1283164, nil, nil, nil, 5)
local timerDesquamatingVenomCD			= mod:NewCDCountTimer(20.5, 1296335, nil, nil, nil, 3)--likely not used
local timerStygianBurstCD				= mod:NewCDCountTimer(20.5, 1302489, nil, nil, nil, 3)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

mod.vb.DrippingFangsCount = 0
mod.vb.AdaptiveInfectionCount = 0
mod.vb.MalignantCatalystCount = 0
mod.vb.PlagueFrothCount = 0
mod.vb.ToxicOutpouringCount = 0
mod.vb.ImbibeToxinCount = 0
mod.vb.DesquamatingVenomCount = 0
mod.vb.StygianBurstCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnDrippingFangs:SetAlert(754, "defensive", 2, 2)
		end
		specWarnMalignantCatalyst:SetAlert(756, "helpsoak", 2, 2)
		specWarnPlagueFroth:SetAlert(757, "incomingdebuff", 15, 2)
		specWarnStygianInfection:SetAlert({770, 774}, "phasechange", 2, 2, 0)
		specWarnSiphoningInfection:SetAlert(771, "gathershare", 2, 2, 0)
		specWarnExplodingInfection:SetAlert({772, 773}, "phasechange", 2, 2, 0)
		specWarnStygianBurst:SetAlert(775, "watchstep", 2, 2)
	end
	local onlyColor = not DBM.Options.HideDBMBars
	timerDrippingFangsCD:SetTimeline(754, onlyColor)
	timerAdaptiveInfectionCD:SetTimeline(755, onlyColor)
	timerMalignantCatalystCD:SetTimeline(756, onlyColor)
	timerPlagueFrothCD:SetTimeline(757, onlyColor)
	timerToxicOutpouringCD:SetTimeline({758, 769}, onlyColor)
	timerImbibeToxinCD:SetTimeline(759, onlyColor)
	timerDesquamatingVenomCD:SetTimeline(766, onlyColor)
	timerStygianBurstCD:SetTimeline(775, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.DrippingFangsCount = 1
	self.vb.AdaptiveInfectionCount = 1
	self.vb.MalignantCatalystCount = 1
	self.vb.PlagueFrothCount = 1
	self.vb.ToxicOutpouringCount = 1
	self.vb.ImbibeToxinCount = 1
	self.vb.DesquamatingVenomCount = 1
	self.vb.StygianBurstCount = 1

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
