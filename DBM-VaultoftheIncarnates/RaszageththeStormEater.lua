local mod	= DBM:NewMod(2499, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)--way too many CIDs to guess right now
mod:SetEncounterID(2607)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20221215000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 377612 388643 377658 377594 385065 385553 397382 397468 387261 385574 389870 385068 395885 386410 382434 390463",
	"SPELL_CAST_SUCCESS 381615 396037 399713 181089 381249",
	"SPELL_AURA_APPLIED 381615 388631 395906 388115 396037 385541 397382 397387 388691 391990 394574 394576 391991 394579 394575 394582 391993 394584 377467 395929 391285 399713 391281",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 381615 396037 385541 397382 397387 388691 377467 399713",
	"SPELL_PERIODIC_DAMAGE 395929",
	"SPELL_PERIODIC_MISSED 395929",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, volatile current target scan (or maybe emote/whisper/debuff?)
--TODO, warn for Volatike (388631)?
--TODO, fix lightning strikes
--TODO, detect intermission add spawns/add timer for spawns?
--TODO, initial CD timers for spawning in adds, if timers are used for the mythic only stuff
--TODO, track and alert high stacks of https://www.wowhead.com/beta/spell=385560/windforce-strikes on Oathsworn?
--TODO, determine number adds and spawn behavior for auto marking Stormseeker Acolyte for interrupt assignments?
--TODO, use specWarnScatteredCharge once coding is verified it's being avoided for now to avoid SW spam
--[[
(ability.id = 377612 or ability.id = 388643 or ability.id = 377658 or ability.id = 377594
 or ability.id = 385065 or ability.id = 397382 or ability.id = 397468 or ability.id = 387261 or ability.id = 385574 or ability.id = 389870
 or ability.id = 385068 or ability.id = 395885 or ability.id = 386410 or ability.id = 382434 or ability.id = 390463) and type = "begincast"
 or (ability.id = 381615 or ability.id = 396037 or ability.id = 378829 or ability.id = 399713 or ability.id = 382434 or ability.id = 390463 or ability.id = 381249) and type = "cast"
 or ability.id = 388431 or ability.id = 396734
 or ability.id = 181089 and type = "cast"
 or (ability.id = 391281 or ability.id = 391402) and type = "applybuff"
--]]
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(388115, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--Stage One: The Winds of Change
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25244))
local warnStaticCharge							= mod:NewTargetNoFilterAnnounce(381615, 3)
local warnLightningStrike						= mod:NewSpellAnnounce(376126, 3)

--local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnHurricaneWing						= mod:NewSpecialWarningCount(377612, nil, nil, nil, 2, 2)
local specWarnStaticCharge						= mod:NewSpecialWarningYouPos(381615, nil, 37859, nil, 1, 2)
local yellStaticCharge							= mod:NewShortPosYell(381615, 37859)
local yellStaticChargeFades						= mod:NewIconFadesYell(381615, 37859)
local specWarnVolatileCurrent					= mod:NewSpecialWarningMoveAwayCount(388643, nil, nil, nil, 2, 2)
local specWarnElectrifiedJaws					= mod:NewSpecialWarningDefensive(377658, nil, nil, nil, 1, 2)
local specWarnElectrifiedJawsOther				= mod:NewSpecialWarningTaunt(377658, nil, nil, nil, 1, 2)
local specWarnLightingBreath					= mod:NewSpecialWarningDodgeCount(388643, nil, nil, nil, 2, 2)

local timerHurricaneWingCD						= mod:NewCDCountTimer(35, 377612, nil, nil, nil, 2)
local timerStaticChargeCD						= mod:NewCDCountTimer(35, 381615, nil, nil, nil, 3)
local timerVolatileCurrentCD					= mod:NewCDCountTimer(47, 388643, nil, nil, nil, 3)--More data needed
local timerElectrifiedJawsCD					= mod:NewCDCountTimer(25, 377658, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerLightningBreathCD					= mod:NewCDCountTimer(35, 377594, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddSetIconOption("SetIconOnStaticCharge", 381615, true, 0, {1, 2, 3})
--Intermission: The Primalist Strike
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25683))
--Raszageth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25402))

