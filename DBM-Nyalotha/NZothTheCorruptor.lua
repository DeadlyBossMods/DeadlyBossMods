local mod	= DBM:NewMod(2375, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158041)
mod:SetEncounterID(2344)
mod:SetZone()
mod:SetHotfixNoticeRev(20200201000000)--2020, 2, 01
mod:SetMinSyncRevision(20200201000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 311176 316711 310184 310134 310130 317292 310331 315772 309698 310042 313400 308885 317066 318196 319349 319350 319351 316970 318449 312782 316463",
	"SPELL_CAST_SUCCESS 315927 319257 317102",
	"SPELL_AURA_APPLIED 313334 308996 309991 313184 310073 311392 316541 316542 313793 315709 315710 312155 318196 318459 319309 319015 317112 319346 316711 318714",
	"SPELL_AURA_APPLIED_DOSE 313184 319309",
	"SPELL_AURA_REMOVED 313184 313334 312155 318459 317112 319346 316541 316542 319015",
	"SPELL_PERIODIC_DAMAGE 309991",
	"SPELL_PERIODIC_MISSED 309991",
--	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_POWER_FREQUENT player"
)

--TODO, figure out if mental decay cast by mind controled players can be interrupted (if they even cast it, journal for previous boss was wrong)
--TODO, find out power gains of Psychus and add timer for Manifest Madness that's more reliable (his energy soft enrage)
--TODO, build infoframe for something?
--TODO, further improve paranoia with icons/chat bubbles maybe, depends how many there are on 30 man or mythic
--TODO, verify mythic drycodes.
--TODO, P3 spells with no detection like Stupefying Glare need scheduling
--TODO, Need mythic stage trigger and verification of other stage handling
--TODO, harvester timers would be more reliable with IEEU, but that can't be pulled from public logs, which is a bit more difficult since the kind of guilds that will use transcriptor tend not to get 7 of them
--New Voice: "leavemind" and "lowsanity"
--[[
(ability.id = 318449 or ability.id = 311176 or ability.id = 316711 or ability.id = 310184 or ability.id = 316463 or ability.id = 310134 or ability.id = 310130 or ability.id = 317292 or ability.id = 310331 or ability.id = 315772 or ability.id = 309698 or ability.id = 313400 or ability.id = 308885 or ability.id = 317066 or ability.id = 318196 or ability.id = 316970 or ability.id = 319351 or ability.id = 319350 or ability.id = 319349 or ability.id = 318460 or ability.id = 312782) and type = "begincast"
 or (ability.id = 315927 or ability.id = 317102) and type = "cast"
 or ability.id = 318714 and type = "applybuff"
 or (ability.id = 312155 or ability.id = 319015)
 or ability.id = 319346 and (type = "applydebuff" or type = "removedebuff")
 or (ability.id = 309296 or ability.id = 309307) and type = "cast"
--]]
--General
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnGiftofNzoth						= mod:NewTargetNoFilterAnnounce(313334, 2)
local warnSanity							= mod:NewCountAnnounce(307831, 3)
--Stage 1: Dominant Mind
local warnGlimpseofInfinite					= mod:NewCastAnnounce(311176, 2)
----Psychus
local warnCreepingAnguish					= mod:NewCastAnnounce(310184, 4)
local warnSynapticShock						= mod:NewStackAnnounce(313184, 1)
local warnEternalHatred						= mod:NewCastAnnounce(310130, 4)
local warnCollapsingMindscape				= mod:NewCastAnnounce(317292, 2)
local warnMindwrack							= mod:NewTargetNoFilterAnnounce(316711, 4, nil, "Tank|Healer")
----Eyes of N'zoth
local warnVoidGaze							= mod:NewSpellAnnounce(310333, 3)
----Exposed Synapse

