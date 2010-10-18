local mod	= DBM:NewMod("Argaloth", "DBM-BaradinHold", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47120)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)