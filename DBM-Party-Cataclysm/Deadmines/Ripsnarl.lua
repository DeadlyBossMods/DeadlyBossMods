local mod	= DBM:NewMod(92, "DBM-Party-Cataclysm", 2, 63)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47626)
mod:SetModelID(35739)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)