--Stage 2: Writhing Onslaught
----N'Zoth
local warnShatteredEgo						= mod:NewTargetNoFilterAnnounce(312155, 1)
local warnParanoia							= mod:NewTargetNoFilterAnnounce(309980, 3)
local warnMindGate							= mod:NewCastAnnounce(309046, 2)
----Basher tentacle
local warnTumultuousBurst					= mod:NewCastAnnounce(310042, 4, nil, nil, "Tank")
----Through the Mindgate
------Corruption of Deathwing
local warnFlamesofInsanity					= mod:NewTargetNoFilterAnnounce(313793, 2, nil, "RemoveMagic")
------Trecherous Bargain
--local warnBlackVolley						= mod:NewCastAnnounce(313960, 2)
--Stage 3 Non Mythic
local warnThoughtHarvester					= mod:NewSpellAnnounce("ej21308", 3, 231298)
--Stage 3 Mythic
local warnAnnihilate						= mod:NewTargetAnnounce(318459, 2)
local warnEvokeAnguish						= mod:NewTargetAnnounce(317112, 3)
local warnCleansingProtocol					= mod:NewCastAnnounce(319349, 2)

--General
local specWarnGiftofNzoth					= mod:NewSpecialWarningYou(313334, nil, nil, nil, 1, 2)
local yellGiftofNzothFades					= mod:NewFadesYell(313334)
local specWarnServantofNzoth				= mod:NewSpecialWarningTargetChange(308996, false, nil, 2, 1, 2)
local yellServantofNzoth					= mod:NewYell(308996)
local specwarnSanity						= mod:NewSpecialWarningCount(307831, nil, nil, nil, 1, 10)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(309991, nil, nil, nil, 1, 8)
--Stage 1: Dominant Mind
----Psychus
local specWarnMindwrack						= mod:NewSpecialWarningInterruptCount(316711, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindwrackTaunt				= mod:NewSpecialWarningTaunt(316711, nil, nil, nil, 1, 2)
local specWarnManifestMadness				= mod:NewSpecialWarningSpell(310134, nil, nil, nil, 3)--Basically an automatic wipe unless Psychus was like sub 1% health, no voice because there isn't really one that says "you're fucked"
local specWarnEternalHatred					= mod:NewSpecialWarningMoveTo(310130, nil, nil, nil, 3, 10)--No longer in journal, replaced by collapsing Mindscape, but maybe a hidden mythic mechanic now?
local specWarnCollapsingMindscape			= mod:NewSpecialWarningMoveTo(317292, nil, nil, nil, 2, 10)
----Exposed Synapse

----Reflected Self

--Stage 2: Writhing Onslaught
----N'Zoth
local specWarnMindgrasp						= mod:NewSpecialWarningSpell(315772, nil, nil, nil, 2, 2)
local yellMindgrasp							= mod:NewShortYell(315772, "%s", false, 2)
local specWarnParanoia						= mod:NewSpecialWarningMoveTo(309980, nil, nil, nil, 1, 2)
local yellParanoia							= mod:NewShortYell(309980)
local yellParanoiaRepeater					= mod:NewPosYell(309980, DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnEternalTorment				= mod:NewSpecialWarningCount(318449, nil, nil, nil, 2, 2)
----Basher Tentacle
local specWarnBasherTentacle				= mod:NewSpecialWarningSwitch("ej21286", "-Healer", nil, 2, 1, 2)
local specWarnVoidLash						= mod:NewSpecialWarningDefensive(309698, nil, nil, nil, 1, 2)
----Corruptor Tentacle
local specWarnCorruptedMind					= mod:NewSpecialWarningInterruptCount(313400, "HasInterrupt", nil, nil, 1, 2)
local specWarnCorruptedMindDispel			= mod:NewSpecialWarningDispel(313400, "RemoveMagic", nil, nil, 1, 2)
local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(308885, false, nil, nil, 1, 2)
----Through the Mindgate
------Corruption of Deathwing

------Trecherous Bargain
local specWarnTreadLightly					= mod:NewSpecialWarningYou(315709, nil, nil, nil, 1, 2)
local specWarnContempt						= mod:NewSpecialWarningStopMove(315710, nil, nil, nil, 1, 6)
--Stage 3:
----N'Zoth
local specWarnEvokeAnguish					= mod:NewSpecialWarningMoveAway(317112, nil, nil, nil, 1, 2)
local yellEvokeAnguish						= mod:NewYell(317112, nil, false, 2)
local yellEvokeAnguishFades					= mod:NewShortFadesYell(317112, nil, true, 3)
local specWarnStupefyingGlare				= mod:NewSpecialWarningDodgeCount(317874, nil, nil, nil, 2, 2)
----Thought Harvester
local specWarnThoughtHarvester				= mod:NewSpecialWarningSwitch("ej21308", false, nil, nil, 1, 2)
local specWarnHarvestThoughts				= mod:NewSpecialWarningCount(317066, nil, nil, nil, 2, 2)
--Stage 3 Mythic
local specWarnEventHorizon					= mod:NewSpecialWarningDefensive(318196, nil, nil, nil, 1, 2, 4)
local specWarnEventHorizonSwap				= mod:NewSpecialWarningTaunt(318196, nil, nil, nil, 1, 2, 4)
local specWarnAnnihilate					= mod:NewSpecialWarningMoveAway(318459, nil, nil, nil, 1, 2, 4)
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
local timerCreepingAnguishCD				= mod:NewCDTimer(28.2, 310184, nil, nil, 2, 5, nil, DBM_CORE_TANK_ICON)
local timerSynampticShock					= mod:NewBuffActiveTimer(30, 313184, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)--, nil, 1, 4
----Mind's Eye
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20977))
local timerVoidGazeCD						= mod:NewCDTimer(33, 310333, nil, nil, nil, 2)--33-34.3
----Exposed Synapse

