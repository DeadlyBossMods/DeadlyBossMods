local mod	= DBM:NewMod(2375, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158041)
mod:SetEncounterID(2344)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 311176 316711 310184 310134 310130 317292 310331 315772 309698 310042 313400 308885 317066 318196 319349 319350 319351 316970 318449",
	"SPELL_CAST_SUCCESS 315927 316463 319257 317102",
	"SPELL_AURA_APPLIED 313334 308996 309991 313184 310073 311392 316541 316542 313793 315709 315710 312155 318196 318459 319309 319015 317112 319346",
	"SPELL_AURA_APPLIED_DOSE 313184 319309",
	"SPELL_AURA_REMOVED 313184 313334 312155 318459 317112 319346",
	"SPELL_PERIODIC_DAMAGE 309991",
	"SPELL_PERIODIC_MISSED 309991",
--	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_POWER_FREQUENT player"
)

--TODO, figure out if mental decay cast by mind controled players can be interrupted (if they even cast it, journal for previous boss was wrong)
--TODO, find out power gains of Psychus and add timer for Manifest Madness that's more reliable (his energy soft enrage)
--TODO, build infoframe for something?
--TODO, further improve paranoia with icons/chat bubbles maybe, depends how many there are on 30 man or mythic
--TODO, figure out the abilities that were removed from journal in latest update. The spells still exist and weren't removing, indicating maybe those harder mechanics were moved to mythic only
--TODO, verify mythic drycodes.
--TODO, P3 spells not in combat log like Stupefying Glare as well as some of tentacle spawns
--TODO, phase 3 trigger still needs review. Simply using 2 phase 2 mind phases defeated may not be reliable enough but is currently what is used
--New Voice: "leavemind" and "lowsanity"
--[[
(ability.id = 318449 or ability.id = 311176 or ability.id = 316711 or ability.id = 310184 or ability.id = 310134 or ability.id = 310130 or ability.id = 317292 or ability.id = 310331 or ability.id = 315772 or ability.id = 309698 or ability.id = 313400 or ability.id = 308885 or ability.id = 317066 or ability.id = 318196 or ability.id = 316970 or ability.id = 319351 or ability.id = 319350 or ability.id = 319349 or ability.id = 318460) and type = "begincast"
 or (ability.id = 315927 or ability.id = 316463 or ability.id = 317102) and type = "cast"
 or ability.id = 319346 and (type = "applydebuff" or type = "removedebuff")
 or (ability.id = 312155 or ability.id = 319015)
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
----Corruptor Tentacle
local warnCorruptorTentacle					= mod:NewSpellAnnounce("ej21107", 2)
----Spike Tentacle
--local warnSpikeTentacle						= mod:NewSpellAnnounce("ej21001", 2)
----Through the Mindgate
------Corruption of Deathwing
local warnFlamesofInsanity					= mod:NewTargetNoFilterAnnounce(313793, 2, nil, "RemoveMagic")
------Trecherous Bargain
--local warnBlackVolley						= mod:NewCastAnnounce(313960, 2)
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
local specWarnMindwrack						= mod:NewSpecialWarningDefensive(316711, false, nil, 2, 1, 2)
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
local yellParanoia							= mod:NewYell(309980)
local specWarnEternalTorment				= mod:NewSpecialWarningCount(318449, nil, nil, nil, 2, 2)
----Basher Tentacle
local specWarnBasherTentacle				= mod:NewSpecialWarningSwitch("ej21286", "Tank", nil, nil, 1, 2)--Maybe DPS too?
local specWarnVoidLash						= mod:NewSpecialWarningDefensive(309698, nil, nil, nil, 1, 2)
----Corruptor Tentacle
local specWarnCorruptedMind					= mod:NewSpecialWarningInterrupt(313400, "HasInterrupt", nil, nil, 1, 2)
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
local yellEvokeAnguish						= mod:NewYell(317112)
local yellEvokeAnguishFades					= mod:NewShortFadesYell(317112)
----Thought Harvester
local specWarnHarvestThoughts				= mod:NewSpecialWarningMoveTo(317066, nil, nil, nil, 2, 2)
--Stage 3 Mythic
local specWarnEventHorizon					= mod:NewSpecialWarningDefensive(318196, nil, nil, nil, 1, 2)
local specWarnEventHorizonSwap				= mod:NewSpecialWarningTaunt(318196, nil, nil, nil, 1, 2)
local specWarnAnnihilate					= mod:NewSpecialWarningMoveAway(318459, nil, nil, nil, 1, 2)
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
local timerParanoiaCD						= mod:NewCDTimer(30.1, 309980, nil, nil, nil, 3)
local timerMindgateCD						= mod:NewCDTimer(30.1, 309046, nil, nil, nil, 1, nil, nil, nil, 1, 5)
local timerShatteredEgo						= mod:NewBuffActiveTimer(30, 319015, nil, nil, nil, 6)
local timerEternalTormentCD					= mod:NewCDCountTimer(56.1, 318449, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
----Basher Tentacle
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21286))
local timerBasherTentacleCD					= mod:NewCDTimer(60, "ej21286", nil, nil, nil, 1, 309698, DBM_CORE_DAMAGE_ICON)
local timerVoidLashCD						= mod:NewCDTimer(22.9, 309698, nil, false, 2, 5, nil, DBM_CORE_TANK_ICON)
----Corruptor Tentacle
--local timerCorruptorTentacleCD			= mod:NewCDTimer(5.3, "ej21107", nil, nil, nil, 1, 313400, DBM_CORE_DAMAGE_ICON)
----Spike Tentacle
--local timerSpikeTentacleCD				= mod:NewCDTimer(5.3, "ej21001", nil, nil, nil, 1, 312078, DBM_CORE_DAMAGE_ICON)
----Through the Mindgate
------Corruption of Deathwing

------Trecherous Bargain
--local timerBlackVolleyCD					= mod:NewAITimer(30.1, 313960, nil, nil, nil, 2)
--Stage 3: Convergence:
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20767))
----N'Zoth
local timerEvokeAnguishCD					= mod:NewCDTimer(30.5, 317102, nil, nil, nil, 3)--30.5-44.9, delayed by boss doing other stuff?
--local timerStupefyingGlareCD				= mod:NewAITimer(22.9, 317874, nil, nil, nil, 3)
----Thought Harvester
--local timerHarvestThoughtsCD				= mod:NewAITimer(30.1, 317066, nil, nil, nil, 2)
--Stage 3 Mythic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21435))
local timerEventHorizonCD					= mod:NewAITimer(22.9, 318196, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--, nil, 2, 4
local timerAnnihilateCD						= mod:NewAITimer(22.9, 318460, nil, nil, nil, 3)
local timerCleansingProtocol				= mod:NewCastTimer(50, 319349, nil, nil, nil, 2)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307831, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
--mod:AddNamePlateOption("NPAuraOnShock", 313184)

local playersInMind = {}
local selfInMind = false
local lastSanity = 100
local seenAdds = {}
local ParanoiaTargets = {}
local stage2BasherTimers = {36, 60, 40}--40, 54.7, 50.2, 89.1? These are guesses from combat log, need transcriptor to fix add timers
local stage2EternalTormentTimers = {35.3, 56, 30.5, 19.5}
local stage3EternalTormentTimers = {35.3, 72, 11}
mod.vb.phase = 0
mod.vb.BasherCount = 0
mod.vb.egoCount = 0
mod.vb.evokeAnguishCount = 0
mod.vb.eternalTormentCount = 0

local function warnParanoiaTargets()
	warnParanoia:Show(table.concat(ParanoiaTargets, "<, >"))
	table.wipe(ParanoiaTargets)
end

local function UpdateTimerFades(self)
	if selfInMind then
		--Outside
		timerMindgraspCD:SetFade(true)
		timerParanoiaCD:SetFade(true)
		timerBasherTentacleCD:SetFade(true)
		timerVoidLashCD:SetFade(true)
		timerEternalTormentCD:SetFade(true)
		--Mindscape
		timerMindwrackCD:SetFade(false)
		timerCreepingAnguishCD:SetFade(false)
		timerVoidGazeCD:SetFade(false)
	else
		--Outside
		timerMindgraspCD:SetFade(false)
		timerParanoiaCD:SetFade(false)
		timerBasherTentacleCD:SetFade(false)
		timerVoidLashCD:SetFade(false)
		timerEternalTormentCD:SetFade(false)
		--Mindscape
		timerMindwrackCD:SetFade(true)
		timerCreepingAnguishCD:SetFade(true)
		timerVoidGazeCD:SetFade(true)
	end
end

function mod:OnCombatStart(delay)
	if self:IsMythic() then
		self.vb.phase = 1
		self.vb.egoCount = 0
		--Assumptions from phase 2 start timers for non mythic
		timerMindgraspCD:Start(18.7)
		timerBasherTentacleCD:Start(36, 1)
		--timerSpikeTentacleCD:Start(27.9)
		--timerCorruptorTentacleCD:Start(32)
	else
		self.vb.phase = 0
	end
	self.vb.BasherCount = 0
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
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		if not DBM:UnitDebuff(uId, 319346) then
			local name = DBM:GetUnitFullName(uId)
			table.insert(playersInMind, name)
			if UnitIsUnit("player", uId) then
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
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then
				specWarnMindwrack:Show()
				specWarnMindwrack:Play("defensive")
				break
			end
		end
		if args:GetSrcCreatureID() == 158041 then--Big guy
			timerMindwrackCD:Start(5.6, args.sourceGUID)
		else--Tentacles in P3
			timerMindwrackCD:Start(8.6, args.sourceGUID)
		end
	elseif spellId == 310184 then
		warnCreepingAnguish:Show()
		timerCreepingAnguishCD:Start()
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
		timerMindgraspCD:Start()
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
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCorruptedMind:Show(args.sourceGUID)
			specWarnCorruptedMind:Play("kickcast")
		end
		if not seenAdds[args.sourceGUID] then
			seenAdds[args.sourceGUID] = true
			if self:AntiSpam(3, 11) then
				warnCorruptorTentacle:Show()
			end
		end
	elseif spellId == 308885 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceGUID)
		specWarnMindFlay:Play("kickcast")
	--elseif spellId == 313960 then
		--warnBlackVolley:Show()
		--timerBlackVolleyCD:Start()
	elseif spellId == 317066 then
		if self:AntiSpam(5, 10) then
			specWarnHarvestThoughts:Show(DBM_ALLY)
			specWarnHarvestThoughts:Play("gathershare")
		end
		--timerHarvestThoughtsCD:Start()
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
		local timer = self.vb.phase == 2 and stage2EternalTormentTimers[self.vb.eternalTormentCount+1] or stage3EternalTormentTimers[self.vb.eternalTormentCount+1]
		if timer then
			timerEternalTormentCD:Start(timer, self.vb.eternalTormentCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 315927 then
		--timerParanoiaCD:Start()
	elseif spellId == 316463 then
		warnMindGate:Show()
		--timerMindgateCD:Start()
	elseif spellId == 319257 then
		--timerCleansingProtocol:Stop()
	elseif spellId == 317102 then
		self.vb.evokeAnguishCount = self.vb.evokeAnguishCount + 1
		timerEvokeAnguishCD:Start(self.vb.evokeAnguishCount == 1 and 46 or 30.5)
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
		self:Schedule(0.3, warnParanoiaTargets)
		if #ParanoiaTargets % 2 == 0 then
			if ParanoiaTargets[#ParanoiaTargets-1] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets])
				specWarnParanoia:Play("gather")
			elseif ParanoiaTargets[#ParanoiaTargets] == UnitName("player") then
				specWarnParanoia:Show(ParanoiaTargets[#ParanoiaTargets-1])
				specWarnParanoia:Play("gather")
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
	elseif (spellId == 312155 or spellId == 319015) and args:GetDestCreatureID() == 158041 then--Shattered Psyche on N'Zoth
		self.vb.egoCount = self.vb.egoCount + 1
		warnShatteredEgo:Show(args.destName)
		timerShatteredEgo:Start(30)
		if not self:IsMythic() and self.vb.phase == 1 then
			self.vb.phase = 2
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			timerBasherTentacleCD:Start(36, 1)--40.1 til first cast they do
			--timerSpikeTentacleCD:Start(27.9)
			--timerCorruptorTentacleCD:Start(32)
		end
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
	elseif (spellId == 312155 or spellId == 319015) and args:GetDestCreatureID() == 158041 then--Shattered Psyche on N'Zoth
		--These always happen after this
		timerShatteredEgo:Stop()
		self.vb.eternalTormentCount = 0
		if self.vb.egoCount < 3 then
			timerMindgraspCD:Start(8.1)--START (basically happens immediately after 312155 ends, but it can end 18-30?
			timerEternalTormentCD:Start(35.3, 1)
			timerParanoiaCD:Start(50)--SUCCESS (45 to START)
			timerMindgateCD:Start(72.9)--START
		else
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			timerMindgraspCD:Stop()--Shouldn't even be running but just in case
			timerMindgateCD:Stop()
			timerParanoiaCD:Stop()
			timerEvokeAnguishCD:Start(17)
			timerEternalTormentCD:Start(35.3, 1)
			timerMindgraspCD:Start(74.5)
			--timerStupefyingGlareCD:Start()
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
		if args.destGUID == UnitGUID("player") then
			selfInMind = true
			UpdateTimerFades(self)
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

	--elseif cid == 161845 then--reflected-self

	--elseif cid == 158374 then--mindgate-tentacle

	elseif cid == 158367 then--basher-tentacle
		timerVoidLashCD:Stop(args.destGUID)
	elseif cid == 162933 then--Thought Harvester
		--timerHarvestThoughtsCD:Stop(args.destGUID)
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
			if cid == 158367 then--Basher Tentacle
				timerVoidLashCD:Start(15, GUID)
			elseif cid == 158376 then--Psychus
				timerMindwrackCD:Start(6)
				timerCreepingAnguishCD:Start(12)
				--self:SendSync("PsychusEngaged")--He doesn't create a boss frame for players not in mind so we need to sync event
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("INTERFACE\\ICONS\\ACHIEVEMENT_BOSS_YOGGSARON_01.BLP") and self:AntiSpam(5, 4) then
		self:SendSync("BasherTentacle")--Synced since event is only seen outside mind, and people in mind should at least get the timer
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 315917 then--Tentacle Skirt
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 158367 then--Basher Tentacle (faster than IEEU, we want timer to start here, IEEU is for counting how many of them there are since this event only fires ONCE)
			--specWarnBasherTentacle:Show()
			--specWarnBasherTentacle:Play("bigmob")
			--timerVoidLashCD:Start(15)
			timerBasherTentacleCD:Start(60)
		--elseif cid == 160249 then--Spike tentacle
			--warnSpikeTentacle:Show()
			--timerSpikeTentacleCD:Start()
		--elseif cid == 158375 then--corruptor-tentacle

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

function mod:OnSync(msg, targetName)
	if not self:IsInCombat() then return end
	if msg == "BasherTentacle" then
		self.vb.BasherCount = self.vb.BasherCount + 1
		if not selfInMind then
			specWarnBasherTentacle:Show(self.vb.BasherCount)
			specWarnBasherTentacle:Play("bigmob")
		end
		local timer = stage2BasherTimers[self.vb.BasherCount+1]
		if timer then
			timerBasherTentacleCD:Start(timer, self.vb.BasherCount+1)
		end
	--elseif msg == "PsychusEngaged" and self:AntiSpam(5, 5) then
	--	timerMindwrackCD:Start(6)
	--	timerCreepingAnguishCD:Start(12)
	end
end
