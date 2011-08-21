local mod	= DBM:NewMod("CoMGrilek", "DBM-Party-Cataclysm", 11)
--local mod	= DBM:NewMod(603, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52258)
mod:SetModelID(37829)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_INTERRUPT",
	"SPELL_CAST_SUCCESS"
)

