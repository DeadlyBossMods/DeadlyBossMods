local mod = DBM:NewMod("Nadox", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29309)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
