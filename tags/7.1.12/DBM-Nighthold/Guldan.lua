local mod	= DBM:NewMod(1737, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104154)--104537 (Fel Lord Kuraz'mal)
mod:SetEncounterID(1866)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(15720)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206219 206220 206514 206675 206840 207938 104534 208545 209270 211152 208672 206939 206744 206883 206221 206222",
	"SPELL_CAST_SUCCESS 206222 206221 221783 212258",
	"SPELL_AURA_APPLIED 206219 206220 209011 206354 206384 209086 208903 211162 221891 208802 221606 221603 221785 221784 212686 227427 206516",
	"SPELL_AURA_APPLIED_DOSE 211162 208802",
	"SPELL_AURA_REMOVED 209011 206354 206384 209086 221603 221785 221784 212686 206516",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, if anquished spirits is important, add a timer. if not, remove warning.
--TODO, a LOT more work on bonds of fel. Once I understand how it breaks. if it's like shackled torment. how many targets, etc.
--TODO, more work on eye of guldan. if pulsing aoe, maybe only ranged switch?. Timer for duplicate when energy gain rate known
--TODO, hand of guldan in phase 2 needs work, if it's not pruned
--TODO, charred laceration Removed?
--TODO, fine tune black harvest into special warning if viable. Improve timer for it
--TODO, Do a bunch of stuff with well of souls? infoframe to track stacks/who should soak next?
--TODO, figure out flames of sargeras and improve upon it. add timer and keepmove voice if needed.
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
--local warnEmpLiquidHellfire			= mod:NewTargetAnnounce(206220, 3)
local warnBondsofFel				= mod:NewTargetAnnounce(206222, 4)
--local warnBurningClaws				= mod:NewTargetAnnounce(208903, 3, nil, "Tank")
--local warnCharredLacerations		= mod:NewStackAnnounce(211162, 2, nil, "Tank")
--Stage Three: The Master's Power
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnWellofSouls				= mod:NewSpellAnnounce(206939, 4)
local warnSoulSiphon				= mod:NewTargetAnnounce(221891, 3, nil, "Healer")
local warnFlamesofSargeras			= mod:NewTargetAnnounce(221606, 4)

--Stage One: The Council of Elders
----Gul'dan
local specWarnLiquidHellfire		= mod:NewSpecialWarningDodge(206219, nil, nil, nil, 1, 2)
local specWarnFelEfflux				= mod:NewSpecialWarningDodge(206514, nil, nil, nil, 1, 2)
----Fel Lord Kuraz'mal
local specWarnShatterEssence		= mod:NewSpecialWarningDefensive(206675, nil, nil, nil, 3, 2)
----Inquisitor Vethriz
--local specWarnDrain				= mod:NewSpecialWarningDispel(212568, "Healer", nil, nil, 1, 2)
----D'zorykx the Trapper
local specWarnSoulVortex			= mod:NewSpecialWarningMoveAway(206883, nil, nil, nil, 1, 2)
local yellSoulVortex				= mod:NewYell(206883)
--Stage Two: The Ritual of Aman'thul
local specWarnEmpLiquidHellfire		= mod:NewSpecialWarningDodge(206220, nil, nil, nil, 1, 2)
local specWarnBondsofFel			= mod:NewSpecialWarningYou(206222, nil, nil, nil, 1, 2)
local specWarnBondsofFelTank		= mod:NewSpecialWarningTaunt(206222, nil, nil, nil, 1, 2)
local yellBondsofFel				= mod:NewYell(206222)
local specWarnHandofGuldan			= mod:NewSpecialWarningSwitch(212258, "-Healer", nil, nil, 1, 2)
local specWarnEyeofGuldan			= mod:NewSpecialWarningSwitchCount(209270, "Dps", nil, nil, 1, 2)
local specWarnEmpEyeofGuldan		= mod:NewSpecialWarningSwitchCount(211152, "Dps", nil, nil, 1, 2)
local specWarnCarrionWave			= mod:NewSpecialWarningInterrupt(208672, "HasInterrupt", nil, nil, 1, 2)
--local specWarnCharredLacerations	= mod:NewSpecialWarningStack(211162, nil, 6)--stack guessed
--local specWarnCharredLacerationsOther= mod:NewSpecialWarningTaunt(211162, nil, nil, nil, 1, 2)
--Stage Three: The Master's Power
local specWarnStormOfDestroyer		= mod:NewSpecialWarningDodge(161121, nil, nil, nil, 2, 2)
local specWarnSoulCorrosion			= mod:NewSpecialWarningStack(208802, nil, 3)--stack guessed
local specWarnBlackHarvest			= mod:NewSpecialWarningCount(206744, nil, nil, nil, 2, 2)
local specWarnFlamesOfSargeras		= mod:NewSpecialWarningMoveAway(221606, nil, nil, nil, 3, 2)
local yellFlamesofSargeras			= mod:NewYell(221606)
local specWarnFlamesOfSargerasTank	= mod:NewSpecialWarningTaunt(221606, nil, nil, nil, 1, 2)


--Stage One: The Council of Elders
----Gul'dan
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerLiquidHellfireCD			= mod:NewNextCountTimer(25, 206219, nil, nil, nil, 3)
local timerFelEffluxCD				= mod:NewCDCountTimer(12, 206514, nil, nil, nil, 3)--12-13.5 (14-15 on normal)
----Fel Lord Kuraz'mal
mod:AddTimerLine(Kurazmal)
local timerFelLordKurazCD			= mod:NewCastTimer(16, "ej13121", nil, nil, nil, 1, 212258)
local timerShatterEssenceCD			= mod:NewCDTimer(54, 206675, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
--local timerFelObeliskCD				= mod:NewAITimer(16, 206841, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Inquisitor Vethriz
mod:AddTimerLine(Vethriz)
local timerVethrizCD				= mod:NewCastTimer(25, "ej13124", nil, nil, nil, 1, 212258)
local timerGazeofVethrizCD			= mod:NewCDTimer(4.7, 206840, nil, nil, nil, 3)
local timerShadowBlinkCD			= mod:NewCDTimer(36, 207938)--Role color maybe if blink applies to tank
----D'zorykx the Trapper
mod:AddTimerLine(Dzorykx)
local timerDzorykxCD				= mod:NewCastTimer(35, "ej13129", nil, nil, nil, 1, 212258)
--local timerSoulVortexCD				= mod:NewCDTimer(32.5, 206883, nil, nil, nil, 3)--34-36
--Stage Two: The Ritual of Aman'thul
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerTransition				= mod:NewPhaseTimer(19)
local timerHandofGuldanCD			= mod:NewCDCountTimer(58.5, 212258, nil, nil, nil, 1)
local timerBondsofFelCD				= mod:NewNextTimer(50, 206222, nil, nil, nil, 3)
local timerEyeofGuldanCD			= mod:NewNextCountTimer(60, 209270, nil, nil, nil, 1)
--Stage Three: The Master's Power
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFlamesofSargerasCD		= mod:NewCDCountTimer(58.5, 221783, nil, nil, nil, 3)
local timerStormOfDestroyerCD		= mod:NewCDCountTimer(16, 161121, nil, nil, nil, 3)
local timerWellOfSoulsCD			= mod:NewCDTimer(16, 206939, nil, nil, nil, 5)
local timerBlackHarvestCD			= mod:NewCDCountTimer(83, 206744, nil, nil, nil, 2)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

--Stage One: The Council of Elders
----Gul'dan
local voiceLiquidHellfire			= mod:NewVoice(206219)--watchstep
local voiceFelEfflux				= mod:NewVoice(206514)--watchwave
----Fel Lord Kuraz'mal
local voiceShatterEssence			= mod:NewVoice(206675)--defensive (maybe custom one that's more specific and says to use Resonant Barrier)
--local voiceFelObelisk				= mod:NewVoice(206841)--tauntboss
----Inquisitor Vethriz
--local voiceDrain					= mod:NewVoice(212568, "Healer")--helpdispel
----D'zorykx the Trapper
local voiceSoulVortex				= mod:NewVoice(206883)--runout
--Stage Two: The Ritual of Aman'thul
local voiceBondsofFel				= mod:NewVoice(206222)--targetyou/helpsoak/tauntboss
local voiceEmpLiquidHellfire		= mod:NewVoice(206220)--watchstep
local voiceHandofGuldan				= mod:NewVoice(212258)--bigmob
local voiceEyeofGuldan				= mod:NewVoice(209270, "Dps")--killmob
local voiceCarrionWave				= mod:NewVoice(208672, "HasInterrupt")--kickcast
--local voiceCharredLacerations		= mod:NewVoice(211162)--tauntboss
--Stage Three: The Master's Power
local voiceStormOfDestroyer			= mod:NewVoice(161121)--watchstep
local voiceBlackHarvest				= mod:NewVoice(206744)--aesoon
local voiceFlamesOfSargeras			= mod:NewVoice(221606)--runout

mod:AddRangeFrameOption(8, 221606)
mod:AddSetIconOption("SetIconOnBondsOfFel", 206222, true)
mod:AddHudMapOption("HudMapOnBondsofFel", 206222, "-Tank")

mod.vb.phase = 1
mod.vb.addsDied = 0
mod.vb.liquidHellfireCast = 0
mod.vb.felEffluxCast = 0
mod.vb.handofGuldanCast = 0
mod.vb.stormCast = 0
mod.vb.blackHarvestCast = 0
mod.vb.eyeCast = 0
mod.vb.flamesSargCast = 0
local felEffluxTimers = {11.0, 14.0, 19.6, 12.0, 12.2, 12.0}
local felEffluxTimersEasy = {11.0, 14.0, 19.9, 15.6, 16.8, 15.9, 15.8}
local handofGuldanTimers = {14.5, 48.9, 138.8}
local stormTimersEasy = {94, 78.6, 70.0, 87}
local stormTimers = {84.1, 68.7, 61.3, 76.5}
local blackHarvestTimersEasy = {63, 82.9, 100.0}
local blackHarvestTimers = {64.1, 72.5, 87.5}
--local phase2Eyes = {29, 53.3, 53.4, 53.3, 53.3, 53.3, 66}--Not used, not needed if only 1 is different. need longer pulls to see what happens after 66
local p3EmpoweredEyeTimersEasy = {42.5, 71.5, 71.4, 28.6, 114}--114 is guessed on the 1/8th formula
local p3EmpoweredEyeTimers = {39.1, 62.5, 62.5, 25, 100}--100 is confirmed
local bondsIcons = {}

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
	table.wipe(bondsIcons)
	timerLiquidHellfireCD:Start(2-delay, 1)
	timerFelEffluxCD:Start(11-delay, 1)
	timerFelLordKurazCD:Start(11-delay)
	timerVethrizCD:Start(25-delay)
	timerDzorykxCD:Start(35-delay)
	DBM:AddMsg("This mod was created using phase 1 data only. 2 and 3 are still drycodes and need updating as soon as live data starts coming in.")
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBondsofFel then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 206219 then
		self.vb.liquidHellfireCast = self.vb.liquidHellfireCast + 1
		specWarnLiquidHellfire:Show()
		voiceLiquidHellfire:Play("watchstep")
		if self.vb.phase == 1 then
			timerLiquidHellfireCD:Start(15, self.vb.liquidHellfireCast+1)
		elseif self.vb.phase == 1.5 then
			if self.vb.liquidHellfireCast == 2 or self:IsHeroic() then
				timerLiquidHellfireCD:Start(23.8, self.vb.liquidHellfireCast+1)
			else--On LFR/Normal the rest are 32 in phase 1.5
				timerLiquidHellfireCD:Start(32.5, self.vb.liquidHellfireCast+1)
			end
		else--Phase 2
			if self:IsEasy() then
				if self.vb.liquidHellfireCast == 6 then
					timerLiquidHellfireCD:Start(84, self.vb.liquidHellfireCast+1)
				elseif self.vb.liquidHellfireCast == 7 then--TODO, if a longer phase 2 than 7 casts, and continue to see diff timers than 36, build a table
					timerLiquidHellfireCD:Start(36, self.vb.liquidHellfireCast+1)
				else
					timerLiquidHellfireCD:Start(41, self.vb.liquidHellfireCast+1)
				end
			else
				if self.vb.liquidHellfireCast == 6 then
					timerLiquidHellfireCD:Start(74, self.vb.liquidHellfireCast+1)
				elseif self.vb.liquidHellfireCast == 7 then--TODO, if a longer phase 2 than 7 casts, and continue to see diff timers than 36, build a table
					timerLiquidHellfireCD:Start(31.6, self.vb.liquidHellfireCast+1)
				else
					timerLiquidHellfireCD:Start(36, self.vb.liquidHellfireCast+1)
				end
			end
		end
	elseif spellId == 206220 then
		self.vb.liquidHellfireCast = self.vb.liquidHellfireCast + 1
		specWarnEmpLiquidHellfire:Show()
		voiceEmpLiquidHellfire:Play("watchstep")
		timerLiquidHellfireCD:Start(41, self.vb.liquidHellfireCast+1)
	elseif spellId == 206514 then
		self.vb.felEffluxCast = self.vb.felEffluxCast + 1
		specWarnFelEfflux:Show()
		voiceFelEfflux:Play("watchwave")
		local timer = self:IsEasy() and felEffluxTimersEasy[self.vb.felEffluxCast+1] or felEffluxTimers[self.vb.felEffluxCast+1] or 12
		timerFelEffluxCD:Start(timer, self.vb.felEffluxCast+1)
	elseif spellId == 206675 then
		timerShatterEssenceCD:Start()
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
		timerShadowBlinkCD:Start()
	elseif spellId == 206883 then
		--timerSoulVortexCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104534, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnSoulVortex:Show()
			voiceSoulVortex:Play("runout")
			yellSoulVortex:Yell()
		elseif targetName then
			warnSoulVortex:Show(targetName)
		end
	elseif spellId == 208545 then
		warnAnguishedSpirits:Show()
	elseif spellId == 209270 or spellId == 211152 then
		self.vb.eyeCast = self.vb.eyeCast + 1
		if spellId == 211152 then
			specWarnEmpEyeofGuldan:Show(self.vb.eyeCast)
		else
			specWarnEyeofGuldan:Show(self.vb.eyeCast)
		end
		voiceEyeofGuldan:Play("killmob")
		if self.vb.phase == 3 then
			local timer = self:IsEasy() and p3EmpoweredEyeTimersEasy[self.vb.eyeCast+1] or p3EmpoweredEyeTimers[self.vb.eyeCast+1]
			if timer then
				timerEyeofGuldanCD:Start(timer, self.vb.eyeCast+1)
			end
		else
			if self:IsEasy() then
				if self.vb.eyeCast == 6 then--Assumed easy does this too. unknown for sure.
					timerEyeofGuldanCD:Start(75, self.vb.eyeCast+1)
				else
					timerEyeofGuldanCD:Start(60, self.vb.eyeCast+1)
				end
			else
				if self.vb.eyeCast == 6 then
					timerEyeofGuldanCD:Start(66, self.vb.eyeCast+1)--An oddball cast
				else
					timerEyeofGuldanCD:Start(53.3, self.vb.eyeCast+1)
				end
			end
		end
	elseif spellId == 208672 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnCarrionWave:Show(args.sourceName)
			voiceCarrionWave:Play("kickcast")
		end
	elseif spellId == 206939 then
		warnWellofSouls:Show()
		timerWellOfSoulsCD:Start()
	elseif spellId == 206744 then
		self.vb.blackHarvestCast = self.vb.blackHarvestCast + 1
		specWarnBlackHarvest:Show(self.vb.blackHarvestCast)
		voiceBlackHarvest:Play("aesoon")
		local timer = self:IsEasy() and blackHarvestTimersEasy[self.vb.blackHarvestCast+1] or blackHarvestTimers[self.vb.blackHarvestCast+1]
		if timer then
			timerBlackHarvestCD:Start(timer, self.vb.blackHarvestCast+1)
		end
	elseif spellId == 206222 or spellId == 206221 then
		table.wipe(bondsIcons)
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			--Not a thing!
		else
			local targetName = UnitName("boss1target") or DBM_CORE_UNKNOWN
			if not UnitIsUnit("player", "boss1target") then--the very first bonds of fel, threat reads funny and we need an additional filter
				specWarnBondsofFelTank:Show(targetName)
				voiceBondsofFel:Play("tauntboss")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206222 or spellId == 206221 then
		if self:IsEasy() then
			timerBondsofFelCD:Start()
		else
			timerBondsofFelCD:Start(44.4)
		end
	elseif spellId == 221783 then
		self.vb.flamesSargCast = self.vb.flamesSargCast + 1
		if self:IsEasy() then
			timerFlamesofSargerasCD:Start(nil, self.vb.flamesSargCast+1)
		else
			timerFlamesofSargerasCD:Start(50, self.vb.flamesSargCast+1)--5-6 is 50, 1-5 is 51. For time being using a simple 50 timer
		end
	elseif spellId == 212258 and self.vb.phase > 1.5 then--Ignore phase 1 adds with this cast
		self.vb.handofGuldanCast = self.vb.handofGuldanCast + 1
		specWarnHandofGuldan:Show()
		voiceHandofGuldan:Play("bigmob")
		local timer = handofGuldanTimers[self.vb.handofGuldanCast+1]
		if timer then
			timerHandofGuldanCD:Start(timer, self.vb.handofGuldanCast+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
--[[	if spellId == 206841 then
		timerFelObeliskCD:Start()
		if args:IsPlayer() then
			--DO something here?
		else
			specWarnFelObelisk:Show(args.destName)
			voiceFelObelisk:Play("tauntboss")
		end--]]
--[[	elseif spellId == 212568 then
		specWarnDrain:CombinedShow(0.3, args.destName)--Remove combinedshow if not more than 1 target
		if self:AntiSpam(2, 1) then--remove if only one target
			voiceDrain:Play("helpdispel")
		end--]]
	if spellId == 209011 or spellId == 206354 or spellId == 206384 or spellId == 209086 then--206354/206366 unconfirmed on normal/heroic. LFR/Mythic?
		local isPlayer = args:IsPlayer()
		local name = args.destName
		warnBondsofFel:CombinedShow(0.5, name)
		if isPlayer then
			specWarnBondsofFel:Show()
			voiceBondsofFel:Play("targetyou")
			yellBondsofFel:Yell()
		else
			local uId = DBM:GetRaidUnitId(name)
			if self:IsTanking(uId, "boss1") and not UnitDetailedThreatSituation("player", "boss1") then
				--secondary warning, in case you spaced out the first taunt warning
				specWarnBondsofFelTank:Show(name)
				voiceBondsofFel:Play("tauntboss")
			end
		end
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", name, 5, 600, nil, nil, nil, 0.5):Appear():SetLabel(name)
		end
		if self.Options.HudMapOnBondsofFel and not tContains(bondsIcons, name) then
			bondsIcons[#bondsIcons+1] = name
			self:SetIcon(name, #bondsIcons)
		end
--[[	elseif spellId == 208903 then
		warnBurningClaws:Show(args.destName)
	elseif spellId == 211162 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			if amount >= 6 then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnCharredLacerations:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnCharredLacerationsOther:Show(args.destName)
						voiceCharredLacerations:Play("tauntboss")
					else
						warnCharredLacerations:Show(args.destName, amount)
					end
				end
			else
				warnCharredLacerations:Show(args.destName, amount)
			end
		end--]]
	elseif spellId == 221891 then
		warnSoulSiphon:CombinedShow(0.3, args.destName)
	elseif spellId == 208802 then
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 3 then
			specWarnSoulCorrosion:Show(amount)
		end
	elseif spellId == 221606 then--Looks like the 3 second pre targeting debuff for flames of sargeras
		warnFlamesofSargeras:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFlamesOfSargeras:Show()
			voiceFlamesOfSargeras:Play("runout")
			yellFlamesofSargeras:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId, "boss1") then
				specWarnFlamesOfSargerasTank:Show(args.destName)
				voiceFlamesOfSargeras:Play("tauntboss")
			end
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
		timerFelEffluxCD:Stop()
		timerLiquidHellfireCD:Start(5, self.vb.liquidHellfireCast+1)
		timerFelEffluxCD:Start(10, self.vb.felEffluxCast+1)
	elseif spellId == 227427 then--The Eye of Aman'Thul (phase 3 transition buff)
		self.vb.phase = 3
		self.vb.eyeCast = 0
		warnPhase3:Show()
		timerBondsofFelCD:Stop()
		timerLiquidHellfireCD:Stop()
		timerEyeofGuldanCD:Stop()
		timerHandofGuldanCD:Stop()
		timerWellOfSoulsCD:Start(15)
		timerBlackHarvestCD:Start(63, 1)
		if self:IsEasy() then
			timerFlamesofSargerasCD:Start(29, 1)
			timerEyeofGuldanCD:Start(42.5, 1)
			timerStormOfDestroyerCD:Start(94, 1)--Health based or timer? VERIFY THIS
		else
			timerFlamesofSargerasCD:Start(27.5, 1)
			timerEyeofGuldanCD:Start(39, 1)
			timerStormOfDestroyerCD:Start(84, 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209011 or spellId == 206354 then
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.Options.HudMapOnBondsofFel then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 206384 or spellId == 209086 then--(206366: stunned version mythic?)
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.Options.HudMapOnBondsofFel then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 221603 or spellId == 221785 or spellId == 221784 or spellId == 212686 then--4 different duration versions of Flames of sargeras?
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 206516 and self.vb.phase < 2 then--The Eye of Aman'Thul (phase 1 buff)
		--Backup trigger since sometimes unit_died not fire for all 3 adds
		self.vb.phase = 2
		self.vb.liquidHellfireCast = 0
		warnPhase2:Show()
		timerLiquidHellfireCD:Stop()
		timerFelEffluxCD:Stop()--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
		timerBondsofFelCD:Start(8.8)
		if self:IsEasy() then
			timerEyeofGuldanCD:Start(32.5, 1)
			timerLiquidHellfireCD:Start(45, 1)
		else
			timerHandofGuldanCD:Start(14, 1)
			timerEyeofGuldanCD:Start(29, 1)
			timerLiquidHellfireCD:Start(40, 1)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104537 or cid == 104536 or cid == 104534 then
		if cid == 104537 then--Fel Lord Kuraz'mal
			self.vb.addsDied = self.vb.addsDied + 1
			timerShatterEssenceCD:Stop()
			--timerFelObeliskCD:Stop()
		elseif cid == 104536 then--Inquisitor Vethriz
			timerGazeofVethrizCD:Stop()
			timerShadowBlinkCD:Stop()
			if not self.vb.inquisitorDead then
				self.vb.addsDied = self.vb.addsDied + 1
				self.vb.inquisitorDead = true
			end
		elseif cid == 104534 then--D'zorykx the Trapper
			self.vb.addsDied = self.vb.addsDied + 1
			timerSoulVortexCD:Stop()
		end
		if self.vb.addsDied == 3 and not self:IsMythic() then
			self.vb.phase = 2
			warnPhase2:Show()
			timerLiquidHellfireCD:Stop()
			timerFelEffluxCD:Stop()--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
			timerTransition:Start(19)
			timerBondsofFelCD:Start(28)
			if self:IsEasy() then
				timerEyeofGuldanCD:Start(51.5, 1)
				timerLiquidHellfireCD:Start(64, self.vb.liquidHellfireCast+1)
			else
				timerHandofGuldanCD:Start(33, 1)
				timerEyeofGuldanCD:Start(48, 1)
				timerLiquidHellfireCD:Start(59, self.vb.liquidHellfireCast+1)
			end
		end
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 161121 then--Assumed this is a script like felseeker
		self.vb.stormCast = self.vb.stormCast + 1
		specWarnStormOfDestroyer:Show()
		voiceStormOfDestroyer:Play("watchstep")
		local timer = self:IsEasy() and stormTimersEasy[self.vb.stormCast+1] or stormTimers[self.vb.stormCast+1]
		if timer then
			timerStormOfDestroyerCD:Start(timer, self.vb.stormCast+1)
		end
	elseif spellId == 215736 then--Hand of Guldan (Fel Lord Kuraz'mal)
		timerShatterEssenceCD:Start(19)--Same on normal and heroic. mythic/LFR need vetting.
	elseif spellId == 215738 then--Hand of Guldan (Inquisitor Vethriz)
		if self:IsEasy() then
			--Unknown, died before casting either one
		else
			timerShadowBlinkCD:Start(28.5)
			timerGazeofVethrizCD:Start(28.5)--Basically starts casting it right after blink, then every 5 seconds
		end
	elseif spellId == 215739 then--Hand of Guldan (D'zorykx the Trapper)
		--[[if self:IsEasy() then
			timerSoulVortexCD:Start(52)--Normal verified, LFR assumed
		else
			timerSoulVortexCD:Start(35)--Heroic Jan 21
		end--]]
	elseif spellId == 209601 or spellId == 209637 or spellId == 208831 then--Fel Lord, Inquisitor, Jailer (they cast these on death, more reliable than UNIT_DIED which often doesn't fire for inquisitor)
		local cid = self:GetUnitCreatureId(uId)
		if cid == 104537 or cid == 104536 or cid == 104534 then
			self.vb.addsDied = self.vb.addsDied + 1
			if cid == 104537 then--Fel Lord Kuraz'mal
				timerShatterEssenceCD:Stop()
				--timerFelObeliskCD:Stop()
			elseif cid == 104536 then--Inquisitor Vethriz
				timerGazeofVethrizCD:Stop()
				timerShadowBlinkCD:Stop()
			elseif cid == 104534 then--D'zorykx the Trapper
				--timerSoulVortexCD:Stop()
			end
			if self.vb.addsDied == 3 and not self:IsMythic() then
				--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
				self.vb.phase = 2
				self.vb.liquidHellfireCast = 0
				warnPhase2:Show()
				timerLiquidHellfireCD:Stop()
				timerFelEffluxCD:Stop()
				timerTransition:Start(19)
				timerBondsofFelCD:Start(27.8)
				if self:IsEasy() then
					timerEyeofGuldanCD:Start(51.5, 1)
					timerLiquidHellfireCD:Start(64, 1)
				else
					timerHandofGuldanCD:Start(33, 1)
					timerEyeofGuldanCD:Start(48, 1)
					timerLiquidHellfireCD:Start(59, 1)
				end
			end
		end
	elseif spellId == 227401 then--Phase 2?
		DBM:Debug("227401: phase 2 trigger?")
	elseif spellId == 227682 then--Phase 2?
		DBM:Debug("227682: phase 2 trigger?")
	elseif spellId == 207728 then--Phase 2?
		DBM:Debug("207728: phase 2 trigger?")
	elseif spellId == 227639 then
		DBM:Debug("227639: phase 3 trigger? Mythic Only?")
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
