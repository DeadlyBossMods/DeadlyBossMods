local mod	= DBM:NewMod("Helix", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47296)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
