local mod	= DBM:NewMod("VaultoftheIncarnatesTrash", "DBM-Raids-Dragonflight", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

--mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE 339528",
--	"SPELL_AURA_REMOVED 339525"
--)

--TODO, icon mark shared suffering? Maybe when they fix ENCOUNTER_START, for now I don't want to risk trash mod messing with a boss mods icon marking
--Lady's Trash, minus bottled anima, which will need a unit event to detect it looks like
--local warnConcentrateAnima					= mod:NewTargetNoFilterAnnounce(339525, 3)

--local specWarnConcentrateAnima				= mod:NewSpecialWarningMoveAway(310780, nil, nil, nil, 1, 2)
--local yellConcentrateAnima					= mod:NewYell(339525)
--local yellConcentrateAnimaFades				= mod:NewShortFadesYell(339525)
--local specWarnSharedSuffering				= mod:NewSpecialWarningYou(339607, nil, nil, nil, 1, 2)
--local specWarnDirgefromBelow				= mod:NewSpecialWarningInterrupt(310839, "HasInterrupt", nil, nil, 1, 2)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc
--[[
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
	if spellId == 339525 then

	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 339525 and args:IsPlayer() then

	end
end
--]]
