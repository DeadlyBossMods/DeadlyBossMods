local mod	= DBM:NewMod("AlAkir", "DBM-ThroneFourWinds", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46753)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)