--Stage 2: Writhing Onslaught
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20970))
----N'Zoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20917))
local timerCollapsingMindscape				= mod:NewCastTimer(20, 317292, nil, nil, nil, 6)
local timerMindgraspCD						= mod:NewCDTimer(30.1, 315772, nil, nil, nil, 3)
local timerParanoiaCD						= mod:NewCDCountTimer(30.1, 309980, nil, nil, nil, 3)
local timerMindgateCD						= mod:NewCDTimer(30.1, 309046, nil, nil, nil, 1, nil, nil, nil, 1, 5)
local timerShatteredEgo						= mod:NewBuffActiveTimer(30, 319015, nil, nil, nil, 6)
local timerEternalTormentCD					= mod:NewCDCountTimer(56.1, 318449, 311383, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--"Torment" short name
----Basher Tentacle
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21286))
local timerBasherTentacleCD					= mod:NewCDCountTimer(60, "ej21286", nil, nil, nil, 1, "319441", DBM_CORE_DAMAGE_ICON)
local timerVoidLashCD						= mod:NewCDTimer(22.9, 309698, nil, false, 2, 5, nil, DBM_CORE_TANK_ICON)
----Through the Mindgate
------Corruption of Deathwing

------Trecherous Bargain
--local timerBlackVolleyCD					= mod:NewAITimer(30.1, 313960, nil, nil, nil, 2)
--Stage 3: Convergence:
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20767))
----N'Zoth
local timerEvokeAnguishCD					= mod:NewCDCountTimer(30.5, 317102, nil, nil, nil, 3)--30.5-44.9, delayed by boss doing other stuff?
local timerStupefyingGlareCD				= mod:NewCDCountTimer(22.9, 317874, 239918, nil, nil, 3)
----Thought Harvester
local timerThoughtHarvesterCD				= mod:NewCDCountTimer(30.1, "ej21308", nil, nil, nil, 1, 231298)
local timerHarvestThoughtsCD				= mod:NewCDTimer(35.2, 317066, nil, nil, nil, 3)
--Stage 3 Mythic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21435))
local timerEventHorizonCD					= mod:NewAITimer(22.9, 318196, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--, nil, 2, 4
local timerAnnihilateCD						= mod:NewAITimer(22.9, 318460, nil, nil, nil, 3)
local timerCleansingProtocol				= mod:NewCastTimer(50, 319349, nil, nil, nil, 2)
--local timerSpawnPsychusCD					= mod:NewCDTimer(45, 311609, nil, nil, nil, 1)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307831, true)
mod:AddSetIconOption("SetIconOnCorruptor", "ej21441", true, true, {1, 2, 3, 4})
--mod:AddNamePlateOption("NPAuraOnShock", 313184)

