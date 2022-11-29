local mod	= DBM:NewMod(2499, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)--way too many CIDs to guess right now
mod:SetEncounterID(2607)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20221124000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 377612 388643 388635 377658 377594 385065 385553 397382 397468 387261 385574 389870 385068 395885 386410",
	"SPELL_CAST_SUCCESS 381615 376126 396037",
	"SPELL_AURA_APPLIED 381615 388631 395906 381249 388431 388115 396037 385541 397382 397387 388691 391990 394574 394576 391991 394579 394575 394582 391993 394584 377467 396734 395929 391285",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 381615 388431 396037 385541 397382 397387 388691 377467 396734",
	"SPELL_PERIODIC_DAMAGE 395929",
	"SPELL_PERIODIC_MISSED 395929",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, volatile current target scan (or maybe emote/whisper/debuff?)
--TODO, warn for Volatike (388631)?
--TODO, fix lightning strikes
--TODO, speed up Lightning Devistation, i'm sure one of scripts fire earlier than channel, similar to vexiona and others coded same way
--TODO, detect intermission add spawns/add timer for spawns?
--TODO, initial CD timers for spawning in adds, if timers are used
--TODO, track and alert high stacks of https://www.wowhead.com/beta/spell=385560/windforce-strikes on Oathsworn?
--TODO, determine number adds and spawn behavior for auto marking Stormseeker Acolyte for interrupt assignments?
--TODO, use specWarnScatteredCharge once coding is verified it's being avoided for now to avoid SW spam
--TODO, add https://www.wowhead.com/beta/spell=391281/crackling-energy to intermission 2 or is it just persistent damage?
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(388115, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--Stage One: The Winds of Change
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25244))
local warnStaticCharge							= mod:NewTargetNoFilterAnnounce(381615, 3)
local warnLightningStrike						= mod:NewCountAnnounce(376126, 3)
local warnElectricScales						= mod:NewCountAnnounce(381249, 2)

--local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnHurricaneWing						= mod:NewSpecialWarningCount(377612, nil, nil, nil, 2, 2)
local specWarnStaticCharge						= mod:NewSpecialWarningYouPos(381615, nil, 37859, nil, 1, 2)
local yellStaticCharge							= mod:NewShortPosYell(381615, 37859)
local yellStaticChargeFades						= mod:NewIconFadesYell(381615, 37859)
local specWarnVolatileCurrent					= mod:NewSpecialWarningMoveAwayCount(388643, nil, nil, nil, 2, 2)
local specWarnBurst								= mod:NewSpecialWarningInterruptCount(388635, "HasInterrupt", nil, nil, 1, 2)
local specWarnElectrifiedJaws					= mod:NewSpecialWarningDefensive(377658, nil, nil, nil, 1, 2)
local specWarnElectrifiedJawsOther				= mod:NewSpecialWarningTaunt(377658, nil, nil, nil, 1, 2)
local specWarnLightingBreath					= mod:NewSpecialWarningDodgeCount(388643, nil, nil, nil, 2, 2)

local timerHurricaneWingCD						= mod:NewAITimer(35, 377612, nil, nil, nil, 2)
local timerStaticChargeCD						= mod:NewAITimer(35, 381615, nil, nil, nil, 3)
local timerVolatileCurrentCD					= mod:NewAITimer(35, 388643, nil, nil, nil, 3)
local timerElectrifiedJawsCD					= mod:NewAITimer(35, 377658, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerLightningBreathCD					= mod:NewAITimer(35, 377594, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerLightningStrikesCD					= mod:NewAITimer(35, 376126, nil, nil, nil, 3)
local timerElectricScalesCD						= mod:NewAITimer(35, 381249, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddSetIconOption("SetIconOnStaticCharge", 381615, true, 0, {1, 2, 3})
mod:AddSetIconOption("SetIconVolatileSpark", 388635, false, 5, {8, 7, 6, 5, 4})
--Intermission: The Primalist Strike
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25683))
--Raszageth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25402))
local specWarnLightningDevastation				= mod:NewSpecialWarningDodgeCount(385065, nil, nil, nil, 3, 2)

local timerLightningDevastationCD				= mod:NewAITimer(35, 385065, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Primalist Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25638))
local warnSurgingBlast							= mod:NewTargetAnnounce(396037, 3)
local warnShatteringShroud						= mod:NewTargetNoFilterAnnounce(397382, 4)
local warnShatteringShroudFaded					= mod:NewFadedAnnounce(397382, 1)
local warnBlazingroar							= mod:NewCastAnnounce(397468, 4)

