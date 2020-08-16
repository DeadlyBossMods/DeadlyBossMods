local mod	= DBM:NewMod("CastleNathriaTrash", "DBM-CastleNathria", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED 339525 339607 339528",
	"SPELL_AURA_APPLIED_DOSE 339528",
	"SPELL_AURA_REMOVED 339525"
)

--TODO, icon mark shared suffering? Maybe when they fix ENCOUNTER_START, for now I don't want to risk trash mod messing with a boss mods icon marking
--Lady's Trash, minus bottled anima, which will need a unit event to detect it looks like
local warnConcentrateAnima					= mod:NewTargetNoFilterAnnounce(339525, 3)
local warnSharedSuffering					= mod:NewTargetNoFilterAnnounce(339607, 3)
local warnWarpedDesires						= mod:NewStackAnnounce(339528, 2, nil, "Tank|Healer")

local specWarnConcentrateAnima				= mod:NewSpecialWarningMoveAway(310780, nil, nil, nil, 1, 2)
local yellConcentrateAnima					= mod:NewYell(339525)
local yellConcentrateAnimaFades				= mod:NewShortFadesYell(339525)
local specWarnSharedSuffering				= mod:NewSpecialWarningYou(339607, nil, nil, nil, 1, 2)
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
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 339525 then
		if args:IsPlayer() then
			specWarnConcentrateAnima:Show()
			specWarnConcentrateAnima:Play("runout")
			yellConcentrateAnima:Yell()
			yellConcentrateAnimaFades:Countdown(spellId)
		else
			warnConcentrateAnima:Show(args.destName)
		end
	elseif spellId == 339607 then
		warnSharedSuffering:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSharedSuffering:Show()
			specWarnSharedSuffering:Play("targetyou")
		end
	elseif spellId == 339528 then
		local amount = args.amount or 1
		warnWarpedDesires:Show(args.destName, amount)
		--TODO, swaps?
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 339525 and args:IsPlayer() then
		yellConcentrateAnimaFades:Cancel()
	end
end
