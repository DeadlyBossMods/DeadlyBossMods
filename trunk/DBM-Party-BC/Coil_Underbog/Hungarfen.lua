local mod	= DBM:NewMod("Hungarfen", "DBM-Party-BC", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17770)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnFoulSpores  = mod:NewSpellAnnounce(31673)--Iffy, this may not work. Dry-coded off wowhead.

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31673 then
		warnFoulSpores:Show()
	end
end