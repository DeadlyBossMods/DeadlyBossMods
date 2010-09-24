local mod	= DBM:NewMod("Cookie", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(4739)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)