local mod	= DBM:NewMod(683, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(12345)	-- Needs to be changed
mod:SetModelID(41503)--Protector Kaolan, 41502 and 41504 are elders

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
