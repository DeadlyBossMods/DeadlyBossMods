local mod	= DBM:NewMod("UnderrotTrash", "DBM-Party-BfA", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true


mod:RegisterEvents(
	"SPELL_CAST_START 272609 266106 265019 265089 265091 265433 265540 272183 278961 265523",
	"SPELL_AURA_APPLIED 265568 266107",
	"SPELL_CAST_SUCCESS 265523"
)

--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage			= mod:NewYell(200343)
local specWarnMaddeningGaze			= mod:NewSpecialWarningDodge(272609, nil, nil, nil, 2, 2)
local specWarnSavageCleave			= mod:NewSpecialWarningDodge(265019, nil, nil, nil, 2, 2)
local specWarnRottenBile			= mod:NewSpecialWarningDodge(265540, nil, nil, nil, 2, 2)
local specWarnDarkOmen				= mod:NewSpecialWarningMoveAway(265568, nil, nil, nil, 1, 2)
local specWarnThirstforBlood		= mod:NewSpecialWarningRun(266107, nil, nil, nil, 4, 2)
local specWarnSonicScreech			= mod:NewSpecialWarningInterrupt(266106, "HasInterrupt", nil, nil, 1, 2)
local specWarnDarkReconstituion		= mod:NewSpecialWarningInterrupt(265089, "HasInterrupt", nil, nil, 1, 2)
local specWarnGiftofGhuun			= mod:NewSpecialWarningInterrupt(265091, "HasInterrupt", nil, nil, 1, 2)
local specWarnWitheringCurse		= mod:NewSpecialWarningInterrupt(265433, "HasInterrupt", nil, nil, 1, 2)
local specWarnRaiseDead				= mod:NewSpecialWarningInterrupt(272183, "HasInterrupt", nil, nil, 1, 2)
local specWarnDecayingMind			= mod:NewSpecialWarningInterrupt(278961, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpiritDrainTotem		= mod:NewSpecialWarningInterrupt(265523, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpiritDrainTotemKill	= mod:NewSpecialWarningDodge(265523, nil, nil, nil, 2, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 272609 and self:AntiSpam(2.5, 1) then
		specWarnMaddeningGaze:Show()
		specWarnMaddeningGaze:Play("shockwave")
	elseif spellId == 265019 and self:AntiSpam(2.5, 1) then
		specWarnSavageCleave:Show()
		specWarnSavageCleave:Play("shockwave")
	elseif spellId == 265540 and self:AntiSpam(2.5, 1) then
		specWarnRottenBile:Show()
		specWarnRottenBile:Play("shockwave")
	elseif spellId == 266106 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSonicScreech:Show(args.sourceName)
		specWarnSonicScreech:Play("kickcast")
	elseif spellId == 265089 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDarkReconstituion:Show(args.sourceName)
		specWarnDarkReconstituion:Play("kickcast")
	elseif spellId == 265091 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGiftofGhuun:Show(args.sourceName)
		specWarnGiftofGhuun:Play("kickcast")
	elseif spellId == 265433 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWitheringCurse:Show(args.sourceName)
		specWarnWitheringCurse:Play("kickcast")
	elseif spellId == 272183 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRaiseDead:Show(args.sourceName)
		specWarnRaiseDead:Play("kickcast")
	elseif spellId == 278961 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDecayingMind:Show(args.sourceName)
		specWarnDecayingMind:Play("kickcast")
	elseif spellId == 265523 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSpiritDrainTotem:Show(args.sourceName)
		specWarnSpiritDrainTotem:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265568 and args:IsPlayer() then
		specWarnDarkOmen:Show()
		specWarnDarkOmen:Play("range5")
	elseif spellId == 266107 and args:IsPlayer() then
		specWarnThirstforBlood:Show()
		specWarnThirstforBlood:Play("justrun")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265523 then
		specWarnSpiritDrainTotemKill:Show()
		specWarnSpiritDrainTotemKill:Play("watchstep")
	end
end
