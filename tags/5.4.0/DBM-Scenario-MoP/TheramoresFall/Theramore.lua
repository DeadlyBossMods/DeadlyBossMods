local mod	= DBM:NewMod("d566", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1000, 999)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnStormTotem			= mod:NewSpellAnnounce(127010, 3)
local warnWarEnginesSights		= mod:NewTargetAnnounce(114570, 4)

local specWarnStormTotem		= mod:NewSpecialWarningSpell(127010)--Just a spell type, cause switch and move are both viable options for strategy so we won't tell players how to do it in our warning
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

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 127010 then
		warnStormTotem:Show()
		specWarnStormTotem:Show()
	end
end
