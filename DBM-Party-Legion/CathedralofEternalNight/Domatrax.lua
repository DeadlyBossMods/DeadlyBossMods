local mod	= DBM:NewMod(1904, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(91004)
--mod:SetEncounterID(1791)
mod:SetZone()
--mod:SetHotfixNoticeRev(15186)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnStrikeofMountain			= mod:NewTargetAnnounce(216290, 2)

local specWarnStrikeofMountain		= mod:NewSpecialWarningDodge(216290, nil, nil, nil, 1, 2)
local yellStrikeofMountain			= mod:NewYell(216290)

local timerSunderCD					= mod:NewCDTimer(7.5, 198496, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local voiceStrikeofMountain			= mod:NewVoice(216290)--targetyou

--mod:AddSetIconOption("SetIconOnIdol", 216249, true, true)

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198496 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 216290 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 198509 then

	end
end

--]]