local mod	= DBM:NewMod("Baltharus", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39751)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"UNIT_HEALTH"
)

local warningSplitSoon		= mod:NewAnnounce("WarningSplitSoon", 2)
local warningRepellingWave	= mod:NewSpellAnnounce(74509, 3)
local warnWhirlwind			= mod:NewSpellAnnounce(75125, 3, nil, mod:IsTank() or mod:IsHealer())
local warningWarnBrand		= mod:NewTargetAnnounce(74505, 4)

local specWarnBrand			= mod:NewSpecialWarningYou(74505)
local specWarnRepellingWave	= mod:NewSpecialWarningSpell(74509)

local timerWhirlwind		= mod:NewBuffActiveTimer(4, 75125, nil, mod:IsTank() or mod:IsHealer())
local timerRepellingWave	= mod:NewBuffActiveTimer(4, 74509)--1 second cast + 3 second stun
local timerBrand			= mod:NewBuffActiveTimer(10, 74505)

mod:AddBoolOption("SetIconOnBrand", true)
mod:AddBoolOption("RangeFrame")

local warnedSplit1	= false
local warnedSplit2	= false
local warnedSplit3	= false
local brandTargets = {}
local brandIcon	= 8

local function showBrandWarning()
	warningWarnBrand:Show(table.concat(brandTargets, "<, >"))
	table.wipe(brandTargets)
end

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(15.5-delay)--need more pulls to verify consistency
	warnedSplit1 = false
	warnedSplit2 = false
	warnedSplit3 = false
	table.wipe(brandTargets)
	brandIcon = 8
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74509) then
		warningRepellingWave:Show()
		specWarnRepellingWave:Show()
		timerRepellingWave:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75125) then
		warnWhirlwind:Show()
		timerWhirlwind:Show()
	elseif args:IsSpellID(74505) then
		brandTargets[#brandTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBrand:Show()
			timerBrand:Show()
		end
		if self.Options.SetIconOnBrand then
			if 	brandIcon < 1 then
				brandIcon = 8
			end
			self:SetIcon(args.destName, brandIcon, 10)
			brandIcon = brandIcon - 1
		end
		self:Unschedule(showBrandWarning)
		self:Schedule(0.5, showBrandWarning)
	end
end

function mod:UNIT_HEALTH(uId)
	if (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) then
		if not warnedSplit1 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
			warnedSplit1 = true
			warningSplitSoon:Show()
		elseif not warnedSplit3 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
			warnedSplit3 = true
			warningSplitSoon:Show()
		end
	else
		if not warnedSplit2 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
			warnedSplit2 = true
			warningSplitSoon:Show()
		end
	end
end