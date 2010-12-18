local mod	= DBM:NewMod("Magmaw", "DBM-BlackwingDescent", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41570)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warnLavaSpew		= mod:NewSpellAnnounce(77689, 3, nil, false)--This warning is almost completely pointless so turning off by default.
local warnPillarFlame	= mod:NewSpellAnnounce(78006, 3)
local warnMoltenTantrum	= mod:NewSpellAnnounce(78403, 4)
local warnInferno		= mod:NewSpellAnnounce(92190, 4)
local warnMangle		= mod:NewTargetAnnounce(89773, 3)

local timerLavaSpew		= mod:NewCDTimer(30, 77689)
local timerPillarFlame	= mod:NewCDTimer(30, 78006)
local timerMangle		= mod:NewTargetTimer(30, 89773)
local timerMangleCD		= mod:NewCDTimer(95, 89773)--complete guesswork on timer since two weeks in a row i had useless logger.
local timerInferno		= mod:NewCDTimer(35, 92190)

local lastLavaSpew = 0

function mod:OnCombatStart(delay)
	lastLavaSpew = 0
	timerPillarFlame:Start(-delay)
	timerMangleCD:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerInferno:Start(20-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77690, 91931, 91932) and GetTime() - lastLavaSpew > 5 then--SpellIds for other modes are guesswork, 77690 10 man confirmed
		warnLavaSpew:Show()
		timerLavaSpew:Start()
		lastLavaSpew = GetTime()
	elseif args:IsSpellID(78006) then--More than one spellid?
		warnPillarFlame:Show()
		timerPillarFlame:Start()
	elseif args:IsSpellID(78403) then
		warnMoltenTantrum:Show()
	elseif args:IsSpellID(89773, 91912, 91916, 91917) then
		warnMangle:Show(args.destName)
		timerMangle:Start(args.destName)
		timerMangleCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(89773, 91912, 91916, 91917) then
		timerMangle:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(92154, 92190, 92191, 92192) then
		warnInferno:Show()
		timerInferno:Start()
	end
end