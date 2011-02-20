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
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnBreath		= mod:NewSpellAnnounce(92944, 3)
local warnSlicer		= mod:NewSpellAnnounce(92954, 4)
local warnWrack			= mod:NewTargetAnnounce(92955, 3)
local warnExtinction	= mod:NewSpellAnnounce(86227, 4)
local warnIndomitable	= mod:NewSpellAnnounce(92946, 3)
local warnEggWeaken		= mod:NewAnnounce("WarnEggWeaken", 4, 61357)
local warnDragon		= mod:NewAnnounce("WarnDragon", 3, 69002)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)

local timerBreathCD		= mod:NewCDTimer(24, 92944)
local timerSlicer		= mod:NewNextTimer(28, 92954)
local timerWrack		= mod:NewBuffActiveTimer(60, 92955)
local timerExtinction	= mod:NewCastTimer(15, 86227)
local timerEggWeakening	= mod:NewTimer(5, "TimerEggWeakening", 61357)
local timerDragon		= mod:NewTimer(50, "TimerDragon", 69002)

local eggDown = 0
local eggSpam = 0

function mod:SlicerRepeat()
	warnSlicer:Show()
	timerSlicer:Start()
	self:ScheduleMethod(28, "SlicerRepeat")
end

function mod:OnCombatStart(delay)
	eggDown = 0
	eggSpam = 0
	timerDragon:Start(16-delay)
	timerBreathCD:Start(21-delay)
	timerSlicer:Start(30-delay)
	self:ScheduleMethod(30-delay, "SlicerRepeat")
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
	elseif args:IsSpellID(87299) then
		eggDown = 0
		warnPhase2:Show()
		timerDragon:Cancel()
		timerBreathCD:Cancel()
		timerSlicer:Cancel()
		self:UnscheduleMethod("SlicerRepeat")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(87654) and GetTime() - eggSpam >= 3 then
		eggSpam = GetTime()
		warnEggWeaken:Show()
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
			timerSlicer:Start()
			timerDragon:Start()
			self:ScheduleMethod(28, "SlicerRepeat")
		end
	end
end