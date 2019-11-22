local mod	= DBM:NewMod(2375, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158041)--161520?
mod:SetEncounterID(2344)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 311176 316711 310184 310134 310130 317292 310331 315772 309698 310042 313400 308885 317066",
	"SPELL_CAST_SUCCESS 317292 315927 316463 309296 309307",
	"SPELL_AURA_APPLIED 313334 308996 309991 313184 308842 310073 311392 316541 316542 313793 315709 315710",
	"SPELL_AURA_APPLIED_DOSE 313184",
	"SPELL_AURA_REMOVED 313184 308842 313334",
	"SPELL_PERIODIC_DAMAGE 309991",
	"SPELL_PERIODIC_MISSED 309991",
--	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, figure out if mental decay cast by mind controled players can be interrupted (if they even cast it, journal for previous boss was wrong)
--TODO, find out power gains of animus and add timer for Manifest Madness that's more reliable
--TODO, find a good way improving detecting players in mind (currently ground work is in but do to combat log phasing it's flawed without adding syncing or blizz fixing combat log phasing
--TODO, build infoframe up to show mind phase players if detection works and sort this to the top when mechanics that require players leaving said phase are present
--TODO, timer fading based on phase player is in, once further review of player realm phaseing is done and thoroughly tested
--TODO, add AI timers will likely screw up. That will be fixed when they are converted to real timers
--TODO, further improve paranoia with icons/chat bubbles maybe, depends how many there are on 30 man or mythic
--TODO, handle visions phases
--TODO, figure out the abilities that were removed from journal in latest update. The spells still exist and weren't removing, indicating maybe those harder mechanics were moved to mythic only
--New Voice: "leavemind"
--General
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnGiftofNzoth						= mod:NewTargetNoFilterAnnounce(313334, 2)
--Stage 1: Dominant Mind
local warnGlimpseofInfinite					= mod:NewCastAnnounce(311176, 2)
----Animus
local warnCreepingAnguish					= mod:NewCastAnnounce(310184, 4)
local warnSynapticShock						= mod:NewStackAnnounce(313184, 1)
local warnEternalHatred						= mod:NewCastAnnounce(310130, 4)
local warnCollapsingMindscape				= mod:NewCastAnnounce(317292, 2)
----Eyes of N'zoth
local warnVoidGaze							= mod:NewSpellAnnounce(310333, 3)
----Exposed Synapse

--Stage 2: Writhing Onslaught
----N'Zoth
local warnParanoia							= mod:NewTargetNoFilterAnnounce(309980, 3)
local warnMindGate							= mod:NewCastAnnounce(309046, 2)
----Basher tentacle
local warnTumultuousBurst					= mod:NewCastAnnounce(310042, 4, nil, nil, "Tank")
----Corruptor Tentacle
local warnCorruptorTentacle					= mod:NewSpellAnnounce("ej21107", 2)
----Spike Tentacle
local warnSpikeTentacle						= mod:NewSpellAnnounce("ej21001", 2)
----Through the Mindgate
------Corruption of Deathwing
local warnFlamesofInsanity					= mod:NewTargetNoFilterAnnounce(313793, 2, nil, "RemoveMagic")
------Trecherous Bargain
--local warnBlackVolley						= mod:NewCastAnnounce(313960, 2)

--General
local specWarnGiftofNzoth					= mod:NewSpecialWarningYou(313334, nil, nil, nil, 1, 2)
local specWarnServantofNzoth				= mod:NewSpecialWarningTargetChange(308996, "-Healer", nil, nil, 1, 2)
local yellServantofNzoth					= mod:NewYell(308996)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(309991, nil, nil, nil, 1, 8)
--Stage 1: Dominant Mind
----Animus
local specWarnMindwrack						= mod:NewSpecialWarningDefensive(316711, nil, nil, nil, 1, 2)
local specWarnManifestMadness				= mod:NewSpecialWarningSpell(310134, nil, nil, nil, 3)--Basically an automatic wipe unless animus was like sub 1% health, no voice because there isn't really one that says "you're fucked"
local specWarnEternalHatred					= mod:NewSpecialWarningMoveTo(310130, nil, nil, nil, 3, 10)--No longer in journal, replaced by collapsing Mindscape, but maybe a hidden mythic mechanic now?
local specWarnCollapsingMindscape			= mod:NewSpecialWarningMoveTo(317292, nil, nil, nil, 2, 10)
----Exposed Synapse

----Reflected Self

--Stage 2: Writhing Onslaught
----N'Zoth
local specWarnMindgrasp						= mod:NewSpecialWarningYouCount(315772, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(315772), nil, 2, 2)
local yellMindgrasp							= mod:NewShortYell(315772, "%s", false, 2)
local specWarnParanoia						= mod:NewSpecialWarningMoveTo(309980, nil, nil, nil, 1, 2)
local yellParanoia							= mod:NewYell(309980)
----Basher Tentacle
--local specWarnBasherTentacle				= mod:NewSpecialWarningSwitch("ej20762", "Tank", nil, nil, 1, 2)--Maybe DPS too?
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
----Thought Harvester
local specWarnHarvestThoughts				= mod:NewSpecialWarningMoveTo(317066, nil, nil, nil, 2, 2)

--mod:AddTimerLine(BOSS)
--General
local timerGiftofNzoth						= mod:NewBuffFadesTimer(20, 313334, nil, nil, nil, 5)
--local berserkTimer						= mod:NewBerserkTimer(600)
--Stage 1: Dominant Mind
----Animus
local timerMindwrackCD						= mod:NewCDTimer(4.9, 316711, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)--4.9-8.6
local timerCreepingAnguishCD				= mod:NewNextTimer(24.4, 310184, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSynampticShock					= mod:NewBuffActiveTimer(20, 313184, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
----Eyes of N'zoth
local timerVoidGazeCD						= mod:NewCDTimer(33, 310333, nil, nil, nil, 2)--33-34.3
----Exposed Synapse

--Stage 2: Writhing Onslaught
----N'Zoth
local timerCollapsingMindscape				= mod:NewCastTimer(20, 317292, nil, nil, nil, 6)
local timerMindgraspCD						= mod:NewCDTimer(30.1, 315772, nil, nil, nil, 3)
local timerParanoiaCD						= mod:NewCDTimer(30.1, 309980, nil, nil, nil, 3)
local timerMindgateCD						= mod:NewCDTimer(30.1, 309046, nil, nil, nil, 1)
----Basher Tentacle
--local timerBasherTentacleCD					= mod:NewCDTimer(5.3, "ej20762", nil, nil, nil, 1, 309698, DBM_CORE_DAMAGE_ICON)
local timerVoidLashCD						= mod:NewCDTimer(23.1, 309698, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Corruptor Tentacle
local timerCorruptorTentacleCD				= mod:NewCDTimer(5.3, "ej21107", nil, nil, nil, 1, 313400, DBM_CORE_DAMAGE_ICON)
----Spike Tentacle
local timerSpikeTentacleCD					= mod:NewCDTimer(5.3, "ej21001", nil, nil, nil, 1, 312078, DBM_CORE_DAMAGE_ICON)
----Through the Mindgate
------Corruption of Deathwing

------Trecherous Bargain
--local timerBlackVolleyCD					= mod:NewAITimer(30.1, 313960, nil, nil, nil, 2)
--Stage 3:
----Thought Harvester
local timerHarvestThoughtsCD				= mod:NewAITimer(30.1, 317066, nil, nil, nil, 2)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307831, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
--mod:AddNamePlateOption("NPAuraOnShock", 313184)

local playersInMind = {}
local selfInMind = false
local seenAdds = {}
local ParanoiaTargets = {}
mod.vb.phase = 0
mod.vb.BasherCount = 0

local function warnParanoiaTargets()
	warnParanoia:Show(table.concat(ParanoiaTargets, "<, >"))
	table.wipe(ParanoiaTargets)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	self.vb.BasherCount = 0
	table.wipe(playersInMind)
	selfInMind = false
	table.wipe(seenAdds)
	table.wipe(ParanoiaTargets)
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

--[[
function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 308842) then
			local name = DBM:GetUnitFullName(uId)
			table.insert(playersInMind, name)
		end
	end
end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 311176 then
		self.vb.phase = 1
		warnGlimpseofInfinite:Show()
		--Start P1 timers here, more accurate, especially if boss forgets to cast this :D
		timerVoidGazeCD:Start(14.7)
		timerMindwrackCD:Start(14.7)
	elseif spellId == 316711 then
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then
				specWarnMindwrack:Show()
				specWarnMindwrack:Play("defensive")
				break
			end
		end
		timerMindwrackCD:Start()
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
		timerMindgraspCD:Start()
	elseif spellId == 309698 then
		if self:AntiSpam(3, 1) then--tentacles sync their cast, so one bar for all of them
			timerVoidLashCD:Start(23.1)
		end
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
			warnCorruptorTentacle:Show()
		end
	elseif spellId == 308885 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceGUID)
		specWarnMindFlay:Play("kickcast")
	--elseif spellId == 313960 then
		--warnBlackVolley:Show()
		--timerBlackVolleyCD:Start()
	elseif spellId == 317066 then
		specWarnHarvestThoughts:Show(args.sourceName)
		specWarnHarvestThoughts:Play("gathershare")
		timerHarvestThoughtsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 317292 then
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then
			timerMindgraspCD:Start(10.9)
			--timerBasherTentacleCD:Start(27.1)
			timerSpikeTentacleCD:Start(27.9)
			timerCorruptorTentacleCD:Start(32)
			timerParanoiaCD:Start(55.9)
			timerMindgateCD:Start(75)
		end
	elseif spellId == 315927 then
		--timerParanoiaCD:Start()
	elseif spellId == 316463 then
		warnMindGate:Show()
		--timerMindgateCD:Start()
	--"<25.90 23:24:55> [CLEU] SPELL_CAST_SUCCESS#Creature-0-2012-2217-3244-158378-00004F25B7#Severed Consciousness#Player-969-001B01A7#Nyaza#309296#Reflected Self#nil#nil", -- [169]
	elseif spellId == 309296 then--Reflected Self (Players entering mind)
		if not tContains(playersInMind, args.destName) then
			table.insert(playersInMind, args.destName)
		end
		if args.destGUID == UnitGUID("player") then
			selfInMind = true
			DBM:AddMsg("Temporary debug: you have entered mind")
		end
	--"<82.53 23:25:52> [CLEU] SPELL_CAST_SUCCESS#Player-969-001B322E#Werdup#Creature-0-2012-2217-3244-158378-00004F25B8#Severed Consciousness#309307#Restore Consciousness#nil#nil", -- [3604]
	elseif spellId == 309307 then--Restore Consciousness (Players leaving mind)
		tDeleteItem(playersInMind, args.sourceName)
		if args.sourceGUID == UnitGUID("player") then
			selfInMind = false
			DBM:AddMsg("Temporary debug: you have exited mind")
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
	elseif spellId == 313184 then
		local amount = args.amount or 1
		warnSynapticShock:Show(args.destName, amount)
		timerSynampticShock:Stop()
		timerSynampticShock:Start()
--	elseif spellId == 308842 then

	elseif spellId == 310073 or spellId == 311392 then
		if args:IsPlayer() then
			local text = spellId == 310073 and L.Away or L.Toward
			specWarnMindgrasp:Show(text)
			specWarnMindgrasp:Play("targetyou")
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313184 then
		timerSynampticShock:Stop()
	--elseif spellId == 308842 then

	elseif spellId == 313334 then
		if args:IsPlayer() then
			timerGiftofNzoth:Stop()
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
	if cid == 158376 then--animus
		timerMindwrackCD:Stop()
		timerCreepingAnguishCD:Stop()
		timerSynampticShock:Stop()
	--elseif cid == 158122 then--Eyes of N'zoth
		--timerVoidGazeCD:Stop(args.destGUID)
	--elseif cid == 159578 then--exposed-synapse

	--elseif cid == 161845 then--reflected-self

	--elseif cid == 158374 then--mindgate-tentacle

	elseif cid == 158367 then--basher-tentacle
		self.vb.BasherCount = self.vb.BasherCount - 1
		if self.vb.BasherCount == 0 then
			timerVoidLashCD:Stop()
		end
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
			if cid == 158367 then
				self.vb.BasherCount = self.vb.BasherCount + 1
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 315917 then--Tentacle Skirt
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 158367 then--Basher Tentacle (faster than IEEU, we want timer to start here, IEEU is for counting how many of them there are since this event only fires ONCE)
			--specWarnBasherTentacle:Show()
			--specWarnBasherTentacle:Play("bigmob")
			timerVoidLashCD:Start(15)
			--timerBasherTentacleCD:Start()
		elseif cid == 160249 then--Spike tentacle
			warnSpikeTentacle:Show()
			--timerSpikeTentacleCD:Start()
		end
	end
end