local specWarnSurgingBlast						= mod:NewSpecialWarningMoveAway(396037, nil, 37859, nil, 1, 2)
local yellSurgingBlast							= mod:NewShortYell(396037, 37859)
local yellSurgingBlastFades						= mod:NewShortFadesYell(396037, 37859)
local specWarnStormBolt							= mod:NewSpecialWarningInterruptCount(385553, "HasInterrupt", nil, nil, 1, 2)
local specWarnShatteringShroud					= mod:NewSpecialWarningYou(397382, nil, nil, nil, 1, 2, 4)
local specWarnFlameShield						= mod:NewSpecialWarningSwitch(397387, nil, nil, nil, 1, 2, 4)

local timerSurgingBlastCD						= mod:NewAITimer(35, 396037, 37859, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerShatteringShroudCD					= mod:NewAITimer(35, 397382, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFlameShieldCD						= mod:NewAITimer(35, 397387, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnShatteringShroud", 397382, true, 0, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnAscension", 385541)
mod:AddNamePlateOption("NPAuraOnFlameShield", 397387)
--Stage Two: Surging Power
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25312))
local warnStormsurge						= mod:NewEndAnnounce(387261, 1)
local warnInversion							= mod:NewTargetAnnounce(394584, 4)
local warnFocusedCharge						= mod:NewYouAnnounce(394582, 1)
local warnScatteredCharge					= mod:NewYouAnnounce(394583, 4)
local warnFulminatingCharge					= mod:NewTargetNoFilterAnnounce(378829, 3)

local specWarnStormsurge					= mod:NewSpecialWarningMoveAwayCount(387261, nil, nil, nil, 2, 2)--Maybe shorttext 28089?
local specWarnPositiveCharge				= mod:NewSpecialWarningYouPos(391990, nil, nil, nil, 1, 13)--Split warning so user can custom sounds
local specWarnNegativeCharge				= mod:NewSpecialWarningYouPos(391991, nil, nil, nil, 1, 13)--between positive and negative
local yellStormCharged						= mod:NewShortPosYell(391989, DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION)
local specWarnInversion						= mod:NewSpecialWarningMoveAway(394584, nil, nil, nil, 3, 13, 4)
local yellInversion							= mod:NewShortYell(394584)
local yellInversionFades					= mod:NewShortFadesYell(394584)
--local specWarnScatteredCharge				= mod:NewSpecialWarningMoveAway(394583, nil, nil, nil, 1, 2)
local specWarnTempestWing					= mod:NewSpecialWarningCount(385574, nil, nil, nil, 2, 2)--Dodge?
local specWarnFulminatingCharge				= mod:NewSpecialWarningYouPos(378829, nil, nil, nil, 1, 2)
local yellFulminatingCharge					= mod:NewShortPosYell(378829)
local yellFulminatingChargeFades			= mod:NewIconFadesYell(378829)

local timerStormsurgeCD						= mod:NewAITimer(35, 387261, nil, nil, nil, 2)--Maybe shorttext 28089?
local timerTempestWingCD					= mod:NewAITimer(35, 385574, nil, nil, nil, 3)
local timerFulminatingChargeCD				= mod:NewAITimer(35, 378829, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnFulminatingCharge", 378829, true, 0, {1, 2, 3})
mod:AddInfoFrameOption(387261, true)
mod:GroupSpells(391989, 391990, 391991, 394584)--Group positive and negative spellIds under parent category "Stormcharged"
--Intermission: The Vault Falters
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25812))
--Colossal Stormfiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25816))
local specWarnStormBreak					= mod:NewSpecialWarningDodge(389870, nil, nil, nil, 2, 2)
local specWarnBallLightning					= mod:NewSpecialWarningDodge(385068, nil, nil, nil, 2, 2)

local timerStormBreakCD						= mod:NewAITimer(35, 389870, nil, nil, nil, 3)
local timerBallLightningCD					= mod:NewAITimer(35, 385068, nil, nil, nil, 3)
--Stage Three: Storm Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25477))
local specWarnStormEater					= mod:NewSpecialWarningCount(395885, nil, nil, nil, 2, 2, 4)
local specWarnThunderousBlast				= mod:NewSpecialWarningDefensive(386410, nil, nil, nil, 1, 2)
local specWarnMeltedArmor					= mod:NewSpecialWarningTaunt(391285, nil, nil, nil, 1, 2)

