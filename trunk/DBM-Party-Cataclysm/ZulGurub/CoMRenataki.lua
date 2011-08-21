local mod	= DBM:NewMod("CoMRenataki", "DBM-Party-Cataclysm", 11)
--local mod	= DBM:NewMod(605, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52269)
mod:SetModelID(37830)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_INTERRUPT",
	"SPELL_CAST_SUCCESS"
)

