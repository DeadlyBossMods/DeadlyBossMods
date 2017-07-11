local mod	= DBM:NewMod("AntorusTrash", "DBM-AntorusBurningTomb")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16034 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

--[[
mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnPolyMorphBomb				= mod:NewTargetAnnounce(240735, 3)

local specWarnPolyMorphBomb			= mod:NewSpecialWarningMoveAway(240735, nil, nil, nil, 1, 2)
local yellPolyMorphBomb				= mod:NewYell(240735)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(243171, "HasInterrupt", nil, nil, 1, 2)

local voicePolyMorphBomb			= mod:NewVoice(240735)--runout
local voiceShadowBoltVolley			= mod:NewVoice(243171, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 243171 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 241360 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240735 then
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]
