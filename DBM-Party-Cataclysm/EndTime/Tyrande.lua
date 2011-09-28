local mod	= DBM:NewMod("EchoTyrande", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(38918)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
