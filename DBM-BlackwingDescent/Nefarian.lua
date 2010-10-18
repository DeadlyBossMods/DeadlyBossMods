local mod	= DBM:NewMod("Nedarian-BD", "DBM-BlackwingDescent", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41376)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)