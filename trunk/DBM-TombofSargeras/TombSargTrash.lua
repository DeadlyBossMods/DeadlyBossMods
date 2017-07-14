local mod	= DBM:NewMod("TombSargTrash", "DBM-TombofSargeras")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 243171 239810 240169 242909",
	"SPELL_CAST_SUCCESS 241360",
	"SPELL_AURA_APPLIED 240735 241362 241171",
	"SPELL_PERIODIC_DAMAGE 240176",
	"SPELL_PERIODIC_MISSED 240176"
)

--TODO, add jellyfish Static something, forgot to log it and don't remember name
local warnPolyMorphBomb				= mod:NewTargetAnnounce(240735, 3)
local warnWateryGrave				= mod:NewTargetAnnounce(241171, 3)
local warnLunarBomb				= mod:NewTargetAnnounce(241362, 3)

local specWarnPolyMorphBomb			= mod:NewSpecialWarningMoveAway(240735, nil, nil, nil, 1, 2)
local yellPolyMorphBomb				= mod:NewYell(240735)
local specWarnLunarBomb				= mod:NewSpecialWarningMoveAway(241171, nil, nil, nil, 1, 2)
local yellLunarBomb					= mod:NewYell(241171)
local specWarnWateryGrave			= mod:NewSpecialWarningSwitch(241360, "-Healer", nil, nil, 1, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)
local specWarnSeverSoul				= mod:NewSpecialWarningRun(239810, "Melee", nil, nil, 4, 2)
local specWarnElectroShock			= mod:NewSpecialWarningRun(240169, "Melee", nil, nil, 4, 2)
local specWarnMassiveEruption		= mod:NewSpecialWarningRun(242909, "Melee", nil, nil, 4, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(240176, nil, nil, nil, 1, 2)

local voicePolyMorphBomb			= mod:NewVoice(240735)--runout
local voiceLunarBomb				= mod:NewVoice(241171)--runout
local voiceWateryGrave				= mod:NewVoice(241360, "-Healer")--helpme? maybe targetchange instead
local voiceShadowBoltVolley			= mod:NewVoice(243171, "HasInterrupt")--kickcast
local voiceSeverSoul				= mod:NewVoice(239810)--runout
local voiceElectroShock				= mod:NewVoice(240169)--runout
local voiceMassiveEruption			= mod:NewVoice(242909)--runout
local voiceGTFO						= mod:NewVoice(240176, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 243171 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	elseif spellId == 239810 and self:AntiSpam(3, 1) then
		specWarnSeverSoul:Show()
		voiceSeverSoul:Play("runout")
	elseif spellId == 240169 and self:AntiSpam(3, 2) then
		specWarnElectroShock:Show()
		voiceElectroShock:Play("runout")
	elseif spellId == 242909 and self:AntiSpam(3, 3) then
		specWarnMassiveEruption:Show()
		voiceMassiveEruption:Play("runout")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then
		specWarnWateryGrave:Show()
		voiceWateryGrave:Play("helpme")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240735 then
		if args:IsPlayer() then
			specWarnPolyMorphBomb:Show()
			voicePolyMorphBomb:Play("runout")
			yellPolyMorphBomb:Yell()
		else
			warnPolyMorphBomb:Show(args.destName)
		end
	elseif spellId == 241171 then
		warnLunarBomb:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnLunarBomb:Show()
			voiceLunarBomb:Play("runout")
			yellLunarBomb:Yell()
		end
	elseif spellId == 241362 then
		warnWateryGrave:CombinedShow(0.3, args.destName)--Multiple targets assumed
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--TODO, add more
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 240176) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
