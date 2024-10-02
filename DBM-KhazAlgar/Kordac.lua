local mod	= DBM:NewMod(2637, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(221084)
mod:SetEncounterID(2997)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 458423 458329 458845",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 458220 458838 458844",
	"SPELL_PERIODIC_DAMAGE 458799",
	"SPELL_PERIODIC_MISSED 458799"
)

--TODO, personal rupturing runes warning, with right debuff ID (https://www.wowhead.com/beta/spell=450863/rupturing-runes or https://www.wowhead.com/beta/spell=450677/rupturing-runes
--TODO, what kind of warning for Discoard weaklings or grasp?
local warnOverchargedLasers				= mod:NewTargetNoFilterAnnounce(458209, 3)
local warnSupressionBurst				= mod:NewTargetNoFilterAnnounce(458845, 3)

local specWarnArcaneBombardment			= mod:NewSpecialWarningDodge(458423, nil, nil, nil, 2, 2)
local specWarnTitanicImpact				= mod:NewSpecialWarningDodge(458320, nil, nil, nil, 2, 2)
local specWarnOverchargedLasers			= mod:NewSpecialWarningMoveAway(458209, nil, nil, nil, 1, 2)
local specWarnSupressionBurst			= mod:NewSpecialWarningMoveAway(458845, nil, nil, nil, 1, 2)
local specWarnSupressionBurstDebuff		= mod:NewSpecialWarningDispel(458844, "RemoveMagic", nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(458799, nil, nil, nil, 1, 8)

local timerArcaneBombardmentCD			= mod:NewAITimer(32.7, 458423, nil, nil, nil, 2)
local timerOverchargedLasersCD			= mod:NewAITimer(32.7, 458209, nil, nil, nil, 3)
local timerTitanicImpactCD				= mod:NewAITimer(32.7, 458320, nil, nil, nil, 5)
local timerSupressionBurstCD			= mod:NewAITimer(32.7, 458845, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 458423 then
		specWarnArcaneBombardment:Show()
		specWarnArcaneBombardment:Play("watchstep")
		timerArcaneBombardmentCD:Start()
	elseif spellId == 458329 then
		specWarnTitanicImpact:Show()
		specWarnTitanicImpact:Play("shockwave")
		timerTitanicImpactCD:Start()
	elseif spellId == 458845 then
		timerSupressionBurstCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 421006 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 458220 then
		warnOverchargedLasers:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOverchargedLasers:Show()
			specWarnOverchargedLasers:Play("runout")
		end
		if self:AntiSpam(5, 1) then
			timerOverchargedLasersCD:Start()
		end
	elseif spellId == 458838 then
		warnSupressionBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSupressionBurst:Show()
			specWarnSupressionBurst:Play("runout")
		end
	elseif spellId == 458844 then
		if self:CheckDispelFilter("magic") then
			specWarnSupressionBurstDebuff:CombinedShow(1, args.destName)
			specWarnSupressionBurstDebuff:ScheduleVoice(1, "helpdispel")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 458799 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
