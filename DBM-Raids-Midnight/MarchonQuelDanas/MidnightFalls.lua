local mod	= DBM:NewMod(2740, "DBM-Raids-Midnight", 1, 1308)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214650)
mod:SetEncounterID(3183)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2913)

mod:RegisterCombat("combat")

--TODO, each rune might be a specific private aura. Although I suspect if we solve that, blizzard will disable PAs for it near immediately
--TODO, appropriate glaive audio
--TODO, midnight has an eventID but it seems a bit more passive (https://www.wowhead.com/spell=1266622/midnight 260)
--TODO, https://www.wowhead.com/spell=1284525/galvanize has event of 632 but I'm pretty sure it's just to flag personal announce (which alreaedy has PA)
--TODO, switch to https://www.wowhead.com/spell=1249609/dark-rune event if PAs get disabled (and they probably will be once players figure out which is which) ID 650
--TODO, add PAs for https://www.wowhead.com/beta/spell=1286294/grim-symphony and https://www.wowhead.com/beta/spell=1284984/grim-symphony ? they seem to overlap with dark runes though
--TODO, figure out which torchbearer is which. One is for player holding it and one is for standing near them i'm pretty sure
--TODO, do a thorough audit of private auras, timers, and alerts and remove what isn't actually used and eliminate redundancies or fix anything missing
local warnTotalEclipse				= mod:NewSpellAnnounce(1261871, 2)--Intermission 1.5 Start
local warnHeavensLance				= mod:NewCountAnnounce(1267049, 2)--Stage 1 tank ability

local specWarnDeathsDirge			= mod:NewSpecialWarningCount(1249620, nil, nil, nil, 2, 2)
local specWarnHeavensGlaives		= mod:NewSpecialWarningCount(1253915, nil, nil, nil, 2, 2)
local specWarnSafeguaredPrism		= mod:NewSpecialWarningSwitchCount(1251386, nil, nil, nil, 1, 2)
local specWarnShatteredSky			= mod:NewSpecialWarningCount(1249796, nil, nil, nil, 2, 2)
local specWarnLightSiphon			= mod:NewSpecialWarningCount(1266897, nil, nil, nil, 2, 2)--Stage 3 ability
local specWarnDarkConstellation		= mod:NewSpecialWarningCount(1266388, nil, nil, nil, 2, 2)--Stage 3 ability
local specWarnDarkArchangel			= mod:NewSpecialWarningCount(1250898, nil, nil, nil, 3, 2)--Stage 3 ability
local specWarnDeathsRequiem			= mod:NewSpecialWarningCount(1249619, nil, nil, nil, 2, 2)--Stage 3 ability
local specWarnSeverance				= mod:NewSpecialWarningCount(1276202, nil, nil, nil, 2, 2, 4)--Stage 3 mythic ability
local specWarnIntoDarkwell			= mod:NewSpecialWarningCount(1282047, nil, nil, nil, 2, 2)--Stage 2 Start
local specWarnCosmicFission			= mod:NewSpecialWarningCount(1282249, nil, nil, nil, 2, 2)--Stage 2 triggered ability (not timer one)
local specWarnCoreHarvest			= mod:NewSpecialWarningCount(1282412, nil, nil, nil, 2, 2)--Stage 2 ability
local specWarnDarkMeltdown			= mod:NewSpecialWarningCount(1281194, nil, nil, nil, 2, 2)--Stage 2 ability
local specWarnTerminationPrism		= mod:NewSpecialWarningSwitchCount(1284931, nil, nil, nil, 2, 2, 4)--Stage 1 Mythic version of Safeguarded Prism
local specWarnGrimSymphony			= mod:NewSpecialWarningCount(1284980, nil, nil, nil, 2, 2, 4)--Stage 1 Mythic version of DeathsDirge
local specWarnDarkQuasar			= mod:NewSpecialWarningCount(1279420, nil, nil, nil, 2, 2)--Stage 1 ability

local timerDeathsDirgeCD			= mod:NewCDCountTimer(20.5, 1249620, nil, nil, nil, 5)
local timerheavensGlaivesCD			= mod:NewCDCountTimer(20.5, 1253915, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSafeguaredPrismCD		= mod:NewCDCountTimer(20.5, 1251386, nil, nil, nil, 1)
local timerShatteredSkyCD			= mod:NewCDCountTimer(20.5, 1249796, nil, nil, nil, 2)
local timerTotalEclipseCD			= mod:NewCDTimer(60, 1261871, nil, nil, nil, 6)--Stage 1.5 intermisison start
local timerMidnightCD				= mod:NewCDCountTimer(60, 1263514, nil, nil, nil, 3)--iffy, Stage 3
local timerLightSiphonCD			= mod:NewCDCountTimer(20.5, 1266897, nil, nil, nil, 5)--Stage 3
local timerDarkConstellationCD		= mod:NewCDCountTimer(20.5, 1266388, nil, nil, nil, 3)--Stage 3
local timerDarkArchangelCD			= mod:NewCDCountTimer(20.5, 1250898, nil, nil, nil, 2)--Stage 3
local timerDeathsRequiemCD			= mod:NewCDCountTimer(20.5, 1249619, nil, nil, nil, 3)--Stage 3
local timerSeveranceCD				= mod:NewCDCountTimer(20.5, 1276202, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 3 mythic
local timerHeavensLanceCD			= mod:NewCDCountTimer(20.5, 1267049, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerIntoDarkwellCD			= mod:NewCDTimer(60, 1282047, nil, nil, nil, 6)--Stage 2 Start
local timerCoreHarvestCD			= mod:NewCDCountTimer(20.5, 1282412, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--Stage 2
local timerDarkMeltdownCD			= mod:NewCDCountTimer(20.5, 1281194, nil, nil, nil, 2)--Stage 2
local timerStarSplinterCD			= mod:NewCDCountTimer(20.5, 1282441, nil, nil, nil, 3)--Stage 1.5 intermission
local timerGalvanizeCD				= mod:NewCDCountTimer(20.5, 1284525, nil, nil, nil, 2)--Stage 2 Core ability (so maybe no timer?)
local timerTerminationPrismCD		= mod:NewCDCountTimer(20.5, 1284931, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 1 mythic
local timerGrimSymphonyCD			= mod:NewCDCountTimer(20.5, 1284980, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 1 mythic version of DeathsDirge
local timerDarkQuasarCD				= mod:NewCDCountTimer(20.5, 1279420, nil, nil, nil, 3)--Stage 1

mod:AddPrivateAuraSoundOption({1249609,1249565,1249566,1273133,1249550,1249558,1249562}, true, 1249620, 1, 2, "runeyou", 19)--Dark Rune (sub spell of Death's Dirge & Death's Requiem)
mod:AddPrivateAuraSoundOption(1263514, false, 1253915, 1, 2, "watchfeet", 8)--Midnight (could be spammy if group is poor and not using lightbearers well)
mod:AddPrivateAuraSoundOption(1284527, true, 1284525, 1, 1, "beamyou", 19)--Galvanize
mod:AddPrivateAuraSoundOption(1281184, true, 1284525, 1, 1, "scatter", 2)--Criticality (mythic Galvonize tertiary affect)
mod:AddPrivateAuraSoundOption({1279512,1285510}, true, 1282441, 1, 1, "runout", 2)--Starsplinter
mod:AddPrivateAuraSoundOption(1282470, true, 1279420, 1, 2, "watchfeet", 8)--Dark Quasar
mod:AddPrivateAuraSoundOption(1253031, true, 1253031, 1, 1, "dawncrystal", 19)--Glimmering (Holding Dawn Crystal)
mod:AddPrivateAuraSoundOption(1253770, true, 1250898, 1, 3, "safenow", 2)--Dawnlight barrier (needed to survive Archangel))
mod:AddPrivateAuraSoundOption(1262055, false, 1261871, 1, 3, "absorbyou", 19)--Eclipsed (Total Eclipse debuff)
mod:AddPrivateAuraSoundOption(1275429, true, 1276202, 1, 1, "moveright", 2)--Severance (right)
mod:AddPrivateAuraSoundOption(1266946, true, 1276202, 1, 1, "moveleft", 2)--Severance (left?)
--mod:AddPrivateAuraSoundOption({1266113,1266627{, true, 1266113, 1, 1, "torchyou", 2)--Torchbearer (Reundant with glimmering? or maybe buff players who get near person holding it get?)

mod.vb.deathCount = 0--Used for both Dirge and requiem
mod.vb.glaivesCount = 0
mod.vb.prismCount = 0
mod.vb.shatteredSkyCount = 0
mod.vb.midnightCount = 0
mod.vb.lightSiphonCount = 0
mod.vb.darkConstellationCount = 0
mod.vb.darkArchangelCount = 0
mod.vb.severanceCount = 0
mod.vb.heavensLanceCount = 0
mod.vb.harvestCount = 0
mod.vb.meltdownCount = 0
mod.vb.starSplinterCount = 0
mod.vb.galvanizeCount = 0
mod.vb.terminationPrismCount = 0
mod.vb.grimSymphonyCount = 0--Mythic version of Deaths Dirge, combine count if this is confirmed
mod.vb.darkQuasarCount = 0

---@param self DBMMod
local function setFallback(self)
	specWarnDeathsDirge:SetAlert(255, "runesincoming", 19, 4)
	timerDeathsDirgeCD:SetTimeline(255)
	specWarnHeavensGlaives:SetAlert(256, "watchstep", 2, 3)
	timerheavensGlaivesCD:SetTimeline(256)
	specWarnSafeguaredPrism:SetAlert(257, "targetchange", 2, 3)
	timerSafeguaredPrismCD:SetTimeline(257)
	specWarnShatteredSky:SetAlert(258, "aesoon", 2, 2)
	timerShatteredSkyCD:SetTimeline(258)
	warnTotalEclipse:SetAlert(259, "phasechange", 2, 1)
	timerTotalEclipseCD:SetTimeline(259)
	timerMidnightCD:SetTimeline(260)
	specWarnLightSiphon:SetAlert(261, "lightrifts", 19, 3)
	timerLightSiphonCD:SetTimeline(261)
	specWarnDarkConstellation:SetAlert(262, "watchstep", 2, 3)
	timerDarkConstellationCD:SetTimeline(262)
	specWarnDarkArchangel:SetAlert(263, "findshield", 2, 2)
	timerDarkArchangelCD:SetTimeline(263)
	specWarnDeathsRequiem:SetAlert(362, "runesincoming", 19, 4)
	timerDeathsRequiemCD:SetTimeline(362)
	specWarnSeverance:SetAlert(363, "raidsplit", 19, 4)
	timerSeveranceCD:SetTimeline(363)
	if self:IsTank() then
		warnHeavensLance:SetAlert(364, "defensive", 2, 2)
	end
	timerHeavensLanceCD:SetTimeline(364)
	specWarnIntoDarkwell:SetAlert(433, "pullin", 12, 2)
	timerIntoDarkwellCD:SetTimeline(433)
	specWarnCosmicFission:SetAlert(434, "pullin", 12, 2, 0)--Guessed. it's not on a timer it's triggered by players hitting cores
	specWarnCoreHarvest:SetAlert(435, "aesoon", 2, 2)
	timerCoreHarvestCD:SetTimeline(435)
	specWarnDarkMeltdown:SetAlert(436, "energyhigh", 2, 2)
	timerDarkMeltdownCD:SetTimeline(436)
	timerStarSplinterCD:SetTimeline(437)
	timerGalvanizeCD:SetTimeline(632)
	specWarnTerminationPrism:SetAlert(636, "targetchange", 2, 3)
	timerTerminationPrismCD:SetTimeline(636)
	specWarnGrimSymphony:SetAlert(644, "runesincoming", 19, 4)
	timerGrimSymphonyCD:SetTimeline(644)
	specWarnDarkQuasar:SetAlert(649, "watchstep", 2, 3)
	timerDarkQuasarCD:SetTimeline(649)
end

function mod:OnLimitedCombatStart(delay)
	self.vb.deathCount = 1
	self.vb.glaivesCount = 1
	self.vb.prismCount = 1
	self.vb.shatteredSkyCount = 1
	self.vb.midnightCount = 1
	self.vb.lightSiphonCount = 1
	self.vb.darkConstellationCount = 1
	self.vb.darkArchangelCount = 1
	self.vb.severanceCount = 1
	self.vb.heavensLanceCount = 1
	self.vb.harvestCount = 1
	self.vb.meltdownCount = 1
	self.vb.starSplinterCount = 1
	self.vb.galvanizeCount = 1
	self.vb.terminationPrismCount = 1
	self.vb.grimSymphonyCount = 1
	self.vb.darkQuasarCount = 1
	--Hardcode features first
	--if DBM.Options.HardcodedTimer and self:IsEasy() and not badStateDetected then
	--	self:IgnoreBlizzardAPI()
	--	self:RegisterShortTermEvents(
	--		"ENCOUNTER_TIMELINE_EVENT_ADDED",
	--		"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
	--	)
	--else
		setFallback(self)
	--end
	DBM:AddMsg("This boss was untested on beta and much is guessed based on datamined info and journal. A full complete mod will be made after release")
end
