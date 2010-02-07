local mod	= DBM:NewMod("ApothecaryTrio", "DBM-Party-WotLK", 17)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(36272, 36296, 36565)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY"
)
