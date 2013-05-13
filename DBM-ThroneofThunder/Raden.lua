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
local warnUnstableAnima			= mod:NewTargetAnnounce(138288)--May range frame needed. 138295 is damage id according to wowhead, 138288 is debuff cast.
local warnSanguineHorror		= mod:NewCountAnnounce(138338, 3, nil, not mod:IsHealer())--Adds
--Vita
local warnVita					= mod:NewSpellAnnounce(138332, 2)--Switched to vita phase
local warnFatalStrike			= mod:NewSpellAnnounce(138334, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
local warnUnstableVita			= mod:NewTargetAnnounce(138297, 3)
local warnCracklingStalker		= mod:NewCountAnnounce(138339, 3, nil, not mod:IsHealer())--Adds
--General
local warnCreation				= mod:NewCountAnnounce(138321)--aka Orbs/Balls
local warnRuinBolt				= mod:NewSpellAnnounce(139087)--Useful?

--Anima
local specWarnMurderousStrike	= mod:NewSpecialWarningSpell(138333, mod:IsTank(), nil, nil, 3)
local specWarnSanguineHorror	= mod:NewSpecialWarningSpell(138338, not mod:IsHealer())
local specWarnAninaSensitive	= mod:NewSpecialWarningYou(139318)
local specWarnUnstableAnima		= mod:NewSpecialWarningYou(138288, nil, nil, nil, 3)
local yellUnstableAnima			= mod:NewYell(138288, nil, false)
--Vita
local specWarnFatalStrike		= mod:NewSpecialWarningSpell(138334, mod:IsTank(), nil, nil, 3)
local specWarnCracklingStalker	= mod:NewSpecialWarningSpell(138339, not mod:IsHealer())
local specWarnVitaSensitive		= mod:NewSpecialWarningYou(138372)
local specWarnUnstablVita		= mod:NewSpecialWarningYou(138297, nil, nil, nil, 3)
local yellUnstableVita			= mod:NewYell(138297, nil, false)

--Anima
local timerMurderousStrikeCD	= mod:NewCDTimer(33, 138333, nil, mod:IsTank())--Gains 3 power per second roughly and uses special at 100 Poewr
--local timerSanguineHorrorCD	= mod:NewCDCountTimer(41, 138338)
--Vita
local timerFatalStrikeCD		= mod:NewCDTimer(10, 138334, nil, mod:IsTank())--Gains 10 power per second roughly and uses special at 100 Poewr
local timerUnstableVita			= mod:NewTargetTimer(12, 138297)
local timerCracklingStalkerCD	= mod:NewCDCountTimer(41, 138339)
--General
local timerCreationCD			= mod:NewCDCountTimer(31, 138321)--31-35second variation

local countdownUnstableVita		= mod:NewCountdownFades(11, 138297)

local creationCount = 0
local stalkerCount = 0
local horrorCount = 0
local lastStalker = 0

function mod:OnCombatStart(delay)
	creationCount = 0
	stalkerCount = 0
	horrorCount = 0
	timerCreationCD:Start(10-delay, 1)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 138338 then
		horrorCount = horrorCount + 1
		warnSanguineHorror:Show(horrorCount)
		specWarnSanguineHorror:Show()
--		timerSanguineHorrorCD:Start(nil, horrorCount+1)
	elseif args.spellId == 138339 then
		lastStalker = GetTime()
		stalkerCount = stalkerCount + 1
		warnCracklingStalker:Show(stalkerCount)
		specWarnCracklingStalker:Show()
		timerCracklingStalkerCD:Start(nil, stalkerCount+1)
	elseif args.spellId == 138321 then
		creationCount = creationCount + 1
		warnCreation:Show(creationCount)
		timerCreationCD:Start(nil, creationCount+1)
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
		timerFatalStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138331 then--Anima Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 3
		horrorCount = 0
		timerFatalStrikeCD:Cancel()
		timerCracklingStalkerCD:Cancel()
		timerMurderousStrikeCD:Start(33-radenPower)
		--timerSanguineHorrorCD:Start(nil, 1)
		warnAnima:Show()
	elseif args.spellId == 138332 then--Vita Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 10
		local stalkerupdate = nil
		if GetTime() - lastStalker < 32 then--Check if it's been at least 32 seconds since last stalker
			stalkerupdate = 40 - (GetTime() - lastStalker)--if not, find out how much time is left on internal stalker cd (cause CD doesn't actually reset when you reset vita, it just extends to 8-9 seconds if less than 8-9 seconds remaining)
		else
			stalkerupdate = 8
		end
		stalkerCount = 0
		warnVita:Show()
		timerMurderousStrikeCD:Cancel()
		--timerSanguineHorrorCD:Cancel()
		timerCracklingStalkerCD:Start(stalkerupdate, 1)
		timerFatalStrikeCD:Start(10-radenPower)
	elseif args.spellId == 139318 then--Anima Sensitivity
		if args:IsPlayer() then
			specWarnAninaSensitive:Show()
		end
	elseif args.spellId == 138372 then--Vita Sensitivity
		if args:IsPlayer() then
			specWarnVitaSensitive:Show()
		end
	elseif args.spellId == 138288 then--Unstable Anima
		warnUnstableAnima:Show(args.destName)
		if args:IsPlayer() then
			specWarnUnstableAnima:Show()
			yellUnstableAnima:Yell()
		end
	elseif args:IsSpellID(138297, 138308) then--Unstable Vita
		warnUnstableVita:Show(args.destName)
		timerUnstableVita:Start(args.destName)
		if args:IsPlayer() then
			specWarnUnstablVita:Show()
			yellUnstableVita:Yell()
			countdownUnstableVita:Start()
		end
	end
end
