local dungeonID, creatureID
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2213, 138122--Dooms Howl
else--Horde
	dungeonID, creatureID = 2212, 137374--Lion's Roar
end
local mod	= DBM:NewMod(dungeonID, "DBM-Azeroth-BfA", 3, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(creatureID)--Dooms Howl 138122, Lion's Roar 137374
--mod:SetEncounterID(encounterID)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 271163 277598",
	"SPELL_CAST_SUCCESS 271246 271280 271797 271783",
	"SPELL_AURA_APPLIED 271223 277632 271783",
	"SPELL_AURA_REMOVED 271223 271783",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, GTFO for flamestrike?
--Mobile
local warnSiegeModeOver				= mod:NewEndAnnounce(271223)
local warnMortarShot				= mod:NewSpellAnnounce(271164, 2)
local warnFlameExhausts				= mod:NewSpellAnnounce(277598, 2)
--Siege
local warnSiegeMode					= mod:NewSpellAnnounce(271223)
local warnDemoCannon				= mod:NewTargetNoFilterAnnounce(271246, 2, nil, false)--Not part of global filter, in case healer wants to turn it on for heal targets

--Mobile
local specWarnShatteringPulse		= mod:NewSpecialWarningSpell(271163, "Tank", nil, 3, 1, 2)
--Siege
local specWarnDoomsHowlEngineer		= mod:NewSpecialWarningSwitch("ej18702", "-Healer", nil, nil, 1, 2)
local specWarnLionsHowlEngineer		= mod:NewSpecialWarningSwitch("ej18682", "-Healer", nil, nil, 1, 2)
local specWarnFieldRepair			= mod:NewSpecialWarningInterrupt(271797, "HasInterrupt", nil, nil, 1, 2)
local specWarnSentry				= mod:NewSpecialWarningMove(271783, false, nil, 2, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Mobile
local timerShatteringPulseCD		= mod:NewCDTimer(20, 271163, nil, "Tank", nil, 5)
local timerMortarShotCD				= mod:NewCDTimer(10, 271164, nil, nil, nil, 3)
local timerFlameExhaustsCD			= mod:NewCDTimer(12.1, 277598, nil, nil, nil, 3)
local timerSiegeUpCD				= mod:NewCDTimer(84.5, 271223, nil, nil, nil, 6)--84.5-86.2
--Siege
local timerSiegeUp					= mod:NewBuffActiveTimer(64, 271223, nil, nil, nil, 6)--64-66
local timerDemoCannonCD				= mod:NewCDTimer(5.8, 271246, nil, false, nil, 5, nil, DBM_CORE_HEALER_ICON)

mod:AddRangeFrameOption(8, 271192)
mod:AddNamePlateOption("NPAuraOnSentry", 271783)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerShatteringPulseCD:Start(-delay)
		--timerMortarShotCD:Start(-delay)
		--timerFlameExhaustsCD:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.NPAuraOnSentry then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnSentry then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 271163 then
		specWarnShatteringPulse:Show()
		specWarnShatteringPulse:Play("carefly")
		timerShatteringPulseCD:Start()
	elseif spellId == 277598 then
		warnFlameExhausts:Show()
		timerFlameExhaustsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 271246 then
		timerDemoCannonCD:Start()
	elseif spellId == 271280 then
		if creatureID == 138122 then--Alliance
			specWarnDoomsHowlEngineer:Show()
			specWarnDoomsHowlEngineer:Play("killmob")
		else
			specWarnLionsHowlEngineer:Show()
			specWarnLionsHowlEngineer:Play("killmob")
		end
	elseif spellId == 271797 and self:CheckInterruptFilter(args.sourceGUID, false, true, true) then
		specWarnFieldRepair:Show(args.sourceName)
		specWarnFieldRepair:Play("kickcast")
	elseif spellId == 271783 and self:AntiSpam(3, 2) then
		specWarnSentry:Show()
		specWarnSentry:Play("moveboss")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271223 then--Siege Up (Stage: Seiged Battle Station)
		warnSiegeMode:Show()
		timerSiegeUpCD:Stop()
		timerShatteringPulseCD:Stop()
		timerMortarShotCD:Stop()
		timerFlameExhaustsCD:Stop()
		timerDemoCannonCD:Start(6.5)--SUCCESS
		timerSiegeUp:Start(64)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 277632 then
		warnDemoCannon:CombinedShow(0.3, args.destName)
	elseif spellId == 271783 then
		if self.Options.NPAuraOnSentry then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271223 then--Siege Up (Stage: Mobile Battle Vehicle)
		warnSiegeModeOver:Show()
		timerDemoCannonCD:Stop()
		timerSiegeUp:Stop()
		timerFlameExhaustsCD:Start(8.5)
		timerMortarShotCD:Start(11)
		timerShatteringPulseCD:Start(18.4)
		timerSiegeUpCD:Start(84)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 271783 then
		if self.Options.NPAuraOnSentry then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 271164 and self:AntiSpam(5, 1) then
		warnMortarShot:Show()
		timerMortarShotCD:Start()
	end
end
