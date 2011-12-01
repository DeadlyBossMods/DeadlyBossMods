local mod	= DBM:NewMod(197, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52571)
mod:SetModelID(37953)
mod:SetZone()
mod:SetUsedIcons(8)
mod:SetModelSound("Sound\\Creature\\FandralFlameDruid\\VO_FL_FANDRAL_GATE_INTRO_01.wav", "Sound\\Creature\\FandralFlameDruid\\VO_FL_FANDRAL_KILL_05.wav")
--Long: Well, well. I admire your tenacity. Baleroc stood guard over this keep for a thousand mortal lifetimes.
--Short: *Laughs, Burn

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnAdrenaline			= mod:NewStackAnnounce(97238, 3)
local warnFury					= mod:NewStackAnnounce(97235, 3)
local warnLeapingFlames			= mod:NewTargetAnnounce(100208, 3)
local warnOrbs					= mod:NewCastAnnounce(98451, 4)

local yellLeapingFlames			= mod:NewYell(100208)
local specWarnLeapingFlamesCast	= mod:NewSpecialWarningYou(98476)--Cast on you
local specWarnLeapingFlamesNear	= mod:NewSpecialWarningClose(98476)--Cast on you
local specWarnLeapingFlames		= mod:NewSpecialWarningMove(100208)--Standing in circle it left behind.
local specWarnSearingSeed		= mod:NewSpecialWarningMove(98450)
local specWarnOrb				= mod:NewSpecialWarningStack(100211, true, 4)

local timerOrbActive			= mod:NewBuffActiveTimer(64, 98451)
local timerOrb					= mod:NewBuffFadesTimer(6, 100211)
local timerSearingSeed			= mod:NewBuffFadesTimer(60, 98450)
local timerNextSpecial			= mod:NewTimer(4, "timerNextSpecial", 97238)--This one stays localized because it's 1 timer used for two abilities

local berserkTimer				= mod:NewBerserkTimer(600)

local soundSeed					= mod:NewSound(98450)

mod:AddBoolOption("RangeFrameSeeds", true)
mod:AddBoolOption("RangeFrameCat", false)--Diff options for each ability cause seeds strat is pretty universal, don't blow up raid, but leaps may or may not use a stack strategy, plus melee will never want it on by default.
mod:AddBoolOption("IconOnLeapingFlames", false)
mod:AddBoolOption("LeapArrow", true)

local abilityCount = 0
local recentlyJumped = false
local kitty = false
local targetScansDone = 0

local abilityTimers = {
	[0] = 17.3,--Sometimes this is 16.7
	[1] = 13.4,--Sometimes this is 12.7 sigh. Wonder what causes this variation?
	[2] = 11,--One of the few you can count on being consistent.
	[3] = 8.6,--Really it's between 8.5 and 8.6
	[4] = 7.4,--Sometimes 8 instead of 7.3-7.4
	[5] = 7.4,--Varies from 7.3 or 7.4 as well
	[6] = 6.1,--Varies between 6 even and 6.1 even.
	[7] = 6.1,
	[8] = 4.9,
	[9] = 4.9,
	[10]= 4.9
}

local function clearLeapWarned()
	recentlyJumped = false
end

function mod:LeapingFlamesTarget()
	local targetname = self:GetBossTarget(52571)
	if not targetname then return end
	warnLeapingFlames:Show(targetname)
	if self.Options.IconOnLeapingFlames then
		self:SetIcon(targetname, 8, 5)	-- 5seconds should be long enough to notice
	end
	if targetname == UnitName("player") then
		recentlyJumped = true--Anti Spam
		specWarnLeapingFlamesCast:Show()
		yellLeapingFlames:Yell()
		self:Schedule(4, clearLeapWarned)--So you don't get move warning too from debuff.
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 13 then
				recentlyJumped = true--Anti Spam
				specWarnLeapingFlamesNear:Show(targetname)
				if self.Options.LeapArrow then
					DBM.Arrow:ShowRunAway(x, y, 12, 5)
				end
				self:Schedule(2.5, clearLeapWarned)--Clear it a little faster for near warnings though, cause  you definitely don't need 4 seconds to move if it wasn't even on YOU.
			end
		end
	end
