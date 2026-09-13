if DBM:GetTOC() < 120105 then return end
local mod	= DBM:NewMod(2896, "DBM-Raids-Midnight", 5, 1324)--Change order when 12.1.5 ships
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(267861)
mod:SetEncounterID(3513)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3095)

mod:RegisterCombat("combat")

--NOTE. https://www.wowhead.com/ptr-2/spell=1303406/abyssal-grasp has event ID of 864 but we'll use aura for now until we can confirm ENCOUNTER_WARNING is used
--TODO, cleanup objects that don't have timeline events
--TODO, gtfo for https://www.wowhead.com/ptr-2/spell=1304950/voidscar ?
--TODO, more renames
DBM:RegisterAltSpellName(1304930, DBM_COMMON_L.TANK .. " " .. DBM_COMMON_L.FRONTAL)--Dark Devastation -> Tank Frontal
--Stage 1
--local warnUnspeakableHorrors			= mod:NewCountAnnounce(1304045, 3)--Hardcode Only
--local Nullgate						= mod:NewCountAnnounce(1308873, 3)--Hardcode Only
--local EightfoldEclipse				= mod:NewCountAnnounce(1301479, 4)--Hardcode Only

local specWarnDarkDevastation			= mod:NewSpecialWarningDefensive(1304930, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnVoidswarm					= mod:NewSpecialWarningCount(1301511, nil, nil, nil, 1, 2, nil, nil, "mobsoon")
local warnSuffocatingDarkness			= mod:NewSpecialWarningCount(1302951, nil, nil, nil, 2, 2, nil, nil, "phasechange")
local specWarnExtinguish				= mod:NewSpecialWarningCount(1304424, nil, nil, nil, 3, 2, nil, nil, "findshield")
local specWarnTwistedAppendage			= mod:NewSpecialWarningDodgeCount(1303681, nil, nil, nil, 2, 2, nil, nil, "watchfeet")
local specWarnDivineRadiance			= mod:NewSpecialWarningCount(1303406, nil, nil, nil, 2, 2, nil, nil, "phasechange")--Darkness ending

local timerUnspeakableHorrorsCD			= mod:NewCDCountTimer(20.5, 1304045, nil, nil, nil, 3)
local timerDarkDevastationCD			= mod:NewCDCountTimer(20.5, 1304930, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVoidswarmCD					= mod:NewCDCountTimer(20.5, 1301511, nil, nil, nil, 1)
local timerSuffocatingDarknessCD		= mod:NewCDCountTimer(20.5, 1302951, nil, nil, nil, 6)
local timerExtinguishCD					= mod:NewCDCountTimer(20.5, 1304424, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTwistedAppendageCD			= mod:NewCDCountTimer(20.5, 1303681, nil, nil, nil, 3)
local timerNullgateCD					= mod:NewCDCountTimer(20.5, 1308873, nil, nil, nil, 3)
local timerDivineRadianceCD				= mod:NewCDCountTimer(20.5, 1303406, nil, nil, nil, 6)
local timerNegationCD					= mod:NewCDCountTimer(20.5, 1318467, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEightfoldEclipseCD			= mod:NewCDCountTimer(20.5, 1301479, nil, nil, nil, 2)
--local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddAuraSoundOption(1304045, true, 1304045, 1, 1, "runout", 2)--Unbreakable Horror (pre debuff that leads to Overwhelming Fear
mod:AddAuraSoundOption(1304046, true, 1304045, 1, 3, "fearyou", 2)--Overwhelming Fear
mod:AddAuraSoundOption(1303406, true, 1302951, 1, 1, "absorbyou", 19)--Abyssal Grasp, part of Suffocating Darkness
mod:AddAuraSoundOption(1308873, true, 1308873, 1, 1, "runout", 2)--Null gate (make custom audio later?)
mod:AddAuraSoundOption(1318467, true, 1318467, 1, 1, "movetogate", 20)--Negation
mod:AddAuraSoundOption(1304040, true, 1301511, 1, 1, "stunyou", 19)--Mindsting
mod:AddAuraSoundOption(1302334, true, 1301511, 1, 1, "beamyou", 19)--Voidweave
mod:AddAuraSoundOption(1304434, true, 1301511, 1, 1, "fixateyou", 19)--Fixate (verify ID)
mod:AddAuraSoundOption(1303257, true, 1302951, 1, 2, "findshelter", 2)--Suffocation (debuff from not being in barrier)

local badStateDetected = false

---@param self DBMMod
---@param dontSetAlerts boolean? Called on engage when we only want to set timeline parameters and not touch encounter alerts
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnDarkDevastation:SetAlert(858, "defensive", 2, 2)
		end
		specWarnVoidswarm:SetAlert(859, "mobsoon", 2, 3)
		warnSuffocatingDarkness:SetAlert(860, "phasechange", 2, 2)
		specWarnExtinguish:SetAlert(861, "findshield", 2, 4)
		specWarnTwistedAppendage:SetAlert(862, "watchstep", 2, 2)
		specWarnDivineRadiance:SetAlert(951, "phasechange", 2, 2)
	end

	--If user has dbm bars enabled, countdowns will be sent by dbm bars
	--if user has dbm bars off, SetTimeline will set color and countdowns
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerUnspeakableHorrorsCD:SetTimeline(838, onlyColor)
	timerDarkDevastationCD:SetTimeline(858, onlyColor)
	timerVoidswarmCD:SetTimeline(859, onlyColor)
	timerSuffocatingDarknessCD:SetTimeline(860, onlyColor)
	timerExtinguishCD:SetTimeline(861, onlyColor)
	timerTwistedAppendageCD:SetTimeline(862, onlyColor)
	timerNullgateCD:SetTimeline(903, onlyColor)
	timerDivineRadianceCD:SetTimeline(951, onlyColor)
	timerNegationCD:SetTimeline(1002, onlyColor)
	timerEightfoldEclipseCD:SetTimeline(1003, onlyColor)
end

function mod:OnLimitedCombatStart(delay)
	self:TLCountReset()
	--Hardcode features first
	if DBM.Options.HardcodedTimer and not badStateDetected then
		self:SetStage(1)
		self:IgnoreBlizzardAPI()
--		self:RegisterShortTermEvents(
--			"ENCOUNTER_TIMELINE_EVENT_ADDED",
--			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
--		)
		--Even when using hardcodes, we still want to customize the timeline in certain ways
		--Many use timeline in conjunction with DBM warnings
		setFallback(self, true)
	else
		setFallback(self)
	end
end

function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

--[[
do
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			--Do Stuff
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			--Do Stuff
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			--Do Stuff
		end
	end
end
--]]
