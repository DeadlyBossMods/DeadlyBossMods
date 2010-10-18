local mod	= DBM:NewMod("Chogall", "DBM-BastionTwilight", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46900)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)