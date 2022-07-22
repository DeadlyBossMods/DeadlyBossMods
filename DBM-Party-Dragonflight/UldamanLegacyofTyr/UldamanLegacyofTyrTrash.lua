local mod	= DBM:NewMod("UldamanLegacyofTyrTrash", "DBM-Party-Dragonflight", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 369811 382578 369674 369823",--381593
	"SPELL_AURA_APPLIED 369365"
--	"SPELL_AURA_APPLIED_DOSE 339528",
--	"SPELL_AURA_REMOVED 339525"
)

--TODO, icon mark shared suffering? Maybe when they fix ENCOUNTER_START, for now I don't want to risk trash mod messing with a boss mods icon marking
--Lady's Trash, minus bottled anima, which will need a unit event to detect it looks like
local warnBlessingofTyr						= mod:NewCastAnnounce(382578, 4)

local specWarnBrutalSlam					= mod:NewSpecialWarningMoveAway(369811, nil, nil, nil, 2, 2)
--local specWarnThunderousClap				= mod:NewSpecialWarningMoveAway(381593, nil, nil, nil, 2, 2)--Iffy, not sure if dodgable
local specWarnCurseofStone					= mod:NewSpecialWarningDispel(369365, "RemoveCurse", nil, nil, 1, 2)
--local yellConcentrateAnima					= mod:NewYell(339525)
--local yellConcentrateAnimaFades				= mod:NewShortFadesYell(339525)
--local specWarnSharedSuffering				= mod:NewSpecialWarningYou(339607, nil, nil, nil, 1, 2)
local specWarnStoneSpike					= mod:NewSpecialWarningInterrupt(369674, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpikedCarapace				= mod:NewSpecialWarningInterrupt(369823, "HasInterrupt", nil, nil, 1, 2)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 369811 and self:AntiSpam(5, 2) then
		specWarnBrutalSlam:Show()
		specWarnBrutalSlam:Play("watchstep")
--	elseif spellId == 381593 and self:AntiSpam(5, 2) then
--		specWarnThunderousClap:Show()
--		specWarnThunderousClap:Play("watchstep")
	elseif spellId == 382578 and self:AntiSpam(3, 5) then
		warnBlessingofTyr:Show()
	elseif spellId == 369674 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStoneSpike:Show(args.sourceName)
		specWarnStoneSpike:Play("kickcast")
	elseif spellId == 369823 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSpikedCarapace:Show(args.sourceName)
		specWarnSpikedCarapace:Play("kickcast")
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 369365 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnCurseofStone:Show(args.destName)
		specWarnCurseofStone:Play("helpdispel")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 339525 and args:IsPlayer() then

	end
end
--]]
