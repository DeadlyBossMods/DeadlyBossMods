local mod	= DBM:NewMod(687, "DBM-MogushanPalace", nil, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(41813)	-- Meng Sharpfang (listed as main boss)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
