local mod	= DBM:NewMod("Fear", "DBM-Party-MoP", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(50063)
--mod:SetModelID(34573)
--mod:SetZone(748, 720)--Dread Wastes (zoneid not yet known)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

