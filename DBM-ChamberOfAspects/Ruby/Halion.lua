local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2317 $"):sub(12, -3))
mod:SetCreatureID()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

