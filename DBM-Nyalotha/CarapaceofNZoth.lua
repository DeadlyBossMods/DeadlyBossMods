local mod	= DBM:NewMod(2366, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157439)--Fury of N'Zoth
mod:SetEncounterID(2337)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 307131 307008 307809 307092 313039 315820",
	"SPELL_CAST_SUCCESS 313364 306973 307482 307048 306984 313040",
	"SPELL_AURA_APPLIED 313334 307832 306973 306990 307071 306984",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 313334 306973 306990 307071 306984",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://ptr.wowhead.com/spell=307071/synthesis
--TODO, figure out which mental decay is interruptable player version and which is non interruptable boss version
--TODO, figure out how whole tentacle/hemorrhage/antigen works
--TODO, verify gaze of madness trigger
--TODO, Synthesis Growth count, with growth remaining warning counter?
--TODO, update Phase 2 trigger to actual retreat trigger, not him gaining heals/immunity
--TODO, phase 3 trigger
--TODO, find and use correct Eternal Darkness trigger and eliminate extra
--TODO, Cyst Genesis still listed in overview but removed from P3 in latest build, see if it still exists. 313118/307064
--General
local warnGiftofNzoth						= mod:NewTargetNoFilterAnnounce(313334, 2)
--Stage 1: Exterior Carapace
----Fury of N'Zoth
local warnMadnessBomb						= mod:NewTargetAnnounce(306973, 2)
local warnAdaptiveMembrane					= mod:NewTargetNoFilterAnnounce(306990, 4)
local warnGazeofMadness						= mod:NewSpellAnnounce(307482, 2)
--Stage 2: Subcutaneous Tunnel
local warnSynthesisOver						= mod:NewEndAnnounce(307071, 1)
--Stage 3: Nightmare Chamber
local warnInsanityBomb						= mod:NewTargetAnnounce(306984, 2)

