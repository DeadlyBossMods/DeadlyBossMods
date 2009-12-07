local mod	= DBM:NewMod("Toravon", "DBM-PvP", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2521 $"):sub(12, -3))
mod:SetCreatureID(38433, 38462)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

