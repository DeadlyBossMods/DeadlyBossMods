local mod	= DBM:NewMod(2733, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(240435)
mod:SetEncounterID(3176)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(
--	"ENCOUNTER_TIMELINE_EVENT_ADDED"
--)

--NOTE, https://www.wowhead.com/spell=1270949/desolation has event ID of 361 on this fight but doesn't exist?
--TODO, add remaining private auras? most of em are just basic stacks and stuff anchor kinda handles better since we can't warn for stacks
--TODO, do adds have timeline timers? i very much doubt it, possibly see if timers are fixed after spawn and start on spawn
local specWarnShadowsAdvance			= mod:NewSpecialWarningCount(1262776, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnDarkUpheaval				= mod:NewSpecialWarningCount(1249251, nil, nil, nil, 2, 2)
local specWarnOblivionWrath				= mod:NewSpecialWarningDodgeCount(1260712, nil, nil, nil, 2, 2)
local specWarnVoidFall					= mod:NewSpecialWarningCount(1258880, nil, 28405, nil, 2, 2)
local specWarnMarchofEndless			= mod:NewSpecialWarningSpell(1260203, nil, nil, nil, 3, 2)--Enrage?
local specWarnPitchBulwark				= mod:NewSpecialWarningInterrupt(1255702, false, nil, nil, 1, 2)--Probably spammy

local timerShadowsAdvanceCD				= mod:NewCDCountTimer(20.5, 1262776, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerDarkUpheavalCD				= mod:NewCDCountTimer(20.5, 1249251, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerUmbralCollapseCD				= mod:NewCDCountTimer(20.5, 1249265, nil, nil, nil, 3)
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

function mod:OnLimitedCombatStart()
	self.vb.shadowCount = 0
	self.vb.upheavalCount = 0
	self.vb.CollapseCount = 0
	self.vb.oblivionCount = 0
	self.vb.voidFallCount = 0
	self.vb.voidMarkCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	specWarnShadowsAdvance:SetAlert({194, 195}, "mobsoon", 2, 2)
	timerShadowsAdvanceCD:SetTimeline({194, 195})
	specWarnDarkUpheaval:SetAlert(196, "aesoon", 2, 2)
	timerDarkUpheavalCD:SetTimeline(196)
	timerUmbralCollapseCD:SetTimeline(197)
	specWarnOblivionWrath:SetAlert(198, "watchstep", 2, 2)
	timerOblivionWrathCD:SetTimeline(198)
	specWarnVoidFall:SetAlert({199, 209}, "carefly", 2, 2)
	timerVoidFallCD:SetTimeline({199, 209})
	specWarnMarchofEndless:SetAlert(200, "stilldanger", 2, 4)
	specWarnPitchBulwark:SetAlert(201, "kickcast", 2, 2, 0)
	timerVoidMarkCD:SetTimeline(419)

	self:EnablePrivateAuraSound({1249265,1260203}, "helpsoak", 2)--or gathershare?
	self:EnablePrivateAuraSound(1280023, "darknessyou", 19)
	self:EnablePrivateAuraSound(1283069, "fixateyou", 19)
	self:EnablePrivateAuraSound(1275059, "curseyou", 19)
end

--[[
--Note, bar stage changing and canceling is handled by core
function DBM:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
	if eventInfo.source ~= 0 then return end
	local eventID = eventInfo.id
--	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local timer = math.floor(eventInfo.duration + 0.5)
end
--]]
