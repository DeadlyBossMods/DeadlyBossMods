local mod	= DBM:NewMod(2735, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(250892)--Vaelgor main boss, 254109 for Ezzorak
mod:SetEncounterID(3178)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(
--	"ENCOUNTER_TIMELINE_EVENT_ADDED"
--)

--NOTE: hardcode can probably combine cosmisis abilities into a single https://www.wowhead.com/ptr/spell=1263623/cosmosis timer
--local warnRadiantBarrier			= mod:NewCountAnnounce(1248847, 1)

local specWarnNullBeam				= mod:NewSpecialWarningCount(1262623, nil, nil, nil, 2, 2)
local specWarnVoidHowl				= mod:NewSpecialWarningCount(1244917, nil, nil, nil, 2, 2)
local specWarnGloom					= mod:NewSpecialWarningCount(1245391, nil, nil, nil, 2, 2)
local specWarnDreadBreath			= mod:NewSpecialWarningCount(1244221, nil, nil, nil, 2, 2)
local specWarnMidnightFlames		= mod:NewSpecialWarningCount(1249748, nil, nil, nil, 2, 2)
local specWarnGrabblingMaw			= mod:NewSpecialWarningDefensive(1280458, nil, nil, nil, 1, 2)
local specWarnRakfang				= mod:NewSpecialWarningDefensive(1245645, nil, nil, nil, 1, 2)
local specWarnVaelwing				= mod:NewSpecialWarningDefensive(1265131, nil, nil, nil, 1, 2)
local specWarnCosmosisGloom			= mod:NewSpecialWarningCount(1277470, nil, nil, nil, 2, 2, 4)
local specWarnCosmosisNullbeam		= mod:NewSpecialWarningCount(1277471, nil, nil, nil, 2, 2, 4)
local specWarnCosmosisDreadBreath	= mod:NewSpecialWarningCount(1277472, nil, nil, nil, 2, 2, 4)
local specWarnCosmosisVoidHowl		= mod:NewSpecialWarningCount(1277473, nil, nil, nil, 2, 2, 4)

local timerNullBeamCD				= mod:NewCDCountTimer(20.5, 1262623, nil, nil, nil, 3)
local timerVoidHowlCD				= mod:NewCDCountTimer(20.5, 1244917, nil, nil, nil, 2)
local timerGloomCD					= mod:NewCDCountTimer(20.5, 1245391, nil, nil, nil, 3)
local timerDreadBreathCD			= mod:NewCDCountTimer(20.5, 1244221, nil, nil, nil, 3)
local timerMidnightFlamesCD			= mod:NewCDCountTimer(20.5, 1249748, nil, nil, nil, 2)
local timerGrabblingMawCD			= mod:NewCDCountTimer(20.5, 1280458, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRakfangCD				= mod:NewCDCountTimer(20.5, 1245645, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVaelwingCD				= mod:NewCDCountTimer(20.5, 1265131, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmosisGloomCD			= mod:NewCDCountTimer(20.5, 1277470, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisNullbeamCD		= mod:NewCDCountTimer(20.5, 1277471, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisDreadBreathCD	= mod:NewCDCountTimer(20.5, 1277472, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisVoidHowlCD		= mod:NewCDCountTimer(20.5, 1277473, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerRadiantBarrierCD			= mod:NewCDCountTimer(20.5, 1248847, nil, nil, nil, 5)

mod:AddPrivateAuraSoundOption(1262999, true, 1262623, 1, 1)--Null Beam (soaked it)
mod:AddPrivateAuraSoundOption(1244672, true, 1262623, 1, 2)--Null Zone (GTFO from null beam)
mod:AddPrivateAuraSoundOption(1252157, true, 1262623, 1, 1)--Null Implosion
mod:AddPrivateAuraSoundOption(1245554, true, 1245391, 1, 1)--Gloomtouched (soaked Gloom)
mod:AddPrivateAuraSoundOption(1270852, false, 1245391, 1, 1)--Diminish (Gloomtouched ended, don't soak again)
mod:AddPrivateAuraSoundOption(1245421, true, 1245391, 1, 2)--Gloomfield (GTFO left by gloom)
mod:AddPrivateAuraSoundOption(1255612, true, 1244221, 1, 1)--Dread Breath Target
mod:AddPrivateAuraSoundOption(1255979, true, 1244221, 1, 1)--Dread Breath debuff
mod:AddPrivateAuraSoundOption(1265152, true, 1245645, 1, 1)--Impale (secondary attack of Rakfang)
mod:AddPrivateAuraSoundOption(1248865, true, 1248865, 1, 1)--Radiant Barrier
mod:AddPrivateAuraSoundOption(1270497, true, 1270497, 1, 1)--Shadowmark

mod.vb.beamCount = 0
mod.vb.howlCount = 0
mod.vb.gloomCount = 0
mod.vb.dreadCount = 0
mod.vb.flamesCount = 0
mod.vb.mawCount = 0
mod.vb.rakfangCount = 0
mod.vb.vaelwingCount = 0
mod.vb.cosmosisGloomCount = 0
mod.vb.cosmosisNullbeamCount = 0
mod.vb.cosmosisDreadBreathCount = 0
mod.vb.cosmosisVoidHowlCount = 0
mod.vb.radiantBarrierCount = 0

function mod:OnLimitedCombatStart()
	self.vb.beamCount = 0
	self.vb.howlCount = 0
	self.vb.gloomCount = 0
	self.vb.dreadCount = 0
	self.vb.flamesCount = 0
	self.vb.mawCount = 0
	self.vb.rakfangCount = 0
	self.vb.vaelwingCount = 0
	self.vb.cosmosisGloomCount = 0
	self.vb.cosmosisNullbeamCount = 0
	self.vb.cosmosisDreadBreathCount = 0
	self.vb.cosmosisVoidHowlCount = 0
	self.vb.radiantBarrierCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	specWarnNullBeam:SetAlert(101, "beamincoming", 19, 3)
	timerNullBeamCD:SetTimeline(101)
	specWarnVoidHowl:SetAlert(102, "range5", 2, 2)
	timerVoidHowlCD:SetTimeline(102)
	specWarnGloom:SetAlert(103, "gloomincoming", 19, 3)
	timerGloomCD:SetTimeline(103)
	specWarnDreadBreath:SetAlert(104, "breathsoon", 2, 3)
	timerDreadBreathCD:SetTimeline(104)
	specWarnMidnightFlames:SetAlert(105, "aesoon", 2, 2)
	timerMidnightFlamesCD:SetTimeline(105)
	if self:IsTank() then
		specWarnGrabblingMaw:SetAlert(219, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
		specWarnRakfang:SetAlert(220, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
		specWarnVaelwing:SetAlert(221, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
	end
	timerGrabblingMawCD:SetTimeline(219)
	timerRakfangCD:SetTimeline(220)
	timerVaelwingCD:SetTimeline(221)
	specWarnCosmosisGloom:SetAlert(377, "gloomincoming", 19, 3)
	timerCosmosisGloomCD:SetTimeline(377)
	specWarnCosmosisNullbeam:SetAlert(378, "beamincoming", 19, 3)
	timerCosmosisNullbeamCD:SetTimeline(378)
	specWarnCosmosisDreadBreath:SetAlert(379, "breathsoon", 19, 3)
	timerCosmosisDreadBreathCD:SetTimeline(379)
	specWarnCosmosisVoidHowl:SetAlert(380, "range5", 2, 2)
	timerCosmosisVoidHowlCD:SetTimeline(380)
	timerRadiantBarrierCD:SetTimeline(381)

	self:EnablePrivateAuraSound({1262999,1262676,1262656}, "beamyou", 19)--iffy sound choice, might change
	self:EnablePrivateAuraSound(1244672, "watchfeet", 8)
	self:EnablePrivateAuraSound(1252157, "debuffyou", 17)
	self:EnablePrivateAuraSound(1245554, "gloomyou", 19)
	self:EnablePrivateAuraSound(1270852, "debuffyou", 17)
	self:EnablePrivateAuraSound(1245421, "watchfeet", 8)
	self:EnablePrivateAuraSound(1255612, "targetyou", 2)--Maybe a more specific sound?
	self:EnablePrivateAuraSound(1255979, "fearyou", 19)
	self:EnablePrivateAuraSound({1248865,1249595}, "barrieryou", 19)
	self:EnablePrivateAuraSound(1270497, "shadowyou", 15)
	self:EnablePrivateAuraSound(1265152, "stunyou", 19)
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
