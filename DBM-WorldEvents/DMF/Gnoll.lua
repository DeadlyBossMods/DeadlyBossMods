local mod	= DBM:NewMod("Gnoll", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnGameOver				= mod:NewAnnounce("warnGameOver", 2)--Can't find a way to track how many points YOU earned yet though. If i do, i'll update this to say "Earned x out of x total possible points this game". It'll be a nice self challenge mode ;)
local warnGnoll					= mod:NewAnnounce("warnGnoll", 2, nil, false)
local warnHogger				= mod:NewAnnounce("warnHogger", 4)

local specWarnHogger			= mod:NewSpecialWarning("specWarnHogger")

local timerGame					= mod:NewBuffActiveTimer(60, 101612)

local countdownGame				= mod:NewCountdown(60, 101612)

local gameMaxPoints = 0

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		gameMaxPoints = 0
		timerGame:Start()
		countdownGame:Start(60)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		timerGame:Cancel()
		countdownGame:Cancel()
		warnGameOver:Show(gameMaxPoints)
	end
end

do 
	local antiSpam = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
		if spellID == 102044 then--Hogger
			gameMaxPoints = gameMaxPoints + 3
			warnHogger:Show()
			if GetTime() - antiSpam > 2 then
				specWarnHogger:Show()
			end
			antiSpam = GetTime()
		elseif spellID == 102036 then--Gnoll
			gameMaxPoints = gameMaxPoints + 1
			warnGnoll:Show()
		end
	end
end
