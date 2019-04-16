local mod	= DBM:NewMod("AtalDazarTrash", "DBM-Party-BfA", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 255824 253562 255041 253544 253517 256849 252781",
	"SPELL_AURA_APPLIED 260666 255824 256849 252781 252687",
	"SPELL_CAST_SUCCESS 253583 253721"
)

local warnBulwarkofJuju				= mod:NewSpellAnnounce(253721, 2)

local specWarnVenomfangStrike		= mod:NewSpecialWarningDefensive(252687, nil, nil, nil, 1, 2)
local specWarnUnstableHexSelf		= mod:NewSpecialWarningMoveAway(252781, nil, nil, nil, 1, 2)
local yellUnstableHex				= mod:NewYell(252781)
local specWarnFanaticsRage			= mod:NewSpecialWarningInterrupt(255824, "HasInterrupt", nil, nil, 1, 2)
local specWarnWildFire				= mod:NewSpecialWarningInterrupt(253562, false, nil, 2, 1, 2)
local specWarnFieryEnchant			= mod:NewSpecialWarningInterrupt(253583, "HasInterrupt", nil, nil, 1, 2)
local specWarnTerrifyingScreech		= mod:NewSpecialWarningInterrupt(255041, "HasInterrupt", nil, nil, 1, 2)
local specWarnBwonsamdisMantle		= mod:NewSpecialWarningInterrupt(253544, "HasInterrupt", nil, nil, 1, 2)
local specWarnMendingWord			= mod:NewSpecialWarningInterrupt(253517, "HasInterrupt", nil, nil, 1, 2)
local specWarnDinoMight				= mod:NewSpecialWarningInterrupt(256849, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnstableHex			= mod:NewSpecialWarningInterrupt(252781, "HasInterrupt", nil, nil, 1, 2)
local specWarnTransfusion			= mod:NewSpecialWarningMoveTo(260666, nil, nil, nil, 3, 2)
local specWarnFanaticsRageDispel	= mod:NewSpecialWarningDispel(255824, "RemoveEnrage", nil, 2, 1, 2)
local specWarnDinoMightDispel		= mod:NewSpecialWarningDispel(256849, "MagicDispeller", nil, nil, 1, 2)
local specWarnVenomfangStrikeDispel	= mod:NewSpecialWarningDispel(252687, "RemovePoison", nil, nil, 1, 2)

local taintedBlood = DBM:GetSpellInfo(255558)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 255824 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFanaticsRage:Show(args.sourceName)
		specWarnFanaticsRage:Play("kickcast")
	elseif spellId == 253562 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWildFire:Show(args.sourceName)
		specWarnWildFire:Play("kickcast")
	elseif spellId == 255041 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTerrifyingScreech:Show(args.sourceName)
		specWarnTerrifyingScreech:Play("kickcast")
	elseif spellId == 253544 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBwonsamdisMantle:Show(args.sourceName)
		specWarnBwonsamdisMantle:Play("kickcast")
	elseif spellId == 253517 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMendingWord:Show(args.sourceName)
		specWarnMendingWord:Play("kickcast")
	elseif spellId == 256849 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDinoMight:Show(args.sourceName)
		specWarnDinoMight:Play("kickcast")
	elseif spellId == 252781 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnstableHex:Show(args.sourceName)
		specWarnUnstableHex:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 260666 and args:IsPlayer() then
		specWarnTransfusion:Show(taintedBlood)
		specWarnTransfusion:Play("takedamage")
	elseif spellId == 255824 then
		specWarnFanaticsRageDispel:Show(args.destName)
		specWarnFanaticsRageDispel:Play("helpdispel")
	elseif spellId == 256849 then
		specWarnDinoMightDispel:Show(args.destName)
		specWarnDinoMightDispel:Play("helpdispel")
	elseif spellId == 252781 and args:IsPlayer() then
		specWarnUnstableHexSelf:Show()
		specWarnUnstableHexSelf:Play("runout")
		yellUnstableHex:Yell()
	elseif spellId == 252687 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnVenomfangStrike:Show()
			specWarnVenomfangStrike:Play("defensive")
		elseif self:CheckDispelFilter() then
			specWarnVenomfangStrikeDispel:Show(args.destName)
			specWarnVenomfangStrikeDispel:Play("helpdispel")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 253583 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFieryEnchant:Show(args.sourceName)
		specWarnFieryEnchant:Play("kickcast")
	elseif spellId == 253721 and self:AntiSpam(3, 1) then
		warnBulwarkofJuju:Show()
	end
end
