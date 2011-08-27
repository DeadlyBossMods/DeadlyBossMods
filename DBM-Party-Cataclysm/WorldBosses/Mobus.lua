local mod	= DBM:NewMod("Mobus", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5750 $"):sub(12, -3))
mod:SetCreatureID(50009)
mod:SetModelID(37338)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

