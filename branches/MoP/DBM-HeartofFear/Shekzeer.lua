local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(42730)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
