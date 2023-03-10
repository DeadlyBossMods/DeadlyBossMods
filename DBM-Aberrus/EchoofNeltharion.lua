local mod	= DBM:NewMod(2523, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(184972)
mod:SetEncounterID(2684)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20221215000000)
--mod:SetMinSyncRevision(20221215000000)
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
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
--local warnFlamerift								= mod:NewTargetNoFilterAnnounce(390715, 2)
--local warnBurningWound							= mod:NewStackAnnounce(394906, 2, nil, "Tank|Healer")

--local specWarnFlamerift							= mod:NewSpecialWarningMoveAway(390715, nil, nil, nil, 1, 2)
--local yellFlamerift								= mod:NewShortYell(390715)
--local yellFlameriftFades						= mod:NewShortFadesYell(390715)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)
--
--local timerMoltenCleaveCD						= mod:NewAITimer(29.9, 370615, nil, nil, nil, 3)
--local timerFlameriftCD							= mod:NewAITimer(28.9, 390715, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
--mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--mod:GroupSpells(390715, 396094)
---Frenzied Tarasek

function mod:OnCombatStart(delay)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
--end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 370307 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 370597 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 370597 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then

	end
end
--]]

--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
