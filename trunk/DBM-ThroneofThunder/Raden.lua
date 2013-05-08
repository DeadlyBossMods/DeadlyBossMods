local mod	= DBM:NewMod(831, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69473)--69888
mod:SetQuestID(32753)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

-- NO WARNINGS, PURE DRYCODE. Events are assumed from spellinfo data (cast time, obviously SPELL_CAST_START, instant cast, SPELL_CAST_SUCCESS. Aura on boss, SPELL_AURA_APPLIED)
-- To complete this mod, combatlog required..

--Anima
local warnAnima					= mod:NewSpellAnnounce(138331, 2)--Switched to anima phase
local warnMurderousStrike		= mod:NewSpellAnnounce(138333, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
--local warnUnstableAnima			= mod:NewTargetAnnounce(138288)--May range frame needed. 138295 is damage id according to wowhead, 138288 is debuff cast.
local warnSanguineHorror		= mod:NewSpellAnnounce(138338, 3, nil, not mod:IsHealer())--Adds
--Vita
local warnVita					= mod:NewSpellAnnounce(138332, 2)--Switched to vita phase
local warnFatalStrike			= mod:NewSpellAnnounce(138334, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
--local warnUnstableVita			= mod:NewTargetAnnounce(138308, 3)
local warnCracklingStalker		= mod:NewSpellAnnounce(138339, 3, nil, not mod:IsHealer())--Adds
--All Phases ?
local warnCreation				= mod:NewSpellAnnounce(138321)
local warnRuinBolt				= mod:NewSpellAnnounce(139087)

--Anima
local specWarnMurderousStrike	= mod:NewSpecialWarningSpell(138333, mod:IsTank() or mod:IsHealer(), nil, nil, 3)
local specWarnSanguineHorror	= mod:NewSpecialWarningSwitch(138338, not mod:IsHealer())--Do all need to switch? how dangerous adds? more info needed
--Vita
local specWarnFatalStrike		= mod:NewSpecialWarningSpell(138334, mod:IsTank() or mod:IsHealer(), nil, nil, 3)--Do all need to switch? how dangerous adds? more info needed
local specWarnCracklingStalker	= mod:NewSpecialWarningSwitch(138339, not mod:IsHealer())

function mod:SPELL_CAST_START(args)
	if args.spellId == 138338 then
		warnSanguineHorror:Show()
		specWarnSanguineHorror:Show()
	elseif args.spellId == 138339 then
		warnCracklingStalker:Show()
		specWarnCracklingStalker:Show()
	elseif args.spellId == 138321 then
		warnCreation:Show()
	elseif args.spellId == 139087 then
		warnRuinBolt:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138333 then
		warnMurderousStrike:Show()
		specWarnMurderousStrike:Show()
	elseif args.spellId == 138334 then
		warnFatalStrike:Show()
		specWarnFatalStrike:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138331 then
		warnAnima:Show()
	elseif args.spellId == 138332 then
		warnVita:Show()
	end
end
