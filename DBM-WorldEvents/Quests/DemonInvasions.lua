local mod	= DBM:NewMod("DemonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START 223420 219469 219441 219112 219110 224067 213890 216916 217958",
	"SPELL_CAST_SUCCESS 218639 218659",
	"SPELL_SUMMON 213861",
	"SPELL_AURA_APPLIED 218625 218657 224044",
	"SPELL_AURA_REMOVED 218657 224044",
	"SPELL_PERIODIC_DAMAGE 219367 207576",
	"SPELL_PERIODIC_MISSED 219367 207576",
	"SCENARIO_UPDATE"
)
mod.noStatistics = true

--Many are antispammed for good measure, in case two of same type of mob are up together.
--IMPORTANT: When legion launches, re-add ## X-DBM-Mod-World-Boss: 1
local warnRumblingSlam				= mod:NewSpellAnnounce(223420, 2)
local warnBlazingHellfire			= mod:NewSpellAnnounce(218625, 3)
local warnExplosiveOrbs				= mod:NewSpellAnnounce(219469, 2)
local warnFlameBreath				= mod:NewSpellAnnounce(219441, 3)
local warnWakeofBlood				= mod:NewSpellAnnounce(224067, 4)--See if target scanning works? Might always be on person tanking that mob which means even if it doesn't can assume it's "tank"

local specWarnMarkofBlood			= mod:NewSpecialWarningMoveAway(224044, nil, nil, nil, 1, 2)
local specWarnRainofFire			= mod:NewSpecialWarningMove(219367, nil, nil, nil, 1, 2)
local specWarnFelFire				= mod:NewSpecialWarningMove(207576, nil, nil, nil, 1, 2)
local specWarnDestructiveFlames		= mod:NewSpecialWarningDodge(218639, nil, nil, nil, 2, 2)--Is this a reflect?
local specWarnCharredFlesh			= mod:NewSpecialWarningMoveAway(218657)--Don't really have an appropriate voice file, if it were organized raids This would be a healer warning not a personal. Instead it's basically a "you're gonna die"
local yellCharredFlesh				= mod:NewFadesYell(218657)
local specWarnEyeOfDarkness			= mod:NewSpecialWarningMoveTo(219112, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(219112), nil, 3, 2)
local specWarnShadowNova			= mod:NewSpecialWarningRun(219110, nil, nil, nil, 4, 2)
local specWarnCarrionSwarm			= mod:NewSpecialWarningRun(213890, nil, nil, nil, 4, 2)
local specWarnLegionInfernals		= mod:NewSpecialWarningSwitch(213861, "RangedDps", nil, nil, 1, 2)
local specWarnWavesofDread			= mod:NewSpecialWarningDodge(216916, nil, nil, nil, 2, 2)
local specWarnChaosWave				= mod:NewSpecialWarningDodge(217958, nil, nil, nil, 2, 2)

local timerDestructiveFlamesCD		= mod:NewCDTimer(30, 218639, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerEyeofDarknessCD			= mod:NewCDTimer(50, 219112, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerShadowNovaCD				= mod:NewCDTimer(50, 219110, nil, nil, nil, 2)
local timerCarrionSwarmCD			= mod:NewCDTimer(32.5, 213890, nil, nil, nil, 2)
local timerLegionInfernalsCD		= mod:NewCDTimer(28.5, 213861, nil, nil, nil, 1)
local timerCharredFlesh				= mod:NewBuffFadesTimer(17, 218657, nil, nil, nil, 3)

local countdownCharredFlesh			= mod:NewCountdownFades(17, 218657)

local voiceMarkofBlood				= mod:NewVoice(224044)--scatter
local voiceRainofFire				= mod:NewVoice(219367)--runaway
local voiceFelFire					= mod:NewVoice(207576)--runaway
local voiceDestructiveFlames		= mod:NewVoice(218639)--watchstep
local voiceEyeOfDarkness			= mod:NewVoice(219112)--runin
local voiceShadowNova				= mod:NewVoice(219110)--runout
local voiceCarrionSwarm				= mod:NewVoice(213890)--runout
local voiceLegionInfernals			= mod:NewVoice(213861, "RangedDps")--killmob
local voiceWavesofDread				= mod:NewVoice(216916)--watchwave
local voiceChaosWave				= mod:NewVoice(217958)--watchwave
--local voiceWakeofBlood			= mod:NewVoice(224067)--keepmove

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(6, 224044)

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
	elseif spellId == 224067 then
		warnWakeofBlood:Show()
	elseif spellId == 213890 then
		specWarnCarrionSwarm:Show()
		voiceCarrionSwarm:Play("runout")
		timerCarrionSwarmCD:Start()
	elseif spellId == 216916 and self:AntiSpam(8, 6) then
		specWarnWavesofDread:Show()
		voiceWavesofDread:Play("watchwave")
	elseif spellId == 217958 then
		specWarnChaosWave:Show()
		voiceChaosWave:Play("watchwave")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 218639 then
		specWarnDestructiveFlames:Show()
		voiceDestructiveFlames:Play("watchstep")
		timerDestructiveFlamesCD:Start()
	elseif spellId == 218659 then
		timerCharredFlesh:Start()
		countdownCharredFlesh:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 213861 and self:AntiSpam(3, 5) then
		specWarnLegionInfernals:Show()
		voiceLegionInfernals:Play("killmob")
		timerLegionInfernalsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 218625 and self:AntiSpam(3, 3) and self:CheckInterruptFilter(args.sourceGUID, true) then
		warnBlazingHellfire:Show()
	elseif spellId == 224044 and args:IsPlayer() then
		specWarnMarkofBlood:Show()
		voiceMarkofBlood:Play("scatter")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif spellId == 218657 and args:IsPlayer() then
		specWarnCharredFlesh:Schedule(10)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
		if expires then
			local remaining = expires-GetTime()
			yellCharredFlesh:Schedule(remaining-1, 1)
			yellCharredFlesh:Schedule(remaining-2, 2)
			yellCharredFlesh:Schedule(remaining-3, 3)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 218657 and args:IsPlayer() then
		specWarnCharredFlesh:Cancel()
		yellCharredFlesh:Cancel()
	elseif spellId == 224044 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
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
		timerDestructiveFlamesCD:Stop()
		timerCarrionSwarmCD:Stop()
		timerLegionInfernalsCD:Stop()
	end
end
