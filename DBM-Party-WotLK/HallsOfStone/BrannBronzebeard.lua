local mod = DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(28070)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
