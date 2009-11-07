local mod = DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36678, 38216)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnSlimePuddle		= mod:NewCastAnnounce(70341, 3)
local warnUnstableExperiment	= mod:NewCastAnnounce(70351, 3)
local warnVolatileOozeAdhesive	= mod:NewTargetAnnounce(70447, 4)

local timerSlimePuddleCD	= mod:NewNextTimer(35, 70341)	-- guessed timer atm
local timerUnstableExperimentCD	= mod:NewNextTimer(35, 70351)


function mod:OnCombatStart(delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70351, 71966) then
		warnUnstableExperiment:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70341) then
		warnSlimePuddle:Show()
		timerSlimePuddleCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70447) then
		warnVolatileOozeAdhesive:Show(args.destName)
	end
end