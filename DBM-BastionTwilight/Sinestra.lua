local mod	= DBM:NewMod("Sinestra", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45213)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnBreath		= mod:NewSpellAnnounce(92944, 3)
local warnSlicerSoon	= mod:NewAnnounce("WarnSlicerSoon", 2, 92954) -- yeah, this stuff can be very spammy, but in Sinestra, Twilight Slicer is very very very important, so on it by default.
local warnWrack			= mod:NewTargetAnnounce(92955, 3)
local warnDragon		= mod:NewAnnounce("WarnDragon", 3, 69002)
local warnEggWeaken		= mod:NewAnnounce("WarnEggWeaken", 4, 61357)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnIndomitable	= mod:NewSpellAnnounce(92946, 3)
local warnExtinction	= mod:NewSpellAnnounce(86227, 4)
local warnEggShield		= mod:NewSpellAnnounce(87654, 3)
local warnPhase3		= mod:NewPhaseAnnounce(3)

local specWarnSlicer	= mod:NewSpecialWarning("SpecWarnSlicer")
local specWarnDispel	= mod:NewSpecialWarning("SpecWarnDispel", mod:IsHealer()) -- this can be personal stuff, but Warck dispel also important In sinestra. adjust appropriately.
local specWarnBreath	= mod:NewSpecialWarningSpell(92944, false)
local specWarnEggShield	= mod:NewSpecialWarning("SpecWarnEggShield", mod:IsRanged())
local specWarnEggWeaken	= mod:NewSpecialWarning("SpecWarnEggWeaken", mod:IsRanged())

local timerBreathCD		= mod:NewCDTimer(24, 92944)
local timerSlicer		= mod:NewNextTimer(28, 92954)
local timerWrack		= mod:NewBuffActiveTimer(60, 92955)
local timerExtinction	= mod:NewCastTimer(16, 86227)
local timerEggWeakening	= mod:NewTimer(5, "TimerEggWeakening", 61357)
local timerEggWeaken	= mod:NewTimer(30, "TimerEggWeaken", 61357)
local timerDragon		= mod:NewTimer(50, "TimerDragon", 69002)

local eggDown = 0
local eggSpam = 0
local lastDispeled = 0
local newWrackTime = 0
local oldWrackTime = 0
local newWrackCount = 0
local oldWrackCount = 0
local eggRemoved = false
local warckWarned2 = false
local warckWarned4 = false

function mod:SlicerRepeat()
	specWarnSlicer:Show()
	timerSlicer:Start()
	if self.Options.WarnSlicerSoon then
		warnSlicerSoon:Schedule(23, 5)
		warnSlicerSoon:Schedule(24, 4)
		warnSlicerSoon:Schedule(25, 3)
		warnSlicerSoon:Schedule(26, 2)
		warnSlicerSoon:Schedule(27, 1)
	end
	self:ScheduleMethod(28, "SlicerRepeat")
end

function mod:OnCombatStart(delay)
	eggDown = 0
	eggSpam = 0
	lastDispeled = 0
	newWrackTime = 0
	oldWrackTime = 0
	newWrackCount = 0
	warckWarned2 = false
	warckWarned4 = false
	eggRemoved = false
	timerDragon:Start(16-delay)
	timerBreathCD:Start(23-delay)
	timerSlicer:Start(29-delay)
	if self.Options.WarnSlicerSoon then
		warnSlicerSoon:Schedule(24, 5)
		warnSlicerSoon:Schedule(25, 4)
		warnSlicerSoon:Schedule(26, 3)
		warnSlicerSoon:Schedule(27, 2)
		warnSlicerSoon:Schedule(28, 1)
	end
	self:ScheduleMethod(29-delay, "SlicerRepeat")
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(92944) then
		warnBreath:Show()
		specWarnBreath:Show()
		timerBreathCD:Start()
	elseif args:IsSpellID(86227) then
		warnExtinction:Show()
		timerExtinction:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(92946) then
		warnIndomitable:Show()
	elseif args:IsSpellID(92955) then
		warnWrack:Show(args.destName)
		timerWrack:Start()
		if oldWrackTime == 0 then
			oldWrackTime = GetTime()
		else
			oldWrackTime = newWrackTime
		end
		newWrackTime = GetTime()
		newWrackCount = 1
		lastDispeled = 0
		warckWarned4 = false
		warckWarned2 = false
--		print ("new warck detected") -- debug message
		specWarnDispel:Schedule(18, 18)
		self:Schedule(60, function()
			specWarnDispel:Cancel()
		end)
	elseif args:IsSpellID(92956) and (GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 12) then -- jumped warcks
		newWrackCount = newWrackCount + 1
--		print ("applied", newWrackCount, newWrackTime, floor(lastDispeled - newWrackTime)) -- debug message
		if newWrackCount > 3 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not warckWarned4 then
			specWarnDispel:Cancel()
			specWarnDispel:Schedule(12, 12)
			warckWarned4 = true
--			print ("success. 12 sec warn enabled") -- debug message
		elseif newWrackCount > 1 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not warckWarned2 then
			specWarnDispel:Cancel()
			specWarnDispel:Schedule(17, 17)
			warckWarned2 = true
--			print ("success. 17 sec warn enabled") -- debug message
		end
	elseif args:IsSpellID(87299) then
		eggDown = 0
		warnPhase2:Show()
		timerBreathCD:Cancel()
		timerSlicer:Cancel()
		if self.Options.WarnSlicerSoon then
			warnSlicerSoon:Cancel()
		end
		self:UnscheduleMethod("SlicerRepeat")
	elseif args:IsSpellID(87654) and GetTime() - eggSpam >= 3 then
		eggSpam = GetTime()
		warnEggShield:Show()
		timerDragon:Cancel()
		if eggRemoved then
			specWarnEggShield:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(87654) and GetTime() - eggSpam >= 3 then
		eggSpam = GetTime()
		warnEggWeaken:Show()
		timerEggWeaken:Show()
		specWarnEggWeaken:Show()
		eggRemoved = true
	elseif args:IsSpellID(92955, 92956) then
--		print ("removed", newWrackCount, floor(lastDispeled - newWrackTime)) -- debug message
		if GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 12 then
			newWrackCount = newWrackCount - 1
			if GetTime() - lastDispeled > 5 then
				lastDispeled = GetTime()
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDragon or msg:find(L.YellDragon) then
		warnDragon:Show()
		timerDragon:Start()
	elseif msg == L.YellEgg or msg:find(L.YellEgg) then
		timerEggWeakening:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 46842 then
		eggDown = eggDown + 1
		if eggDown >= 2 then
			warnPhase3:Show()
			timerBreathCD:Start()
			timerSlicer:Start(29)
			timerDragon:Start()
			if self.Options.WarnSlicerSoon then
				warnSlicerSoon:Schedule(24, 5)
				warnSlicerSoon:Schedule(25, 4)
				warnSlicerSoon:Schedule(26, 3)
				warnSlicerSoon:Schedule(27, 2)
				warnSlicerSoon:Schedule(28, 1)
			end
			self:ScheduleMethod(29, "SlicerRepeat")
		end
	end
end