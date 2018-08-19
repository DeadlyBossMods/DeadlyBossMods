local mod	= DBM:NewMod("FreeholdTrash", "DBM-Party-BfA", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 257732 257397 257899 257736 258777 257784 257756 274860",
	"SPELL_AURA_APPLIED 257274"
--	"SPELL_CAST_SUCCESS"
)

--local warnSoulEchoes					= mod:NewTargetAnnounce(194966, 2)

local specWarnHealingBalm				= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnPainfulMotivation			= mod:NewSpecialWarningInterrupt(257899, "HasInterrupt", nil, nil, 1, 2)
local specWarnThunderingSquall			= mod:NewSpecialWarningInterrupt(257736, "HasInterrupt", nil, nil, 1, 2)
local specWarnSeaSpout					= mod:NewSpecialWarningInterrupt(258779, "HasInterrupt", nil, nil, 1, 2)--258777 has no tooltip yet so using damage ID for now
local specWarnFrostBlast				= mod:NewSpecialWarningInterrupt(257784, "HasInterrupt", nil, nil, 1, 2)--Might prune or disable by default if it conflicts with higher priority interrupts in area
local specWarnShatteringBellow			= mod:NewSpecialWarningCast(257732, "SpellCaster", nil, nil, 1, 2)
local specWarnGoinBan					= mod:NewSpecialWarningRun(257756, "Melee", nil, nil, 4, 2)
local specWarnShatteringToss			= mod:NewSpecialWarningSpell(274860, "Tank", nil, nil, 3, 2)
--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingBalm:Show(args.sourceName)
		specWarnHealingBalm:Play("kickcast")
	elseif spellId == 257899 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPainfulMotivation:Show(args.sourceName)
		specWarnPainfulMotivation:Play("kickcast")
	elseif spellId == 257736 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnThunderingSquall:Show(args.sourceName)
		specWarnThunderingSquall:Play("kickcast")
	elseif spellId == 258777 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSeaSpout:Show(args.sourceName)
		specWarnSeaSpout:Play("kickcast")
	elseif spellId == 257784 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostBlast:Show(args.sourceName)
		specWarnFrostBlast:Play("kickcast")
	elseif spellId == 257732 and self:AntiSpam(3, 1) then
		specWarnShatteringBellow:Show()
		specWarnShatteringBellow:Play("stopcasting")
	elseif spellId == 257756 and self:AntiSpam(3, 3) then
		specWarnGoinBan:Show()
		specWarnGoinBan:Play("justrun")
	elseif spellId == 274860 and self:AntiSpam(3, 4) then
		specWarnShatteringToss:Show()
		specWarnShatteringToss:Play("carefly")--"toss coming" would be better but i can't remember media file
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257274 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
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
