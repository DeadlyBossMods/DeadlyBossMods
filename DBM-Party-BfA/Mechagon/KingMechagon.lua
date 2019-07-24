local mod	= DBM:NewMod(2331, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150396, 144249)
mod:SetEncounterID(2260)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 291865 291928 292264 291613",
	"SPELL_CAST_SUCCESS 291626 283551 283143",
--	"SPELL_AURA_APPLIED 283143",
--	"SPELL_AURA_REMOVED 283143",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, does gigaszap work the way i think it does?
--TODO, warn tank if not in range in p2 for Ninety-Nine?
--[[
(ability.id = 291865 or ability.id = 291928 or ability.id = 292264 or ability.id = 291613) and type = "begincast"
 or (ability.id = 291626 or ability.id = 283551 or ability.id = 283143) and type = "cast"
 or (target.id = 150396 or target.id = 144249) and type = "death"
--]]
--Stage One: Aerial Unit R-21/X
local warnCuttingBeam				= mod:NewSpellAnnounce(291626, 2)
--Stage Two: Omega Buster
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, 2)
local warnMagnetoArmSoon			= mod:NewSoonAnnounce(283551, 2)

--Stage One: Aerial Unit R-21/X
local specWarnRecalibrate			= mod:NewSpecialWarningDodge(291865, nil, nil, nil, 2, 2)
local specWarnGigaZap				= mod:NewSpecialWarningDodge(292264, nil, nil, nil, 2, 2)
local specWarnTakeOff				= mod:NewSpecialWarningRun(291613, nil, nil, nil, 4, 2)
--Stage Two: Omega Buster
local specWarnMagnetoArm			= mod:NewSpecialWarningRun(283143, nil, nil, nil, 4, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Stage One: Aerial Unit R-21/X
local timerRecalibrateCD			= mod:NewAITimer(13.4, 291865, nil, nil, nil, 3)
local timerGigaZapCD				= mod:NewAITimer(13.4, 292264, nil, nil, nil, 3)
local timerTakeOffCD				= mod:NewAITimer(13.4, 291613, nil, nil, nil, 6)
--Stage Two: Omega Buster
local timerMagnetoArmCD				= mod:NewAITimer(31.6, 283143, nil, nil, nil, 2)

--mod:AddRangeFrameOption(5, 194966)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerRecalibrateCD:Start(1-delay)
	timerGigaZapCD:Start(1-delay)
	timerTakeOffCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 291865 then
		specWarnRecalibrate:Show()
		specWarnRecalibrate:Play("watchorb")
		timerRecalibrateCD:Start()
	elseif spellId == 291928 or spellId == 292264 then--Stage 1, Stage 2
		specWarnGigaZap:Show()
		specWarnGigaZap:Play("watchstep")
		timerGigaZapCD:Start()
	elseif spellId == 291613 then
		specWarnTakeOff:Show()
		specWarnTakeOff:Play("justrun")
		timerTakeOffCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 291626 then
		warnCuttingBeam:Show()
	elseif spellId == 283551 then
		warnMagnetoArmSoon:Show()
	elseif spellId == 283143 then
		specWarnMagnetoArm:Show()
		specWarnMagnetoArm:Play("justrun")
		specWarnMagnetoArm:ScheduleVoice(1.5, "keepmove")
		timerMagnetoArmCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 283143 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 283143 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 150396 and self.vb.phase == 1 then--Aerial Unit R-21/X
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerRecalibrateCD:Stop()
		timerGigaZapCD:Stop()
		timerTakeOffCD:Stop()
		--Start P2 Timers
		timerGigaZapCD:Start(2)
		timerRecalibrateCD:Start(2)
		timerMagnetoArmCD:Start(2)
	elseif cid == 144249 then--Omega Buster
		self.vb.phase = 3
		timerRecalibrateCD:Stop()
		timerGigaZapCD:Stop()
		timerMagnetoArmCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 296323 and self.vb.phase == 1 then--Activate Omega Buster (Needed? Stage 2 should already be started by stage 1 boss death)
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerRecalibrateCD:Stop()
		timerGigaZapCD:Stop()
		timerTakeOffCD:Stop()
		--Start P2 Timers
		timerGigaZapCD:Start(2)
		timerRecalibrateCD:Start(2)
		timerMagnetoArmCD:Start(2)
	end
end
