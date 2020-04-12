local mod	= DBM:NewMod("CastleNathriaTrash", "DBM-CastleNathria", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

--local warnPsychicDetonation					= mod:NewTargetNoFilterAnnounce(316623, 3)

--local specWarnShadowSmash					= mod:NewSpecialWarningDodge(310780, nil, nil, nil, 2, 2)
--local yellPsychicDetonation					= mod:NewYell(316623)
--local yellPsychicDetonationFades			= mod:NewShortFadesYell(316623)
--local specWarnDirgefromBelow				= mod:NewSpecialWarningInterrupt(310839, "HasInterrupt", nil, nil, 1, 2)

--local playerName = UnitName("player")

--[[
--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 310780 and self:AntiSpam(5, 2) then

	elseif spellId == 310839 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDirgefromBelow:Show(args.sourceName)
		specWarnDirgefromBelow:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 316623 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 316623 and args:IsPlayer() then

	end
end
--]]
