local mod	= DBM:NewMod("Porung", "DBM-Party-BC", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(20923)

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
