local mod	= DBM:NewMod("Azshara", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54853)
mod:SetModelID(39391)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
