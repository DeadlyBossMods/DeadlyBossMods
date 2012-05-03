local mod	= DBM:NewMod(726, "DBM-MogushanPalace", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(41399)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
