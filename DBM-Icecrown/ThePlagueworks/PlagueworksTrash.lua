local mod	= DBM:NewMod("PlagueworksTrash", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(37025, 37217)
--mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_CAST_START",
	"UNIT_DIED"
)

local warnZombies		= mod:NewSpellAnnounce(71159)
local warnMortalWound	= mod:NewAnnounce("warnMortalWound", 2, nil, false)
local warnDecimateSoon	= mod:NewSoonAnnounce(71123)

local specWarnDecimate		= mod:NewSpecialWarningSpell(71123)
local specWarnMortalWound	= mod:NewSpecialWarningStack(71127, nil, 5)

local timerZombies		= mod:NewNextTimer(20, 71159)
local timerMortalWound	= mod:NewTargetTimer(15, 71127)
local timerDecimate		= mod:NewNextTimer(33, 71123)

mod:RemoveOption("HealthFrame")

local spamZombies = 0

--[[function mod:OnCombatStart(delay)		-- guessed timers
	warnDecimateSoon:Schedule(28-delay)
	timerDecimate:Start(-delay)
	timerZombies:Start(-delay)
end--]]

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71127) then
		warnMortalWound:Show(args.spellName, args.destName, args.amount or 1)
		timerMortalWound:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 5 then
			specWarnMortalWound:Show(args.amount)
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

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71123) then
		specWarnDecimate:Show()
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37025 then
		timerShadowstepCD:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 37217 then
		timerZombies:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	end
end