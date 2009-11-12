local mod	= DBM:NewMod("Ghazan", "DBM-Party-BC", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(18105)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)