local mod	= DBM:NewMod("d504", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1030)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 142884 119843",
	"SPELL_CAST_SUCCESS 120824",
	"SPELL_AURA_APPLIED 120817 127823 120929 120215",
	"SPELL_AURA_REMOVED 120817 127823",
	"UNIT_DIED"
)

--Todo, Gather Heroic data, actual Cds when the bosses last longer than 10 seconds.
--Jin Ironfist
local warnRelentless		= mod:NewTargetAnnounce(120817, 3)--10 second target fixate
local warnEnrage			= mod:NewTargetAnnounce(127823, 3)--10 second Enrage
--Maragor
local warnFear				= mod:NewCastAnnounce(142884, 3)
local warnGuardianStrike	= mod:NewSpellAnnounce(119843, 3)
--Abomination of Anger
local warnBreathofHate		= mod:NewSpellAnnounce(120929, 3)
local warnCloudofAnger		= mod:NewSpellAnnounce(120824, 3, 120743)--142432 is heroic ID in 5.3 only, need to figure out damage type event, SPELL_DAMAGE or SPELL_PERIODIC_DAMAGE and add move warning
local warnDarkforce			= mod:NewSpellAnnounce(120215, 4)--normal 5, heroic 3.5 cast

--Jin Ironfist
--local specWarnRelentless	= mod:NewSpecialWarningRun(120817)--Maybe on heroic this actually deadly and you must run? if so, uncomment
local specWarnEnrage		= mod:NewSpecialWarningDispel(127823, mod:CanRemoveEnrage())
--Maragor
local specWarnFear			= mod:NewSpecialWarningInterrupt(142884)
local specWarnGuardianStrike= mod:NewSpecialWarningRun(119843, mod:IsMelee())
--Abomination of Anger
local specWarnDarkforce		= mod:NewSpecialWarningRun(120215)

--Jin Ironfist
local timerRelentless		= mod:NewTargetTimer(10, 120817)
local timerEnrage			= mod:NewBuffActiveTimer(10, 127823)
--local timerRelentlessCD		= mod:NewCDTimer(10, 120817)
--Abomination of Anger
local timerBreathCD			= mod:NewCDTimer(21.5, 120929)--Limited sample size, may be shorter
local timerCloudofAngerCD	= mod:NewCDTimer(17, 120824)--Limited sample size, may be shorter
local timerDarkforce		= mod:NewCastTimer(5, 120215)
local timerDarkforceCD		= mod:NewCDTimer(32, 120215)

local soundDarkforce		= mod:NewSound(120215)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args.spellId == 142884 then
		warnFear:Show()
		specWarnFear:Show(args.sourceName)
	elseif args.spellId == 119843 then
		warnGuardianStrike:Show()
		specWarnGuardianStrike:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 120824 then
		warnCloudofAnger:Show()
		timerCloudofAngerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 120817 then
		warnRelentless:Show(args.destName)
		timerRelentless:Start(args.destName)
	elseif args.spellId == 127823 then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		timerEnrage:Start()
	elseif args.spellId == 120929 then
		warnBreathofHate:Show()
		timerBreathCD:Start()
	elseif args.spellId == 120215 then
		warnDarkforce:Show()
		specWarnDarkforce:Show()
		soundDarkforce:Play()
		timerDarkforce:Start(self:IsDifficulty("heroic5") and 3.5 or 5)
		timerDarkforceCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 120817 then
		timerRelentless:Cancel(args.destName)
	elseif args.spellId == 127823 then
		timerEnrage:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61814 then--Jin Ironfist
		--No CDs yet, but will have some later, probably heroic
	elseif cid == 71492 then--Maragor
		--No CDs yet, but will have some later, probably heroic
	elseif cid == 61707 then--Abomination of Anger
		timerBreathCD:Cancel()
		timerCloudofAngerCD:Cancel()
		timerDarkforceCD:Start()
	end
end
