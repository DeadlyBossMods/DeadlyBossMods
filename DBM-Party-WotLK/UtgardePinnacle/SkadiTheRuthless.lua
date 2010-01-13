local mod	= DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26693)
mod:SetMinSyncRevision(3108)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warningPoison		= mod:NewTargetAnnounce(59331, 2)
local warningWhirlwind	= mod:NewSpellAnnounce(59322, 3)
local timerPoison		= mod:NewTargetTimer(12, 59331)
local timerWhirlwindCD	= mod:NewCDTimer(23, 59322)

local specWarnWhirlwind	= mod:NewSpecialWarningRun(59322)

local timerAchieve		= mod:NewAchievementTimer(180, 1873, "TimerSpeedKill")

local soundWhirlwind	= mod:NewSound(59322)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59331, 50255) then
		warningPoison:Show(args.destName)
		timerPoison:Start(args.destName)
	elseif args:IsSpellID(59322, 50228) then
		warningWhirlwind:Show()
		timerWhirlwindCD:Start()
		specWarnWhirlwind:Show()
		soundWhirlwind:Play()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(59331, 50255) then
		timerPoison:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2")
	elseif msg == L.CombatStart or msg:find(L.CombatStart) then
		self:SendSync("CombatStart")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Phase2" then
		warnPhase2:Show()
	elseif msg == "CombatStart" then
		if mod:IsDifficulty("heroic5") then
			timerAchieve:Start()
		end
	end
end