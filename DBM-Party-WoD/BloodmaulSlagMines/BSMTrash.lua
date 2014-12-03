local mod	= DBM:NewMod("BSMTrash", "DBM-Party-WoD", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 164597 151548 151697 151965 151558 151581",
	"SPELL_CAST_START 152298 151447 151545"
)

local warnCrush							= mod:NewCastAnnounce(151447, 4, nil, mod:IsTank())
local warnCinderSplash					= mod:NewCastAnnounce(152298, 3)
local warnRoar							= mod:NewCastAnnounce(151545, 3)
local warnLavaBurst						= mod:NewCastAnnounce(151558, 4)--Too spammy? hits tank hard on CM though, near one shot. like 70% of health. Must interrupt most of them
local warnSuppressionField				= mod:NewCastAnnounce(151581, 3)
local warnStoneBulwark					= mod:NewTargetAnnounce(164597, 3, nil, mod:IsMagicDispeller())
local warnBloodRage						= mod:NewTargetAnnounce(151548, 4, nil, mod:IsMagicDispeller())
local warnSubjugate						= mod:NewTargetAnnounce(151697, 3, nil, mod:IsHealer())
local warnSlaversRage					= mod:NewTargetAnnounce(151965, 3, nil, mod:CanRemoveEnrage())

local specWarnCrush						= mod:NewSpecialWarningMove(151447, mod:IsTank())
local specWarnCinderSplash				= mod:NewSpecialWarningSpell(152298, nil, nil, nil, 2)
local specWarnRoar						= mod:NewSpecialWarningInterrupt(151545, not mod:IsHealer())--Maybe healer need warning too, if interrupt gets off, healer can't heal for 5 seconds
local specWarnLavaBurst					= mod:NewSpecialWarningInterrupt(151558, not mod:IsHealer())
local specWarnSuppressionField			= mod:NewSpecialWarningInterrupt(151581, not mod:IsHealer())--Maybe healer need warning too, if interrupt gets off, healer can't heal for 5 seconds
local specWarnStoneBulwark				= mod:NewSpecialWarningDispel(164597, mod:IsMagicDispeller())
local specWarnBloodRage					= mod:NewSpecialWarningDispel(151548, mod:IsMagicDispeller())
local specWarnSubjugate					= mod:NewSpecialWarningDispel(151697, mod:IsHealer())
local specWarnSlaversRage				= mod:NewSpecialWarningDispel(151965, mod:CanRemoveEnrage())

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 164597 and not args:IsDestTypePlayer() then
		warnStoneBulwark:Show(args.destName)
		specWarnStoneBulwark:Show(args.destName)
	elseif spellId == 151548 and not args:IsDestTypePlayer() then
		warnBloodRage:Show(args.destName)
		specWarnBloodRage:Show(args.destName)
	elseif spellId == 151697 then
		warnSubjugate:Show(args.destName)
		specWarnSubjugate:Show(args.destName)
	elseif spellId == 151965 then
		warnSlaversRage:Show(args.destName)
		specWarnSlaversRage:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled or self:IsDifficulty("normal5") then return end
	local spellId = args.spellId
	if spellId == 152298 then
		warnCinderSplash:Show()
		specWarnCinderSplash:Show()
	elseif spellId == 151447 then
		warnCrush:Show()
		specWarnCrush:Show()
	elseif spellId == 151545 then
		warnRoar:Show()
		specWarnRoar:Show(args.sourceName)
	elseif spellId == 151558 then
		warnLavaBurst:Show()
		specWarnLavaBurst:Show(args.sourceName)
	elseif spellId == 151581 then
		warnSuppressionField:Show()
		specWarnSuppressionField:Show(args.sourceName)
	end
end
