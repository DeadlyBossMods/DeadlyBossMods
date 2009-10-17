local mod = DBM:NewMod("HeadlessHorseman", "DBM-Party-WotLK", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(23682)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)