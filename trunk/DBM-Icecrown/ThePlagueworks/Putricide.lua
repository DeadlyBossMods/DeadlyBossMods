local mod = DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36678, 38216)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)