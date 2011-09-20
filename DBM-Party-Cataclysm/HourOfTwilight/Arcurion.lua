local mod	= DBM:NewMod("Arcurion", "DBM-Party-Cataclysm", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(12345)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
