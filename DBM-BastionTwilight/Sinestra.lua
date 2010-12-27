local mod	= DBM:NewMod("Sinestra", "DBM-BastionTwilight", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4829 $"):sub(12, -3))
mod:SetCreatureID()
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)