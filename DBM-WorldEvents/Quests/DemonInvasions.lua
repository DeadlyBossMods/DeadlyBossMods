local mod	= DBM:NewMod("DemonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START 223420 219469 219441 219112 219110",
	"SPELL_AURA_APPLIED 218625 218657",
	"SPELL_PERIODIC_DAMAGE 219367 207576",
	"SPELL_PERIODIC_MISSED 219367 207576",
	"SCENARIO_UPDATE"
)
mod.noStatistics = true

--EVERYTHING is antispammed for good measure, in case two of same type of mob are up together.
--IMPORTANT: When legion launches, kill ## X-DBM-Mod-MapID: 1, 2 from TOC file
local warnRumblingSlam				= mod:NewSpellAnnounce(223420, 2)
local warnBlazingHellfire			= mod:NewSpellAnnounce(218625, 3)
local warnExplosiveOrbs				= mod:NewSpellAnnounce(219469, 2)
local warnFlameBreath				= mod:NewSpellAnnounce(219441, 3)

local specWarnRainofFire			= mod:NewSpecialWarningMove(219367, nil, nil, nil, 1, 2)
local specWarnFelFire				= mod:NewSpecialWarningMove(207576, nil, nil, nil, 1, 2)
local specWarnCharredFlesh			= mod:NewSpecialWarningYou(218657)--Don't really have an appropriate voice file, if it were organized raids This would be a healer warning not a personal. Instead it's basically a "you're gonna die"
local specWarnEyeOfDarkness			= mod:NewSpecialWarningMoveTo(219112, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(219112), nil, 3, 2)
local specWarnShadowNova			= mod:NewSpecialWarningRun(219110, nil, nil, nil, 4, 2)

local timerEyeofDarknessCD			= mod:NewCDTimer(34, 219112, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerShadowNovaCD				= mod:NewCDTimer(35.5, 219110, nil, nil, nil, 2)

local voiceRainofFire				= mod:NewVoice(219367)--runaway
local voiceFelFire					= mod:NewVoice(207576)--runaway
local voiceEyeOfDarkness			= mod:NewVoice(219112)--runin
local voiceShadowNova				= mod:NewVoice(219110)--runout

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 223420 and self:AntiSpam(3, 4) then
		warnRumblingSlam:Show()
	elseif spellId == 219469  then
		warnExplosiveOrbs:Show()
	elseif spellId == 219441 then
		warnFlameBreath:Show()
	elseif spellId == 219112 then
		specWarnEyeOfDarkness:Show(BOSS)
		voiceEyeOfDarkness:Play("runin")
		timerEyeofDarknessCD:Start()
	elseif spellId == 219110 then
		specWarnShadowNova:Show()
		voiceShadowNova:Play("runout")
		timerShadowNovaCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 218625 and self:AntiSpam(3, 3) then
		warnBlazingHellfire:Show()
	elseif spellId == 218657 and args:IsPlayer() then
		specWarnCharredFlesh:Show()
	end
end

do
	local playerGUID = UnitGUID("player")
	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 219367 and destGUID == playerGUID and self:AntiSpam(3, 1) then
			specWarnRainofFire:Show()
			voiceRainofFire:Play("runaway")
		elseif spellId == 207576 and destGUID == playerGUID and self:AntiSpam(3, 2) then
			specWarnFelFire:Show()
			voiceFelFire:Play("runaway")
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end

--"<480.50 21:31:36> [SCENARIO_UPDATE] #newStep#true#Info#Invasion: Tanaris#0#0#0#false#false#true#0#0#4#Tanaris#StepInfo#nil#nil#0#false#false#false#0#nil#nil#nil", -- [14820]
function mod:SCENARIO_UPDATE()
	local stageName, stageDescription, numCriteria, completed = C_Scenario.GetStepInfo()
	if completed then
		timerShadowNovaCD:Stop()
		timerEyeofDarknessCD:Stop()
	end
end
