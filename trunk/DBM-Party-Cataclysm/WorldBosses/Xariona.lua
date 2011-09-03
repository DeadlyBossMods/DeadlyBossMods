local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnTwilightZone			= mod:NewSpellAnnounce(93553, 2)--Used for protection against UnleashedMagic
local warnTwilightFissure		= mod:NewTargetAnnounce(93546, 3)--Typical void zone.
local warnUnleashedMagic		= mod:NewCastAnnounce(93556, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnUnleashedMagic	= mod:NewSpecialWarningSpell(93556, nil, nil, nil, true)
local specWarnTwilightFissure	= mod:NewSpecialWarningYou(93546)

local timerTwilightFissureCD	= mod:NewCDTimer(23, 93546)
local timerTwilightZoneCD		= mod:NewNextTimer(30, 93553)
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
	elseif args:IsSpellID(93546) then--Assumed spell event, could be spell summon or something else.
		self:ScheduleMethod(0.2, "FissureTarget")
		timerTwilightFissureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93553) then--Assumed spell event, could be spell summon or something else.
		warnTwilightZone:Show()
		timerTwilightZoneCD:Start()
	end
end