local mod	= DBM:NewMod("Onyxia", "DBM-Onyxia")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(10184)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

local warnWhelpsSoon		= mod:NewAnnounce("WarnWhelpsSoon", 1)
local sndBreath				= mod:NewRunAwaySound(nil, "SoundBreath")
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnPhase3Soon		= mod:NewAnnounce("WarnPhase3Soon", 2)

local specWarnBreath		= mod:NewSpecialWarning("SpecWarnBreath")
local specWarnBlastNova		= mod:NewSpecialWarning("SpecWarnBlastNova", isMelee)
mod:AddBoolOption("PlaySoundOnBlastNova", isMelee)

local timerNextBreath		= mod:NewNextTimer(70, 17086)--Experimental, if it is off please let me know.
local timerBreath			= mod:NewTimer(6, "TimerBreath", 17086)
local timerWhelps			= mod:NewTimer(105, "TimerWhelps", 10697)
local timerAchieve			= mod:NewAchievementTimer(300, 4405, "TimerSpeedKill") 
local timerAchieveWhelps	= mod:NewAchievementTimer(10, 4406, "TimerWhelps") 

local sndFunny				= mod:NewSound(nil, "SoundWTF")

local warned_preP3 = false
local phase = 0
function mod:OnCombatStart(delay)
	phase = 1
	warned_preP3 = false
	timerAchieve:Start(-delay)
	sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\dps-very-very-slowly.mp3")
	sndFunny:Schedule(20, "Interface\\AddOns\\DBM-Onyxia\\sounds\\hit-it-like-you-mean-it.mp3")
	sndFunny:Schedule(30, "Interface\\AddOns\\DBM-Onyxia\\sounds\\now-hit-it-very-hard-and-fast.mp3")
end 

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
		warnWhelpsSoon:Schedule(95)
		self:ScheduleMethod(105, "Whelps")
		-- we replay sounds as long as p2 is running
		sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\i-dont-see-enough-dots.mp3")
		sndFunny:Schedule(35, "Interface\\AddOns\\DBM-Onyxia\\sounds\\throw-more-dots.mp3")
	end
end

function mod:OnSync(msg)
	if msg == "Phase2" then
		phase = 2
		warnPhase2:Show()
		timerNextBreath:Start(85)
		timerAchieveWhelps:Start()
		self:ScheduleMethod(5, "Whelps")
		sndFunny:Schedule(10, "Interface\\AddOns\\DBM-Onyxia\\sounds\\throw-more-dots.mp3")
		sndFunny:Schedule(17, "Interface\\AddOns\\DBM-Onyxia\\sounds\\whelps-left-side-even-side-handle-it.mp3")
	elseif msg == "Phase3" then
		phase = 3
		warnPhase3:Show()
		self:UnscheduleMethod("Whelps")
		timerWhelps:Stop()
		timerNextBreath:Stop()
		warnWhelpsSoon:Cancel()
		sndFunny:Schedule(20, "Interface\\AddOns\\DBM-Onyxia\\sounds\\now-hit-it-very-hard-and-fast.mp3")
   		sndFunny:Schedule(35, "Interface\\AddOns\\DBM-Onyxia\\sounds\\i-dont-see-enough-dots.mp3")
		sndFunny:Schedule(50, "Interface\\AddOns\\DBM-Onyxia\\sounds\\hit-it-like-you-mean-it.mp3")
		sndFunny:Schedule(65, "Interface\\AddOns\\DBM-Onyxia\\sounds\\throw-more-dots.mp3")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68958) then
        	specWarnBlastNova:Show()
		if self.Options.PlaySoundOnBlastNova then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args:IsSpellID(17086, 18351, 18584, 18609) or args:IsSpellID(18564, 18584, 18596, 18617) then		-- 1 ID for each direction?
		specWarnBreath:Show()
		timerBreath:Start()
		timerNextBreath:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(68867, 69286) and args:IsPlayer() then		-- Tail Sweep
		sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\watch-the-tail.mp3")
	end
end

function mod:UNIT_DIED(args)
	if self:IsInCombat() and args:IsPlayer() then
		sndFunny:Play("Interface\\AddOns\\DBM-Onyxia\\sounds\\thats-a-fucking-fifty-dkp-minus.mp3")
	end
end

function mod:UNIT_HEALTH(uId)
	if phase == 2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 10184 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end

