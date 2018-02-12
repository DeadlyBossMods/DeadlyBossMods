local mod	= DBM:NewMod("FreeholdTrash", "DBM-Party-BfA", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 257732 257397 257899 257736 258777 257784"
--	"SPELL_AURA_APPLIED",
--	"SPELL_CAST_SUCCESS"
)

--local warnSoulEchoes					= mod:NewTargetAnnounce(194966, 2)

local specWarnHealingBalm				= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnPainfulMotivation			= mod:NewSpecialWarningInterrupt(257899, "HasInterrupt", nil, nil, 1, 2)
local specWarnThunderingSquall			= mod:NewSpecialWarningInterrupt(257736, "HasInterrupt", nil, nil, 1, 2)
local specWarnSeaSpout					= mod:NewSpecialWarningInterrupt(258779, "HasInterrupt", nil, nil, 1, 2)--258777 has no tooltip yet so using damage ID for now
local specWarnFrostBlast				= mod:NewSpecialWarningInterrupt(257784, "HasInterrupt", nil, nil, 1, 2)--Might prune or disable by default if it conflicts with higher priority interrupts in area
local specWarnShatteringBellow			= mod:NewSpecialWarningCast(257732, "SpellCaster", nil, nil, 1, 2)
--local yellArrowBarrage				= mod:NewYell(200343)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnHealingBalm:Show()
		specWarnHealingBalm:Play("kickcast")
	elseif spellId == 257899 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnPainfulMotivation:Show()
		specWarnPainfulMotivation:Play("kickcast")
	elseif spellId == 257736 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnThunderingSquall:Show()
		specWarnThunderingSquall:Play("kickcast")
	elseif spellId == 258777 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnSeaSpout:Show()
		specWarnSeaSpout:Play("kickcast")
	elseif spellId == 257784 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFrostBlast:Show()
		specWarnFrostBlast:Play("kickcast")
	elseif spellId == 257732 then
		specWarnShatteringBellow:Show()
		specWarnShatteringBellow:Play("stopcasting")
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
