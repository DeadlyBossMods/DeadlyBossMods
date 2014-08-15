local mod	= DBM:NewMod(1237, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79852)
mod:SetEncounterID(1750)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163054",
	"SPELL_AURA_APPLIED 162415"
)

--TODO, Roar cd 37 seconds? Verify
local warnRoar				= mod:NewSpellAnnounce(163054, 3)
local warnTimeToFeed		= mod:NewSpellAnnounce(162415, 3)

local specWarnRoar			= mod:NewSpecialWarningSpell(163054, nil, nil, nil, true)
local specWarnTimeToFeed	= mod:NewSpecialWarningTarget(162415, mod:IsHealer())

--local timerTimeToFeedCD		= mod:NewCDTimer(30, 162415, nil, mod:IsTank() or mod:IsHealer())--VERIFY

function mod:OnCombatStart(delay)
--	timerTimeToFeedCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 162415 then
		warnTimeToFeed:Show(args.destName)
		specWarnTimeToFeed:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 163054 then--he do not target anything. so can't use target scan.
		warnRoar:Show()
		specWarnRoar:Show()
	end
end
