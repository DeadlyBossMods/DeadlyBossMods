local mod	= DBM:NewMod(2397, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164451, 164463, 164461)--Dessia, Paceran, Sathel
mod:SetEncounterID(2391)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 320069 324085 320105 320248 320272 320293",
	"SPELL_CAST_START 320063 320094 320164 320269 320281",
	"SPELL_CAST_SUCCESS 320069 320180 320272",
	"SPELL_PERIODIC_DAMAGE 320180",
	"SPELL_PERIODIC_MISSED 320180"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is enrage on a timer or just used at low health
--TODO, why does fungal bloom have a DPS icon
--Dessia the Decapitator
--
local warnMortalStrike				= mod:NewTargetNoFilterAnnounce(320069, 3, nil, "Tank|Healer")
local warnEnrage					= mod:NewTargetNoFilterAnnounce(324085, 3)
local warnInspiration				= mod:NewTargetNoFilterAnnounce(320105, 3)
--Paceran the Virulent
local warnGeneticAlteration			= mod:NewTargetNoFilterAnnounce(320248, 3, nil, "RemoveMagic")
--Sathel the Accursed

--Dessia the Decapitator
local specWarnSlam					= mod:NewSpecialWarningDefensive(320063, "Tank", nil, nil, 1, 2)
local specWarnEnrage				= mod:NewSpecialWarningDispel(324085, "RemoveEnrage", nil, nil, 1, 2)
local specWarnVortex				= mod:NewSpecialWarningRun(320094, "Melee", nil, nil, 4, 2)
--Paceran the Virulent
local specWarnGTFO					= mod:NewSpecialWarningGTFO(320180, nil, nil, nil, 1, 8)
local specWarnFungalbloom			= mod:NewSpecialWarningDodge(320164, nil, nil, nil, 2, 2)
--Sathel the Accursed
local specWarnPainSpike				= mod:NewSpecialWarningInterrupt(320269, false, nil, nil, 1, 2)
local specWarnSpectralTransference	= mod:NewSpecialWarningDispel(320272, "MagicDispeller", nil, nil, 1, 2)
local specWarnMassTransference		= mod:NewSpecialWarningSpell(320281, nil, nil, nil, 2, 2)
local specWarnOneWithDeath			= mod:NewSpecialWarningDispel(320293, "ImmunityDispeller", nil, nil, 1, 2)

--Dessia the Decapitator
local timerMortalStrikeCD				= mod:NewAITimer(13, 320069, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_Translations.TANK_ICON)
local timerSlamCD						= mod:NewAITimer(13, 320063, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_Translations.TANK_ICON)
--Paceran the Virulent
local timerNoxiousSporeCD				= mod:NewAITimer(15.8, 320180, nil, nil, nil, 3)
local timerFungalBloomCD				= mod:NewAITimer(15.8, 320164, nil, nil, nil, 3, nil, DBM_CORE_Translations.DEADLY_ICON..DBM_CORE_Translations.DAMAGE_ICON)
--Sathel the Accursed
local timerPainSpikeCD					= mod:NewAITimer(15.8, 320269, nil, nil, nil, 4, nil, DBM_CORE_Translations.INTERRUPT_ICON)
local timerSpectralTransferenceCD		= mod:NewAITimer(15.8, 320272, nil, nil, nil, 5, nil, DBM_CORE_Translations.MAGIC_ICON)

function mod:OnCombatStart(delay)
	--Dessia
	timerMortalStrikeCD:Start(1-delay)
	timerSlamCD:Start(1-delay)
	--Paceran
	timerNoxiousSporeCD:Start(1-delay)
	timerFungalBloomCD:Start(1-delay)
	--Sathel
	timerPainSpikeCD:Start(1-delay)
	timerSpectralTransferenceCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320063 then
		specWarnSlam:Show()
		specWarnSlam:Play("defensive")
		timerSlamCD:Start()
	elseif spellId == 320094 then
		specWarnVortex:Show()
		specWarnVortex:Play("justrun")
	elseif spellId == 320164 then
		specWarnFungalbloom:Show()
		specWarnFungalbloom:Play("watchstep")
		timerFungalBloomCD:Start()
	elseif spellId == 320269 then
		timerPainSpikeCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPainSpike:Show(args.sourceName)
			specWarnPainSpike:Play("kickcast")
		end
	elseif spellId == 320281 then
		specWarnMassTransference:Show()
		specWarnMassTransference:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320069 then
		timerMortalStrikeCD:Start()
	elseif spellId == 320180 then
		timerNoxiousSporeCD:Start()
	elseif spellId == 320272 then
		timerSpectralTransferenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320069 then
		warnMortalStrike:Show(args.destName)
	elseif spellId == 324085 then
		if self.Options.SpecWarn324085dispel then
			specWarnEnrage:Show(args.destName)
		else
			warnEnrage:Show(args.destName)
		end
	elseif spellId == 320105 then
		warnInspiration:CombinedShow(0.3, args.destName)
	elseif spellId == 320248 then
		warnGeneticAlteration:CombinedShow(0.3, args.destName)
	elseif spellId == 320272 then
		specWarnSpectralTransference:CombinedShow(0.3, args.destName)--Combined because of Mass Transference
		specWarnSpectralTransference:ScheduleVoice(0.3, "dispelboss")
	elseif spellId == 320293 then
		specWarnOneWithDeath:Show(args.destName)
		specWarnOneWithDeath:Play("dispelboss")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320180 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164451 then--Dessia the Decapitator
		timerMortalStrikeCD:Stop()
		timerSlamCD:Stop()
	elseif cid == 164463 then--Paceran the Virulent
		timerNoxiousSporeCD:Stop()
		timerFungalBloomCD:Stop()
	elseif cid == 164461 then--Sathel the Accursed
		timerPainSpikeCD:Stop()
		timerSpectralTransferenceCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
