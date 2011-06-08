local mod	= DBM:NewMod("Ragnaros-Cata", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetModelID(37875)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"UNIT_HEALTH"
)

local warnHandRagnaros		= mod:NewSpellAnnounce(99237, 3)
local warnWrathRagnaros		= mod:NewSpellAnnounce(98263, 3)
local warnBurningWound		= mod:NewStackAnnounce(99399, 3)
local warnMoltenSeed		= mod:NewSpellAnnounce(98520, 3)	-- spell ID ??
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3, 3)

local timerMagmaTrap		= mod:NewCDTimer(25, 98164)		-- might even be a "next" timer
local timerSulfurasSmash	= mod:NewCDTimer(40, 98710)		-- might even be a "next" timer
local timerHandRagnaros		= mod:NewCDTimer(35, 99237)		-- might even be a "next" timer
local timerWrathRagnaros	= mod:NewCDTimer(25, 98263)		-- 25-35sec variation?
local timerBurningWound		= mod:NewTargetTimer(20, 99399, nil, mod:IsTank() or mod:IsHealer())
local timerFlames			= mod:NewCDTimer(60, 99171)		-- Engulfing Flames spell ID?
local timerMoltenSeed 		= mod:NewBuffActiveTimer(10, 98520)	-- spell ID ??
local timerMoltenSeedCD		= mod:NewCDTimer(60, 98520)		-- spell ID ??  Might even be a "next" timer
local timerPhaseSons		= mod:NewTimer(45, "TimerPhaseSons")	-- lasts 45secs or till all sons are dead

local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, 5, nil, mod:IsTank())

mod:AddBoolOption("RangeFrame")

local sonsDied = 0
local phase = 1
local prewarnedPhase2 = false
local prewarnedPhase3 = false

local function showRangeFrame()
	if mod.Options.RangeFrame then
		if phase < 3 then
			DBM.RangeCheck:Show(6)
		else
			DBM.RangeCheck:Show(5)
		end
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFram then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
	timerMagmaTrap:Start(17-delay)
	timerSulfurasSmash:Start(32-delay)
	sonsDied = 0
	phase = 1
	prewarnedPhase2 = false
	prewarnedPhase3 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99399, 101238) then
		if args.amount or 0 % 2 == 0 then
			warnBurningWound:Show(args.destName, args,amount or 1)
		end
		if args.amount or 0 > 5 then
			specWarnBurningWound:Show()
		end
		timerBurningWound:Start(args.destName)
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98710, 100890) then
		timerSulfurasSmash:Start()
	elseif args:IsSpellID(98952) then
		timerMagmaTrap:Cancel()
		timerSulfurasSmash:Cancel()
		timerHandRagnaros:Cancel()
		timerWrathRagnaros:Cancel()
		timerPhaseSons:Start(53)	-- 45 + 8sec cast
		self:hideRangeFrame()
		sonsDied = 0
		phase = phase + 1
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98237, 100383) then
		warnHandRagnaros:Show()
		timerHandRagnaros:Start()
	elseif args:IsSpellID(98164) then
		timerMagmaTrap:Start()
	elseif args:IsSpellID(98263, 100113) then
		warnWrathRagnaros:Show()
		timerWrathRagnaros:Start()
	elseif args:IsSpellID(99171) then	-- correct SpellID ???
		timerFlames:Start()
	elseif args:IsSpellID(98520) then	-- correct spell ID ???
		warnMoltenSeed:Show()
		timerMoltenSeed:Start()
		timerMoltenSeedCD:Start()
		self:HideRangeFrame()			-- only have to spread just before the Molten Seeds
		self:Schedule(50, showRangeFrame)	-- show the range frame 10secs before next Molten Seeds
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then
		sonsDied = sonsDied + 1
		if sonsDied > 6 then		-- 6 on normal 10?  How many are there at which difficulties?
			timerPhaseSons:Cancel()
			if phase == 2 then
				timerSulfurasSmash:Start(25)
				timerFlames:Start(44)
				timerMoltenSeedCD:Start(16)
				self:Schedule(6, showRangeFrame)
			elseif phase == 3 then
				self:showRangeFrame()	-- Meteors needs spreading
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 52409 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 80 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 72 and h < 75 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		elseif h > 50 and prewarnedPhase3 then
			prewarnedPhase3 = false
		elseif h > 42 and h < 45 and not prewarnedPhase3 then
			prewarnedPhase3 = true
			warnPhase3Soon:Show()
		end
	end
end