local mod	= DBM:NewMod("Gnoll", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"QUEST_WATCH_UPDATE"
)

local warnGameOverQuest			= mod:NewAnnounce("warnGameOverQuest", 2, 101612, nil, false)
local warnGameOverNoQuest		= mod:NewAnnounce("warnGameOverNoQuest", 2, 101612, nil, false)
mod:AddBoolOption("warnGameOver", true, "announce")
local warnGnoll					= mod:NewAnnounce("warnGnoll", 2, nil, false)
local warnHogger				= mod:NewAnnounce("warnHogger", 4)

local specWarnHogger			= mod:NewSpecialWarning("specWarnHogger")

local timerGame					= mod:NewBuffActiveTimer(60, 101612)

local countdownGame				= mod:NewCountdown(60, 101612)

local gameEarnedPoints = 0
local gameMaxPoints = 0

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		gameEarnedPoints = 0
		gameMaxPoints = 0
		timerGame:Start()
		countdownGame:Start(60)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		timerGame:Cancel()
		countdownGame:Cancel()
		if self.Options.warnGameOver then
			if gameEarnedPoints > 0 then
				warnGameOverQuest:Show(gameEarnedPoints, gameMaxPoints)
			else
				warnGameOverNoQuest:Show(gameMaxPoints)
			end
		end
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

function mod:QUEST_WATCH_UPDATE()
	gameEarnedPoints = gameEarnedPoints + 1
end
