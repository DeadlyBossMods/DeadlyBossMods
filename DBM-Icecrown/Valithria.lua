local mod = DBM:NewMod("Valithria", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(37868, 38167, 36791, 38169, 37863, 38171, 37886, 38166)--All the add creatureids for now drycoded from mmo database.
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)