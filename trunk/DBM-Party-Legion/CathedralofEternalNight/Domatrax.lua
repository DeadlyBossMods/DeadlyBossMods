local mod	= DBM:NewMod(1904, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(119542)--119883 Fel Portal Guardian
mod:SetEncounterID(2053)
mod:SetZone()
--mod:SetHotfixNoticeRev(15186)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 236543 234107 241622",
	"SPELL_CAST_SUCCESS 234107"
)

--TODO< approaching doom, once know who casting source is and whether it can be canceled properly
--TODO, other warnings? portal spawns/phases?
--TODO, announce portal guardians, they fire UNIT_TARGETABLE_CHANGED (maybe other things?)
local warnApproachingDoom			= mod:NewCastAnnounce(241622, 2)

local specWarnFelsoulCleave			= mod:NewSpecialWarningDodge(236543, "Tank", nil, nil, 1, 2)
local specWarnChaoticEnergy			= mod:NewSpecialWarningMoveTo(234107, nil, nil, nil, 2, 2)

local timerFelsoulCleaveCD			= mod:NewCDTimer(20, 236543, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChaoticEnergyCD			= mod:NewCDTimer(30, 234107, nil, nil, nil, 2)
--local timerApproachingDoom			= mod:NewCastTimer(20, 241622, nil, nil, nil, 1)

local voiceFelsoulCleave			= mod:NewVoice(236543)--shockwave (review)
local voiceChaoticEnergy			= mod:NewVoice(234107)--findshield

--mod:AddSetIconOption("SetIconOnIdol", 216249, true, true)

local shield = GetSpellInfo(238410)

function mod:OnCombatStart(delay)
	timerFelsoulCleaveCD:Start(8.2-delay)
	timerChaoticEnergyCD:Start(32.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 236543 then
		specWarnFelsoulCleave:Show()
		voiceFelsoulCleave:Play("shockwave")
		timerFelsoulCleaveCD:Start()
	elseif spellId == 234107 then
		specWarnChaoticEnergy:Show(shield)
		voiceChaoticEnergy:Play("findshield")
	elseif spellId == 241622 then
		warnApproachingDoom:Show()
		--timerApproachingDoom
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 234107 then
		timerChaoticEnergyCD:Start()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 198509 then

	end
end
--]]
