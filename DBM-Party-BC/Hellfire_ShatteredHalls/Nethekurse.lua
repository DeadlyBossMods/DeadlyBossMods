local mod	= DBM:NewMod("Nethekurse", "DBM-Party-BC", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(16807)

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
