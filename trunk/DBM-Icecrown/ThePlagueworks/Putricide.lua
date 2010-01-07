local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36678, 38216)
mod:RegisterCombat("yell", L.YellPull)
mod:SetUsedIcons(7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 3)
local warnChokingGasBomb			= mod:NewSpellAnnounce(70351, 3)
local warnMalleableGoo				= mod:NewSpellAnnounce(72295, 3)
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 4)
local warnGaseousBloat				= mod:NewTargetAnnounce(70672, 4)

local specWarnTearGas				= mod:NewSpecialWarningSpell(71617)
local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447)
local specWarnGaseousBloat			= mod:NewSpecialWarningYou(70672)

local timerSlimePuddleCD			= mod:NewNextTimer(35, 70341)	-- guessed timer atm
local timerUnstableExperimentCD		= mod:NewNextTimer(35, 70351)
local timerTearGas					= mod:NewBuffActiveTimer(20, 71615)

mod:AddBoolOption("OozeAdhesiveIcon")
mod:AddBoolOption("GaseousBloatIcon")


function mod:OnCombatStart(delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70351, 71966) then
		warnUnstableExperiment:Show()
	elseif args:IsSpellID(71617) then
		specWarnTearGas:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70341) then
		warnSlimePuddle:Show()
		timerSlimePuddleCD:Start()
	elseif args:IsSpellID(71255) then
		warnChokingGasBomb:Show()
	elseif args:IsSpellID(72295) then--too many spellids to drycode other spellids without logs.
		warnMalleableGoo:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		warnVolatileOozeAdhesive:Show(args.destName)
		if args:IsPlayer() then
			specWarnVolatileOozeAdhesive:Show()
		end
		if self.Options.OozeAdhesiveIcon then
				mod:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(70672) then
		warnGaseousBloat:Show(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
		end
		if self.Options.GaseousBloatIcon then
			mod:SetIcon(args.destName, 7, 20)
		end
	elseif args:IsSpellID(71615, 71618) then--normal and heroic? one is immune to damage and stunned, other is just a stun
		timerTearGas:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		if self.Options.OozeAdhesiveIcon then
			mod:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70672) then
		if self.Options.GaseousBloatIcon then
			mod:SetIcon(args.destName, 0)
		end
	end
end