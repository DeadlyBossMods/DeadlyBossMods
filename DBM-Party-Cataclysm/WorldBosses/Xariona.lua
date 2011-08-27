local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5750 $"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

