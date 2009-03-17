local mod = DBM:NewMod("Thorim", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local timerStormhammer		= mod:NewTimer(16, "TimerStormhammer", 62042)
local timerUnbalancingStrike	= mod:NewTimer(15, "TimerUnbalancingStrike", 62130)

local warnStormhammer		= mod:NewAnnounce("WarningStormhammer", 1, 62470)
local warnUnbalancingStrike	= mod:NewAnnounce("UnbalancingStrike", 4, 62130)	-- nice blizzard, very new stuff, hmm or not? ^^ aq40 4tw :)

local enrageTimer		= mod:NewEnrageTimer(310)

local phase = 0
function mod:OnCombatStart(delay)
	phase = 1
	enrageTimer:Start()
end

function mod:OnCombatEnd()
	enrageTimer:Stop()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62042 then -- storm hammer
		timerStormhammer:Start()
		warnStormhammer:Show(args.destName)

	elseif args.spellId == 62130 then	-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
		if GetInstanceDifficulty() == 1 then
			timerUnbalancingStrike:Start(6)
		else
			timerUnbalancingStrike:Start(15)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase1 then		-- Arena Event
		enrageTimer:Start()

	elseif msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		enrageTimer:Stop()
	end
end