local timerStormEaterCD						= mod:NewAITimer(35, 395885, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerThunderousBlastCD				= mod:NewAITimer(35, 386410, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:GroupSpells(386410, 391285)--Thunderous Blast and associated melted armor debuff

--P1
mod.vb.energyCount = 0--Reused for the 100 energy special in stage 1/2 and mythic storm eater mechanic in stage 3
mod.vb.chargeCount = 0--Static Charge/Fulminating Charge
mod.vb.chargeIcon = 1--Static Charge/Fulminating Charge
mod.vb.currentCount = 0
mod.vb.tankCount = 0--Electrified Jaws/Thunderous Blast
mod.vb.addIcon = 8
mod.vb.breathCount = 0--Reused in P1.5 intermission
mod.vb.strikeCount = 0
mod.vb.scalesCount = 0
--P2
mod.vb.shroudIcon = 1
mod.vb.wingCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.energyCount = 0
	self.vb.chargeCount = 0
	self.vb.currentCount = 0
	self.vb.tankCount = 0
	self.vb.breathCount = 0
	self.vb.strikeCount = 0
	self.vb.scalesCount = 0
	timerHurricaneWingCD:Start(1-delay)
	timerStaticChargeCD:Start(1-delay)
	timerVolatileCurrentCD:Start(1-delay)
	timerElectrifiedJawsCD:Start(1-delay)
	timerLightningBreathCD:Start(1-delay)
	timerLightningStrikesCD:Start(1-delay)
	timerElectricScalesCD:Start(1-delay)
	if self.Options.NPAuraOnAscension or self.Options.NPAuraOnFlameShield then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnAscension or self.Options.NPAuraOnFlameShield then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 377612 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnHurricaneWing:Show(self.vb.energyCount)
		specWarnHurricaneWing:Play("pushbackincoming")
		specWarnHurricaneWing:ScheduleVoice(1.5, "movecenter")
		timerHurricaneWingCD:Start()
	elseif spellId == 388643 then
		self.vb.addIcon = 8
		self.vb.currentCount = self.vb.currentCount + 1
		specWarnVolatileCurrent:Show(self.vb.currentCount)
		specWarnVolatileCurrent:Play("scatter")
		timerVolatileCurrentCD:Start()
	elseif spellId == 388635 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconVolatileSpark and self.vb.addIcon > 3 then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconVolatileSpark")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnBurst:Show(args.sourceName, count)
			if count < 6 then
				specWarnBurst:Play("kick"..count.."r")
			else
				specWarnBurst:Play("kickcast")
			end
		end
	elseif spellId == 385553 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnStormBolt:Show(args.sourceName, count)
			if count < 6 then
				specWarnStormBolt:Play("kick"..count.."r")
			else
				specWarnStormBolt:Play("kickcast")
			end
		end
	elseif spellId == 377658 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnElectrifiedJaws:Show()
			specWarnElectrifiedJaws:Play("defensive")
		end
		timerElectrifiedJawsCD:Start()
	elseif spellId == 377594 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnLightingBreath:Show(self.vb.breathCount)
		specWarnLightingBreath:Play("breathsoon")
		timerLightningBreathCD:Start()
	elseif spellId == 385065 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnLightningDevastation:Show(self.vb.breathCount)
		specWarnLightningDevastation:Play("breathsoon")
		timerLightningDevastationCD:Start()
	elseif spellId == 397382 then
		self.vb.shroudIcon = 1
		timerShatteringShroudCD:Start(nil, args.sourceGUID)
	elseif spellId == 397468 then
		warnBlazingroar:Show()
	elseif spellId == 387261 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnStormsurge:Show(self.vb.energyCount)
		specWarnStormsurge:Play("scatter")
		timerStormsurgeCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 385574 then
		self.vb.wingCount = self.vb.wingCount + 1
		specWarnTempestWing:Show(self.vb.wingCount)
		specWarnTempestWing:Play("watchwave")
		timerTempestWingCD:Start()
	elseif spellId == 389870 then
		specWarnStormBreak:Show()
		specWarnStormBreak:Play("watchstep")
		timerStormBreakCD:Start(nil, args.sourceGUID)
	elseif spellId == 385068 then
		specWarnBallLightning:Show()
		specWarnBallLightning:Play("watchorb")
		timerBallLightningCD:Start(nil, args.sourceGUID)
	elseif spellId == 395885 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnStormEater:Show(self.vb.energyCount)
		specWarnStormEater:Play("specialsoon")--Clarify voice when number of soakers and need to soak better understood
	elseif spellId == 386410 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnThunderousBlast:Show()
			specWarnThunderousBlast:Play("defensive")
		end
		timerThunderousBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 381615 then
		self.vb.chargeIcon = 1
		self.vb.chargeCount = self.vb.chargeCount + 1
		timerStaticChargeCD:Start()
	elseif spellId == 376126 then
		self.vb.strikeCount = self.vb.strikeCount + 1
		warnLightningStrike:Show(self.vb.strikeCount)
		timerLightningStrikesCD:Start()
	elseif spellId == 396037 then
		timerSurgingBlastCD:Start(nil, args.sourceGUID)
	elseif spellId == 378829 then
		self.vb.chargeIcon = 1
		self.vb.chargeCount = self.vb.chargeCount + 1
		timerFulminatingChargeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 381615 then
		local icon = self.vb.chargeIcon
		if self.Options.SetIconOnStaticCharge then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnStaticCharge:Show(self:IconNumToTexture(icon))
			specWarnStaticCharge:Play("mm"..icon)
			yellStaticCharge:Yell(icon, icon)
			yellStaticChargeFades:Countdown(spellId, nil, icon)
		end
		warnStaticCharge:CombinedShow(0.5, args.destName)
		self.vb.chargeIcon = self.vb.chargeIcon + 1
	elseif spellId == 395906 and not args:IsPlayer() then
		specWarnElectrifiedJawsOther:Show(args.destName)
		specWarnElectrifiedJawsOther:Play("tauntboss")
	elseif spellId == 381249 then
		self.vb.scalesCount = self.vb.scalesCount + 1
		warnElectricScales:Show(self.vb.scalesCount)
		timerElectricScalesCD:Start()
	elseif (spellId == 388115 or spellId == 395929) and args:IsPlayer() and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 396037 then
		if args:IsPlayer() then
			specWarnSurgingBlast:Show()
			specWarnSurgingBlast:Play("runout")
			yellSurgingBlast:Yell()
			yellSurgingBlastFades:Countdown(spellId)
		end
		warnSurgingBlast:CombinedShow(0.5, args.destName)
	elseif spellId == 385541 then
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 397387 then
		specWarnFlameShield:Show(args.destName)
		specWarnFlameShield:Play("targetchange")
		timerFlameShieldCD:Start(nil, args.sourceGUID)
		if self.Options.NPAuraOnFlameShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 397382 then
		local icon = self.vb.shroudIcon
		if self.Options.SetIconOnShatteringShroud then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnShatteringShroud:Show()
			specWarnShatteringShroud:Play("targetyou")
		end
		warnShatteringShroud:CombinedShow(0.5, args.destName)
		self.vb.shroudIcon = self.vb.shroudIcon + 1
	elseif spellId == 388691 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount or UnitGetTotalAbsorbs("boss1"), "boss1")
		end
	elseif args:IsSpellID(391990, 394574, 394576) then--All variants of positive
		if args:IsPlayer() then
			specWarnPositiveCharge:Show()
			specWarnPositiveCharge:Play("positive")
			yellStormCharged:Yell(6)--Blue Square
		end
	elseif args:IsSpellID(391991, 394579, 394575) then--All variants of positive
		if args:IsPlayer() then
			specWarnNegativeCharge:Show()
			specWarnNegativeCharge:Play("negative")
			yellStormCharged:Yell(7)--Red X
		end
	elseif spellId == 394582 and args:IsPlayer() then
		warnFocusedCharge:Show()
	elseif spellId == 394583 and args:IsPlayer() then
		warnScatteredCharge:Show()
	elseif spellId == 394584 then
		warnInversion:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnInversion:Show()
			specWarnInversion:Play("polarityshift")
			yellInversion:Yell()
			yellInversionFades:Countdown(spellId)
		end
	elseif spellId == 377467 then
		local icon = self.vb.chargeIcon
		if self.Options.SetIconOnFulminatingCharge then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFulminatingCharge:Show(self:IconNumToTexture(icon))
			specWarnFulminatingCharge:Play("mm"..icon)
			yellFulminatingCharge:Yell(icon, icon)
			yellFulminatingChargeFades:Countdown(spellId, nil, icon)
		end
		warnFulminatingCharge:CombinedShow(0.5, args.destName)
		self.vb.chargeIcon = self.vb.chargeIcon + 1
	elseif spellId == 391285 and not args:IsPlayer() then
		specWarnMeltedArmor:Show(args.destName)
		specWarnMeltedArmor:Play("tauntboss")
	elseif spellId == 388431 then--Ruinous Shroud
		self:SetStage(1.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self.vb.breathCount = 0--Reused for Lightning Devastation
		timerHurricaneWingCD:Stop()
		timerStaticChargeCD:Stop()
		timerVolatileCurrentCD:Stop()
		timerElectrifiedJawsCD:Stop()
		timerLightningBreathCD:Stop()
		timerLightningStrikesCD:Stop()
		timerElectricScalesCD:Stop()

		timerLightningDevastationCD:Start(2)
	elseif spellId == 396734 then--Storm Shroud
		self:SetStage(2.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
		warnPhase:Play("phasechange")
		self.vb.breathCount = 0--Reused for Lightning Devastation
		timerStormsurgeCD:Stop()
		timerTempestWingCD:Stop()
		timerFulminatingChargeCD:Stop()
		timerVolatileCurrentCD:Stop()
		timerElectrifiedJawsCD:Stop()
		timerLightningStrikesCD:Stop()
		timerElectricScalesCD:Stop()

		timerLightningDevastationCD:Start(3)
--		timerStormBreakCD:Start(3)
--		timerBallLightningCD:Start(3)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 381615 then
		if self.Options.SetIconOnStaticCharge then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellStaticChargeFades:Cancel()
		end
	elseif spellId == 388431 then--Ruinous Shroud
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.energyCount = 0
		self.vb.currentCount = 0
		self.vb.tankCount = 0
		self.vb.strikeCount = 0
		self.vb.scalesCount = 0
		self.vb.wingCount = 0
		self.vb.chargeCount = 0

		timerLightningDevastationCD:Stop()
		timerStormsurgeCD:Start(2)
		timerTempestWingCD:Start(2)
		timerFulminatingChargeCD:Start(2)
		timerVolatileCurrentCD:Start(2)
		timerElectrifiedJawsCD:Start(2)
		timerLightningStrikesCD:Start(2)
		timerElectricScalesCD:Start(2)
	elseif spellId == 396734 then--Storm Shroud
		self:SetStage(3)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")

		self.vb.energyCount = 0--Used for Mythic Storm-Eater
		self.vb.chargeCount = 0--Fulminating
		self.vb.tankCount = 0--Thunderous Blast
		self.vb.breathCount = 0--Lightning Breath
		self.vb.strikeCount = 0--Lightning Strike
		self.vb.scalesCount = 0--Electric Scales
		self.vb.wingCount = 0

		timerLightningDevastationCD:Stop()
		timerStormEaterCD:Start(3)
		timerTempestWingCD:Start(3)
		timerFulminatingChargeCD:Start(3)
		timerLightningBreathCD:Start(3)
		timerThunderousBlastCD:Start(3)
		timerLightningStrikesCD:Start(3)
		timerElectricScalesCD:Start(3)
	elseif spellId == 396037 then
		if args:IsPlayer() then
			yellSurgingBlastFades:Cancel()
		end
	elseif spellId == 385541 then
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 397387 then
		if self.Options.NPAuraOnFlameShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 397382 then
		if self.Options.SetIconOnShatteringShroud then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			warnShatteringShroudFaded:Show()
		end
	elseif spellId == 388691 then
		warnStormsurge:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 394584 then
		if args:IsPlayer() then
			yellInversionFades:Cancel()
		end
	elseif spellId == 377467 then
		if self.Options.SetIconOnFulminatingCharge then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellFulminatingChargeFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 395929 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 194999 then--Volatile Spark
		castsPerGUID[args.destGUID] = nil
	elseif cid == 193760 then--Surging Ruiner
		timerSurgingBlastCD:Stop(args.destGUID)
--	elseif cid == 194991 then--Oathsworn Vanguard

	elseif cid == 194990 then--Stormseeker Acolyte
		castsPerGUID[args.destGUID] = nil
	elseif cid == 199547 then--Frostforged Zealot
		timerShatteringShroudCD:Stop(args.destGUID)
	elseif cid == 199549 then--Flamesworn Herald
		timerFlameShieldCD:Stop(args.destGUID)
	elseif cid == 197145 then--Colossal Stormfiend
		timerStormBreakCD:Stop(args.destGUID)
		timerBallLightningCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
