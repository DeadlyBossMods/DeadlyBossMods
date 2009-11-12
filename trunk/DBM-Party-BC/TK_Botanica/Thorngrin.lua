local mod = DBM:NewMod("Thorngrin", "DBM-Party-BC", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(17978)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnSacrifice       = mod:NewTargetAnnounce(34661)
local timerSacrifice      = mod:NewTargetTimer(8, 34661)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(34661) then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	end
end