local mod = DBM:NewMod("OrmorokTheTreeShaper", "DBM-Party-WotLK", 8)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26794)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warningSpikes	= mod:NewAnnounce("WarningSpikes", 2, 47958)
local warningFrenzy	= mod:NewAnnounce("WarningFrenzy", 3, 48017)
local warningReflection	= mod:NewAnnounce("WarningReflection", 4, 47981)
local warningAdd	= mod:NewAnnounce("WarningAdd", 1, 61564)
local timerReflection	= mod:NewTimer(15, "TimerReflection", 47981)
local timerReflectionCD	= mod:NewTimer(30, "TimerReflectionCD", 47981)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 47958 or args.spellId == 57082 or args.spellId == 57083 then
		warningSpikes:Show(args.spellName)
	elseif args.spellId == 48017 or args.spellId == 57086 then
		warningFrenzy:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 47981 then
		timerReflection:Start(args.spellName)
		warningReflection:Show(args.spellName)
		timerReflectionCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 47981 then
		timerReflection:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 61564 then
		warningAdd:Show(args.spellName)
	end
end