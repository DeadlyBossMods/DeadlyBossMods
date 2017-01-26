local mod	= DBM:NewMod(1743, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(106643)
mod:SetEncounterID(1872)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--During soft enrage will go over 8 debuffs, can't mark beyond that
mod:SetHotfixNoticeRev(15735)
mod.respawnTime = 30

mod:RegisterCombat("combat")
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 209590 209620 221864 209617 209595 210022 209971",
	"SPELL_CAST_SUCCESS 209597 210387 214295 214278 209615 210024",
	"SPELL_AURA_APPLIED 209615 209244 209973 209598 211261 232974",
	"SPELL_AURA_REFRESH 209973",
	"SPELL_AURA_APPLIED_DOSE 209615 209973",
	"SPELL_AURA_REMOVED 209973 209598",
--	"SPELL_PERIODIC_DAMAGE 209433",
--	"SPELL_PERIODIC_MISSED 209433",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
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
local specWarnSpanningSingularity	= mod:NewSpecialWarningDodge(209168, nil, nil, nil, 2, 2)
--local specWarnSingularityGTFO		= mod:NewSpecialWarningMove(209168, nil, nil, nil, 1, 2)
--Time Layer 2
local specWarnDelphuricBeam			= mod:NewSpecialWarningYou(214278, nil, nil, nil, 1, 2)
local yellDelphuricBeam				= mod:NewYell(214278, nil, false)--off by default, because yells last longer than 3-4 seconds so yells from PERVIOUS beam are not yet gone when new beam is cast.
local specWarnEpochericOrb			= mod:NewSpecialWarningSpell(210022, "-Tank", nil, 2, 1, 2)
local specWarnAblationExplosion		= mod:NewSpecialWarningTaunt(209615, nil, nil, nil, 1, 2)
local specWarnAblationExplosionOut	= mod:NewSpecialWarningMoveAway(209615, nil, nil, nil, 1, 2)
local yellAblatingExplosion			= mod:NewFadesYell(209973)
--Time Layer 3
local specWarnConflexiveBurst		= mod:NewSpecialWarningYou(209598, nil, nil, nil, 1, 2)
local specWarnAblativePulse			= mod:NewSpecialWarningInterrupt(209971, "HasInterrupt", nil, nil, 1, 2)

--Base
local timerLeaveNightwell			= mod:NewCastTimer(9.8, 208863, nil, nil, nil, 6)
local timerTimeElementalsCD			= mod:NewNextSourceTimer(16, 208887, 141872, nil, nil, 1)--"Call Elemental" short text
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

--local berserkTimer					= mod:NewBerserkTimer(240)--4 minute berserk that resets when she changes layers.

--Base
--Time Layer 1
local countdownArcaneticRing		= mod:NewCountdown(30, 208807)
--Time Layer 2
local countdownDelphuricBeam		= mod:NewCountdown("Alt6", 214278)
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
local voiceAblativePulse			= mod:NewVoice(209971, "HasInterrupt")--kickcast

mod:AddRangeFrameOption(8, 209973)
mod:AddInfoFrameOption(209598)
mod:AddSetIconOption("SetIconOnConflexiveBurst", 209598)
mod:AddHudMapOption("HudMapOnDelphuricBeam", 214278)

--Exists in phases 1-3
local slowElementalTimers = {5, 49, 52, 60}--Heroic Jan 18
local easyslowElementalTimers = {5, 49, 41}--Heroic Jan 26
local fastElementalTimers = {8, 88, 95, 20}--Heroic Jan 19
local easyfastElementalTimers = {8, 71}--Norma Jan 26
local RingTimers = {34, 40, 10, 62, 9, 45}--Heroic Jan 19
local easyRingTimers = {34, 30}--Normal Jan 26
local SingularityTimers = {10, 22, 36.0, 57, 65}--Heroic Jan 18
--Only exist in phase 2
local BeamTimers = {72, 57, 60}--Heroic Jan 18
--Exists in Phase 2 and Phase 3 (but cast start event missing in phase 3)
local OrbTimers = {27, 76, 37, 70}--Heroic Jan 18
--Only exist in phase 3 so first timer of course isn't variable
local BurstTimers = {58, 52.0, 56.0, 65.0, 10.0, 10.0, 10.0, 10.0}--Heroic Jan 21 (normal ones are different i'm sure, just no data to fix yet)
local TormentTimers = {33, 61, 37, 60}--Heroic Jan 21
local currentTank, tankUnitID = nil, nil--not recoverable on purpose
mod.vb.firstElementals = false
mod.vb.slowElementalCount = 0
mod.vb.fastElementalCount = 0
mod.vb.tormentCastCount = 0
mod.vb.ringCastCount = 0
mod.vb.beamCastCount = 0
mod.vb.orbCastCount = 0
mod.vb.burstCastCount = 0
mod.vb.burstDebuffCount = 0
mod.vb.singularityCount = 1
mod.vb.phase = 1
--Saved Information for echos
mod.vb.totalRingCasts = 0
mod.vb.totalbeamCasts = 0
mod.vb.totalsingularityCasts = 0
mod.vb.pos1X, mod.vb.pos1Y = nil, nil
mod.vb.pos2X, mod.vb.pos2Y = nil, nil
mod.vb.pos3X, mod.vb.pos3Y = nil, nil
mod.vb.pos4X, mod.vb.pos4Y = nil, nil
mod.vb.pos5X, mod.vb.pos5Y = nil, nil
mod.vb.pos6X, mod.vb.pos6Y = nil, nil
mod.vb.pos7X, mod.vb.pos7Y = nil, nil

local function checkPlayerDot(self, spellName)
	if not UnitDebuff("player", spellName) then
 		DBMHudMap:RegisterRangeMarkerOnPartyMember(209244, "party", UnitName("player"), 0.7, 3, nil, nil, nil, 1, nil, false):Appear()--Create Player Dot
	end
end

function mod:OnCombatStart(delay)
	currentTank, tankUnitID = nil, nil
	--self.vb.firstElementals = false
	self.vb.slowElementalCount = 0
	self.vb.fastElementalCount = 0
	self.vb.tormentCastCount = 0
	self.vb.ringCastCount = 0
	self.vb.burstDebuffCount = 0
	self.vb.singularityCount = 1--First one on pull doesn't have an event so have to skip it in count
	self.vb.phase = 1
	self.vb.totalRingCasts = 0
	self.vb.totalbeamCasts = 0
	self.vb.totalsingularityCasts = 0
	self.vb.pos1X, self.vb.pos1Y = nil, nil
	self.vb.pos2X, self.vb.pos2Y = nil, nil
	self.vb.pos3X, self.vb.pos3Y = nil, nil
	self.vb.pos4X, self.vb.pos4Y = nil, nil
	self.vb.pos5X, self.vb.pos5Y = nil, nil
	self.vb.pos6X, self.vb.pos6Y = nil, nil
	self.vb.pos7X, self.vb.pos7Y = nil, nil
	timerTimeElementalsCD:Start(5-delay, SLOW)
	timerTimeElementalsCD:Start(8-delay, FAST)
	--timerAblationCD:Start(8.5-delay)--Verify/tweak
	timerSpanningSingularityCD:Start(23-delay, 2)
	timerArcaneticRing:Start(34-delay, 1)
	countdownArcaneticRing:Start(34-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnDelphuricBeam then
		DBMHudMap:Disable()
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
		local timer = OrbTimers[nextCount]
		if timer then
			timerEpochericOrbCD:Start(timer, nextCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 209597 then
		self.vb.burstCastCount = self.vb.burstCastCount + 1
		local nextCount = self.vb.burstCastCount + 1
		local timer = BurstTimers[nextCount] or 10
		if timer then
			timerConflexiveBurstCD:Start(timer, nextCount)
			countdownConflexiveBurst:Start(timer)
		end
	elseif spellId == 210387 then
		self.vb.tormentCastCount = self.vb.tormentCastCount + 1
		local nextCount = self.vb.tormentCastCount + 1
		local timer = TormentTimers[nextCount]
		if timer then
			timerPermaliativeTormentCD:Start(timer, nextCount)
		end
	elseif spellId == 214278 or spellId == 214295 then--Boss: 214278, Echo: 214295
		self.vb.beamCastCount = self.vb.beamCastCount + 1
		local nextCount = self.vb.beamCastCount + 1
		if self.vb.phase == 2 then
			self.vb.totalbeamCasts = self.vb.totalbeamCasts + 1
			if not self:HasMapRestrictions() then
				currentTank, tankUnitID = self:GetCurrentTank()
				if not currentTank then
					DBM:Debug("Tank Detection Failure in HudMapOnDelphuricBeam", 2)
					return
				end
				--Yes this could be in a table and be far prettier, but being ugly like this makes it recoverable by dbms timer recovery feature
				if self.vb.beamCastCount == 1 then
					self.vb.pos1X, self.vb.pos1Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 2 then
					self.vb.pos2X, self.vb.pos2Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 3 then
					self.vb.pos3X, self.vb.pos3Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 4 then
					self.vb.pos4X, self.vb.pos4Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 5 then
					self.vb.pos5X, self.vb.pos5Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 6 then
					self.vb.pos6X, self.vb.pos6Y = UnitPosition(tankUnitID)
				elseif self.vb.beamCastCount == 7 then
					self.vb.pos7X, self.vb.pos7Y = UnitPosition(tankUnitID)
				end
			end
		else
			if nextCount > self.vb.totalbeamCasts then return end
		end
		local timer = BeamTimers[nextCount]
		if timer then
			timerDelphuricBeamCD:Start(timer, nextCount)
			countdownDelphuricBeam:Start(timer)
		end
	elseif spellId == 209615 then
		--timerAblationCD:Start()
	elseif spellId == 210024 and self:AntiSpam(15, 4) then
		self.vb.orbCastCount = self.vb.orbCastCount + 1
		local nextCount = self.vb.orbCastCount + 1
		local timer = OrbTimers[nextCount]
		if timer then
			specWarnEpochericOrb:Schedule(timer-10)
			voiceEpochericOrb:Schedule(timer-10, "161612")
			timerEpochericOrbCD:Start(timer-10, nextCount)
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
		--TODO, phase 3 lines need exact location of the echo ( map coords )
		if self.Options.HudMapOnDelphuricBeam and not self:HasMapRestrictions() then
			self:Unschedule(checkPlayerDot)
			self:Schedule(0.3, checkPlayerDot, self, args.spellName)--Give player just a dot if they don't end up with debuff
			--Always put dots up
			DBMHudMap:RegisterRangeMarkerOnPartyMember(213166, "party", args.destName, 0.35, 5, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(args.destName, nil, nil, nil, nil, nil, 0.8, nil, -13, 8, nil)
			--Now attempt to do lines to best of ability using tanks position as an approximation to boss position
			if self.vb.phase == 2 then--use current tanks current position
				if not currentTank then return end
				if args:IsPlayer() then--Yellow Line
					DBMHudMap:AddEdge(1, 1, 0, 0.5, 4, currentTank, args.destName, nil, nil, nil, nil, 125)
				else--Red Line
					DBMHudMap:AddEdge(1, 0, 0, 0.5, 4, currentTank, args.destName, nil, nil, nil, nil, 125)
				end
			else--Echos, pull saved coords
				--Yes this could be in a table and be far prettier, but being ugly like this makes it recoverable by dbms timer recovery feature
				local EchoX, EchoY
				if self.vb.beamCastCount == 1 then
					EchoX, EchoY = self.vb.pos1X, self.vb.pos1Y
				elseif self.vb.beamCastCount == 2 then
					EchoX, EchoY = self.vb.pos2X, self.vb.pos2Y
				elseif self.vb.beamCastCount == 3 then
					EchoX, EchoY = self.vb.pos3X, self.vb.pos3Y
				elseif self.vb.beamCastCount == 4 then
					EchoX, EchoY = self.vb.pos4X, self.vb.pos4Y
				elseif self.vb.beamCastCount == 5 then
					EchoX, EchoY = self.vb.pos5X, self.vb.pos5Y
				elseif self.vb.beamCastCount == 6 then
					EchoX, EchoY = self.vb.pos6X, self.vb.pos6Y
				elseif self.vb.beamCastCount == 7 then
					EchoX, EchoY = self.vb.pos7X, self.vb.pos7Y
				end
				if not EchoX or not EchoY then return end
				if args:IsPlayer() then--Yellow Line
					DBMHudMap:AddEdge(1, 1, 0, 0.5, 4, nil, args.destName, EchoX, EchoY, nil, nil, 125)
				else--Red Line
					DBMHudMap:AddEdge(1, 0, 0, 0.5, 4, nil, args.destName, EchoX, EchoY, nil, nil, 125)
				end
			end
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
		if args:IsPlayer() then
			specWarnConflexiveBurst:Show()
			voiceConflexiveBurst:Play("targetyou")
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
		warnConflexiveBurst:CombinedShow(0.5, args.destName)
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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 209433 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnSingularityGTFO:Show()
		voiceSpanningSingularity:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 211647 then--Time Stop
		self.vb.phase = self.vb.phase + 1
		--self.vb.firstElementals = false
		self.vb.slowElementalCount = 0
		self.vb.fastElementalCount = 0
		self.vb.ringCastCount = 0
		self.vb.beamCastCount = 0
		self.vb.singularityCount = 0
		self.vb.orbCastCount = 0
		timerArcaneticRing:Stop()
		countdownArcaneticRing:Cancel()
		timerTimeElementalsCD:Stop()
		timerEpochericOrbCD:Stop()
		timerSpanningSingularityCD:Stop()
		timerDelphuricBeamCD:Stop()
		countdownDelphuricBeam:Cancel()
		timerLeaveNightwell:Start()
		timerSpanningSingularityCD:Start(10, 1)--Updated Jan 18 heroic
		if self:IsEasy() then
			timerTimeElementalsCD:Start(15.7, SLOW)--Updated Jan 26
			timerTimeElementalsCD:Start(18, FAST)--Updated Jan 26
			timerEpochericOrbCD:Start(28, 1)--Updated Jan 26
		else
			timerTimeElementalsCD:Start(14.7, SLOW)--Updated Jan 18 heroic
			timerTimeElementalsCD:Start(17, FAST)--Updated Jan 18 (17-18)
			timerEpochericOrbCD:Start(27, 1)--Updated Jan 18 Heroic
			timerArcaneticRing:Start(46, 1)--Verified Jan 18
			countdownArcaneticRing:Start(46)
		end
		if self.vb.phase == 2 then
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
			timerAblatingExplosionCD:Start(22)--Verfied unchanged Dec 13 Heroic
			timerDelphuricBeamCD:Start(72, 1)--Cast SUCCESS
			countdownDelphuricBeam:Start(72)
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
			self.vb.burstCastCount = 0
			timerAblatingExplosionCD:Stop()
			--timerAblativePulseCD:Start(20.5)
			if not self:IsEasy() then
				specWarnEpochericOrb:Schedule(27)--Spawning isn't in combat log in phase 3, only landing, so need to use schedule for warnings
				voiceEpochericOrb:Schedule(27, "161612")
			end
			timerPermaliativeTormentCD:Start(33)--Updated Jan 18 Heroic
			if not self:IsLFR() then
				--Wasn't used in LFR
				--Timer itself may need updating but been so long since seen heroic or mythic of this fight.
				timerConflexiveBurstCD:Start(58, 1)
				countdownConflexiveBurst:Start(58)
			end
		end
		--berserkTimer:Cancel()
		--berserkTimer:Start(258)
	elseif spellId == 209005 then--Summon Time Elemental - Slow
		self.vb.slowElementalCount = self.vb.slowElementalCount + 1
		--if self.vb.firstElementals then
			specWarnTimeElementals:Show(SLOW)
			voiceElemental:Play("bigmob")
		--end
		local timer = self:IsEasy() and easyslowElementalTimers[self.vb.slowElementalCount+1] or slowElementalTimers[self.vb.slowElementalCount+1]
		if timer then
			timerTimeElementalsCD:Start(timer, SLOW)
		end
	elseif spellId == 209007 or spellId == 211616 then--Summon Time Elemental - Fast
		self.vb.fastElementalCount = self.vb.fastElementalCount + 1
		--if self.vb.firstElementals then
			specWarnTimeElementals:Show(FAST)
			voiceElemental:Play("bigmob")
		--end
		local timer = self:IsEasy() and easyfastElementalTimers[self.vb.fastElementalCount+1] or fastElementalTimers[self.vb.fastElementalCount+1]
		if timer then
			timerTimeElementalsCD:Start(timer, FAST)
		end
	elseif spellId == 208887 then--Summon Time Elementals (summons both of them, used at beginning of each phase)
		--self.vb.firstElementals = true
		--specWarnTimeElementals:Show(STATUS_TEXT_BOTH)
		--voiceElemental:Play("bigmob")
		DBM:Debug("Both elementals summoned, this event still exists, probably need custom code for certain difficulties")
	elseif (spellId == 209168 or spellId == 233012 or spellId == 233011) and self:AntiSpam(3, 3) then
		self.vb.singularityCount = self.vb.singularityCount + 1
		specWarnSpanningSingularity:Show()
		voiceSpanningSingularity:Play("watchstep")
		local nextCount = self.vb.singularityCount + 1
		if self.vb.phase == 1 then
			self.vb.totalsingularityCasts = self.vb.totalsingularityCasts + 1
		else
			if nextCount > self.vb.totalsingularityCasts then return end--There won't be any more
		end
		local timer = SingularityTimers[nextCount]
		if timer then
			timerSpanningSingularityCD:Start(timer, nextCount)
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
		local timer = self:IsEasy() and easyRingTimers[nextCount] or RingTimers[nextCount]
		if timer then
			timerArcaneticRing:Start(timer, nextCount)
			countdownArcaneticRing:Start(timer)
		end
	end
end

function mod:OnSync(msg, targetname)
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
		local timer = RingTimers[nextCount]
		if timer then
			timerArcaneticRing:Start(timer, nextCount)
			countdownArcaneticRing:Start(timer)
		end
	end
end
