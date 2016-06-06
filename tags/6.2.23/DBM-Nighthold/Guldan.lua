local mod	= DBM:NewMod(1737, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(105503)--104537 (Fel Lord Kuraz'mal)
mod:SetEncounterID(1866)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 206219 206220 206514 212258 206675 206840 207938 104534 208545 209270 211152 208672 167819 167935 177380 152987 206939 206744",
	"SPELL_CAST_SUCCESS 212568 206222 206221",
	"SPELL_AURA_APPLIED 206219 206220 206841 212568 209011 206354 206384 209086 208903 211162 221891 208802 221606 221603 221785 221784 212686",
	"SPELL_AURA_APPLIED_DOSE 211162 208802",
	"SPELL_AURA_REMOVED 209011 206354 206384 209086 221603 221785 221784 212686",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, pretty sure 106986 (Gaze of Vethriz) has to be killed
--TODO, if anquished sperits is important, add a timer. if not, remove warning.
--TODO, a LOT more owrk on bonds of fel. Once I understand how it breaks. if it's like shackled torment. how many targets, etc.
--TODO, more work on eye of guldan. if pulsing aoe, maybe only ranged switch?. Timer for duplicate when energy gain rate known
--TODO, hand of guldan in phase 2 probably diff spellid than phase 1, since it calls a different add.
--TODO, adjust charred laceration stacks as needed.
--TODO, fine tune black harvest into special warning if viable. Add timer if it's not cast often.
--TODO, Do a bunch of stuff with well of souls? infoframe to track stacks/who should soak next?
--TODO, figure out flames of sargeras and improve upon it. add timer and keepmove voice if needed.
--Stage One: The Council of Elders
----Gul'dan
local warnLiquidHellfire			= mod:NewTargetAnnounce(206219, 3)
local warnFelEfflux					= mod:NewSpellAnnounce(206514, 3)
local warnHandofGuldan				= mod:NewSpellAnnounce(212258, 3)
----Inquisitor Vethriz
local warnGazeofVethriz				= mod:NewSpellAnnounce(206840, 3)
local warnShadowblink				= mod:NewSpellAnnounce(207938, 2)
----D'zorykx the Trapper
local warnSoulVortex				= mod:NewTargetAnnounce(206883, 3)
local warnAnguishedSpirits			= mod:NewSpellAnnounce(208545, 2)
--Stage Two: The Ritual of Aman'thul
local warnEmpLiquidHellfire			= mod:NewTargetAnnounce(206220, 3)
local warnBurningClaws				= mod:NewTargetAnnounce(208903, 3, nil, "Tank")
local warnCharredLacerations		= mod:NewStackAnnounce(211162, 2, nil, "Tank")
--Stage Three: The Master's Power
local warnStormOfDestroyer			= mod:NewCountAnnounce(161121, 3)
local warnWellofSouls				= mod:NewSpellAnnounce(206939, 4)
local warnSoulSiphon				= mod:NewTargetAnnounce(221891, 3, nil, "Healer")
local warnBlackHarvest				= mod:NewSpellAnnounce(206744, 4)
local warnFlamesofSargeras			= mod:NewTargetAnnounce(206220, 4)

--Stage One: The Council of Elders
----Gul'dan
local specWarnLiquidHellfire		= mod:NewSpecialWarningYou(206219)
local specWarnLiquidHellfireNear	= mod:NewSpecialWarningClose(206219)
local yellLiquidHellfire			= mod:NewYell(206219)
----Fel Lord Kuraz'mal
local specWarnShatterEssence		= mod:NewSpecialWarningDefensive(206675, nil, nil, nil, 3, 2)
local specWarnFelObelisk			= mod:NewSpecialWarningTaunt(206841, nil, nil, nil, 1, 2)
----Inquisitor Vethriz
local specWarnDrain					= mod:NewSpecialWarningDispel(212568, "Healer", nil, nil, 1, 2)
----D'zorykx the Trapper
local specWarnSoulVortex			= mod:NewSpecialWarningYou(206883)
local yellSoulVortex				= mod:NewYell(206883)
--Stage Two: The Ritual of Aman'thul
local specWarnEmpLiquidHellfire		= mod:NewSpecialWarningYou(206220)
local specWarnEmpLiquidHellfireNear	= mod:NewSpecialWarningClose(206220)
local specWarnBondsofFel			= mod:NewSpecialWarningYou(206222)
local specWarnEmpBondsofFel			= mod:NewSpecialWarningYou(206384)
local yellBondsofFel				= mod:NewYell(206222)
local specWarnEyeofGuldan			= mod:NewSpecialWarningSwitch(209270, "Dps", nil, nil, 1, 2)
local specWarnEmpEyeofGuldan		= mod:NewSpecialWarningSwitch(211152, "Dps", nil, nil, 1, 2)
local specWarnCarrionWave			= mod:NewSpecialWarningInterrupt(208672, "HasInterrupt", nil, nil, 1, 2)
local specWarnCharredLacerations	= mod:NewSpecialWarningStack(211162, nil, 6)--stack guessed
local specWarnCharredLacerationsOther= mod:NewSpecialWarningTaunt(211162, nil, nil, nil, 1, 2)
--Stage Three: The Master's Power
local specWarnStormOfDestroyer		= mod:NewSpecialWarningDodge(161121, nil, nil, nil, 2, 2)
local specWarnSoulCorrosion			= mod:NewSpecialWarningStack(208802, nil, 3)--stack guessed
local specWarnFlamesOfSargeras		= mod:NewSpecialWarningMoveAway(221606, nil, nil, nil, 3, 2)
local yellFlamesofSargeras			= mod:NewYell(221606)


--Stage One: The Council of Elders
----Gul'dan
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerLiquidHellfireCD			= mod:NewAITimer(16, 206219, nil, nil, nil, 3)
local timerFelEffluxCD				= mod:NewAITimer(16, 206514, nil, nil, nil, 3)
local timerHandofGuldanCD			= mod:NewAITimer(16, 212258, nil, nil, nil, 1)
----Fel Lord Kuraz'mal
local timerShatterEssenceCD			= mod:NewAITimer(16, 206675, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
local timerFelObeliskCD				= mod:NewAITimer(16, 206841, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Inquisitor Vethriz
local timerGazeofVethrizCD			= mod:NewAITimer(16, 206840, nil, nil, nil, 3)--Add timer maybe
local timerDrainCD					= mod:NewAITimer(16, 212568, nil, "Healer", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerShadowBlinkCD			= mod:NewAITimer(16, 207938)--Roll color maybe if blink applies to tank
----D'zorykx the Trapper
local timerDrainCD					= mod:NewAITimer(16, 212568, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerSoulVortexCD				= mod:NewAITimer(16, 206883, nil, nil, nil, 3)
--Stage Two: The Ritual of Aman'thul
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerBondsofFelCD				= mod:NewAITimer(16, 206222, nil, nil, nil, 3)
local timerEyeofGuldanCD			= mod:NewAITimer(16, 209270, nil, nil, nil, 1)
--Stage Three: The Master's Power
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerStormOfDestroyerCD		= mod:NewAITimer(16, 161121, nil, nil, nil, 3)
local timerWellOfSoulsCD			= mod:NewAITimer(16, 206939, nil, nil, nil, 5)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

--Stage One: The Council of Elders
----Gul'dan
--local voiceLiquidHellfire			= mod:NewVoice(206219)--TODO, figure out what voices once seen
----Fel Lord Kuraz'mal
local voiceShatterEssence			= mod:NewVoice(206675)--defensive (maybe custom one that's more specific and says to use Resonant Barrier)
local voiceFelObelisk				= mod:NewVoice(206841)--tauntboss
----Inquisitor Vethriz
local voiceDrain					= mod:NewVoice(212568, "Healer")--helpdispel
--local voiceSoulVortex				= mod:NewVoice(206883)--TODO, figure out what voices once seen
----D'zorykx the Trapper
--Stage Two: The Ritual of Aman'thul
--local voiceBondsofFel				= mod:NewVoice(206222)--TODO, figure out what voices once seen
local voiceEyeofGuldan				= mod:NewVoice(209270, "Dps")--killmob
local voiceCarrionWave				= mod:NewVoice(208672, "HasInterrupt")--kickcast
local voiceCharredLacerations		= mod:NewVoice(211162)--tauntboss
--Stage Three: The Master's Power
local voiceStormOfDestroyer			= mod:NewVoice(161121)--watchstep
local voiceFlamesOfSargeras			= mod:NewVoice(221606)--runout

mod:AddRangeFrameOption(8, 221606)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnBondsofFel", 206222, "-Tank")

function mod:OnCombatStart(delay)
	timerLiquidHellfireCD:Start(1-delay)
	timerFelEffluxCD:Start(1-delay)
	timerHandofGuldanCD:Start(1-delay)
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
		timerLiquidHellfireCD:Start()
	elseif spellId == 206220 then
		timerLiquidHellfireCD:Start()--use same timer (for now)
	elseif spellId == 206514 then
		warnFelEfflux:Show()
		timerFelEffluxCD:Start()
	elseif spellId == 212258 then
		warnHandofGuldan:Show()
		timerHandofGuldanCD:Start()
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
	elseif spellId == 104534 then
		timerSoulVortexCD:Start()
		local targetName, uId, bossuid = self:GetBossTarget(104534)--Add true if it has a boss unitID
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
		timerEyeofGuldanCD:Start()
	elseif spellId == 208672 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnCarrionWave:Show(args.sourceName)
			voiceCarrionWave:Play("kickcast")
		end
	elseif spellId == 167819 then
		warnStormOfDestroyer:Show(15)
	elseif spellId == 167935 then
		warnStormOfDestroyer:Show(20)
	elseif spellId == 177380 then
		warnStormOfDestroyer:Show(40)
	elseif spellId == 152987 then
		warnStormOfDestroyer:Show(60)
	elseif spellId == 206939 then
		warnWellofSouls:Show()
		timerWellOfSoulsCD:Start()
	elseif spellId == 206744 then
		warnBlackHarvest:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 212568 then
		timerDrainCD:Start()
	elseif spellId == 206222 or spellId == 206221 then
		timerBondsofFelCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206219 then--Might be wrong spell id. blizz fails at tooltips
		if args:IsPlayer() then
			specWarnLiquidHellfire:Show()
			yellLiquidHellfire:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnLiquidHellfireNear:Show(args.destName)
		else
			warnLiquidHellfire:Show(args.destName)
		end
	elseif spellId == 206220 then
		if args:IsPlayer() then
			specWarnEmpLiquidHellfire:Show()
			yellLiquidHellfire:Yell()--use same yell, no reason to make yell text bigger
		elseif self:CheckNearby(10, args.destName) then
			specWarnEmpLiquidHellfireNear:Show(args.destName)
		else
			warnEmpLiquidHellfire:Show(args.destName)
		end
	elseif spellId == 206841 then
		timerFelObeliskCD:Start()
		if args:IsPlayer() then
			--DO something here?
		else
			specWarnFelObelisk:Show(args.destName)
			voiceFelObelisk:Play("tauntboss")
		end
	elseif spellId == 212568 then
		specWarnDrain:CombinedShow(0.3, args.destName)--Remove combinedshow if not more than 1 target
		if self:AntiSpam(2, 1) then--remove if only one target
			voiceDrain:Play("helpdispel")
		end
	elseif spellId == 209011 or spellId == 206354 then--206354 may be LFR version, it has no snare
		if args:IsPlayer() then
			specWarnBondsofFel:Show()
			yellBondsofFel:Yell()
		end
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 600, nil, nil, nil, 0.5):Appear():SetLabel(args.destName)
		end
	elseif spellId == 206384 or spellId == 209086 then--(206366: stunned version mythic?)
		if args:IsPlayer() then
			specWarnEmpBondsofFel:Show()
			yellBondsofFel:Yell()
		end
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 600, nil, nil, nil, 0.5):Appear():SetLabel(args.destName)
		end
	elseif spellId == 208903 then
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
		end
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209011 or spellId == 206354 then
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 206384 or spellId == 209086 then--(206366: stunned version mythic?)
		if self.Options.HudMapOnBondsofFel then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 221603 or spellId == 221785 or spellId == 221784 or spellId == 212686 then--4 different duration versions of Flames of sargeras?
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
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
	if cid == 104537 then--Fel Lord Kuraz'mal
		timerShatterEssenceCD:Stop()
		timerFelObeliskCD:Stop()
	elseif cid == 104536 then--Inquisitor Vethriz
		timerGazeofVethrizCD:Stop()
		timerDrainCD:Stop()
		timerShadowBlinkCD:Stop()
	elseif cid == 104534 then--D'zorykx the Trapper
		timerSoulVortexCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 161121 then--Assumed this is a script like felseeker
		specWarnStormOfDestroyer:Show()
		voiceStormOfDestroyer:Play("watchstep")
		timerStormOfDestroyerCD:Start()
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
