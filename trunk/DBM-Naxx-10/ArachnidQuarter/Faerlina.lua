local mod = DBM:NewMod("Faerlina 10", "DBM-Naxx-10", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 84 $"):sub(12, -3))
mod:SetCreatureID(15953)
mod:SetZone(GetAddOnMetadata("DBM-Naxx-10", "X-DBM-Mod-LoadZone"))

--mod:RegisterCombat("yell", L.yell1, L.yell2, L.yell3)
mod:RegisterCombat("combat")


mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_REMOVED"
)