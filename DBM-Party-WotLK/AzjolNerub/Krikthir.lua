local mod = DBM:NewMod("Krikthir", "DBM-Party-WotLK", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(28684)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