local specWarnStormNova							= mod:NewSpecialWarningSpell(382434, nil, nil, nil, 2, 2)
local specWarnLightningDevastation				= mod:NewSpecialWarningDodgeCount(385065, nil, nil, nil, 3, 2)

local timerStormNova							= mod:NewCastTimer(5, 382434, nil, nil, nil, 5)
local timerLightningDevastationCD				= mod:NewCDTimer(13.3, 385065, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--Primalist Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25638))
local warnSurgingBlast							= mod:NewTargetAnnounce(396037, 3)
local warnShatteringShroud						= mod:NewTargetNoFilterAnnounce(397382, 4)
local warnShatteringShroudFaded					= mod:NewFadesAnnounce(397382, 1)
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

local timerStormsurgeCD						= mod:NewCDCountTimer(35, 387261, nil, nil, nil, 2)--Maybe shorttext 28089?
local timerTempestWingCD					= mod:NewCDCountTimer(35, 385574, nil, nil, nil, 3)
local timerFulminatingChargeCD				= mod:NewCDCountTimer(35, 378829, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnFulminatingCharge", 378829, true, 0, {1, 2, 3})
mod:AddInfoFrameOption(387261, true)
mod:GroupSpells(391989, 391990, 391991, 394584)--Group positive and negative spellIds under parent category "Stormcharged"
--Intermission: The Vault Falters
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25812))
--Colossal Stormfiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25816))
local specWarnStormBreak					= mod:NewSpecialWarningDodge(389870, nil, nil, nil, 2, 2)
local specWarnBallLightning					= mod:NewSpecialWarningDodge(385068, nil, nil, nil, 2, 2)

local timerStormBreakCD						= mod:NewCDTimer(23.1, 389870, nil, nil, nil, 3)
local timerBallLightningCD					= mod:NewCDTimer(23.1, 385068, nil, nil, nil, 3)
--Stage Three: Storm Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25477))
local warnMagneticCharge					= mod:NewTargetNoFilterAnnounce(399713, 3)

local specWarnStormEater					= mod:NewSpecialWarningCount(395885, nil, nil, nil, 2, 2, 4)
local specWarnThunderousBlast				= mod:NewSpecialWarningDefensive(386410, nil, nil, nil, 1, 2)
local specWarnMeltedArmor					= mod:NewSpecialWarningTaunt(391285, nil, nil, nil, 1, 2)
local specWarnMagneticCharge				= mod:NewSpecialWarningYouPos(399713, nil, nil, nil, 1, 2)
local yellMagneticCharge					= mod:NewShortPosYell(399713)
local yellMagneticChargeFades				= mod:NewIconFadesYell(399713)

