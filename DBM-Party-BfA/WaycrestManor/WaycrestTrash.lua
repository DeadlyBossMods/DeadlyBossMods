local mod	= DBM:NewMod("WaycrestTrash", "DBM-Party-BfA", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 263959 265881"
--	"SPELL_AURA_APPLIED",
--	"SPELL_CAST_SUCCESS"
)

--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnSoulVolley			= mod:NewSpecialWarningInterrupt(263959, "HasInterrupt", nil, nil, 1, 2)
local specWarnDecayingTouch			= mod:NewSpecialWarningSpell(265881, "Tank", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 263959 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSoulVolley:Show(args.sourceName)
		specWarnSoulVolley:Play("kickcast")
	elseif spellId == 265881 then
		specWarnDecayingTouch:Show()
		specWarnDecayingTouch:Play("defensive")
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
