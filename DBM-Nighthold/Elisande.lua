local mod	= DBM:NewMod(1743, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106643)
mod:SetEncounterID(1872)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--During soft enrage will go over 8 debuffs, can't mark beyond that
mod:SetHotfixNoticeRev(16196)
mod.respawnTime = 30

mod:RegisterCombat("combat")
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 209590 209620 221864 209617 209595 210022 209971",
	"SPELL_CAST_SUCCESS 209597 210387 214295 214278 209615 210024",
	"SPELL_AURA_APPLIED 209615 209244 209973 209598 211261 232974",
	"SPELL_AURA_REFRESH 209973",
	"SPELL_AURA_APPLIED_DOSE 209615 209973",
	"SPELL_AURA_REMOVED 209973 209598",
	"SPELL_PERIODIC_DAMAGE 209433",
	"SPELL_PERIODIC_MISSED 209433",
	"PARTY_KILL",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

--TODO, figure out interrupt order/count assistant for stuff
--TODO, determine which interrupts are off by default, if any
--TODO, Adjust beam lines/warnings as needed.
--TODO, Balls special warning on or off by default and for who?
--TODO, figure out how to do yell countdowns on Conflexive Burst. It'll probably require UNIT_AURA player scanning with constant checking of time remaining.
--TODO, are tanks enough to keep Ablative Pulse Interrupted? Dps have enough stuff to interrupt so hopefully tanks can worry about boss on their own
--TODO, auto assign conflexive burst. if always 3 targets have one stand out, 1 go to fast and one go to slow. this will perfectly stagger 3 explosions. assign by mark
--(ability.id = 209595 or ability.id = 208807 or ability.id = 228877 or ability.id = 210022 or ability.id = 209168) and type = "begincast" or (ability.id = 209597 or ability.id = 210387 or ability.id = 214278 or ability.id = 214295 or ability.id = 208863) and type = "cast"
--Base
local warnTemporalisis				= mod:NewSpellAnnounce(209595, 3)
----Recursive Elemental
local warnCompressedTime			= mod:NewSpellAnnounce(209590, 3)
----Expedient Elemental
--Time Layer 1
local warnAblation					= mod:NewStackAnnounce(209615, 2, nil, "Tank")
--Time Layer 2
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnDelphuricBeam				= mod:NewTargetAnnounce(214278, 3)
local warnAblatingExplosion			= mod:NewTargetAnnounce(209973, 3)
--Time Layer 3
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnPermaliativeTorment		= mod:NewTargetAnnounce(210387, 3, nil, "Healer")
local warnConflexiveBurst			= mod:NewTargetAnnounce(209598, 4)

--Base
local specWarnTimeElementals		= mod:NewSpecialWarningSwitchCount(208887, "-Healer", DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(208887), nil, 1, 2)
----Recursive Elemental
local specWarnCompressedTime		= mod:NewSpecialWarningDodge(209590)
local specWarnRecursion				= mod:NewSpecialWarningInterrupt(209620, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlast					= mod:NewSpecialWarningInterrupt(221864, "HasInterrupt", nil, nil, 1, 2)
----Expedient Elemental
--local specWarnExoRelease			= mod:NewSpecialWarningInterrupt(209568, "HasInterrupt", nil, nil, 1, 2)
local specWarnExpedite				= mod:NewSpecialWarningInterrupt(209617, "HasInterrupt", nil, nil, 1, 2)
--Time Layer 1
local specWarnArcaneticRing			= mod:NewSpecialWarningDodge(208807, nil, nil, nil, 2, 5)
local specWarnAblation				= mod:NewSpecialWarningTaunt(209615, nil, nil, nil, 1, 2)
local specWarnSpanningSingularityPre= mod:NewSpecialWarningMoveTo(209168, "RangedDps", nil, 2, 1, 7)
local specWarnSpanningSingularity	= mod:NewSpecialWarningDodge(209168, nil, nil, nil, 2, 2)
local specWarnSingularityGTFO		= mod:NewSpecialWarningMove(209168, "-Tank", nil, 2, 1, 2)
--Time Layer 2
local specWarnDelphuricBeam			= mod:NewSpecialWarningYou(214278, nil, nil, nil, 1, 2)
local yellDelphuricBeam				= mod:NewYell(214278, nil, false)--off by default, because yells last longer than 3-4 seconds so yells from PERVIOUS beam are not yet gone when new beam is cast.
local specWarnEpochericOrb			= mod:NewSpecialWarningSpell(210022, "-Tank", nil, 2, 1, 2)
local specWarnAblationExplosion		= mod:NewSpecialWarningTaunt(209615, nil, nil, nil, 1, 2)
local specWarnAblationExplosionOut	= mod:NewSpecialWarningMoveAway(209615, nil, nil, nil, 1, 2)
local yellAblatingExplosion			= mod:NewFadesYell(209973)
--Time Layer 3
local specWarnConflexiveBurst		= mod:NewSpecialWarningYou(209598, nil, nil, nil, 1, 2)
local specWarnConflexiveBurstTank	= mod:NewSpecialWarningTaunt(209598, nil, nil, nil, 1, 2)
local specWarnAblativePulse			= mod:NewSpecialWarningInterrupt(209971, "Tank", nil, 2, 1, 2)

--Base
local timerRP						= mod:NewRPTimer(68)
local timerLeaveNightwell			= mod:NewCastTimer(9.8, 208863, nil, nil, nil, 6)
local timerTimeElementalsCD			= mod:NewNextSourceTimer(16, 208887, 141872, nil, nil, 1)--"Call Elemental" short text
local timerFastTimeBubble			= mod:NewTimer(35, "timerFastTimeBubble", 209166, nil, nil, 5)
local timerSlowTimeBubble			= mod:NewTimer(70, "timerSlowTimeBubble", 209165, nil, nil, 5)
--209166
--Time Layer 1
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerArcaneticRing			= mod:NewNextCountTimer(6, 208807, nil, nil, nil, 2)
--local timerAblationCD				= mod:NewCDTimer(4.8, 209615, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSpanningSingularityCD	= mod:NewNextCountTimer(16, 209168, nil, nil, nil, 3)
--Time Layer 2
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerDelphuricBeamCD			= mod:NewNextCountTimer(16, 214278, nil, nil, nil, 3)
local timerEpochericOrbCD			= mod:NewNextCountTimer(16, 210022, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerAblatingExplosion		= mod:NewTargetTimer(6, 209973, nil, "Tank")
local timerAblatingExplosionCD		= mod:NewCDTimer(20, 209973, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--Time Layer 3
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerConflexiveBurstCD		= mod:NewNextCountTimer(100, 209597, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--local timerAblativePulseCD			= mod:NewCDTimer(9.6, 209971, nil, "Tank", nil, 4, nil, DBM_CORE_TANK_ICON..DBM_CORE_INTERRUPT_ICON)--12 now?
local timerPermaliativeTormentCD	= mod:NewNextCountTimer(16, 210387, nil, "Healer", nil, 5, nil, DBM_CORE_DEADLY_ICON)

local berserkTimer					= mod:NewBerserkTimer(240)

--Base
--Time Layer 1
local countdownArcaneticRing		= mod:NewCountdown(30, 208807)
local countdownSpanningSingularity	= mod:NewCountdown(30, 209168, "Ranged")--Mythic Only
--Time Layer 2
local countdownOrbs					= mod:NewCountdown("Alt6", 210022, "Ranged")
--Time Layer 3
local countdownConflexiveBurst		= mod:NewCountdown("AltTwo6", 209597)

--Base
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceElemental				= mod:NewVoice(208887)--bigmob
----Recursive Elemental
local voiceRecursion				= mod:NewVoice(209620, "HasInterrupt")--kickcast
local voiceBlast					= mod:NewVoice(221864, "HasInterrupt")--kickcast
----Expedient Elemental
--local voiceExoRelease				= mod:NewVoice(209568, "HasInterrupt")--kickcast
local voiceExpedite					= mod:NewVoice(209617, "HasInterrupt")--kickcast
--Time Layer 1
local voiceArcaneticRing			= mod:NewVoice(208807)--watchorb
local voiceAblation					= mod:NewVoice(209615)--tauntboss
local voiceSpanningSingularity		= mod:NewVoice(209168)--watchstep/runaway
--Time Layer 2
local voiceDelphuricBeam			= mod:NewVoice(214278)--targetyou
local voiceEpochericOrb				= mod:NewVoice(210022, "-Tank", nil, 2)--161612(catch balls)
local voiceAblatingExplosion		= mod:NewVoice(209973)--runout/tauntboss
--Time Layer 3
local voiceConflexiveBurst			= mod:NewVoice(209598)--targetyou (review for better voice)
local voiceAblativePulse			= mod:NewVoice(209971, "Tank", nil, 2)--kickcast

mod:AddRangeFrameOption(8, 209973)
mod:AddInfoFrameOption(209598)
mod:AddSetIconOption("SetIconOnConflexiveBurst", 209598)

--Exists in phases 1-3
local heroicSlowElementalTimers = {5, 49, 52, 60}--Heroic Jan 18
local normalSlowElementalTimers = {5, 49, 41}--Normal Jan 26
local lfrSlowElementalTimers = {5, 62, 40}--LFR Apr 2
local mythicP1SlowElementalTimers = {5, 39, 75}--Mythic Feb 5
local mythicP2SlowElementalTimers = {5, 39, 45, 30, 30, 30}--Mythic Feb 5
local mythicP3SlowElementalTimers = {5, 54, 55, 30}--Mythic Feb 5
local heroicFastElementalTimers = {8, 88, 95, 20}--Heroic Jan 19
local normalFastElementalTimers = {8, 71}--Normal Jan 26
--local lfrFastElementalTimers = {65}--LFR Apr 2 (currently unused since the first timer on phase change and combat start not started by this. Will be used if ever see second one spawn
local mythicP1FastElementalTimers = {8, 81.0}--Mythic Feb 5
local mythicP2FastElementalTimers = {8, 51}--Mythic Feb 5
local mythicP3FastElementalTimers = {8, 36, 44}--Mythic Feb 5
local heroicRingTimers = {34, 40, 10, 62, 9, 45}--Heroic Jan 19
local normalRingTimers = {34, 30, 75, 50}--Normal Feb 8
local mythicRingTimers = {30, 39, 14.7, 30, 19, 10, 25, 9, 10, 10}--Mythic Feb 5 (figure out that 25 in middle of 10s)
local lfrRingTimers = {21, 30, 37, 35}
local heroicSingularityTimers = {10, 22, 36.0, 57, 65}--Heroic Jan 18
local normalSingularityTimers = {10, 22, 36.0, 46}--Normal Feb 2
local mythicSingularityTimers = {10, 53.7, 49.8, 45}--Mythic April 20th
local lfrSingularityTimers = {10, 15, 57, 30}--LFR April 2nd
--Only exist in phase 2
local heroicBeamTimers = {72, 57, 60}--Heroic Jan 18
local normalBeamTimers = {72, 26, 40}--Normal Feb 2
local mythicBeamTimers = {67, 50, 65}--Mythic Feb 5
local lfrBeamTimers = {23.7, 25.0, 76.9}--LFR April 2
--Exists in Phase 2 and Phase 3 (but cast start event missing in phase 3)
local heroicOrbTimers = {27, 76, 37, 70, 15, 15, 15}--Heroic Jan 18
local normalOrbTimers = {27, 56, 31}--Normal Feb 2
local mythicOrbTimers = {24, 85, 60, 20, 10}--Mythic Feb 5
local lfrOrbTimers = {50, 37}--LFR Apr 2
--Only exist in phase 3 so first timer of course isn't variable
local heroicBurstTimers = {58, 52.0, 56.0, 65.0, 10.0, 10.0, 10.0, 10.0}--Heroic Jan 21 (normal ones are different i'm sure, just no data to fix yet)
local normalBurstTimers = {58, 67}--Normal Feb 2
local mythicBurstTimers = {48, 90, 45, 30}--Mythic Feb 5
local heroicTormentTimers = {33, 61, 37, 60}--Heroic Jan 21
local normalTormentTimers = {33, 41}--Normal Feb 2
local mythicTormentTimers = {74, 75, 25, 20}--Mythic Feb 5
mod.vb.firstElementals = false
mod.vb.slowElementalCount = 0
mod.vb.fastElementalCount = 0
mod.vb.slowBubbleCount = 0
mod.vb.fastBubbleCount = 0
mod.vb.tormentCastCount = 0
mod.vb.ringCastCount = 0
mod.vb.beamCastCount = 0
mod.vb.orbCastCount = 0
mod.vb.burstCastCount = 0
mod.vb.burstDebuffCount = 0
mod.vb.singularityCount = 1
mod.vb.phase = 1
mod.vb.transitionActive = false
--Saved Information for echos
mod.vb.totalRingCasts = 0
mod.vb.totalbeamCasts = 0
mod.vb.totalsingularityCasts = 0

function mod:OnCombatStart(delay)
	self.vb.slowElementalCount = 0
	self.vb.fastElementalCount = 0
	self.vb.slowBubbleCount = 0
	self.vb.fastBubbleCount = 0
	self.vb.tormentCastCount = 0
	self.vb.ringCastCount = 0
	self.vb.burstDebuffCount = 0
	self.vb.singularityCount = 1--First one on pull doesn't have an event so have to skip it in count
	self.vb.phase = 1
	self.vb.transitionActive = false
	self.vb.totalRingCasts = 0
	self.vb.totalbeamCasts = 0
	self.vb.totalsingularityCasts = 1
	timerLeaveNightwell:Start(4-delay)
	timerTimeElementalsCD:Start(5-delay, SLOW)
	--timerAblationCD:Start(8.5-delay)--Verify/tweak
	if self:IsMythic() then
		timerTimeElementalsCD:Start(8-delay, FAST)
		timerSpanningSingularityCD:Start(53.7-delay, 2)
		specWarnSpanningSingularityPre:Schedule(48.7, DBM_CORE_ROOM_EDGE)
		if self.Options.SpecWarn209168moveto then
			voiceSpanningSingularity:Schedule(48.7, "runtoedge")
		end
		countdownSpanningSingularity:Start(53.7)
		timerArcaneticRing:Start(30-delay, 1)
		countdownArcaneticRing:Start(30-delay)
	elseif self:IsLFR() then
		timerSpanningSingularityCD:Start(15-delay, 2)
		timerArcaneticRing:Start(21-delay, 1)
		countdownArcaneticRing:Start(21-delay)
		timerTimeElementalsCD:Start(65-delay, FAST)
	else
		timerTimeElementalsCD:Start(8-delay, FAST)
		timerSpanningSingularityCD:Start(22-delay, 2)
		timerArcaneticRing:Start(34-delay, 1)
		countdownArcaneticRing:Start(34-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 209590 then
		warnCompressedTime:Show()
	elseif spellId == 209620 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnRecursion:Show(args.sourceName)
			voiceRecursion:Play("kickcast")
		end
	elseif spellId == 221864 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnBlast:Show(args.sourceName)
			voiceBlast:Play("kickcast")
		end
--[[	elseif spellId == 209568 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExoRelease:Show(args.sourceName)
			voiceExoRelease:Play("kickcast")
		end--]]
	elseif spellId == 209617 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnExpedite:Show(args.sourceName)
			voiceExpedite:Play("kickcast")
		end
	elseif spellId == 209971 then
		--timerAblativePulseCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnAblativePulse:Show(args.sourceName)
			voiceAblativePulse:Play("kickcast")
		end
	elseif spellId == 209595 then
		warnTemporalisis:Show()
	elseif spellId == 210022 and self:AntiSpam(15, 4) then
		self.vb.orbCastCount = self.vb.orbCastCount + 1
		specWarnEpochericOrb:Show()
		voiceEpochericOrb:Play("161612")
		local nextCount = self.vb.orbCastCount + 1
		local timer = self:IsMythic() and mythicOrbTimers[nextCount] or self:IsNormal() and normalOrbTimers[nextCount] or self:IsHeroic() and heroicOrbTimers[nextCount] or self:IsLFR() and lfrOrbTimers[nextCount]
		if timer then
			timerEpochericOrbCD:Start(timer, nextCount)
			countdownOrbs:Start(timer)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 209597 then
		self.vb.burstCastCount = self.vb.burstCastCount + 1
		local nextCount = self.vb.burstCastCount + 1
		local timer = self:IsMythic() and mythicBurstTimers[nextCount] or self:IsNormal() and normalBurstTimers[nextCount] or self:IsHeroic() and heroicBurstTimers[nextCount]
		if timer then
			timerConflexiveBurstCD:Start(timer, nextCount)
			countdownConflexiveBurst:Start(timer)
		end
	elseif spellId == 210387 then
		self.vb.tormentCastCount = self.vb.tormentCastCount + 1
		local nextCount = self.vb.tormentCastCount + 1
		local timer = self:IsMythic() and mythicTormentTimers[nextCount] or self:IsNormal() and normalTormentTimers[nextCount] or self:IsHeroic() and heroicTormentTimers[nextCount]
		if timer then
			timerPermaliativeTormentCD:Start(timer, nextCount)
		end
	elseif (spellId == 214278 or spellId == 214295) and self:AntiSpam(10, 2) then--Boss: 214278, Echo: 214295
		self.vb.beamCastCount = self.vb.beamCastCount + 1
		local nextCount = self.vb.beamCastCount + 1
		if self.vb.phase == 2 then
			self.vb.totalbeamCasts = self.vb.totalbeamCasts + 1
		else
			if nextCount > self.vb.totalbeamCasts then return end
		end
		local timer = self:IsMythic() and mythicBeamTimers[nextCount] or self:IsNormal() and normalBeamTimers[nextCount] or self:IsHeroic() and heroicBeamTimers[nextCount] or self:IsLFR() and lfrBeamTimers[nextCount]
		if timer then
			timerDelphuricBeamCD:Start(timer, nextCount)
		end
	elseif spellId == 209615 then
		--timerAblationCD:Start()
	elseif spellId == 210024 and self:AntiSpam(15, 4) then
		self.vb.orbCastCount = self.vb.orbCastCount + 1
		local nextCount = self.vb.orbCastCount + 1
		local timer = self:IsMythic() and mythicOrbTimers[nextCount] or self:IsNormal() and normalOrbTimers[nextCount] or self:IsHeroic() and heroicOrbTimers[nextCount] or self:IsLFR() and lfrOrbTimers[nextCount]
		if timer then
			specWarnEpochericOrb:Schedule(timer-10)
			voiceEpochericOrb:Schedule(timer-10, "161612")
			timerEpochericOrbCD:Start(timer-10, nextCount)
			countdownOrbs:Start(timer-10)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209615 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnAblation:Show(args.destName)
					voiceAblation:Play("tauntboss")
				else
					warnAblation:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 211261 then
		warnPermaliativeTorment:CombinedShow(0.5, args.destName)
	elseif spellId == 209244 then--Could still use more, but this is only spell ID on heroic that was used for debuff.
		warnDelphuricBeam:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDelphuricBeam:Show()
			voiceDelphuricBeam:Play("targetyou")
			yellDelphuricBeam:Yell()
		end
	elseif spellId == 209973 then
		warnAblatingExplosion:Show(args.destName)
		timerAblatingExplosion:Start(args.destName)
		timerAblatingExplosionCD:Start()
		if args:IsPlayer() then
			specWarnAblationExplosionOut:Show()
			voiceAblatingExplosion:Play("runout")
			yellAblatingExplosion:Cancel()
			yellAblatingExplosion:Schedule(3, 3)
			yellAblatingExplosion:Schedule(4, 2)
			yellAblatingExplosion:Schedule(5, 1)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			specWarnAblationExplosion:Show(args.destName)
			voiceAblatingExplosion:Play("tauntboss")
		end
	elseif spellId == 209598 then
		self.vb.burstDebuffCount = self.vb.burstDebuffCount + 1
		warnConflexiveBurst:CombinedShow(0.5, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		if args:IsPlayer() then
			specWarnConflexiveBurst:Show()
			voiceConflexiveBurst:Play("targetyou")
		elseif self:IsTanking(uId, "boss1") then
			specWarnConflexiveBurstTank:Show(args.destName)
			voiceConflexiveBurst:Play("tauntboss")
		end
		if self.Options.SetIconOnConflexiveBurst then
			self:SetAlphaIcon(0.5, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	end
end
mod.SPELL_AURA_RESFRESH = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209973 then
		timerAblatingExplosion:Stop(args.destName)
		if args:IsPlayer() then
			yellAblatingExplosion:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 209598 then
		self.vb.burstDebuffCount = self.vb.burstDebuffCount - 1
		if args:IsPlayer() then
			--Cancel yells when they are added
		end
		if self.Options.SetIconOnConflexiveBurst then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.InfoFrame and self.vb.burstDebuffCount == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 209433 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnSingularityGTFO:Show()
		if not self:IsTank() then
			voiceSpanningSingularity:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Done this way because it's less ugly for 1, but 2, the other way will fail if there is ever more than 1 of SAME TYPE up at once and one of them dies.
function mod:PARTY_KILL(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105299 then -- Recursive
		self:SendSync("SlowAddDied")
	elseif cid == 105301 then -- Expedient
		self:SendSync("FastAddDied")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 211647 then--Time Stop
		self.vb.transitionActive = true
		self.vb.phase = self.vb.phase + 1
		--self.vb.firstElementals = false
		self.vb.slowElementalCount = 0
		self.vb.fastElementalCount = 0
		self.vb.slowBubbleCount = 0
		self.vb.fastBubbleCount = 0
		self.vb.ringCastCount = 0
		self.vb.beamCastCount = 0
		self.vb.singularityCount = 0
		self.vb.orbCastCount = 0
		timerArcaneticRing:Stop()
		countdownArcaneticRing:Cancel()
		timerTimeElementalsCD:Stop()
		timerSlowTimeBubble:Stop()
		timerFastTimeBubble:Stop()
		timerEpochericOrbCD:Stop()
		countdownOrbs:Cancel()
		timerSpanningSingularityCD:Stop()
		specWarnSpanningSingularityPre:Cancel()
		voiceSpanningSingularity:Cancel()
		countdownSpanningSingularity:Cancel()
		timerDelphuricBeamCD:Stop()
		berserkTimer:Cancel()
		timerLeaveNightwell:Start()
		timerSpanningSingularityCD:Start(10, 1)--Updated Jan 18 heroic
		timerTimeElementalsCD:Start(14.7, SLOW)--Updated Jan 18 heroic
		if self:IsLFR() then
			timerTimeElementalsCD:Start(74.9, FAST)--Updated April 2
		else
			timerTimeElementalsCD:Start(17, FAST)--Updated Jan 18 (17-18)
		end
		if self.vb.phase == 2 then
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
			timerAblatingExplosionCD:Start(22)--Verfied unchanged Dec 13 Heroic
			if self:IsMythic() then--TODO: Fine tune these as they may be hit or miss by some seconds Hard to measure precise phase changes from WCL
				timerEpochericOrbCD:Start(23.8, 1)
				countdownOrbs:Start(23.8)
				timerArcaneticRing:Start(41.9, 1)--Verified Jan 18
				countdownArcaneticRing:Start(41.9)
				timerDelphuricBeamCD:Start(67, 1)--Cast SUCCESS
				countdownSpanningSingularity:Start(10)
			elseif self:IsHeroic() then
				timerEpochericOrbCD:Start(27, 1)
				countdownOrbs:Start(27)
				timerArcaneticRing:Start(45.7, 1)--Verified Jan 18
				countdownArcaneticRing:Start(45.7)
				timerDelphuricBeamCD:Start(72, 1)--Cast SUCCESS
			--LFR and Normal have no rings. LFR has no beams
			elseif self:IsLFR() then
				timerEpochericOrbCD:Start(50, 1)
				countdownOrbs:Start(50)
			else--Normal
				timerEpochericOrbCD:Start(27, 1)
				countdownOrbs:Start(27)
				timerDelphuricBeamCD:Start(72, 1)--Cast SUCCESS
			end
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
			self.vb.burstCastCount = 0
			timerAblatingExplosionCD:Stop()
			yellAblatingExplosion:Cancel()
			--timerAblativePulseCD:Start(20.5)
			if self:IsMythic() then
				countdownSpanningSingularity:Start(10)
				timerEpochericOrbCD:Start(24, 1)
				countdownOrbs:Start(24)
				specWarnEpochericOrb:Schedule(24)--Spawning isn't in combat log in phase 3, only landing, so need to use schedule for warnings
				voiceEpochericOrb:Schedule(24, "161612")
				timerArcaneticRing:Start(42, 1)--Verified Jan 18
				countdownArcaneticRing:Start(42)
				timerConflexiveBurstCD:Start(48, 1)
				countdownConflexiveBurst:Start(48)
				timerPermaliativeTormentCD:Start(73.7, 1)--Updated April 21 Mythic
			elseif self:IsHeroic() then
				timerEpochericOrbCD:Start(27, 1)
				countdownOrbs:Start(27)
				specWarnEpochericOrb:Schedule(27)--Spawning isn't in combat log in phase 3, only landing, so need to use schedule for warnings
				voiceEpochericOrb:Schedule(27, "161612")
				timerPermaliativeTormentCD:Start(33, 1)
				timerArcaneticRing:Start(45.7, 1)--Verified Jan 18
				countdownArcaneticRing:Start(45.7)
				timerConflexiveBurstCD:Start(57.7, 1)
				countdownConflexiveBurst:Start(57.7)
			elseif self:IsLFR() then
				timerDelphuricBeamCD:Start(23.7, 1)--Special exception
			else--Normal
				timerPermaliativeTormentCD:Start(33, 1)
				timerConflexiveBurstCD:Start(57.7, 1)
				countdownConflexiveBurst:Start(57.7)
			end
		end
	elseif spellId == 208863 then
		self.vb.transitionActive = false
		if self:IsMythic() then 
			if self.vb.phase == 3 then
				berserkTimer:Start(194)
			else
				berserkTimer:Start(199)
			end
		end
	elseif spellId == 209005 and not self.vb.transitionActive then--Summon Time Elemental - Slow
		self.vb.slowElementalCount = self.vb.slowElementalCount + 1
		--if self.vb.firstElementals then
			specWarnTimeElementals:Show(SLOW)
			voiceElemental:Play("bigmob")
		--end
		local timer
		local nextCount = self.vb.slowElementalCount+1
		if self:IsMythic() then
			timer = self.vb.phase == 1 and mythicP1SlowElementalTimers[nextCount] or self.vb.phase == 2 and mythicP2SlowElementalTimers[nextCount] or mythicP3SlowElementalTimers[nextCount]
		else
			timer = self:IsNormal() and normalSlowElementalTimers[nextCount] or self:IsHeroic() and heroicSlowElementalTimers[nextCount] or self:IsLFR() and lfrSlowElementalTimers[nextCount]
		end
		if timer then
			timerTimeElementalsCD:Start(timer, SLOW)
		end
	elseif (spellId == 209007 or spellId == 211616) and not self.vb.transitionActive then--Summon Time Elemental - Fast
		self.vb.fastElementalCount = self.vb.fastElementalCount + 1
		--if self.vb.firstElementals then
			specWarnTimeElementals:Show(FAST)
			voiceElemental:Play("bigmob")
		--end
		local timer
		local nextCount = self.vb.fastElementalCount+1
		if self:IsMythic() then
			timer = self.vb.phase == 1 and mythicP1FastElementalTimers[nextCount] or self.vb.phase == 2 and mythicP2FastElementalTimers[nextCount] or mythicP3FastElementalTimers[nextCount]
		else
			timer = self:IsNormal() and normalFastElementalTimers[nextCount] or self:IsHeroic() and heroicFastElementalTimers[nextCount]
		end
		if timer then
			timerTimeElementalsCD:Start(timer, FAST)
		end
	elseif spellId == 208887 then--Summon Time Elementals (summons both of them, used at beginning of each phase)
		--self.vb.firstElementals = true
		--specWarnTimeElementals:Show(STATUS_TEXT_BOTH)
		--voiceElemental:Play("bigmob")
		DBM:Debug("Both elementals summoned, this event still exists, probably need custom code for certain difficulties")
	elseif (spellId == 209168 or spellId == 233013 or spellId == 233012 or spellId == 233011 or spellId == 233009 or spellId == 233010) and self:AntiSpam(4, 3) and not self.vb.transitionActive then
		self.vb.singularityCount = self.vb.singularityCount + 1
		specWarnSpanningSingularity:Show()
		voiceSpanningSingularity:Play("watchstep")
		local nextCount = self.vb.singularityCount + 1
		if self.vb.phase == 1 then
			self.vb.totalsingularityCasts = self.vb.totalsingularityCasts + 1
		else
			if nextCount > self.vb.totalsingularityCasts then return end--There won't be any more
		end
		local timer = self:IsMythic() and mythicSingularityTimers[nextCount] or self:IsNormal() and normalSingularityTimers[nextCount] or self:IsHeroic() and heroicSingularityTimers[nextCount] or self:IsLFR() and lfrSingularityTimers[nextCount]
		if timer then
			timerSpanningSingularityCD:Start(timer, nextCount)
			if self:IsMythic() then
				specWarnSpanningSingularityPre:Schedule(timer-5, DBM_CORE_ROOM_EDGE)
				if self.Options.SpecWarn209168moveto then
					voiceSpanningSingularity:Schedule(timer-5, "runtoedge")
				end
				countdownSpanningSingularity:Start(timer)
			end
		end
	end
end

--Phase 2 and 3 do not have event for cast. CLEU is unreliable.
--CHAT_MSG_MONSTER_YELL is faster than CHAT_MSG_RAID_BOSS_EMOTE but emote doesn't require localizing, so emote exists purely as backup.
---"<441.20 14:04:16> [CHAT_MSG_MONSTER_YELL] Let the waves of time crash over you!#Echo of Elisande#####0#0##0#962#nil#0#false#false#false#false", -- [7359]
--It's now possible to do this with secondary event but it's 2 seconds slower so it should only be used as a backup with this as ideal primary still
function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if (msg == L.noCLEU4EchoRings or msg:find(L.noCLEU4EchoRings)) then
		self:SendSync("ArcaneticRing")--Syncing to help unlocalized clients
	elseif (msg == L.noCLEU4EchoOrbs or msg:find(L.noCLEU4EchoOrbs)) then
		self:SendSync("Orbs")--Syncing to help unlocalized clients
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg, npc, _, _, target)
	if (msg == L.prePullRP or msg:find(L.prePullRP)) and self:LatencyCheck() then
		self:SendSync("ElisandeRP")
	end
end

--Backup to above yell, it's 2 seconds slower but works without localizing
--"<228.48 22:48:56> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\Spell_Mage_ArcaneOrb.blp:20|t |cFFFF0000|Hspell:228877|h[Arcanetic Rings]|h|
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228877") and self:AntiSpam(5, 1) then
		self.vb.ringCastCount = self.vb.ringCastCount + 1
		specWarnArcaneticRing:Show()
		voiceArcaneticRing:Play("watchorb")
		local nextCount = self.vb.ringCastCount + 1
		if self.vb.phase == 1 then
			self.vb.totalRingCasts = self.vb.totalRingCasts + 1
		else
			if nextCount > self.vb.totalRingCasts then return end--There won't be any more
		end
		local timer = self:IsMythic() and mythicRingTimers[nextCount] or self:IsNormal() and normalRingTimers[nextCount] or self:IsHeroic() and heroicRingTimers[nextCount] or self:IsLFR() and lfrRingTimers[nextCount]
		if timer then
			timerArcaneticRing:Start(timer-2, nextCount)
			countdownArcaneticRing:Start(timer-2)
		end
	end
end

function mod:OnSync(msg, targetname)
	if msg == "ElisandeRP" and self:AntiSpam(10, 6) then
		timerRP:Start()
	end
	if not self:IsInCombat() then return end
	if msg == "ArcaneticRing" and self:AntiSpam(5, 1) then
		self.vb.ringCastCount = self.vb.ringCastCount + 1
		specWarnArcaneticRing:Show()
		voiceArcaneticRing:Play("watchorb")
		local nextCount = self.vb.ringCastCount + 1
		if self.vb.phase == 1 then
			self.vb.totalRingCasts = self.vb.totalRingCasts + 1
		else
			if nextCount > self.vb.totalRingCasts then return end--There won't be any more
		end
		local timer = self:IsMythic() and mythicRingTimers[nextCount] or self:IsNormal() and normalRingTimers[nextCount] or self:IsHeroic() and heroicRingTimers[nextCount] or self:IsLFR() and lfrRingTimers[nextCount]
		if timer then
			timerArcaneticRing:Start(timer, nextCount)
			countdownArcaneticRing:Start(timer)
		end
	elseif msg == "Orbs" and self:AntiSpam(15, 4) then
		specWarnEpochericOrb:Cancel()
		voiceEpochericOrb:Cancel()
		countdownOrbs:Cancel()
		self.vb.orbCastCount = self.vb.orbCastCount + 1
		specWarnEpochericOrb:Show()
		voiceEpochericOrb:Play("161612")
		local nextCount = self.vb.orbCastCount + 1
		local timer = self:IsMythic() and mythicOrbTimers[nextCount] or self:IsNormal() and normalOrbTimers[nextCount] or self:IsHeroic() and heroicOrbTimers[nextCount] or self:IsLFR() and lfrOrbTimers[nextCount]
		if timer then
			timerEpochericOrbCD:Start(timer, nextCount)
			countdownOrbs:Start(timer)
		end
	elseif msg == "SlowAddDied" then
		self.vb.slowBubbleCount = self.vb.slowBubbleCount + 1
		timerSlowTimeBubble:Start(70, self.vb.slowBubbleCount)
	elseif msg == "FastAddDied" then
		self.vb.fastBubbleCount = self.vb.fastBubbleCount + 1
		timerFastTimeBubble:Start(35, self.vb.fastBubbleCount)
	end
end
