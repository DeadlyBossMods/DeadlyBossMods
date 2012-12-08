local mod	= DBM:NewMod("BrawlRank5", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(6923)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START"
)