local playersInMind = {}
local selfInMind = false
local lastSanity = 100
local seenAdds = {}
local ParanoiaTargets = {}
local castsPerGUID = {}
local mythicTimers = {
	[1] = {--TODO: Stage 1 timer sequences likely all go longer if a successful shattered ego doesn't trigger to restart the shattered ego timer cycles
		--Basher tentacles
		[318714] = {},
		--Paranoia
		[315927] = {},
		--Eternal Torment
		[318449] = {},
	},
	[2] = {
		--Eternal Torment
		[318449] = {},
		--Thought Harvester spawns
		[316711] = {},
		--Evoke Anquish
		[317102] = {},
		--Stupefying Glare
		[317874] = {},
	},
}
local heroicTimers = {
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
		[316711] = {21.1, 25.5, 42.7, 29.2, 3.6, 31.6, 3.7, 30.4, 4.8},--It might be that after 3rd cast, it just alternates between 29-30 and 3.7-4.8
		--Evoke Anquish
		[317102] = {15.3, 45.2, 32.6, 30.6, 35.3, 35.3},
		--Stupefying Glare
		[317874] = {40.5, 67.5},
	},
}
local normalTimers = {
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
		[316711] = {20.3, 25.5, 44.6, 31.2, 30.4, 43, 31.7},
		--Evoke Anquish
		[317102] = {15.3, 46.2, 31.6, 44.9, 37.7, 15.8, 51, 37.7},
		--Stupefying Glare
		[317874] = {},
	},
}
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
mod.vb.addIcon = 1
local lastHarvesterTime = 0
local debugSpawnTable = {}
local harvesterDebugTriggered = 0
local playerName = UnitName("player")

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
	end
end

