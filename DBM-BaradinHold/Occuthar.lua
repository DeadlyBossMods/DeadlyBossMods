local mod	= DBM:NewMod("Occuthar", "DBM-BaradinHold")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(47120)
--mod:SetModelID(35426)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)
