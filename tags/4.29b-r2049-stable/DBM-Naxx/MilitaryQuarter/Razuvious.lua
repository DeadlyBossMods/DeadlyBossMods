local mod = DBM:NewMod("Razuvious", "DBM-Naxx", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16061)

mod:RegisterCombat("yell", L.Yell1, L.Yell2, L.Yell3, L.Yell4)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnShoutNow		= mod:NewAnnounce("WarningShoutNow", 1, 55543, false)
local warnShoutSoon		= mod:NewAnnounce("WarningShoutSoon", 3, 55543, false)
local warnShieldWall	= mod:NewAnnounce("WarningShieldWallSoon", 3, 29061)

local timerShout		= mod:NewTimer(16, "TimerShout", 55543)
local timerTaunt		= mod:NewTimer(20, "TimerTaunt", 29060)
local timerShieldWall	= mod:NewTimer(20, "TimerShieldWall", 29061)

function mod:OnCombatStart(delay)
	timerShout:Start(16 - delay)
	warnShoutSoon:Schedule(11 - delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 55543       -- Disrupting Shout (10)
	or args.spellId == 29107 then  -- Disrupting Shout (25)
		timerShout:Start()
		warnShoutNow:Show()
		warnShoutSoon:Schedule(11)
	elseif args.spellId == 29060 then -- Taunt
		timerTaunt:Start()
	elseif args.spellId == 29061 then -- ShieldWall
		timerShieldWall:Start()
		warnShieldWall:Schedule(15)
	end
end
