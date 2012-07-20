local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62837)
mod:SetModelID(42730)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnScreech				= mod:NewSpellAnnounce(123735, 3)
local warnCryOfTerror			= mod:NewTargetAnnounce(123788, 3, nil, mod:IsHealer())
local warnEyes					= mod:NewStackAnnounce(123707, 2, nil, mod:IsTank())
local warnRetreat				= mod:NewSpellAnnounce(125098, 4)

local specWarnEyes				= mod:NewSpecialWarningStack(123707, mod:IsTank(), 4)
local specWarnEyesOther			= mod:NewSpecialWarningTarget(123707, mod:IsTank())
local specWarnRetreat			= mod:NewSpecialWarningSpell(125098, nil, nil, nil, true)

local timerScreechCD			= mod:NewNextTimer(7, 123735)
local timerCryOfTerror			= mod:NewTargetTimer(20, 123788, nil, mod:IsHealer())
local timerCryOfTerrorCD		= mod:NewNextTimer(25, 123788, nil, mod:IsHealer())
--local timerPhase1				= mod:NewTimer(120, "Return")
local timerPhase2				= mod:NewNextTimer(152, 125098)

function mod:OnCombatStart(delay)
	timerScreechCD:Start(-delay)
	timerPhase2:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123735) then
		warnEyes:Show(args.destName, args.amount or 1)
--		timerEyes:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 4 then--MUSt get other tank to taunt at 4 stacks at latest
			specWarnEyes:Show(args.amount)
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(123735)) and not UnitIsDeadOrGhost("player") then--However, other tank can taunt at 3 stacks if their debuff clear
				specWarnEyesOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(123788) then
		warnCryOfTerror:Show(args.destName)
		timerCryOfTerror:Start(args.destName)
		timerCryOfTerrorCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123788) then
		timerCryOfTerror:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123707) then
		warnScreech:Show()
		timerScreechCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125098 and self:AntiSpam(2, 1) then
		timerScreech:Cancel()
		timerCryOfTerrorCD:Cancel()
		warnRetreat:Show()
		specWarnRetreat:Show()
--		timerPhase1:Start()
	end
end