local function stupefyingGlareLoop(self)
	self.vb.stupefyingGlareCount = self.vb.stupefyingGlareCount + 1
	specWarnStupefyingGlare:Show(self.vb.stupefyingGlareCount)
	specWarnStupefyingGlare:Play("farfromline")
	local timer = self:Mythic() and mythicTimers[self.vb.phase][317874][self.vb.stupefyingGlareCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][317874][self.vb.stupefyingGlareCount+1] or self:IsEasy() and normalTimers[self.vb.phase][317874][self.vb.stupefyingGlareCount+1]
	if timer then
		timerStupefyingGlareCD:Start(timer, self.vb.stupefyingGlareCount+1)
		self:Schedule(timer, stupefyingGlareLoop, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.eternalTormentCount = 0
	self.vb.BasherCount = 0
	self.vb.paranoiaCount = 0
	self.vb.stupefyingGlareCount = 0
	self.vb.egoCount = 0
	self.vb.addIcon = 1
	lastHarvesterTime = 0
	table.wipe(debugSpawnTable)
	table.wipe(castsPerGUID)
	harvesterDebugTriggered = 0
	if self:IsMythic() then
		self.vb.phase = 1
	else
		self.vb.phase = 0
	end
	table.wipe(playersInMind)
	selfInMind = false
	lastSanity = 100
	table.wipe(seenAdds)
	table.wipe(ParanoiaTargets)
	UpdateTimerFades(self)
	berserkTimer:Start(720-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
		DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
	end
	--if self.Options.NPAuraOnShock then
	--	DBM:FireEvent("BossMod_EnableHostileNameplates")
	--end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	--if self.Options.NPAuraOnShock then
	--	DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	--end
	DBM:AddMsg("Harvester Spawn Timers collected. If you see this message, Please report these numbers and raid difficulty to DBM author: " .. table.concat(debugSpawnTable, ", "))
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		if not DBM:UnitDebuff(uId, 319346) then
			local name = DBM:GetUnitFullName(uId)
			table.insert(playersInMind, name)
			if UnitIsUnit("player", uId) and not UnitIsDeadOrGhost("player") then
				selfInMind = true
				UpdateTimerFades(self)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 311176 then
		self.vb.phase = 1--Non Mythic
		warnGlimpseofInfinite:Show()
		--Start P1 timers here, more accurate, especially if boss forgets to cast this :D
		timerVoidGazeCD:Start(14.7)
	elseif spellId == 316711 then
		timerMindwrackCD:Start(4.9, args.sourceGUID)
		--Backup, if they have a pile of harvesters the game might run out of boss unit IDs and not assign one
		if (args:GetSrcCreatureID() == 162933) and not seenAdds[args.sourceGUID] then
			seenAdds[args.sourceGUID] = true
			self.vb.harvesterCount = self.vb.harvesterCount + 1
			self.vb.harvestersAlive = self.vb.harvestersAlive + 1
			if self.Options.SpecWarnej21308switch then
				specWarnThoughtHarvester:Show()
				specWarnThoughtHarvester:Play("killmob")
			else
				warnThoughtHarvester:Show()
			end
			local timer = self:Mythic() and mythicTimers[self.vb.phase][316711][self.vb.harvesterCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][316711][self.vb.harvesterCount+1] or self:IsEasy() and normalTimers[self.vb.phase][316711][self.vb.harvesterCount+1]
			if timer then
				timerThoughtHarvesterCD:Start(timer, self.vb.harvesterCount+1)
			end
		else--Not thought harvester, actually interruptable
			if not castsPerGUID[args.sourceGUID] then
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
		end
	elseif spellId == 310184 then
		if selfInMind then
			warnCreepingAnguish:Show()
		end
		timerCreepingAnguishCD:Start(28.2)
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
		else
			warnCollapsingMindscape:Show()
		end
		timerCollapsingMindscape:Start(20)
	elseif spellId == 310331 then
		warnVoidGaze:Show()
		timerVoidGazeCD:Start(33)
	elseif spellId == 315772 then
		specWarnMindgrasp:Show()
		specWarnMindgrasp:Play("specialsoon")
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
		specWarnMindFlay:Show(args.sourceGUID)
		specWarnMindFlay:Play("kickcast")
	--elseif spellId == 313960 then
		--warnBlackVolley:Show()
		--timerBlackVolleyCD:Start()
	elseif spellId == 317066 then
		self.vb.harvestThoughtsCount = self.vb.harvestThoughtsCount + 1
		if self:AntiSpam(5, 10) then
			specWarnHarvestThoughts:Show(self.vb.harvestThoughtsCount)
			specWarnHarvestThoughts:Play("gathershare")
		end
		timerHarvestThoughtsCD:Start(35.2, args.sourceGUID)
	elseif spellId == 318196 then
		timerEventHorizonCD:Start()
	elseif (spellId == 316970 or spellId == 319351 or spellId == 319350 or spellId == 319349) and self:AntiSpam(3, 9) then--All spellIds until we know which one is valid. Filtered by antispam in case more than one of these fires for it
		warnCleansingProtocol:Show()
		timerCleansingProtocol:Start()
	elseif spellId == 318460 then
		timerAnnihilateCD:Start()
	elseif spellId == 318449 then
		self.vb.eternalTormentCount = self.vb.eternalTormentCount + 1
		if not selfInMind then
			specWarnEternalTorment:Show(self.vb.eternalTormentCount)
			specWarnEternalTorment:Play("aesoon")
		end
		local timer = self:IsMythic() and mythicTimers[self.vb.phase][318449][self.vb.eternalTormentCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][318449][self.vb.eternalTormentCount+1] or self:IsEasy() and normalTimers[self.vb.phase][318449][self.vb.eternalTormentCount+1]
		if timer then
			timerEternalTormentCD:Start(timer, self.vb.eternalTormentCount+1)
		end
	elseif spellId == 312782 then--Convergence (2-2.5 seconds slower than shattered ego, but likely more reliable for mythic)
		if self:IsMythic() then
			self.vb.phase = 2
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
		else
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
		end
		self.vb.harvesterCount = 0
		self.vb.harvestersAlive = 0
		self.vb.harvestThoughtsCount = 0
		self.vb.evokeAnguishCount = 0
		lastHarvesterTime = GetTime()
		timerMindgraspCD:Stop()--Shouldn't even be running but just in case
		timerMindgateCD:Stop()
		timerParanoiaCD:Stop()
		timerEvokeAnguishCD:Start(15, 1)
		timerThoughtHarvesterCD:Start(21.1, 1)
		timerEternalTormentCD:Start(32.8, 1)
		timerMindgraspCD:Start(71.7)
		if self:IsHard() then--Only place I've verified, need to find some normal videos/vods
			timerStupefyingGlareCD:Start(40.5)
			self:Schedule(40.5, stupefyingGlareLoop, self)
		end
	elseif spellId == 316463 then
		warnMindGate:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 315927 then
		self.vb.paranoiaCount = self.vb.paranoiaCount + 1
		local timer = self:IsMythic() and mythicTimers[self.vb.phase][315927][self.vb.paranoiaCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][315927][self.vb.paranoiaCount+1] or self:IsEasy() and normalTimers[self.vb.phase][315927][self.vb.paranoiaCount+1]
		if timer then
			timerParanoiaCD:Start(timer, self.vb.paranoiaCount+1)
		end

	elseif spellId == 319257 then
		--timerCleansingProtocol:Stop()
	elseif spellId == 317102 then
		self.vb.evokeAnguishCount = self.vb.evokeAnguishCount + 1
		local timer = self:Mythic() and mythicTimers[self.vb.phase][317102][self.vb.evokeAnguishCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][317102][self.vb.evokeAnguishCount+1] or self:IsEasy() and normalTimers[self.vb.phase][317102][self.vb.evokeAnguishCount+1]
		if timer then
			timerEvokeAnguishCD:Start(timer, self.vb.harvesterCount+1)
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
	elseif spellId == 310073 or spellId == 311392 then
		if args:IsPlayer() then
			local text = spellId == 310073 and L.Away or L.Toward
			yellMindgrasp:Yell(text)
		end
	elseif spellId == 316541 or spellId == 316542 then
		ParanoiaTargets[#ParanoiaTargets + 1] = args.destName
		self:Unschedule(warnParanoiaTargets)
		self:Schedule(0.3, warnParanoiaTargets, self)
		local icon
		if #ParanoiaTargets % 2 == 0 then
			icon = #ParanoiaTargets / 2--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			--On mythic, two pairs won't have an icon available, so we just assign it SOMETHING
			if icon == 9 then
				icon = "(ツ)"--(စ‿စ)
			elseif icon == 10 then
				icon = "(•_•)"
			end
			if ParanoiaTargets[#ParanoiaTargets-1] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets])
				specWarnParanoia:Play("gather")
			elseif ParanoiaTargets[#ParanoiaTargets] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets-1])
				specWarnParanoia:Play("gather")
			end
			if not self:IsLFR() and args:IsPlayer() then--Only repeat yell on mythic and mythic+
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
			if self:IsTanking(uId) then--Just in case it can go on non tanks
				specWarnEventHorizonSwap:Show(args.destName)
				specWarnEventHorizonSwap:Play("tauntboss")
			end
		end
	elseif spellId == 318459 then
		warnAnnihilate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnAnnihilate:Show()
			specWarnAnnihilate:Play("runout")
			yellAnnihilate:Yell()
			yellAnnihilateFades:Countdown(spellId)
		end
	elseif spellId == 317112 then
		warnEvokeAnguish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEvokeAnguish:Show()
			specWarnEvokeAnguish:Play("runout")
			yellEvokeAnguish:Yell()
			yellEvokeAnguishFades:Countdown(spellId)
		end
	elseif spellId == 319346 then--Infinity's Toll being applied (Players leaving mind)
		tDeleteItem(playersInMind, args.sourceName)
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
				local timer = self:IsMythic() and mythicTimers[self.vb.phase][318714][self.vb.BasherCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][318714][self.vb.BasherCount+1] or self:IsEasy() and normalTimers[self.vb.phase][318714][self.vb.BasherCount+1]
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313184 then
		timerSynampticShock:Stop()
	elseif spellId == 313334 then
		if args:IsPlayer() then
			timerGiftofNzoth:Stop()
			yellGiftofNzothFades:Cancel()
		end
	elseif (spellId == 312155 or spellId == 319015) and args:GetDestCreatureID() == 158041 then--Shattered Ego on N'Zoth
		--These always happen after this
		timerShatteredEgo:Stop()
		self.vb.eternalTormentCount = 0--Variable used in P2 (P1 Mythic) and P3 (P2 Mythic)
		if self.vb.egoCount < 3 then
			self.vb.BasherCount = 0
			self.vb.paranoiaCount = 0
			if self:IsMythic() then

			else
				timerMindgraspCD:Start(7.5)--START (basically happens immediately after 312155 ends, but it can end 18-30?
				timerBasherTentacleCD:Start(23, 1)
				timerEternalTormentCD:Start(35.3, 1)
				timerParanoiaCD:Start(50, 1)--SUCCESS (45 to START)
				timerMindgateCD:Start(72.9)--START
			end
		end
	elseif spellId == 318459 then
		if args:IsPlayer() then
			yellAnnihilateFades:Cancel()
		end
	elseif spellId == 317112 then
		if args:IsPlayer() then
			yellEvokeAnguishFades:Cancel()
		end
	elseif spellId == 319346 then--Infinity's Toll fading (players entering mind)
		if not tContains(playersInMind, args.destName) then
			table.insert(playersInMind, args.destName)
		end
		if args.destGUID == UnitGUID("player") and not UnitIsDeadOrGhost("player") then
			selfInMind = true
			UpdateTimerFades(self)
		end
	elseif spellId == 316541 or spellId == 316542 then
		if args:IsPlayer() then
			self:Unschedule(paranoiaYellRepeater)
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

--[[
function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 158376 then--Psychus
		timerMindwrackCD:Stop(args.destGUID)
		timerCreepingAnguishCD:Stop()
		timerSynampticShock:Stop()
	--elseif cid == 158122 then--Eyes of N'zoth
		--timerVoidGazeCD:Stop(args.destGUID)
	--elseif cid == 159578 then--exposed-synapse

	--elseif cid == 158374 then--mindgate-tentacle

	elseif cid == 158367 then--basher-tentacle
		timerVoidLashCD:Stop(args.destGUID)
	elseif cid == 162933 then--Thought Harvester
		self.vb.harvestersAlive = self.vb.harvestersAlive - 1
		timerHarvestThoughtsCD:Stop(args.destGUID)
	--elseif cid == 158375 then--corruptor-tentacle

	--elseif cid == 160249 then--spike-tentacle

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
				timerMindwrackCD:Start(6)
				timerCreepingAnguishCD:Start(12)
			elseif cid == 162933 and not seenAdds[GUID] then--Thought Harvester
				seenAdds[GUID] = true
				self.vb.harvesterCount = self.vb.harvesterCount + 1
				self.vb.harvestersAlive = self.vb.harvestersAlive + 1
				if self.Options.SpecWarnej21308switch then
					specWarnThoughtHarvester:Show()
					specWarnThoughtHarvester:Play("killmob")
				else
					warnThoughtHarvester:Show()
				end
				local timer = self:Mythic() and mythicTimers[self.vb.phase][316711][self.vb.harvesterCount+1] or self:IsHeroic() and heroicTimers[self.vb.phase][316711][self.vb.harvesterCount+1] or self:IsEasy() and normalTimers[self.vb.phase][316711][self.vb.harvesterCount+1]
				if timer then
					timerThoughtHarvesterCD:Start(timer, self.vb.harvesterCount+1)
				end
				local currentTime = GetTime() - lastHarvesterTime
				debugSpawnTable[self.vb.harvesterCount] = math.floor(currentTime*10)/10--Floored but only after trying to preserve at least one decimal place
				lastHarvesterTime = GetTime()
			end
		end
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("INTERFACE\\ICONS\\ACHIEVEMENT_BOSS_YOGGSARON_01.BLP") and self:AntiSpam(5, 4) then
		self:SendSync("BasherTentacle")--Synced since event is only seen outside mind, and people in mind should at least get the timer
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 311609 then--Spawn Psychus (used in Stage 3 by Thought Harvesters?)
		timerSpawnPsychusCD:Start()
	end
end
--]]

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
