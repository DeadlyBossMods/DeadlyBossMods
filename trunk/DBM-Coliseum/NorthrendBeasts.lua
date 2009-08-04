local mod = DBM:NewMod("NorthrendBeasts", "DBM-Coliseum", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 599 $"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetZone()

mod:RegisterCombat("combat", 34796)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnImpaleOn		= mod:NewAnnounce("WarningMarkSoon", 1, 67478)
local specWarnSilence	= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer")


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67478 then
		warnImpaleOn:Show(args.spellName, args.amount)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 67648 then
		specWarnSilence:Show()
	end
end
