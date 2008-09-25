local mod = DBM:NewMod("Sladran", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(29304)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