--General
local specWarnGiftofNzoth					= mod:NewSpecialWarningYou(313334, nil, nil, nil, 1, 2)
local specWarnServantofNzoth				= mod:NewSpecialWarningTargetChange(307832, "-Healer", nil, nil, 1, 2)
--local specWarnMentalDecay					= mod:NewSpecialWarningInterrupt(313364, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--Stage 1: Exterior Carapace
----Fury of N'Zoth
local specWarnMadnessBomb					= mod:NewSpecialWarningMoveAway(306973, nil, nil, nil, 1, 2)
local yellMadnessBomb						= mod:NewYell(306973)
local yellMadnessBombFades					= mod:NewShortFadesYell(306973)
local specWarnGrowthCoveredTentacle			= mod:NewSpecialWarningCount(307131, nil, nil, nil, 2, 2)
local specWarnBreedMadness					= mod:NewSpecialWarningInterrupt(307008, "HasInterrupt", nil, nil, 1, 2)
--Stage 2: Subcutaneous Tunnel
local specWarnEternalDarkness				= mod:NewSpecialWarningCount(307048, nil, nil, nil, 2, 2)
local specWarnOccipitalBlast				= mod:NewSpecialWarningDodge(307092, nil, nil, nil, 2, 2)
--Stage 3: Nightmare Chamber
local specWarnInsanityBomb					= mod:NewSpecialWarningMoveAway(306984, nil, nil, nil, 1, 2)
local yellInsanityBomb						= mod:NewYell(306984)
local yellInsanityBombFades					= mod:NewShortFadesYell(306984)
local specWarnInfiniteDarkness				= mod:NewSpecialWarningCount(313040, nil, nil, nil, 2, 2)
local specWarnThrashingTentacle				= mod:NewSpecialWarningCount(315820, nil, nil, nil, 2, 2)

--mod:AddTimerLine(BOSS)
--General
local timerGiftofNzoth						= mod:NewBuffFadesTimer(20, 313334, nil, nil, nil, 5)
--Stage 1: Exterior Carapace
----Fury of N'Zoth
local timerMadnessBombCD					= mod:NewAITimer(30.1, 306973, nil, nil, nil, 3)
local timerAdaptiveMembraneCD				= mod:NewAITimer(30.1, 306990, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_TANK_ICON, nil, 2, 4)
local timerAdaptiveMembrane					= mod:NewBuffActiveTimer(12, 306990, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)
local timerMentalDecayCD					= mod:NewAITimer(30.1, 313364, nil, nil, nil, 3)
local timerGrowthCoveredTentacleCD			= mod:NewAITimer(84, 307131, nil, nil, nil, 1, nil, nil, nil, 1, 4)
----Adds
local timerGazeofMadnessCD					= mod:NewAITimer(84, 307482, nil, nil, nil, 1)
local timerBreedMadnessCD					= mod:NewAITimer(84, 307008, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
----Wrathion (for now assuming his stuff is passive not timed)
--Stage 2: Subcutaneous Tunnel
local timerEternalDarknessCD				= mod:NewAITimer(30.1, 307048, nil, nil, nil, 2)
local timerOccipitalBlastCD					= mod:NewAITimer(30.1, 307092, nil, nil, nil, 3)
--Stage 3: Nightmare Chamber
local timerInsanityBombCD					= mod:NewAITimer(30.1, 306984, nil, nil, nil, 3)
local timerInfiniteDarknessCD				= mod:NewAITimer(30.1, 313040, nil, nil, nil, 2)
local timerThrashingTentacleCD				= mod:NewAITimer(30.1, 315820, nil, nil, nil, 3)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("10")
mod:AddInfoFrameOption(307831, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnMembrane", 306990)

mod.vb.TentacleCount = 0
mod.vb.DarknessCount = 0
mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.TentacleCount = 0
	self.vb.DarknessCount = 0
	self.vb.phase = 1
	timerMadnessBombCD:Start(1-delay)
	timerAdaptiveMembraneCD:Start(1-delay)
	timerMentalDecayCD:Start(1-delay)
	timerGrowthCoveredTentacleCD:Start(1-delay)
	timerGazeofMadnessCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
		DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
	end
	if self.Options.NPAuraOnMembrane then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnMembrane then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 307131 then
		self.vb.TentacleCount = self.vb.TentacleCount + 1
		specWarnGrowthCoveredTentacle:Show(self.vb.TentacleCount)
		specWarnGrowthCoveredTentacle:Play("killmob")
		timerGrowthCoveredTentacleCD:Start()
	elseif spellId == 315820 then
		self.vb.TentacleCount = self.vb.TentacleCount + 1
		specWarnThrashingTentacle:Show(self.vb.TentacleCount)
		specWarnThrashingTentacle:Play("watchstep")--???
		timerThrashingTentacleCD:Start()
	elseif spellId == 307008 then
		timerBreedMadnessCD:Start(10, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBreedMadness:Show(args.sourceName)
			specWarnBreedMadness:Play("kickcast")
		end
	elseif spellId == 307809 and self:AntiSpam(5, 1) then
		self.vb.DarknessCount = self.vb.DarknessCount + 1
		specWarnEternalDarkness:Show(self.vb.DarknessCount)
		specWarnEternalDarkness:Play("aesoon")
		timerEternalDarknessCD:Start()
	elseif spellId == 313039 and self:AntiSpam(5, 1) then
		self.vb.DarknessCount = self.vb.DarknessCount + 1
		specWarnInfiniteDarkness:Show(self.vb.DarknessCount)
		specWarnInfiniteDarkness:Play("aesoon")
		timerInfiniteDarknessCD:Start()
	elseif spellId == 307092 then
		specWarnOccipitalBlast:Show()
		specWarnOccipitalBlast:Play("shockwave")
		timerOccipitalBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 313364 then
		if args:GetSrcCreatureID() == 157439 then--Fury of N'Zoth
			timerMentalDecayCD:Start()
		--elseif self:CheckInterruptFilter(args.sourceGUID, false, true) then
		--	specWarnMentalDecay:Show(args.sourceName)
		end
	elseif spellId == 306973 then
		timerMadnessBombCD:Start()
	elseif spellId == 307482 then
		warnGazeofMadness:Show()
		timerGazeofMadnessCD:Start()
		--timerBreedMadnessCD:Start(1)
	elseif spellId == 307048 and self:AntiSpam(5, 1) then
		self.vb.eternalDarknessCount = self.vb.eternalDarknessCount + 1
		specWarnEternalDarkness:Show(self.vb.eternalDarknessCount)
		specWarnEternalDarkness:Play("aesoon")
		timerEternalDarknessCD:Start()
	elseif spellId == 313040 and self:AntiSpam(5, 1) then
		self.vb.DarknessCount = self.vb.DarknessCount + 1
		specWarnInfiniteDarkness:Show(self.vb.DarknessCount)
		specWarnInfiniteDarkness:Play("aesoon")
		timerInfiniteDarknessCD:Start()
	elseif spellId == 306984 then
		timerInsanityBombCD:Start()
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
	elseif spellId == 306973 then
		warnMadnessBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnMadnessBomb:Show()
			specWarnMadnessBomb:Play("runout")
			yellMadnessBomb:Yell()
			yellMadnessBombFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 306984 then
		warnInsanityBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnInsanityBomb:Show()
			specWarnInsanityBomb:Play("runout")
			yellInsanityBomb:Yell()
			yellInsanityBombFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 306990 then
		warnAdaptiveMembrane:Show(args.destName)
		timerAdaptiveMembrane:Start()
		timerAdaptiveMembraneCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
		if self.Options.NPAuraOnMembrane then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 12)
		end
	elseif spellId == 307071 and self.vb.phase < 2 then--Synthesis
		self.vb.phase = 2
		timerMadnessBombCD:Stop()
		timerAdaptiveMembraneCD:Stop()
		timerMentalDecayCD:Stop()
		timerGrowthCoveredTentacleCD:Stop()
		timerGazeofMadnessCD:Stop()
		timerMadnessBombCD:Start(2)
		timerAdaptiveMembraneCD:Start(2)
		timerMentalDecayCD:Start(2)
		timerEternalDarknessCD:Start(2)
		timerOccipitalBlastCD:Start(2)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 313334 then
		if args:IsPlayer() then
			timerGiftofNzoth:Stop()
		end
	elseif spellId == 306973 then
		if args:IsPlayer() then
			yellMadnessBombFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 306984 then
		if args:IsPlayer() then
			yellInsanityBombFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 306990 then
		timerAdaptiveMembrane:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307831))
			DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 2)--Sorting lowest to highest
		end
		if self.Options.NPAuraOnMembrane then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 307071 then--Synthesis
		warnSynthesisOver:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157452 then--nightmare-antigen

	elseif cid == 157442 then--gaze-of-madness
		timerBreedMadnessCD:Stop(args.destGUID)
	elseif cid == 157475 then--synthesis-growth

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298689 then

	end
end
