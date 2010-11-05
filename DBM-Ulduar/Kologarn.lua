local mod	= DBM:NewMod("Kologarn", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32930)--, 32933, 32934
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_DIED"
)

mod:SetBossHealthInfo(
	32930, L.Health_Body,
	32934, L.Health_Right_Arm,
	32933, L.Health_Left_Arm
)

local warnFocusedEyebeam		= mod:NewTargetAnnounce(63346, 3)
local warnGrip					= mod:NewTargetAnnounce(64292, 2)
local warnCrunchArmor			= mod:NewTargetAnnounce(64002, 2)

local specWarnCrunchArmor2		= mod:NewSpecialWarningStack(64002, false, 2)
local specWarnEyebeam			= mod:NewSpecialWarningYou(63346)

local timerCrunch10             = mod:NewTargetTimer(6, 63355)
local timerNextShockwave		= mod:NewCDTimer(18, 63982)
local timerNextEyebeam			= mod:NewCDTimer(17.5, 63346)--Experimental.
local timerNextGrip				= mod:NewCDTimer(20, 64292)
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm")
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm")
local timerTimeForDisarmed		= mod:NewTimer(10, "achievementDisarmed")	-- 10 HC / 12 nonHC

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("SetIconOnGripTarget", true)
mod:AddBoolOption("PlaySoundOnEyebeam", true)
mod:AddBoolOption("SetIconOnEyebeamTarget", true)
mod:AddBoolOption("YellOnBeam", true, "announce")

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 32934 then 		-- right arm
		timerRespawnRightArm:Start()
		timerNextGrip:Cancel()
		if mod:IsDifficulty("normal10") then
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
	if msg:find(L.FocusedEyebeam) then
		self:SendSync("EyeBeamOn", UnitName("player"))
	end
end

function mod:OnSync(msg, target)
	if msg == "EyeBeamOn" then
		warnFocusedEyebeam:Show(target)
		timerNextEyebeam:Start()
		if target == UnitName("player") then
			specWarnEyebeam:Show()
			if self.Options.PlaySoundOnEyebeam then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav") 
			end
			if self.Options.YellOnBeam then
				SendChatMessage(L.YellBeam, "SAY")
			end
		end 
		if self.Options.SetIconOnEyebeamTarget then
			self:SetIcon(target, 5, 8) 
		end
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
	elseif args:IsSpellID(64002, 63355) then	-- Crunch Armor
        warnCrunchArmor:Show(args.destName)
		if mod:IsDifficulty("heroic10") then
            timerCrunch10:Start(args.destName)  -- We track duration timer only in 10-man since it's only 6sec and tanks don't switch.
		end
    end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(64002) then		        -- Crunch Armor (25-man only)
		warnCrunchArmor:Show(args.destName)
        if args.amount >= 2 then 
            if args:IsPlayer() then
                specWarnCrunchArmor2:Show(args.amount)
            end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64290, 64292) then
		self:SetIcon(args.destName, 0)
    end
end