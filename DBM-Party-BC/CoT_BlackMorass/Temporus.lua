local mod	= DBM:NewMod("Temporus", "DBM-Party-BC", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17880)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnSpellReflect  = mod:NewSpellAnnounce(38592)
local warnHasten		= mod:NewSpellAnnounce(31458)
local timerSpellReflect	= mod:NewBuffActiveTimer(6, 38592)
local timerHasten		= mod:NewBuffActiveTimer(10, 31458)
local specWarnHasten	= mod:NewSpecialWarning("specWarnHasten", isDispeller)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 38592 then
		warnSpellReflect:Show()
		timerSpellReflect:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31458 and not args:IsDestTypePlayer() then     --Hasten
		warnHasten:Show(args.destName)
		timerHasten:Start(args.destName)
		specWarnHasten:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31458 then
		timerHasten:Cancel(args.destName)
    end
end