local mod	= DBM:NewMod("d539", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1051)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)

--Li Te
local warnWaterShell		= mod:NewSpellAnnounce(124653, 2)
--Den Mother Moof
local warnBurrow			= mod:NewSpellAnnounce(124359, 2)
--Warbringer Qobi
local warnFireLine			= mod:NewCastAnnounce(125392, 4, 3)

--Warbringer Qobi
local specWarnFireLine		= mod:NewSpecialWarningSpell(125392, nil, nil, nil, 2)

mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 124428 then
		warnWaterShell:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 124359 then
		warnBurrow:Show()
	elseif args.spellId == 125392 then
		warnFireLine:Show()
		specWarnFireLine:Show()
	end
end
