local mod = DBM:NewMod("IngvarThePlunderer", "DBM-Party-WotLK", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23980)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningSmash		= mod:NewSpellAnnounce(42723, 1)
local warningGrowl		= mod:NewSpellAnnounce(42708, 3)
local warningWoeStrike	= mod:NewTargetAnnounce(42730, 2)
local timerSmash		= mod:NewCastTimer(3, 42723)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723)

local specWarnSpelllock	= mod:NewSpecialWarning("SpecialWarningSpelllock")


function mod:SPELL_CAST_START(args)
	if args.spellId == 42723 or args.spellId == 42669 or args.spellId == 59706 then
		warningSmash:Show(args.spellName, args.spellName)
		timerSmash:Start(args.spellName)
	elseif args.spellId == 42708 or args.spellId == 42729
	or args.spellId == 59708 or args.spellId == 59734 then
		warningGrowl:Show(args.spellName, args.spellName)
	end
	if args.spellId == 42729 then
		specWarnSpelllock:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42730 or args.spellId == 59735 then
		warningWoeStrike:Show(args.spellName, args.destName)
		timerWoeStrike:Start(args.spellName, args.destName)
		mod:SetIcon(args.destName, 8, 10)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 42730 or args.spellId == 59735 then
		timerWoeStrike:Cancel()
	end
end