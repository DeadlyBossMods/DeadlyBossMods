local mod	= DBM:NewMod("AscendantCouncil", "DBM-BastionTwilight", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43735)	-- update with members!	(43735 = Elementium Monstrosity)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)