local mod	= DBM:NewMod("Troves", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 8980 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 934)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local timerEvent			= mod:NewBuffFadesTimer(300, 140000)

mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 140000 then
		timerEvent:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 140000 then
		timerEvent:Cancel()
	end
end
