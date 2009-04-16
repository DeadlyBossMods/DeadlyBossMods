local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnEyebeam			= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnGrip				= mod:NewAnnounce("Grip on >%s<, >%s< and >%s<", 2)
local warnEyebeam			= mod:NewAnnounce("WarningEyebeam", 2, 63976)
local timerEyebeam			= mod:NewTimer(10, "timerEyebeam", 63976)


mod:AddBoolOption("SetIconOnEyebeamTarget", true)

local timerPetrifyingBreath		= mod:NewTimer(4, "timerPetrifyingBreath", 63980)	-- never seen this in the movie looks like a "move away" type
local timerNextShockwave		= mod:NewTimer(22, "timerNextShockwave", 63982)		-- don't really know, movie quality was low ;)
local timerRespawnLeftArm		= mod:NewTimer(60, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(60, "timerRightArm")

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62030 or args.spellId == 63980 then 	-- Petrifying Breath
		timerPetrifyingBreath:Start()
	end
end

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
	end
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(unpack(gripTargets))
	table.wipe(gripTargets)
end
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62166 or args.spellId == 63981 then
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod("GripAnnounce")
		if #gripTargets >= 3 then
			self:GripAnnounce()
		end
		self:ScheduleMethod(0.2, "GripAnnounce")
	end
end


