local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(0) missing
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnEyebeam			= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnEyebeam			= mod:NewAnnounce("WarningEyebeam", 2, 63976)
local timerEyebeam			= mod:NewTimer(10, "timerEyebeam", 63976)
mod:AddBoolOption("SetIconOnEyebeamTarget", true)

local timerPetrifyingBreath		= mod:NewTimer(4, "timerPetrifyingBreath", 63980)	-- never seen this in the movie looks like a "move away" type

local timerNextShockwave		= mod:NewTimer(22, "timerNextShockwave", 63982)		-- don't realy know, move quality was anoying ;)

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
		-- startet by emote / I think, no message is required
	end
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

function mod:CHAT_MSG_MONSTER_YELL(msg) -- maybe its possible from combatlog to get a UNIT_DIED or something like this event so no translation is required
	if msg == L.Yell_Trigger_arm_left then
		timerRespawnLeftArm:Start()

	elseif msg == L.Yell_Trigger_arm_right then
		timerRespawnRightArm:Start()
	end
end

