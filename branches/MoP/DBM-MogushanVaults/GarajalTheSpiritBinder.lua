local mod	= DBM:NewMod(682, "DBM-MogushanPalace", 3, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(41256)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
