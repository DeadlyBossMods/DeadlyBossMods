local mod = DBM:NewMod("Gjarngrin", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(28586)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
