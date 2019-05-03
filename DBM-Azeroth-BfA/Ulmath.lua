local mod	= DBM:NewMod(2362, "DBM-Azeroth-BfA", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152697)
mod:SetEncounterID(2317)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

--local warnConsumingSpirits			= mod:NewTargetAnnounce(261605, 3)

--local specWarnCrushingSlam			= mod:NewSpecialWarningDefensive(262004, nil, nil, nil, 1, 2)
--local yellConsumingSpirits			= mod:NewYell(261605)
--local specWarnTerrorWall			= mod:NewSpecialWarningDodge(261552, nil, nil, nil, 3, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--local timerCrushingSlamCD			= mod:NewCDTimer(23.2, 262004, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--24.8-31?
--local timerCoalescedEssenceCD		= mod:NewCDTimer(23.6, 261600, nil, nil, nil, 3)--25-28?

--mod:AddRangeFrameOption(8, 261605)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 262004 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 262004 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 261605 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 261605 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
