local mod = DBM:NewMod("Onyxia", "DBM-Onyxia")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(10184)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local timerBreath	= mod:NewTimer(6, "TimerBreath", 17086)
local timerWhelps	= mod:NewTimer(79, "TimerWhelps", 10697)

local specWarnBreath	= mod:NewSpecialWarning("SpecWarnBreath")
local warnWhelpsSoon	= mod:NewAnnounce("WarnWhelpsSoon", 1)
local sndBreath			= mod:NewRunAwaySound(nil, "SoundBreath")
local timerAchieve		= mod:NewAchievementTimer(300, 4405, "TimerSpeedKill") 

local sndFunny			= mod:NewSound(nil, "SoundWTF", false)

function mod:OnCombatStart(delay)
   timerAchieve:Start(-delay)
   sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\dps-very-very-slowly.mp3")
   sndFunny:Schedule(20, "Interface\\AddOns\\DBM-Onyxia\\sounds\\hit-it-like-you-mean-it.mp3")
   sndFunny:Schedule(30, "Interface\\AddOns\\DBM-Onyxia\\sounds\\now-hit-it-very-hard-and-fast.mp3")
end 

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Breath then
		self:SendSync("Breath")
		sndBreath:Play()
	end
end

mod.CHAT_MSG_MONSTER_EMOTE = mod.CHAT_MSG_RAID_BOSS_EMOTE -- todo: check if this is necessary

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellP2 then
		self:SendSync("Phase2")
	elseif msg == L.YellP3 then
		self:SendSync("Phase3")
	end
end

function mod:Whelps()
	if self:IsInCombat() then
		timerWhelps:Start()
		warnWhelpsSoon:Schedule(67)
		self:ScheduleMethod(79, "Whelps")
	end
end

function mod:OnSync(msg)
	if msg == "Breath" then
		specWarnBreath:Show()
		timerBreath:Start()
	elseif msg == "Phase2" then
		self:Whelps()
		sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\i-dont-see-enough-dots.mp3")
		sndFunny:Schedule(10, "Interface\\AddOns\\DBM-Onyxia\\sounds\\throw-more-dots.mp3")
		sndFunny:Schedule(20, "Interface\\AddOns\\DBM-Onyxia\\sounds\\whelps-left-side-even-side-handle-it.mp3")
	elseif msg == "Phase3" then
		self:UnscheduleMethod("Whelps")
		timerWhelps:Stop()
		warnWhelpsSoon:Cancel()

		sndFunny:Schedule(20, "Interface\\AddOns\\DBM-Onyxia\\sounds\\now-hit-it-very-hard-and-fast.mp3")
	end
end

function mod:UNIT_DIED(args)
	if args:IsPlayer() then
		sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\thats-a-fucking-fifty-dkp-minus.mp3")
	end
end

