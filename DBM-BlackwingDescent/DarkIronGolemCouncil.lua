local mod	= DBM:NewMod("DarkIronGolemCouncil", "DBM-BlackwingDescent", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42180)	-- add members!	(42180 = Toxitron)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)