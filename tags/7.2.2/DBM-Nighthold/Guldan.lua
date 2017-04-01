local mod	= DBM:NewMod(1737, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104154)--104537 (Fel Lord Kuraz'mal)
mod:SetEncounterID(1866)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(16028)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206219 206220 206514 206675 206840 207938 104534 208545 209270 211152 208672 206744 206883 206221 206222 221783 211439 220957 227008 221408 221486",
	"SPELL_CAST_SUCCESS 206222 206221 221783 212258 227008 221336 221486",
	"SPELL_AURA_APPLIED 206219 206220 209011 206354 206384 209086 208903 211162 221891 208802 221606 221603 221785 221784 212686 227427 206516 206847 206983 206458 227009",
	"SPELL_AURA_APPLIED_DOSE 211162 208802",
	"SPELL_AURA_REMOVED 209011 206354 206384 209086 221603 221785 221784 212686 221606 206847 206458",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, if anquished spirits is important, add a timer. if not, remove warning.
--TODO, Do a bunch of stuff with well of souls? infoframe to track stacks/who should soak next?
--TODO, infoframe for TimeStop (206310) used correctly/well?
--TODO, maybe add a 'watch orb" warning to chaos seed?
--TODO, new voice "Get Stop Time" (getstoptime)
--[[
(ability.id = 206219 or ability.id = 206220 or ability.id = 206514 or ability.id = 206675 or ability.id = 206840 or ability.id = 207938 or ability.id = 206883 or ability.id = 208545 or ability.id = 209270 or ability.id = 211152 or ability.id = 208672 or ability.id = 167819 or ability.id = 206939 or ability.id = 206744) and type = "begincast"
or (ability.id = 206222 or ability.id = 206221 or ability.id = 221783 or ability.id = 212258) and type = "cast"
or (ability.id = 227427 or ability.id = 206516) and type = "applybuff"
or (ability.id = 227427 or ability.id = 206516) and type = "removebuff"
--]]

local Kurazmal = EJ_GetSectionInfo(13121)
local Vethriz = EJ_GetSectionInfo(13124)
local Dzorykx = EJ_GetSectionInfo(13129)

--Stage One: The Council of Elders
----Gul'dan
local warnLiquidHellfire			= mod:NewCastAnnounce(206219, 3)
----Inquisitor Vethriz
local warnGazeofVethriz				= mod:NewSpellAnnounce(206840, 3)
local warnShadowblink				= mod:NewSpellAnnounce(207938, 2)
----D'zorykx the Trapper
local warnSoulVortex				= mod:NewTargetAnnounce(206883, 3)
local warnAnguishedSpirits			= mod:NewSpellAnnounce(208545, 2)
--Stage Two: The Ritual of Aman'thul
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnBondsofFel				= mod:NewTargetAnnounce(206222, 3)
local warnEmpBondsofFel				= mod:NewTargetAnnounce(209086, 4)
--Stage Three: The Master's Power
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnSoulSiphon				= mod:NewTargetAnnounce(221891, 3, nil, "Healer")
local warnFlamesofSargeras			= mod:NewTargetAnnounce(221606, 4)
--Mythic Only
local warnParasiticWound			= mod:NewTargetAnnounce(206847, 3)
local warnShadowyGaze				= mod:NewTargetAnnounce(206983, 3)
local warnWounded					= mod:NewSpellAnnounce(227009, 1)

--Stage One: The Council of Elders
----Gul'dan
local specWarnLiquidHellfire		= mod:NewSpecialWarningDodge(206219, nil, nil, nil, 1, 2)
local specWarnFelEfflux				= mod:NewSpecialWarningDodge(206514, nil, nil, nil, 1, 2)
----Fel Lord Kuraz'mal
local specWarnShatterEssence		= mod:NewSpecialWarningDefensive(206675, nil, nil, nil, 3, 2)
local specWarnFelObelisk			= mod:NewSpecialWarningDodge(229945, nil, nil, nil, 1, 2)
----D'zorykx the Trapper
local specWarnSoulVortex			= mod:NewSpecialWarningMoveAway(206883, nil, nil, nil, 1, 2)
local yellSoulVortex				= mod:NewYell(206883)
--Stage Two: The Ritual of Aman'thul
local specWarnBondsofFel			= mod:NewSpecialWarningYou(206222, nil, nil, nil, 1, 2)
local specWarnBondsofFelTank		= mod:NewSpecialWarningTaunt(206222, nil, nil, nil, 1, 2)
local yellBondsofFel				= mod:NewPosYell(206222)
local specWarnHandofGuldan			= mod:NewSpecialWarningSwitch(212258, "-Healer", nil, nil, 1, 2)
local specWarnEyeofGuldan			= mod:NewSpecialWarningSwitchCount(209270, "Dps", nil, nil, 1, 2)
local specWarnCarrionWave			= mod:NewSpecialWarningInterrupt(208672, "HasInterrupt", nil, nil, 1, 2)
--Stage Three: The Master's Power
local specWarnStormOfDestroyer		= mod:NewSpecialWarningDodge(161121, nil, nil, nil, 2, 2)
local specWarnSoulCorrosion			= mod:NewSpecialWarningStack(208802, nil, 3, nil, nil, 1, 6)--stack guessed
local specWarnBlackHarvest			= mod:NewSpecialWarningCount(206744, nil, nil, nil, 2, 2)
local specWarnFlamesOfSargeras		= mod:NewSpecialWarningMoveAway(221606, nil, nil, nil, 3, 2)
local yellFlamesofSargeras			= mod:NewPosYell(221606)
local specWarnFlamesOfSargerasTank	= mod:NewSpecialWarningTaunt(221606, nil, nil, nil, 1, 2)
--Mythic Only
local specWarnWilloftheDemonWithin	= mod:NewSpecialWarningSpell(211439, nil, nil, nil, 1, 2)
local specWarnParasiticWound		= mod:NewSpecialWarningMoveAway(206847, nil, nil, nil, 3, 2)
local yellParasiticWound			= mod:NewYell(206847)
local yellParasiticWoundFades		= mod:NewFadesYell(206847)
local specWarnShearedSoul			= mod:NewSpecialWarningYou(206458, nil, nil, nil, 1, 2)
local specWarnSoulsever				= mod:NewSpecialWarningCount(220957, nil, nil, nil, 3)--Needs voice, but what?
local specWarnVisionsofDarkTitan	= mod:NewSpecialWarningMoveTo(227008, nil, nil, nil, 3, 7)
local specWarnSummonNightorb		= mod:NewSpecialWarningSwitchCount(227283, "-Healer", nil, nil, 1, 2)
--Shard
local specWarnManifestAzzinoth		= mod:NewSpecialWarningSwitch(221149, "-Healer", nil, nil, 1, 2)
local specWarnBulwarkofAzzinoth		= mod:NewSpecialWarningSpell(221408, nil, nil, nil, 1)--Needs voice, but what?
local specWarnPurifiedEssence		= mod:NewSpecialWarningMoveTo(221486, nil, nil, nil, 3, 7)

--Stage One: The Council of Elders
----Gul'dan
local timerRP						= mod:NewRPTimer(78)
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerLiquidHellfireCD			= mod:NewNextCountTimer(25, 206219, nil, nil, nil, 3)
local timerFelEffluxCD				= mod:NewCDCountTimer(10.7, 206514, nil, nil, nil, 3)--10.7-13.5 (14-15 on normal)
----Fel Lord Kuraz'mal
mod:AddTimerLine(Kurazmal)
local timerFelLordKurazCD			= mod:NewCastTimer(16, "ej13121", nil, nil, nil, 1, 212258)
local timerShatterEssenceCD			= mod:NewCDTimer(54, 206675, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
local timerFelObeliskCD				= mod:NewCDTimer(16, 206841, nil, nil, nil, 3)
----Inquisitor Vethriz
mod:AddTimerLine(Vethriz)
local timerVethrizCD				= mod:NewCastTimer(25, "ej13124", nil, nil, nil, 1, 212258)
local timerGazeofVethrizCD			= mod:NewCDTimer(4.7, 206840, nil, nil, nil, 3)
----D'zorykx the Trapper
mod:AddTimerLine(Dzorykx)
local timerDzorykxCD				= mod:NewCastTimer(35, "ej13129", nil, nil, nil, 1, 212258)
local timerSoulVortexCD				= mod:NewCDTimer(21, 206883, nil, nil, nil, 3)--34-36
--Stage Two: The Ritual of Aman'thul
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerTransition				= mod:NewPhaseTimer(19)
local timerHandofGuldanCD			= mod:NewNextCountTimer(58.5, 212258, nil, nil, nil, 1)
local timerBondsofFelCD				= mod:NewNextCountTimer(50, 206222, nil, nil, nil, 3)
local timerEyeofGuldanCD			= mod:NewNextCountTimer(60, 209270, nil, nil, nil, 1)
--Stage Three: The Master's Power
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFlamesofSargerasCD		= mod:NewNextCountTimer("d58.5", 221783, nil, nil, nil, 3)
local timerStormOfDestroyerCD		= mod:NewNextCountTimer(16, 161121, nil, nil, nil, 3)
local timerWellOfSouls				= mod:NewCastTimer(16, 206939, nil, nil, nil, 5)
local timerBlackHarvestCD			= mod:NewNextCountTimer(83, 206744, nil, nil, nil, 2)
--Mythic Only
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerWindsCD					= mod:NewCDCountTimer(39, 199446, nil, nil, nil, 2)
local timerWilloftheDemonWithinCD	= mod:NewCDTimer(39, 211439, nil, nil, nil, 2)
local timerWilloftheDemonWithin		= mod:NewCastTimer(4, 211439, nil, nil, nil, 2)
local timerParasiticWoundCD			= mod:NewCDTimer(36, 206847, nil, nil, nil, 3)
local timerWounded					= mod:NewBuffActiveTimer(36, 227009, nil, nil, nil, 6)
local timerSoulSeverCD				= mod:NewCDCountTimer(36, 220957, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerVisionsofDarkTitan		= mod:NewCastTimer(9, 227008, nil, nil, nil, 2)
local timerVisionsofDarkTitanCD		= mod:NewCDCountTimer(9, 227008, nil, nil, nil, 2)
local timerFlameCrashCD				= mod:NewCDCountTimer(20, 227071, nil, nil, nil, 3)
local timerSummonNightorbCD			= mod:NewCDCountTimer(10.9, 227283, nil, nil, nil, 1, 225133)
--Shard
mod:AddTimerLine(GetSpellInfo(221149))
local timerManifestAzzinothCD		= mod:NewCDTimer(10.9, 221149, nil, nil, nil, 1, 236237)
local timerChaosSeedCD				= mod:NewCDTimer(10.9, 221336, nil, nil, nil, 3)
local timerBulwarkofAzzinothCD		= mod:NewCDTimer(10.9, 221408, nil, nil, nil, 6)
local timerPurifiedEssence			= mod:NewCastTimer(4, 221486, nil, nil, nil, 2)

--Non Mythic
local countdownBondsOfFel			= mod:NewCountdown(50, 206222)
local countdownEyeofGuldan			= mod:NewCountdown("Alt50", 209270, "-Tank")
local countdownHandofGuldan			= mod:NewCountdown("Alt50", 212258, "Tank")
local countdownLiquidHellfire		= mod:NewCountdown("AltTwo50", 206219, "Ranged")
local countdownBlackHarvest			= mod:NewCountdown("AltTwo50", 206744)
--mythic
--TODO, what needs countdowns the most?

--Stage One: The Council of Elders
----Gul'dan
local voiceLiquidHellfire			= mod:NewVoice(206219)--watchstep
local voiceFelEfflux				= mod:NewVoice(206514)--159202 (flame jet)
----Fel Lord Kuraz'mal
local voiceShatterEssence			= mod:NewVoice(206675)--defensive (maybe custom one that's more specific and says to use Resonant Barrier)
local voiceFelObelisk				= mod:NewVoice(229945)--watchstep
----D'zorykx the Trapper
local voiceSoulVortex				= mod:NewVoice(206883)--runout
--Stage Two: The Ritual of Aman'thul
local voiceBondsofFel				= mod:NewVoice(206222)--targetyou/helpsoak/tauntboss
local voiceHandofGuldan				= mod:NewVoice(212258)--bigmob
local voiceEyeofGuldan				= mod:NewVoice(209270, "Dps")--killmob
local voiceCarrionWave				= mod:NewVoice(208672, "HasInterrupt")--kickcast
--Stage Three: The Master's Power
local voiceStormOfDestroyer			= mod:NewVoice(161121)--watchstep
local voiceSoulCorrosion			= mod:NewVoice(208802)--stackhigh
local voiceBlackHarvest				= mod:NewVoice(206744)--aesoon
local voiceFlamesOfSargeras			= mod:NewVoice(221606)--runout
--Mythic Only
local voiceWilloftheDemonWithin		= mod:NewVoice(211439)--carefly
local voiceParasiticWound			= mod:NewVoice(206847)--scatter
local voiceShearedSoul				= mod:NewVoice(206458)--targetyou (don't know what to do for most of this stuff yet so generic voices)
--local voiceSoulSever				= mod:NewVoice(220957)--??? (temp, no idea what you're supposed to for spell_
local voiceVisionsOfDarkTitan		= mod:NewVoice(227008)--getstoptime
local voiceSummonNightorb			= mod:NewVoice(227283, "-Healer")--killmob
--Shard
local voiceManifestAzzinoth			= mod:NewVoice(221149, "-Healer")--bigmob
local voicePurifiedEssence			= mod:NewVoice(221486)--getstoptime

mod:AddRangeFrameOption(8, 221606)
mod:AddSetIconOption("SetIconOnBondsOfFlames", 221783, true)
mod:AddSetIconOption("SetIconOnBondsOfFel", 206222, true)
mod:AddInfoFrameOption(206310)

mod.vb.phase = 1
mod.vb.addsDied = 0
mod.vb.liquidHellfireCast = 0
mod.vb.felEffluxCast = 0
mod.vb.handofGuldanCast = 0
mod.vb.stormCast = 0
mod.vb.blackHarvestCast = 0
mod.vb.eyeCast = 0
mod.vb.flamesSargCast = 0
mod.vb.flamesTargets = 0
mod.vb.bondsofFelCast = 0
--Mythic only Phase
mod.vb.obeliskCastCount = 0
mod.vb.severCastCount = 0
mod.vb.crashCastCount = 0
mod.vb.orbCastCount = 0
mod.vb.visionCastCount = 0
--Mythic only Phase end
local felEffluxTimers = {11.0, 14.0, 18.5, 12.0, 12.2, 12.0}
local felEffluxTimersEasy = {11.0, 14.0, 19.9, 15.6, 16.8, 15.9, 15.8}
local handofGuldanTimers = {14.5, 48.9, 138.8}
--local mythicHandofGuldanTimers = {17, 165, 0, 0, 0}
local stormTimersEasy = {94, 78.6, 70.0, 87}
local stormTimers = {84.1, 68.7, 61.3, 76.5}
local stormTimersMythic = {72.6, 57.9, 51.6, 64.7, 57.4}--Credit to JustWait
local blackHarvestTimersEasy = {63, 82.9, 100.0}
local blackHarvestTimers = {64.1, 72.5, 87.5}
local blackHarvestTimersMythic = {55.7, 61.0, 75.3, 86.8}--Credit to JustWait
--local phase2Eyes = {29, 53.3, 53.4, 53.3, 53.3, 53.3, 66}--Not used, not needed if only 1 is different. need longer pulls to see what happens after 66
--local p1EyesMythic = {26, 48, 48}
local p3EmpoweredEyeTimersEasy = {42.5, 71.5, 71.4, 28.6, 114}--114 is guessed on the 1/8th formula
local p3EmpoweredEyeTimers = {39.1, 62.5, 62.5, 25, 100}--100 is confirmed
local p3EmpoweredEyeTimersMythic = {35.1, 52.6, 53.3, 20.4, 84.2, 52.6}--Credit to JustWait
local bondsIcons = {}
local flamesIcons = {}
local timeStopBuff = GetSpellInfo(206310)

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.addsDied = 0
	self.vb.liquidHellfireCast = 0
	self.vb.felEffluxCast = 0
	self.vb.handofGuldanCast = 0
	self.vb.stormCast = 0
	self.vb.blackHarvestCast = 0
	self.vb.eyeCast = 0
	self.vb.flamesSargCast = 0
	self.vb.flamesTargets = 0
	self.vb.bondsofFelCast = 0
	self.vb.obeliskCastCount = 0
	table.wipe(bondsIcons)
	table.wipe(flamesIcons)
	if self:IsMythic() then
		DBM:AddMsg("This mod still needs mythic refactoring to properly support new phase 3")
		timerBondsofFelCD:Start(8.4-delay, 1)
		countdownBondsOfFel:Start(8.4)
		timerDzorykxCD:Start(17-delay)
		countdownHandofGuldan:Start(17)
		timerEyeofGuldanCD:Start(26.4-delay, 1)
		countdownEyeofGuldan:Start(26.4)
		timerLiquidHellfireCD:Start(36-delay, 1)
		countdownLiquidHellfire:Start(36)
		self:SetCreatureID(104154, 999999)--Placeholder until I know id of mythic enemy
	else
		timerLiquidHellfireCD:Start(2-delay, 1)
		timerFelEffluxCD:Start(11-delay, 1)
		timerFelLordKurazCD:Start(11-delay)
		countdownHandofGuldan:Start(11)
		timerVethrizCD:Start(25-delay)
		timerDzorykxCD:Start(35-delay)
		self:SetCreatureID(104154)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 206219 or spellId == 206220 then
		self.vb.liquidHellfireCast = self.vb.liquidHellfireCast + 1
		--if spellId == 206219 then
			specWarnLiquidHellfire:Show()
			voiceLiquidHellfire:Play("watchstep")
		--else

		--end
		if self:IsMythic() or self.vb.phase >= 2 then
			local longTimer, shortTimer, mediumTimer
			if self:IsMythic() then
				longTimer, shortTimer, mediumTimer = 66, 28.9, 33
			elseif self:IsHeroic() then
				longTimer, shortTimer, mediumTimer = 74, 31.6, 36
			elseif self:IsNormal() then--Normal
				longTimer, shortTimer, mediumTimer = 84, 36, 41
			else
				longTimer, shortTimer, mediumTimer = 88, 38.6, 44
			end
			if self.vb.liquidHellfireCast == 4 or self.vb.liquidHellfireCast == 6 then
				timerLiquidHellfireCD:Start(longTimer, self.vb.liquidHellfireCast+1)
				countdownLiquidHellfire:Start(longTimer)
			elseif self.vb.liquidHellfireCast == 7 then--TODO, if a longer phase 2 than 7 casts, and continue to see diff timers than 36, build a table
				timerLiquidHellfireCD:Start(shortTimer, self.vb.liquidHellfireCast+1)
				countdownLiquidHellfire:Start(shortTimer)
			else
				timerLiquidHellfireCD:Start(mediumTimer, self.vb.liquidHellfireCast+1)
				countdownLiquidHellfire:Start(mediumTimer)
			end
		elseif self.vb.phase == 1.5 then
			if self.vb.liquidHellfireCast == 2 or self:IsHeroic() then
				timerLiquidHellfireCD:Start(23.8, self.vb.liquidHellfireCast+1)
				countdownLiquidHellfire:Start(23.8)
			else--On LFR/Normal the rest are 32 in phase 1.5
				timerLiquidHellfireCD:Start(32.5, self.vb.liquidHellfireCast+1)
				countdownLiquidHellfire:Start(32.5)
			end
		else--Phase 1
			timerLiquidHellfireCD:Start(15, self.vb.liquidHellfireCast+1)
			countdownLiquidHellfire:Start(15)
		end
	elseif spellId == 206514 then
		self.vb.felEffluxCast = self.vb.felEffluxCast + 1
		specWarnFelEfflux:Show()
		voiceFelEfflux:Play("159202")
		local timer = self:IsEasy() and felEffluxTimersEasy[self.vb.felEffluxCast+1] or felEffluxTimers[self.vb.felEffluxCast+1] or 12
		timerFelEffluxCD:Start(timer, self.vb.felEffluxCast+1)
	elseif spellId == 206675 then
		if self:IsMythic() then
			timerShatterEssenceCD:Start(21)
		else
			timerShatterEssenceCD:Start()
		end
		local targetName, uId, bossuid = self:GetBossTarget(104537)--Add true if it has a boss unitID
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnShatterEssence:Show()
			voiceShatterEssence:Play("defensive")
		end
	elseif spellId == 206840 then
		warnGazeofVethriz:Show()
		timerGazeofVethrizCD:Start()
	elseif spellId == 207938 then
		warnShadowblink:Show()
		--timerShadowBlinkCD:Start()
	elseif spellId == 206883 then
		if self:IsMythic() then--On mythic it's just tossed into center of room, not at tank
			specWarnSoulVortex:Show()
			voiceSoulVortex:Play("watchstep")
			timerSoulVortexCD:Start(21)
		else
			local targetName, uId, bossuid = self:GetBossTarget(104534, true)
			local tanking, status = UnitDetailedThreatSituation("player", bossuid)
			if tanking or (status == 3) then--Player is current target
				specWarnSoulVortex:Show()
				voiceSoulVortex:Play("runout")
				yellSoulVortex:Yell()
			elseif targetName then
				warnSoulVortex:Show(targetName)
			end
		end
	elseif spellId == 208545 then
		warnAnguishedSpirits:Show()
	elseif spellId == 209270 or spellId == 211152 then
		self.vb.eyeCast = self.vb.eyeCast + 1
		--if spellId == 211152 then

		--else
			specWarnEyeofGuldan:Show(self.vb.eyeCast)
		--end
		voiceEyeofGuldan:Play("killmob")
		if self:IsMythic() and self.vb.phase == 2 or self.vb.phase == 3 then
			local timer = self:IsMythic() and p3EmpoweredEyeTimersMythic[self.vb.eyeCast+1] or self:IsEasy() and p3EmpoweredEyeTimersEasy[self.vb.eyeCast+1] or p3EmpoweredEyeTimers[self.vb.eyeCast+1]
			if timer then
				timerEyeofGuldanCD:Start(timer, self.vb.eyeCast+1)
				countdownEyeofGuldan:Start(timer)
			end
			if self.vb.eyeCast == 4 and self:IsMythic() then
				timerWindsCD:Start(97, 3)
			end
		else
			local longTimer, shortTimer
			if self:IsMythic() then
				longTimer, shortTimer = 80, 48
			elseif self:IsHeroic() then
				longTimer, shortTimer = 66, 53
			elseif self:IsNormal() then--Normal
				longTimer, shortTimer = 75, 60
			else--LFR
				longTimer, shortTimer = 80, 64
			end
			if self.vb.eyeCast == 6 then
				timerEyeofGuldanCD:Start(longTimer, self.vb.eyeCast+1)--An oddball cast
				countdownEyeofGuldan:Start(longTimer)
			else
				timerEyeofGuldanCD:Start(shortTimer, self.vb.eyeCast+1)
				countdownEyeofGuldan:Start(shortTimer)
			end
		end
	elseif spellId == 208672 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnCarrionWave:Show(args.sourceName)
			voiceCarrionWave:Play("kickcast")
		end
	elseif spellId == 206744 then
		self.vb.blackHarvestCast = self.vb.blackHarvestCast + 1
		specWarnBlackHarvest:Show(self.vb.blackHarvestCast)
		voiceBlackHarvest:Play("aesoon")
		local timer = self:IsMythic() and blackHarvestTimersMythic[self.vb.blackHarvestCast+1] or self:IsEasy() and blackHarvestTimersEasy[self.vb.blackHarvestCast+1] or blackHarvestTimers[self.vb.blackHarvestCast+1]
		if timer then
			timerBlackHarvestCD:Start(timer, self.vb.blackHarvestCast+1)
			countdownBlackHarvest:Start(timer)
		end
		if self:IsMythic() and self.vb.blackHarvestCast == 4 then
			timerWindsCD:Start(75, 4)
		end
	elseif spellId == 206222 or spellId == 206221 then
		table.wipe(bondsIcons)
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			--Not a thing!
		else
			local targetName = UnitName("boss1target") or DBM_CORE_UNKNOWN
			if not UnitIsUnit("player", "boss1target") then--the very first bonds of fel, threat is broken and not available yet, so we need an additional filter
				specWarnBondsofFelTank:Show(targetName)
				voiceBondsofFel:Play("tauntboss")
			end
		end
	elseif spellId == 221783 then
		table.wipe(flamesIcons)
		self.vb.flamesTargets = 0
	--Begin Mythic Only Stuff
	elseif spellId == 211439 then--Will of the Demon Within
		if self.vb.phase ~= 3 then -- For unlocalized clients
			self.vb.phase = 3
			timerWindsCD:Stop()
		end
		specWarnWilloftheDemonWithin:Show()
		voiceWilloftheDemonWithin:Play("carefly")
		timerWilloftheDemonWithin:Start()

		self.vb.severCastCount = 0
		self.vb.crashCastCount = 0
		self.vb.orbCastCount = 0
		self.vb.visionCastCount = 0
		timerParasiticWoundCD:Start(8.6)
		timerSoulSeverCD:Start(19.6, 1)	
 		timerManifestAzzinothCD:Start(26.6)
 		timerFlameCrashCD:Start(29.6, 1)
 		timerSummonNightorbCD:Start(39.6, 1)
 		timerVisionsofDarkTitanCD:Start(96.2, 1)
	elseif spellId == 220957 then
		self.vb.severCastCount = self.vb.severCastCount + 1
		if self:IsTank() then
			specWarnSoulsever:Show(self.vb.severCastCount)
			--voiceSoulSever:Play("stilldanger")
		end
		if self.vb.severCastCount == 4 or self.vb.severCastCount == 7 then
			timerSoulSeverCD:Start(50, self.vb.severCastCount+1)
		else
			timerSoulSeverCD:Start(20, self.vb.severCastCount+1)
		end
	elseif spellId == 227008 then
		self.vb.visionCastCount = self.vb.visionCastCount+1
		specWarnVisionsofDarkTitan:Show(timeStopBuff)
		voiceVisionsOfDarkTitan:Play("getstoptime")
		timerVisionsofDarkTitan:Start()
		if self.vb.visionCastCount ~= 3 then
			if self.vb.visionCastCount == 2 then
				timerVisionsofDarkTitanCD:Start(150)
			else
				timerVisionsofDarkTitanCD:Start(90)
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_NO_DEBUFF:format(timeStopBuff))
			DBM.InfoFrame:Show(10, "playergooddebuff", timeStopBuff)
		end
	elseif spellId == 221408 then
		specWarnBulwarkofAzzinoth:Show()
	elseif spellId == 221486 then
		specWarnPurifiedEssence:Show(timeStopBuff)
		voicePurifiedEssence:Play("getstoptime")
		timerPurifiedEssence:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_NO_DEBUFF:format(timeStopBuff))
			DBM.InfoFrame:Show(10, "playergooddebuff", timeStopBuff)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206222 or spellId == 206221 then
		self.vb.bondsofFelCast = self.vb.bondsofFelCast + 1
		if self:IsMythic() then
			timerBondsofFelCD:Start(40, self.vb.bondsofFelCast+1)
			countdownBondsOfFel:Start(40)
		elseif self:IsHeroic() then
			timerBondsofFelCD:Start(44.4, self.vb.bondsofFelCast+1)
			countdownBondsOfFel:Start(44.4)
		elseif self:IsNormal() then
			timerBondsofFelCD:Start(50, self.vb.bondsofFelCast+1)
			countdownBondsOfFel:Start(50)
		else
			timerBondsofFelCD:Start(53, self.vb.bondsofFelCast+1)
			countdownBondsOfFel:Start(53)
		end
	elseif spellId == 221783 and self:AntiSpam(35, 1) then
		self.vb.flamesSargCast = self.vb.flamesSargCast + 1
		if self:IsMythic() then
			timerFlamesofSargerasCD:Start(6.3, (self.vb.flamesSargCast).."-"..2)
			timerFlamesofSargerasCD:Start(13.6, (self.vb.flamesSargCast).."-"..3)
			timerFlamesofSargerasCD:Start(45, (self.vb.flamesSargCast+1).."-"..1)
			if self.vb.flamesSargCast == 2 then
				timerWindsCD:Start(31, 2)
			end
		elseif self:IsHeroic() then
			timerFlamesofSargerasCD:Start(7.7, (self.vb.flamesSargCast).."-"..2)
			timerFlamesofSargerasCD:Start(16.4, (self.vb.flamesSargCast).."-"..3)
			timerFlamesofSargerasCD:Start(50, (self.vb.flamesSargCast+1).."-"..1)--5-6 is 50, 1-5 is 51. For time being using a simple 50 timer
		else--Normal, LFR?
			timerFlamesofSargerasCD:Start(18.9, (self.vb.flamesSargCast).."-"..2)
			timerFlamesofSargerasCD:Start(58.5, (self.vb.flamesSargCast+1).."-"..1)
		end
	elseif spellId == 212258 and self.vb.phase > 1.5 then--Ignore phase 1 adds with this cast
		self.vb.handofGuldanCast = self.vb.handofGuldanCast + 1
		specWarnHandofGuldan:Show()
		voiceHandofGuldan:Play("bigmob")
		if self:IsMythic() then
			if self.vb.handofGuldanCast == 1 then
				timerFelLordKurazCD:Start(165)
				countdownHandofGuldan:Start(165)
			end
		else
			local timer = handofGuldanTimers[self.vb.handofGuldanCast+1]
			if timer then
				timerHandofGuldanCD:Start(timer, self.vb.handofGuldanCast+1)
				countdownHandofGuldan:Start(timer)
			end
		end
	elseif spellId == 227008 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 221486 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 221336 then
		timerChaosSeedCD:Start(10.9)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209011 or spellId == 206354 or spellId == 206384 or spellId == 209086 then--206354/206366 unconfirmed on normal/heroic. LFR/Mythic?
		local isPlayer = args:IsPlayer()
		local name = args.destName
		if not tContains(bondsIcons, name) then
			bondsIcons[#bondsIcons+1] = name
		end
		local count = #bondsIcons
		if spellId == 206384 or spellId == 209086 then
			warnEmpBondsofFel:CombinedShow(0.5, name)
		else
			warnBondsofFel:CombinedShow(0.5, name)
		end
		if isPlayer then
			specWarnBondsofFel:Show()
			voiceBondsofFel:Play("targetyou")
			yellBondsofFel:Yell(count, count, count)
		else
			local uId = DBM:GetRaidUnitId(name)
			if self:IsTanking(uId, "boss1") and not UnitDetailedThreatSituation("player", "boss1") then
				--secondary warning, in case you spaced out the first taunt warning
				specWarnBondsofFelTank:Show(name)
				voiceBondsofFel:Play("tauntboss")
			end
		end
		if self.Options.SetIconOnBondsOfFel then
			self:SetIcon(name, count)
		end
	elseif spellId == 221891 then
		warnSoulSiphon:CombinedShow(0.3, args.destName)
	elseif spellId == 208802 then
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 3 then
			specWarnSoulCorrosion:Show(amount)
			voiceSoulCorrosion:Play("stackhigh")
		end
	elseif spellId == 221606 then--Looks like the 3 second pre targeting debuff for flames of sargeras
		if self:AntiSpam(35, 1) then
			self.vb.flamesSargCast = self.vb.flamesSargCast + 1
			if self:IsMythic() then
				timerFlamesofSargerasCD:Start(6.3, (self.vb.flamesSargCast).."-"..2)
				timerFlamesofSargerasCD:Start(13.6, (self.vb.flamesSargCast).."-"..3)
				timerFlamesofSargerasCD:Start(45, (self.vb.flamesSargCast+1).."-"..1)
				if self.vb.flamesSargCast == 2 then
					timerWindsCD:Start(31, 2)--FIXME later and start at correct flames cast
				end
			elseif self:IsHeroic() then
				timerFlamesofSargerasCD:Start(7.7, (self.vb.flamesSargCast).."-"..2)
				timerFlamesofSargerasCD:Start(16.4, (self.vb.flamesSargCast).."-"..3)
				timerFlamesofSargerasCD:Start(50, (self.vb.flamesSargCast+1).."-"..1)--5-6 is 50, 1-5 is 51. For time being using a simple 50 timer
			else--Normal, LFR
				timerFlamesofSargerasCD:Start(18.9, (self.vb.flamesSargCast).."-"..2)
				timerFlamesofSargerasCD:Start(58.5, (self.vb.flamesSargCast+1).."-"..1)
			end
		end
		local name = args.destName
		self.vb.flamesTargets = self.vb.flamesTargets + 1
		if not tContains(flamesIcons, name) then
			flamesIcons[#flamesIcons+1] = name
		end
		local count = #flamesIcons+3
		warnFlamesofSargeras:CombinedShow(0.3, name)
		if args:IsPlayer() then
			specWarnFlamesOfSargeras:Show()
			voiceFlamesOfSargeras:Play("runout")
			yellFlamesofSargeras:Yell(count, count, count)
		else
			local uId = DBM:GetRaidUnitId(name)
			if self:IsTanking(uId, "boss1") then
				specWarnFlamesOfSargerasTank:Show(name)
				voiceFlamesOfSargeras:Play("tauntboss")
			end
		end
		if self.Options.SetIconOnBondsOfFlames and count < 9 then
			self:SetIcon(name, count)--Should start at icon 4 and go up from there (because icons 1-3 are used by bonds of fel)
		end
	elseif spellId == 221603 or spellId == 221785 or spellId == 221784 or spellId == 212686 then--4 different duration versions of Flames of sargeras?
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 206516 then--The Eye of Aman'Thul (phase 1 buff)
		self.vb.phase = 1.5
		timerLiquidHellfireCD:Stop()
		countdownLiquidHellfire:Cancel()
		timerFelEffluxCD:Stop()
		timerLiquidHellfireCD:Start(5, self.vb.liquidHellfireCast+1)
		countdownLiquidHellfire:Start(5)
		timerFelEffluxCD:Start(10, self.vb.felEffluxCast+1)
	elseif spellId == 227427 then--The Eye of Aman'Thul (phase 3 transition buff)
		timerBondsofFelCD:Stop()
		countdownBondsOfFel:Cancel()
		timerLiquidHellfireCD:Stop()
		countdownLiquidHellfire:Cancel()
		timerEyeofGuldanCD:Stop()
		countdownEyeofGuldan:Cancel()
		timerHandofGuldanCD:Stop()
		countdownHandofGuldan:Cancel()
		timerWellOfSouls:Start(15)
		self.vb.eyeCast = 0
		if self:IsMythic() then
			self.vb.phase = 2
			warnPhase2:Show()
			timerFlamesofSargerasCD:Start(24.5, "1-1")
			timerEyeofGuldanCD:Start(35.1, 1)
			countdownEyeofGuldan:Start(35)
			timerBlackHarvestCD:Start(55.7, 1)
			countdownBlackHarvest:Start(55.7)
			timerWindsCD:Start(68, 1)
			timerStormOfDestroyerCD:Start(72.6, 1)
		else
			self.vb.phase = 3
			warnPhase3:Show()
			timerBlackHarvestCD:Start(self:IsLFR() and 73 or 63, 1)
			countdownBlackHarvest:Start(self:IsLFR() and 73 or 63)
			if self:IsEasy() then
				timerFlamesofSargerasCD:Start(29, 1)
				timerEyeofGuldanCD:Start(42.5, 1)
				countdownEyeofGuldan:Start(42.5)
				timerStormOfDestroyerCD:Start(94, 1)
			else
				timerFlamesofSargerasCD:Start(27.5, "1-1")
				timerEyeofGuldanCD:Start(39, 1)
				countdownEyeofGuldan:Start(39)
				timerStormOfDestroyerCD:Start(84, 1)
			end
		end
	elseif spellId == 206847 then
		warnParasiticWound:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, _, expires = UnitDebuff(args.destName, args.spellName)
			local remaining = expires-GetTime()
			specWarnParasiticWound:Show()
			voiceParasiticWound:Play("scatter")
			yellParasiticWound:Yell()
			yellParasiticWoundFades:Schedule(remaining-1, 1)
			yellParasiticWoundFades:Schedule(remaining-2, 2)
			yellParasiticWoundFades:Schedule(remaining-3, 3)
		end
	elseif spellId == 206983 and self:AntiSpam(2, args.destName) then
		warnShadowyGaze:CombinedShow(0.3, args.destName)
	elseif spellId == 206458 then
		if args:IsPlayer() then
			specWarnShearedSoul:Show()
			voiceShearedSoul:Play("targetyou")
		end
	elseif spellId == 227009 then
		warnWounded:Show()
		timerWounded:Start()
		timerVisionsofDarkTitan:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209011 or spellId == 206354 then
		if self.Options.SetIconOnBondsOfFel then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 206384 or spellId == 209086 then--(206366: stunned version mythic?)
		if self.Options.SetIconOnBondsOfFel then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 221606 then
		self.vb.flamesTargets = self.vb.flamesTargets - 1
		if self.vb.flamesTargets == 0 then
			table.wipe(flamesIcons)
		end
	elseif spellId == 221603 or spellId == 221785 or spellId == 221784 or spellId == 212686 then--4 different duration versions of Flames of sargeras?
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.SetIconOnBondsOfFlames then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 206847 then
		if args:IsPlayer() then
			yellParasiticWoundFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 111070 then--Azzinoth
		timerChaosSeedCD:Stop()
	elseif cid == 104154 and self:IsMythic() then--Gul'dan
		timerFlamesofSargerasCD:Stop()
		timerEyeofGuldanCD:Stop()
		countdownEyeofGuldan:Cancel()
 		timerBlackHarvestCD:Stop()
 		countdownBlackHarvest:Cancel()
 		timerStormOfDestroyerCD:Stop()
 		timerWindsCD:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.prePullRP or msg:find(L.prePullRP)) and self:LatencyCheck() then
		self:SendSync("GuldanRP")
	elseif ( msg == L.mythicPhase3 or msg:find(L.mythicPhase3)) and self:IsMythic() then	
		self:SendSync("mythicPhase3")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 161121 then--Assumed this is a script like felseeker
		self.vb.stormCast = self.vb.stormCast + 1
		specWarnStormOfDestroyer:Show()
		voiceStormOfDestroyer:Play("watchstep")
		local timer = self:IsMythic() and stormTimersMythic[self.vb.stormCast+1] or self:IsEasy() and stormTimersEasy[self.vb.stormCast+1] or stormTimers[self.vb.stormCast+1]
		if timer then
			timerStormOfDestroyerCD:Start(timer, self.vb.stormCast+1)
		end
	elseif spellId == 215736 then--Hand of Guldan (Fel Lord Kuraz'mal)
		if self:IsMythic() then
			timerShatterEssenceCD:Start(21)
		else
			timerShatterEssenceCD:Start(19)--Same on normal and heroic. mythic/LFR need vetting.
		end
	elseif spellId == 215738 then--Hand of Guldan (Inquisitor Vethriz)
		if self:IsEasy() then
			--Unknown, died before casting either one
		else
			--timerShadowBlinkCD:Start(27.8)
			timerGazeofVethrizCD:Start(27.8)--Basically starts casting it right after blink, then every 5 seconds
		end
	elseif spellId == 215739 then--Hand of Guldan (D'zorykx the Trapper)
		if self:IsMythic() then
			timerSoulVortexCD:Start(3)
		end
		--[[if self:IsEasy() then
			timerSoulVortexCD:Start(52)--Normal verified, LFR assumed
		else
			timerSoulVortexCD:Start(35)--Heroic Jan 21
		end--]]
	elseif spellId == 210273 then--Fel Obelisk
		self.vb.obeliskCastCount = self.vb.obeliskCastCount + 1
		specWarnFelObelisk:Show()
		voiceFelObelisk:Play("watchstep")
		if self:IsMythic() then
			if self.vb.obeliskCastCount % 2 == 0 then
				timerFelObeliskCD:Start(16)
			else
				timerFelObeliskCD:Start(5)
			end
		else
			timerFelObeliskCD:Start(23)
		end
	elseif spellId == 209601 or spellId == 209637 or spellId == 208831 then--Fel Lord, Inquisitor, Jailer (they cast these on death, more reliable than UNIT_DIED which often doesn't fire for inquisitor)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 104537 or cid == 104536 or cid == 104534 then
			self.vb.addsDied = self.vb.addsDied + 1
			if cid == 104537 then--Fel Lord Kuraz'mal
				timerShatterEssenceCD:Stop()
				timerFelObeliskCD:Stop()
			elseif cid == 104536 then--Inquisitor Vethriz
				timerGazeofVethrizCD:Stop()
				--timerShadowBlinkCD:Stop()
			elseif cid == 104534 then--D'zorykx the Trapper
				timerSoulVortexCD:Stop()
			end
			if self.vb.addsDied == 3 and not self:IsMythic() then
				--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
				self.vb.phase = 2
				self.vb.liquidHellfireCast = 0
				warnPhase2:Show()
				timerLiquidHellfireCD:Stop()
				countdownLiquidHellfire:Cancel()
				timerFelEffluxCD:Stop()
				timerTransition:Start(19)
				timerBondsofFelCD:Start(27.6, 1)
				countdownBondsOfFel:Start(27.6)
				if self:IsLFR() then
					timerEyeofGuldanCD:Start(54, 1)
					countdownEyeofGuldan:Start(54)
					timerLiquidHellfireCD:Start(67, 1)
					countdownLiquidHellfire:Start(67)
				elseif self:IsNormal() then
					timerEyeofGuldanCD:Start(50.6, 1)
					countdownEyeofGuldan:Start(50.6)
					timerLiquidHellfireCD:Start(63.1, 1)
					countdownLiquidHellfire:Start(63.1)
				else--Heroic
					timerHandofGuldanCD:Start(33, 1)
					countdownHandofGuldan:Start(33)
					timerEyeofGuldanCD:Start(48, 1)
					countdownEyeofGuldan:Start(48)
					timerLiquidHellfireCD:Start(59, 1)
					countdownLiquidHellfire:Start(59)
				end
			end
		end
	elseif spellId == 227035 then -- Parasitic Wound
		timerParasiticWoundCD:Start()
	elseif spellId == 221149 or spellId == 227277 then -- Manifest Azzinoth
		specWarnManifestAzzinoth:show()
		voiceManifestAzzinoth:Play("bigmob")
		timerBulwarkofAzzinothCD:Start(15)
		timerManifestAzzinothCD:Start(41)
	elseif spellId == 227071 then -- Flame Crash
		self.vb.crashCastCount  = self.vb.crashCastCount  + 1
		if self.vb.crashCastCount == 4 or self.vb.crashCastCount == 7 then
			timerFlameCrashCD:Start(50, self.vb.crashCastCount+1)
		else
			timerFlameCrashCD:Start(20, self.vb.crashCastCount+1)
		end
	elseif spellId == 227283 then -- Nightorb
		self.vb.orbCastCount = self.vb.orbCastCount + 1
		specWarnSummonNightorb:Show(self.vb.orbCastCount)
		voiceSummonNightorb:Play("killmob")
		if self.vb.orbCastCount ~= 4 then
			if self.vb.orbCastCount == 2 then
				timerSummonNightorbCD:Start(60, self.vb.orbCastCount+1)
			elseif self.vb.orbCastCount == 3 then
				timerSummonNightorbCD:Start(40, self.vb.orbCastCount+1)
			else
				timerSummonNightorbCD:Start(45, self.vb.orbCastCount+1)
			end
		end
	end
end

function mod:OnSync(msg)
	if msg == "GuldanRP" and self:AntiSpam(10, 3) then
		timerRP:Start()
	end
	if not self:IsInCombat() then return end
	if msg == "mythicPhase3" and self:IsMythic() then
		self.vb.phase = 3
		warnPhase3:Show()
		timerWilloftheDemonWithinCD:Start(39)
	end
end