local mod = DBM:NewMod("Thekal", "DBM-Party-BC", 17)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7 $"):sub(12, -3))

mod:SetCreatureID(14509, 11348, 11347)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)


local warnSimulKill		= mod:NewAnnounce("WarnSimulKill", 1)
local timerSimulKill	= mod:NewTimer(12, "TimerSimulKill")
local warnHeal			= mod:NewCastAnnounce(24208)
local timerHeal			= mod:NewCastTimer(4, 24208)
local warnBlind			= mod:NewTargetAnnounce(21060)
local timerBlind		= mod:NewTargetTimer(10, 21060)
local warnGouge			= mod:NewTargetAnnounce(12540)
local timerGouge		= mod:NewTargetTimer(4, 12540)
local warnPhase2		= mod:NewPhaseAnnounce(2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 24208 then
		warnHeal:Show()
		timerHeal:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 21060 then     --Blind Daze
		warnBlind:Show(args.destName)
		timerBlind:Start(args.destName)
	elseif args.spellId == 12540 then --Gouge Stun
		warnGouge:Show(args.destName)
		timerGouge:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 21060 then
		timerBlind:Cancel(args.destName)
    elseif args.spellId == 12540 then
        timerGouge:Cancel(args.destName)
	end
end

local killTime = 0
function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.PriestDied then		-- Starts timer before ressurection of adds.
		if (GetTime() - killTime) > 20 then
			warnSimulKill:Show()
			timerSimulKill:Start()
			killTime = GetTime()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		warnPhase2:Show()
		timerSimulKill:Cancel()
	end
end