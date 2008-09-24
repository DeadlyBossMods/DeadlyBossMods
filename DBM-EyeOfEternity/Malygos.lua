local mod = DBM:NewMod("Malygos", "DBM-EyeOfEternity")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28859)
mod:SetZone()

mod:SetModelScale(0.3)
--mod:SetModelMoveSpeed(3.0)
mod:SetModelOffset(0, -0.95, 0)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSpark		= mod:NewAnnounce("WarningSpark", 1, 59381)
local warnVortex	= mod:NewAnnounce("WarningVortex", 3, 56105)
local warnBreathInc	= mod:NewAnnounce("WarningBreathSoon", 3, 60071)
local warnBreath	= mod:NewAnnounce("WarningBreath", 4, 60071)

local timerSpark	= mod:NewTimer(30, "TimerSpark", 59381)
local timerVortex	= mod:NewTimer(11, "TimerVortex", 56105)
local timerBreath	= mod:NewTimer(59, "TimerBreath", 60071)


function mod:OnCombatStart(delay)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpark then
		self:SendSync("Spark")
	elseif msg == L.EmoteBreath then
		self:SendSync("Breath")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 56105 then
		warnVortex:Show()
		timerVortex:Start()
		if timerSpark:GetTime() < 11 then
			timerSpark:Update(18, 30)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:sub(0, L.YellPhase2:len()) == L.YellPhase2 then
		self:SendSync("Phase2")
	elseif msg == L.YellBreath then
		self:SendSync("BreathSoon")
	end
end

function mod:OnSync(event, arg)
	if event == "Spark" then
		warnSpark:Show()
		timerSpark:Start()
	elseif event == "Phase2" then
		timerSpark:Stop()
		timerBreath:Start(92)
	elseif event == "Breath" then
		timerBreath:Schedule(1)
		warnBreath:Schedule(1)
	elseif event == "BreathSoon" then
		warnBreathInc:Show()
	end
end
