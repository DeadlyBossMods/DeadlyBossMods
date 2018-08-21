local mod	= DBM:NewMod("AtalDazarTrash", "DBM-Party-BfA", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 253562 255041",
	"SPELL_AURA_APPLIED 260666"
--	"SPELL_CAST_SUCCESS"
)

--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage			= mod:NewYell(200343)
--local specWarnWhirlOfFlame		= mod:NewSpecialWarningDodge(221634, nil, nil, nil, 2, 2)
local specWarnWildFire				= mod:NewSpecialWarningInterrupt(253562, "HasInterrupt", nil, nil, 1, 2)
local specWarnTerrifyingScreech		= mod:NewSpecialWarningInterrupt(255041, "HasInterrupt", nil, nil, 1, 2)
local specWarnTransfusion			= mod:NewSpecialWarningMoveTo(260666, nil, nil, nil, 3, 2)

local taintedBlood = DBM:GetSpellInfo(255558)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 253562 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWildFire:Show(args.sourceName)
		specWarnWildFire:Play("kickcast")
	elseif spellId == 255041 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTerrifyingScreech:Show(args.sourceName)
		specWarnTerrifyingScreech:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 260666 and args:IsPlayer() then
		specWarnTransfusion:Show(taintedBlood)
		specWarnTransfusion:Play("takedamage")
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
