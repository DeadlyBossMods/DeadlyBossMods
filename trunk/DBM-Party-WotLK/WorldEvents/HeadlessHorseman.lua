local mod = DBM:NewMod("HeadlessHorseman", "DBM-Party-WotLK", 17)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23682, 23775)

mod:RegisterCombat("combat")
mod:RegisterKill("say", L.SayCombatEnd)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY"
)

local warnConflag					= mod:NewTargetAnnounce(42380)
local warnSquashSoul				= mod:NewTargetAnnounce(42514)
local timerConflag					= mod:NewTargetTimer(4, 42380)
local timerSquashSoul				= mod:NewTargetTimer(15, 42514)
local warnHorsemanSoldiers			= mod:NewAnnounce("warnHorsemanSoldiers")
local specWarnHorsemanHead			= mod:NewSpecialWarning("specWarnHorsemanHead")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42380) then											-- Conflagration
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif args:IsSpellID(42514) then											-- Squash Soul
		warnSquashSoul:Show(args.destName)
		timerSquashSoul:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.HorsemanHead then											-- No combatlog event for head spawning, Emote works iffy(head doesn't emote First time, only 2nd and forward)
		specWarnHorsemanHead:Show()
	elseif msg == L.HorsemanSoldiers then									-- Warning for adds spawning.
		warnHorsemanSoldiers:Show()
	end
end

