local mod	= DBM:NewMod(2168, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(137119)--Taloc
mod:SetEncounterID(2144)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 271296 271728 271895",
	"SPELL_CAST_SUCCESS 271224",
	"SPELL_AURA_APPLIED 271224 271965 275270",
	"SPELL_AURA_REMOVED 271225 271965",
	"SPELL_PERIODIC_DAMAGE 270290",
	"SPELL_PERIODIC_MISSED 270290"
)

local warnPoweringDown					= mod:NewSpellAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnPlastmaDischarge				= mod:NewTargetAnnounce(271225, 2)
local warnPoweringDownOver				= mod:NewEndAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnFixate						= mod:NewTargetAnnounce(275270, 2)

local specWarnPlasmaDischarge			= mod:NewSpecialWarningMoveAway(271225, nil, nil, nil, 3, 2)
local yellPlasmaDischarge				= mod:NewYell(271225)
local specWarnCudgelofGore				= mod:NewSpecialWarningMoveTo(271296, nil, nil, nil, 3, 2)
local specWarnCudgelofGoreEveryone		= mod:NewSpecialWarningRun(271296, nil, nil, nil, 4, 2)
local specWarnRetrieveCudgel			= mod:NewSpecialWarningDodge(271728, nil, nil, nil, 2, 2)
local specWarnSanguineStatic			= mod:NewSpecialWarningDodge(272582, nil, nil, nil, 2, 2)
local specWarnFixate					= mod:NewSpecialWarningYou(275270, nil, nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 2)

mod:AddTimerLine(BOSS)
local timerPlasmaDischargeCD			= mod:NewCDTimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
local timerCudgelOfGoreCD				= mod:NewCDTimer(57.4, 271296, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--57.4-63
local timerSanguineStaticCD				= mod:NewCDTimer(57.4, 272582, nil, nil, nil, 3)--57.4-63
mod:AddTimerLine(DBM:GetSpellInfo(271965))
local timerPoweredDown					= mod:NewBuffActiveTimer(88.6, 271965, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(57.4, 271296, true, 3, 3)
--local countdownRealityTear				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconPlasmaDischarge", 271225, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(275270, true)

local bloodStorm = DBM:GetSpellInfo(270290)
local ignoreGTFO = false

function mod:OnCombatStart(delay)
	timerPlasmaDischargeCD:Start(5.9-delay)
	timerCudgelOfGoreCD:Start(31.6-delay)
	timerSanguineStaticCD:Start(20.6-delay)
	ignoreGTFO = false
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 271296 then
		timerCudgelOfGoreCD:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnCudgelofGore:Show(bloodStorm)
			specWarnCudgelofGore:Play("targetyou")--Better voice maybe, or custom voice
		else
			specWarnCudgelofGoreEveryone:Show()
			specWarnCudgelofGoreEveryone:Play("justrun")
		end
		if self:IsTank() then
			ignoreGTFO = true
		end
	elseif spellId == 271728 then
		ignoreGTFO = false
		specWarnRetrieveCudgel:Show()
		specWarnRetrieveCudgel:Play("chargemove")
	elseif spellId == 271895 then--Sanguine Static
		specWarnSanguineStatic:Show()
		specWarnSanguineStatic:Play("watchwave")
		timerSanguineStaticCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 271224 and self:AntiSpam(3, 1) then
		timerPlasmaDischargeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271224 then
		warnPlastmaDischarge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPlasmaDischarge:Show()
			specWarnPlasmaDischarge:Play("runout")
			specWarnPlasmaDischarge:ScheduleVoice(1.5, "keepmove")
			yellPlasmaDischarge:Yell()
		end
	elseif spellId == 271965 then
		ignoreGTFO = false
		warnPoweringDown:Show()
		warnPoweringDown:Play("phasechange")
		timerPoweredDown:Start()
		timerPlasmaDischargeCD:Stop()
		timerCudgelOfGoreCD:Stop()
		timerSanguineStaticCD:Stop()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(275270))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 275270)
		end
	elseif spellId == 275270 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
		else
			warnFixate:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 271225 then--Used later with icon feature

	elseif spellId == 271965 then
		warnPoweringDownOver:Show()
		warnPoweringDownOver:Play("phasechange")
		timerPoweredDown:Stop()
		timerPlasmaDischargeCD:Start(6)
		timerSanguineStaticCD:Start(20.7)
		timerCudgelOfGoreCD:Start(30.5)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) and not ignoreGTFO then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end
--]]
