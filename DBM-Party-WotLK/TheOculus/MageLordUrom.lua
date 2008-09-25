local mod = DBM:NewMod("MageLordUrom", "DBM-Party-WotLK", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27655)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
