local mod	= DBM:NewMod("NecroticWakeTrash", "DBM-Party-Shadowlands", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 324293 327240 327399 334748 320462 338353 323496",
	"SPELL_AURA_APPLIED 327401 323347 335141 324372 338353 338357",
	"SPELL_AURA_APPLIED_DOSE 338357",
	"SPELL_AURA_REMOVED 327401"
)

--TODO targetscan shared agony during cast and get at least one of targets early? for fade/invis and feign death?
--TODO, actually, does shared agony even still exist? it's not in any recent logs
--https://www.wowhead.com/guides/necrotic-wake-shadowlands-dungeon-strategy-guide
--Notable Blightbone Trash
local warnClingingDarkness					= mod:NewTargetNoFilterAnnounce(323347, 3, nil, "Healer|RemoveMagic")
--Notable Amarth Trash
local warnSharedAgony						= mod:NewCastAnnounce(327401, 3)
local warnSharedAgonyTargets				= mod:NewTargetAnnounce(327401, 4)
local warnTenderize							= mod:NewStackAnnounce(338357, 2, nil, "Tank|Healer")
local warnThrowCleaver						= mod:NewCastAnnounce(323496, 2)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Blightbone Trash
local specWarnClingingDarkness				= mod:NewSpecialWarningDispel(323347, false, nil, nil, 1, 2)--Opt it for now, since dispel timing is less black and white
local specWarnDrainFluids					= mod:NewSpecialWarningInterrupt(334748, "HasInterrupt", nil, nil, 1, 2)
--Notable Amarth Trash
local specWarnNecroticBolt					= mod:NewSpecialWarningInterrupt(320462, "HasInterrupt", nil, nil, 1, 2)
local specWarnRaspingScream					= mod:NewSpecialWarningInterrupt(324293, "HasInterrupt", nil, nil, 1, 2)
local specWarnSharedAgony					= mod:NewSpecialWarningMoveAway(327401, nil, nil, nil, 1, 11)
local yellSharedAgony						= mod:NewYell(327401)
local specWarnDarkShroud					= mod:NewSpecialWarningDispel(335141, "MagicDispeller", nil, nil, 1, 2)
local specWarnReapingWinds					= mod:NewSpecialWarningRun(324372, nil, nil, nil, 4, 2)
--Notable Surgeon Stitchflesh Trash
local specWarnGoresplatter					= mod:NewSpecialWarningInterrupt(338353, false, nil, nil, 1, 2)--Off by default since enemy has two casts and this is lower priority one
local specWarnGoresplatterDispel			= mod:NewSpecialWarningDispel(338353, "RemoveDisease", nil, nil, 1, 2)
--Unknown
local specWarnSpineCrush					= mod:NewSpecialWarningDodge(327240, nil, nil, nil, 2, 2)--Not sure where these spawn, not in guide, but I still feel warning worth having

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 324293 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRaspingScream:Show(args.sourceName)
		specWarnRaspingScream:Play("kickcast")
	elseif spellId == 334748 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDrainFluids:Show(args.sourceName)
		specWarnDrainFluids:Play("kickcast")
	elseif spellId == 320462 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNecroticBolt:Show(args.sourceName)
		specWarnNecroticBolt:Play("kickcast")
	elseif spellId == 338353 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGoresplatter:Show(args.sourceName)
		specWarnGoresplatter:Play("kickcast")
	elseif spellId == 327240 and self:AntiSpam(3, 2) then
		specWarnSpineCrush:Show()
		specWarnSpineCrush:Play("watchstep")
	elseif spellId == 327399 and self:AntiSpam(3, 6) then
		warnSharedAgony:Show()
	elseif spellId == 323496 and self:AntiSpam(3, 6) then
		warnThrowCleaver:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 327401 then
		warnSharedAgonyTargets:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSharedAgony:Show()
			specWarnSharedAgony:Play("lineapart")
			yellSharedAgony:Yell()
		end
	elseif spellId == 323347 and args:IsDestTypePlayer() and self:AntiSpam(3, 5) then
		if self.Options.SpecWarn323347dispel and  self:CheckDispelFilter() then
			specWarnClingingDarkness:Show(args.destName)
			specWarnClingingDarkness:Play("helpdispel")
		else
			warnClingingDarkness:Show(args.destName)
		end
	elseif spellId == 335141 and args:IsDestTypeHostile() then--Not filtered with self:AntiSpam(3, 5) for now
		specWarnDarkShroud:Show(args.destName)
		specWarnDarkShroud:Play("dispelboss")
	elseif spellId == 324372 then
		specWarnReapingWinds:Show()
		specWarnReapingWinds:Play("justrun")
	elseif spellId == 338353 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnGoresplatterDispel:Show(args.destName)
		specWarnGoresplatterDispel:Play("helpdispel")
	elseif spellId == 340288 and args:IsDestTypePlayer() then
		local amount = args.amount or 1
		if amount >= 2 then
			warnTenderize:Show(args.destName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
