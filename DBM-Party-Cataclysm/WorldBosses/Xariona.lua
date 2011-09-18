local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)
mod:SetZone(640)--Deepholm

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnTwilightZone			= mod:NewSpellAnnounce(93553, 2)--Used for protection against UnleashedMagic
local warnTwilightFissure		= mod:NewTargetAnnounce(93546, 3)--Typical void zone.
local warnTwilightBuffet		= mod:NewTargetAnnounce(93551, 3)
local warnUnleashedMagic		= mod:NewCastAnnounce(93556, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnUnleashedMagic	= mod:NewSpecialWarningSpell(93556, nil, nil, nil, true)
local specWarnTwilightFissure	= mod:NewSpecialWarningYou(93546)

local timerTwilightFissureCD	= mod:NewCDTimer(23, 93546)
local timerTwilightZoneCD		= mod:NewNextTimer(30, 93553)
local timerTwilightBuffetCD		= mod:NewCDTimer(20, 93551)
local timerTwilightBuffet		= mod:NewTargetTimer(10, 93551)
--local timerUnleashedMagicCD	= mod:NewNextTimer(60, 93494)--She doesn't seem to use this ability if you don't have at least 3 ranged in group. Melee comps or tiny groups avoid this completely.

function mod:FissureTarget()
	local targetname = self:GetBossTarget(50061)
	if not targetname then return end
	warnTwilightFissure:Show(targetname)
	if targetname == UnitName("player") then
		specWarnTwilightFissure:Show()
	end
end

function mod:OnCombatStart(delay)
	timerTwilightZoneCD:Start(-delay)--Not a large sample size but seems like it'd be right.
	timerTwilightFissureCD:Start(-delay)--May not be right, not a large sample size
	--timerUnleashedMagicCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93492) then
		warnUnleashedMagic:Show()
		specWarnUnleashedMagic:Show()
--		timerUnleashedMagicCD:Start()
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