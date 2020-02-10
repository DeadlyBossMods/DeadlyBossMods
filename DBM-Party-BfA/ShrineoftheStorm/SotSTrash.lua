local mod	= DBM:NewMod("SotSTrash", "DBM-Party-BfA", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 268030 267973 268391 268239 268309 276268 267977 268050 268027 274437 268184 276292 268211 268273 268322 268317 268375 276767",
	"SPELL_AURA_APPLIED 268375 268322 268214 276297 276767 274631",
	"SPELL_AURA_REMOVED 276297"
)

--TODO, Colossal Slam-268348? START
--TODO, Tempest-274437-npc:139800 target scan (START)?
--Find slicing hurricane
local warnCarvedFlesh				= mod:NewTargetAnnounce(268214, 2)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnRisingTides			= mod:NewSpecialWarningSpell(268027, nil, nil, nil, 2, 2)
local specWarnShipbreakerStorm		= mod:NewSpecialWarningSpell(268239, nil, nil, nil, 2, 2)--Can be interrupted by stuns, but not interrupts
local specWarnWashAway				= mod:NewSpecialWarningDodge(267973, nil, nil, nil, 2, 2)
local specWarnDeepSmash				= mod:NewSpecialWarningDodge(268273, nil, nil, nil, 2, 2)
local specWarnWhirlingSlam			= mod:NewSpecialWarningDodge(276292, nil, nil, nil, 4, 2)
local specWarnMentalAssault			= mod:NewSpecialWarningDodge(268391, "Tank", nil, 2, 1, 2)
local specWarnHeavingBlow			= mod:NewSpecialWarningDodge(276268, "Tank", nil, nil, 1, 2)
local specWarnBlessingofIrontides	= mod:NewSpecialWarningRun(274631, "Tank", nil, nil, 1, 2)
local specWarnMinorSwiftness		= mod:NewSpecialWarningMove(268184, "Tank", nil, nil, 1, 2)
local specWarnMinorReinforcement	= mod:NewSpecialWarningMove(268211, "Tank", nil, nil, 1, 2)
local specWarnAnchorofBinding		= mod:NewSpecialWarningInterrupt(268050, false, nil, nil, 1, 2)--Off by default, should only be interrupted if group has enough for this and mending and purging swiftness
local specWarnMendingRapids			= mod:NewSpecialWarningInterrupt(268030, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnendingDarkness		= mod:NewSpecialWarningInterrupt(268309, "HasInterrupt", nil, nil, 1, 2)
local specWarnTidalSurge			= mod:NewSpecialWarningInterrupt(267977, "HasInterrupt", nil, nil, 1, 2)
local specWarnTempest				= mod:NewSpecialWarningInterrupt(274437, "HasInterrupt", nil, nil, 1, 2)
local specWarnRipMind				= mod:NewSpecialWarningInterrupt(268317, "Tank", nil, nil, 1, 2)--Let tank handle this interrupt
local specWarnTouchofDrownedKick	= mod:NewSpecialWarningInterrupt(268322, "HasInterrupt", nil, nil, 1, 2)--Let everyone else get this one (or healers can dispel it)
local specWarnDetectThoughtsKick	= mod:NewSpecialWarningInterrupt(268375, "HasInterrupt", nil, nil, 1, 2)
local specWarnConsumingVoidKick		= mod:NewSpecialWarningInterrupt(276767, "HasInterrupt", nil, nil, 1, 2)
local specWarnDetectThoughts		= mod:NewSpecialWarningDispel(268375, "MagicDispeller", nil, nil, 1, 2)
local specWarnConsumingVoid			= mod:NewSpecialWarningDispel(276767, "MagicDispeller", nil, nil, 1, 2)
local specWarnTouchofDrowned		= mod:NewSpecialWarningDispel(268322, "Healer", nil, nil, 1, 2)
local specWarnConsumingVoidStop		= mod:NewSpecialWarningReflect(276767, "CasterDps", nil, nil, 1, 2)
local specWarnCarveFlesh			= mod:NewSpecialWarningMoveTo(268214, nil, nil, nil, 3, 2)
local specWarnVoidSeed				= mod:NewSpecialWarningMoveAway(276297, nil, nil, nil, 1, 2)
local yellVoidSeed					= mod:NewShortFadesYell(276297)

local MinorReinforcement = DBM:GetSpellInfo(268211)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268030 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMendingRapids:Show(args.sourceName)
		specWarnMendingRapids:Play("kickcast")
	elseif spellId == 268309 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnendingDarkness:Show(args.sourceName)
		specWarnUnendingDarkness:Play("kickcast")
	elseif spellId == 267973 and self:AntiSpam(5, 1) then
		specWarnWashAway:Show()
		specWarnWashAway:Play("watchstep")
	elseif spellId == 268391 and self:AntiSpam(2.5, 2) then
		specWarnMentalAssault:Show()
		specWarnMentalAssault:Play("shockwave")
	elseif spellId == 268239 and self:AntiSpam(5, 4) then
		specWarnShipbreakerStorm:Show()
		specWarnShipbreakerStorm:Play("aesoon")
	elseif spellId == 276268 and self:AntiSpam(2.5, 2) then
		specWarnHeavingBlow:Show()
		specWarnHeavingBlow:Play("shockwave")
	elseif spellId == 267977 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTidalSurge:Show(args.sourceName)
		specWarnTidalSurge:Play("kickcast")
	elseif spellId == 268050 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAnchorofBinding:Show(args.sourceName)
		specWarnAnchorofBinding:Play("kickcast")
	elseif spellId == 268027 and self:AntiSpam(4, 6) then
		specWarnRisingTides:Show()
		specWarnRisingTides:Play("aesoon")
	elseif spellId == 274437 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTempest:Show(args.sourceName)
		specWarnTempest:Play("kickcast")
	elseif spellId == 268184 and self:AntiSpam(4, 7) then
		specWarnMinorSwiftness:Show()
		specWarnMinorSwiftness:Play("moveboss")
	elseif spellId == 276292 and self:AntiSpam(5, 8) then
		specWarnWhirlingSlam:Show()
		specWarnWhirlingSlam:Play("justrun")
	elseif spellId == 268211 and self:AntiSpam(4, 10) then
		specWarnMinorReinforcement:Show()
		specWarnMinorReinforcement:Play("moveboss")
	elseif spellId == 268273 and self:AntiSpam(4, 1) then
		specWarnDeepSmash:Show()
		specWarnDeepSmash:Play("watchstep")
	elseif spellId == 268322 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTouchofDrownedKick:Show(args.sourceName)
		specWarnTouchofDrownedKick:Play("kickcast")
	elseif spellId == 268317 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRipMind:Show(args.sourceName)
		specWarnRipMind:Play("kickcast")
	elseif spellId == 268375 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDetectThoughtsKick:Show(args.sourceName)
		specWarnDetectThoughtsKick:Play("kickcast")
	elseif spellId == 276767 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnConsumingVoidKick:Show(args.sourceName)
		specWarnConsumingVoidKick:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268375 and self:AntiSpam(2, 12) then
		specWarnDetectThoughts:Show(args.destName)
		specWarnDetectThoughts:Play("helpdispel")
	elseif spellId == 276767 and self:AntiSpam(2, 13) then
		if self.Options.SpecWarn276767dispel then
			specWarnConsumingVoid:Show(args.destName)
			specWarnConsumingVoid:Play("helpdispel")
		else
			specWarnConsumingVoidStop:Show(args.destName)
			specWarnConsumingVoidStop:Play("stopattack")
		end
	elseif spellId == 268322 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(2, 3) then
		specWarnTouchofDrowned:Show(args.destName)
		specWarnTouchofDrowned:Play("helpdispel")
	elseif spellId == 268214 then
		if args:IsPlayer() then
			specWarnCarveFlesh:Show(MinorReinforcement)
			specWarnCarveFlesh:Play("targetyou")
		else
			warnCarvedFlesh:Show(args.destName)
		end
	elseif spellId == 276297 then
		if args:IsPlayer() then
			specWarnVoidSeed:Schedule(8)
			specWarnVoidSeed:ScheduleVoice(8, "runout")
			yellVoidSeed:Countdown(12)
		end
	elseif spellId == 274631 and self:AntiSpam(4, 9) then
		specWarnBlessingofIrontides:Show()
		specWarnBlessingofIrontides:Play("justrun")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 276297 then
		if args:IsPlayer() then
			specWarnVoidSeed:Cancel()
			specWarnVoidSeed:CancelVoice()
			yellVoidSeed:Cancel()
		end
	end
end
