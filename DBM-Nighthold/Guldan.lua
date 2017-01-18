local mod	= DBM:NewMod(1737, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(105503)--104537 (Fel Lord Kuraz'mal)
mod:SetEncounterID(1866)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(15664)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206219 206220 206514 206675 206840 207938 104534 208545 209270 211152 208672 206939 206744 206883 206221 206222",
	"SPELL_CAST_SUCCESS 206222 206221 221783",
	"SPELL_AURA_APPLIED 206219 206220 209011 206354 206384 209086 208903 211162 221891 208802 221606 221603 221785 221784 212686 227427 206516",
	"SPELL_AURA_APPLIED_DOSE 211162 208802",
	"SPELL_AURA_REMOVED 209011 206354 206384 209086 221603 221785 221784 212686 206516",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
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
or (ability.id = 206222 or ability.id = 206221 or ability.id = 221783) and type = "cast"
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
--local specWarnFelObelisk			= mod:NewSpecialWarningTaunt(206841, nil, nil, nil, 1, 2)
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
local specWarnEyeofGuldan			= mod:NewSpecialWarningSwitch(209270, "Dps", nil, nil, 1, 2)
local specWarnEmpEyeofGuldan		= mod:NewSpecialWarningSwitch(211152, "Dps", nil, nil, 1, 2)
local specWarnCarrionWave			= mod:NewSpecialWarningInterrupt(208672, "HasInterrupt", nil, nil, 1, 2)
--local specWarnCharredLacerations	= mod:NewSpecialWarningStack(211162, nil, 6)--stack guessed
--local specWarnCharredLacerationsOther= mod:NewSpecialWarningTaunt(211162, nil, nil, nil, 1, 2)
--Stage Three: The Master's Power
local specWarnStormOfDestroyer		= mod:NewSpecialWarningDodge(161121, nil, nil, nil, 2, 2)
local specWarnSoulCorrosion			= mod:NewSpecialWarningStack(208802, nil, 3)--stack guessed
local specWarnBlackHarvest			= mod:NewSpecialWarningCount(206744, nil, nil, nil, 2, 2)
local specWarnFlamesOfSargeras		= mod:NewSpecialWarningMoveAway(221606, nil, nil, nil, 3, 2)
local yellFlamesofSargeras			= mod:NewYell(221606)


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
local timerGazeofVethrizCD			= mod:NewCDTimer(4.5, 206840, nil, nil, nil, 3)
local timerShadowBlinkCD			= mod:NewCDTimer(36, 207938)--Role color maybe if blink applies to tank
----D'zorykx the Trapper
mod:AddTimerLine(Dzorykx)
local timerDzorykxCD				= mod:NewCastTimer(35, "ej13129", nil, nil, nil, 1, 212258)
local timerSoulVortexCD				= mod:NewCDTimer(32.5, 206883, nil, nil, nil, 3)--34-36
--Stage Two: The Ritual of Aman'thul
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerTransition				= mod:NewPhaseTimer(19)
local timerBondsofFelCD				= mod:NewNextTimer(50, 206222, nil, nil, nil, 3)
local timerEyeofGuldanCD			= mod:NewNextTimer(60, 209270, nil, nil, nil, 1)
--Stage Three: The Master's Power
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerFlamesofSargerasCD		= mod:NewCDTimer(58.5, 221783, nil, nil, nil, 3)
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
mod.vb.stormCast = 0
mod.vb.blackHarvestCast = 0
mod.vb.empoweredEyeCast = 0
local felEffluxTimers = {11.0, 14.0, 19.9, 15.6, 16.8, 15.9, 15.8}
local stormTimers = {0, 78.6, 70.0}--Might not be timer based,mibht be 25 and 10 %
local blackHarvestTimers = {0, 82.9, 100.0}--Might not be timer based.
local p3EmpoweredEyeTimers = {0, 71.5, 71.4, 28.6}--The 28 one could be a special one he summons at 10%
local bondsIcons = {}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.addsDied = 0
	self.vb.liquidHellfireCast = 0
	self.vb.felEffluxCast = 0
	self.vb.stormCast = 0
	self.vb.blackHarvestCast = 0
	self.vb.empoweredEyeCast = 0
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
			if self.vb.liquidHellfireCast == 2 then
				timerLiquidHellfireCD:Start(23.8, self.vb.liquidHellfireCast+1)
			else
				timerLiquidHellfireCD:Start(32.5, self.vb.liquidHellfireCast+1)
			end
		else--Phase 2
			timerLiquidHellfireCD:Start(41, self.vb.liquidHellfireCast+1)
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
		local timer = felEffluxTimers[self.vb.felEffluxCast+1] or 15.5
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
		timerSoulVortexCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104534, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnSoulVortex:Show()
			yellSoulVortex:Yell()
		elseif targetName then
			warnSoulVortex:Show(targetName)
		end
	elseif spellId == 208545 then
		warnAnguishedSpirits:Show()
	elseif spellId == 209270 or spellId == 211152 then
		if spellId == 211152 then
			specWarnEmpEyeofGuldan:Show()
		else
			specWarnEyeofGuldan:Show()
		end
		voiceEyeofGuldan:Play("killmob")
		if self.vb.phase == 3 then
			self.vb.empoweredEyeCast = self.vb.empoweredEyeCast + 1
			local timer = p3EmpoweredEyeTimers[self.vb.empoweredEyeCast+1]
			if timer then
				timerEyeofGuldanCD:Start(timer)
			end
		else
			timerEyeofGuldanCD:Start()
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
		local timer = blackHarvestTimers[self.vb.blackHarvestCast+1]
		if timer then
			timerBlackHarvestCD:Start(timer, self.vb.blackHarvestCast+1)
		end
	elseif spellId == 206222 or spellId == 206221 then
		table.wipe(bondsIcons)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206222 or spellId == 206221 then
		timerBondsofFelCD:Start()
	elseif spellId == 221783 then
		timerFlamesofSargerasCD:Start()
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
		end
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", name, 5, 600, nil, nil, nil, 0.5):Appear():SetLabel(name)
		end
		local uId = DBM:GetRaidUnitId(name)
		if self:IsTanking(uId, "boss1") and not isPlayer then
			specWarnBondsofFelTank:Show(name)
			voiceBondsofFel:Play("tauntboss")
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
		self.vb.empoweredEyeCast = 0
		warnPhase3:Show()
		timerBondsofFelCD:Stop()
		timerLiquidHellfireCD:Stop()
		timerEyeofGuldanCD:Stop()
		timerWellOfSoulsCD:Start(15)
		timerFlamesofSargerasCD:Start(21)
		timerEyeofGuldanCD:Start(42.5)
		timerBlackHarvestCD:Start(63, 1)
		timerStormOfDestroyerCD:Start(94, 1)--Health based or timer? VERIFY THIS
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
		warnPhase2:Show()
		timerLiquidHellfireCD:Stop()
		timerFelEffluxCD:Stop()--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
		timerBondsofFelCD:Start(9)
		timerEyeofGuldanCD:Start(32.5)
		timerLiquidHellfireCD:Start(45, self.vb.liquidHellfireCast+1)
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
	if cid == 104537 or cid == 104536 or cid == 104534 then
		self.vb.addsDied = self.vb.addsDied + 1
		if cid == 104537 then--Fel Lord Kuraz'mal
			timerShatterEssenceCD:Stop()
			--timerFelObeliskCD:Stop()
		elseif cid == 104536 then--Inquisitor Vethriz
			timerGazeofVethrizCD:Stop()
			timerShadowBlinkCD:Stop()
		elseif cid == 104534 then--D'zorykx the Trapper
			timerSoulVortexCD:Stop()
		end
		if self.vb.addsDied == 3 then
			self.vb.phase = 2
			warnPhase2:Show()
			timerLiquidHellfireCD:Stop()
			timerFelEffluxCD:Stop()--This probably needs refactoring for mythic since phase 1 and 2 happen at same time
			timerTransition:Start(19)
			timerBondsofFelCD:Start(28)
			timerEyeofGuldanCD:Start(51.5)
			timerLiquidHellfireCD:Start(64, self.vb.liquidHellfireCast+1)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 161121 then--Assumed this is a script like felseeker
		self.vb.stormCast = self.vb.stormCast + 1
		specWarnStormOfDestroyer:Show()
		voiceStormOfDestroyer:Play("watchstep")
		local timer = stormTimers[self.vb.stormCast+1]
		if timer then
			timerStormOfDestroyerCD:Start(timer, self.vb.stormCast+1)
		end
	elseif spellId == 215736 then--Hand of Guldan (Fel Lord Kuraz'mal)
		if self:IsEasy() then
			timerShatterEssenceCD:Start(20)
		else
			timerShatterEssenceCD:Start(5)--Verify if still 5 on heroic
		end
	elseif spellId == 215738 then--Hand of Guldan (Inquisitor Vethriz)
		if self:IsEasy() then
			--Unknown, died before casting either one
		else
			timerShadowBlinkCD:Start(2.5)
			timerGazeofVethrizCD:Start(5)
		end
	elseif spellId == 215739 then--Hand of Guldan (D'zorykx the Trapper)
		if self:IsEasy() then
			timerSoulVortexCD:Start(52)
		else
			timerSoulVortexCD:Start(19)--This was hotfixed couple times so reverify on live
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
