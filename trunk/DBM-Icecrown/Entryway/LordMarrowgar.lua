local mod	= DBM:NewMod("LordMarrowgar", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36612)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local preWarnWhirlwind   	= mod:NewSoonAnnounce(69076, 2)
local warnBoneSpike			= mod:NewCastAnnounce(69057)
local warnImpale			= mod:NewAnnounce("WarnImpale")

local specWarnColdflame		= mod:NewSpecialWarning("SpecWarnColdflame")
local specWarnWhirlwind		= mod:NewSpecialWarning("SpecWarnWhirlwind")

mod:AddBoolOption("PlaySoundOnWhirlwind", true, "announce")

local timerBoneSpike		= mod:NewCDTimer(18, 69057) --Roughly 18-23 second delay between casts, using an 18 sec cooldown timer.
local timerWhirlwindCD		= mod:NewCDTimer(60, 69076)--Changed to a CD timer, it's always at least a minute but new logs indicate it's not dead on, i'm seing 61-65sec variation
local timerWhirlwind		= mod:NewBuffActiveTimer(25, 69076)--Seems to be 28 second duration, down from 30 in last test. Will watch for more PTR adjustments.

function mod:OnCombatStart(delay)
    preWarnWhirlwind:Schedule(40-delay)
	timerWhirlwindCD:Start(45-delay)
	timerBoneSpike:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69057, 70826) then					-- Bone Spike Graveyard
		warnBoneSpike:Show(args.spellName)
		timerBoneSpike:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69076) then						-- Whirlwind
		specWarnWhirlwind:Show()
		if self.Options.PlaySoundOnWhirlwind then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

do 
	local lastColdflame = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69146, 70823, 70824, 70825) and args:IsPlayer() and time() - lastColdflame > 2 then		-- Coldflame, MOVE!
			specWarnColdflame:Show()
			lastColdflame = time()
		end
	end
end

local impaleTargets = {}

function mod:warnImpale() 
	warnImpale:Show(table.concat(impaleTargets, "<, >")) 
	table.wipe(impaleTargets) 
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669) then							-- Impale (This function is iffy and I'm not sure it'll work, but it is the earliest combatlog entry to detect off of.)
		self:UnscheduleMethod("warnImpale")
		impaleTargets[#impaleTargets + 1] = args.sourceName
		mod:ScheduleMethod(0.2, "warnImpale")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69076, 70834) then						-- Whirlwind Begins
		timerWhirlwind:Show(args.destName)
--[[	elseif args:IsSpellID(69065) then					-- Impale (this function is a backup if summon doesn't work. This happens at least 1-2 seconds after the summon event and after person has already taken damage from it.
		self:UnscheduleMethod("warnImpale")
		impaleTargets[#impaleTargets + 1] = args.destName
		mod:ScheduleMethod(0.2, "warnImpale")]]--
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69076) then						-- Whirlwind Ends
		timerWhirlwindCD:Start()
        preWarnWhirlwind:Schedule(55)
	end
end
