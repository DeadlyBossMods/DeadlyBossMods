-- this fight seems to incomplete, anyway supports to mods

local mod	= DBM:NewMod("Jindo", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52148)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnDeadzone				= mod:NewSpellAnnounce(97170, 3)
local warnShadowsOfHakkar		= mod:NewCastAnnounce(97172, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnBarrierDown			= mod:NewAnnounce("WarnBarrierDown", 2)
local warnBodySlam				= mod:NewTargetAnnounce(97198, 2)

local specWarnShadow			= mod:NewSpecialWarningSpell(97172)
local specWarnBodySlam			= mod:NewSpecialWarningYou(97198)

local timerDeadzone				= mod:NewNextTimer(21, 97170)
local timerShadowsOfHakkar		= mod:NewBuffActiveTimer(10, 97172)
local timerShadowsOfHakkarNext	= mod:NewNextTimer(21, 97172)

local phase2warned = false
local barrier = 3

function mod:SlamTarget()
	local targetname = self:GetBossTarget(52730)
	if not targetname then return end
	warnBodySlam:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBodySlam:Show()
	end
end

function mod:OnCombatStart(delay)
	phase2warned = false
	barrier = 3
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97172) then
		specWarnShadow:Show()
		timerShadowsOfHakkar:Start()
		timerShadowsOfHakkarNext:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(97417) then
		barrier = barrer - 1
		warnBarrierDown:Show(barrier)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(97172) then
		warnShadowsOfHakkar:Show()
	elseif args:IsSpellID(97158) and not phase2warned then
		warnPhase2:Show()
		phase2warned = true
	elseif args:IsSpellID(97198) and self:IsInCombat() then
		self:ScheduleMethod(0.15, "SlamTarget")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(97170) then
		warnDeadzone:Show()
		timerDeadzone:Start()
	end
end
