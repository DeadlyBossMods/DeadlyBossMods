local mod	= DBM:NewMod(2349, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(151586)
mod:SetEncounterID(2293)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--local warnPoweringDown					= mod:NewSpellAnnounce(271965, 2, nil, nil, nil, nil, nil, 2

--local specWarnPlasmaDischarge			= mod:NewSpecialWarningMoveAway(271225, nil, nil, nil, 3, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--local specWarnEntropicBlast				= mod:NewSpecialWarningInterrupt(270620, "HasInterrupt", nil, nil, 1, 2)

--mod:AddTimerLine(BOSS)
--local timerPlasmaDischargeCD			= mod:NewAITimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
--local timerCudgelOfGoreCD				= mod:NewAITimer(58.2, 271296, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true)

--mod.vb.phase = 1

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 271296 then

	elseif spellId == 267180 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
		--	specWarnVoidbolt:Show(args.sourceName)
			--specWarnVoidbolt:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 271224 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271224 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271965 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135824 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 then

	end
end
--]]
