local mod	= DBM:NewMod("Rhyolith", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52558)
mod:SetModelID(38414)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_SUMMON",
	"UNIT_HEALTH"
)

--[[
	Boss seems to have UNIT_POWER based on the direction he walks into -> InfoFrame worthy?
	Phase 2 starts @ 25%
	Flame Stomp CD in P2 = ~13secs?   (30secs in P1)
--]]

local warnElementals		= mod:NewAnnounce("WarnElementals", 3)
local warnHeatedVolcano		= mod:NewSpellAnnounce(98493, 3)
local warnFlameStomp		= mod:NewSpellAnnounce(97282, 3, nil, mod:IsMelee())--According to journal only hits players within 20 yards of him, so melee by default?
local warnMoltenArmor		= mod:NewStackAnnounce(98255, 4, nil, mod:IsTank() or mod:IsHealer())	-- Would this be nice if we could show this in the infoFrame? (changed defaults to tanks/healers, if you aren't either it doesn't concern you unless you find shit to stand in)
local warnDrinkMagma		= mod:NewSpellAnnounce(98034, 2)	-- if you "kite" him to close to magma
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)

local timerElementals		= mod:NewTimer(22.5, "TimerElementals")
local timerHeatedVolcano	= mod:NewCDTimer(40, 98493)
local timerFlameStomp		= mod:NewNextTimer(30, 97282, nil, mod:IsMelee())
local timerMoltenSpew		= mod:NewNextTimer(6, 98034)	-- 6secs after Drinking Magma

local spamElementals = 0
local spamMoltenArmor = 0
local prewarnedPhase2 = false

function mod:OnCombatStart(delay)
	timerRockElementals:Start(21.5-delay)
	timerFireElementals:Start(45-delay)
	timerHeatedVolcano:Start(55-delay)
	timerFlameStomp:Start(28-delay)
	spamElementals = 0
	spamMoltenArmor = 0
	prewarnedPhase2 = false
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(98255, 101157, 101158, 101159) and self:GetCIDFromGUID(args.destGUID) == 52558 and args.amount > 10 and GetTime() - spamMoltenArmor > 5 then
		warnMoltenArmor:Show(args.destName, args.amount)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98034) then
		warnDrinkMagma:Show()
		timerMoltenSpew:Start()
	elseif args:IsSpellID(97282) then
		warnFlameStomp:Show()
		timerFlameStomp:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98493) then
		warnHeatedVolcano:Show()
		timerHeatedVolcano:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(98552, 98146) and GetTime() - spamElementals > 5 then
		warnElementals:Show()
		timerElementals:Start()
		spamElementals = GetTime()
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