end

function mod:TargetScanner(SpellID, isTank)
	targetScansDone = targetScansDone + 1
	if UnitExists("boss1target") then--Better way to check if target exists and prevent nil errors at same time, without stopping scans from starting still. so even if target is nil, we stil do more checks instead of just blowing off a warning.
		local targetname = UnitName("boss1target")
		if UnitDetailedThreatSituation("boss1target", "boss1") and not isTank then--He's targeting his highest threat target.
			if targetScansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "TargetScanner", SpellID)--Check multiple times to be sure it's not on something other then tank.
			else
				self:TargetScanner(SpellID, true)--It's still on tank, force true isTank and activate else rule and warn target is on tank.
			end
		else--He's not targeting highest threat target (or isTank was set to true after 12 scans) so this has to be right target.
			self:UnscheduleMethod("TargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			self:LeapingFlamesTarget(targetname)
		end
	else--target was nil, lets schedule a rescan here too.
		if targetScansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "TargetScanner", SpellID)
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	abilityCount = 0
	kitty = false
	targetScansDone = 0
end

function mod:OnCombatEnd()
	if self.Options.RangeFrameSeeds or self.Options.RangeFrameCat then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(98374) then		-- Cat Form (99574? maybe the form id for druids with staff)
		kitty = true
		abilityCount = 0
		timerNextSpecial:Cancel()
		timerNextSpecial:Start(abilityTimers[abilityCount], GetSpellInfo(100208), abilityCount+1)
		if self.Options.RangeFrameCat then
			DBM.RangeCheck:Show(10)
		end
	elseif args:IsSpellID(98379) then	-- Scorpion Form
		kitty = false
		abilityCount = 0
		timerNextSpecial:Cancel()
		timerNextSpecial:Start(abilityTimers[abilityCount], GetSpellInfo(98474), abilityCount+1)
		if self.Options.RangeFrameCat and not UnitDebuff("player", GetSpellInfo(98450)) then--Only hide range finder if you do not have seed.
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(97238) then
		abilityCount = (args.amount or 1)--This should change your ability account to his current stack, which is disconnect friendly.
		warnAdrenaline:Show(args.destName, args.amount or 1)
		if kitty then
			timerNextSpecial:Start(abilityTimers[abilityCount], GetSpellInfo(100208), abilityCount+1)
		else
			timerNextSpecial:Start(abilityTimers[abilityCount], GetSpellInfo(98474), abilityCount+1)
		end
	elseif args:IsSpellID(97235) then
		warnFury:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(98535, 100206, 100207, 100208) and args:IsPlayer() and not recentlyJumped then
		specWarnLeapingFlames:Show()--You stood in the fire!
	elseif args:IsSpellID(98584, 100209, 100210, 100211) and args:IsPlayer() then
		if (args.amount or 1) >= 4 then
			specWarnOrb:Show(args.amount)--You stood in the fire!
		end
		timerOrb:Start()
	elseif args:IsSpellID(98450) and args:IsPlayer() then
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)--Find out what our specific seed timer is
		specWarnSearingSeed:Schedule(expires - GetTime() - 5)	-- Show "move away" warning 5secs before explode
		soundSeed:Schedule(expires - GetTime() - 5)
		timerSearingSeed:Start(expires-GetTime())
		if self.Options.RangeFrameSeeds then
			DBM.RangeCheck:Show(12)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(98450) and args:IsPlayer() then
		specWarnSearingSeed:Cancel()
		soundSeed:Cancel()
		timerSearingSeed:Cancel()
		if self.Options.RangeFrameSeeds then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98451) then	--98451 confirmed
		warnOrbs:Show()
		timerOrbActive:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98476) then	--98476 confirmed
		targetScansDone = 0
		self:TargetScanner(98476)
	end
end