local mod	= DBM:NewMod("FandralStaghelm", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52571)
mod:SetModelID(37953) -- Temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS"
)

local warnAdrenaline		= mod:NewStackAnnounce(97238, 3)
local warnFury			= mod:NewStackAnnounce(97235, 3)

local timerLeapingFlames	= mod:NewCDTimer(17, 100208)
local timerFlameScythe		= mod:NewCDTimer(17, 98474)

local specWarnSearingSeed	= mod:NewSpecialWarningMove(98450)

-- Tried to find a start timer and make it 20% 'faster' each time, but from PTR logs it would mean to be correct to have a start timer of 15.66 which is 1sec off for the first ability :s
local abilitySpam	-- Cat ability happens twice in a row (2 combat log events), but using it for both just in case :)
local abilityCount = 0
local abilityTimers = {
	[0] = 16.708,
	[1] = 12.740,
	[2] = 10.025,
	[3] = 8.381,
	[4] = 7.214	-- should only allow him to cast more (need logs for more/better timing or different timing)
}

function mod:OnCombatStart(delay)
	abilityCount = 0
	abilitySpam = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(98374) then		-- Cat Form
		transforms = transforms + 1
		abilityCount = 0
		timerFlameScythe:Cancel()
		timerLeapingFlames:Start(abilityTimers[0])
	elseif args:IsSpellID(98379) then	-- Scorpion Form
		transforms = transforms + 1
		abilityCount = 0
		timerLeapingFlames:Cancel()
		timerFlameScythe:Start(abilityTimers[0])
	elseif args:IsSpellID(97238) then
		warnAdrenaline:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(97235) then
		warnFury:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(98450) and args:IsPlayer() then
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)	-- does duration return actual duration or the total duration?
		specWarnSearingSeed:Schedule(expires - GetTime() - 5)	-- Show "move away" warning 5secs before explode?
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98476) and GetTime() - abilitySpam > 3 then
		abilityCount = abilityCount + 1
		abilitySpam = GetTime()
		local t = abilityTimers[abilityCount] or 0
		timerLeapingFlames:Start(t)
	elseif args:IsSpellID(100212) and GetTime() - abilitySpam > 3 then
		abilityCount = abilityCount + 1
		abilitySpam = GetTime()
		local t = abilityTimers[abilityCount] or 0
		timerFlameScythe:Start(t)
	end
end