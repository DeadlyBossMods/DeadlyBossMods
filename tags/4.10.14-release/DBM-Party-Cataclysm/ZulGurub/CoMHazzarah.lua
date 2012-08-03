local mod	= DBM:NewMod(178, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52271)
mod:SetModelID(37832)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

