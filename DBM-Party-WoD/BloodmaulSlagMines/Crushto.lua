local mod	= DBM:NewMod(888, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(74787)
mod:SetEncounterID(1653)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 150751",
	"SPELL_CAST_START 150759 150801 153679 150753"
)

local warnFerociousYell			= mod:NewCastAnnounce(150759, 2)
local warnRaiseMiners			= mod:NewSpellAnnounce(150801, 2, nil, mod:IsTank())
local warnCrushingLeap			= mod:NewTargetAnnounce(150751, 3)
local warnEarthCrush			= mod:NewSpellAnnounce(153679, 4)--Target scanning unavailable.
local warnWildSlam				= mod:NewSpellAnnounce(150753, 3)

local specWarnFerociousYell		= mod:NewSpecialWarningInterrupt(150759, not mod:IsHealer())
local specWarnRaiseMiners		= mod:NewSpecialWarningSwitch(150801, mod:IsTank())
local specWarnCrushingLeap		= mod:NewSpecialWarningTarget(150751, false)--seems useless.
local specWarnEarthCrush		= mod:NewSpecialWarningSpell(153679, nil, nil, nil, 2)--avoidable.
local specWarnWildSlam			= mod:NewSpecialWarningSpell(150753, nil, nil, nil, 2)--not avoidable. large aoe damage and knockback

--local timerFerociousYellCD--12~18. large variable?
--local timerRaiseMinersCD--14~26. large variable. useless.
local timerCrushingLeapCD		= mod:NewCDTimer(23, 150751)--23~25 variable.
--local timerEarthCrushCD--13~21. large variable. useless.
local timerWildSlamCD			= mod:NewCDTimer(23, 150753)--23~24 variable.

local voiceFerociousYell		= mod:NewVoice(150759, not mod:IsHealer())
local voiceRaiseMiners			= mod:NewVoice(150801)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 150751 then
		warnCrushingLeap:Show(args.destName)
		specWarnCrushingLeap:Show(args.destName)
		timerCrushingLeapCD:Start()
		if self:IsTank() then
			voiceFerociousYell:Play("kickcast")
		else
			voiceFerociousYell:Play("helpkick")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 150759 then
		warnFerociousYell:Show()
		specWarnFerociousYell:Show(args.sourceName)
	elseif spellId == 150801 then
		warnRaiseMiners:Show()
		specWarnRaiseMiners:Show()
		voiceRaiseMiners:Play("mobsoon")
	elseif spellId == 153679 then
		warnEarthCrush:Show()
		specWarnEarthCrush:Show()
	elseif spellId == 150753 then
		warnWildSlam:Show()
		specWarnWildSlam:Show()
		timerWildSlamCD:Start()
	end
end
