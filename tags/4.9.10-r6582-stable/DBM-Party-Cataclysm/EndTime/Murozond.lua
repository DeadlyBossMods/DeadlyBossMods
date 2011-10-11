local mod	= DBM:NewMod("Murozond", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54432)
mod:SetModelID(38931)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
