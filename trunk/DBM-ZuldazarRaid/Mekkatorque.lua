local mod	= DBM:NewMod(2334, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(138967)
mod:SetEncounterID(2276)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282205 287797 287952 286465 287929",
	"SPELL_CAST_SUCCESS 282182 287757 284042 288049",
	"SPELL_AURA_APPLIED 282182 287757 287167 284168 289023 286051",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 287757 282401",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine right boss CID, he has 9 of them that were all added in 8.1 alone
--TODO, Gigavolt Charge has 3 debuff spellIDs, all 3 used or what the deal?
--TODO, see if timers reset on lift off and landing, like 2nd boss of HFC
--TODO, Dimensional Ripper XL target?
--TODO, icon marking for poly morph dispel assignments?
--TODO, nameplate aura for tampering protocol, if it has actual debuff diration (wowhead does not)
--TODO, better intermission code?
--TODO, correct event/spellid for shrink ray timer
--TODO, if number of bots can be counted, add additional "switch to bots" warnings when shrunk is applied if any are still up
--TODO, intermission ending on removal of 282401 or death of x shield generators?
--TODO, blast off and crash down might be entirely based on intermission and not actually P1 abilities
local warnPhase						= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Ground Phase
local warnShrunk						= mod:NewTargetNoFilterAnnounce(284168, 1)
--Intermission: Evasive Maneuvers!

--Final Push
local warnHyperDrive					= mod:NewTargetNoFilterAnnounce(286051, 3)

--Ground Phase
local specWarnBusterCannon				= mod:NewSpecialWarningYou(282182, nil, nil, nil, 1, 2)
local specWarnBlastOff					= mod:NewSpecialWarningRun(282205, "Melee", nil, nil, 4, 2)
local specWarnCrashDown					= mod:NewSpecialWarningDodge(287797, nil, nil, nil, 2, 2)
local specWarnGigaVoltCharge			= mod:NewSpecialWarningYou(286646, nil, nil, nil, 1, 2)
local yellGigaVoltCharge				= mod:NewYell(286646)
local yellGigaVoltChargeFades			= mod:NewFadesYell(286646)
local specWarnGigaVoltChargeFading		= mod:NewSpecialWarningMoveTo(286646, nil, nil, nil, 3, 2)
local specWarnGigaVoltChargeTaunt		= mod:NewSpecialWarningTaunt(286646, nil, nil, nil, 1, 2)
local specWarnDimensionalRipperXL		= mod:NewSpecialWarningSpell(287952, nil, nil, nil, 2, 5)
local specWarnDiscombobulation			= mod:NewSpecialWarningDispel(287167, "Healer", nil, nil, 1, 2)--Mythic
local specWarnDeploySparkBot			= mod:NewSpecialWarningSwitch(288410, nil, nil, nil, 1, 2)
local specWarnShrunk					= mod:NewSpecialWarningYou(284168, nil, nil, nil, 1, 2)
local yellShrunk						= mod:NewYell(284168)--Shrunk will just say with white letters
local specWarnEnormous					= mod:NewSpecialWarningYou(289023, nil, nil, nil, 1, 2)--Mythic
local yellEnormous						= mod:NewYell(289023, nil, nil, nil, "YELL")--Enormous will shout with red letters
--Intermission: Evasive Maneuvers!
local specWarnExplodingSheep			= mod:NewSpecialWarningDodge(287929, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Ground Phase
local timerBusterCannonCD				= mod:NewAITimer(55, 282182, nil, nil, nil, 3)
local timerBlastOffCD					= mod:NewAITimer(55, 282205, nil, nil, nil, 2)
local timerCrashDownCD					= mod:NewAITimer(55, 287797, nil, nil, nil, 3)
local timerGigaVoltChargeCD				= mod:NewAITimer(14.1, 286646, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)
local timerDimensionalRipperXLCD		= mod:NewAITimer(55, 287952, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerDeploySparkBotCD				= mod:NewAITimer(55, 288410, nil, nil, nil, 1)
local timerShrinkRayCD					= mod:NewAITimer(55, 288049, nil, nil, nil, 3)
--Intermission: Evasive Maneuvers!
local timerExplodingSheepCD				= mod:NewAITimer(55, 287929, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddInfoFrameOption(258040, true)
--mod:AddNamePlateOption("NPAuraOnPresence", 276093)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

--mod.vb.phase = 1

function mod:OnCombatStart(delay)
	timerBusterCannonCD:Start(1-delay)
	timerBlastOffCD:Start(1-delay)
	timerGigaVoltChargeCD:Start(1-delay)
	timerDeploySparkBotCD:Start(1-delay)
	timerShrinkRayCD:Start(1-delay)
	if self:IsHard() then
		timerDimensionalRipperXLCD:Start(1-delay)
	end
--	if self.Options.NPAuraOnPresence then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnPresence then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282205 then
		specWarnBlastOff:Show()
		specWarnBlastOff:Play("justrun")
		--timerCrashDownCD:Start()
		timerBlastOffCD:Start()--Move to crash down when not AI
	elseif spellId == 287797 then
		specWarnCrashDown:Show()
		specWarnCrashDown:Play("watchstep")
	elseif spellId == 287952 then
		specWarnDimensionalRipperXL:Show()
		specWarnDimensionalRipperXL:Play("teleyou")
		timerDimensionalRipperXLCD:Start()
	elseif spellId == 286465 then--Deploy Shield generators
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("phasechange")
		timerBusterCannonCD:Stop()
		timerBlastOffCD:Stop()
		timerGigaVoltChargeCD:Stop()
		timerDeploySparkBotCD:Stop()
		timerShrinkRayCD:Stop()
		timerDimensionalRipperXLCD:Stop()
		--timerCrashDownCD:Stop()
		timerGigaVoltChargeCD:Start(2)
		timerShrinkRayCD:Start(2)
		timerExplodingSheepCD:Start(2)
	elseif spellId == 287929 then
		specWarnExplodingSheep:Show()
		specWarnExplodingSheep:Play("watchstep")
		timerExplodingSheepCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282182 then
		timerBusterCannonCD:Start()
	elseif spellId == 287757 then
		timerGigaVoltChargeCD:Start()
	elseif spellId == 284042 then
		if DBM:UnitDebuff("player", 284168) then--Shrunk
			specWarnDeploySparkBot:Show()
			specWarnDeploySparkBot:Play("targetchange")
		end
		timerDeploySparkBotCD:Start()
	elseif spellId == 288049 then
		timerShrinkRayCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282182 then
		if args:IsPlayer() then
			specWarnBusterCannon:Show()
			specWarnBusterCannon:Play("targetyou")
		end
	elseif spellId == 287757 then--Or 283409 or 286646
		if args:IsPlayer() then
			specWarnGigaVoltCharge:Show()
			specWarnGigaVoltCharge:Play("targetyou")
			specWarnGigaVoltChargeFading:Schedule(10, DBM_CORE_BREAK_LOS)
			specWarnGigaVoltChargeFading:ScheduleVoice(10, "findshelter")--TODO, more specific voice
			yellGigaVoltCharge:Yell()
			yellGigaVoltChargeFades:Countdown(15)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnGigaVoltChargeTaunt:Show(args.destName)
				specWarnGigaVoltChargeTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 287167 then
		specWarnDiscombobulation:CombinedShow(0.3, args.destName)
		specWarnDiscombobulation:ScheduleVoice(0.3, "helpdispel")
	elseif spellId == 284168 then
		warnShrunk:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnShrunk:Show()
			specWarnShrunk:Play("targetyou")
			yellShrunk:Yell()
		end
	elseif spellId == 289023 then
		if args:IsPlayer() then
			specWarnEnormous:Show()
			specWarnEnormous:Play("watchstep")
			yellEnormous:Yell()
		end
	elseif spellId == 286051 then
		warnHyperDrive:Show(args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 287757 then--Or 283409 or 286646
		if args:IsPlayer() then
			specWarnGigaVoltChargeFading:Cancel()
			specWarnGigaVoltChargeFading:CancelVoice()
			yellGigaVoltChargeFades:Cancel()
		end
	elseif spellId == 282401 then--Gnomish Force Shield
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("phasechange")
		timerGigaVoltChargeCD:Stop()
		timerShrinkRayCD:Stop()
		timerExplodingSheepCD:Stop()
		
		timerBusterCannonCD:Start(3)
		timerBlastOffCD:Start(3)
		timerGigaVoltChargeCD:Start(3)
		timerDeploySparkBotCD:Start(3)
		timerShrinkRayCD:Start(3)
		timerDimensionalRipperXLCD:Start(3)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146440 then--Shield Generator
	
	--elseif cid == 148123 then--Evil Twin (Mythic)

	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then

	end
end
--]]
