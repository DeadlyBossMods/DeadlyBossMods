if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2683, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(221067)
mod:SetEncounterID(3128)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

--local warnMountainsGrasp			= mod:NewSpellAnnounce(450929, 3)

--local specWarnTectonicRoar			= mod:NewSpecialWarningSpell(450454, nil, nil, nil, 2, 2)

--local timerTectonicRoarCD			= mod:NewAITimer(32.7, 450454, nil, nil, nil, 2)

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 450454 then

	end
end
--]]

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
