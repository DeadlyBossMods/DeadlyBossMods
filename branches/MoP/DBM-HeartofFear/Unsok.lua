local mod	= DBM:NewMod("Unsok", "DBM-HeartofFear", nil)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
--mod:SetModelID(41399)	-- Needs to be changed

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
