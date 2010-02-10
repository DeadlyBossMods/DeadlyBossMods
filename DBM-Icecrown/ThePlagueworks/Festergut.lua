local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local isRanged = select(2, UnitClass("player")) == "MAGE"
              or select(2, UnitClass("player")) == "HUNTER"
              or select(2, UnitClass("player")) == "WARLOCK"

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
local timerPungentBlight	= mod:NewNextTimer(132, 71219)		-- 132 seconds'ish, subject to adjustments
local timerInhaledBlight	= mod:NewNextTimer(34, 71912)		-- 34 seconds'ish (4 of these add up to Pungent Blight)
local timerVileGas			= mod:NewBuffActiveTimer(6, 71219)
local timerGastricBloat		= mod:NewTargetTimer(100, 72551)	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(11, 72551) 		-- 10 to 14 seconds

local berserkTimer			= mod:NewBerserkTimer(300)

mod:AddBoolOption("RangeFrame", isRanged)
mod:AddBoolOption("SetIconOnGasSpore", true)

local gasSporeTargets	= {}
local vileGasTargets	= {}
local gasSporeIcon 	= 8

local mRange = { }
local mPoints = { 
	[0] = { 0.19828705489635, 0.653256416320 },
	[1] = { 0.21672140061855, 0.63018447160721 },
	[2] = { 0.21968087553978, 0.6705778837204 }
}
local noCheck = true

local function findMin(a)
	local index = 1
	local value = a[index]
	for i, val in ipairs(a) do
		if val < value then
			index = i
			value = val
		end
	end
	return value, index
end

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	timerGasSpore:Start()

	if not noCheck then
		for _, point in ipairs(mPoints) do 
			for i, v in ipairs(gasSporeTargets) do
				mRange[i] = DBM.RangeCheck:GetDistance(DBM:GetRaidUnitId(v), point[1], point[2])
			end
			local value, index = findMin(mRange)
			if gasSporeTargets[index] == UnitName("player") then	-- found my shortest way
				DBM.Arrow:ShowRunTo(point[1], point[2])
			end
			table.remove(gasSporeTargets, index)
			table.wipe(mRange)
		end
	end
	noCheck = true

	table.wipe(gasSporeTargets)
	gasSporeIcon = 8
end

local function warnVileGasTargets()
	warnVileGas:Show(table.concat(vileGasTargets, "<, >"))
	table.wipe(vileGasTargets)
	timerVileGas:Start()
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	timerPungentBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	table.wipe(gasSporeTargets)
	gasSporeIcon = 8
	noCheck = true
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specWarnPungentBlight:Show()
		timerPungentBlight:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		if args:IsPlayer() then
			noCheck = false	-- check for distance and show the arrow
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
		timerGastricBloatCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 9 then
			specWarnGastricBloat:Show(args.amount)
		end
	elseif args:IsSpellID(69240, 71218, 73020, 73019) then	-- Vile Gas(Heroic Spellids drycoded, may not be correct)
		vileGasTargets[#vileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
		end
		self:Unschedule(warnVileGasTargets)
		self:Schedule(0.8, warnVileGasTargets)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


