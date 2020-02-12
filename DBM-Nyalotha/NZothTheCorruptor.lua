local mod	= DBM:NewMod(2375, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158041)
mod:SetEncounterID(2344)
mod:SetZone()
mod:SetHotfixNoticeRev(20200206000001)--2020, 2, 06
mod:SetMinSyncRevision(20200206000001)
mod.respawnTime = 49

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 311176 316711 310184 310134 310130 317292 310331 315772 309698 310042 313400 308885 317066 319349 319350 319351 316970 318449 312782 316463 318971 313611",
	"SPELL_CAST_SUCCESS 315927 319257 317102 317066 316970 319349 319350 319351 318460 312866",
	"SPELL_SUMMON 318091",
	"SPELL_AURA_APPLIED 313334 308996 309991 313184 316541 316542 313793 315709 315710 312155 318196 318459 319309 319015 317112 319346 316711 318714 313960",
	"SPELL_AURA_APPLIED_DOSE 313184 319309",
	"SPELL_AURA_REMOVED 313184 313334 312155 318459 317112 319346 316541 316542 319015 319309 318196",
	"SPELL_PERIODIC_DAMAGE 309991",
	"SPELL_PERIODIC_MISSED 309991",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_POWER_FREQUENT player",
	"CINEMATIC_STOP"
)

--TODO, find out power gains of Psychus and add timer for Manifest Madness that's more reliable? (his energy soft enrage)
--TODO, test infoframe for sanity+neck status
--TODO, P3 spells with no detection like Stupefying Glare need scheduling for remaining difficulties
--TODO, fix canceling cleansing timer if one is blown up by annihilate?
--New Voice: "leavemind" and "lowsanity"
--[[
(ability.id = 318449 or ability.id = 311176 or ability.id = 310184 or ability.id = 316463 or ability.id = 310134 or ability.id = 310130 or ability.id = 317292 or ability.id = 310331 or ability.id = 315772 or ability.id = 309698 or ability.id = 313400 or ability.id = 308885 or ability.id = 317066 or ability.id = 318196 or ability.id = 316970 or ability.id = 319351 or ability.id = 319350 or ability.id = 319349 or ability.id = 312782 or ability.id = 318971) and type = "begincast"
 or (ability.id = 315927 or ability.id = 317102 or ability.id = 318460) and type = "cast"
 or ability.id = 318714 and type = "applybuff"
 or ability.id = 318196 and type = "applydebuff"
 or ability.id = 312155 or ability.id = 319015 or ability.id = 318091
 or target.id = 163612 and type = "death"
 or ability.id = 316711 and type = "begincast"
 or ability.id = 319346 and (type = "applydebuff" or type = "removedebuff")
 or (ability.id = 309296 or ability.id = 309307) and type = "cast"
--]]
--General
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnGiftofNzoth						= mod:NewTargetNoFilterAnnounce(313334, 2)
local warnSanity							= mod:NewCountAnnounce(307831, 3)
--Stage 1: Dominant Mind
----Psychus
local warnCreepingAnguish					= mod:NewCastAnnounce(310184, 4)
local warnSynapticShock						= mod:NewStackAnnounce(313184, 1)
local warnEternalHatred						= mod:NewCastAnnounce(310130, 4)
local warnMindwrack							= mod:NewTargetNoFilterAnnounce(316711, 4, nil, "Tank|Healer")
----Eyes of N'zoth
local warnVoidGaze							= mod:NewSpellAnnounce(310333, 3)
--Stage 2: Writhing Onslaught
----N'Zoth
local warnShatteredEgo						= mod:NewTargetNoFilterAnnounce(312155, 1)
local warnParanoia							= mod:NewTargetNoFilterAnnounce(309980, 3)
local warnMindGate							= mod:NewCastAnnounce(309046, 2)
----Basher tentacle
local warnTumultuousBurst					= mod:NewCastAnnounce(310042, 4, nil, nil, "Tank")
----Through the Mindgate
------Corruption of Deathwing
local warnCataclysmicFlames					= mod:NewCountAnnounce(312866, 3)
local warnBlackVolley						= mod:NewCountAnnounce(313960, 3)
local warnFlamesofInsanity					= mod:NewTargetNoFilterAnnounce(313793, 2, nil, "RemoveMagic")
--Stage 3 Non Mythic
local warnThoughtHarvester					= mod:NewCountAnnounce("ej21308", 3, 231298)
local warnStupefyingGlareSoon				= mod:NewCountdownAnnounce(317874, 4, nil, nil, 239918)--warning will be shortened to "Glare"
--Stage 3 Mythic
local warnEventHorizon						= mod:NewTargetNoFilterAnnounce(318196, 3)
local warnAnnihilate						= mod:NewTargetNoFilterAnnounce(318459, 2)
local warnEvokeAnguish						= mod:NewTargetAnnounce(317112, 3)
local warnCleansingProtocol					= mod:NewCountAnnounce(316970, 2)
local warnDisarmCountermeasure				= mod:NewTargetNoFilterAnnounce(319257, 1)

