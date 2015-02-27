local mod	= DBM:NewMod(1211, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81535)
mod:SetEncounterID(1770)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")--no yell

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 175973 175979",
	"SPELL_CAST_SUCCESS 176013",
	"SPELL_AURA_APPLIED 176004",
	"SPELL_PERIODIC_DAMAGE 176037",
	"SPELL_ABSORBED 176037"
)

--Oh look, someone designed a world boss that's a copy and paste of Yalnu with tweaks.
--TODO, do dps siwtch to Untamed Mand, or just tanks.
local warnSavageVines				= mod:NewTargetAnnounce(176004, 2)

local specWarnColossalBlow			= mod:NewSpecialWarningDodge(175973, nil, nil, nil, 2, nil, 2)
local specWarnGenesis				= mod:NewSpecialWarningSpell(175979, nil, nil, nil, nil, nil, 2)--Everyone. "Switch" is closest generic to "run around stomping flowers". Might need custom message
local specWarnSavageVines			= mod:NewSpecialWarningYou(176004)
local yellSavageVines				= mod:NewYell(176004)
local specWarnSavageVinesNear		= mod:NewSpecialWarningClose(176004)
local specWarnGrowUntamedMandragora	= mod:NewSpecialWarningSwitch(176013, "-Healer", nil, nil, nil, nil, 2)
local specWarnNoxiousSpit			= mod:NewSpecialWarningMove(176037)

--local timerColossalBlowCD			= mod:NewNextTimer(60, 175973)
local timerGenesis					= mod:NewCastTimer(14, 169613)
local timerGenesisCD				= mod:NewCDTimer(45, 169613)--45-60 variation
local timerGrowUntamedMandragoraCD	= mod:NewCDTimer(30, 176013)

local voiceColossalBlow				= mod:NewVoice(175973)
local voiceMandragora				= mod:NewVoice(176013, "Dps")
local voiceGenesis					= mod:NewVoice(175979)

--mod:AddReadyCheckOption(37462, false)
--mod:AddRangeFrameOption(8, 175979)

local UnitDebuff = UnitDebuff
local debuffName = GetSpellInfo(176004)
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, debuffName)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then
		--Vines--7
		--Colossal Bow--14
		--timerGrowUntamedMandragoraCD:Start(18-delay)
		--timerGenesisCD:Start(20-delay)
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175973 then
		specWarnColossalBlow:Show()
		--timerColossalBlow:Start()
		voiceColossalBlow:Play("shockwave")
	elseif spellId == 175979 then
		specWarnGenesis:Show()
		timerGenesis:Start()
		timerGenesisCD:Start()
		voiceGenesis:Play("169613")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 176013 then
		specWarnGrowUntamedMandragora:Show()
		timerGrowUntamedMandragoraCD:Start()
		voiceMandragora:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 176004 then
		local targetName = args.destName
		warnSavageVines:CombinedShow(0.5, targetName)
		if args:IsPlayer() then
			specWarnSavageVines:Show()
			yellSavageVines:Yell()
		else
			if self:CheckNearby(8, targetName) then
				specWarnSavageVinesNear:Show(targetName)
			end
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", debuffName) then
				DBM.RangeCheck:Show(8, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter, nil, nil, nil, 8)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID)-- only listen personal Noxious Spit event
	if destGUID ~= UnitGUID("player") then return end
	if self:AntiSpam(2, 1) then
		specWarnNoxiousSpit:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE