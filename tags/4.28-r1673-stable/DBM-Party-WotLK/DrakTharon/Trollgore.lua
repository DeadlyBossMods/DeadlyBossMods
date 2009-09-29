local mod = DBM:NewMod("Trollgore", "DBM-Party-WotLK", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26630)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
