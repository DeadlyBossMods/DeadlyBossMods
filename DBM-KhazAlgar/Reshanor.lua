local mod	= DBM:NewMod(2762, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(238319)
mod:SetEncounterID(3184)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)
mod:SetZone(2738)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1237905 1237261 1237893"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

local warnUntetheredRetreat			= mod:NewSpellAnnounce(1237261, 3)

local specWarnTwilightBreath		= mod:NewSpecialWarningDodge(1237905, nil, nil, nil, 2, 2)
local specWarnVeilshatterRoar		= mod:NewSpecialWarningCast(1237893, "SpellCaster", nil, nil, 2, 2)

local timerTwilightBreathCD			= mod:NewAITimer(32.7, 1237905, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1237905 then
		specWarnTwilightBreath:Show()
		specWarnTwilightBreath:Play("breathsoon")
		timerTwilightBreathCD:Start()
	elseif spellId == 1237261 then
		warnUntetheredRetreat:Show()
	elseif spellId == 1237893 then
		specWarnVeilshatterRoar:Show()
		specWarnVeilshatterRoar:Play("stopcast")
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
