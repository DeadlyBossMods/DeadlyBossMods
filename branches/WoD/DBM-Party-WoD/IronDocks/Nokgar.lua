local mod	= DBM:NewMod(1235, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81297, 81305)--VERIFY 81305
mod:SetEncounterID(1749)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 166923",
	"SPELL_AURA_APPLIED 164426"
)

local warnBarbedArrowBarrage			= mod:NewSpellAnnounce(166923, 3)
local warnRecklessProvocation			= mod:NewTargetAnnounce(164426, 3)

local specWarnBarbedArrowBarrage		= mod:NewSpecialWarningSpell(166923, nil, nil, nil, true)
local specWarnRecklessProvocation		= mod:NewSpecialWarningReflect(164426)

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 166923 then
		warnBarbedArrowBarrage:Show()
		specWarnBarbedArrowBarrage:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 164426 then
		warnRecklessProvocation:Show(args.destName)
		specWarnRecklessProvocation:Show(args.destName)
	end
end