--General
local specWarnGiftofNzoth					= mod:NewSpecialWarningYou(313334, nil, nil, nil, 1, 2)
local yellGiftofNzothFades					= mod:NewFadesYell(313334)
local specWarnServantofNzoth				= mod:NewSpecialWarningSwitch(308996, false, nil, 3, 1, 2)
local yellServantofNzoth					= mod:NewYell(308996)
local specwarnSanity						= mod:NewSpecialWarningCount(307831, nil, nil, nil, 1, 10)
local specWarnMentalDecay					= mod:NewSpecialWarningInterrupt(313611, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(309991, nil, nil, nil, 1, 8)
--Stage 1: Dominant Mind
----Psychus
local specWarnMindwrack						= mod:NewSpecialWarningInterruptCount(316711, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindwrackTaunt				= mod:NewSpecialWarningTaunt(316711, nil, nil, nil, 1, 2)
local specWarnManifestMadness				= mod:NewSpecialWarningSpell(310134, nil, nil, nil, 3)--Basically an automatic wipe unless Psychus was like sub 1% health, no voice because there isn't really one that says "you're fucked"
local specWarnEternalHatred					= mod:NewSpecialWarningMoveTo(310130, nil, nil, nil, 3, 10)--No longer in journal, replaced by collapsing Mindscape, but maybe a hidden mythic mechanic now?
local specWarnCollapsingMindscape			= mod:NewSpecialWarningMoveTo(317292, nil, nil, nil, 2, 10)
--Stage 2: Writhing Onslaught
----N'Zoth
local specWarnMindgrasp						= mod:NewSpecialWarningSpell(315772, nil, nil, nil, 2, 2)
local specWarnParanoia						= mod:NewSpecialWarningMoveTo(309980, nil, nil, nil, 1, 2)
local yellParanoia							= mod:NewShortYell(309980)
local yellParanoiaRepeater					= mod:NewPosYell(309980, DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnEternalTorment				= mod:NewSpecialWarningCount(318449, nil, 311383, nil, 2, 2)
----Basher Tentacle
local specWarnBasherTentacle				= mod:NewSpecialWarningSwitch("ej21286", "-Healer", nil, 2, 1, 2)
local specWarnVoidLash						= mod:NewSpecialWarningDefensive(309698, nil, nil, nil, 1, 2)
----Corruptor Tentacle
local specWarnCorruptedMind					= mod:NewSpecialWarningInterruptCount(313400, "HasInterrupt", nil, nil, 1, 2)
local specWarnCorruptedMindDispel			= mod:NewSpecialWarningDispel(313400, "RemoveMagic", nil, nil, 1, 2)
local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(308885, false, nil, nil, 1, 2)
----Through the Mindgate
------Trecherous Bargain
local specWarnTreadLightly					= mod:NewSpecialWarningYou(315709, nil, nil, nil, 1, 2)
local specWarnContempt						= mod:NewSpecialWarningStopMove(315710, nil, nil, nil, 1, 6)
--Stage 3:
----N'Zoth
local specWarnEvokeAnguish					= mod:NewSpecialWarningYou(317112, nil, nil, nil, 1, 2)
local yellEvokeAnguish						= mod:NewYell(317112, nil, false, 2)
local yellEvokeAnguishFades					= mod:NewShortFadesYell(317112, nil, true, 3)
local specWarnStupefyingGlare				= mod:NewSpecialWarningDodgeCount(317874, nil, 239918, nil, 2, 2)--warning will be shortened to "Glare"
----Thought Harvester
local specWarnThoughtHarvester				= mod:NewSpecialWarningSwitchCount("ej21308", false, nil, nil, 1, 2)
local specWarnHarvestThoughts				= mod:NewSpecialWarningCount(317066, nil, nil, nil, 2, 2)
--Stage 3 Mythic
local specWarnSummonGateway					= mod:NewSpecialWarningMoveTo(318091, nil, nil, nil, 3, 5)
local specWarnEventHorizon					= mod:NewSpecialWarningDefensive(318196, nil, nil, nil, 1, 2, 4)
local specWarnEventHorizonSwap				= mod:NewSpecialWarningTaunt(318196, nil, nil, nil, 1, 2, 4)
local specWarnDarkMatter					= mod:NewSpecialWarningDodgeCount(318971, nil, nil, nil, 2, 2, 4)
local specWarnAnnihilate					= mod:NewSpecialWarningYou(318459, nil, nil, nil, 1, 2, 4)
local yellAnnihilate						= mod:NewYell(318459)
local yellAnnihilateFades					= mod:NewShortFadesYell(318459)

--mod:AddTimerLine(BOSS)
--General
local timerGiftofNzoth						= mod:NewBuffFadesTimer(20, 313334, nil, nil, nil, 5)
local berserkTimer							= mod:NewBerserkTimer(720)
--Stage 1: Dominant Mind
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20957))
----Psychus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21455))
local timerMindwrackCD						= mod:NewCDTimer(5.6, 316711, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)--4.9-8.6
local timerCreepingAnguishCD				= mod:NewNextTimer(28.2, 310184, nil, nil, 2, 5, nil, DBM_CORE_TANK_ICON)
local timerSynampticShock					= mod:NewBuffActiveTimer(30, 313184, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)--, nil, 1, 4
----Mind's Eye
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20977))
local timerVoidGazeCD						= mod:NewCDTimer(33, 310333, nil, nil, nil, 2)--33-34.3
--Stage 2: Writhing Onslaught
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20970))
----N'Zoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20917))
local timerCollapsingMindscape				= mod:NewCastTimer(20, 317292, nil, nil, nil, 6)
local timerMindgraspCD						= mod:NewNextTimer(30.1, 315772, nil, nil, nil, 3)
local timerParanoiaCD						= mod:NewNextCountTimer(30.1, 309980, nil, nil, nil, 3)
local timerMindgateCD						= mod:NewNextTimer(30.1, 309046, nil, nil, nil, 1, nil, nil, nil, 1, 4)
local timerShatteredEgo						= mod:NewBuffActiveTimer(30, 319015, nil, nil, nil, 6)
local timerEternalTormentCD					= mod:NewNextCountTimer(56.1, 318449, 311383, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--"Torment" short name
----Basher Tentacle
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21286))
local timerBasherTentacleCD					= mod:NewNextCountTimer(60, "ej21286", nil, nil, nil, 1, "319441", DBM_CORE_DAMAGE_ICON)
local timerVoidLashCD						= mod:NewCDTimer(22.9, 309698, nil, false, 2, 5, nil, DBM_CORE_TANK_ICON)
----Through the MindGate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20971))
local timerCataclysmicFlamesCD				= mod:NewNextCountTimer(22.4, 312866, nil, nil, nil, 3)
local timerBlackVolleyCD					= mod:NewNextCountTimer(20, 313960, nil, nil, nil, 2)
--Stage 3 (2Mythic): Convergence:
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20767))
----N'Zoth
local timerEvokeAnguishCD					= mod:NewNextCountTimer(30.5, 317102, nil, nil, nil, 3)--30.5-44.9, delayed by boss doing other stuff?
local timerStupefyingGlareCD				= mod:NewNextCountTimer(22.9, 317874, 239918, nil, 2, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)
----Thought Harvester
local timerThoughtHarvesterCD				= mod:NewCDCountTimer(30.1, "ej21308", nil, nil, nil, 1, 231298)
local timerHarvestThoughtsCD				= mod:NewCDTimer(35.2, 317066, nil, nil, nil, 3)
--Stage 3 Mythic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21435))
local timerSummongateway					= mod:NewNextTimer(153.9, 318091, nil, nil, nil, 6)
local timerEventHorizonCD					= mod:NewNextCountTimer(22.9, 318196, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--, nil, 2, 4
local timerDarkMatterCD						= mod:NewNextCountTimer(16, 318971, nil, nil, nil, 3)
local timerAnnihilateCD						= mod:NewNextCountTimer(22.9, 318460, nil, nil, nil, 3)
local timerCleansingProtocolCD				= mod:NewNextCountTimer(16, 316970, nil, nil, nil, 5)
local timerCleansingProtocol				= mod:NewCastTimer(8, 316970, nil, nil, nil, 2)

mod:AddRangeFrameOption(4, 317112)
mod:AddInfoFrameOption(307831, true)
mod:AddSetIconOption("SetIconOnCorruptor", "ej21441", true, true, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnHarvester", "ej21308", true, true, {1, 2, 3, 4})
mod:AddBoolOption("ArrowOnGlare", true)
mod:AddMiscLine(DBM_CORE_OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InterruptBehavior", {"Four", "Five", "Six", "NoReset"}, "Five", "misc")

mod.vb.phase = 0
mod.vb.BasherCount = 0
mod.vb.egoCount = 0
mod.vb.evokeAnguishCount = 0
mod.vb.eternalTormentCount = 0
mod.vb.harvesterCount = 0
mod.vb.harvestThoughtsCount = 0
mod.vb.harvestersAlive = 0
mod.vb.paranoiaCount = 0
mod.vb.stupefyingGlareCount = 0
mod.vb.darkMatterCount = 0
mod.vb.eventHorrizonCount = 0
mod.vb.cleansingCastCount = 0
mod.vb.annihilateCastCount = 0
mod.vb.cleansingActive = 0
mod.vb.cataclysmCount = 0
mod.vb.blackVolleyCount = 0
mod.vb.addIcon = 1
mod.vb.interruptBehavior = "Five"
mod.vb.difficultyName = "None"
local selfInMind = false
local lastSanity = 100
local lastHarvesterTime = 0
local debugSpawnTable = {}
local harvesterDebugTriggered = 0
local playerName = UnitName("player")
local neckAvailable = {}
local seenAdds = {}
local ParanoiaTargets = {}
local castsPerGUID = {}
local allTimers = {
	["lfr"] = {
		[2] = {--Unknown, using same ones as normal
			--Basher tentacles
			[318714] = {23, 55.0, 50.0},
			--Paranoia
			[315927] = {50, 56.1, 48.6},
			--Eternal Torment
			[318449] = {35.3, 56, 29.3, 19.5},
		},
		[3] = {--Unknown, using same ones as normal
			--Eternal Torment
			[318449] = {32.8, 70.9, 10.9, 34.1, 60.7, 10.5, 33.2},
			--Thought Harvester spawns
			[316711] = {15, 27, 45},
			--Evoke Anquish
			[317102] = {15.3, 46.2, 31.6, 44.9, 37.7, 15.8, 51, 37.7},
			--Stupefying Glare
			[317874] = {},
		},
	},
	["normal"] = {
		[2] = {--Same as heroic
			--Basher tentacles
			[318714] = {23, 55.0, 50.0},
			--Paranoia
			[315927] = {50, 56.1, 48.6},
			--Eternal Torment
			[318449] = {35.3, 56, 29.3, 19.5},
		},
		[3] = {--Different from heroic
			--Eternal Torment
			[318449] = {32.8, 70.9, 10.9, 34.1, 60.7, 10.5, 33.2},
			--Thought Harvester spawns
			[316711] = {15, 25.6, 45, 29.7, 30.1},--, 43, 31.7
			--Evoke Anquish
			[317102] = {15.3, 46.2, 31.6, 44.9, 37.7, 15.8, 51, 37.7},
			--Stupefying Glare
			[317874] = {},
		},
	},
	["heroic"] = {
		[2] = {--TODO: Stage 2 timer sequences likely all go longer if a successful shattered ego doesn't trigger to restart the shattered ego timer cycles
			--Basher tentacles
			[318714] = {23, 55.0, 50.0},
			--Paranoia
			[315927] = {50, 56.1, 48.6},
			--Eternal Torment
			[318449] = {35.3, 56, 29.3, 19.5},
		},
		[3] = {
			--Eternal Torment
			[318449] = {32.8, 70.9, 10.5, 24.5, 10.9, 23.2, 11, 23.1},--It might be that after first two casts it just alternates between 10.5 and 23.1?
			--Thought Harvester spawns
			[316711] = {15.1, 25.1, 45, 31, 3.9, 30.2, 4.8},--, 31.6, 3.7, 30.4, 4.8 It might be that after 3rd cast, it just alternates between 29-30 and 3.7-4.8
			--Evoke Anquish
			[317102] = {15.3, 45.2, 32.6, 30.6, 35.3, 35.3},
			--Stupefying Glare
			[317874] = {40.5, 67.5},
		},
	},
	["mythic"] = {
		[1] = {--TODO: Stage 1 timer sequences likely all go longer if a successful shattered ego doesn't trigger to restart the shattered ego timer cycles
			--Basher tentacles
			[318714] = {0, 35, 35, 50, 35},
			--Paranoia
			[315927] = {15, 85.1},
			--Eternal Torment
			[318449] = {25, 25, 25, 50, 25},
		},
		[2] = {
			--Thought Harvester spawns
			[316711] = {9.5, 76.9, 26.7},
			--Evoke Anquish
			[317102] = {25, 19.5, 33.9, 20.6},
			--Stupefying Glare
			[317874] = {35, 70},
			--Paranoia
			[315927] = {56.6, 65.7},
		},
		[3] = {
			--Eternal Torment (Nzoth)
			[318449] = {20, 6.1},--6.1 repeating
			--Cleansing Protocol (Chamber)
			[318449] = {25, 16, 12, 27, 29.9},
			--Event Horizon (Chamber)
			[318196] = {20, 30, 30, 30},
			--Dark Matter (Chamber)
			[318971] = {39, 60},
			--Annihilate (Chamber)
			[318460] = {60, 26.7},
			----Returning to nzoth after Chamber (ie phase 2, 2.0)
			--Thought Harvester spawns
			[316711] = {12.3, 76.9, 26.3, 44.9, 26.6, 44.9},
			--Evoke Anquish
			[317102] = {27.7, 19.5, 33.9, 20.6, 42.5, 30.4, 41.2, 30.4, 42.5, 29.1},
			--Stupefying Glare
			[317874] = {38, 70},
			--Paranoia
			[315927] = {59.5, 71.6, 71.7},
		},
	},
}

local function warnParanoiaTargets(self)
	if not self:IsMythic() then--Entire raid gets it, no point in announcing this
		warnParanoia:Show(table.concat(ParanoiaTargets, "<, >"))
	end
	table.wipe(ParanoiaTargets)
end

local function paranoiaYellRepeater(self, text)
	yellParanoiaRepeater:Yell(text)
	self:Schedule(2, paranoiaYellRepeater, self, text)
end

local function UpdateTimerFades(self)
	if selfInMind and not UnitIsDeadOrGhost("player") then
		--Outside
		timerMindgraspCD:SetFade(true)
		timerParanoiaCD:SetFade(true, self.vb.paranoiaCount+1)
		timerBasherTentacleCD:SetFade(true, self.vb.BasherCount+1)
		timerVoidLashCD:SetFade(true)
		timerEternalTormentCD:SetFade(true, self.vb.eternalTormentCount+1)
		--Mindscape
		timerMindwrackCD:SetFade(false)
		timerCreepingAnguishCD:SetFade(false)
		timerVoidGazeCD:SetFade(false)
		timerSynampticShock:SetFade(false)
		timerCataclysmicFlamesCD:SetFade(false, self.vb.cataclysmCount+1)
		timerBlackVolleyCD:SetFade(false, self.vb.blackVolleyCount+1)
	else
		--Outside
		timerMindgraspCD:SetFade(false)
		timerParanoiaCD:SetFade(false, self.vb.paranoiaCount+1)
		timerBasherTentacleCD:SetFade(false, self.vb.BasherCount+1)
		timerVoidLashCD:SetFade(false)
		timerEternalTormentCD:SetFade(false, self.vb.eternalTormentCount+1)
		--Mindscape
		timerMindwrackCD:SetFade(true)
		timerCreepingAnguishCD:SetFade(true)
		timerVoidGazeCD:SetFade(true)
		timerSynampticShock:SetFade(true)
		timerCataclysmicFlamesCD:SetFade(true, self.vb.cataclysmCount+1)
		timerBlackVolleyCD:SetFade(true, self.vb.blackVolleyCount+1)
	end
end

local function stupefyingGlareLoop(self)
	self.vb.stupefyingGlareCount = self.vb.stupefyingGlareCount + 1
	local direction = ""
	if self:IsMythic() then
		if self.vb.phase == 2 then
			if self.vb.stupefyingGlareCount % 2 == 0 then
				direction = DBM_CORE_RIGHT--ie counter clockwise
			else
				direction = DBM_CORE_LEFT--ie Clockwise
			end
		else--Phase 3
			if self.vb.stupefyingGlareCount % 2 == 0 then
				direction = DBM_CORE_LEFT--ie counter clockwise
			else
				direction = DBM_CORE_RIGHT--ie Clockwise
			end
		end
	--else--Not mythic
		--Guessed same as mythic stage 2, but if wrong I'm sure i'll get feedback quickly
	--	if self.vb.stupefyingGlareCount % 2 == 0 then
	--		direction = DBM_CORE_LEFT--ie Clockwise
	--	else
	--		direction = DBM_CORE_RIGHT--ie counter clockwise
	--	end
	end
	specWarnStupefyingGlare:Show(self.vb.stupefyingGlareCount .. direction)
	specWarnStupefyingGlare:Play("farfromline")
	if self.Options.ArrowOnGlare then
		--Assuming facing boss
		if direction == DBM_CORE_LEFT then
			DBM.Arrow:ShowStatic(90, 10)
		elseif direction == DBM_CORE_RIGHT then
			DBM.Arrow:ShowStatic(270, 10)
		end
	end
	local timer = allTimers[self.vb.difficultyName][self.vb.phase][317874][self.vb.stupefyingGlareCount+1]
	if timer then
		--Flip direction for next timer
		if direction == DBM_CORE_RIGHT then
			direction = DBM_CORE_LEFT
		elseif direction == DBM_CORE_LEFT then
			direction = DBM_CORE_RIGHT
		end
		warnStupefyingGlareSoon:Countdown(timer, 5)
		timerStupefyingGlareCD:Start(timer, self.vb.stupefyingGlareCount+1 .. "-" .. direction)
		self:Schedule(timer, stupefyingGlareLoop, self)
	end
end


local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local sortedLines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local function sortFuncAsc(a, b) return tempLines[a] < tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		table.wipe(tempLines)
		table.wipe(tempLinesSorted)
		--Build Sanity Table
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			local count = UnitPower(uId, ALTERNATE_POWER_INDEX)
			tempLines[unitName] = count
			tempLinesSorted[#tempLinesSorted + 1] = unitName
		end
		--Sort it by lowest sorted to top
		tsort(tempLinesSorted, sortFuncAsc)
		--Move into regular infoframe table now
		for _, name in ipairs(tempLinesSorted) do
			local neckAvailable = neckAvailable[name] and "|cFF088A08"..YES.."|r" or "|cffff0000"..NO.."|r"
			addLine(neckAvailable.."*"..name, tempLines[name])
		end
		return lines, sortedLines
	end
end

--/run DBM:GetModByName("2375"):Test()
function mod:Test()
	specWarnStupefyingGlare:Show(1)
	warnStupefyingGlareSoon:Countdown(10, 5)
end

function mod:OnCombatStart(delay)
	self.vb.eternalTormentCount = 0
	self.vb.BasherCount = 0
	self.vb.paranoiaCount = 0
	self.vb.egoCount = 0
	self.vb.addIcon = 1
	self.vb.cataclysmCount = 0
	self.vb.blackVolleyCount = 0
	self.vb.interruptBehavior = self.Options.InterruptBehavior--Default it to whatever user has it set to, until group leader overrides it
	lastHarvesterTime = 0
	table.wipe(debugSpawnTable)
	table.wipe(castsPerGUID)
	table.wipe(neckAvailable)
	selfInMind = false
	lastSanity = 100
	table.wipe(seenAdds)
	table.wipe(ParanoiaTargets)
	harvesterDebugTriggered = 0
	if self:IsMythic() then
		self.vb.phase = 1
		self.vb.difficultyName = "mythic"
		timerParanoiaCD:Start(15.5, 1)--SUCCESS
		timerEternalTormentCD:Start(25, 1)
		timerMindgateCD:Start(55)--START
		timerMindgraspCD:Start(103)
		berserkTimer:Start(780-delay)
	else
		if self:IsHeroic() then
			self.vb.difficultyName = "heroic"
		elseif self:IsNormal() then
			self.vb.difficultyName = "normal"
		else
			self.vb.difficultyName = "lfr"
		end
		self.vb.phase = 0
		berserkTimer:Start(720-delay)
	end
	UpdateTimerFades(self)
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Four" then
			self:SendSync("Four")
		elseif self.Options.InterruptBehavior == "Five" then
			self:SendSync("Five")
		elseif self.Options.InterruptBehavior == "Six" then
			self:SendSync("Six")
		elseif self.Options.InterruptBehavior == "NoReset" then
			self:SendSync("NoReset")
		end
	end
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		neckAvailable[name] = true
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
		if DBM.Options.DebugMode then
			DBM.InfoFrame:Show(self:IsMythic() and 20 or 8, "function", updateInfoFrame, false)
		else
			DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnGlare then
		DBM.Arrow:Hide()
	end
	if (harvesterDebugTriggered >= 2) and (#debugSpawnTable > 0) then
		local message = table.concat(debugSpawnTable, ", ")
		DBM:AddMsg("Harvester Spawns collected. Please report these numbers and raid difficulty to DBM author: "..message)
	end
end

function mod:OnTimerRecovery()
	if not DBM:UnitDebuff("player", 319346) and not UnitIsDeadOrGhost("player") then
		selfInMind = true
	end
	--On recovery no way to know neck status, so set all to false
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		neckAvailable[name] = false
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 311176 then
		self.vb.phase = 1--Non Mythic
		--Start P1 timers here, more accurate, especially if boss forgets to cast this :D
		timerVoidGazeCD:Start(14.7)
	elseif spellId == 316711 then
		if args:GetSrcCreatureID() == 158376 then--Psychus
			timerMindwrackCD:Start(4.9, args.sourceGUID)
			if not castsPerGUID[args.sourceGUID] then
				castsPerGUID[args.sourceGUID] = 0
			end
			if (self.vb.interruptBehavior == "Four" and castsPerGUID[args.sourceGUID] == 4) or (self.vb.interruptBehavior == "Five" and castsPerGUID[args.sourceGUID] == 5) or (self.vb.interruptBehavior == "Six" and castsPerGUID[args.sourceGUID] == 6) then
				castsPerGUID[args.sourceGUID] = 0
			end
			castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
			local count = castsPerGUID[args.sourceGUID]
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnMindwrack:Show(args.sourceName, count)
				if count == 1 then
					specWarnMindwrack:Play("kick1r")
				elseif count == 2 then
					specWarnMindwrack:Play("kick2r")
				elseif count == 3 then
					specWarnMindwrack:Play("kick3r")
				elseif count == 4 then
					specWarnMindwrack:Play("kick4r")
				elseif count == 5 then
					specWarnMindwrack:Play("kick5r")
				else--Shouldn't happen, but fallback rules never hurt
					specWarnMindwrack:Play("kickcast")
				end
			end
		else
			timerMindwrackCD:Start(8.4, args.sourceGUID)
		end
	elseif spellId == 310184 then
		if selfInMind then
			warnCreepingAnguish:Show()
		end
		timerCreepingAnguishCD:Start(self:IsMythic() and 26.6 or 28.2)
	elseif spellId == 310134 then
		specWarnManifestMadness:Show()
	elseif spellId == 310130 then
		if selfInMind then
			specWarnEternalHatred:Show(L.ExitMind)
			specWarnEternalHatred:Play("leavemind")
		else
			warnEternalHatred:Show()
		end
	elseif spellId == 317292 then
		if selfInMind then
			specWarnCollapsingMindscape:Show(L.ExitMind)
			specWarnCollapsingMindscape:Play("leavemind")
		end
		timerCollapsingMindscape:Start(20)
		timerCataclysmicFlamesCD:Stop()
		timerBlackVolleyCD:Stop()
	elseif spellId == 310331 then
		warnVoidGaze:Show()
		timerVoidGazeCD:Start(33)
	elseif spellId == 315772 then
		if not selfInMind then
			specWarnMindgrasp:Show()
			specWarnMindgrasp:Play("specialsoon")
		end
		--timerMindgraspCD:Start()
	elseif spellId == 309698 then
		timerVoidLashCD:Start(23.1, args.sourceGUID)
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then
				specWarnVoidLash:Show()
				specWarnVoidLash:Play("defensive")
				break
			end
		end
	elseif spellId == 310042 then
		warnTumultuousBurst:Show()
	elseif spellId == 313400 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCorruptedMind:Show(args.sourceName, count)
			if count == 1 then
				specWarnCorruptedMind:Play("kick1r")
			elseif count == 2 then
				specWarnCorruptedMind:Play("kick2r")
			elseif count == 3 then
				specWarnCorruptedMind:Play("kick3r")
			elseif count == 4 then
				specWarnCorruptedMind:Play("kick4r")
			elseif count == 5 then
				specWarnCorruptedMind:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnCorruptedMind:Play("kickcast")
			end
		end
	elseif spellId == 308885 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	elseif spellId == 313611 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMentalDecay:Show(args.sourceName)
		specWarnMentalDecay:Play("kickcast")
	elseif spellId == 317066 then
		if self:AntiSpam(5, 10) then
			self.vb.harvestThoughtsCount = self.vb.harvestThoughtsCount + 1
			specWarnHarvestThoughts:Show(self.vb.harvestThoughtsCount)
			specWarnHarvestThoughts:Play("gathershare")
		end
	elseif spellId == 316970 or spellId == 319349 or spellId == 319350 or spellId == 319351 then--8 second, 20 second, 5 second, 50 second
		self.vb.cleansingActive = self.vb.cleansingActive + 1
		if self:AntiSpam(3, 9) then
			self.vb.cleansingCastCount = self.vb.cleansingCastCount + 1
			warnCleansingProtocol:Show(self.vb.cleansingCastCount)
			local castTime = spellId == 316970 and 8 or spellId == 319350 and 5 or spellId == 319351 and 50 or 20
			timerCleansingProtocol:Start(castTime)
			local timer = allTimers[self.vb.difficultyName][self.vb.phase][316970][self.vb.cleansingCastCount+1] or 16
			if timer then
				timerCleansingProtocolCD:Start(timer, self.vb.cleansingCastCount+1)
			end
		end
	elseif spellId == 318449 then
		self.vb.eternalTormentCount = self.vb.eternalTormentCount + 1
		if not selfInMind then
			specWarnEternalTorment:Show(self.vb.eternalTormentCount)
			specWarnEternalTorment:Play("aesoon")
		end
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][318449][self.vb.eternalTormentCount+1]
		if timer then
			timerEternalTormentCD:Start(timer, self.vb.eternalTormentCount+1)
		else
			if self:IsMythic() and self.vb.phase == 3 then
				timerEternalTormentCD:Start(6.1, self.vb.eternalTormentCount+1)
			end
		end
	elseif spellId == 312782 then--Convergence (2-2.5 seconds slower than shattered ego, but likely more reliable for mythic)
		self.vb.harvesterCount = 0
		self.vb.harvestersAlive = 0
		self.vb.harvestThoughtsCount = 0
		self.vb.evokeAnguishCount = 0
		self.vb.stupefyingGlareCount = 0
		self.vb.addIcon = 1
		lastHarvesterTime = GetTime()
		timerMindgraspCD:Stop()--Shouldn't even be running but just in case
		timerMindgateCD:Stop()
		timerParanoiaCD:Stop()
		if self:IsMythic() then
			self.vb.phase = 2
			self.vb.paranoiaCount = 0
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			timerThoughtHarvesterCD:Start(9.5, 1)
			timerEvokeAnguishCD:Start(25, 1)
			warnStupefyingGlareSoon:Countdown(35, 5)
			timerStupefyingGlareCD:Start(35, 1 .. "L")
			self:Schedule(35, stupefyingGlareLoop, self)
			timerParanoiaCD:Start(56.6, 1)
			timerMindgraspCD:Start(58.5)
			timerSummongateway:Start(153.9)
		else
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerEvokeAnguishCD:Start(15, 1)
			timerThoughtHarvesterCD:Start(15, 1)
			timerEternalTormentCD:Start(32.8, 1)
			timerMindgraspCD:Start(71.7)
			if self:IsHeroic() then--Only place I've verified, need to find some normal videos/vods
				warnStupefyingGlareSoon:Countdown(40.5, 5)
				timerStupefyingGlareCD:Start(40.5, 1 .. "L")--direction not confirmed
				self:Schedule(40.5, stupefyingGlareLoop, self)
			end
		end
	elseif spellId == 316463 then
		warnMindGate:Show()
	elseif spellId == 318971 then
		self.vb.darkMatterCount = self.vb.darkMatterCount + 1
		specWarnDarkMatter:Show(self.vb.darkMatterCount)
		specWarnDarkMatter:Play("watchstep")
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][318971][self.vb.darkMatterCount+1]
		if timer then
			timerDarkMatterCD:Start(timer, self.vb.darkMatterCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 315927 then
		self.vb.paranoiaCount = self.vb.paranoiaCount + 1
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][315927][self.vb.paranoiaCount+1]
		if timer then
			timerParanoiaCD:Start(timer, self.vb.paranoiaCount+1)
		end
	elseif spellId == 319257 then
		neckAvailable[args.sourceName] = false
		warnDisarmCountermeasure:CombinedShow(1, args.sourceName)
		self.vb.cleansingActive = self.vb.cleansingActive - 1
		if self.vb.cleansingActive == 0 then
			timerCleansingProtocol:Stop()
		end
	elseif spellId == 317102 then
		self.vb.evokeAnguishCount = self.vb.evokeAnguishCount + 1
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][317102][self.vb.evokeAnguishCount+1]
		if timer then
			timerEvokeAnguishCD:Start(timer, self.vb.evokeAnguishCount+1)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
			if DBM.Options.DebugMode then
				DBM.InfoFrame:Show(self:IsMythic() and 20 or 8, "function", updateInfoFrame, false)
			else
				DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
			end
		end
	elseif spellId == 317066 then
		--Timer started here because if people are dying it can trigger stutter/recasts of this
		timerHarvestThoughtsCD:Start(30.2, args.sourceGUID)
	elseif spellId == 316970 or spellId == 319349 or spellId == 319350 or spellId == 319351 then
		self.vb.cleansingActive = self.vb.cleansingActive - 1
	elseif spellId == 318741 then--Neck Used
		neckAvailable[args.sourceName] = false
	elseif spellId == 318460 then
		self.vb.annihilateCastCount = self.vb.annihilateCastCount + 1
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][318460][self.vb.annihilateCastCount+1]
		if timer then
			timerAnnihilateCD:Start(timer, self.vb.annihilateCastCount+1)
		end
	elseif spellId == 312866 then
		self.vb.cataclysmCount = self.vb.cataclysmCount + 1
		if selfInMind then
			warnCataclysmicFlames:Show(self.vb.cataclysmCount)
		end
		timerCataclysmicFlamesCD:Start(22.4, self.vb.cataclysmCount+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 318091 then
		specWarnSummonGateway:Show(L.Gate or "Gate")
		specWarnSummonGateway:Play("telesoon")
		if self.vb.phase < 3 then
			self.vb.darkMatterCount = 0
			self.vb.eventHorrizonCount = 0
			self.vb.cleansingActive = 0
			self.vb.cleansingCastCount = 0
			self.vb.annihilateCastCount = 0
			self.vb.eternalTormentCount = 0
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerEternalTormentCD:Start(20, 1)
			timerEventHorizonCD:Start(20, 1)
			timerCleansingProtocolCD:Start(25, 1)
			timerDarkMatterCD:Start(39, 1)
			timerAnnihilateCD:Start(60, 1)--SUCCESS
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 313334 then
		if args:IsPlayer() then
			specWarnGiftofNzoth:Show()
			specWarnGiftofNzoth:Play("targetyou")
			timerGiftofNzoth:Start()
			yellGiftofNzothFades:Countdown(spellId)
		else
			warnGiftofNzoth:CombinedShow(1, args.destName)
		end
	elseif spellId == 308996 then
		specWarnServantofNzoth:CombinedShow(1, args.destName)
		specWarnServantofNzoth:ScheduleVoice(1, "findmc")
		if args:IsPlayer() then
			yellServantofNzoth:Yell()
		end
	elseif spellId == 309991 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 313184 or spellId == 319309 then
		local amount = args.amount or 1
		warnSynapticShock:Show(args.destName, amount)
		timerSynampticShock:Stop()
		timerSynampticShock:Start(spellId == 313184 and 30 or 15)--Non Mythic/Mythic
		if spellId == 319309 then--Add deadly icon to this on mythic
			timerSynampticShock:UpdateInline(DBM_CORE_DEADLY_ICON)
		end
	elseif spellId == 316541 or spellId == 316542 then
		ParanoiaTargets[#ParanoiaTargets + 1] = args.destName
		self:Unschedule(warnParanoiaTargets)
		self:Schedule(0.3, warnParanoiaTargets, self)
		local icon
		if #ParanoiaTargets % 2 == 0 then
			icon = #ParanoiaTargets / 2--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			local playerIsInPair = false
			--On mythic, two pairs won't have an icon available, so we just assign it SOMETHING
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			end
			if ParanoiaTargets[#ParanoiaTargets-1] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets])
				specWarnParanoia:Play("gather")
				playerIsInPair = true
			elseif ParanoiaTargets[#ParanoiaTargets] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets-1])
				specWarnParanoia:Play("gather")
				playerIsInPair = true
			end
			if not self:IsLFR() and playerIsInPair then--Only repeat yell on mythic and mythic+
				self:Unschedule(paranoiaYellRepeater)
				if type(icon) == "number" then icon = DBM_CORE_AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
				self:Schedule(2, paranoiaYellRepeater, self, icon)
			end
		end
		if args:IsPlayer() then
			yellParanoia:Yell()
		end
	elseif spellId == 313400 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 3) then
		specWarnCorruptedMindDispel:Show(args.destName)
		specWarnCorruptedMindDispel:Play("helpdispel")
	elseif spellId == 313793 then
		warnFlamesofInsanity:CombinedShow(0.3, args.destName)
	elseif spellId == 315709 then
		if args:IsPlayer() then
			specWarnTreadLightly:Show()
			specWarnTreadLightly:Play("targetyou")
		end
	elseif spellId == 315710 then
		if args:IsPlayer() then
			specWarnContempt:Show()
			specWarnContempt:Play("stopmove")
		end
	elseif (spellId == 312155 or spellId == 319015) and args:GetDestCreatureID() == 158041 then--Shattered Ego on N'Zoth
		self.vb.egoCount = self.vb.egoCount + 1
		warnShatteredEgo:Show(args.destName)
		timerShatteredEgo:Start(30)
		if not self:IsMythic() and self.vb.phase == 1 then
			self.vb.phase = 2
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
		end
		timerParanoiaCD:Stop()
		timerEternalTormentCD:Stop()
		timerMindgraspCD:Stop()
		timerBasherTentacleCD:Stop()
	elseif spellId == 318196 then
		if args:IsPlayer() then
			specWarnEventHorizon:Show()
			specWarnEventHorizon:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTank() then
				specWarnEventHorizonSwap:Show(args.destName)
				specWarnEventHorizonSwap:Play("tauntboss")
			else
				warnEventHorizon:Show(args.destName)
			end
		end
	elseif spellId == 318459 and self:AntiSpam(1, args.destName) then
		if args:IsPlayer() then
			specWarnAnnihilate:Show()
			specWarnAnnihilate:Play("runout")
			yellAnnihilate:Yell()
			yellAnnihilateFades:Countdown(spellId)
		else
			warnAnnihilate:Show(args.destName)
		end
	elseif spellId == 317112 then
		warnEvokeAnguish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEvokeAnguish:Show()
			specWarnEvokeAnguish:Play("targetyou")
			yellEvokeAnguish:Yell()
			yellEvokeAnguishFades:Countdown(spellId)
			if self.Options.RangeFrame and self:IsMythic() then
				DBM.RangeCheck:Show(4)
			end
		end
	elseif spellId == 319346 then--Infinity's Toll being applied (Players leaving mind)
		if args.sourceGUID == UnitGUID("player") then
			selfInMind = false
			UpdateTimerFades(self)
		end
	elseif spellId == 316711 then
		--It's phase 1 non mythic which means both tanks are with Psychus, or it's Convergence phase and only 1 harvester is up
		if (not self:IsMythic() and self.vb.phase == 1) or ((self:IsMythic() and self.vb.phase == 2) or self.vb.phase == 3) and self.vb.harvestersAlive == 1 then
			specWarnMindwrackTaunt:Show(args.destName)
			specWarnMindwrackTaunt:Play("changemt")
		else--In a situation 2nd tank can't taunt do to being in different phase from one another or there being 2 or more adds up with mind wrack ability
			warnMindwrack:Show(args.destName)
		end
	elseif spellId == 318714 then--Corrupted Viscera
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 158367 then--Basher Tentacle
			if self:AntiSpam(10, 4) then
				self.vb.BasherCount = self.vb.BasherCount + 1
				if not selfInMind then
					specWarnBasherTentacle:Show(self.vb.BasherCount)
					specWarnBasherTentacle:Play("bigmob")
				end
				local timer = allTimers[self.vb.difficultyName][self.vb.phase][318714][self.vb.BasherCount+1]
				if timer then
					timerBasherTentacleCD:Start(timer, self.vb.BasherCount+1)
				end
				timerVoidLashCD:Start(16.7, args.destGUID)
			end
		elseif cid == 158375 then--Corruptor
			if self.Options.SetIconOnCorruptor then
				self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon > 4 then--Cycle through 4 icons as they spawn. On mythic 2 spawn at a time so every other set it should cycle icons back to 1
				self.vb.addIcon = 1
			end
		end
	elseif spellId == 313960 then
		self.vb.blackVolleyCount = self.vb.blackVolleyCount + 1
		if selfInMind then
			warnBlackVolley:Show(self.vb.blackVolleyCount)
		end
		timerBlackVolleyCD:Start(self:IsMythic() and 20 or 19, self.vb.blackVolleyCount+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313184 or spellId == 319309 then
		timerSynampticShock:Stop()
	elseif spellId == 313334 then
		if args:IsPlayer() then
			timerGiftofNzoth:Stop()
			yellGiftofNzothFades:Cancel()
		end
	elseif (spellId == 312155 or spellId == 319015) and args:GetDestCreatureID() == 158041 then--Shattered Ego on N'Zoth
		--These always happen after this
		timerShatteredEgo:Stop()
		--Basically below only runs after first psychus phase in Stage 1 mythic/Stage 2 non mythic. 2nd one ending is start of next phase
		if (self:IsMythic() and self.vb.egoCount == 1) or (not self:IsMythic() and self.vb.egoCount <= 2) then
			self.vb.BasherCount = 0
			self.vb.paranoiaCount = 0
			self.vb.eternalTormentCount = 0
			timerVoidGazeCD:Stop()
			if self:IsMythic() then
				--Basher tentacle is instant
				timerParanoiaCD:Start(15.1, 1)--SUCCESS
				timerEternalTormentCD:Start(25.5, 1)
				timerMindgateCD:Start(55)--START
				timerMindgraspCD:Start(103)--START
			else
				timerMindgraspCD:Start(7.5)--START (basically happens immediately after 312155 ends, but it can end 18-30?
				timerBasherTentacleCD:Start(23, 1)
				timerEternalTormentCD:Start(35.3, 1)
				timerParanoiaCD:Start(50, 1)--SUCCESS (45 to START)
				timerMindgateCD:Start(68)--START
			end
		end
	elseif spellId == 318459 then
		if args:IsPlayer() then
			yellAnnihilateFades:Cancel()
		end
	elseif spellId == 317112 then
		if args:IsPlayer() then
			yellEvokeAnguishFades:Cancel()
			if self.Options.RangeFrame and self:IsMythic() then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 319346 then--Infinity's Toll fading (players entering mind)
		if args.destGUID == UnitGUID("player") and not UnitIsDeadOrGhost("player") then
			selfInMind = true
			UpdateTimerFades(self)
		end
	elseif spellId == 316541 or spellId == 316542 then
		if args:IsPlayer() then
			self:Unschedule(paranoiaYellRepeater)
		end
	elseif spellId == 318196 and self:AntiSpam(1, args.destName) then--Just to announce that event horizon is spawning an annihilate since it ended
		if args:IsPlayer() then
			specWarnAnnihilate:Show()
			specWarnAnnihilate:Play("watchstep")
			yellAnnihilate:Yell()
		else
			warnAnnihilate:Show(args.destName)--Combined show just to fix double message bug, since this work around is ONLY required for first one
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 158376 then--Psychus
		timerMindwrackCD:Stop(args.destGUID)
		timerCreepingAnguishCD:Stop()
		timerSynampticShock:Stop()
	elseif cid == 158367 then--basher-tentacle
		timerVoidLashCD:Stop(args.destGUID)
	elseif cid == 162933 then--Thought Harvester
		self.vb.harvestersAlive = self.vb.harvestersAlive - 1
		timerHarvestThoughtsCD:Stop(args.destGUID)
		timerMindwrackCD:Stop(args.destGUID)
	elseif cid == 163612 then--Voidspawn Annihilator
		self.vb.harvesterCount = 0
		self.vb.harvestersAlive = 0
		self.vb.harvestThoughtsCount = 0
		self.vb.evokeAnguishCount = 0
		self.vb.paranoiaCount = 0
		self.vb.stupefyingGlareCount = 0
		timerDarkMatterCD:Stop()
		timerAnnihilateCD:Stop()
		timerEventHorizonCD:Stop()
		timerEternalTormentCD:Stop()
		timerThoughtHarvesterCD:Start(12.3, 1)--12.6
		timerEvokeAnguishCD:Start(27.7, 1)--28
		warnStupefyingGlareSoon:Countdown(38, 5)
		timerStupefyingGlareCD:Start(38, 1 .. "R")
		self:Schedule(38, stupefyingGlareLoop, self)
		timerParanoiaCD:Start(59.5, 1)
		timerMindgraspCD:Start(61.4)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 158376 then--Psychus
				timerMindwrackCD:Start(6, GUID)
				timerCreepingAnguishCD:Start(12)
				if (self:IsMythic() and self.vb.egoCount == 0) or (not self:IsMythic() and self.vb.egoCount == 1) then
					timerCataclysmicFlamesCD:Start(19.3, 1)
				elseif (self:IsMythic() and self.vb.egoCount == 1) or (not self:IsMythic() and self.vb.egoCount == 2) then
					timerBlackVolleyCD:Start(21, 1)
				end
			elseif cid == 162933 then--Thought Harvester
				self.vb.harvestersAlive = self.vb.harvestersAlive + 1
				if self:AntiSpam(3, 1) then
					self.vb.harvesterCount = self.vb.harvesterCount + 1
					if self.Options.SpecWarnej21308switch then
						specWarnThoughtHarvester:Show(self.vb.harvesterCount)
						specWarnThoughtHarvester:Play("killmob")
					else
						warnThoughtHarvester:Show(self.vb.harvesterCount)
					end
					local timer = allTimers[self.vb.difficultyName][self.vb.phase][316711][self.vb.harvesterCount+1]
					if timer then
						timerThoughtHarvesterCD:Start(timer, self.vb.harvesterCount+1)
					else
						harvesterDebugTriggered = harvesterDebugTriggered + 1
					end
					local currentTime = GetTime() - lastHarvesterTime
					debugSpawnTable[#debugSpawnTable + 1] = math.floor(currentTime*10)/10--Floored but only after trying to preserve at least one decimal place
					lastHarvesterTime = GetTime()
					if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
						DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
						if DBM.Options.DebugMode then
							DBM.InfoFrame:Show(self:IsMythic() and 20 or 8, "function", updateInfoFrame, false)
						else
							DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
						end
					end
				end
				timerHarvestThoughtsCD:Start(self:IsMythic() and 6.4 or 8.2, GUID)
				timerMindwrackCD:Start(self:IsMythic() and 12 or 5, GUID)--Cast immediately on heroic but on mythic they cast harvest thoughts first
				if self.Options.SetIconOnCorruptor then
					SetRaidTarget(unitID, self.vb.addIcon)
				end
				self.vb.addIcon = self.vb.addIcon + 1
				if self.vb.addIcon > 4 then--Cycle through 4 icons as they spawn. On mythic 2 spawn at a time so every other set it should cycle icons back to 1
					self.vb.addIcon = 1
				end
			elseif cid == 163612 then--Voidspawn Annihilator
				if self.vb.phase == 3 then
					if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
						DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
						if DBM.Options.DebugMode then
							DBM.InfoFrame:Show(self:IsMythic() and 20 or 8, "function", updateInfoFrame, false)
						else
							DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
						end
					end
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 318196 then--Event Horizon (cast not in combat log only debuff is)
		self.vb.eventHorrizonCount = self.vb.eventHorrizonCount + 1
		local timer = allTimers[self.vb.difficultyName][self.vb.phase][318196][self.vb.eventHorrizonCount+1] or 30
		if timer then
			timerEventHorizonCD:Start(timer, self.vb.eventHorrizonCount+1)
		end
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	local currentSanity = UnitPower(uId, ALTERNATE_POWER_INDEX)
	if currentSanity > lastSanity then
		lastSanity = currentSanity
		return
	end
	if self:AntiSpam(5, 6) then--Additional throttle in case you lose sanity VERY rapidly with increased ICD for special warning
		if currentSanity == 15 and lastSanity > 15 then
			lastSanity = 15
			specwarnSanity:Show(lastSanity)
			specwarnSanity:Play("lowsanity")
		elseif currentSanity == 30 and lastSanity > 30 then
			lastSanity = 30
			specwarnSanity:Show(lastSanity)
			specwarnSanity:Play("lowsanity")
		end
	elseif self:AntiSpam(3, 7) then--Additional throttle in case you lose sanity VERY rapidly
		if currentSanity == 45 and lastSanity > 45 then
			lastSanity = 45
			warnSanity:Show(lastSanity)
		elseif currentSanity == 60 and lastSanity > 60 then
			lastSanity = 60
			warnSanity:Show(lastSanity)
		end
	end
end

function mod:CINEMATIC_STOP()
	if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
		if DBM.Options.DebugMode then
			DBM.InfoFrame:Show(self:IsMythic() and 20 or 8, "function", updateInfoFrame, false)
		else
			DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
		end
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Four" then
		self.vb.interruptBehavior = "Four"
	elseif msg == "Five" then
		self.vb.interruptBehavior = "Five"
	elseif msg == "Six" then
		self.vb.interruptBehavior = "Six"
	elseif msg == "NoReset" then
		self.vb.interruptBehavior = "NoReset"
	end
end
