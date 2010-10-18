local mod	= DBM:NewMod("HalfusWyrmbreaker", "DBM-BastionTwilight", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(44600)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)