local mod	= DBM:NewMod("Chimaeron", "DBM-BlackwingDescent", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43296)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)