local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS"
)

local specWarnEyebeam		= mod:NewSpecialWarning("SpecialWarningEyebeam")
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

function mod:SPELL_CAST_START(args)
--	if args.spellId == 63346 or args.spellId == 63976 then		-- Focused Eyebeam
	if args.spellId == 63783 or args.spellId == 63982 then		-- Shockwave	
		timerNextShockwave:Start()

	elseif args.spellId == 62030 or args.spellId == 63980 then 	-- Petrifying Breath
		timerPetrifyingBreath:Start()

--	elseif args.spellId == 64290 or args.spellId == 64292 then	-- Stone Grip
		-- startet by emote?
	end
end

local gripTargets = {}
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63981 then
		table.insert(gripTargets, args.destName)
		self:UnscheduleMethod(0.2, "GripAnnounce")
		if #gripTargets >= 3 then
			self:GripAnnounce()
		end
		self:ScheduleMethod(0.2, "GripAnnounce")
	end
end

function mod:GripAnnounce()
	warnGrip:Show(unpack(gripTargets))
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 63343 or args.spellId == 63701 then		-- Eyebeam (the patch on the ground)
		if args.destName == UnitName("player") then
			specWarnEyebeam:Show()
		end
		timerEyebeam:Start(args.destName)
		warnEyebeam:Show(args.destName)
		if self.Options.SetIconOnEyebeamTarget then
			mod:SetIcon(args.destName, 8, 10)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg) -- maybe it's possible to use a UNIT_DIED event or something like this here to get rid of the translation issue
	if msg == L.Yell_Trigger_arm_left then
		timerRespawnLeftArm:Start()

	elseif msg == L.Yell_Trigger_arm_right then
		timerRespawnRightArm:Start()
	end
end

