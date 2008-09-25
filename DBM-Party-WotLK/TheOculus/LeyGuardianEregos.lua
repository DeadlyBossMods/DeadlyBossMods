local mod = DBM:NewMod("LeyGuardianEregos", "DBM-Party-WotLK", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(27656)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
