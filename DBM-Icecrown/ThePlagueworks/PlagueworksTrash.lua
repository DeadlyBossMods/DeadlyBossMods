local mod	= DBM:NewMod("PlagueworksTrash", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
--mod:SetCreatureID(37025, 37217)
--mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS"
)

local warnZombies	= mod:NewSpellAnnounce(71159)
local warnMortalWound	= mod:NewTargetAnnounce(71127)
local warnDecimateSoon	= mod:NewSoonAnnounce(71123)

local specWarnMortalWound	= mod:NewSpecialWarningStack(71127, nil, 3)

local timerZombies	= mod:NewNextTimer(20, 71159)
local timerMortalWound	= mod:NewTargetTimer(15, 71127)
local timerDecimate	= mod:NewNextTimer(33, 71123)

mod:RemoveOption("HealthFrame")

local spamZombies

function mod:OnCombatStart(delay)		-- guessed timers
	warnDecimateSoon:Schedule(28-delay)
	timerDecimate:Start(-delay)
	timerZombies:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71127) then
		warnMortalWound:Show(args.destName)
		timerMortalWound:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 3 then
			specWarnMortalWound:Show()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71159) and GetTime() - spamZombies > 5 then
		warnZombies:Show()
		timerZombies:Start()
		spamZombies = GetTime()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(71123) then
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	end
end