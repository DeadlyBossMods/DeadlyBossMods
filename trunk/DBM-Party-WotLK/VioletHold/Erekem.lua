local mod = DBM:NewMod("Erekem", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29315)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
