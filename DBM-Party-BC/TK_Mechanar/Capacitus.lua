local mod = DBM:NewMod("Capacitus", "DBM-Party-BC", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(19219)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnPolarity          = mod:NewCastAnnounce(39096)
local warnMagicShield       = mod:NewSpellAnnounce(35158)
local warnDamageShield      = mod:NewSpellAnnounce(35159)
local timerMagicShield      = mod:NewBuffActiveTimer(10, 35158)
local timerDamageShield     = mod:NewBuffActiveTimer(10, 35159)

local enrageTimer	= mod:NewEnrageTimer(180)

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 39096 then          --Robo Thaddius AMG!
		warnPolarity:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35158 then          --Magic Shield
		warnMagicShield:Show(args.destName)
		timerMagicShield:Start()
	elseif args.spellId == 35159 then      --Damage Shield
		warnDamageShield:Show(args.destName)
		timerDamageShield:Start()
	end
end