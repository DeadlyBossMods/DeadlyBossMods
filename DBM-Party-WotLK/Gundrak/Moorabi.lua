local mod = DBM:NewMod("Moorabi", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(29305)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
