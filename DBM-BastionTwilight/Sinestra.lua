local mod	= DBM:NewMod("Sinestra", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4829 $"):sub(12, -3))
mod:SetCreatureID(45213)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DISPEL",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnBreath		= mod:NewSpellAnnounce(92944, 3)
local warnSlicerSoon	= mod:NewAnnounce("WarnSlicerSoon", 2, 92954) -- yeah, this stuff can be very spammy, but in Sinestra, Twilight Slicer is very very very important, so on it by default.
local warnWrack			= mod:NewTargetAnnounce(92955, 3)
local warnExtinction	= mod:NewSpellAnnounce(86227, 4)
local warnIndomitable	= mod:NewSpellAnnounce(92946, 3)
local warnEggWeaken		= mod:NewAnnounce("WarnEggWeaken", 4, 61357)
local warnDragon		= mod:NewAnnounce("WarnDragon", 3, 69002)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)

local specWarnSlicer	= mod:NewSpecialWarning("SpecWarnSlicer")
local specWarnDispel	= mod:NewSpecialWarning("SpecWarnDispel", mod:IsHealer()) -- this can be personal stuff, but Warck dispel also important In sinestra. adjust appropriately.
local specWarnBreath	= mod:NewSpecialWarningSpell(92944, false)

local timerBreathCD		= mod:NewCDTimer(24, 92944)
local timerSlicer		= mod:NewNextTimer(28, 92954)
local timerWrack		= mod:NewBuffActiveTimer(60, 92955)
local timerExtinction	= mod:NewCastTimer(15, 86227)
local timerEggWeakening	= mod:NewTimer(5, "TimerEggWeakening", 61357)
local timerDragon		= mod:NewTimer(50, "TimerDragon", 69002)

local eggDown = 0
local eggSpam = 0
local wrackTargets = {}
local wrackCount = 0
local lastDispeled = 0

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
	table.wipe(wrackTargets)
	wrackCount = 0
	lastDispeled = 0
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
		table.wipe(wrackTargets)
		wrackCount = 1
		wrackTargets[args.destName] = true
		specWarnDispel:Schedule(18, 18)
		self:Schedule(60, function()
			specWarnDispel:Cancel()
		end)
	elseif args:IsSpellID(92956) then -- jumped warcks
		if not wrackTargets[args.destName] then
			wrackTargets[args.destName] = true
			wrackCount = WrackCount + 1
		end
		if wrackCount > 3 and GetTime() - lastDispeled < 5 then
			specWarnDispel:Schedule(12, 12)
		elseif wrackCount > 1 and GetTime() - lastDispeled < 5 then
			specWarnDispel:Schedule(14, 14)
		end
	elseif args:IsSpellID(87299) then
		eggDown = 0
		warnPhase2:Show()
		timerDragon:Cancel()
		timerBreathCD:Cancel()
		timerSlicer:Cancel()
		if self.Options.WarnSlicerSoon then
			warnSlicerSoon:Cancel()
		end
		self:UnscheduleMethod("SlicerRepeat")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(87654) and GetTime() - eggSpam >= 3 then
		eggSpam = GetTime()
		warnEggWeaken:Show()
	elseif args:IsSpellID(92955, 92956) then
		if wrackTargets[args.destName] then
			wrackTargets[args.destName] = nil
			wrackCount = WrackCount - 1
		end
	end
end

function mod:SPELL_DISPEL(args)
	if args:IsSpellID(92955, 92956) and GetTime() - lastDispeled > 5 then
		lastDispeled = GetTime()
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