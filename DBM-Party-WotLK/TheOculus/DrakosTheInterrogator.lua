local mod	= DBM:NewMod("DrakosTheInterrogator", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27654)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)