local mod	= DBM:NewMod("Mandokir", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52151, 52157)
mod:SetZone()

mod:SetBossHealthInfo(
	52151, L.name,
	52157, L.Ohgan
)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnDecapitate		= mod:NewTargetAnnounce(96684, 2)
local warnBloodletting		= mod:NewTargetAnnounce(96776, 3)
local warnSlam			= mod:NewSpellAnnounce(96740, 4)
local warnOhgan			= mod:NewSpellAnnounce(96724, 4)
local warnFrenzy		= mod:NewSpellAnnounce(96800, 3)
local warnRevive 		= mod:NewAnnounce("WarnRevive", 2, nil, false)


local timerDecapitate		= mod:NewNextTimer(30, 96684)
local timerBloodletting		= mod:NewTargetTimer(10, 96776)
local timerBloodlettingCD	= mod:NewCDTimer(25, 96776)
local timerSlam			= mod:NewCastTimer(2, 96740)
local timerOhgan		= mod:NewCastTimer(3, 96724)

local specWarnSlam		= mod:NewSpecialWarningCast(96740, nil, mod:IsTank())

local reviveCounter = 0

function mod:OnCombatStart(delay)
	reviveCounter = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96776) then
		warnBloodletting:Show(args.destName)
		timerBloodletting:Start(args.destName)
		timerBloodlettingCD:Start()
	elseif args:IsSpellID(96800) then
		warnFrenzy:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96484) then
		reviveCounter = reviveCounter + 1
		warnRevive:Show(args.spellName, reviveCounter)
	elseif args:IsSpellID(96740) then
		warnSlam:Show()
		specWarnSlam:Show()
		timerSlam:Start()
	elseif args:IsSpellID(96724) then
		warnOhgan:Show()
		timerOhgan:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96684) then
		warnDecapitate:Show(args.destName) -- yes, this works according to combatlog
		timerDecapitate:Start()
	end
end