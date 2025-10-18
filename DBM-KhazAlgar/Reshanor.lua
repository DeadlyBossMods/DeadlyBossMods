local mod	= DBM:NewMod(2762, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(238319)
mod:SetEncounterID(3184)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
mod:SetHotfixNoticeRev(20251017000000)
mod:SetMinSyncRevision(20251017000000)
mod:SetZone(2738)

mod:RegisterCombat("combat")
mod:SetWipeTime(40)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1237905 1237261 1237893"
)

local warnUntetheredRetreat			= mod:NewSpellAnnounce(1237261, 3)

local specWarnTwilightBreath		= mod:NewSpecialWarningDodge(1237905, nil, nil, nil, 2, 2)
local specWarnVeilshatterRoar		= mod:NewSpecialWarningCast(1237893, "SpellCaster", nil, nil, 2, 2)--CD too messy, 54.9-114

local timerTwilightBreathCD			= mod:NewCDTimer(34.8, 1237905, nil, nil, nil, 3)
local timerUntetheredRetreatCD		= mod:NewCDTimer(111.1, 1237261, nil, nil, nil, 6)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1237905 then
		specWarnTwilightBreath:Show()
		specWarnTwilightBreath:Play("breathsoon")
		timerTwilightBreathCD:Start()
	elseif spellId == 1237261 then
		warnUntetheredRetreat:Show()
		timerUntetheredRetreatCD:Start()
	elseif spellId == 1237893 then
		specWarnVeilshatterRoar:Show()
		specWarnVeilshatterRoar:Play("stopcast")
	end
end
