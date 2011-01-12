local mod	= DBM:NewMod("Sinestra", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4829 $"):sub(12, -3))
mod:SetCreatureID(45213)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)