local mod = DBM:NewMod("Kologarn", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)
mod:SetUsedIcons(6, 7, 8)

mod:RegisterCombat("combat", 32930, 32933, 32934)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
--	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_DIED"
)

mod:AddBoolOption("HealthFrame", true)
mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)


local specWarnEyebeam			= mod:NewSpecialWarning("SpecialWarningEyebeam")
local warnGrip					= mod:NewAnnounce("WarnGrip", 2)
local timerTimeForDisarmed		= mod:NewTimer(10, "achievementDisarmed")	-- 10 HC / 12 nonHC
local timerNextShockwave		= mod:NewCDTimer(18, 63982)
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm")
local warnFocusedEyebeam		= mod:NewAnnounce("WarningEyeBeam", 3)

-- 5/23 00:33:48.648  SPELL_AURA_APPLIED,0x0000000000000000,nil,0x80000000,0x0480000001860FAC,"Hâzzad",0x4000512,63355,"Crunch Armor",0x1,DEBUFF
-- 6/3 21:41:56.140 UNIT_DIED,0x0000000000000000,nil,0x80000000,0xF1500080A60274A0,"Rechter Arm",0xa48 

mod:AddBoolOption("SetIconOnGripTarget", true)

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 32934 then 		-- right arm
		timerRespawnRightArm:Start()
		if mod:IsDifficulty("heroic10") then
			timerTimeForDisarmed:Start(12)
		else
			timerTimeForDisarmed:Start()
		end
	elseif self:GetCIDFromGUID(args.destGUID) == 32933 then		-- left arm
		timerRespawnLeftArm:Start()
		if mod:IsDifficulty("heroic10") then
			timerTimeForDisarmed:Start(12)
		else
			timerTimeForDisarmed:Start()
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(63783, 63982) and args:IsPlayer() then	-- Shockwave
		timerNextShockwave:Start()
	elseif args:IsSpellID(63346, 63976) and args:IsPlayer() then
		specWarnEyebeam:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg == L.FocusedEyebeam then
		self:SendSync("EyeBeamOn", UnitName("player"))
		specWarnEyebeam:Show()
	end
end

function mod:OnSync(event, arg)
	if event == "EyeBeamOn" and arg and DBM:GetRaidUnitId(arg) ~= "none" then
		warnFocusedEyebeam:Show(arg)
	end
end

local gripTargets = {}
function mod:GripAnnounce()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64290, 64292) then
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


