local mod	= DBM:NewMod(2740, "DBM-Raids-Midnight", 1, 1308)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214650)
mod:SetEncounterID(3183)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2913)

mod:RegisterCombat("combat")

--TODO, each rune might be a specific private aura. Although I suspect if we solve that, blizzard will disable PAs for it near immediately
--TODO, midnight has an eventID but it seems a bit more passive (https://www.wowhead.com/spell=1266622/midnight 260)
--TODO, https://www.wowhead.com/spell=1284525/galvanize has event of 632 but I'm pretty sure it's just to flag personal announce (which alreaedy has PA)
--TODO, switch to https://www.wowhead.com/spell=1249609/dark-rune event if PAs get disabled (and they probably will be once players figure out which is which) ID 650
--TODO, add PAs for https://www.wowhead.com/beta/spell=1286294/grim-symphony and https://www.wowhead.com/beta/spell=1284984/grim-symphony ? they seem to overlap with dark runes though
--TODO, figure out which torchbearer is which. One is for player holding it and one is for standing near them i'm pretty sure
local warnTotalEclipse				= mod:NewSpellAnnounce(1261871, 2)--Intermission 1.5 Start

local specWarnHeavensLance			= mod:NewSpecialWarningCount(1267049, nil, nil, nil, 1, 2)--Stage 1 tank ability
local specWarnDeathsDirge			= mod:NewSpecialWarningCount(1249620, nil, nil, L.MemoryGame, 2, 2)
local specWarnHeavensGlaives		= mod:NewSpecialWarningCount(1253915, nil, 289465, nil, 2, 2)
local specWarnSafeguaredPrism		= mod:NewSpecialWarningSwitchCount(1251386, nil, nil, DBM_COMMON_L.INTERRUPTS, 1, 2)
local specWarnShatteredSky			= mod:NewSpecialWarningCount(1249796, nil, nil, nil, 2, 2)
local specWarnLightSiphon			= mod:NewSpecialWarningCount(1266897, nil, nil, nil, 2, 2)--Stage 3 ability
local specWarnDarkConstellation		= mod:NewSpecialWarningCount(1266388, nil, nil, nil, 2, 2)--Stage 3 ability
local specWarnDarkArchangel			= mod:NewSpecialWarningCount(1250898, nil, nil, nil, 3, 2)--Stage 3 ability
local specWarnDeathsRequiem			= mod:NewSpecialWarningCount(1249619, nil, nil, L.MemoryGame, 2, 2)--Stage 3 ability
local specWarnSeverance				= mod:NewSpecialWarningCount(1276202, nil, nil, nil, 2, 2, 4)--Stage 3 mythic ability
local specWarnIntoDarkwell			= mod:NewSpecialWarningSpell(1282047, nil, nil, nil, 2, 2)--Stage 2 Start
local specWarnCosmicFission			= mod:NewSpecialWarningCount(1282249, nil, nil, nil, 2, 2)--Stage 2 triggered ability (not timer one)
local specWarnCoreHarvest			= mod:NewSpecialWarningCount(1282412, nil, nil, nil, 2, 2)--Stage 2 ability
local specWarnDarkMeltdown			= mod:NewSpecialWarningSpell(1281194, nil, nil, nil, 2, 2)--Stage 2 End
local specWarnTerminationPrism		= mod:NewSpecialWarningSwitchCount(1284931, nil, nil, DBM_COMMON_L.INTERRUPTS, 2, 2, 4)--Stage 1 Mythic version of Safeguarded Prism
local specWarnGrimSymphony			= mod:NewSpecialWarningCount(1284980, nil, nil, L.MemoryGame, 2, 2, 4)--Stage 1 Mythic version of DeathsDirge
local specWarnDarkQuasar			= mod:NewSpecialWarningCount(1279420, nil, 207544, nil, 2, 2)--Stage 1 ability

local timerDeathsDirgeCD			= mod:NewCDCountTimer(20.5, 1249620, L.MemoryGame.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerHeavensGlaivesCD			= mod:NewCDCountTimer(20.5, 1253915, 289465, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Shortnmae "Glaives"
local timerSafeguaredPrismCD		= mod:NewCDCountTimer(20.5, 1251386, DBM_COMMON_L.INTERRUPTS.." (%s)", nil, 2, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerShatteredSkyCD			= mod:NewCDCountTimer(20.5, 1249796, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerTotalEclipseCD			= mod:NewCDTimer(60, 1261871, DBM_COMMON_L.INTERMISSION, nil, nil, 6, nil, DBM_COMMON_L.IMPORTANT_ICON)--Stage 1.5 intermisison start
local timerLightSiphonCD			= mod:NewCDCountTimer(20.5, 1266897, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 5)--Stage 3
local timerDarkConstellationCD		= mod:NewCDCountTimer(20.5, 1266388, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Stage 3
local timerDarkArchangelCD			= mod:NewCDCountTimer(20.5, 1250898, nil, nil, 2, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Stage 3
local timerDeathsRequiemCD			= mod:NewCDCountTimer(20.5, 1249619, L.MemoryGame.." (%s)", nil, nil, 3)--Stage 3
local timerSeveranceCD				= mod:NewCDCountTimer(20.5, 1276202, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 3 mythic
local timerHeavensLanceCD			= mod:NewCDCountTimer(20.5, 1267049, 361324, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Shortname Lance
local timerIntoDarkwellCD			= mod:NewCDTimer(60, 1282047, nil, nil, nil, 6, nil, DBM_COMMON_L.IMPORTANT_ICON)--Stage 2 Start
local timerCoreHarvestCD			= mod:NewCDCountTimer(20.5, 1282412, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--Stage 2
local timerDarkMeltdownCD			= mod:NewCDTimer(20.5, 1281194, 1273378, nil, nil, 2)--Stage 2 (timer for stage 3 begin). Shorttest "Stage Three"
local timerStarSplinterCD			= mod:NewCDCountTimer(20.5, 1282441, nil, nil, nil, 3)--Stage 1.5 intermission
local timerGalvanizeCD				= mod:NewCDCountTimer(20.5, 1284525, nil, nil, nil, 2)--Stage 2 Core ability (so maybe no timer?)
local timerTerminationPrismCD		= mod:NewCDCountTimer(20.5, 1284931, DBM_COMMON_L.INTERRUPTS.." (%s)", nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 1 mythic
local timerGrimSymphonyCD			= mod:NewCDCountTimer(20.5, 1284980, L.MemoryGame.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)--Stage 1 mythic version of DeathsDirge
local timerDarkQuasarCD				= mod:NewCDCountTimer(20.5, 1279420, 207544, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Stage 1 (shortname "Beams")

mod:AddPrivateAuraSoundOption({1249609,1249565,1249566,1273133,1249550,1249558,1249562}, true, 1249620, 1, 2, "runeyou", 19)--Dark Rune (sub spell of Death's Dirge & Death's Requiem)
mod:AddPrivateAuraSoundOption(1263514, false, 1253915, 1, 2, "watchfeet", 8)--Midnight (could be spammy if group is poor and not using lightbearers well)
mod:AddPrivateAuraSoundOption(1284527, true, 1284525, 1, 1, "beamyou", 19)--Galvanize
mod:AddPrivateAuraSoundOption(1281184, true, 1284525, 1, 1, "scatter", 2)--Criticality (mythic Galvonize tertiary affect)
mod:AddPrivateAuraSoundOption({1279512,1285510}, true, 1282441, 1, 1, "runout", 2)--Starsplinter
mod:AddPrivateAuraSoundOption(1282470, true, 1279420, 1, 2, "watchfeet", 8)--Dark Quasar
mod:AddPrivateAuraSoundOption(1253031, true, 1253031, 1, 1, "dawncrystal", 19)--Glimmering (Holding Dawn Crystal)
mod:AddPrivateAuraSoundOption(1253770, false, 1250898, 1, 3, "safenow", 2)--Dawnlight barrier (needed to survive Archangel))
mod:AddPrivateAuraSoundOption(1262055, false, 1261871, 1, 3, "absorbyou", 19)--Eclipsed (Total Eclipse debuff)
mod:AddPrivateAuraSoundOption(1275429, true, 1276202, 1, 1, "moveright", 2)--Severance (right)
mod:AddPrivateAuraSoundOption(1266946, true, 1276202, 1, 1, "moveleft", 2)--Severance (left?)
--mod:AddPrivateAuraSoundOption({1266113,1266627{, true, 1266113, 1, 1, "torchyou", 2)--Torchbearer (Reundant with glimmering? or maybe buff players who get near person holding it get?)
mod:AddPrivateAuraSoundOption(1276527, true, 1276527, 1, 1, "debuffyou", 17)--Heaven and Hell (secret Mythic phase 4 mechanic) (customize sound later)

mod.vb.deathCount = 0--Used for both Dirge and requiem
mod.vb.glaivesCount = 0
mod.vb.prismCount = 0
mod.vb.shatteredSkyCount = 0
mod.vb.lightSiphonCount = 0
mod.vb.darkConstellationCount = 0
mod.vb.darkArchangelCount = 0
mod.vb.severanceCount = 0
mod.vb.heavensLanceCount = 0
mod.vb.harvestCount = 0
mod.vb.starSplinterCount = 0
mod.vb.galvanizeCount = 0
mod.vb.terminationPrismCount = 0
mod.vb.grimSymphonyCount = 0--Mythic version of Deaths Dirge, combine count if this is confirmed
mod.vb.darkQuasarCount = 0
local badStateDetected = false
local ignoreInitialBuggedSet = true
local stage1SeventySlot = 0
local stage2ThirtySlot = 0
local totalEclipseStartTimes = {}
local totalEclipseExpected = 180

---@param self DBMMod
local function setFallback(self)
	specWarnDeathsDirge:SetAlert(255, "runesincoming", 19, 4)
	timerDeathsDirgeCD:SetTimeline(255)
	specWarnHeavensGlaives:SetAlert(256, "watchstep", 2, 3)
	timerHeavensGlaivesCD:SetTimeline(256)
	specWarnSafeguaredPrism:SetAlert(257, "targetchange", 2, 3)
	timerSafeguaredPrismCD:SetTimeline(257)
	specWarnShatteredSky:SetAlert(258, "aesoon", 2, 2)
	timerShatteredSkyCD:SetTimeline(258)
	warnTotalEclipse:SetAlert(259, "phasechange", 2, 1)
	timerTotalEclipseCD:SetTimeline(259)
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
		specWarnHeavensLance:SetAlert(364, "defensive", 2, 2)
	end
	timerHeavensLanceCD:SetTimeline(364)
	specWarnIntoDarkwell:SetAlert(433, "pullin", 12, 2)
	timerIntoDarkwellCD:SetTimeline(433)
	specWarnCosmicFission:SetAlert(434, "pullin", 12, 2, 0)--Guessed. it's not on a timer it's triggered by players hitting cores
	specWarnCoreHarvest:SetAlert(435, "farfromline", 2, 2)
	timerCoreHarvestCD:SetTimeline(435)
	specWarnDarkMeltdown:SetAlert(436, "carefly", 2, 2)
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
	self:TLCountReset()
	self:SetStage(1)
	self.vb.deathCount = 1
	self.vb.glaivesCount = 1
	self.vb.prismCount = 1
	self.vb.shatteredSkyCount = 1
	self.vb.lightSiphonCount = 1
	self.vb.darkConstellationCount = 1
	self.vb.darkArchangelCount = 1
	self.vb.severanceCount = 1
	self.vb.heavensLanceCount = 1
	self.vb.harvestCount = 1
	self.vb.starSplinterCount = 1
	self.vb.galvanizeCount = 1
	self.vb.terminationPrismCount = 1
	self.vb.grimSymphonyCount = 1
	self.vb.darkQuasarCount = 1
	ignoreInitialBuggedSet = true
	stage1SeventySlot = 0
	stage2ThirtySlot = 0
	totalEclipseStartTimes = {}
	if DBM.Options.HardcodedTimer and self:IsDifficulty("lfr", "normal", "heroic") and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		setFallback(self)
	end
end

function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	local function setStage15IfNeeded(self)
		if self:GetStage(1.5, 1) then
			self:SetStage(1.5)
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersAll(self, timer, timerExact, eventID)
		if ignoreInitialBuggedSet then
			if timer == 180 then
				ignoreInitialBuggedSet = false
			end
			return
		end

		local handled = false
		local stage = self:GetStage()
		if stage == 1 then
			if timer == 10 then
				timerDeathsDirgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathsDirge", "deathCount"))
				handled = true
			elseif timer == 20 then
				timerHeavensLanceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "heavensLance", "heavensLanceCount"))
				handled = true
			elseif timer == 35 then
				timerHeavensGlaivesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "heavensGlaives", "glaivesCount"))
				handled = true
			elseif timer == 40 then
				timerDarkQuasarCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkQuasar", "darkQuasarCount"))
				handled = true
			elseif timer == 45 then
				timerIntoDarkwellCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "intoDarkwell"))
				setStage15IfNeeded(self)--Into the Darkwell is stage 1.5 intermission timer start
				handled = true
			elseif timer == 55 then
				timerSafeguaredPrismCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "safeguardPrism", "prismCount"))
				handled = true
			elseif timer == 70 then
				stage1SeventySlot = stage1SeventySlot + 1
				local slot = ((stage1SeventySlot - 1) % 4) + 1
				if slot == 1 then
					timerDeathsDirgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathsDirge", "deathCount"))
				elseif slot == 2 then
					timerHeavensGlaivesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "heavensGlaives", "glaivesCount"))
				elseif slot == 3 then
					timerDarkQuasarCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkQuasar", "darkQuasarCount"))
				else
					timerSafeguaredPrismCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "safeguardPrism", "prismCount"))
				end
				handled = true
			elseif timer == 180 then
				timerTotalEclipseCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "totalEclipse"))
				totalEclipseStartTimes[eventID] = GetTime()
				handled = true
			end
		elseif stage == 1.5 then
			if timer == 97 then
				timerDarkMeltdownCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkMeltdown"))
				if self:GetStage(2, 1) then--Dark Meltdown start marks stage 2 start
					self:SetStage(2)
				end
				handled = true
			end
		elseif stage == 2 then
			if timer == 13 then
				timerGalvanizeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "galvanize", "galvanizeCount"))
				handled = true
			elseif timer == 20 then
				timerHeavensLanceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "heavensLance", "heavensLanceCount"))
				handled = true
			elseif timer == 30 then
				stage2ThirtySlot = stage2ThirtySlot + 1
				if stage2ThirtySlot % 2 == 1 then
					timerGalvanizeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "galvanize", "galvanizeCount"))
				else
					timerCoreHarvestCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coreHarvest", "harvestCount"))
				end
				handled = true
			elseif timer == 33 then
				timerCoreHarvestCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coreHarvest", "harvestCount"))
				handled = true
			end
		elseif stage == 3 then
			if timer == 14 or timer == 38 then
				timerDarkArchangelCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkArchangel", "darkArchangelCount"))
				handled = true
			elseif timer == 23 then
				timerHeavensLanceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "heavensLance", "heavensLanceCount"))
				handled = true
			elseif timer == 31 then
				timerLightSiphonCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "lightSiphon", "lightSiphonCount"))
				handled = true
			elseif timer == 33 then
				timerDarkConstellationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkConstellation", "darkConstellationCount"))
				handled = true
			elseif timer == 180 then
				timerShatteredSkyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "shatteredSky", "shatteredSkyCount"))
				handled = true
			end
		end

		if not handled then
			if not DBM.Options.DebugMode then
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end

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
			if eventType == "totalEclipse" then
				totalEclipseStartTimes[eventID] = nil
				setStage15IfNeeded(self)
				warnTotalEclipse:Show()
				return
			elseif eventType == "intoDarkwell" then
				setStage15IfNeeded(self)
				specWarnIntoDarkwell:Show()
				specWarnIntoDarkwell:Play("pullin")
				return
			elseif eventType == "darkMeltdown" then
				if self:GetStage(3, 1) then
					self:SetStage(3)
				end
				specWarnDarkMeltdown:Show()
				specWarnDarkMeltdown:Play("carefly")
			end
			if not eventCount then return end
			if eventType == "deathsDirge" then
				specWarnDeathsDirge:Show(eventCount)
				specWarnDeathsDirge:Play("runesincoming")
			elseif eventType == "heavensGlaives" then
				specWarnHeavensGlaives:Show(eventCount)
				specWarnHeavensGlaives:Play("watchstep")
			elseif eventType == "safeguardPrism" then
				specWarnSafeguaredPrism:Show(eventCount)
				specWarnSafeguaredPrism:Play("targetchange")
			elseif eventType == "shatteredSky" then
				specWarnShatteredSky:Show(eventCount)
				specWarnShatteredSky:Play("aesoon")
			elseif eventType == "lightSiphon" then
				specWarnLightSiphon:Show(eventCount)
				specWarnLightSiphon:Play("lightrifts")
			elseif eventType == "darkConstellation" then
				specWarnDarkConstellation:Show(eventCount)
				specWarnDarkConstellation:Play("watchstep")
			elseif eventType == "darkArchangel" then
				specWarnDarkArchangel:Show(eventCount)
				specWarnDarkArchangel:Play("findshield")
			elseif eventType == "heavensLance" then
				if self:IsTanking("player", "boss1", nil, true) then
					specWarnHeavensLance:Show(eventCount)
					specWarnHeavensLance:Play("defensive")
				elseif self:IsTank() then
					specWarnHeavensLance:Schedule(5, eventCount)
					specWarnHeavensLance:ScheduleVoice(5, "tauntboss")
				end
			elseif eventType == "coreHarvest" then
				specWarnCoreHarvest:Show(eventCount)
				specWarnCoreHarvest:Play("farfromline")
			elseif eventType == "galvanize" then
				--No direct special warning currently used for Galvanize in this mod
			elseif eventType == "darkQuasar" then
				specWarnDarkQuasar:Show(eventCount)
				specWarnDarkQuasar:Play("watchstep")
			end
		elseif eventState == 3 then
			local eclipseStart = totalEclipseStartTimes[eventID]
			if eclipseStart then
				local elapsed = GetTime() - eclipseStart
				if math.abs(elapsed - totalEclipseExpected) <= 1 then
					local eventType = self:TLCountFinish(eventID)
					if eventType == "totalEclipse" then
						totalEclipseStartTimes[eventID] = nil
						setStage15IfNeeded(self)
						warnTotalEclipse:Show()
						return
					end
				end
			end
			local eventType = self:TLCountCancel(eventID)
			if not eventType then return end
			if eventType == "totalEclipse" then
				totalEclipseStartTimes[eventID] = nil
			end
		end
	end
end
