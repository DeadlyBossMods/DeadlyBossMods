local mod	= DBM:NewMod("Ragnaros-Cata", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetModelID(31188) -- temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"UNIT_HEALHT"
)

local warnHandRagnaros		= mod:NewSpellAnnounce(99237, 3)
local warnWrathRagnaros		= mod:NewSpellAnnounce(98263, 3)
local warnBurningWound		= mod:NewStackAnnounce(99399, 3)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3, 3)

local timerMagmaTrap		= mod:NewCDTimer(25, 98164)	-- might even be a "next" timer
local timerSulfurasSmash	= mod:NewCDTimer(40, 98710)	-- might even be a "next" timer
local timerHandRagnaros		= mod:NewCDTimer(35, 99237)	-- might even be a "next" timer
local timerWrathRagnaros	= mod:NewCDTimer(25, 98263)	-- 25-35sec variation?
local timerBurningWound		= mod:NewTargetTimer(20, 99399)
local timerPhaseSons		= mod:NewPhaseSons(45, "TimerPhaseSons")	-- lasts 45secs or till all sons are dead

local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, 5, nil, mod:IsTank())

local sonsDied = 0
local prewarnedPhase2 = false
local prewarnedPhase3 = false
function mod:OnCombatStart(delay)
	timerMagmaTrap:Start(17-delay)
	timerSulfurasSmash:Start(32-delay)
	sonsDied = 0
	prewarnedPhase2 = false
	prewarnedPhase3 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99399) then
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
	if args:IsSpellID(98710) then
		timerSulfurasSmash:Start()
	elseif args:IsSpellID(98952) then
		timerPhaseSons:Start(53)	-- 45 + 8sec cast
		sonsDied = 0
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98237) then
		warnHandRagnaros:Show()
		timerHandRagnaros:Start()
	elseif args:IsSpellID(98164) then
		timerMagmaTrap:Start()
	elseif args:IsSpellID(98263) then
		warnWrathRagnaros:Show()
		timerWrathRagnaros:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then
		sonsDied = sonsDied + 1
		if sonsDied > 10 then		-- how many are there at which difficulties?
			timerPhaseSons:Cancel()
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