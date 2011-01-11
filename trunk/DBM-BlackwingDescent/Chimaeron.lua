local mod	= DBM:NewMod("Chimaeron", "DBM-BlackwingDescent", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43296)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnCausticSlime		= mod:NewTargetAnnounce(82935, 3, nil, false)--This will be very spammy but useful for debugging positioning issues (IE too many people clumped)
local warnBreak				= mod:NewAnnounce("WarnBreak", 3, 82881, mod:IsTank() or mod:IsHealer())
local warnDoubleAttack		= mod:NewSpellAnnounce(88826, 4, nil, mod:IsTank() or mod:IsHealer())
local warnMassacre			= mod:NewSpellAnnounce(82848, 4)
local warnFeud				= mod:NewSpellAnnounce(88872, 3)
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)

local specWarnBreak			= mod:NewSpecialWarningStack(82881, nil, 3)
local specWarnMassacre		= mod:NewSpecialWarningSpell(82848, mod:IsHealer())
local specWarnDoubleAttack	= mod:NewSpecialWarningSpell(88826, mod:IsTank())

local timerBreak			= mod:NewTargetTimer(60, 82881)
local timerMassacre			= mod:NewCastTimer(4, 82848)
local timerMassacreNext		= mod:NewNextTimer(30, 82848)
local timerCausticSlime		= mod:NewNextTimer(15, 88915)--This is seemingly cast 15 seconds into feud, any other time it's simply cast repeatedly the whole fight.
local timerFeud				= mod:NewBuffActiveTimer(26, 88872)
--local timerFeudNext			= mod:NewNextTimer(90, 88872)

local berserkTimer			= mod:NewBerserkTimer(420)--Heroic

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnSlime", true)

local prewarnedPhase2 = false
local feud = false
local slimeTargets = {}
local slimeIcon = 8

local function showSlimeWarning()
	warnCausticSlime:Show(table.concat(slimeTargets, "<, >"))
	table.wipe(slimeTargets)
	slimeIcon = 8
end

function mod:OnCombatStart(delay)
	timerMassacreNext:Start(-delay)
--	timerFeudNext:Start(-delay)--Not consistent?
	prewarnedPhase2 = false
	feud = false
	slimeIcon = 8
	table.wipe(slimeTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82881) then
		warnBreak:Show(args.spellName, args.destName, args.amount or 1)
		timerBreak:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 3 then
			specWarnBreak:Show(args.amount)
		end
	elseif args:IsSpellID(88826) then
		warnDoubleAttack:Show()
		specWarnDoubleAttack:Show()
	elseif args:IsSpellID(82935, 88915, 88916, 88917) and args:IsDestTypePlayer() then--There is no cast for this, so we have to warn on damage :\
		slimeTargets[#slimeTargets + 1] = args.destName
		if self.Options.SetIconOnSlime and not feud then--Don't set icons during feud, set them any other time.
			self:SetIcon(args.destName, slimeIcon)
			slimeIcon = slimeIcon - 1
		end
		self:Unschedule(showSlimeWarning)
		self:Schedule(0.3, showSlimeWarning)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82848) then
		warnMassacre:Show()
		specWarnMassacre:Show()
		timerMassacre:Start()
		timerMassacreNext:Start()
		feud = false
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(88872) then
		warnFeud:Show()
		timerFeud:Start()
--		timerFeudNext:Start()
		timerCausticSlime:Start()
		feud = true
	elseif args:IsSpellID(82934) then
		warnPhase2:Show()
		timerFeudNext:Cancel()
		timerCausticSlime:Cancel()
		timerMassacreNext:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 22 and h < 25 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end