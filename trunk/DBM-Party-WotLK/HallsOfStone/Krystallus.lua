local mod = DBM:NewMod("Krystallus", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(27977)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
