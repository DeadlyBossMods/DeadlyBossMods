local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)
mod:SetZone(640)--Deepholm

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_POWER"
)

local warnTwilightZone			= mod:NewSpellAnnounce(93553, 2)--Used for protection against UnleashedMagic
local warnTwilightFissure		= mod:NewTargetAnnounce(93546, 3)--Typical void zone.
local warnTwilightBuffet		= mod:NewTargetAnnounce(93551, 3)
local warnUnleashedMagicSoon	= mod:NewSoonAnnounce(93556, 3)--An attack that one shots anyone not in a twilight zone.
local warnUnleashedMagic		= mod:NewCastAnnounce(93556, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnUnleashedMagic	= mod:NewSpecialWarningSpell(93556, nil, nil, nil, true)
local specWarnTwilightFissure	= mod:NewSpecialWarningYou(93546)

local timerTwilightFissureCD	= mod:NewCDTimer(23, 93546)
local timerTwilightZoneCD		= mod:NewNextTimer(30, 93553)
local timerTwilightBuffetCD		= mod:NewCDTimer(20, 93551)
local timerTwilightBuffet		= mod:NewTargetTimer(10, 93551)
local timerUnleashedMagicCD		= mod:NewCDTimer(65, 93556)--65 Cd but least priority spell, she will cast breath, fissure zone or buffet before this, so overlapping CDs often delay this upwards to 75 seconds sometimes

function mod:FissureTarget()
	local targetname = self:GetBossTarget(50061)
	if not targetname then return end
	warnTwilightFissure:Show(targetname)
	if targetname == UnitName("player") then
		specWarnTwilightFissure:Show()
	end
end

function mod:OnCombatStart(delay)
	timerTwilightBuffetCD:Start(10-delay)
	timerTwilightZoneCD:Start(-delay)--Not a large sample size but seems like it'd be right.
	timerTwilightFissureCD:Start(-delay)--May not be right, not a large sample size
--	timerUnleashedMagicCD:Start(60-delay)--May not get cast entire fight but if it is cast this is about right.
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93556) then
		warnUnleashedMagic:Show()
		specWarnUnleashedMagic:Show()
		timerUnleashedMagicCD:Start()
	elseif args:IsSpellID(93546) then
		self:ScheduleMethod(0.2, "FissureTarget")
		timerTwilightFissureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93553) then
		warnTwilightZone:Show()
		timerTwilightZoneCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93551) then
		warnTwilightBuffet:Show(args.destName)
		timerTwilightBuffet:Start(args.destName)
		timerTwilightBuffetCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(93551) then
		timerTwilightBuffet:Cancel(args.destName)
	end
end

function mod:UNIT_POWER(uId)
	if self:GetUnitCreatureId(uId) == 50061 and UnitPower(uId) == 80 then
		warnUnleashedMagicSoon:Show()
		DBM.Bars:CreateBar(10, "Big AOE Testbar")
		--Will change to prewarn when i get right tuning and can find right energy level for 10 seconds.
		--Also once i get that info i'll be able to auto start/correct the timer whenever, and detect whether it's bugged or not.
	end
end