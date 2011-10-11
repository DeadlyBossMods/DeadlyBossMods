local mod	= DBM:NewMod("Jindo", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52148)
mod:SetModelID(37789)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
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
local specWarnSunderRift		= mod:NewSpecialWarningMove(97320)

local timerDeadzone				= mod:NewNextTimer(21, 97170)
local timerShadowsOfHakkar		= mod:NewBuffActiveTimer(10, 97172)
local timerShadowsOfHakkarNext	= mod:NewNextTimer(21, 97172)

mod:AddBoolOption("BodySlamIcon")

local phase2warned = false
local barrier = 3

function mod:OnCombatStart(delay)
	phase2warned = false
	barrier = 3
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97172) then
		specWarnShadow:Show()
		timerShadowsOfHakkar:Start()
		timerShadowsOfHakkarNext:Start()
	elseif args:IsSpellID(97320) and args:IsPlayer() then
		specWarnSunderRift:Show()
	elseif args:IsSpellID(97597) then
		warnBodySlam:Show(args.destName)
		if args:IsPlayer() then
			specWarnBodySlam:Show()
		end
		if self.Options.BodySlamIcon then
			self:SetIcon(args.destName, 8, 2)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(97417) then
		barrier = barrier - 1
		warnBarrierDown:Show(barrier)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(97172) then
		warnShadowsOfHakkar:Show()
	elseif args:IsSpellID(97158) and not phase2warned then
		phase2warned = true
		warnPhase2:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(97170) then
		warnDeadzone:Show()
		timerDeadzone:Start()
	end
end
