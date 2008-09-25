local mod = DBM:NewMod("Volkhan", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28587)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
