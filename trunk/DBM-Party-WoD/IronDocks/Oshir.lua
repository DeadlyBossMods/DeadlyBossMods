local mod	= DBM:NewMod(1237, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79852)
mod:SetEncounterID(1750)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163054",
	"SPELL_CAST_SUCCESS 178124",
	"SPELL_AURA_APPLIED 162415 178156",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Roar cd 37 seconds? Verify
--TODO, time to feed seems MUCH longer CD now, unfortunately because of this, fight too short to get good cooldown data
local warnRendingSlashes		= mod:NewSpellAnnounce(161239, 4)
local warnRoar					= mod:NewSpellAnnounce(163054, 3)
local warnTimeToFeed			= mod:NewTargetAnnounce(162415, 3)
local warnBreakout				= mod:NewTargetAnnounce(178124, 2)

local specWarnRendingSlashes	= mod:NewSpecialWarningDodge(161239, nil, nil, nil, 3)
local specWarnRoar				= mod:NewSpecialWarningSpell(163054, nil, nil, nil, true)
local specWarnTimeToFeed		= mod:NewSpecialWarningYou(162415)--Can still move and attack during it, a personal warning lets a person immediately hit self heals/damage reduction abilities.
local specWarnTimeToFeedOther	= mod:NewSpecialWarningTarget(162415, mod:IsHealer())
local specWarnAcidSplash		= mod:NewSpecialWarningMove(178156)

--local timerTimeToFeedCD			= mod:NewCDTimer(22, 162415)--22 to 30 second variation. In CM targets random players, not just tank, so timer for all.

function mod:OnCombatStart(delay)
--	timerTimeToFeedCD:Start(50-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 162415 then
		warnTimeToFeed:Show(args.destName)
		specWarnTimeToFeedOther:Show(args.destName)
--		timerTimeToFeedCD:Start()
		if args:IsPlayer() then
			specWarnTimeToFeed:Show()
		end
	elseif args.spellId == 178156 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnAcidSplash:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 163054 then--he do not target anything. so can't use target scan.
		warnRoar:Show()
		specWarnRoar:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 178124 then
		warnBreakout:Show(args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 161239 and self:AntiSpam(5, 2) then
		warnRendingSlashes:Show()
		specWarnRendingSlashes:Show()
	end
end
