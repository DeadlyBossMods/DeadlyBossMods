local mod	= DBM:NewMod("d566", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 906, 851)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local warnWarEnginesSights		= mod:NewTargetAnnounce(114570, 4)

local specWarnWarEnginesSights	= mod:NewSpecialWarningMove(114570)--Actually used by his trash, but in a speed run, you tend to pull it all together
local yellWarEnginesSights		= mod:NewYell(114570)

mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 114570 then
		warnWarEnginesSights:Show(args.destName)
		if args:IsPlayer() then
			specWarnWarEnginesSights:Show()
			yellWarEnginesSights:Yell()
		end
	end
end
