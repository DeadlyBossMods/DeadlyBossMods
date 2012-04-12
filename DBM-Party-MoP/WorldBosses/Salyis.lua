local mod	= DBM:NewMod("Salyis", "DBM-Party-MoP", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(50063)
--mod:SetModelID(41772)
--mod:SetZone(858)--Dread Wastes (zoneid not yet known)
--Not listed as a world boss anymore in latest patch EJ, was this boss moved?

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

