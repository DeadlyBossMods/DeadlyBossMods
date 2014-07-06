local mod	= DBM:NewMod(1226, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76413)
mod:SetEncounterID(1761)
mod:SetZone()

mod:RegisterCombat("combat")
mod.disableHealthCombat = true

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 166168",
	"SPELL_AURA_APPLIED_DOSE 166168",
	"SPELL_AURA_REMOVED 166168",
	"SPELL_AURA_REMOVED_DOSE 166168"
)


local warnPowerConduit			= mod:NewCountAnnounce(166168, 3)
local warnPowerConduitLeft		= mod:NewAddsLeftAnnounce(166168, 2)

local specWarnPowerConduit		= mod:NewSpecialWarningSpell(166168)

--local timerPowerConduitCD		= mod:NewCDTimer(20, 166168)--Data suggests it's probably health based because timing LOOKED consistent yet varied based on subtle dps differences

function mod:OnCombatStart(delay)
--	timerPowerConduitCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 166168 and self:IsInCombat() then
		warnPowerConduit:Cancel()
		warnPowerConduit:Schedule(0.5, args.amount or 1)
		specWarnPowerConduit:Show()
--		timerPowerConduitCD:Start()
	end
end
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 166168 and self:IsInCombat() then
		warnPowerConduit:Cancel()
		warnPowerConduit:Schedule(0.5, args.amount or 1)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 166168 and self:IsInCombat() then
		warnPowerConduitLeft:Show(args.amount or 0)
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED
