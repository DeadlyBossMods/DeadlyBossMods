local mod	= DBM:NewMod("WaycrestTrash", "DBM-Party-BfA", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 263959 265881 265876 265368 266036 278551 265759 264038 263905 265407 263961",
	"SPELL_AURA_APPLIED 265880 264105",
	"SPELL_AURA_REMOVED 265880 264105"
)

local specWarnSoulVolley			= mod:NewSpecialWarningInterrupt(263959, "HasInterrupt", nil, nil, 1, 2)
local specWarnRuinousVolley			= mod:NewSpecialWarningInterrupt(265876, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpiritedDefense		= mod:NewSpecialWarningInterrupt(265368, "HasInterrupt", nil, nil, 1, 2)
local specWarnDrainEssence			= mod:NewSpecialWarningInterrupt(266036, "HasInterrupt", nil, nil, 1, 2)
local specWarnSoulFetish			= mod:NewSpecialWarningInterrupt(278551, "HasInterrupt", nil, nil, 1, 2)
local specWarnDinnerBell			= mod:NewSpecialWarningInterrupt(265407, "HasInterrupt", nil, nil, 1, 2)
local specWarnDecayingTouch			= mod:NewSpecialWarningDefensive(265881, "Tank", nil, nil, 1, 2)
local specWarnSplinterSpike			= mod:NewSpecialWarningDodge(265759, nil, nil, nil, 2, 2)
local specWarnUproot				= mod:NewSpecialWarningDodge(264038, nil, nil, nil, 2, 2)
local specWarnMarkingCleave			= mod:NewSpecialWarningDodge(263905, "Tank", nil, 2, 1, 2)
local specWarnWardingCandle			= mod:NewSpecialWarningMove(263961, "Tank", nil, nil, 1, 2)
local specWarnDreadMark				= mod:NewSpecialWarningMoveAway(265880, nil, nil, nil, 1, 2)
local yellDreadMark					= mod:NewYell(265880)
local yellDreadMarkFades			= mod:NewShortFadesYell(265880)
local specWarnRunicMark				= mod:NewSpecialWarningMoveAway(264105, nil, nil, nil, 1, 2)
local yellRunicMark					= mod:NewYell(264105)
local yellRunicMarkFades			= mod:NewShortFadesYell(264105)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 263959 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSoulVolley:Show(args.sourceName)
		specWarnSoulVolley:Play("kickcast")
	elseif spellId == 265876 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRuinousVolley:Show(args.sourceName)
		specWarnRuinousVolley:Play("kickcast")
	elseif spellId == 265368 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSpiritedDefense:Show(args.sourceName)
		specWarnSpiritedDefense:Play("kickcast")
	elseif spellId == 266036 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDrainEssence:Show(args.sourceName)
		specWarnDrainEssence:Play("kickcast")
	elseif spellId == 278551 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSoulFetish:Show(args.sourceName)
		specWarnSoulFetish:Play("kickcast")
	elseif spellId == 265407 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDinnerBell:Show(args.sourceName)
		specWarnDinnerBell:Play("kickcast")
	elseif spellId == 265881 then
		specWarnDecayingTouch:Show()
		specWarnDecayingTouch:Play("defensive")
	elseif spellId == 265759 and self:AntiSpam(5, 1) then
		specWarnSplinterSpike:Show()
		specWarnSplinterSpike:Play("watchstep")
	elseif spellId == 264038 and self:AntiSpam(5, 1) then
		specWarnUproot:Show()
		specWarnUproot:Play("watchstep")
	elseif spellId == 263905 and self:AntiSpam(2.5, 2) then
		specWarnMarkingCleave:Show()
		specWarnMarkingCleave:Play("shockwave")
	elseif spellId == 263961 and self:AntiSpam(4, 3) then
		specWarnWardingCandle:Show()
		specWarnWardingCandle:Play("moveboss")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265880 and args:IsPlayer() then
		specWarnDreadMark:Show()
		specWarnDreadMark:Play("runout")
		yellDreadMark:Yell()
		yellDreadMarkFades:Countdown(6)
	elseif spellId == 264105 and args:IsPlayer() then
		specWarnRunicMark:Show()
		specWarnRunicMark:Play("runout")
		yellRunicMark:Yell()
		yellRunicMarkFades:Countdown(6)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265880 and args:IsPlayer() then
		yellDreadMarkFades:Cancel()
	elseif spellId == 264105 and args:IsPlayer() then
		yellRunicMarkFades:Cancel()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
