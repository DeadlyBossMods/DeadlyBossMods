if DBM:GetTOC() < 110005 then return end
local mod	= DBM:NewMod(2666, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "lfr,normal,heroic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226306)
mod:SetEncounterID(3046)
--mod:SetUsedIcons(8, 7, 6)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_SUMMON",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--local warnSnackTime						= mod:NewCountAnnounce(438025, 3)

--local specWarnHoneyMarinade				= mod:NewSpecialWarningMoveAway(438025, nil, nil, nil, 1, 2)
--local yellHoneyMarinade					= mod:NewShortYell(438025)
--local yellHoneyMarinadeFades				= mod:NewShortFadesYell(438025)

--local timerSnackTimeCD					= mod:NewAITimer(33, 438025, nil, nil, nil, 3)--33

--mod:AddNamePlateOption("NPOnHoney", 443983)
--mod:AddSetIconOption("SetIconOnBees", 438025, true, 5, {8, 7, 6})

--local castsPerGUID = {}

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 438025 then

	end
end
--]]

--[[
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 438665 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 440134 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 440134 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 440141 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 218016 then

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
