local mod	= DBM:NewMod(339, "DBM-BaradinHold", nil, 74)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(21252)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
