local mod	= DBM:NewMod(2895, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(257758, 268956)--Ula'tek has two IDs?
mod:SetEncounterID(3492)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

--TODO, threat based moher's wrath in hardcode, maybe disable hobbled sound if redundant/similtanious
--TODO, cull unused timers and warnings, like Fury Unleashed?
--TODO, which Gore Rattle id does TL use, does it use both? https://www.wowhead.com/spell=1304527/gore-rattle
--TODO, same with https://www.wowhead.com/spell=1311037/mothers-wrath and https://www.wowhead.com/spell=1287265/spectral-coils as gore rattle
--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
--local warnSerpentsBite					= mod:NewCountAnnounce(1295905, 2)--Hardcode only

local specWarnMothersWrath				= mod:NewSpecialWarningDefensive(1298367, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnRageoftheShackled			= mod:NewSpecialWarningCount(1286860, nil, nil, nil, 2, 2, nil, nil, "aesoon")
local specWarnCausticWaves				= mod:NewSpecialWarningCount(1292188, nil, nil, nil, 2, 2, nil, nil, "watchwave")
local specWarnFuryUnleashed				= mod:NewSpecialWarningCount(1286905, nil, nil, nil, 3, 2, nil, nil, "stilldanger")--Stage 3 berserk?
local specWarnGoreRattle				= mod:NewSpecialWarningSwitchCount(1298559, nil, nil, nil, 1, 2, nil, nil, "bigmob")
local specWarnToxicIncubation			= mod:NewSpecialWarningCount(1299757, nil, nil, nil, 2, 2, 4, nil, "helpsoak")--Is it a soak though?
local specWarnSpectralCoils				= mod:NewSpecialWarningCount(1300530, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Used by Gore Rattle
local specWarnCalloftheSerpent			= mod:NewSpecialWarningCount(1300751, nil, nil, nil, 1, 2, nil, nil, "mobsoon")
local specWarnCirclingPrey				= mod:NewSpecialWarningRunCount(1301510, nil, nil, nil, 2, 2, nil, nil, "justrun")
local specWarnVirulentSpit				= mod:NewSpecialWarningDodgeCount(1302982, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnMephiticThrash			= mod:NewSpecialWarningDodgeCount(1296301, nil, nil, nil, 2, 2, nil, nil, "aesoon")--Used by Gore Rattle
local specWarnSubmerge					= mod:NewSpecialWarningCount(1292999, nil, nil, nil, 2, 2, nil, nil, "phasechange")

local timerMothersWrathCD				= mod:NewCDCountTimer(20.5, 1298367, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRageoftheShackledCD			= mod:NewCDCountTimer(20.5, 1286860, nil, nil, nil, 2)
local timerCausticWavesCD				= mod:NewCDCountTimer(20.5, 1292188, nil, nil, nil, 3)
local timerFuryUnleashedCD				= mod:NewCDCountTimer(20.5, 1286905, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGoreRattleCD					= mod:NewCDCountTimer(20.5, 1298559, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSerpentsBiteCD				= mod:NewCDCountTimer(20.5, 1295905, nil, nil, nil, 3)
local timerToxicIncubationCD			= mod:NewCDCountTimer(20.5, 1299757, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSpectralCoilsCD				= mod:NewCDCountTimer(20.5, 1300530, nil, nil, nil, 5)
local timerCalloftheSerpentCD			= mod:NewCDCountTimer(20.5, 1300751, nil, nil, nil, 1)
local timerCirclingPreyCD				= mod:NewCDCountTimer(20.5, 1301510, nil, nil, nil, 2)
local timerVirulentSpitCD				= mod:NewCDCountTimer(20.5, 1302982, nil, nil, nil, 3)
local timerMephiticThrashCD				= mod:NewCDCountTimer(20.5, 1296301, nil, nil, nil, 2)
local timerSubmergeCD					= mod:NewCDCountTimer(20.5, 1292999, nil, nil, nil, 6)

--local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddAuraSoundOption(1300938, true, 1298367, 1, 3, "slowyou", 20, 0)--Hobbled
mod:AddAuraSoundOption(1292403, true, 1292188, 1, 3, "dotyou", 19, 0)--Caustic Wave Dot
mod:AddAuraSoundOption(1300685, true, 1300530, 1, 3, "debuffyou", 17, 0)--Soul Constrictor (can't soak Spectral Coils)
mod:AddAuraSoundOption(1293046, true, 1295905, 1, 1, "gathershare", 2, 0)--Serpent's Bite (targeted)
--mod:AddAuraSoundOption(1288879, true, 1295905, 1, 1, "gathershare", 2, 0)--Serpent's Bite (dot) (use if pre target spell aura doesn't work)
mod:AddAuraSoundOption(1306119, true, 1295905, 1, 3, "stunyou", 19, 0)--Calcified Corpse. Failed to clear Serpent's Bite
mod:AddAuraSoundOption(1312967, true, 1295905, 1, 1, "runout", 2, 0)--Volatile Purge (serpent's bite share debuff)
mod:AddAuraSoundOption(1302842, false, 1299757, 1, 3, "stackhigh", 6, 1)--Toxic Burn (may be spammy if rapid soaked, warns at 2+ stacks)
mod:AddAuraSoundOption(1301800, "RemovePoison", 1300751, 1, 3, "poisonyou", 20, 0)--Acidic Burst (Blightscale Viper adds debuffs)
mod:AddAuraSoundOption(1305163, true, 1300751, 1, 1, "runout", 2, 0)--Petrifying Sting (Target). Used by Blightscale Viper
mod:AddAuraSoundOption(1303414, true, 1300751, 1, 3, "stunyou", 2, 0)--Petrifying Sting (Got hit by it)
mod:AddAuraSoundOption(1295360, true, -35864, 1, 3, "eggyou", 20, 0)--Malignant Shell (non mythic)
mod:AddAuraSoundOption(1307612, true, -35864, 1, 3, "eggyou", 20, 0)--Noxious Shell (mythic)
mod:AddAuraSoundOption(1312150, true, -35864, 1, 3, "debuffyou", 17, 0)--Rancid Yolk
mod:AddAuraSoundOption(1301268, "Dps", -35864, 1, 3, "targetchange", 2, 0)--Putrid Membrane means a Blightscale Viper has spawned
mod:AddAuraSoundOption(1300312, true, -37007, 1, 3, "eggyou", 20, 0)--Doomscale Shell
mod:AddAuraSoundOption(1305775, true, -37007, 1, 3, "stunyou", 19, 0)--Dread Roar
mod:AddAuraSoundOption(1305650, true, -37007, 1, 3, "stunyou", 19, 0)--Agnuished Cry
mod:AddAuraSoundOption(1301118, true, -36292, 1, 1, "targetyou", 2, 0)--Grasping Fangs (targeted)
mod:AddAuraSoundOption(1311611, true, -36292, 1, 3, "slowyou", 20, 0)--Grasping Fangs (got hit by it) (maybe change to "break chain" or something?
mod:AddAuraSoundOption(1311602, true, -36292, 1, 3, "dotyou", 19, 0)--Blight Vein (broke Grasping Fangs)

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local stage1SixtyTwoCount = 0--Normal: Call of the Serpent then Mother's Wrath share the exact 62s opening slot
local lfrStage1SeventyCount = 0--LFR: Call of the Serpent, Spectral Coils, then Caustic Waves share the exact 70s slot
local lfrStage3FortyCount = 0--LFR stage 3: Circling Prey, Submerge, then Circling Prey share the exact 40s slot
local lfrStage3FortySixCount = 0--LFR stage 3: Call of the Serpent then Caustic Waves share the exact 46s slot
local lfrStage3FiftyCount = 0--LFR stage 3: Circling Prey then Submerge share the exact 50s slot
local heroicStage1FiftyTwoCount = 0--Heroic: Mephitic Thrash then Caustic Waves share the exact 52s opening slot
local heroicStage3SixtyCount = 0--Heroic stage 3: Call of the Serpent then Submerge share the exact 60s slot
local stage2Pending = false--Opening Rage completion arms the boss1 targetability-loss transition into stage 2
local stage3ScheduledEvents = {}
local lfrStage3Batch = {}
local lfrStage3BatchScheduled = false
local heroicStage3Batch = {}
local heroicStage3BatchScheduled = false
local resetLFRStage3Batch
local resetHeroicStage3Batch
local resetStage3ScheduledEvents
local lfrStage3BatchTimers = {
	[5] = true,
	[20] = true,
	[30] = true,
	[38] = true,
	[40] = true,
	[46] = true,
	[50] = true,
	[141] = true,
	[180] = true,
}
local heroicStage3BatchTimers = {
	[5] = true,
	[10] = true,
	[25] = true,
	[30] = true,
	[37] = true,
	[44] = true,
	[45] = true,
	[50] = true,
	[51] = true,
	[52] = true,
	[53] = true,
	[55] = true,
	[60] = true,
	[61] = true,
	[67] = true,
	[71] = true,
	[75] = true,
	[76] = true,
	[205] = true,
	[235] = true,
}

mod.vb.mothersWrathCount = 1
mod.vb.rageCount = 1
mod.vb.causticWavesCount = 1
mod.vb.goreRattleCount = 1
mod.vb.spectralCoilsCount = 1
mod.vb.callCount = 1
mod.vb.mephiticThrashCount = 1
mod.vb.virulentSpitCount = 1
mod.vb.serpentsBiteCount = 1
mod.vb.furyUnleashedCount = 1
mod.vb.circlingPreyCount = 1
mod.vb.submergeCount = 1

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnMothersWrath:SetAlert({699,952}, "defensive", 2, 2)
		end
		specWarnRageoftheShackled:SetAlert(700, "aesoon", 2, 2)
		specWarnCausticWaves:SetAlert(719, "watchwave", 2, 2)
		specWarnFuryUnleashed:SetAlert({746,810}, "stilldanger", 3, 2, 0)
		specWarnGoreRattle:SetAlert({799,847}, "bigmob", 2, 2)
		specWarnToxicIncubation:SetAlert({806,950}, "helpsoak", 2, 2)
		specWarnSpectralCoils:SetAlert({807,975}, "helpsoak", 2, 2)
		specWarnCalloftheSerpent:SetAlert(825, "mobsoon", 2, 2)
		specWarnCirclingPrey:SetAlert(826, "justrun", 2, 2)
		specWarnVirulentSpit:SetAlert(830, "watchstep", 2, 2)
		specWarnMephiticThrash:SetAlert(912, "aesoon", 2, 2)
		specWarnSubmerge:SetAlert(949, "phasechange", 2, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerMothersWrathCD:SetTimeline({699,952}, onlyColor)
	timerRageoftheShackledCD:SetTimeline(700, onlyColor)
	timerCausticWavesCD:SetTimeline(719, onlyColor)
	timerFuryUnleashedCD:SetTimeline({746,810}, onlyColor)
	timerGoreRattleCD:SetTimeline({799,847}, onlyColor)
	timerSerpentsBiteCD:SetTimeline(800, onlyColor)
	timerToxicIncubationCD:SetTimeline({806,950}, onlyColor)
	timerSpectralCoilsCD:SetTimeline({807,975}, onlyColor)
	timerCalloftheSerpentCD:SetTimeline(825, onlyColor)
	timerCirclingPreyCD:SetTimeline(826, onlyColor)
	timerVirulentSpitCD:SetTimeline(830, onlyColor)
	timerMephiticThrashCD:SetTimeline(912, onlyColor)
	timerSubmergeCD:SetTimeline(949, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:TLBatchReset()
	self:SetStage(1)
	stage1SixtyTwoCount = 0
	lfrStage1SeventyCount = 0
	lfrStage3FortyCount = 0
	lfrStage3FortySixCount = 0
	lfrStage3FiftyCount = 0
	heroicStage1FiftyTwoCount = 0
	heroicStage3SixtyCount = 0
	stage2Pending = false
	resetStage3ScheduledEvents(self)
	resetLFRStage3Batch(self)
	resetHeroicStage3Batch(self)
	self.vb.mothersWrathCount = 1
	self.vb.rageCount = 1
	self.vb.causticWavesCount = 1
	self.vb.goreRattleCount = 1
	self.vb.spectralCoilsCount = 1
	self.vb.callCount = 1
	self.vb.mephiticThrashCount = 1
	self.vb.virulentSpitCount = 1
	self.vb.serpentsBiteCount = 1
	self.vb.furyUnleashedCount = 1
	self.vb.circlingPreyCount = 1
	self.vb.submergeCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and (self:IsStory() or self:IsLFR() or self:IsNormal() or self:IsHeroic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
			"UNIT_TARGETABLE_CHANGED"
		)
		setFallback(self, true)
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	self:TLBatchReset()
	stage1SixtyTwoCount = 0
	lfrStage1SeventyCount = 0
	lfrStage3FortyCount = 0
	lfrStage3FortySixCount = 0
	lfrStage3FiftyCount = 0
	heroicStage1FiftyTwoCount = 0
	heroicStage3SixtyCount = 0
	stage2Pending = false
	resetStage3ScheduledEvents(self)
	resetLFRStage3Batch(self)
	resetHeroicStage3Batch(self)
	self:UnregisterShortTermEvents()
	badStateDetected = false--TEMP, we want to allow partial hardcode to work each pull til it's finished
end

do
	local function finishTimelineEvent(self, eventID)
		local eventType, eventCount = self:TLCountFinish(eventID)
		if not eventType or not eventCount then return end
		if eventType == "mothersWrath" then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnMothersWrath:Show()
				specWarnMothersWrath:Play("defensive")
			end
		elseif eventType == "rage" then
			if self:GetStage() == 1 then
				stage2Pending = true
			end
			specWarnRageoftheShackled:Show(eventCount)
			specWarnRageoftheShackled:Play("aesoon")
		elseif eventType == "causticWaves" then
			specWarnCausticWaves:Show(eventCount)
			specWarnCausticWaves:Play("watchwave")
		elseif eventType == "goreRattle" then
			specWarnGoreRattle:Show(eventCount)
			specWarnGoreRattle:Play("bigmob")
		elseif eventType == "spectralCoils" then
			specWarnSpectralCoils:Show(eventCount)
			specWarnSpectralCoils:Play("helpsoak")
		elseif eventType == "call" then
			specWarnCalloftheSerpent:Show(eventCount)
			specWarnCalloftheSerpent:Play("mobsoon")
		elseif eventType == "mephiticThrash" then
			specWarnMephiticThrash:Show(eventCount)
			specWarnMephiticThrash:Play("aesoon")
		elseif eventType == "virulentSpit" then
			specWarnVirulentSpit:Show(eventCount)
			specWarnVirulentSpit:Play("watchstep")
		elseif eventType == "furyUnleashed" then
			specWarnFuryUnleashed:Show(eventCount)
			specWarnFuryUnleashed:Play("stilldanger")
		elseif eventType == "circlingPrey" then
			specWarnCirclingPrey:Show(eventCount)
			specWarnCirclingPrey:Play("justrun")
		elseif eventType == "submerge" then
			specWarnSubmerge:Show(eventCount)
			specWarnSubmerge:Play("phasechange")
		end
	end

	local function finishScheduledStage3Event(self, eventID)
		stage3ScheduledEvents[eventID] = nil
		finishTimelineEvent(self, eventID)
	end

	resetStage3ScheduledEvents = function(self)
		self:Unschedule(finishScheduledStage3Event)
		stage3ScheduledEvents = {}
	end

	local function hardcodeFailed(self)
		badStateDetected = true
		self:ResumeBlizzardAPI()
		self:UnregisterShortTermEvents()
		setFallback(self)
		DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
	end

	local function resolveLFRStage3Collision(timer)
		if timer == 40 then
			lfrStage3FortyCount = lfrStage3FortyCount + 1
			if lfrStage3FortyCount == 1 or lfrStage3FortyCount == 3 then
				return timerCirclingPreyCD, "circlingPrey", "circlingPreyCount"
			elseif lfrStage3FortyCount == 2 then
				return timerSubmergeCD, "submerge", "submergeCount"
			end
		elseif timer == 46 then
			lfrStage3FortySixCount = lfrStage3FortySixCount + 1
			if lfrStage3FortySixCount == 1 then
				return timerCalloftheSerpentCD, "call", "callCount"
			elseif lfrStage3FortySixCount == 2 then
				return timerCausticWavesCD, "causticWaves", "causticWavesCount"
			end
		elseif timer == 50 then
			lfrStage3FiftyCount = lfrStage3FiftyCount + 1
			if lfrStage3FiftyCount == 1 then
				return timerCirclingPreyCD, "circlingPrey", "circlingPreyCount"
			elseif lfrStage3FiftyCount == 2 then
				return timerSubmergeCD, "submerge", "submergeCount"
			end
		end
	end

	local function startLFRStage3Timer(self, timer, timerExact, eventID, isOpeningBatch)
		if not isOpeningBatch and (timer == 40 or timer == 46 or timer == 50) then
			self:TLBatchStart(timer, function()
				local timerObj, eventType, countKey = resolveLFRStage3Collision(timer)
				if not timerObj then
					hardcodeFailed(self)
				end
				return timerObj, eventType, countKey
			end, timerExact, eventID, nil, nil, lfrStage3BatchTimers)
			stage3ScheduledEvents[eventID] = true
			self:Schedule(timerExact, finishScheduledStage3Event, self, eventID)
			return true
		end

		local timerObj, eventType, countKey
		if isOpeningBatch then
			if timer == 5 then
				timerObj, eventType, countKey = timerCalloftheSerpentCD, "call", "callCount"
			elseif timer == 20 then
				timerObj, eventType, countKey = timerCausticWavesCD, "causticWaves", "causticWavesCount"
			elseif timer == 30 then
				timerObj, eventType, countKey = timerCirclingPreyCD, "circlingPrey", "circlingPreyCount"
			elseif timer == 38 then
				timerObj, eventType, countKey = timerSubmergeCD, "submerge", "submergeCount"
			elseif timer == 141 then
				timerObj, eventType, countKey = timerRageoftheShackledCD, "rage", "rageCount"
			elseif timer == 180 then
				timerObj, eventType, countKey = timerFuryUnleashedCD, "furyUnleashed", "furyUnleashedCount"
			end
		elseif timer == 5 or timer == 20 or timer == 30 then
			timerObj, eventType, countKey = timerCausticWavesCD, "causticWaves", "causticWavesCount"
		end
		if not timerObj then return false end
		if isOpeningBatch then
			self:TLBatchStart(timer, timerObj, timerExact, eventID, eventType, countKey, lfrStage3BatchTimers)
		else
			self:TLBatchStart(timer, timerObj, timerExact, eventID, eventType, countKey, lfrStage3BatchTimers)
		end
		stage3ScheduledEvents[eventID] = true
		self:Schedule(timerExact, finishScheduledStage3Event, self, eventID)
		return true
	end

	local function startLFRStage3Batch(self)
		lfrStage3BatchScheduled = false
		local batch = lfrStage3Batch
		lfrStage3Batch = {}
		local hasFuryUnleashed = false
		for _, event in ipairs(batch) do
			if event.timer == 180 then--LFR Fury Unleashed duration; event order within the batch is not stable
				hasFuryUnleashed = true
				break
			end
		end
		if not hasFuryUnleashed then
			hardcodeFailed(self)
			return
		end
		self:SetStage(3)
		for _, event in ipairs(batch) do
			if not startLFRStage3Timer(self, event.timer, event.timerExact, event.eventID, true) then
				hardcodeFailed(self)
				return
			end
		end
	end

	resetLFRStage3Batch = function(self)
		self:Unschedule(startLFRStage3Batch)
		lfrStage3Batch = {}
		lfrStage3BatchScheduled = false
	end

	local function resolveHeroicStage3Collision()
		heroicStage3SixtyCount = heroicStage3SixtyCount + 1
		if heroicStage3SixtyCount == 1 then
			return timerCalloftheSerpentCD, "call", "callCount"
		elseif heroicStage3SixtyCount == 2 then
			return timerSubmergeCD, "submerge", "submergeCount"
		elseif heroicStage3SixtyCount == 3 then
			return timerSerpentsBiteCD, "serpentsBite", "serpentsBiteCount"
		end
	end

	local function startHeroicStage3Timer(self, timer, timerExact, eventID, isOpeningBatch)
		if not isOpeningBatch and timer == 60 then
			self:TLBatchStart(timer, function()
				local timerObj, eventType, countKey = resolveHeroicStage3Collision()
				if not timerObj then
					hardcodeFailed(self)
				end
				return timerObj, eventType, countKey
			end, timerExact, eventID, nil, nil, heroicStage3BatchTimers)
			stage3ScheduledEvents[eventID] = true
			self:Schedule(timerExact, finishScheduledStage3Event, self, eventID)
			return true
		end

		local timerObj, eventType, countKey
		if isOpeningBatch then
			if timer == 5 then
				timerObj, eventType, countKey = timerCalloftheSerpentCD, "call", "callCount"
			elseif timer == 10 then
				timerObj, eventType, countKey = timerMothersWrathCD, "mothersWrath", "mothersWrathCount"
			elseif timer == 25 then
				timerObj, eventType, countKey = timerSerpentsBiteCD, "serpentsBite", "serpentsBiteCount"
			elseif timer == 50 then
				timerObj, eventType, countKey = timerCausticWavesCD, "causticWaves", "causticWavesCount"
			elseif timer == 60 then
				timerObj, eventType, countKey = timerCirclingPreyCD, "circlingPrey", "circlingPreyCount"
			elseif timer == 67 then
				timerObj, eventType, countKey = timerSubmergeCD, "submerge", "submergeCount"
			elseif timer == 205 then
				timerObj, eventType, countKey = timerRageoftheShackledCD, "rage", "rageCount"
			elseif timer == 235 then
				timerObj, eventType, countKey = timerFuryUnleashedCD, "furyUnleashed", "furyUnleashedCount"
			end
		elseif timer == 30 or timer == 45 then
			timerObj, eventType, countKey = timerCalloftheSerpentCD, "call", "callCount"
		elseif timer == 37 or timer == 71 then
			timerObj, eventType, countKey = timerSerpentsBiteCD, "serpentsBite", "serpentsBiteCount"
		elseif timer == 44 or timer == 50 or timer == 55 then
			timerObj, eventType, countKey = timerCausticWavesCD, "causticWaves", "causticWavesCount"
		elseif timer == 51 or timer == 52 or timer == 61 then
			timerObj, eventType, countKey = timerCirclingPreyCD, "circlingPrey", "circlingPreyCount"
		elseif timer == 53 then
			timerObj, eventType, countKey = timerSubmergeCD, "submerge", "submergeCount"
		elseif timer == 75 or timer == 76 then
			timerObj, eventType, countKey = timerMothersWrathCD, "mothersWrath", "mothersWrathCount"
		end
		if not timerObj then return false end
		self:TLBatchStart(timer, timerObj, timerExact, eventID, eventType, countKey, heroicStage3BatchTimers)
		stage3ScheduledEvents[eventID] = true
		self:Schedule(timerExact, finishScheduledStage3Event, self, eventID)
		return true
	end

	local function startHeroicStage3Batch(self)
		heroicStage3BatchScheduled = false
		local batch = heroicStage3Batch
		heroicStage3Batch = {}
		local hasFuryUnleashed = false
		for _, event in ipairs(batch) do
			if event.timer == 235 then--Heroic Fury Unleashed duration; event order within the batch is not stable
				hasFuryUnleashed = true
				break
			end
		end
		if not hasFuryUnleashed then
			hardcodeFailed(self)
			return
		end
		self:SetStage(3)
		for _, event in ipairs(batch) do
			if not startHeroicStage3Timer(self, event.timer, event.timerExact, event.eventID, true) then
				hardcodeFailed(self)
				return
			end
		end
	end

	resetHeroicStage3Batch = function(self)
		self:Unschedule(startHeroicStage3Batch)
		heroicStage3Batch = {}
		heroicStage3BatchScheduled = false
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	--LFR stages 2 and 3 use independent timer patterns and must not be reused for Normal or higher difficulties.
	local function timersLFR(self, timer, timerExact, eventID)
		local handled = false
		local stage = self:GetStage()
		if stage == 1 then
			if timer == 55 then
				timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
			elseif timer == 3 then
				timerGoreRattleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "goreRattle", "goreRattleCount"))
			elseif timer == 40 then
				timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
			elseif timer == 7 or timer == 68 then
				timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
			elseif timer == 20 then
				timerCalloftheSerpentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "call", "callCount"))
			elseif timer == 145 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			elseif timer == 70 then
				lfrStage1SeventyCount = lfrStage1SeventyCount + 1
				if lfrStage1SeventyCount == 1 then
					timerCalloftheSerpentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "call", "callCount"))
				elseif lfrStage1SeventyCount == 2 then
					timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
				elseif lfrStage1SeventyCount == 3 then
					timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
				else
					hardcodeFailed(self)
					return
				end
			else
				hardcodeFailed(self)
				return
			end
			handled = true
		elseif stage == 2 and timer == 10 then--LFR intermission begins with Spectral Coils
			self:SetStage(2.5)
			timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
			handled = true
		elseif stage == 2.5 then
			table.insert(lfrStage3Batch, {timer = timer, timerExact = timerExact, eventID = eventID})
			if not lfrStage3BatchScheduled then
				lfrStage3BatchScheduled = true
				self:Schedule(0, startLFRStage3Batch, self)
			end
			handled = true
		elseif stage == 3 then
			handled = startLFRStage3Timer(self, timer, timerExact, eventID, false)
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			hardcodeFailed(self)
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		local handled = false
		local stage = self:GetStage()
		if stage == 1 and stage2Pending and timer == 118 then--Fallback if boss1 targetability did not update before the second Rage of the Shackled
			stage2Pending = false
			self:SetStage(2)
			timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			handled = true
		elseif stage == 1 then
			if timer == 5 or timer == 70 then
				timerGoreRattleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "goreRattle", "goreRattleCount"))
			elseif timer == 10 or timer == 37 or timer == 67 then
				timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
			elseif timer == 20 or timer == 95 then
				timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
			elseif timer == 35 then
				timerMephiticThrashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mephiticThrash", "mephiticThrashCount"))
			elseif timer == 42 then
				timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
			elseif timer == 52 then
				heroicStage1FiftyTwoCount = heroicStage1FiftyTwoCount + 1
				if heroicStage1FiftyTwoCount == 1 then
					timerMephiticThrashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mephiticThrash", "mephiticThrashCount"))
				elseif heroicStage1FiftyTwoCount == 2 then
					timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
				else
					hardcodeFailed(self)
					return
				end
			elseif timer == 62 then
				timerSubmergeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "submerge", "submergeCount"))
			elseif timer == 72 then
				timerCalloftheSerpentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "call", "callCount"))
			elseif timer == 129 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			else
				hardcodeFailed(self)
				return
			end
			handled = true
		elseif stage == 2 then
			if timer == 10 then--Heroic intermission begins with Spectral Coils
				self:SetStage(2.5)
				timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
			elseif timer == 118 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			elseif timer == 30 or timer == 40 then
				timerVirulentSpitCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "virulentSpit", "virulentSpitCount"))
			else
				hardcodeFailed(self)
				return
			end
			handled = true
		elseif stage == 2.5 then
			table.insert(heroicStage3Batch, {timer = timer, timerExact = timerExact, eventID = eventID})
			if not heroicStage3BatchScheduled then
				heroicStage3BatchScheduled = true
				self:Schedule(0, startHeroicStage3Batch, self)
			end
			handled = true
		elseif stage == 3 then
			handled = startHeroicStage3Timer(self, timer, timerExact, eventID, false)
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			hardcodeFailed(self)
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	--TODO: Stage 2 routing is incomplete, and stage 3 is unimplemented; the available Normal kill ended early before any stage 3 abilities. More log evidence is needed.
	local function timersNormal(self, timer, timerExact, eventID)
		local handled = false
		local stage = self:GetStage()
		if stage == 1 and stage2Pending and timer == 118 then--Fallback if boss1 targetability did not update before the second Rage of the Shackled
			stage2Pending = false
			self:SetStage(2)
			timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			handled = true
		elseif stage == 1 then
			if timer == 42 then
				timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
				handled = true
			elseif timer == 10 then
				timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
				handled = true
			elseif timer == 20 or timer == 84 then
				timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
				handled = true
			elseif timer == 130 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
				handled = true
			elseif timer == 5 then
				timerGoreRattleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "goreRattle", "goreRattleCount"))
				handled = true
			elseif timer == 35 or timer == 41 then
				timerMephiticThrashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mephiticThrash", "mephiticThrashCount"))
				handled = true
			elseif timer == 62 then
				stage1SixtyTwoCount = stage1SixtyTwoCount + 1
				if stage1SixtyTwoCount == 1 then--Complete Normal corpus: opener Call, then Mother's Wrath
					timerCalloftheSerpentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "call", "callCount"))
					handled = true
				elseif stage1SixtyTwoCount == 2 then
					timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
					handled = true
				end
			end
		elseif stage == 2 then
			if timer == 118 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			elseif timer == 30 or timer == 40 then
				timerVirulentSpitCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "virulentSpit", "virulentSpitCount"))
			end
			handled = timer == 118 or timer == 30 or timer == 40
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			hardcodeFailed(self)
		end
	end

	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			if self:IsStory() or self:IsLFR() then
				timersLFR(self, timer, timerExact, eventID)
			elseif self:IsHeroic() then
				timersHeroic(self, timer, timerExact, eventID)
			else
				timersNormal(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		local batchTimer = self:TLBatchUntrack(eventID)
		if stage3ScheduledEvents[eventID] then
			if eventState == 3 and batchTimer then--Superseded duplicate stage-3 event
				stage3ScheduledEvents[eventID] = nil
				self:Unschedule(finishScheduledStage3Event, self, eventID)
				self:TLCountCancel(eventID)
			end
			return--Stage 3 cancel states are delayed or inaccurate; finish from the raw timeline duration instead
		elseif eventState == 2 or (self:GetStage() == 3 and eventState == 3) then
			finishTimelineEvent(self, eventID)
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end

	function mod:UNIT_TARGETABLE_CHANGED(unit)
		if stage2Pending and self:GetStage() == 1 and unit == "boss1" and not UnitCanAttack("player", unit) then
			stage2Pending = false
			self:SetStage(2)
		end
	end
end
