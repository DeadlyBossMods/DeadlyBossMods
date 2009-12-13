local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(37226, 36954)--Both creature Ids used in Halls of Reflection

mod:RegisterCombat("yell", L.CombatStart)
mod:RegisterKill("yell", L.YellCombatEnd)
mod:SetMinCombatTime(480)-- if you wipe, pull yell happens as soon as you zone back in despite the event not actually being started until you tell jaina you're ready to try again. This is only way to hack around this so mod doesn't wipe you for not being in combat after yell.
--The above also makes an achievement timer not possible. It would be right first pull but any pull after a wipe there is no way at all to detect when real event is started
mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_PERIODIC_DAMAGE"
)

