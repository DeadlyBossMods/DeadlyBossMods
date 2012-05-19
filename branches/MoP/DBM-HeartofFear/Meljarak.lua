local mod	= DBM:NewMod("Meljarak", "DBM-HeartofFear", nil)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
--mod:SetModelID(41813)	-- Needs to be changed

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
