local mod = DBM:NewMod("ChronoLordEpoch", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(26532)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
