local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(46798)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START"
)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")