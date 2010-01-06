local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnInhaledBlight		= mod:NewAnnounce("InhaledBlight")
local warnGastricBloat		= mod:NewAnnounce("WarnGastricBloat", 3)
local warnGasSpore			= mod:NewTargetAnnounce(69279)
local warnVileGas			= mod:NewTargetAnnounce(73020)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(71219)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279)
local specWarnVileGas		= mod:NewSpecialWarningYou(71218)
local specWarnGastricBloat	= mod:NewSpecialWarningStack(72551, nil, 9)
local specWarnInhaled3		= mod:NewSpecialWarningStack(71912, false, 3)

local timerGasSpore			= mod:NewBuffActiveTimer(12, 69279)
local timerPungentBlight	= mod:NewNextTimer(132, 71219)--132 seconds'ish, subject to adjustments
local timerInhaledBlight	= mod:NewNextTimer(34, 71912)--34 seconds'ish (4 of these add up to Pungent Blight)
local timerVileGas			= mod:NewBuffActiveTimer(6, 71219)
local timerGastricBloat		= mod:NewTargetTimer(100, 72551)

local enrageTimer			= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnGasSpore", true)

local gasSporeTargets	= {}
local vileGasTargets	= {}
local gasSporeIcon 	= 8

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	table.wipe(gasSporeTargets)
	timerGasSpore:Start()
	gasSporeIcon = 8
end

local function warnVileGasTargets()
	warnVileGas:Show(table.concat(vileGasTargets, "<, >"))
	table.wipe(vileGasTargets)
	timerVileGas:Start()
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	timerPungentBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	table.wipe(gasSporeTargets)
	gasSporeIcon = 8
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specWarnPungentBlight:Show()
		timerPungentBlight:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69240, 71218, 73020, 73019) then	-- Vile Gas(Heroic Spellids drycoded, may not be correct)
		vileGasTargets[#vileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
		end
		self:Unschedule(warnGasSporeTargets)
		if #vileGasTargets >= 3 then
			warnVileGasTargets()
		else
			self:Schedule(0.3, warnVileGasTargets)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnGasSpore:Show()
		end
		if self.Options.SetIconOnGasSpore then
			self:SetIcon(args.destName, gasSporeIcon, 12)
			gasSporeIcon = gasSporeIcon - 1
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 3 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		warnInhaledBlight:Show(args.amount or 1)
		if (args.amount or 1) >= 3 then
			specWarnInhaled3:Show(args.amount)
		end
		if (args.amount or 1) <= 2 then	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	elseif args:IsSpellID(72219, 72551, 72552, 72553) then	-- Gastric Bloat
		warnGastricBloat:Show(args.spellName, args.destName, args.amount or 1)
		timerGastricBloat:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 9 then
			specWarnGastricBloat:Show(args.amount)
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED