local mod	= DBM:NewMod(2403, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164967)
mod:SetEncounterID(2384)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 321166 321321 321406",
	"SPELL_CAST_SUCCESS 321384",
	"SPELL_AURA_APPLIED 321522 321268 321384 322410 322174",
	"SPELL_AURA_REMOVED 321522 321268 321384 322174",
	"SPELL_PERIODIC_DAMAGE 322356",
	"SPELL_PERIODIC_MISSED 322356"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe warn when oozes spawn after the slams
--TODO, probably half the boss, blizzard fucked journal up so badly for boss that it's unclear how accurate this mod even is anymore
--TODO, fight so broken not even WCL can parse it correctly, so it literally can't be fixed right now
--[[
(ability.id = 321166 or ability.id = 321321 or ability.id = 321285 or ability.id = 321406) and type = "begincast"
 or ability.id = 321384 and type = "cast"
--]]
local warnBurningContagion			= mod:NewTargetNoFilterAnnounce(321522, 2)
local warnCongealedContagion		= mod:NewTargetNoFilterAnnounce(321268, 2)
local warnFocusedGaze				= mod:NewTargetNoFilterAnnounce(321384, 4)
local warnEngulf					= mod:NewTargetNoFilterAnnounce(322174, 4)

--General
local specWarnSurgingSlam			= mod:NewSpecialWarningDefensive(321166, "Tank", nil, nil, 1, 2)
local specWarnVirulentExplosion		= mod:NewSpecialWarningSpell(321406, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(322356, nil, nil, nil, 1, 8)
--Burning Contagion Abilities
local specWarnPestilenceSlam		= mod:NewSpecialWarningDefensive(321321, "Tank", nil, nil, 1, 2)
local specWarnWitheringFilth		= mod:NewSpecialWarningDispel(322410, "RemoveMagic", nil, nil, 1, 2)
--Congealed Contagion Abilities
local specWarnCongealedSlam			= mod:NewSpecialWarningDefensive(321285, "Tank", nil, nil, 1, 2)
local specWarnFocusedGaze			= mod:NewSpecialWarningYou(321384, nil, nil, nil, 3, 2)
local yellFocusedGaze				= mod:NewYell(321384)
local yellFocusedGazeFades			= mod:NewShortFadesYell(321384)
local specWarnEngulf				= mod:NewSpecialWarningDispel(322174, "RemoveDisease", nil, nil, 1, 2)

local timerSurgingSlamCD			= mod:NewAITimer(13, 321166, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Burning Contagion Abilities
local timerPestilenceSlamCD			= mod:NewAITimer(13, 321321, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerVirulentExplosionCD		= mod:NewAITimer(13, 321406, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
--Congealed Contagion Abilities
local timerCongealedSlamCD			= mod:NewAITimer(13, 321285, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFocusedGazeCD			= mod:NewAITimer(20, 321384, nil, nil, nil, 3)
local timerEngulf					= mod:NewTargetTimer(20, 322174, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerSurgingSlamCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 321166 then
		specWarnSurgingSlam:Show()
		specWarnSurgingSlam:Play("defensive")
		timerSurgingSlamCD:Start()
	elseif spellId == 321321 then
		specWarnPestilenceSlam:Show()
		specWarnPestilenceSlam:Play("defensive")
		timerPestilenceSlamCD:Start()
	elseif spellId == 321285 then
		specWarnPestilenceSlam:Show()
		specWarnPestilenceSlam:Play("defensive")
		timerCongealedSlamCD:Start()
	elseif spellId == 321406 then
		specWarnVirulentExplosion:Show()
		specWarnVirulentExplosion:Play("aesoon")
		timerVirulentExplosionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 321384 then
		timerFocusedGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321522 then--Burning Contagion
		warnBurningContagion:Show(args.destName)
		timerSurgingSlamCD:Stop()
		timerPestilenceSlamCD:Start(1)
		timerVirulentExplosionCD:Start(1)
	elseif spellId == 321268 then--Congealed Contagion
		warnCongealedContagion:Show(args.destName)
		timerSurgingSlamCD:Stop()
		timerCongealedSlamCD:Start(1)
		timerFocusedGazeCD:Start(1)
	elseif spellId == 321384 then
		if args:IsPlayer() then
			specWarnFocusedGaze:Show()
			specWarnFocusedGaze:Play("targetyou")
			yellFocusedGaze:Yell()
			yellFocusedGazeFades:Countdown(spellId)
		else
			warnFocusedGaze:Show(args.destName)
		end
	elseif spellId == 322410 and self:CheckDispelFilter() then
		specWarnWitheringFilth:CombinedShow(0.3, args.destName)
		specWarnWitheringFilth:ScheduleVoice(0.3, args.destName)
	elseif spellId == 322174 then
		timerEngulf:Start(20, args.destName)
		if self.Options.SpecWarn322174dispel and self:CheckDispelFilter() then
			specWarnEngulf:Show(args.destName)
			specWarnEngulf:Play(args.destName)
		else
			warnEngulf:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321522 then--Burning Contagion
		timerPestilenceSlamCD:Stop()
		timerVirulentExplosionCD:Stop()
	elseif spellId == 321268 then--Congealed Contagion
		timerCongealedSlamCD:Stop()
		timerFocusedGazeCD:Stop()
	elseif spellId == 321384 and args:IsPlayer() then
		yellFocusedGazeFades:Cancel()
	elseif spellId == 322174 then
		timerEngulf:Stop(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 322356 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
