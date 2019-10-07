local mod	= DBM:NewMod(2367, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(152128)
mod:SetEncounterID(2335)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnDesensitizingSting				= mod:NewStackAnnounce(298156, 2, nil, "Tank")
--local warnIncubationFluid					= mod:NewTargetNoFilterAnnounce(298306, 2)
--local warnCallofTender					= mod:NewCountAnnounce(305057, 2)

--local specWarnDesensitizingSting			= mod:NewSpecialWarningStack(298156, nil, 9, nil, nil, 1, 6)
--local specWarnIncubationFluid				= mod:NewSpecialWarningMoveAway(298306, nil, nil, nil, 1, 2)
--local yellArcingCurrent					= mod:NewYell(295825)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--local specWarnConductivePulse				= mod:NewSpecialWarningInterrupt(295822, "HasInterrupt", nil, nil, 3, 2)

--mod:AddTimerLine(BOSS)
--local timerTankCD							= mod:NewAITimer(5.3, 298156, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerTimerWithCountdownCD			= mod:NewAITimer(84, 298103, nil, nil, nil, 1, nil, nil, nil, 1, 4)
--local timerArcingCurrentCD				= mod:NewAITimer(30.1, 295825, nil, nil, nil, 3)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)
--mod:AddNamePlateOption("NPAuraOnChaoticGrowth", 296914)

function mod:OnCombatStart(delay)
--	if self.Options.NPAuraOnChaoticGrowth then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnChaoticGrowth then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:OnTimerRecovery()

end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 298548 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 298242 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 298156 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 298306 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152311 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298689 then--Absorb Fluids

	end
end
--]]
