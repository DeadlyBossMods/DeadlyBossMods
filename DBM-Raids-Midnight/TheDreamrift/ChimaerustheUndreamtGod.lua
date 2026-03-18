local mod	= DBM:NewMod(2795, "DBM-Raids-Midnight", 2, 1314)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(256116)
mod:SetEncounterID(3306)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2939)

mod:RegisterCombat("combat")

--mod:RegisterEventsInCombat(
--	"ENCOUNTER_TIMELINE_EVENT_ADDED"
--)


--NOTE, https://www.wowhead.com/spell=1245771/corrupted-feathers has event ID ono boss but isn't in journal, possibly pre boss trash mechanic
--NOTE, https://www.wowhead.com/spell=1262616/retched-acid not in journal (208)
--NOTE, https://www.wowhead.com/spell=1280127/stage-two also exists, but based on most recent testing blizzard uses consume for p2 and not this bar anymore
local specWarnRavenousDive				= mod:NewSpecialWarningCount(1245404, nil, nil, nil, 2, 2)
local specWarnRiftEmergence				= mod:NewSpecialWarningCount(1251021, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnCausticPhlegm				= mod:NewSpecialWarningCount(1246621, nil, nil, nil, 2, 2)
local specWarnRendingTear				= mod:NewSpecialWarningDodgeCount(1272726, nil, nil, DBM_COMMON_L.FRONTAL, 2, 2)
local specWarnCorruptedDevastation		= mod:NewSpecialWarningDodgeCount(1245452, nil, nil, nil, 2, 2)
local specWarnFearsomecry				= mod:NewSpecialWarningInterrupt(1249017, "HasInterrupt", nil, nil, 1, 2)--Add alert
local specWarnDiscordantRoar			= mod:NewSpecialWarningCount(1245451, false, nil, nil, 2, 2)--Add alert (evalulate default by cast frequency)
local specWarnAlndustUpheaval			= mod:NewSpecialWarningSoakCount(1262289, nil, nil, nil, 2, 2)
local specWarnConsume					= mod:NewSpecialWarningCount(1245396, nil, nil, nil, 2, 2)
local specWarnCannibalized				= mod:NewSpecialWarningSpell(1245844, nil, nil, nil, 1, 2)--Basically screwing up the add killing
mod:GroupSpells(1245396, 1245844)--Group Cannibalized with Consume

local timerRavenousDiveCD				= mod:NewCDCountTimer(20.5, 1245404, nil, nil, nil, 6)--Stage 1 bar
local timerRiftEmergenceCD				= mod:NewCDCountTimer(20.5, 1251021, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerCausticPhlegmCD				= mod:NewCDCountTimer(20.5, 1246621, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2)
local timerRendingTearCD				= mod:NewCDCountTimer(20.5, 1272726, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 3)
local timerCorruptedDevastationCD		= mod:NewCDCountTimer(20.5, 1245452, nil, nil, nil, 3)
--local timerFearsomecryCD				= mod:NewCDCountTimer(20.5, 1249017, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerConsumingMiasmaCD			= mod:NewCDCountTimer(20.5, 1257087, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerAlndustUpheavalCD			= mod:NewCDCountTimer(20.5, 1262289, nil, nil, nil, 5)
local timerRiftCataclysmCD				= mod:NewCDCountTimer(20.5, 1260088, nil, nil, nil, 6)--12min berserk
local timerRiftMadnessCD				= mod:NewCDCountTimer(20.5, 1264780, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerConsumeCD					= mod:NewCDCountTimer(20.5, 1245396, nil, nil, nil, 6)--Stage 2 bar

mod:AddPrivateAuraSoundOption(1272726, true, 1272726, 1, 1)--Rending Tear
mod:AddPrivateAuraSoundOption(1257087, true, 1257087, 1, 1)--Consuming Miasma
mod:AddPrivateAuraSoundOption(1245698, true, 1262289, 1, 2)--Alnsight (can also use https://www.wowhead.com/spell=1253744/rift-vulnerability)
mod:AddPrivateAuraSoundOption(1264756, true, 1264780, 1, 1)--Rift Madness (initial target)
--mod:AddPrivateAuraSoundOption(1264780, true, 1264780, 1, 1)--Rift Madness (standing in the soak?)
--https://www.wowhead.com/beta/spell=1264757/rift-madness another rift madness, not sure what to include yet beyond initial
mod:AddPrivateAuraSoundOption(1258192, false, 1258192, 1, 1)--Lingering Miasma
mod:AddPrivateAuraSoundOption(1265940, true, 1249017, 1, 1)--Fearsome Cry
mod:AddPrivateAuraSoundOption(1250953, false, 1250953, 1, 1)--Rift Sickness

mod.vb.diveCount = 0
mod.vb.riftCount = 0
mod.vb.phlegmCount = 0
mod.vb.tearCount = 0
mod.vb.devastationCount = 0
mod.vb.miasmaCount = 0
mod.vb.upheavalCount = 0
mod.vb.riftMadnessCount = 0
mod.vb.consumeCount = 0

function mod:OnLimitedCombatStart()
	self.vb.diveCount = 0
	self.vb.riftCount = 0
	self.vb.phlegmCount = 0
	self.vb.tearCount = 0
	self.vb.devastationCount = 0
	self.vb.miasmaCount = 0
	self.vb.upheavalCount = 0
	self.vb.riftMadnessCount = 0
	self.vb.consumeCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	specWarnRavenousDive:SetAlert(48, "phasechange", 2, 3)
	timerRavenousDiveCD:SetTimeline(48)
	specWarnRiftEmergence:SetAlert(49, "mobsoon", 2, 2)
	timerRiftEmergenceCD:SetTimeline(49)
	specWarnCausticPhlegm:SetAlert(50, "aesoon", 2, 2)
	timerCausticPhlegmCD:SetTimeline(50)
	specWarnRendingTear:SetAlert(51, "frontal", 15, 2)
	timerRendingTearCD:SetTimeline(51)
	specWarnCorruptedDevastation:SetAlert({53,458}, "breathsoon", 2, 2)
	timerCorruptedDevastationCD:SetTimeline({53,458})
	specWarnFearsomecry:SetAlert(117, "kickcast", 1, 2, 0)--Needs vetting, it's an add ability but has event Id, so it might fire an ECOUNTER_WARNING based on blizz set conditionals
	specWarnDiscordantRoar:SetAlert(118, "aesoon", 2, 2, 0)--^
	timerConsumingMiasmaCD:SetTimeline(119)
	specWarnAlndustUpheaval:SetAlert({149,431}, "soakincoming", 19, 2)--Can't count casts with blizz API, but hardcode will be able to use group1 and group 2 soak sounds
	timerAlndustUpheavalCD:SetTimeline({149,431})
	timerRiftCataclysmCD:SetTimeline(170)
	timerRiftMadnessCD:SetTimeline(217)
	specWarnConsume:SetAlert(307, "phasechange", 2, 3)
	timerConsumeCD:SetTimeline(307)
	specWarnCannibalized:SetAlert(555, "stilldanger", 1, 2, 0)

	self:EnablePrivateAuraSound(1272726, "bleedyou", 19)
	self:EnablePrivateAuraSound(1257087, "movetopool", 15)
	self:EnablePrivateAuraSound(1245698, "riftyou", 19)
	self:EnablePrivateAuraSound(1264756, "debuffyou", 17)--TODO, better custom voice?
--	self:EnablePrivateAuraSound(1264780, "debuffyou", 17)
	self:EnablePrivateAuraSound(1258192, "dotyou", 19)
	self:EnablePrivateAuraSound(1265940, "fearyou", 19)
	self:EnablePrivateAuraSound(1250953, "absorbyou", 19)
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
