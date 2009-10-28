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

local warningSpikes		= mod:NewSpellAnnounce(47958, 2)
local warningFrenzy		= mod:NewSpellAnnounce(48017, 3)
local warningReflection	= mod:NewSpellAnnounce(47981, 4)
local warningAdd		= mod:NewSpellAnnounce(61564, 1)
local timerReflection	= mod:NewBuffActiveTimer(15, 47981)
local timerReflectionCD	= mod:NewCDTimer(30, 47981)

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