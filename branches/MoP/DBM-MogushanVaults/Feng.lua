local mod	= DBM:NewMod(689, "DBM-MogushanPalace", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(41192)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
