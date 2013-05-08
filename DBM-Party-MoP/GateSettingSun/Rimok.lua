local mod	= DBM:NewMod(676, "DBM-Party-MoP", 4, 303)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56636)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START"
)

--This mod needs more stuff involving adds later.
local warnFrenziedAssault		= mod:NewSpellAnnounce(107120, 3)

local specWarnFrenziedAssault	= mod:NewSpecialWarningSpell(107120, mod:IsTank())
local specWarnViscousFluid		= mod:NewSpecialWarningMove(107122)

local timerFrenziedAssault		= mod:NewBuffActiveTimer(6, 107120)
local timerFrenziedAssaultCD	= mod:NewNextTimer(17, 107120)

function mod:OnCombatStart(delay)
	timerFrenziedAssaultCD:Start(6-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 107122 and args:IsPlayer() and self:AntiSpam(3) then
		specWarnViscousFluid:Show()
	elseif args.spellId == 107120 then
		timerFrenziedAssault:Start()
		timerFrenziedAssaultCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args.spellId == 107120 then
		warnFrenziedAssault:Show()
		specWarnFrenziedAssault:Show()
	end
end
