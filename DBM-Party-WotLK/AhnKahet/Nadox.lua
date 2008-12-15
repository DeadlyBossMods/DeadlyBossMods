local mod = DBM:NewMod("Nadox", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29309)
mod:SetZone()

mod:RegisterCombat("combat")

local warningPlague	= mod:NewAnnounce("WarningPlague", 2, 56130)
local timerPlague	= mod:NewTimer(30, "TimerPlague", 56130)
local timerPlagueCD	= mod:NewTimer(30, "TimerPlagueCD", 56130)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 56130 or args.spellId == 59467 then
		warningPlague:Show(args.spellName, args.destName)
		timerPlague:Start(args.spellName, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 56130 or args.spellId == 59467 then
		timerPlague:Cancel()
	end
end