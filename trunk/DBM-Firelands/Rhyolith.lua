local mod	= DBM:NewMod(193, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52558)--or does 53772 die instead?didn't actually varify this fires right unit_died event yet so we'll see tonight
mod:SetModelID(38414)
mod:SetZone()
mod:SetUsedIcons()
mod:SetModelSound("Sound\\Creature\\RHYOLITH\\VO_FL_RHYOLITH_AGGRO.wav", "Sound\\Creature\\RHYOLITH\\VO_FL_RHYOLITH_KILL_02.wav")
--Long: Blah blah blah Nuisances, Nuisances :)
--Short: So Soft

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_HEALTH"
)

local warnHeatedVolcano		= mod:NewSpellAnnounce(98493, 3)
local warnFlameStomp		= mod:NewSpellAnnounce(97282, 3, nil, mod:IsMelee())--According to journal only hits players within 20 yards of him, so melee by default?
local warnMoltenArmor		= mod:NewStackAnnounce(98255, 4, nil, mod:IsTank() or mod:IsHealer())	-- Would this be nice if we could show this in the infoFrame? (changed defaults to tanks/healers, if you aren't either it doesn't concern you unless you find shit to stand in)
local warnDrinkMagma		= mod:NewSpellAnnounce(98034, 4)	-- if you "kite" him to close to magma
local warnFragments			= mod:NewSpellAnnounce("ej2531", 2, 98136)
local warnShard				= mod:NewCountAnnounce("ej2532", 3, 98552)
local warnMagmaFlow			= mod:NewSpellAnnounce(97225, 4)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)

local specWarnMagmaFlow		= mod:NewSpecialWarningSpell(97225, nil, nil, nil, true)
local specWarnFlameStomp	= mod:NewSpecialWarningSpell(97282, false)

local timerFragmentCD		= mod:NewNextTimer(22.5, "ej2531", nil, nil, nil, 98136)
local timerSparkCD			= mod:NewNextCountTimer(22.5, "ej2532", nil, nil, nil, 98552)
local timerHeatedVolcano	= mod:NewNextTimer(25.5, 98493)
local timerFlameStomp		= mod:NewNextTimer(30.5, 97282)
local timerSuperheated		= mod:NewNextTimer(10, 101305)		--Add the 10 second party in later at some point if i remember to actually log it better
local timerMoltenSpew		= mod:NewNextTimer(6, 98034)		--6secs after Drinking Magma
local timerMagmaFlowActive	= mod:NewBuffActiveTimer(10, 97225)	--10 second buff volcano has, after which the magma line explodes.

local countdownStomp		= mod:NewCountdown(30.5, 97282, false)

local spamAdds = 0
local phase2Started = false
local sparkCount = 0
local fragmentCount = 0
local prewarnedPhase2 = false

function mod:OnCombatStart(delay)
	timerFragmentCD:Start(-delay)
	timerHeatedVolcano:Start(30-delay)
	timerFlameStomp:Start(16-delay)--Actually found an old log, maybe this is right.
	countdownStomp:Start(16-delay)--^^
	if self:IsDifficulty("heroic10", "heroic25") then
		timerSuperheated:Start(300-delay)--5 min on heroic
	else
		timerSuperheated:Start(360-delay)--6 min on normal
	end
	spamAdds = 0
	phase2Started = false
	sparkCount = 0
	fragmentCount = 1--Fight starts out 1 cycle in so only 1 more spawns before pattern reset.
	prewarnedPhase2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99846) and not phase2Started then
		phase2Started = true
		warnPhase2:Show()
		if timerFlameStomp:GetTime() > 0 then--This only happens if it was still on CD going into phase
			countdownStomp:Cancel()
			timerFlameStomp:Cancel()
			countdownStomp:Start(7)
			timerFlameStomp:Start(7)
		else--Else, he uses it right away
			timerFlameStomp:Start(1)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(98255, 101157, 101158, 101159) and self:GetCIDFromGUID(args.destGUID) == 52558 and args.amount > 10 and self:AntiSpam(5, 1) then
		warnMoltenArmor:Show(args.destName, args.amount)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98034) then
		warnDrinkMagma:Show()
		timerMoltenSpew:Start()
	elseif args:IsSpellID(97282, 100411, 100968, 100969) then
		warnFlameStomp:Show()
		specWarnFlameStomp:Show()
		if not phase2Started then
			timerFlameStomp:Start()
			countdownStomp:Start(30.5)
		else--13sec cd in phase 2
			timerFlameStomp:Start(13)
			countdownStomp:Start(13)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98493) then
		warnHeatedVolcano:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerHeatedVolcano:Start()
		else
			timerHeatedVolcano:Start(40)--40 seconds on normal post Aug 16th 2011 hotfix.
		end
	elseif args:IsSpellID(97225) then
		warnMagmaFlow:Show()
		specWarnMagmaFlow:Show()
		timerMagmaFlowActive:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(98136, 100392) and self:AntiSpam(5, 2) then
		fragmentCount = fragmentCount + 1
		warnFragments:Show()
		if fragmentCount < 2 then
			timerFragmentCD:Start()
		else--Spark is next start other CD bar and reset count.
			fragmentCount = 0
			timerSparkCD:Start(22.5, sparkCount+1)
		end
	elseif args:IsSpellID(98552) then
		sparkCount = sparkCount + 1
		warnShard:Show(sparkCount)
		timerFragmentCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 52558 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 35 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 28 and h < 22 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end