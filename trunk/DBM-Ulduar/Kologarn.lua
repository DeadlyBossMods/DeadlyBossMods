local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnEyebeam			= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnGrip				= mod:NewAnnounce("Grip on >%s<, >%s< and >%s<", 2)


mod:AddBoolOption("SetIconOnEyebeamTarget", true)

local timerNextShockwave		= mod:NewCDTimer(18, 63982)
local timerRespawnLeftArm		= mod:NewTimer(50, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(50, "timerRightArm")

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
	elseif args.spellid == 63976 and args.destName == UnitName("player") then
		specWarnEyebeam:Show()
	end
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(unpack(gripTargets))
	table.wipe(gripTargets)
end
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62166 or args.spellId == 64292 then
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod("GripAnnounce")

		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, (8-#gripTargets), 10)
		end

		if #gripTargets >= 3 then
			self:GripAnnounce()
		else
			self:ScheduleMethod(0.2, "GripAnnounce")
		end
	end
end