local timerStormEaterCD						= mod:NewAITimer(35, 395885, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerMagneticChargeCD					= mod:NewAITimer(35, 399713, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerThunderousBlastCD				= mod:NewCDCountTimer(35, 386410, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4, 5, 6})
mod:GroupSpells(386410, 391285)--Thunderous Blast and associated melted armor debuff

--P1
mod.vb.energyCount = 0--Reused for the 100 energy special in stage 1/2 and mythic storm eater mechanic in stage 3
mod.vb.chargeCount = 0--Static Charge/Fulminating Charge
mod.vb.chargeIcon = 1--Static Charge/Fulminating Charge
mod.vb.currentCount = 0
mod.vb.tankCount = 0--Electrified Jaws/Thunderous Blast
mod.vb.breathCount = 0--Reused in P1.5 intermission
mod.vb.strikeCount = 0
--P2
mod.vb.shroudIcon = 1
mod.vb.wingCount = 0
--P3
mod.vb.magneticCount = 0
mod.vb.magneticIcon = 4
local castsPerGUID = {}

local difficultyName = "normal"
local allTimers = {
	["mythic"] = {--Just duplicate of normal for now
		[1] = {
			--Static Charge
			[381615] = {15, 35, 40, 30},
			--Volatile Current
			[388643] = {85, 47},
			--Lightning Breath
			[377594] = {23, 39, 53},
			--Hurricane Wing
			[377612] = {35, 35, 35},
			--Electrified Jaws
			[377658] = {5, 24.8, 24.9, 30, 17.8, 27.6},
		},
		[2] = {
			--Volatile Current
			[388643] = {60, 49.9},
			--Electrified Jaws
			[377658] = {30, 24.9, 22.9, 30, 25, 25, 37},
			--Stormsurge
			[387261] = {0, 80, 80, 80},--First cast immediately
			--Fulminating Charge
			[378829] = {44, 85.9},
			--Tempest Wing
			[385574] = {35, 35, 49.9, 24.9, 55},
		},
		[3] = {
			--Storm Eater (Mythic Only)
			[395885] = {},
			--Lightning Breath
			[377594] = {28.7, 41, 41.9},
			--Tempest Wing
			[385574] = {60.7, 58.9, 26.9},
			--Fulminating Charge
			[378829] = {35.7, 60},
			--Thunderous blast
			[386410] = {16.7, 30, 30, 30, 30},
			--Magnetic Charge (Heroic/Mythic Only)
			[399713] = {},
		},
	},
	["heroic"] = {--Just duplicate of normal for now
		[1] = {
			--Static Charge
			[381615] = {15.0, 35.0, 36.9, 34.1, 33.9},
			--Volatile Current
			[388643] = {80.0, 55.0}, -- Volatile Current
			--Lightning Breath
			[377594] = {23.4, 39.0, 53.1, 51.0}, -- Lightning Breath
			--Hurricane Wing
			[377612] = {35, 35, 35, 35, 35}, -- Hurricane Wing
			--Electrified Jaws
			[377658] = {6.5, 24.9, 25.0, 30.0, 18.0, 27.0, 30.0}, -- Electrified Jaws
		},
		[2] = {
			--Volatile Current
			[388643] = {57, 57},--Different from normal
			--Electrified Jaws
			[377658] = {29.9, 24.4, 22.9, 30.7, 24.2, 25.8},--Same as normal
			--Stormsurge
			[387261] = {0, 80, 80, 80},--Same as normal, First cast immediately
			--Fulminating Charge
			[378829] = {45, 82.5},--Same as normal
			--Tempest Wing
			[385574] = {35, 30, 55, 19.5},--Different from normal
		},
		[3] = {--IFFY, vod that changed angles and PoV many times was used for these
			--Storm Eater (Mythic Only)
			[395885] = {},
			--Lightning Breath
			[377594] = {43},
			--Tempest Wing
			[385574] = {76, 65},
			--Fulminating Charge
			[378829] = {53, 60},
			--Thunderous blast
			[386410] = {32, 31, 30, 29},
			--Magnetic Charge (Heroic/Mythic Only)
			[399713] = {38, 63, 33},
		},
	},
	["normal"] = {
		[1] = {
			--Static Charge
			[381615] = {15, 35, 40, 30},
			--Volatile Current
			[388643] = {85, 47},
			--Lightning Breath
			[377594] = {23, 39, 53},
			--Hurricane Wing
			[377612] = {35, 35, 35},
			--Electrified Jaws
			[377658] = {5, 25, 25, 27, 21, 27},
		},
		[2] = {
			--Volatile Current
			[388643] = {60, 49.9},
			--Electrified Jaws
			[377658] = {30, 24.9, 22.9, 30, 25, 25, 37},
			--Stormsurge
			[387261] = {0, 80, 80, 80},--First cast immediately
			--Fulminating Charge
			[378829] = {44, 85.9},
			--Tempest Wing
			[385574] = {35, 35, 49.9, 24.9, 55},
		},
		[3] = {
			--Storm Eater (Mythic Only)
			[395885] = {},
			--Lightning Breath
			[377594] = {28.7, 41, 41.9},
			--Tempest Wing
			[385574] = {60.7, 58.9, 26.9},
			--Fulminating Charge
			[378829] = {35.7, 60},
			--Thunderous blast
			[386410] = {16.7, 30, 30, 30, 30},
			--Magnetic Charge (Heroic/Mythic Only)
			[399713] = {},
		},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.energyCount = 0
	self.vb.chargeCount = 0
	self.vb.currentCount = 0
	self.vb.tankCount = 0
	self.vb.breathCount = 0
	self.vb.strikeCount = 0
	timerElectrifiedJawsCD:Start(5-delay, 1)
	timerStaticChargeCD:Start(15-delay, 1)
	timerLightningBreathCD:Start(23-delay, 1)
	timerHurricaneWingCD:Start(35-delay, 1)
	timerVolatileCurrentCD:Start(85-delay, 1)
	if self.Options.NPAuraOnAscension or self.Options.NPAuraOnFlameShield then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
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

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 377612 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnHurricaneWing:Show(self.vb.energyCount)
		specWarnHurricaneWing:Play("pushbackincoming")
		specWarnHurricaneWing:ScheduleVoice(1.5, "movecenter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.energyCount+1) or 35
		if timer then
			timerHurricaneWingCD:Start(timer, self.vb.energyCount+1)
		end
	elseif spellId == 388643 then
		self.vb.currentCount = self.vb.currentCount + 1
		specWarnVolatileCurrent:Show(self.vb.currentCount)
		specWarnVolatileCurrent:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.currentCount+1) or 35
		if timer then
			timerVolatileCurrentCD:Start(timer, self.vb.currentCount+1)
		end
	elseif spellId == 377658 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnElectrifiedJaws:Show()
			specWarnElectrifiedJaws:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerElectrifiedJawsCD:Start(timer, self.vb.tankCount+1)
		end
	elseif spellId == 377594 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnLightingBreath:Show(self.vb.breathCount)
		specWarnLightingBreath:Play("breathsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.breathCount+1)
		if timer then
			timerLightningBreathCD:Start(timer, self.vb.breathCount+1)
		end
	elseif spellId == 385065 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnLightningDevastation:Show(self.vb.breathCount)
		specWarnLightningDevastation:Play("breathsoon")
		timerLightningDevastationCD:Start(self.vb.phase == 1.5 and 13.3 or 32.7)
	elseif spellId == 397382 then
		self.vb.shroudIcon = 1
		timerShatteringShroudCD:Start(nil, args.sourceGUID)
	elseif spellId == 397468 then
		warnBlazingroar:Show()
	elseif spellId == 387261 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnStormsurge:Show(self.vb.energyCount)
		specWarnStormsurge:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.energyCount+1) or 80
		if timer then
			timerStormsurgeCD:Start(timer, self.vb.energyCount+1)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 385574 then
		self.vb.wingCount = self.vb.wingCount + 1
		specWarnTempestWing:Show(self.vb.wingCount)
		specWarnTempestWing:Play("pushbackincoming")
		specWarnTempestWing:ScheduleVoice(1.5, "movecenter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.wingCount+1)
		if timer then
			timerTempestWingCD:Start(timer, self.vb.wingCount+1)
		end
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
		timerStormEaterCD:Start()--Temp
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.energyCount+1)
--		if timer then
--			timerStormEaterCD:Start(timer, self.vb.energyCount+1)
--		end
	elseif spellId == 386410 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnThunderousBlast:Show()
			specWarnThunderousBlast:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1) or 30
		if timer then
			timerThunderousBlastCD:Start(timer, self.vb.tankCount+1)
		end
	elseif spellId == 382434 or spellId == 390463 then
		specWarnStormNova:Show()
		specWarnStormNova:Play("carefly")
		timerStormNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 381615 and self:AntiSpam(5, 1) then
		self.vb.chargeIcon = 1
		self.vb.chargeCount = self.vb.chargeCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.chargeCount+1)
		if timer then
			timerStaticChargeCD:Start(timer, self.vb.chargeCount+1)
		end
	elseif spellId == 396037 then
		timerSurgingBlastCD:Start(nil, args.sourceGUID)
	elseif spellId == 378829 then
		self.vb.chargeIcon = 1
		self.vb.chargeCount = self.vb.chargeCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.chargeCount+1)
		if timer then
			timerFulminatingChargeCD:Start(timer, self.vb.chargeCount+1)
		end
	elseif spellId == 399713 then
		self.vb.magneticIcon = 4
		self.vb.magneticCount = self.vb.magneticCount + 1
		timerMagneticChargeCD:Start()
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.magneticCount+1)
--		if timer then
--			timerMagneticChargeCD:Start(timer, self.vb.magneticCount+1)
--		end
	elseif spellId == 381249 and self.vb.phase == 1.5 then--Pre stage 2 trigger
		timerStormsurgeCD:Start(8.5, 1)--Started here so it actually has timer
	elseif spellId == 181089 then--Encounter event
		self:SetStage(0.5)
		if self.vb.phase == 1.5 then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			self.vb.breathCount = 0--Reused for Lightning Devastation
			timerHurricaneWingCD:Stop()
			timerStaticChargeCD:Stop()
			timerVolatileCurrentCD:Stop()
			timerElectrifiedJawsCD:Stop()
			timerLightningBreathCD:Stop()

			timerLightningDevastationCD:Start(7.3, 1)
		elseif self.vb.phase == 2 then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
			self.vb.energyCount = 0
			self.vb.currentCount = 0
			self.vb.tankCount = 0
			self.vb.strikeCount = 0
			self.vb.wingCount = 0
			self.vb.chargeCount = 0

			timerLightningDevastationCD:Stop()

			timerElectrifiedJawsCD:Start(29.9, 1)
			timerTempestWingCD:Start(35, 1)
			timerFulminatingChargeCD:Start(44, 1)
			timerVolatileCurrentCD:Start(self:IsHard() and 57 or 60, 1)--Only difference on heroic, we'll see on mythic
		elseif self.vb.phase == 2.5 then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
			warnPhase:Play("phasechange")
			self.vb.breathCount = 0--Reused for Lightning Devastation
			timerStormsurgeCD:Stop()
			timerTempestWingCD:Stop()
			timerFulminatingChargeCD:Stop()
			timerVolatileCurrentCD:Stop()
			timerElectrifiedJawsCD:Stop()

			timerLightningDevastationCD:Start(25, 1)
--			timerStormBreakCD:Start(3)
--			timerBallLightningCD:Start(3)
		else--P3
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")

			self.vb.energyCount = 0--Used for Mythic Storm-Eater
			self.vb.chargeCount = 0--Fulminating
			self.vb.tankCount = 0--Thunderous Blast
			self.vb.breathCount = 0--Lightning Breath
			self.vb.strikeCount = 0--Lightning Strike
			self.vb.wingCount = 0
			self.vb.magneticCount = 0

			timerLightningDevastationCD:Stop()
			if self:IsHard() then
				if self:IsMythic() then
					timerStormEaterCD:Start(3)
				end
				timerThunderousBlastCD:Start(32, 1)
				timerLightningBreathCD:Start(43, 1)
				timerFulminatingChargeCD:Start(53, 1)
				timerTempestWingCD:Start(76, 1)
				if self:IsHard() then
					timerMagneticChargeCD:Start(38)
				end
			else
				timerStormEaterCD:Start(3)
				timerThunderousBlastCD:Start(16.7, 1)
				timerLightningBreathCD:Start(28.7, 1)
				timerFulminatingChargeCD:Start(35.7, 1)
				timerTempestWingCD:Start(60, 1)
			end
		end
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
	elseif spellId == 399713 then
		local icon = self.vb.magneticIcon
		if self.Options.SetIconOnMagneticCharge then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMagneticCharge:Show(self:IconNumToTexture(icon))
			specWarnMagneticCharge:Play("mm"..icon)
			yellMagneticCharge:Yell(icon, icon)
			yellMagneticChargeFades:Countdown(spellId, nil, icon)
		end
		warnMagneticCharge:CombinedShow(0.5, args.destName)
		self.vb.magneticIcon = self.vb.magneticIcon + 1
	elseif spellId == 391285 and not args:IsPlayer() then
		specWarnMeltedArmor:Show(args.destName)
		specWarnMeltedArmor:Play("tauntboss")
	elseif spellId == 391281 and self:AntiSpam(5, 2) then--Colossal Stormfiend being engaged
		timerBallLightningCD:Start(8.4, args.destGUID)
		timerStormBreakCD:Start(21.8, args.destGUID)
	elseif spellId == 391402 then
		warnLightningStrike:Show()
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
	elseif spellId == 399713 then
		if self.Options.SetIconOnMagneticCharge then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMagneticChargeFades:Cancel()
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
