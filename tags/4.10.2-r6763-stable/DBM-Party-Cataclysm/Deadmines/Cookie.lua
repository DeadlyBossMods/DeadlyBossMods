local mod	= DBM:NewMod("Cookie", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(47739)
mod:SetModelID(1305)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)