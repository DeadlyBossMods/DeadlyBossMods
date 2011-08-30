local mod	= DBM:NewMod("Xariona", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50061)
mod:SetModelID(32229)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnTwilightZone			= mod:NewSpellAnnounce(93553, 2)--Used for protection against UnleashedMagic
local warnTwilightFissure		= mod:NewSpellAnnounce(93546, 3)--Typical void zone.
local warnUnleashedMagic		= mod:NewCastAnnounce(93556, 4)--An attack that one shots anyone not in a twilight zone.

local specWarnUnleashedMagic	= mod:NewSpecialWarningSpell(93556, nil, nil, nil, true)

--local timerTwilightZoneCD		= mod:NewNextTimer(28.5, 93553)
--local timerUnleashedMagicCD	= mod:NewNextTimer(28.5, 93494)

function mod:OnCombatStart(delay)
	--timerTwilightZoneCD:Start(-delay)
	--timerUnleashedMagicCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93492) then
		warnUnleashedMagic:Show()
		specWarnUnleashedMagic:Show()
--		timerUnleashedMagicCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93553) then--Assumed spell event, could be spell summon or something else.
		warnTwilightZone:Show()
	elseif args:IsSpellID(93546) then--Assumed spell event, could be spell summon or something else.
		warnTwilightFissure:Show()
	end
end