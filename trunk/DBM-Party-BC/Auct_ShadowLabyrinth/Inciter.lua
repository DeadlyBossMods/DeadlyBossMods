local mod = DBM:NewMod("Inciter", "DBM-Party-BC", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(18667)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnChaos         = mod:NewSpellAnnounce(33676)
local timerChaos        = mod:NewBuffActiveTimer(15, 33676)
local timerNextChaos    = mod:NewNextTimer(70, 33676)

function mod:OnCombatStart(delay)
    timerNextChaos:Start(15-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 33676 then
		warnChaos:Show()
		timerChaos:Start()
		timerNextChaos:Start()
	end
end