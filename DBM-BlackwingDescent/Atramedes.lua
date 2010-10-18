local mod	= DBM:NewMod("Atramedes", "DBM-BlackwingDescent", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41442)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)