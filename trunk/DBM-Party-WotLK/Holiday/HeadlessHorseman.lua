local mod = DBM:NewMod("HeadlessHorseman", "DBM-Party-WotLK", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1822 $"):sub(12, -3))
mod:SetCreatureID(23682, 23775)

mod:RegisterCombat("combat")
mod:RegisterKill("say", L.SayCombatEnd)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_SAY"
)

local warnConflag					= mod:NewTargetAnnounce(42380)
local timerConflag					= mod:NewTargetTimer(4, 42380)
local warnHorsemanSoldiers			= mod:NewAnnounce("warnHorsemanSoldiers")
local specWarnHorsemanHead			= mod:NewSpecialWarning("specWarnHorsemanHead")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42380) then											-- Conflagration
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.HorsemanHead then											-- No combatlog event for head spawning, Emote works iffy(head doesn't always emote right away, or at all when seperated)
		specWarnHorsemanHead:Show()
	elseif msg == L.HorsemanSoldiers then									-- Warning for adds spawning.
		warnHorsemanSoldiers:Show()
	end
end