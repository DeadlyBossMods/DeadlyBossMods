local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetZone()

mod:RegisterCombat("combat", 32930, 32933, 32934)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

mod:AddBoolOption("HealthFrame", true)
mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)


local specWarnEyebeam			= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnGrip				= mod:NewAnnounce("WarnGrip", 2)
local timerTimeForDisarmed		= mod:NewTimer(10, "achievementDisarmed")	-- 10 HC / 12 nonHC
local timerNextShockwave		= mod:NewCDTimer(18, 63982)
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm")

-- 5/23 00:33:48.648  SPELL_AURA_APPLIED,0x0000000000000000,nil,0x80000000,0x0480000001860FAC,"Hâzzad",0x4000512,63355,"Crunch Armor",0x1,DEBUFF


mod:AddBoolOption("SetIconOnGripTarget", true)

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Yell_Trigger_arm_left then
		timerRespawnLeftArm:Start()
		if GetInstanceDifficulty() == 1 then
			timerTimeForDisarmed:Start(12)
		else
			timerTimeForDisarmed:Start()
		end

	elseif msg == L.Yell_Trigger_arm_right then
		timerRespawnRightArm:Start()
		if GetInstanceDifficulty() == 1 then
			timerTimeForDisarmed:Start(12)
		else
			timerTimeForDisarmed:Start()
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if (args.spellId == 63783 or args.spellId == 63982) and args.destName == UnitName("player") then	-- Shockwave
		timerNextShockwave:Start()
	elseif (args.spellId == 63346 or args.spellId == 63976) and args.destName == UnitName("player") then
		specWarnEyebeam:Show()
	end
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64290 or args.spellId == 64292 then
		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, 8 - #gripTargets, 10)
		end
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod("GripAnnounce")
		if #gripTargets >= 3 then
			self:GripAnnounce()
		else
			self:ScheduleMethod(0.2, "GripAnnounce")
		end
	end
end


