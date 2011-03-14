local mod	= DBM:NewMod("Magmaw", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41570)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

local warnLavaSpew			= mod:NewSpellAnnounce(77689, 3, nil, mod:IsHealer())
local warnPillarFlame		= mod:NewSpellAnnounce(78006, 3)
local warnMoltenTantrum		= mod:NewSpellAnnounce(78403, 4)
local warnInferno			= mod:NewSpellAnnounce(92190, 4)
local warnMangle			= mod:NewTargetAnnounce(89773, 3)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)--heroic
local warnPhase2			= mod:NewPhaseAnnounce(2, 4)--heroic

local specWarnPillar		= mod:NewSpecialWarningSpell(78006, mod:IsRanged())
local specWarnIgnition		= mod:NewSpecialWarningMove(92198)
local specWarnInfernoSoon   = mod:NewSpecialWarning("SpecWarnInferno")
local specWarnArmageddon	= mod:NewSpecialWarningSpell(92177)

local timerLavaSpew			= mod:NewCDTimer(26, 77689, nil, mod:IsHealer())
local timerPillarFlame		= mod:NewCDTimer(32.5, 78006)--This timer is a CD timer. 30-40 seconds. Use your judgement.
local timerMangle			= mod:NewTargetTimer(30, 89773)
local timerExposed			= mod:NewBuffActiveTimer(30, 79011)
local timerMangleCD			= mod:NewCDTimer(95, 89773)
local timerInferno			= mod:NewCDTimer(35, 92190)
local timerArmageddon		= mod:NewCastTimer(8, 92177)

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame")

local lastLavaSpew = 0
local ignitionSpam = 0
local prewarnedPhase2 = false

function mod:OnCombatStart(delay)
	lastLavaSpew = 0
	ignitionSpam = 0
	prewarnedPhase2 = false
	timerPillarFlame:Start(30-delay)
	timerMangleCD:Start(90-delay)
	berserkTimer:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerInferno:Start(30-delay)
		specWarnInfernoSoon:Schedule(26-delay)
	end
	DBM.BossHealth:Clear()
	DBM.BossHealth:AddBoss(41570, 42347, L.name)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78006) then--More than one spellid?
		warnPillarFlame:Show()
		specWarnPillar:Show()
		timerPillarFlame:Start()
	elseif args:IsSpellID(78403) then
		warnMoltenTantrum:Show()
	elseif args:IsSpellID(89773, 91912, 94616, 94617) then
		warnMangle:Show(args.destName)
		timerMangle:Start(args.destName)
		timerMangleCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(89773, 91912, 94616, 94617) then
		timerMangle:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77690, 91931, 91932) and GetTime() - lastLavaSpew > 5 then--SpellIds for other modes are guesswork, 77690 10 man confirmed
		warnLavaSpew:Show()
		timerLavaSpew:Start()
		lastLavaSpew = GetTime()
	elseif args:IsSpellID(92177) then
		specWarnArmageddon:Show()
		timerArmageddon:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(92154, 92190, 92191, 92192) then
		warnInferno:Show()
		specWarnInfernoSoon:Schedule(31)
		timerInferno:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(92128, 92196, 92197, 92198) and args:IsPlayer() and GetTime() - ignitionSpam >= 4 then
		specWarnIgnition:Show()
		ignitionSpam = GetTime()
	end
end

-- heroic phase 2
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		timerInferno:Cancel()
		specWarnInfernoSoon:Cancel()
		warnPhase2:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Slump or msg:find(L.Slump) then
		timerPillarFlame:Start(15)--Resets to 15. If you don't get his head down by then he gives you new adds to mess with. (theory, don't have a lot of logs with chain screwups yet)
	elseif msg == L.HeadExposed or msg:find(L.HeadExposed) then
		timerExposed:Start()
		timerPillarFlame:Start(40)
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 29 and h < 34 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end