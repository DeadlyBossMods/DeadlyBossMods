local mod	= DBM:NewMod("UndermineTrash", "DBM-Party-BfA", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 268709 268129 263275 267433 263103 263066 268865 268797 269090 262540 262554 262092 263202",
	"SPELL_AURA_APPLIED 268702 262947 262540 262092",
	"SPELL_CAST_SUCCESS 280604 262515"
)

local warnActivateMech				= mod:NewCastAnnounce(267433, 4)
local warnRepair					= mod:NewCastAnnounce(262554, 4)
local warnAzeriteHeartseeker		= mod:NewTargetNoFilterAnnounce(262515, 3)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnCover					= mod:NewSpecialWarningMove(263275, "Tank", nil, nil, 1, 2)
local specWarnEarthShield			= mod:NewSpecialWarningInterrupt(268709, "HasInterrupt", nil, nil, 1, 2)
local specWarnRockLance				= mod:NewSpecialWarningInterrupt(263202, false, nil, nil, 1, 2)
local specWarnIcedSpritzer			= mod:NewSpecialWarningInterrupt(280604, "HasInterrupt", nil, nil, 1, 2)
local specWarnCola					= mod:NewSpecialWarningInterrupt(268129, "HasInterrupt", nil, nil, 1, 2)
local specWarnFuriousQuake			= mod:NewSpecialWarningInterrupt(268702, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlowtorch				= mod:NewSpecialWarningInterrupt(263103, "HasInterrupt", nil, nil, 1, 2)
local specWarnTransSyrum			= mod:NewSpecialWarningInterrupt(263066, "HasInterrupt", nil, nil, 1, 2)
local specWarnEnemyToGoo			= mod:NewSpecialWarningInterrupt(268797, "HasInterrupt", nil, nil, 1, 2)
local specWarnArtilleryBarrage		= mod:NewSpecialWarningInterrupt(269090, "HasInterrupt", nil, nil, 1, 2)
local specWarnOvercharge			= mod:NewSpecialWarningInterrupt(262540, "HasInterrupt", nil, nil, 1, 2)
local specWarnInhaleVapors			= mod:NewSpecialWarningInterrupt(262092, "HasInterrupt", nil, nil, 1, 2)
local specWarnForceCannon			= mod:NewSpecialWarningDodge(268865, nil, nil, nil, 2, 2)
local specWarnAzeriteInjection		= mod:NewSpecialWarningDispel(262947, "MagicDispeller", nil, nil, 1, 2)
local specWarnOverchargeDispel		= mod:NewSpecialWarningDispel(262540, "MagicDispeller", nil, nil, 1, 2)
local specWarnInhaleVaporsDispel	= mod:NewSpecialWarningDispel(262092, "RemoveEnrage", nil, 2, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268709 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEarthShield:Show(args.sourceName)
		specWarnEarthShield:Play("kickcast")
	elseif spellId == 268129 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCola:Show(args.sourceName)
		specWarnCola:Play("kickcast")
	elseif spellId == 263103 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBlowtorch:Show(args.sourceName)
		specWarnBlowtorch:Play("kickcast")
	elseif spellId == 263066 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTransSyrum:Show(args.sourceName)
		specWarnTransSyrum:Play("kickcast")
	elseif spellId == 268797 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEnemyToGoo:Show(args.sourceName)
		specWarnEnemyToGoo:Play("kickcast")
	elseif spellId == 269090 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnArtilleryBarrage:Show(args.sourceName)
		specWarnArtilleryBarrage:Play("kickcast")
	elseif spellId == 262540 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnOvercharge:Show(args.sourceName)
		specWarnOvercharge:Play("kickcast")
	elseif spellId == 262092 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnInhaleVapors:Show(args.sourceName)
		specWarnInhaleVapors:Play("kickcast")
	elseif spellId == 263202 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRockLance:Show(args.sourceName)
		specWarnRockLance:Play("kickcast")
	elseif spellId == 263275 and self:IsValidWarning(args.sourceGUID) then
		specWarnCover:Show()
		specWarnCover:Play("moveboss")
	elseif spellId == 267433 and self:AntiSpam(4, 1) then--IsValidWarning removed because it caused most activate mechs not to announce. re-add if it becomes problem
		warnActivateMech:Show()
	elseif spellId == 262554 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 2) then
		warnRepair:Show()
	elseif spellId == 268865 and self:IsValidWarning(args.sourceGUID) and self:AntiSpam(4, 3) then
		specWarnForceCannon:Show()
		specWarnForceCannon:Play("shockwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268702 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFuriousQuake:Show(args.sourceName)
		specWarnFuriousQuake:Play("kickcast")
	elseif spellId == 262947 and not args:IsDestTypePlayer() and self:AntiSpam(3, 4) then
		specWarnAzeriteInjection:Show(args.destName)
		specWarnAzeriteInjection:Play("helpdispel")
	elseif spellId == 262540 and not args:IsDestTypePlayer() and self:AntiSpam(3, 4) then
		specWarnOverchargeDispel:Show(args.destName)
		specWarnOverchargeDispel:Play("helpdispel")
	elseif spellId == 262092 and not args:IsDestTypePlayer() and self:AntiSpam(3, 4) then
		specWarnInhaleVaporsDispel:Show(args.destName)
		specWarnInhaleVaporsDispel:Play("helpdispel")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 280604 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnIcedSpritzer:Show(args.sourceName)
		specWarnIcedSpritzer:Play("kickcast")
	elseif spellId == 262515 then
		warnAzeriteHeartseeker:CombinedShow(0.5, args.destName)
	end
end
