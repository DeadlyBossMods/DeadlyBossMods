local mod	= DBM:NewMod("Salyis", "DBM-Party-MoP", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62352, 62346)--Salyis 62352, Galleon 62346
mod:SetModelID(42468)
mod:SetZone(807)--Valley of the Four winds now?

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

