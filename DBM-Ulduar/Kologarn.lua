local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetZone()

mod:RegisterCombat("combat", 32930, 32933, 32934)

--32934 ^-- right arm
--32933 ^-- left arm
--32930 -- kologarn

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnEyebeam		= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnGrip			= mod:NewAnnounce("WarnGrip", 2)


mod:AddBoolOption("SetIconOnEyebeamTarget", true)

local timerNextShockwave		= mod:NewCDTimer(18, 63982)
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm")

mod:AddBoolOption("SetIconOnGripTarget", true)

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Yell_Trigger_arm_left then
		timerRespawnLeftArm:Start()

	elseif msg == L.Yell_Trigger_arm_right then
		timerRespawnRightArm:Start()
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


