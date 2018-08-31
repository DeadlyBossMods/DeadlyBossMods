local mod	= DBM:NewMod("SethralissTrash", "DBM-Party-BfA", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 265968 272657"
--	"SPELL_AURA_APPLIED",
--	"SPELL_CAST_SUCCESS"
)

--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage			= mod:NewYell(200343)
local specWarnNoxiousBreath			= mod:NewSpecialWarningDodge(272657, "Tank", nil, nil, 1, 2)
local specWarnHealingSurge			= mod:NewSpecialWarningInterrupt(265968, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 265968 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingSurge:Show(args.sourceName)
		specWarnHealingSurge:Play("kickcast")
	elseif spellId == 272657 and self:AntiSpam(2.5, 1) then
		specWarnNoxiousBreath:Show()
		specWarnNoxiousBreath:Play("shockwave")
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
