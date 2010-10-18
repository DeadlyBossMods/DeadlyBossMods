local mod	= DBM:NewMod("DarkIronGolemCouncil", "DBM-BlackwingDescent", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42180, 42178, 42179, 42166)	-- add members!	(42180 = Toxitron // 42178 = Magmatron // 42179 = Electron // 42166 = Arcanotron)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)