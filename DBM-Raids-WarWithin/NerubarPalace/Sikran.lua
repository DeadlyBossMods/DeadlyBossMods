local mod	= DBM:NewMod(2599, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(200927)
mod:SetEncounterID(2898)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

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

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(27649))
--local warnSomeAbility							= mod:NewSpellAnnounce(422277, 3)

--local specWarnSomeAbility						= mod:NewSpecialWarningSpell(426725, nil, nil, nil, 3, 2)
--local yellSearingAftermath					= mod:NewShortYell(422577)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

--local timerWorldinFlamesCD					= mod:NewAITimer(49, 422172, nil, nil, nil, 3)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

--function mod:OnCombatStart(delay)

--end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421343 then

	end
end
--]]

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421656 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]