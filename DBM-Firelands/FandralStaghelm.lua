--local mod	= DBM:NewMod(197, "DBM-Firelands", nil, 78)
local mod	= DBM:NewMod("FandralStaghelm", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52571)
mod:SetModelID(37953)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnAdrenaline		= mod:NewStackAnnounce(97238, 3)
local warnFury			= mod:NewStackAnnounce(97235, 3)
local warnOrbs			= mod:NewCastAnnounce(98451, 3, nil, mod:IsTank())

local timerSearingSeed		= mod:NewTargetTimer(60, 98450)
local timerLeapingFlames	= mod:NewCDTimer(4, 100208)
local timerFlameScythe		= mod:NewCDTimer(4, 98474)

local specWarnSearingSeed	= mod:NewSpecialWarningMove(98450)

local abilitySpam	-- Cat ability happens twice in a row (2 combat log events), but using it for both just in case :)
local abilityCount = 0
local abilityTimers = {
	[0] = 17,
	[1] = 13,
	[2] = 10.5,
	[3] = 8.5,
	[4] = 7,
	[5] = 7,
	[6] = 6,
	[7] = 6,
	[8] = 5,
	[9] = 5,
	[10]= 5
}

function mod:OnCombatStart(delay)
	abilityCount = 0
	abilitySpam = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(98374) then		-- Cat Form (99574? maybe the form id for druids with is heroic staff)
		transforms = transforms + 1
		abilityCount = (1 and mod:IsDifficulty("heroic10", "heroic25")) or 0
		timerFlameScythe:Cancel()
		timerLeapingFlames:Start(abilityTimers[0])
	elseif args:IsSpellID(98379) then	-- Scorpion Form
		transforms = transforms + 1
		abilityCount = (1 and mod:IsDifficulty("heroic10", "heroic25")) or 0
		timerLeapingFlames:Cancel()
		timerFlameScythe:Start(abilityTimers[0])
	elseif args:IsSpellID(97238) then
		warnAdrenaline:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(97235) then
		warnFury:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(98450) and args:IsPlayer() then
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)	-- does duration return actual duration or the total duration?
		specWarnSearingSeed:Schedule(expires - GetTime() - 5)	-- Show "move away" warning 5secs before explode?
		timerSearingSeed:Start(expires-GetTime())
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CASST_START(args)
	if args:IsSpellID(98451) then	--98451 confirmed
		warnOrbs:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98476) and GetTime() - abilitySpam > 3 then	--98476 confirmed
		abilityCount = abilityCount + 1
		abilitySpam = GetTime()
		local t = abilityTimers[abilityCount] or 4
		timerLeapingFlames:Start(t)
	elseif args:IsSpellID(98474, 100212, 100213, 100214) and GetTime() - abilitySpam > 3 then	--98474, 100213 confirmed
		abilityCount = abilityCount + 1
		abilitySpam = GetTime()
		local t = abilityTimers[abilityCount] or 4
		timerFlameScythe:Start(t)
	end
end