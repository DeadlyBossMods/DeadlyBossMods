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
	"SPELL_CAST_SUCCESS 271224 275205 278888",
	"SPELL_AURA_APPLIED 271224 271965 275270 275189 275205 278888",
	"SPELL_AURA_REMOVED 271225 271965 275189 275205",
	"SPELL_PERIODIC_DAMAGE 270290",
	"SPELL_PERIODIC_MISSED 270290"
)

--[[
(ability.id = 271296 or ability.id = 271728 or ability.id = 271895) and type = "begincast"
 or (ability.id = 271224 or ability.id = 275205 or ability.id = 278888) and type = "cast"
 or ability.id = 271965 and (type = "removebuff" or type = "applybuff")
--]]
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
local yellSanguineStatic				= mod:NewYell(272582)
local specWarnFixate					= mod:NewSpecialWarningYou(275270, nil, nil, nil, 1, 2)
local specWarnCloggedArteries			= mod:NewSpecialWarningMoveAway(275189, nil, nil, nil, 1, 2)
local yellCloggedArteries				= mod:NewYell(275189)
local yellCloggedArteriesFades			= mod:NewShortFadesYell(275189)
local specWarnCloggedArteriesNear		= mod:NewSpecialWarningClose(275189, nil, nil, nil, 1, 2)
local specWarnEnlargedHeart				= mod:NewSpecialWarningYou(275205, nil, nil, nil, 1, 2)
local yellEnlargedHeart					= mod:NewYell(275205)
local yellEnlargedHeartFades			= mod:NewFadesYell(275205)
local specWarnEnlargedHeartTaunt		= mod:NewSpecialWarningTaunt(275205, "Tank", nil, nil, 1, 2)
local specWarnEnlargedHeartOther		= mod:NewSpecialWarningMoveTo(275205, "-Tank", nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 2)

mod:AddTimerLine(BOSS)
local timerPlasmaDischargeCD			= mod:NewCDTimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
local timerCudgelOfGoreCD				= mod:NewCDTimer(58.4, 271296, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--60.4-63
local timerSanguineStaticCD				= mod:NewCDTimer(55, 272582, nil, nil, nil, 3)--60.4-63
local timerCloggedArteriesCD			= mod:NewCDTimer(60.4, 275189, nil, nil, nil, 3)--60.4-63
local timerEnlargedHeartCD				= mod:NewCDTimer(60.4, 275205, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--60.4-63
mod:AddTimerLine(DBM:GetSpellInfo(271965))
local timerPoweredDown					= mod:NewBuffActiveTimer(88.6, 271965, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, "Tank")
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconPlasmaDischarge", 271225, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(275270, true)

local bloodStorm = DBM:GetSpellInfo(270290)
local ignoreGTFO = false

function mod:StaticTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellSanguineStatic:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerPlasmaDischargeCD:Start(5.9-delay)
	timerSanguineStaticCD:Start(18-delay)
	timerCudgelOfGoreCD:Start(35-delay)
	countdownCudgelofGore:Start(35)
	if self:IsMythic() then
		timerCloggedArteriesCD:Start(24-delay)
		timerEnlargedHeartCD:Start(25-delay)
		countdownEnlargedHeart:Start(25-delay)
	end
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
		countdownCudgelofGore:Start(58.4)
		if self:IsTanking("player", "boss1", nil, true) then
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
		self:BossUnitTargetScanner(uId, "StaticTarget")
		specWarnSanguineStatic:Show()
		specWarnSanguineStatic:Play("watchwave")
		timerSanguineStaticCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 271224 or spellId == 278888) and self:AntiSpam(3, 1) then
		timerPlasmaDischargeCD:Start()
	elseif spellId == 275205 then
		timerEnlargedHeartCD:Start()
		countdownEnlargedHeart:Start(60.4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 271224 or spellId == 278888 then
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
		countdownCudgelofGore:Cancel()
		timerSanguineStaticCD:Stop()
		timerCloggedArteriesCD:Stop()
		timerEnlargedHeartCD:Stop()
		countdownEnlargedHeart:Cancel()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(275270))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 275270)
		end
	elseif spellId == 275270 and self:AntiSpam(2, args.destName) then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 275189 then
		if self:AntiSpam(3, 3) then
			timerCloggedArteriesCD:Start()
		end
		if args:IsPlayer() then
			specWarnCloggedArteries:Show()
			specWarnCloggedArteries:Play("runout")
			yellCloggedArteries:Yell()
			yellCloggedArteriesFades:Countdown(6)
		elseif self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnCloggedArteriesNear:CombinedShow(0.3, args.destName)
			specWarnCloggedArteriesNear:CancelVoice()--Avoid spam
			specWarnCloggedArteriesNear:ScheduleVoice(0.3, "runaway")
		end
	elseif spellId == 275205 then
		if args:IsPlayer() then
			specWarnEnlargedHeart:Show()
			specWarnEnlargedHeart:Play("runout")
			yellEnlargedHeart:Yell()
			yellEnlargedHeartFades:Countdown(6)
		else
			if not DBM:UnitDebuff("player", 275189) then
				specWarnEnlargedHeartOther:Show(args.destName)
				specWarnEnlargedHeartOther:Play("helpsoak")
			end
			specWarnEnlargedHeartTaunt:Show(args.destName)
			specWarnEnlargedHeartTaunt:Play("tauntboss")
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
		timerPlasmaDischargeCD:Start(13)--6
		timerSanguineStaticCD:Start(27)--18
		timerCudgelOfGoreCD:Start(37)--35
		countdownCudgelofGore:Start(37)--35
		if self:IsMythic() then
			timerCloggedArteriesCD:Start(24.4)
			timerEnlargedHeartCD:Start(25.7)
			countdownEnlargedHeart:Start(25.7)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 275189 then
		if args:IsPlayer() then
			yellCloggedArteriesFades:Cancel()
		end
	elseif spellId == 275205 then
		if args:IsPlayer() then
			yellEnlargedHeartFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) and not ignoreGTFO then
		specWarnGTFO:Show(spellName)
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
