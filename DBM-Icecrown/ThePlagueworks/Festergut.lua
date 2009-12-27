local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnInhaledBlight		= mod:NewAnnounce("InhaledBlight")
local warnGasSpore			= mod:NewTargetAnnounce(69279)
local warnVileGas			= mod:NewSpellAnnounce(73020)

local specwarnPungentBlight	= mod:NewSpecialWarningSpell(71219)
local specwarnGasSpore		= mod:NewSpecialWarningYou(69279)
local specWarnInhaled2		= mod:NewSpecialWarningStack(71912, false, 2)

local timerGasSpore			= mod:NewBuffActiveTimer(12, 69279)
local timerPungentBlight	= mod:NewNextTimer(136, 71219)--136 seconds'ish, subject to adjustments
local timerInhaledBlight	= mod:NewNextTimer(34, 71912)--34 seconds'ish (4 of these add up to Pungent Blight, 136 seconds), subject to adjustments
local timerVileGas			= mod:NewCDTimer(30, 71912)--30 cooldown?

local enrageTimer			= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnGasSpore", true)

local GasSporeTargets	= {}
local GasSporeIcon 	= 8

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(GasSporeTargets, "<, >"))
	table.wipe(GasSporeTargets)
	timerGasSpore:Start()
	GasSporeIcon = 8
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	timerPungentBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	table.wipe(GasSporeTargets)
	GasSporeIcon = 8
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specwarnPungentBlight:Show()
		timerPungentBlight:Start()
	end
end

local spam = 0
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(73019, 73020, 72272, 72273) and GetTime() - spam > 3 then	-- Vile Gas(Spellids drycoded, may not be correct)
		warnVileGas:Show()
		timerVileGas:Start()
		spam = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		GasSporeTargets[#GasSporeTargets + 1] = args.destName
		if args:IsPlayer() then
			specwarnGasSpore:Show()
		end
		if self.Options.SetIconOnGasSpore then
			self:SetIcon(args.destName, GasSporeIcon, 12)
			GasSporeIcon = GasSporeIcon - 1
		end
		self:Unschedule(warnGasSporeTargets)
		if #GasSporeTargets >= 2 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		warnInhaledBlight:Show(args.amount or 1)
		if (args.amount or 1) >= 2 then	--No idea if i should use 2 here or 3, depends how hard he hits with 2 stacks.
			specWarnInhaled2:Show(args.amount)
		end
		if (args.amount or 1) <= 2 then	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED