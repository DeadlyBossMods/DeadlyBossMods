local mod	= DBM:NewMod(2499, "DBM-Raids-Dragonflight", 3, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189492)
mod:SetEncounterID(2607)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20230117000000)
mod:SetMinSyncRevision(20221217000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 377612 388643 377658 377594 385065 385553 397382 397468 387261 385574 389870 385068 395885 386410 382434 390463",
	"SPELL_CAST_SUCCESS 381615 396037 399713 181089 381249 378829 382434 390463",
	"SPELL_AURA_APPLIED 381615 388631 395906 388115 396037 385541 397382 397387 388691 391990 394574 394576 391991 394579 394575 394582 391993 394584 377467 395929 391285 399713 391281 389214 389878 394583 391402",
	"SPELL_AURA_APPLIED_DOSE 389878",
	"SPELL_AURA_REMOVED 381615 396037 385541 397382 397387 388691 377467 399713 391990 394574 394576 391991 394579 394575 394584",
	"SPELL_PERIODIC_DAMAGE 395929",
	"SPELL_PERIODIC_MISSED 395929",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, track and alert high stacks of https://www.wowhead.com/beta/spell=385560/windforce-strikes on Oathsworn?
--TODO, determine number adds and spawn behavior for auto marking Stormseeker Acolyte for interrupt assignments?
--TODO, use specWarnScatteredCharge once coding is verified it's being avoided for now to avoid SW spam
--[[
(ability.id = 377612 or ability.id = 388643 or ability.id = 377658 or ability.id = 377594
 or ability.id = 385065 or ability.id = 397382 or ability.id = 397468 or ability.id = 387261 or ability.id = 385574 or ability.id = 389870
 or ability.id = 385068 or ability.id = 395885 or ability.id = 386410 or ability.id = 382434 or ability.id = 390463) and type = "begincast"
 or (ability.id = 381615 or ability.id = 396037 or ability.id = 378829 or ability.id = 399713 or ability.id = 382434 or ability.id = 390463 or ability.id = 381249) and type = "cast"
 or ability.id = 388431 or ability.id = 396734
 or ability.id = 181089 and type = "cast" or ability.id = 388691 and type = "removebuff"
 or (ability.id = 391281 or ability.id = 391402 or ability.id = 389214 or ability.id = 397387) and type = "applybuff"
 or (ability.id = 394584 or ability.id = 397382) and type = "applydebuff"
 or ability.id = 382530 and (type = "applybuff" or type = "removebuff")
--]]
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(388115, nil, nil, nil, 1, 8)

local timerPhaseCD								= mod:NewPhaseTimer(30)
--local berserkTimer							= mod:NewBerserkTimer(600)

--Stage One: The Winds of Change
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25244))
local warnStaticCharge							= mod:NewTargetNoFilterAnnounce(381615, 3)
local warnLightningStrike						= mod:NewSpellAnnounce(376126, 3)

local specWarnHurricaneWing						= mod:NewSpecialWarningCount(377612, nil, nil, nil, 2, 13)
local specWarnStaticCharge						= mod:NewSpecialWarningYouPos(381615, nil, 37859, nil, 1, 2)
local yellStaticCharge							= mod:NewShortPosYell(381615, 37859)
local yellStaticChargeFades						= mod:NewIconFadesYell(381615, 37859)
local specWarnVolatileCurrent					= mod:NewSpecialWarningMoveAwayCount(388643, nil, 384738, nil, 2, 2)--"Sparks"
local specWarnElectrifiedJaws					= mod:NewSpecialWarningDefensive(395906, nil, nil, nil, 1, 2)
local specWarnElectrifiedJawsOther				= mod:NewSpecialWarningTaunt(395906, nil, nil, nil, 1, 2)
local specWarnLightingBreath					= mod:NewSpecialWarningDodgeCount(377594, nil, 18357, nil, 2, 2)

local timerHurricaneWingCD						= mod:NewCDCountTimer(35, 377612, nil, nil, nil, 2)
local timerStaticChargeCD						= mod:NewCDCountTimer(35, 381615, 167180, nil, nil, 3)--"Bombs"
local timerStaticCharge							= mod:NewCastTimer(35, 381615, 167180, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--"Bombs"
local timerVolatileCurrentCD					= mod:NewCDCountTimer(47, 388643, 384738, nil, nil, 3)
local timerElectrifiedJawsCD					= mod:NewCDCountTimer(25, 395906, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerLightningBreathCD					= mod:NewCDCountTimer(35, 377594, 18357, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddSetIconOption("SetIconOnStaticCharge", 381615, true, 0, {1, 2, 3})
--Intermission: The Primalist Strike
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25683))
--Raszageth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25402))
local warnLightningDevastation					= mod:NewCountAnnounce(385065, 3, nil, nil, 125030)--NOT on our platform

local specWarnStormNova							= mod:NewSpecialWarningSpell(382434, nil, nil, nil, 2, 2)
local specWarnLightningDevastation				= mod:NewSpecialWarningDodgeCount(385065, nil, 125030, nil, 3, 2)--On our platform!

local timerStormNovaCD							= mod:NewCDTimer(5, 382434, nil, nil, nil, 2)
local timerStormNova							= mod:NewCastTimer(5, 382434, nil, nil, nil, 5)
local timerLightningDevastationCD				= mod:NewCDCountTimer(13.3, 385065, 125030, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddBoolOption("SetBreathToBait", false)
--Primalist Forces
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25638))
local warnSurgingBlast							= mod:NewTargetAnnounce(396037, 3)
local warnShatteringShroud						= mod:NewTargetNoFilterAnnounce(397382, 4)
local warnShatteringShroudFaded					= mod:NewFadesAnnounce(397382, 1)
--local warnBlazingroar							= mod:NewCastAnnounce(397468, 4)--Redundant, it casts at same time as flame shield

local specWarnSurgingBlast						= mod:NewSpecialWarningMoveAway(396037, nil, 37859, nil, 1, 2)
local yellSurgingBlast							= mod:NewShortYell(396037, 37859)
local yellSurgingBlastFades						= mod:NewShortFadesYell(396037, 37859)
--local specWarnStormBolt							= mod:NewSpecialWarningInterruptCount(385553, "HasInterrupt", nil, nil, 1, 2)
local specWarnShatteringShroud					= mod:NewSpecialWarningYou(397382, nil, nil, nil, 1, 2, 4)
local specWarnFlameShield						= mod:NewSpecialWarningSwitch(397387, nil, nil, nil, 1, 2, 4)

local timerSurgingBlastCD						= mod:NewCDTimer(12.4, 396037, 37859, false, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerShatteringShroudCD					= mod:NewCDSourceTimer(35, 397382, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFlameShieldCD						= mod:NewCDSourceTimer(35, 397387, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnShatteringShroud2", 397382, false, 0, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnAscension", 385541)
mod:AddNamePlateOption("NPAuraOnFlameShield", 397387)
--Stage Two: Surging Power
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25312))
local warnStormsurge						= mod:NewEndAnnounce(387261, 1)
local warnInversion							= mod:NewTargetAnnounce(394584, 4)
local warnFocusedCharge						= mod:NewYouAnnounce(394582, 1)
local warnScatteredCharge					= mod:NewYouAnnounce(394583, 4)
local warnFulminatingCharge					= mod:NewTargetNoFilterAnnounce(377467, 3, nil, nil, 345338)

local specWarnStormsurge					= mod:NewSpecialWarningMoveAwayCount(387261, nil, nil, nil, 2, 2)--Maybe shorttext 28089?
local specWarnPositiveCharge				= mod:NewSpecialWarningYou(391990, nil, nil, nil, 1, 13)--Split warning so user can custom sounds
local specWarnNegativeCharge				= mod:NewSpecialWarningYou(391991, nil, nil, nil, 1, 13)--between positive and negative
local yellStormCharged						= mod:NewIconRepeatYell(391989)
local specWarnInversion						= mod:NewSpecialWarningMoveAway(394584, nil, nil, nil, 3, 13, 4)
local yellInversion							= mod:NewIconRepeatYell(394584)
--local specWarnScatteredCharge				= mod:NewSpecialWarningMoveAway(394583, nil, nil, nil, 1, 2)
local specWarnTempestWing					= mod:NewSpecialWarningCount(385574, nil, 63533, nil, 2, 2)--"Storm Wave"
local specWarnFulminatingCharge				= mod:NewSpecialWarningYouPos(377467, nil, 221175, nil, 1, 2)--"Charge" shortname
local yellFulminatingCharge					= mod:NewShortPosYell(377467, 221175)--"Charge" shortname
local yellFulminatingChargeFades			= mod:NewIconFadesYell(377467, 221175)--"Charge" shortname

local timerStormsurgeCD						= mod:NewCDCountTimer(35, 387261, nil, nil, nil, 2)--Maybe shorttext 28089?
local timerTempestWingCD					= mod:NewCDCountTimer(35, 385574, 63533, nil, nil, 3)
local timerFulminatingChargeCD				= mod:NewCDCountTimer(35, 377467, 345338, nil, nil, 3)--shortname "Charges"
local timerInversionCD						= mod:NewCDCountTimer(6, 394584, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnFulminatingCharge", 377467, true, 0, {1, 2, 3})
mod:AddInfoFrameOption(387261, true)
mod:GroupSpells(391989, 391990, 391991, 394584)--Group positive and negative spellIds under parent category "Stormcharged"
--Intermission: The Vault Falters
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25812))
--Colossal Stormfiend
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25816))
local warnFuse								= mod:NewStackAnnounce(389878, 2, nil, "Tank|Healer")
local warnStormBreak						= mod:NewCountAnnounce(389870, 3, nil, nil, 7794)--Shortname Teleport

local specWarnBallLightning					= mod:NewSpecialWarningDodge(385068, nil, nil, nil, 2, 2)

local timerLightningStrikeCD				= mod:NewCDTimer(31.6, 376126, nil, nil, nil, 3)
local timerStormBreakCD						= mod:NewCDCountTimer(23.1, 389870, 7794, nil, nil, 3)
local timerBallLightningCD					= mod:NewCDCountTimer(23.1, 385068, nil, nil, nil, 3)
--Stage Three: Storm Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25477))
local warnMagneticCharge					= mod:NewTargetNoFilterAnnounce(399713, 3)

local specWarnStormEater					= mod:NewSpecialWarningSpell(395885, nil, nil, nil, 2, 2, 4)
local specWarnThunderousBlast				= mod:NewSpecialWarningDefensive(386410, nil, 309024, nil, 1, 2)--"Blast"
local specWarnThunderstruckArmor			= mod:NewSpecialWarningTaunt(391285, nil, nil, nil, 1, 2)
local specWarnMagneticCharge				= mod:NewSpecialWarningYou(399713, nil, nil, nil, 1, 2)
local yellMagneticCharge					= mod:NewShortYell(399713)
local yellMagneticChargeFades				= mod:NewShortFadesYell(399713)

local timerStormEaterCD						= mod:NewCDTimer(35, 395885, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerMagneticChargeCD					= mod:NewCDCountTimer(35, 399713, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerThunderousBlastCD				= mod:NewCDCountTimer(35, 386410, 309024, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnMagneticCharge", 399713, true, 0, {4})
mod:GroupSpells(386410, 391285)--Thunderous Blast and associated melted armor debuff

--P1
mod.vb.energyCount = 0--Reused for the 100 energy special in stage 1/2 and mythic storm eater mechanic in stage 3
mod.vb.chargeCount = 0--Static Charge/Fulminating Charge
mod.vb.chargeIcon = 1--Static Charge/Fulminating Charge
mod.vb.currentCount = 0
mod.vb.tankCount = 0--Electrified Jaws/Thunderous Blast
mod.vb.breathCount = 0--Reused in P1.5 intermission
mod.vb.strikeCount = 0
mod.vb.frostAddCount = 0
mod.vb.fireAddCount = 0
--P2
mod.vb.shroudIcon = 1
mod.vb.wingCount = 0
--P2.5
mod.vb.stormSurgeCount = 0
mod.vb.ballCount = 0
--P3
mod.vb.magneticCount = 0
local castsPerGUID = {}
local playerPolarity = nil
local difficultyName = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			--Static Charge
			[381615] = {15, 35, 37, 33, 35, 37, 33},
			--Volatile Current
			[388643] = {28, 53, 46, 59, 46},
			--Lightning Breath
			[377594] = {20, 25, 19, 26, 24, 20, 16, 18, 27, 24, 20},
			--Hurricane Wing
			[377612] = {35, 35, 35, 35, 35, 35},
			--Electrified Jaws
			[377658] = {5, 27, 23, 30, 17, 30, 28, 30, 19, 28},
		},
		[2] = {
			--Volatile Current
			[388643] = {67.5, 60, 40},
			--Electrified Jaws
			[377658] = {44.5, 26.9, 21, 29.9, 25, 25},
			--Stormsurge
			[387261] = {14.5, 80, 80},
			--Fulminating Charge
			[378829] = {57.5, 87},
			--Tempest Wing
			[385574] = {49.5, 29.9, 54, 20},
		},
		[3] = {
			--Lightning Breath
			[377594] = {38.1, 41.4, 44, 29.9, 43},
			--Tempest Wing
			[385574] = {70.6, 70, 19.9},
			--Fulminating Charge
			[378829] = {43.2, 61.4, 66.9},
			--Thunderous blast
			[386410] = {28.6, 29, 32, 58.9, 30},
			--Magnetic Charge (Heroic/Mythic Only)
			[399713] = {32.7, 29.9, 32.9, 33},
		},
	},
	["heroic"] = {
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
			[388643] = {61.5, 57},--Different from normal
			--Electrified Jaws
			[377658] = {38.5, 24.4, 22.9, 30, 24.2, 25.8},--Same as normal
			--Stormsurge
			[387261] = {8.5, 80, 80},
			--Fulminating Charge
			[378829] = {53.5, 82.5},--Same as normal
			--Tempest Wing
			[385574] = {43.5, 30, 55, 19.5},--Different from normal
		},
		[3] = {--IFFY, vod that changed angles and PoV many times was used for these
			--Lightning Breath
			[377594] = {43, 33, 54},
			--Tempest Wing
			[385574] = {76, 65},
			--Fulminating Charge
			[378829] = {53, 60},
			--Thunderous blast
			[386410] = {32, 29.9, 30, 29},
			--Magnetic Charge (Heroic/Mythic Only)
			[399713] = {38, 63, 33},
		},
	},
	["normal"] = {--LFR uses same timers
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
		[2] = {--Started at electric Scales
			--Volatile Current
			[388643] = {68.5, 49.9},
			--Electrified Jaws
			[377658] = {38.5, 24.9, 22.9, 30, 25, 25, 37},
			--Stormsurge
			[387261] = {8.5, 80, 80},
			--Fulminating Charge
			[378829] = {53.5, 85.9},
			--Tempest Wing
			[385574] = {43.5, 35, 49.9, 24.9, 55},
		},
		[3] = {
			--Lightning Breath
			[377594] = {28.7, 41, 41.9},--Even if pull stretches on, boss doesn't cast more than 3
			--Tempest Wing
			[385574] = {60.7, 58.9, 26.9, 31},
			--Fulminating Charge
			[378829] = {35.7, 60, 60},
			--Thunderous blast
			[386410] = {16.7, 30, 30, 30, 30, 30},
		},
	},
}

local function breathCorrect(self)
	DBM:Debug("Boss skipped a breath, scheduling next one")
	self:Unschedule(breathCorrect)
	self.vb.breathCount = self.vb.breathCount + 1
	local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 377594, self.vb.breathCount+1)
	if timer then
		timerLightningBreathCD:Start(timer-4, self.vb.breathCount+1)
		self:Schedule(timer, breathCorrect, self)
	end
end

local function warnDeepBreath(self, myPlatform)
	if myPlatform then
		specWarnLightningDevastation:Show(self.vb.breathCount)
		specWarnLightningDevastation:Play("breathsoon")
		if self.vb.phase == 1.5 then--Only fade in first intermission, raid isn't split in second one
			timerLightningDevastationCD:SetSTFade(true, self.vb.breathCount+1)--If it's on this platform this time, next one isn't so we fade timer for next one
		end
	else--No emote, on other platform
		warnLightningDevastation:Show(self.vb.breathCount)
	end
end

local function yellRepeater(self, text, repeatTotal, inversion)
	repeatTotal = repeatTotal + 1
--	if repeatTotal < 3 then
		if inversion then
			yellInversion:Yell(text)
		else
			yellStormCharged:Yell(text)
		end
		self:Schedule(1.5, yellRepeater, self, text, repeatTotal, inversion)
--	end
end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.energyCount = 0
	self.vb.chargeCount = 0
	self.vb.currentCount = 0
	self.vb.tankCount = 0
	self.vb.breathCount = 0
	self.vb.strikeCount = 0
	self.vb.stormSurgeCount = 0
	timerElectrifiedJawsCD:Start(5-delay, 1)
	timerStaticChargeCD:Start(15-delay, 1)
	timerLightningBreathCD:Start(self:IsMythic() and 20 or 23-delay, 1)
	timerHurricaneWingCD:Start(35-delay, 1)
	timerVolatileCurrentCD:Start(self:IsMythic() and 28 or self:IsHeroic() and 80 or 85-delay, 1)
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
	if DBM:UnitDebuff("player", 391990, 394574, 394576) then--Positive
		playerPolarity = 1
	elseif DBM:UnitDebuff("player", 391991, 394579, 394575) then--Negative
		playerPolarity = 2
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 377612 then
		self.vb.energyCount = self.vb.energyCount + 1
		specWarnHurricaneWing:Show(self.vb.energyCount)
		specWarnHurricaneWing:Play("pushbackincoming")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.energyCount+1) or 35
		if timer then
			timerHurricaneWingCD:Start(timer, self.vb.energyCount+1)
		end
	elseif spellId == 388643 then
		self.vb.currentCount = self.vb.currentCount + 1
		specWarnVolatileCurrent:Show(self.vb.currentCount)
		specWarnVolatileCurrent:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.currentCount+1)
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
		self:Unschedule(breathCorrect)
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnLightingBreath:Show(self.vb.breathCount)
		specWarnLightingBreath:Play("breathsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.breathCount+1)
		if timer then
			timerLightningBreathCD:Start(timer, self.vb.breathCount+1)
			self:Schedule(timer+4, breathCorrect, self)
		end
	elseif spellId == 385065 then
		self.vb.breathCount = self.vb.breathCount + 1
		local timer = self.vb.phase == 1.5 and (self:IsMythic() and 9.7 or self:IsHeroic() and 12.1 or 13.3) or (self:IsMythic() and 29 or self:IsHeroic() and 31.5 or 32.7)
		if self.Options.SetBreathToBait then
			timer = timer - 1.5--Sets timer for baiting breath instead of breath activation
		end
		timerLightningDevastationCD:Start(timer, self.vb.breathCount+1)
		self:Unschedule(warnDeepBreath)
		self:Schedule(0.5, warnDeepBreath, self, false)
	elseif spellId == 397382 then
		self.vb.shroudIcon = 1
		--Time between casts not known yet, fix when groups suck really bad
		--timerShatteringShroudCD:Start(nil, castsPerGUID[args.sourceGUID])
		----If not on our side, fade the timer
		--if not self:CheckBossDistance(args.sourceGUID, true, 35278, 80) then
		--	timerShatteringShroudCD:SetSTFade(true, castsPerGUID[args.sourceGUID])
		--else
	elseif spellId == 397468 then
--		warnBlazingroar:Show()
		--TODO, add cast bar though
	elseif spellId == 387261 then
		self.vb.stormSurgeCount = self.vb.stormSurgeCount + 1
		specWarnStormsurge:Show(self.vb.stormSurgeCount)
		specWarnStormsurge:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.stormSurgeCount+1)
		if timer then
			timerStormsurgeCD:Start(timer, self.vb.stormSurgeCount+1)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
		if self:IsMythic() then
			timerInversionCD:Start(8)
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
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		if self:AntiSpam(2, 1) then--Aggregate similtanious teleports
			warnStormBreak:Show(castsPerGUID[args.sourceGUID])
			timerStormBreakCD:Start(nil, castsPerGUID[args.sourceGUID]+1)
		end
	elseif spellId == 385068 and self:AntiSpam(5, 2) then
		self.vb.ballCount = self.vb.ballCount + 1
		specWarnBallLightning:Show(self.vb.ballCount)
		specWarnBallLightning:Play("watchorb")
		--8.4, 26.7, 23, 23. sometimes 3rd one also delayed more but first one consistently is
		if self.vb.ballCount == 1 then
			timerBallLightningCD:Start(26.7, self.vb.ballCount+1)
		else
			timerBallLightningCD:Start(23, self.vb.ballCount+1)
		end
	elseif spellId == 395885 then
		specWarnStormEater:Show()
		specWarnStormEater:Play("helpsoak")--Clarify voice when number of soakers and need to soak better understood
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
	if spellId == 381615 and self:AntiSpam(5, 3) then
		self.vb.chargeIcon = 1
		self.vb.chargeCount = self.vb.chargeCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.chargeCount+1)
		if timer then
			timerStaticChargeCD:Start(timer, self.vb.chargeCount+1)
		end
		timerStaticCharge:Start(8)
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
		self.vb.magneticCount = self.vb.magneticCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.magneticCount+1)
		if timer then
			timerMagneticChargeCD:Start(timer, self.vb.magneticCount+1)
		end
	elseif spellId == 382434 then--First intermission Starts (Storm Nova finished)
		self:SetStage(1.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self.vb.breathCount = 0--Reused for Lightning Devastation

		if self.Options.SetBreathToBait then
			timerLightningDevastationCD:Start(self:IsMythic() and 11.3 or 11.7, 1)
		else
			timerLightningDevastationCD:Start(self:IsMythic() and 12.8 or 13.2, 1)
		end
		timerPhaseCD:Start(self:IsMythic() and 93.3 or 100)
	elseif spellId == 381249 and self:GetStage(1.5) then--Pre stage 2 trigger (Electric Scales)
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.energyCount = 0
		self.vb.currentCount = 0
		self.vb.tankCount = 0
		self.vb.strikeCount = 0
		self.vb.wingCount = 0
		self.vb.chargeCount = 0

		timerLightningDevastationCD:Stop()
		timerPhaseCD:Stop()

		if self:IsMythic() then--Post Dec 22nd hotfix, Mythic stage 2 now starts 6 seconds slower than other difficulties to allow more time to wrap up intermission
			timerStormsurgeCD:Start(14.5, 1)
			timerElectrifiedJawsCD:Start(44.5, 1)
			timerTempestWingCD:Start(49.5, 1)
			timerFulminatingChargeCD:Start(57.5, 1)
			timerVolatileCurrentCD:Start(67.5, 1)
--			timerPhaseCD:Start(190)--Basically ends on 3rd stormsurge being removed
		else
			timerStormsurgeCD:Start(8.5, 1)
			timerElectrifiedJawsCD:Start(38.5, 1)
			timerTempestWingCD:Start(43.5, 1)
			timerFulminatingChargeCD:Start(52.5, 1)
			timerVolatileCurrentCD:Start(self:IsHeroic() and 65.5 or 68.5, 1)--Only difference on heroic
			timerPhaseCD:Start(self:IsHeroic() and 193 or 211)
		end
	elseif spellId == 390463 then--Second Intermission Ends Storm Nova
		self:SetStage(3)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")

		self.vb.energyCount = 0--Used for Mythic Storm-Eater
		self.vb.chargeCount = 0--Fulminating
		self.vb.tankCount = 0--Thunderous Blast
		self.vb.breathCount = 0--Lightning Breath
		self.vb.strikeCount = 0--Lightning Strike
		self.vb.wingCount = 0
		self.vb.magneticCount = 0

		if self:IsMythic() then
			timerStormEaterCD:Start(21.7)--Cast only once, then persistent aura
			timerThunderousBlastCD:Start(28.6, 1)
			timerMagneticChargeCD:Start(32.7)
			timerLightningBreathCD:Start(38.1, 1)
			timerFulminatingChargeCD:Start(43.2, 1)
			timerTempestWingCD:Start(70.6, 1)
		elseif self:IsHeroic() then
			timerThunderousBlastCD:Start(21.8, 1)
			timerMagneticChargeCD:Start(25.9)
			timerLightningBreathCD:Start(31.3, 1)
			timerFulminatingChargeCD:Start(40.9, 1)
			timerTempestWingCD:Start(65.9, 1)
		else
			timerThunderousBlastCD:Start(22.5, 1)
			timerLightningBreathCD:Start(34.5, 1)
			timerFulminatingChargeCD:Start(41.5, 1)
			timerTempestWingCD:Start(66.4, 1)
		end
	elseif spellId == 181089 and self:GetStage(2) and self.vb.stormSurgeCount > 0 then--Encounter event
		--This is now only used for 2.5 since other stages have earlier events to use
		--But we need to be very specific WHEN to use this event since it fires 7x on fight
		self:SetStage(2.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
		warnPhase:Play("phasechange")
		self.vb.breathCount = 0--Reused for Lightning Devastation
		self.vb.ballCount = 0
		timerStormsurgeCD:Stop()
		timerTempestWingCD:Stop()
		timerFulminatingChargeCD:Stop()
		timerVolatileCurrentCD:Stop()
		timerElectrifiedJawsCD:Stop()

		timerLightningStrikeCD:Start(4.8)
		if self.Options.SetBreathToBait then
			timerLightningDevastationCD:Start(22.8, 1)
		else
			timerLightningDevastationCD:Start(24.3, 1)
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
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--Filter idiots in front of boss that aren't tank.
			specWarnElectrifiedJawsOther:Show(args.destName)
			specWarnElectrifiedJawsOther:Play("tauntboss")
		end
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
		--Time between casts not known yet, fix when groups suck really bad
		--timerFlameShieldCD:Start(nil, castsPerGUID[args.sourceGUID])
		--if not self:CheckBossDistance(args.sourceGUID, true, 35278, 80) then
		--	--Not our platform, set fade, which fades out timer and disables countdowns for it
		--	timerFlameShieldCD:SetSTFade(true, castsPerGUID[args.sourceGUID])
		--end
		if self.Options.NPAuraOnFlameShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 397382 then
		local icon = self.vb.shroudIcon
		if self.Options.SetIconOnShatteringShroud2 then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnShatteringShroud:Show()
			specWarnShatteringShroud:Play("targetyou")
		end
		if not self:CheckBossDistance(args.sourceGUID, true, 35278, 80) then
			warnShatteringShroud:CombinedShow(0.5, args.destName)
		end
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
			yellStormCharged:Yell(6, "")--Blue Square
			self:Unschedule(yellRepeater)
			yellRepeater(self, 6, 0)
			playerPolarity = 1--Positive
		end
	elseif args:IsSpellID(391991, 394579, 394575) then--All variants of positive
		if args:IsPlayer() then
			specWarnNegativeCharge:Show()
			specWarnNegativeCharge:Play("negative")
			yellStormCharged:Yell(7, "")--Red X
			self:Unschedule(yellRepeater)
			yellRepeater(self, 7, 0)
			playerPolarity = 2--Negative
		end
	elseif spellId == 394584 then
		warnInversion:CombinedShow(0.3, args.destName)
		if self:AntiSpam(4, 5) then
			timerInversionCD:Start(6)
		end
		if args:IsPlayer() then
			specWarnInversion:Show()
			specWarnInversion:Play("polarityshift")
			self:Unschedule(yellRepeater)
			--Invert the yell based on player debuff
			if playerPolarity then
				yellRepeater(self, playerPolarity == 1 and 7 or 8, 0, true)
			end
		end
	elseif spellId == 394582 and args:IsPlayer() and self:AntiSpam(3, 6) then
		warnFocusedCharge:Show()
	elseif spellId == 394583 and args:IsPlayer() then
		warnScatteredCharge:Show()
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
		if self.Options.SetIconOnMagneticCharge then
			self:SetIcon(args.destName, 4)
		end
		if args:IsPlayer() then
			specWarnMagneticCharge:Show()
			specWarnMagneticCharge:Play("targetyou")
			yellMagneticCharge:Yell()
			yellMagneticChargeFades:Countdown(spellId)
		end
		warnMagneticCharge:Show(args.destName)
	elseif spellId == 391285 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--Filter idiots in front of boss that aren't tank.
			specWarnThunderstruckArmor:Show(args.destName)
			specWarnThunderstruckArmor:Play("tauntboss")
		end
	elseif spellId == 391281 and self:AntiSpam(5, 7) then--Crackling Energy/Colossal Stormfiends being engaged
		timerBallLightningCD:Start(8.4, 1)
		timerStormBreakCD:Start(21.8, 1)
	elseif spellId == 391402 then
		warnLightningStrike:Show()
		timerLightningStrikeCD:Start(self:IsMythic() and 29.1 or self:IsHeroic() and 31.5 or 32.8)
	elseif spellId == 389214 then--Overload
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 199547 then--Frostforged Zealot
			self.vb.frostAddCount = self.vb.frostAddCount + 1
			castsPerGUID[args.destGUID] = self.vb.frostAddCount
			timerShatteringShroudCD:Start(7.4, castsPerGUID[args.destGUID])--7.4-8.2
			if not self:CheckBossDistance(args.destGUID, true, 35278, 80) then
				timerShatteringShroudCD:SetSTFade(true, castsPerGUID[args.destGUID])
			end
		elseif cid == 199549 then--Flamesworn Herald
			self.vb.fireAddCount = self.vb.fireAddCount + 1
			castsPerGUID[args.destGUID] = self.vb.fireAddCount
			timerFlameShieldCD:Start(6.4, castsPerGUID[args.destGUID])--6.4-7.6
			if not self:CheckBossDistance(args.destGUID, true, 35278, 80) then
				timerFlameShieldCD:SetSTFade(true, castsPerGUID[args.destGUID])
			end
		end
	elseif spellId == 389878 then
		warnFuse:Cancel()
		warnFuse:Schedule(2, args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
		if self.Options.SetIconOnShatteringShroud2 then
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
	elseif spellId == 394584 or args:IsSpellID(391990, 394574, 394576) or args:IsSpellID(391991, 394579, 394575) then--All variants of positive, negative, and inversion
		if args:IsPlayer() then
			self:Unschedule(yellRepeater)
			playerPolarity = nil
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
		timerShatteringShroudCD:Stop(castsPerGUID[args.destGUID])
		castsPerGUID[args.destGUID] = nil
	elseif cid == 199549 then--Flamesworn Herald
		timerFlameShieldCD:Stop(castsPerGUID[args.destGUID])
		castsPerGUID[args.destGUID] = nil
	elseif cid == 197145 or cid == 200943 then--Colossal Stormfiend
		castsPerGUID[args.destGUID] = nil
	end
end

--"<330.41 11:01:55> [CHAT_MSG_RAID_BOSS_EMOTE] Raszageth takes a deep breath...#Raszageth###Raszageth##0#0##0#1502#nil#0#false#false#false#false", -- [17507]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if not msg:find("ICON") and npc == target and (self:GetStage(1.5) or self:GetStage(2.5)) then--This needs vetting, if p2 and p3 mythic have no emotes missing icons, this will work without localizing
--	if msg:find(L.BreathEmote) or msg == L.BreathEmote then
		self:Unschedule(warnDeepBreath)
		warnDeepBreath(self, true)
	end
end

--Purely for earlier timer canceling, new timers not started on USCS if it can be helped, otherwise timers can't be updated easily from WCLs
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 396734 and self:GetStage(1) then--Storm Shroud
		timerHurricaneWingCD:Stop()
		timerStaticChargeCD:Stop()
		timerVolatileCurrentCD:Stop()
		timerElectrifiedJawsCD:Stop()
		timerLightningBreathCD:Stop()
		self:Unschedule(breathCorrect)

		timerStormNovaCD:Start(13.4)
	elseif spellId == 398466 then--[DNT] Clear Raszageth Auras on Players (Intermission 2 end)
		timerStormBreakCD:Stop()
		timerBallLightningCD:Stop()
		timerLightningStrikeCD:Stop()
		timerLightningDevastationCD:Stop()
		timerStormNovaCD:Start(4.8)
	end
end
