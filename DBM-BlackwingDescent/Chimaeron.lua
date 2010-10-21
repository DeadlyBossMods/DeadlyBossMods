local mod	= DBM:NewMod("Chimaeron", "DBM-BlackwingDescent", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43296)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnCausticSlime		= mod:NewSpellAnnounce(82935, 3)
local warnBreak			= mod:NewAnnounce("WarnBreak", 3)
local warnDoubleAttack		= mod:NewSpellAnnounce(88826, 4)
local warnMassacre		= mod:NewSpellAnnounce(82848, 3)
local warnFeud			= mod:NewSpellAnnounce(88872, 4)
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)

--local timerCausticSlime	= mod:NewNextTimer( ?? , 82935)
local timerBreak		= mod:NewTargetTimer(60, 82881)
--local timerDoubleAttack	= mod:NewNextTimer( ?? , 82881)
local timerMassacre		= mod:NewCastTimer(4, 82848)
local timerMassacreNext		= mod:NewNextTimer(30, 82848)
local timerFeud			= mod:NewBuffActiveTimer(30, 88872)
local timerFeudNext		= mod:NewNextTimer(90, 88872)

local specWarnBreak		= mod:NewSpecialWarningStack(82881, nil, 2)

local prewarnedPhase2
function mod:OnCombatStart(delay)
	timerMassacreNext:Start(-delay)
	timerFeudNext:Start(-delay)
	prewarnedPhase2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82881) then
		warnBreak:Show(args.spellName, args.destName, args.amount or 1)
		timerBreak:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnBreak:Show(args.amount)
		end
	elseif args:IsSpellID(82881) then
		warnDoubleAttack:Show()
		-- timerDoubleAttack:Start()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82848) then
		warnMassacre:Show()
		timerMassacre:Start()
		timerMassacreNext:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82935, 88915, 88916, 88917) then
		warnCausticSlime:Show()
		--timerCausticSlime:Start()
	elseif args:IsSpellID(88872) then
		warnFeud:Show()
		timerFeud:Start()
		timerFeudNext:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 22 and h < 25 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end