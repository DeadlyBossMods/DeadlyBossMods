local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36678)
mod:RegisterCombat("yell", L.YellPull)
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH"
)

local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 3)
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 4)
local warnGaseousBloat				= mod:NewTargetAnnounce(70672, 4)
local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnTearGas					= mod:NewSpellAnnounce(71617)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnMalleableGoo				= mod:NewSpellAnnounce(72295, 3)--Phase 2 ability
local warnChokingGasBomb			= mod:NewSpellAnnounce(71255, 3)--Phase 2 ability
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warnGuzzlePotions				= mod:NewSpellAnnounce(71893)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnMutatedPlague				= mod:NewAnnounce("WarnMutatedPlague", 3)--Phase 3 ability

local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447)
local specWarnGaseousBloat			= mod:NewSpecialWarningYou(70672)
local specWarnMutatedPlague			= mod:NewSpecialWarningStack(72451, nil, 5)--Minimum number of stacks needed to clear other tanks debuff with 2 tanks
local specWarnMalleableGoo			= mod:NewSpecialWarning("specWarnMalleableGoo")
local specWarnMalleableGooNear		= mod:NewSpecialWarning("specWarnMalleableGooNear")

local timerGaseousBloat				= mod:NewTargetTimer(20, 70672)--Duration of debuff
local timerSlimePuddleCD			= mod:NewNextTimer(35, 70341)-- Approx
local timerUnstableExperimentCD		= mod:NewNextTimer(35, 70351)
local timerTearGas					= mod:NewBuffActiveTimer(20, 71615)
--local timerCreateConcoction		= mod:NewBuffActiveTimer(15, 71621)--Commented out til i know for sure if it's 15 seconds or 4 seconds. 15 makes more sense with duration of tear gas but tooltip says 4 :\
local timerGuzzlePotions			= mod:NewBuffActiveTimer(12, 71893)--4seconds cast plus 8 seconds for transformation
local timerMutatedPlague			= mod:NewTargetTimer(60, 72451)	-- 60 Seconds until expired
local timerMutatedPlagueCD			= mod:NewCDTimer(10, 72451)-- 10 to 11

-- buffs from "Drink Me"
local timerMutatedSlash				= mod:NewBuffActiveTimer(20, 70542)
local timerRegurgitatedOoze			= mod:NewBuffActiveTimer(20, 70539)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("OozeAdhesiveIcon")
mod:AddBoolOption("GaseousBloatIcon")

local warned_preP2 = false
local warned_preP3 = false
local spamPuddle = 0
local phase = 0

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
	warned_preP2 = false
	warned_preP3 = false
	phase = 1
end

function mod:MalleableGooTarget()--. Great for 10 man, but only marks/warns 1 of the 2 people in 25 man
	local targetname = self:GetBossTarget(36678)
	if not targetname then return end
		self:SetIcon(targetname, 6, 10)
	if targetname == UnitName("player") then
		specWarnMalleableGoo:Show()
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnMalleableGooNear:Show()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70351, 71966) then
		warnUnstableExperiment:Show()
	elseif args:IsSpellID(71617) then
		warnTearGas:Show()--This lasts 15 more seconds atfer Create Concoction is cast start which leads me to suspect the tooltip is wrong or something is wonky.
	elseif args:IsSpellID(71621) then--Create Concoction, used after Tear Gas is cast
--		timerCreateConcoction:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70341) and GetTime() - spamPuddle > 5 then
		warnSlimePuddle:Show()
		timerSlimePuddleCD:Start()
		spamPuddle = GetTime()
	elseif args:IsSpellID(71255) then
		warnChokingGasBomb:Show()
	elseif args:IsSpellID(72295, 72615, 72295, 72296) then
		warnMalleableGoo:Show()
		self:ScheduleMethod(0.1, "MalleableGooTarget")
	elseif args:IsSpellID(73120, 71893) then--Guzzle Potions, used just before phase 3 to mutate
		warnGuzzlePotions:Show()
		timerGuzzlePotions:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then--Green Slime
		warnVolatileOozeAdhesive:Show(args.destName)
		if args:IsPlayer() then
			specWarnVolatileOozeAdhesive:Show()
		end
		if self.Options.OozeAdhesiveIcon then
				mod:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(70672, 72455) then--Red Slime (70672 seems used in both normal modes, i suspect 72455 is heroic)
		warnGaseousBloat:Show(args.destName)
		timerGaseousBloat:Start(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
		end
		if self.Options.GaseousBloatIcon then
			mod:SetIcon(args.destName, 7, 20)
		end
	elseif args:IsSpellID(71615, 71618) then--71615 used in 10 and 25 normal, 71618 heroic ID maybe?(this id doesn't make immune, only stuns)
		timerTearGas:Start()
	elseif args:IsSpellID(71603) then	-- Mutated Strength
		warnPhase3:Show()
	elseif args:IsSpellID(72451) then	-- Mutated Plague
		warnMutatedPlague:Show(args.spellName, args.destName, args.amount or 1)
		timerMutatedPlague:Start(args.destName)
		timerMutatedPlagueCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 5 then
			specWarnMutatedPlague:Show(args.amount)
		end
	elseif args:IsSpellID(70542) then
		timerMutatedSlash:Show()
	elseif args:IsSpellID(70539) then
		timerRegurgitatedOoze:Show()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		if self.Options.OozeAdhesiveIcon then
			mod:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70672, 72455) then
		timerGaseousBloat:Cancel(args.destName)
		if self.Options.GaseousBloatIcon then
			mod:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(71615, 71618) and phase == 1 then	-- only show one time
		phase = 2
		warnPhase2:Show()
	end
end

--values subject to tuning depending on dps and his health pool
function mod:UNIT_HEALTH(uId)
	if phase == 1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.83 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
	elseif phase == 2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end

