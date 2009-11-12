local mod	= DBM:NewMod("Maker", "DBM-Party-BC", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17381)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnMindControl      = mod:NewTargetAnnounce(30923)
local timerMindControl     = mod:NewTargetTimer(10, 30923)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30923 then
		warnMindControl:Show(args.destName)
		timerMindControl:Start(args.destName)
	end
end