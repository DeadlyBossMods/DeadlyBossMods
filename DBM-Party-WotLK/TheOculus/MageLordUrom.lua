local mod = DBM:NewMod("MageLordUrom", "DBM-Party-WotLK", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27655)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warningTimeBomb		= mod:NewTargetAnnounce(51121, 2)
local warningExplosion		= mod:NewSpellAnnounce(51110, 3)
local timerTimeBomb			= mod:NewTargetTimer(6, 51121)
local timerExplosion		= mod:NewTargetTimer(8, 51110)
local specWarnBombYou		= mod:NewSpecialWarning("SpecWarnBombYou")

function mod:SPELL_CAST_START(args)
	if args.spellId == 51110 or args.spellId == 59377 then
		warningExplosion:Show()
		timerExplosion:Start(args.destName)
		if args.destName == UnitName("player") then
			specWarnBombYou:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 51121 or args.spellId == 59376 then
		warningTimeBomb:Show(args.destName)
		timerTimeBomb:Start(args.destName)
	end
end
