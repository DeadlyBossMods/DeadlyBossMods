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
	"SPELL_CAST_START 311176 316711 310184 310134 310130 310331 315772 316463 309046 309698 310042 313400 308885 312866 313960",
	"SPELL_CAST_SUCCESS 314889",
	"SPELL_AURA_APPLIED 313334 307832 309991 313184 308842 309297 310073 311392 316541 316542 313793 315709 315710",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 313184 308842 313334",
	"SPELL_PERIODIC_DAMAGE 309991",
	"SPELL_PERIODIC_MISSED 309991",
--	"SPELL_INTERRUPT",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out azeroth's radiance https://ptr.wowhead.com/spell=310565/azeroths-radiance
--TODO, figure out if mental decay cast by players can be interrupted (if they even cast it, journal for previous boss was wrong)
--TODO, figure out phase travel with animus so players can be warned to get in and get out correctly (is it a portal? buff you click off? etc
--TODO, find out power gains of animus and add timer for Manifest Madness that's more reliable
--TODO, verify detecting players in mind for https://ptr.wowhead.com/spell=310130/eternal-hatred
--TODO, build infoframe up to show mind phase players if detection works and sort this to the top when mechanics that require players leaving said phase are present
--TODO, correct void gaze spellID probably, also should it special warn to leave mind phase?
--TODO, timer fading based on phase player is in, if phase detection stuff is doable
--TODO, add AI timers will likely screw up. That will be fixed when they are converted to real timers
--TODO, verify mindgrasp timer start location and do more with away/toward
--TODO, https://ptr.wowhead.com/spell=315982/corrupted-neuron and https://ptr.wowhead.com/spell=309988/veil-of-anguish, what do?
--TODO, put paranoia timer start in correct place, also enhance yells and auto marking/etc for Paranoia if pairs can be identified
--TODO, correct mindgate spell ID/event
--TODO, does mind gate spawn an add or not, journal is a bit conflicted with that info
--TODO, timer fades based on whether you are in mind or not, if detection possible
--TODO, handle visions phases
--New Voice: "leavemind"
--General
local warnPhase								= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnGiftofNzoth						= mod:NewTargetNoFilterAnnounce(313334, 2)
--Stage 1: Dominant Mind
local warnGlimpseofInfinite					= mod:NewCastAnnounce(311176, 2)
----Animus
local warnCreepingAnguish					= mod:NewCastAnnounce(310184, 4)
local warnSynapticShock						= mod:NewTargetNoFilterAnnounce(313184, 1)
local warnEternalHatred						= mod:NewCastAnnounce(310130, 4)
----Exposed Synapse
local warnProbeMind							= mod:NewTargetAnnounce(314889, 2)
--Stage 2: Writhing Onslaught
----N'Zoth
local warnParanoia							= mod:NewTargetNoFilterAnnounce(309980, 3)
local warnMindGate							= mod:NewCastAnnounce(309046, 2)
----Basher tentacle
local warnTumultuousBurst					= mod:NewCastAnnounce(310042, 4, nil, nil, "Tank")
----Through the Mindgate
------Corruption of Deathwing
local warnFlamesofInsanity					= mod:NewTargetNoFilterAnnounce(313793, 2, nil, "RemoveMagic")
------Trecherous Bargain
local warnBlackVolley						= mod:NewCastAnnounce(313960, 2)

--General
local specWarnGiftofNzoth					= mod:NewSpecialWarningYou(313334, nil, nil, nil, 1, 2)
local specWarnServantofNzoth				= mod:NewSpecialWarningTargetChange(307832, "-Healer", nil, nil, 1, 2)
local yellServantofNzoth					= mod:NewYell(307832)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(309991, nil, nil, nil, 1, 8)
--Stage 1: Dominant Mind
----Animus
local specWarnMindwrack						= mod:NewSpecialWarningDefensive(316711, nil, nil, nil, 1, 2)
local specWarnManifestMadness				= mod:NewSpecialWarningSpell(310134, nil, nil, nil, 3)--Basically an automatic wipe unless animus was like sub 1% health, no voice because there isn't really one that says "you're fucked"
local specWarnEternalHatred					= mod:NewSpecialWarningMoveTo(310130, nil, nil, nil, 3, 10)
----Mind's Eye
local specWarnVoidGaze						= mod:NewSpecialWarningSpell(310333, nil, nil, nil, 2, 2)
----Exposed Synapse
local specWarnProbeMind						= mod:NewSpecialWarningRun(314889, nil, nil, nil, 4, 2)
----Reflected Self
local specWarnReflectedSelf					= mod:NewSpecialWarningYou(309297, nil, nil, nil, 1, 2)
--Stage 2: Writhing Onslaught
----N'Zoth
local specWarnMindgrasp						= mod:NewSpecialWarningYouCount(315772, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(315772), nil, 2, 2)
local yellMindgrasp							= mod:NewShortYell(315772, "%s")
local specWarnParanoia						= mod:NewSpecialWarningYou(309980, nil, nil, nil, 1, 2)--Change to MoveTo if can get name of their linked ally
local yellParanoia							= mod:NewYell(309980)
----Basher Tentacle
local specWarnVoidLash						= mod:NewSpecialWarningDefensive(309698, nil, nil, nil, 1, 2)
----Corruptor Tentacle
local specWarnCorruptedMind					= mod:NewSpecialWarningInterrupt(313400, "HasInterrupt", nil, nil, 1, 2)
local specWarnCorruptedMindDispel			= mod:NewSpecialWarningDispel(313400, "RemoveMagic", nil, nil, 1, 2)
local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(308885, false, nil, nil, 1, 2)
----Through the Mindgate
------Corruption of Deathwing
local specWarnCataclysmicFlames				= mod:NewSpecialWarningDodge(312866, nil, nil, nil, 2, 2)
------Trecherous Bargain
local specWarnTreadLightly					= mod:NewSpecialWarningYou(315709, nil, nil, nil, 1, 2)
local specWarnContempt						= mod:NewSpecialWarningStopMove(315710, nil, nil, nil, 1, 6)

--mod:AddTimerLine(BOSS)
--General
local timerGiftofNzoth						= mod:NewBuffFadesTimer(20, 313334, nil, nil, nil, 5)
--local berserkTimer						= mod:NewBerserkTimer(600)
--Stage 1: Dominant Mind
local timerGlimpseofInfinityCD				= mod:NewAITimer(30.1, 311176, nil, nil, nil, 6)
----Animus
local timerMindwrackCD						= mod:NewAITimer(5.3, 316711, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerSynampticShock					= mod:NewBuffActiveTimer(15, 313184, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
----Mind's Eye
local timerVoidGazeCD						= mod:NewAITimer(30.1, 310333, nil, nil, nil, 2)
----Exposed Synapse
local timerProbeMindCD						= mod:NewAITimer(30.1, 314889, nil, nil, nil, 3)
--Stage 2: Writhing Onslaught
----N'Zoth
local timerMindgraspCD						= mod:NewAITimer(30.1, 315772, nil, nil, nil, 3)
local timerParanoiaCD						= mod:NewAITimer(30.1, 309980, nil, nil, nil, 3)
local timerMindgateCD						= mod:NewAITimer(30.1, 309046, nil, nil, nil, 1)
----Basher Tentacle
local timerVoidLashCD						= mod:NewAITimer(5.3, 309698, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Corruptor Tentacle
local timerCorruptedMindCD					= mod:NewAITimer(5.3, 313400, nil, "HasInterrupt|RemoveMagic", nil, 4, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_INTERRUPT_ICON)
----Through the Mindgate
------Corruption of Deathwing
local timerCataclysmicFlamesCD				= mod:NewAITimer(30.1, 312866, nil, nil, nil, 3)
------Trecherous Bargain
local timerBlackVlleyCD						= mod:NewAITimer(30.1, 313960, nil, nil, nil, 2)


--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307831, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnShock", 313184)

local playersInMind = {}

function mod:OnCombatStart(delay)
	table.wipe(playersInMind)
	--Nzoth
	timerGlimpseofInfinityCD:Start(1-delay)--Probalby used immediately
	--Animus
	timerMindwrackCD:Start(1-delay)--Maybe incorrect spot to start animus timers
	if self.Options.NPAuraOnShock then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
		DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnShock then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 308842) then
			local name = DBM:GetUnitFullName(uId)
			table.insert(playersInMind, name)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 311176 then
		warnGlimpseofInfinite:Show()
		timerGlimpseofInfinityCD:Start()
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
	elseif spellId == 310134 then
		specWarnManifestMadness:Show()
	elseif spellId == 310130 then
		if DBM:UnitDebuff("player", 308842) then
			specWarnEternalHatred:Show(L.ExitMind)
			specWarnEternalHatred:Play("leavemind")
		else
			warnEternalHatred:Show()
		end
	elseif spellId == 310331 then
		if DBM:UnitDebuff("player", 308842) then
			specWarnVoidGaze:Show()
			specWarnVoidGaze:Play("")--leavemind?
		end
		timerVoidGazeCD:Start(nil, args.sourceGUID)
	elseif spellId == 315772 then
		timerMindgraspCD:Start()
	elseif spellId == 316463 or spellId == 309046 then
		warnMindGate:Show()
		timerMindgateCD:Start()
	elseif spellId == 309698 then
		timerVoidLashCD:Start(nil, args.sourceGUID)
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
		timerCorruptedMindCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCorruptedMind:Show(args.sourceGUID)
			specWarnCorruptedMind:Play("kickcast")
		end
	elseif spellId == 308885 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceGUID)
		specWarnMindFlay:Play("kickcast")
	elseif spellId == 312866 then
		specWarnCataclysmicFlames:Show()
		specWarnCataclysmicFlames:Play("breathsoon")
		timerCataclysmicFlamesCD:Start()
	elseif spellId == 313960 then
		warnBlackVolley:Show()
		timerBlackVlleyCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314889 then
		timerProbeMindCD:Start(nil, args.sourceGUID)
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
	elseif spellId == 307832 then
		specWarnServantofNzoth:CombinedShow(1, args.destName)
		specWarnServantofNzoth:ScheduleVoice(1, "findmc")
		if args:IsPlayer() then
			yellServantofNzoth:Yell()
		end
	elseif spellId == 309991 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 313184 then
		warnSynapticShock:Show(args.destName)
		timerSynampticShock:Start()
		if self.Options.NPAuraOnShock then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 15)
		end
	elseif spellId == 308842 then
		if not tContains(playersInMind, args.destName) then
			table.insert(playersInMind, args.destName)
		end
	elseif spellId == 314889 then
		warnProbeMind:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnProbeMind:Show()
			specWarnProbeMind:Play("justrun")
		end
	elseif spellId == 309297 then

		if args:IsPlayer() then
			specWarnReflectedSelf:Show()
			specWarnReflectedSelf:Play("targetyou")
		end
	elseif spellId == 310073 or spellId == 311392 then

		if args:IsPlayer() then
			local text = spellId == 310073 and L.Away or L.Toward
			specWarnMindgrasp:Show(text)
			specWarnMindgrasp:Play("targetyou")
			yellMindgrasp:Yell(text)
		end
	elseif spellId == 316541 or spellId == 316542 then
		warnParanoia:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnParanoia:Show()
			specWarnParanoia:Play("gather")--Better voice needed, when more understood
			yellParanoia:Yell()
		end
		if self:AntiSpam(3, 1) then
			timerParanoiaCD:Start()
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
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313184 then
		timerSynampticShock:Stop()
		if self.Options.NPAuraOnShock then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 308842 then
		tDeleteItem(playersInMind, args.destName)
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
	elseif cid == 158122 then--minds-eye
		timerVoidGazeCD:Stop(args.destGUID)
	elseif cid == 159578 then--exposed-synapse
		timerProbeMindCD:Stop(args.destGUID)
	--elseif cid == 161845 then--reflected-self

	--elseif cid == 158374 then--mindgate-tentacle

	elseif cid == 158367 then--basher-tentacle
		timerVoidLashCD:Stop(args.destGUID)
	elseif cid == 158375 then--corruptor-tentacle
		timerCorruptedMindCD:Stop(args.destGUID)
	--elseif cid == 160249 then--spike-tentacle

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298689 then

	end
end
