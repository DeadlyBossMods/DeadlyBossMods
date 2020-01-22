local mod	= DBM:NewMod(2331, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150396, 144249, 150397)
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
--	"UNIT_SPELLCAST_START boss1 boss2 boss3"
)

--TODO, warn tank if not in range in p2 for Ninety-Nine?
--[[
(ability.id = 291865 or ability.id = 291928 or ability.id = 292264 or ability.id = 291613) and type = "begincast"
 or (ability.id = 291626 or ability.id = 283551 or ability.id = 283143) and type = "cast"
 or (target.id = 150396 or target.id = 144249) and type = "death"
--]]
--Stage One: Aerial Unit R-21/X
local warnGigaZap					= mod:NewTargetCountAnnounce(292264, 2, nil, nil, nil, nil, nil, nil, true)
local warnRecalibrate				= mod:NewSpellAnnounce(291865, 2, nil, nil, nil, nil, 2)
local warnCuttingBeam				= mod:NewSpellAnnounce(291626, 2)
--Stage Two: Omega Buster
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, 2)
local warnMagnetoArmSoon			= mod:NewSoonAnnounce(283551, 2)

--Stage One: Aerial Unit R-21/X
--local specWarnRecalibrate			= mod:NewSpecialWarningDodge(291865, nil, nil, nil, 2, 2)
local specWarnGigaZap				= mod:NewSpecialWarningYouCount(292264, nil, nil, nil, 2, 2)
local yellGigaZap					= mod:NewCountYell(292264)
local specWarnTakeOff				= mod:NewSpecialWarningRun(291613, nil, nil, nil, 4, 2)
--Stage Two: Omega Buster
local specWarnMagnetoArm			= mod:NewSpecialWarningRun(283143, nil, nil, nil, 4, 2)
local specWarnHardMode				= mod:NewSpecialWarningSpell(292750, nil, nil, nil, 3, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Stage One: Aerial Unit R-21/X
local timerRecalibrateCD			= mod:NewCDTimer(13.4, 291865, nil, nil, nil, 3)
local timerGigaZapCD				= mod:NewCDTimer(15.8, 292264, nil, nil, nil, 3)
local timerTakeOffCD				= mod:NewCDTimer(35.2, 291613, nil, nil, nil, 6)
local timerCuttingBeam				= mod:NewCastTimer(6, 291626, nil, nil, nil, 3)
--Stage Two: Omega Buster
local timerMagnetoArmCD				= mod:NewCDTimer(61.9, 283143, nil, nil, nil, 2)
local timerHardModeCD				= mod:NewCDTimer(42.5, 292750, nil, nil, nil, 5, nil, DBM_CORE_MYTHIC_ICON)--42.5-46.1

--mod:AddRangeFrameOption(5, 194966)

mod.vb.phase = 1
mod.vb.recalibrateCount = 0
mod.vb.zapCount = 0
local P1RecalibrateTimers = {5.9, 13.3, 27.9, 15.6, 19.4}
--All hard mode timers, do they differ if hard mode isn't active?
--5.9, 13.3, 27.9, 15.6, 20.7
--5.9, 13.3, 28.8, 17.0, 19.4
--5.9, 13.3, 31.4, 16.9, 20.7

function mod:ZapTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(5, 5) then
		specWarnGigaZap:Show(self.vb.zapCount)
		specWarnGigaZap:Play("runout")
		yellGigaZap:Yell(self.vb.zapCount)
	else
		warnGigaZap:Show(self.vb.zapCount, targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.recalibrateCount = 0
	self.vb.zapCount = 0
	timerRecalibrateCD:Start(5.9-delay)
	timerGigaZapCD:Start(8.3-delay)
	timerTakeOffCD:Start(30.2-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 291865 then
		self.vb.recalibrateCount = self.vb.recalibrateCount + 1
		warnRecalibrate:Show()
		warnRecalibrate:Play("watchorb")
		local timer = P1RecalibrateTimers[self.vb.recalibrateCount+1]
		if timer then
			timerRecalibrateCD:Start(timer)
		end
	elseif spellId == 291928 or spellId == 292264 then--Stage 1, Stage 2
		self.vb.zapCount = self.vb.zapCount + 1
		--specWarnGigaZap:Show()
		--specWarnGigaZap:Play("watchstep")
		if spellId == 292264 then--Stage 2
			if self.vb.zapCount % 3 == 0 then
				--14.8, 3.5, 3.5, 28.6, 3.5, 3.5, 23.4, 3.5, 3.5, 23.3, 3.5, 3.5
				--14.8, 3.5, 3.5, 28.2, 3.5, 3.5
				timerGigaZapCD:Start(self.vb.zapCount == 3 and 28 or 23.3)
			else
				timerGigaZapCD:Start(3.5)
			end
		else--Stage 1
			timerGigaZapCD:Start(15.8)--15-20, but not sequencable enough because it differs pull from pull
		end
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "ZapTarget", 0.1, 7, true)
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
		timerCuttingBeam:Start()
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
	if cid == 150396 then--Aerial Unit R-21/X
		timerRecalibrateCD:Stop()
		timerGigaZapCD:Stop()
		timerTakeOffCD:Stop()
		timerCuttingBeam:Stop()
	elseif cid == 144249 then--Omega Buster
		self.vb.phase = 3
		timerRecalibrateCD:Stop()
		timerGigaZapCD:Stop()
		timerMagnetoArmCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 296323 then--Activate Omega Buster (Needed? Stage 2 should already be started by stage 1 boss death)
		self.vb.phase = 2
		self.vb.zapCount = 0
		self.vb.recalibrateCount = 0
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		--Start P2 Timers
		timerGigaZapCD:Start(13.6)
		--timerRecalibrateCD:Start(2)--Cast start event hidden in P2, and not the most important mechanic of fight that it needs hacks to work around
		timerMagnetoArmCD:Start(34)
	elseif spellId == 292807 then--Cancel Skull Aura (Annihilo-tron 5000 activating on pull)
		timerHardModeCD:Start(33.3)
	elseif spellId == 292750 then--H.A.R.D.M.O.D.E.
		specWarnHardMode:Show()
		specWarnHardMode:Play("stilldanger")
		timerHardModeCD:Start()
	end
end

--[[
--Used for auto acquiring of unitID and absolute fastest auto target scan using UNIT_TARGET events
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 291928 or spellId == 292264 then--Stage 1 Zap, Stage 2 Zap
		self:BossUnitTargetScanner(uId, "ZapTarget")
	end
end
--]]
