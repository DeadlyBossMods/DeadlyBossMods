local mod	= DBM:NewMod(2625, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(221067)
mod:SetEncounterID(2984)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 450454 450407 450677 450929 451702"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

--TODO, personal rupturing runes warning, with right debuff ID (https://www.wowhead.com/beta/spell=450863/rupturing-runes or https://www.wowhead.com/beta/spell=450677/rupturing-runes
--TODO, what kind of warning for Discoard weaklings or grasp?
local warnMountainsGrasp			= mod:NewSpellAnnounce(450929, 3)
local warnDiscardWeaklings			= mod:NewSpellAnnounce(451702, 3)

local specWarnTectonicRoar			= mod:NewSpecialWarningSpell(450454, nil, nil, nil, 2, 2)
local specWarnColossalSlam			= mod:NewSpecialWarningDodge(450407, nil, nil, nil, 2, 2)

local timerTectonicRoarCD			= mod:NewCDTimer(31.8, 450454, nil, nil, nil, 2)
local timerColossalSlamCD			= mod:NewCDTimer(31.8, 450407, nil, nil, nil, 3)
local timerRupturingRunesCD			= mod:NewCDTimer(31.8, 450677, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerMountainsGraspCD			= mod:NewCDTimer(31.8, 450929, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 450454 then
		specWarnTectonicRoar:Show()
		specWarnTectonicRoar:Play("carefly")
		timerTectonicRoarCD:Start()
	elseif spellId == 450407 then
		specWarnColossalSlam:Show()
		specWarnColossalSlam:Play("shockwave")
		timerColossalSlamCD:Start()
	elseif spellId == 450677 then
		timerRupturingRunesCD:Start()
	elseif spellId == 450929 then
		warnMountainsGrasp:Show()
		timerMountainsGraspCD:Start()
	elseif spellId == 451702 then
		warnDiscardWeaklings:Show()
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
