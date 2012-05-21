local mod	= DBM:NewMod(742, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(42832)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
