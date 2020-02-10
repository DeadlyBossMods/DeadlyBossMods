local mod	= DBM:NewMod(2154, "DBM-Party-BfA", 4, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134063, 134058)
mod:SetEncounterID(2131)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267830",
	"SPELL_AURA_REMOVED 267830",
	"SPELL_CAST_START 267818 267905 267891 267899",
	"SPELL_CAST_SUCCESS 267901",
	"UNIT_DIED"
)

local warnBlessingofTempest			= mod:NewTargetNoFilterAnnounce(267830, 4)

local specWarnReinforcingWardT		= mod:NewSpecialWarningMove(267905, nil, nil, nil, 1, 2)
local specWarnReinforcingWard		= mod:NewSpecialWarningMoveTo(267905, nil, nil, nil, 1, 2)
local specWarnSwiftnessWardT		= mod:NewSpecialWarningMove(267891, nil, nil, nil, 1, 2)
local specWarnSwiftnessWard			= mod:NewSpecialWarningMoveTo(267891, nil, nil, nil, 1, 2)
local specWarnSlicingBlast			= mod:NewSpecialWarningInterrupt(267818, "HasInterrupt", nil, 4, 1, 2)
local specWarnHinderingCleave		= mod:NewSpecialWarningDefensive(267899, "Tank", nil, nil, 1, 2)
local specWarnBlessingofIronsides	= mod:NewSpecialWarningRun(267901, "Tank", nil, 2, 4, 2)

local timerReinforcingWardCD		= mod:NewCDTimer(30.2, 267905, nil, nil, nil, 5, nil, DBM_CORE_IMPORTANT_ICON)
local timerSwiftnessWardCD			= mod:NewCDTimer(36.4, 267891, nil, nil, nil, 5)--More data needed
local timerHinderingCleaveCD		= mod:NewCDTimer(18.2, 267899, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBlessingofIronsidesCD	= mod:NewCDTimer(32.4, 267901, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

mod.vb.bossTempest = false

function mod:OnCombatStart(delay)
	self.vb.bossTempest = false
	if not self:IsNormal() then
		timerBlessingofIronsidesCD:Start(5-delay)
	end
	timerHinderingCleaveCD:Start(5.8-delay)
	timerSwiftnessWardCD:Start(16.1-delay)
	timerReinforcingWardCD:Start(30.1-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267830 then
		self.vb.bossTempest = true
		warnBlessingofTempest:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 267830 then
		self.vb.bossTempest = false
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267905 then
		timerReinforcingWardCD:Start()
		if self:IsTank() then
			specWarnReinforcingWardT:Show()
			specWarnReinforcingWardT:Play("bossout")
		else
			specWarnReinforcingWard:Show(args.spellName)
			specWarnReinforcingWard:Play("findshield")
		end
	elseif spellId == 267891 then
		timerSwiftnessWardCD:Start()
		if self:IsTank() then
			specWarnSwiftnessWardT:Show()
			specWarnSwiftnessWardT:Play("bossout")
		else
			specWarnSwiftnessWard:Show(args.spellName)
			specWarnSwiftnessWard:Play("findshield")
		end
	elseif spellId == 267818 and not self.vb.bossTempest and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSlicingBlast:Show(args.sourceName)
		specWarnSlicingBlast:Play("kickcast")
	elseif spellId == 267899 then
		specWarnHinderingCleave:Show()
		specWarnHinderingCleave:Play("defensive")
		timerHinderingCleaveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267901 then
		specWarnBlessingofIronsides:Show()
		specWarnBlessingofIronsides:Play("justrun")
		timerBlessingofIronsidesCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 134063 then
		timerReinforcingWardCD:Stop()
		timerHinderingCleaveCD:Stop()
	elseif cid == 134058 then
		timerSwiftnessWardCD:Stop()
	end
end
