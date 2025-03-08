if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2683, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(231821)--Bombs use https://www.wowhead.com/ptr-2/npc=236733
mod:SetEncounterID(3128)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1216505 1216709 1216812 1216687"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

local warnBombfield				= mod:NewSpellAnnounce(1216505, 3)

local specWarnDeathFromAbove	= mod:NewSpecialWarningDodge(1216709, nil, nil, nil, 2, 2)
local specWarnToxicMechanic		= mod:NewSpecialWarningSpell(1216812, nil, nil, nil, 2, 2)
local specWarnFlamingFlames		= mod:NewSpecialWarningDodge(1216687, nil, nil, nil, 2, 2)

local timerBombfieldCD			= mod:NewAITimer(32.7, 1216505, nil, nil, nil, 1)
local timerDeathFromAboveCD		= mod:NewAITimer(32.7, 1216709, nil, nil, nil, 3)
local timerSlamCD				= mod:NewAITimer(32.7, 1216812, nil, nil, nil, 2)
local timerFlamingFlamesCD		= mod:NewAITimer(32.7, 1216687, nil, nil, nil, 2)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1216505 then
		warnBombfield:Show()
		timerBombfieldCD:Start()
	elseif spellId == 1216709 then
		specWarnDeathFromAbove:Show()
		specWarnDeathFromAbove:Play("watchstep")
		timerDeathFromAboveCD:Start()
	elseif spellId == 1216812 then
		specWarnToxicMechanic:Show()
		specWarnToxicMechanic:Play("carefly")
		timerSlamCD:Start()
	elseif spellId == 1216687 then
		specWarnFlamingFlames:Show()
		specWarnFlamingFlames:Play("frontal")
		timerFlamingFlamesCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 421006 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421260 then

	end
end
--]]
