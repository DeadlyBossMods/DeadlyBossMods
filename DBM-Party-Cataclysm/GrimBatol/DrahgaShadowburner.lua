local mod	= DBM:NewMod(133, "DBM-Party-Cataclysm", 3, 71)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40319)
mod:SetModelID(31792)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_AURA"
)

local warnFlame					= mod:NewSpellAnnounce(75321, 3)
local warnDevouring				= mod:NewSpellAnnounce(90950, 3)
local warnShredding				= mod:NewSpellAnnounce(75271, 3)
local warnFlamingFixate	 		= mod:NewTargetAnnounce(82850, 4)

local specWarnFlamingFixate		= mod:NewSpecialWarningYou(82850)
local specWarnDevouring 		= mod:NewSpecialWarningSpell(90950, nil, nil, nil, true)
local specWarnSeepingTwilight	= mod:NewSpecialWarningMove(75317)

local timerFlame				= mod:NewCDTimer(27, 75321)
local timerDevouring			= mod:NewBuffActiveTimer(5, 90950)
local timerShredding			= mod:NewBuffActiveTimer(20, 75271)

local flamingFixate = GetSpellInfo(82850)
local fixateWarned = false
local Valiona = EJ_GetSectionInfo(3369)

function mod:OnCombatStart(delay)
	fixateWarned = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75328) then
		DBM.BossHealth:RemoveBoss(40320)
	elseif args:IsSpellID(75317, 90964) and args:IsPlayer() then
		specWarnSeepingTwilight:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75321, 90973) then
		warnFlame:Show()
		timerFlame:Start()
	elseif args:IsSpellID(90950) then
		warnDevouring:Show()
		specWarnDevouring:Show()
		timerDevouring:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(75271, 90966) then
		warnShredding:Show()
		timerShredding:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.ValionaYell or msg:find(L.ValionaYell) then
		DBM.BossHealth:AddBoss(40320, Valiona)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Add or msg:find(L.Add) then
		fixateWarned = false--This will of course mess up if you haven't killed your last add yet, it'll rewarn fixate on that one then not warn for new one.
	end
end

function mod:UNIT_AURA(uId)
	if UnitDebuff(uId, flamingFixate) and not fixateWarned then--This spams every 0.5 seconds if not throttled, debuff has unlimited duration so you can't really use a timed function.
		warnFlamingFixate:Show(DBM:GetUnitFullName(uId))
		if uId == "player" then
			specWarnFlamingFixate:Show()
		end
		fixateWarned = true
	end
end