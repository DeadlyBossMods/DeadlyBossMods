local mod	= DBM:NewMod("ValionaTheralion", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)