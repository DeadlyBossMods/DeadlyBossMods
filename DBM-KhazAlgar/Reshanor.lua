local mod	= DBM:NewMod(2762, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(231821)
mod:SetEncounterID(3184)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)
mod:SetZone(2774)--Possibly incorrect

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

--local warnBombfield				= mod:NewSpellAnnounce(1216505, 3)

--local specWarnDeathFromAbove	= mod:NewSpecialWarningDodge(1216709, nil, nil, nil, 2, 2)

--local timerBombfieldCD			= mod:NewAITimer(32.7, 1216505, nil, nil, nil, 1)

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1216505 then

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
