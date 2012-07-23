local mod	= DBM:NewMod(741, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62397)
mod:SetModelID(42645)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
