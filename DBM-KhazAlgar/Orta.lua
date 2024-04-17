local mod	= DBM:NewMod(2625, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(209574)
mod:SetEncounterID(2984)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

--mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
--)

--local warnSomeAbility				= mod:NewCountAnnounce(421059, 3)

--local specWarnSomeAbility				= mod:NewSpecialWarningYou(420895, nil, nil, nil, 1, 2)

--local timerSomeAbilityCD				= mod:NewAITimer(32.7, 420895, nil, nil, nil, 5)
--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420895 then

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
