local mod	= DBM:NewMod(2139, "DBM-Zandalar", nil, 1029)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(132701)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 262004 261600 261552",
	"SPELL_CAST_SUCCESS 262004 261605",
	"SPELL_AURA_APPLIED 261605",
	"SPELL_AURA_REMOVED 261605"
)

local warnConsumingSpirits			= mod:NewTargetAnnounce(261605, 3)

local specWarnCrushingSlam			= mod:NewSpecialWarningDefensive(262004, nil, nil, nil, 1, 2)
local specWarnCrushingSlamOther		= mod:NewSpecialWarningTaunt(262004, nil, nil, nil, 1, 2)
local specWarnCoalescedEssence		= mod:NewSpecialWarningDodge(261600, nil, nil, nil, 2, 2)
local specWarnConsumingSpirits		= mod:NewSpecialWarningMoveAway(261605, nil, nil, nil, 1, 2)
local yellConsumingSpirits			= mod:NewYell(261605)
local specWarnTerrorWall			= mod:NewSpecialWarningDodge(261552, nil, nil, nil, 3, 2)

--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerCrushingSlamCD			= mod:NewAITimer(16, 262004, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCoalescedEssenceCD		= mod:NewAITimer(16, 261600, nil, nil, nil, 3)
local timerConsumingSpiritsCD		= mod:NewAITimer(16, 261605, nil, nil, nil, 3)
local timerTerrorWallCD				= mod:NewAITimer(16, 261552, nil, nil, nil, 3)

mod:AddRangeFrameOption(8, 261605)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 262004 then
		timerCrushingSlamCD:Start()
		if UnitExists("target") then
			local tanking, status = UnitDetailedThreatSituation("player", "target")
			if tanking or (status == 3) then--Player is current target
				specWarnCrushingSlam:Show()
				specWarnCrushingSlam:Play("defensive")
			end
		end
	elseif spellId == 261600 then
		specWarnCoalescedEssence:Show()
		specWarnCoalescedEssence:Play("watchorb")
		timerCoalescedEssenceCD:Start()
	elseif spellId == 261552 then
		specWarnTerrorWall:Show()
		specWarnTerrorWall:Play("shockwave")
		timerTerrorWallCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 262004 then
		if args.destName and not args:IsPlayer() then
			specWarnCrushingSlamOther:Show(args.destName)
			specWarnCrushingSlamOther:Play("tauntboss")
		end
	elseif spellId == 261605 then
		timerConsumingSpiritsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 261605 then
		warnConsumingSpirits:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnConsumingSpirits:Show()
			specWarnConsumingSpirits:Play("runout")
			yellConsumingSpirits:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 261605 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
	end
end
--]]
