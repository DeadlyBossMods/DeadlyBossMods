local mod = DBM:NewMod("Faerlina", "DBM-Naxx", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15953)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnEmbraceActive		= mod:NewAnnounce("WarningEmbraceActive", 1, 28732)
local warnEmbraceExpire		= mod:NewAnnounce("WarningEmbraceExpire", 2, 28732)
local warnEmbraceExpired	= mod:NewAnnounce("WarningEmbraceExpired", 3, 28732)
local warnEnrageSoon		= mod:NewAnnounce("WarningEnrageSoon", 3, 28131)
local warnEnrageNow		= mod:NewAnnounce("WarningEnrageNow", 4, 28131)

local timerEmbrace		= mod:NewTimer(30, "TimerEmbrace", 28732)
local timerEnrage		= mod:NewTimer(60, "TimerEnrage", 28131)

local embraceSpam = 0
local enraged = false

function mod:OnCombatStart(delay)
	timerEnrage:Start(-delay)
	warnEnrageSoon:Schedule(55 - delay)
	enraged = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if (args.spellId == 28732				-- Widow's Embrace (10)
	or args.spellId == 54097)				-- Widow's Embrace (25)
	and (GetTime() - embraceSpam) > 5 then  -- This spell is casted twice in Naxx 25 (bug?)
		embraceSpam = GetTime()
		warnEmbraceExpire:Cancel()
		warnEmbraceExpired:Cancel()
		warnEnrageSoon:Cancel()
		timerEnrage:Stop()
		if enraged then
			timerEnrage:Start()
			warnEnrageSoon:Schedule(45)
		end
		timerEmbrace:Start()
		warnEmbraceActive:Show()
		warnEmbraceExpire:Schedule(25)
		warnEmbraceExpired:Schedule(30)
		enraged = false
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28798
	or args.spellId == 54100 then			-- Frenzy
		warnEnrageNow:Show()
		enraged = GetTime()
	end
end

