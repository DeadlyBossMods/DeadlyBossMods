local mod	= DBM:NewMod(2734, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(240434)
mod:SetEncounterID(3177)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(
--	"ENCOUNTER_TIMELINE_EVENT_ADDED"
--)

--TODO< https://www.wowhead.com/spell=1244346/colossal-throw has an event ID but doesn't exist on encounter?
--TODO, probably drop either 59 or 60 for eventIDs, one is for parent activation and one is for the additional slams we probably want to ignore/filter
--Hardcoded Objects that use Blizz api as fallback
local specWarnShadowclawSlam			= mod:NewSpecialWarningCount(1241836, nil, 182557, nil, 2, 2)
local specWarnVoidBreath				= mod:NewSpecialWarningDodgeCount(1243853, nil, 17088, nil, 2, 2)
local specWarnParasiteExpulsion			= mod:NewSpecialWarningDodgeCount(1254199, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnPrimordialRoar			= mod:NewSpecialWarningCount(1260046, nil, 140459, nil, 2, 2)
local specWarnFixateParasite			= mod:NewSpecialWarningYou(1254112, nil, nil, nil, 1, 2)

local timerShadowclawSlamCD				= mod:NewCDCountTimer(20.5, 1241836, 182557, nil, nil, 2)--Shortname "Slam"
local timerVoidBreathCD					= mod:NewCDCountTimer(20.5, 1243853, 17088, nil, nil, 3)--Shortname "Breath"
local timerParasiteExpulsionCD			= mod:NewCDCountTimer(20.5, 1254199, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerPrimordialRoarCD				= mod:NewCDCountTimer(20.5, 1260046, 140459, nil, nil, 2)--Shortname "Roar"

mod:AddPrivateAuraSoundOption(1243270, true, 1243270, 1, 2)--Dark Goo
mod:AddPrivateAuraSoundOption(1241844, false, 1241836, 1, 1)--Smashed (debuff from shadowclaw slam)
mod:AddPrivateAuraSoundOption(1272527, false, 1272527, 1, 1)--Creep Spit
mod:AddPrivateAuraSoundOption(1259186, true, 1259186, 1, 1)--Blisterburst

mod.vb.clawCount = 0
mod.vb.breathCount = 0
mod.vb.expulsionCount = 0
mod.vb.roarCount = 0

function mod:OnLimitedCombatStart()
	self.vb.clawCount = 0
	self.vb.breathCount = 0
	self.vb.expulsionCount = 0
	self.vb.roarCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	specWarnShadowclawSlam:SetAlert({59, 60}, "slamincoming", 19, 2)
	timerShadowclawSlamCD:SetTimeline({59, 60})
	specWarnVoidBreath:SetAlert(61, "breathsoon", 2, 4)
	timerVoidBreathCD:SetTimeline(61)
	specWarnParasiteExpulsion:SetAlert(62, "watchstep", 2, 2)
	timerParasiteExpulsionCD:SetTimeline(62)
	specWarnPrimordialRoar:SetAlert(133, "carefly", 2, 3)
	timerPrimordialRoarCD:SetTimeline(133)
	specWarnFixateParasite:SetAlert(1254112, "fixateyou", 19, 3, 0)--Iffy, but maybe

	self:EnablePrivateAuraSound(1243270, "watchfeet", 8)
	self:EnablePrivateAuraSound(1241844, "debuffyou", 17)
	self:EnablePrivateAuraSound(1272527, "debuffyou", 17)
	self:EnablePrivateAuraSound(1259186, "debuffyou", 17)
end

--[[
function DBM:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo, remaining)
	local eventID = eventInfo.id
--	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local duration = remaining or eventInfo.duration
end
--]]
