local mod	= DBM:NewMod("Gnoll", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 101612",
	"SPELL_AURA_REMOVED 101612",
	"UNIT_SPELLCAST_SUCCEEDED player",
	"QUEST_WATCH_UPDATE"
)
mod.noStatistics = true

local warnGameOverQuest			= mod:NewAnnounce("warnGameOverQuest", 2, 101612, nil, false)
local warnGameOverNoQuest		= mod:NewAnnounce("warnGameOverNoQuest", 2, 101612, nil, false)
mod:AddBoolOption("warnGameOver", true, "announce")
local warnGnoll					= mod:NewAnnounce("warnGnoll", 2, nil, false)

local specWarnHogger			= mod:NewSpecialWarning("specWarnHogger")

local timerGame					= mod:NewBuffActiveTimer(60, 101612)

local countdownGame				= mod:NewCountdownFades(60, 101612)

local gameEarnedPoints = 0
local gameMaxPoints = 0

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 101612 and args:IsPlayer() then
		gameEarnedPoints = 0
		gameMaxPoints = 0
		timerGame:Start()
		countdownGame:Start(60)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 101612 and args:IsPlayer() then
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellID)
	if spellID == 102044 then--Hogger
		if gameEarnedPoints < 30 then--You earned 30 points in first game, stop counting points you didn't earn so you get more accurate depiction of hwo many you missed, not how many you ignored when you finished.
			gameMaxPoints = gameMaxPoints + 3
		end
		if self:AntiSpam() then
			specWarnHogger:Show()
		end
	elseif spellID == 102036 then--Gnoll
		if gameEarnedPoints < 30 then
			gameMaxPoints = gameMaxPoints + 1
		end
		warnGnoll:Show()
	end
end

function mod:QUEST_WATCH_UPDATE()
	gameEarnedPoints = gameEarnedPoints + 1
end
