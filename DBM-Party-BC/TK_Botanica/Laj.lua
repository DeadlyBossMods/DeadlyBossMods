local mod = DBM:NewMod("Laj", "DBM-Party-BC", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(17980)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnAllergic       = mod:NewTargetAnnounce(34697)
local timerAllergic      = mod:NewTargetTimer(18, 34697)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(34697) then
		warnAllergic:Show(args.destName)
		timerAllergic:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(34697) then
		timerAllergic:Cancel(args.destName)
	end
end