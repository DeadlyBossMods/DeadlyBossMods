local mod	= DBM:NewMod(1197, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77428, 78623)
mod:SetEncounterID(1705)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)--Unknown total number of icons replication will use.
mod:SetBossHPInfoToHighest()--For mythic chogal
mod:SetHotfixNoticeRev(12073)
mod:SetMinSyncRevision(12073)--Avoid premature combat end on mythic

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156238 156467 157349 163988 164075 156471 164299 164232 164301 163989 164076 164235 163990 164077 164240 164303 158605 164176 164178 164191",
	"SPELL_CAST_SUCCESS 158563",
	"SPELL_AURA_APPLIED 157763 158553 156225 164004 164005 164006 158605 164176 164178 164191 157801",
	"SPELL_AURA_APPLIED_DOSE 158553",
	"SPELL_AURA_REFRESH 157763",
	"SPELL_AURA_REMOVED 158605 164176 164178 164191 157763 156225 164004 164005 164006",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, combine options to reduce GUI mod options in same manor that was done with paragons.
--TODO, get timers for first kick and crush, since my logs are from before the hotfix
--All Phases
mod:AddBoolOption("warnBranded", true, "announce")
local warnBranded								= mod:NewStackAnnounce("OptionVersion2", 156225, 4, nil, nil, false)
local warnBrandedDisplacement					= mod:NewStackAnnounce("OptionVersion2", 164004, 4, nil, nil, false)
local warnBrandedFortification					= mod:NewStackAnnounce("OptionVersion2", 164005, 4, nil, nil, false)
local warnBrandedReplication					= mod:NewStackAnnounce("OptionVersion2", 164006, 4, nil, nil, false)
mod:AddBoolOption("warnResonance", true, "announce")
local warnDestructiveResonance					= mod:NewSpellAnnounce("OptionVersion2", 156467, 3, nil, nil, false)
local warnDestructiveResonanceDisplacement		= mod:NewSpellAnnounce("OptionVersion2", 164075, 4, nil, nil, false)
local warnDestructiveResonanceFortification		= mod:NewSpellAnnounce("OptionVersion2", 164076, 4, nil, nil, false)
local warnDestructiveResonanceReplication		= mod:NewSpellAnnounce("OptionVersion2", 164077, 4, nil, nil, false)
mod:AddBoolOption("warnMarkOfChaos", true, "announce")
local warnMarkOfChaos							= mod:NewTargetAnnounce("OptionVersion2", 158605, 4, nil, nil, false)
local warnMarkOfChaosDisplacement				= mod:NewTargetAnnounce("OptionVersion2", 164176, 4, nil, nil, false)
local warnMarkOfChaosFortification				= mod:NewTargetAnnounce("OptionVersion2", 164178, 4, nil, nil, false)
local warnMarkOfChaosReplication				= mod:NewTargetAnnounce("OptionVersion2", 164191, 4, nil, nil, false)
mod:AddBoolOption("warnForceNova", true, "announce")
local warnForceNova								= mod:NewCountAnnounce("OptionVersion2", 157349, 3, nil, nil, false)
local warnForceNovaDisplacement					= mod:NewCountAnnounce("OptionVersion2", 164232, 3, nil, nil, false)
local warnForceNovaFortification				= mod:NewCountAnnounce("OptionVersion2", 164235, 3, nil, nil, false)
local warnForceNovaReplication					= mod:NewCountAnnounce("OptionVersion2", 164240, 3, nil, nil, false)
mod:AddBoolOption("warnAberration", true, "announce")
local warnSummonArcaneAberration				= mod:NewSpellAnnounce("OptionVersion2", 156471, 3, nil, nil, false)
local warnSummonDisplacingArcaneAberration		= mod:NewSpellAnnounce("OptionVersion2", 164299, 3, nil, nil, false)
local warnSummonFortifiedArcaneAberration		= mod:NewSpellAnnounce("OptionVersion2", 164301, 3, nil, nil, false)
local warnSummonReplicatingArcaneAberration		= mod:NewSpellAnnounce("OptionVersion2", 164303, 3, nil, nil, false)

--Intermission: Dormant Runestones
local warnFixate								= mod:NewTargetAnnounce("OptionVersion2", 157763, 3, nil, not mod:IsTank())
--Intermission: Lineage of Power
local warnKickToTheFace							= mod:NewTargetAnnounce("OptionVersion2", 158563, 3, nil, mod:IsTank())
local warnCrushArmor							= mod:NewStackAnnounce(158553, 2, nil, mod:IsTank())

--All Phases
--Special warnings cannot be combined because it breaks custom sounds, however, they will be grouped up better now at least.
local specWarnDestructiveResonance				= mod:NewSpecialWarningSpell(156467, nil, nil, nil, 2)
local specWarnDestructiveResonanceDisplacement	= mod:NewSpecialWarningSpell(164075, nil, nil, nil, 2)
local specWarnDestructiveResonanceFortification	= mod:NewSpecialWarningSpell(164076, nil, nil, nil, 2)
local specWarnDestructiveResonanceReplication	= mod:NewSpecialWarningSpell(164077, nil, nil, nil, 2)

local specWarnMarkOfChaos						= mod:NewSpecialWarningMoveAway(158605, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosDisplacement			= mod:NewSpecialWarningMoveAway(164176, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosFortification			= mod:NewSpecialWarningMoveAway(164178, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosReplication			= mod:NewSpecialWarningMoveAway(164191, nil, nil, nil, 3, nil, true)

local specWarnMarkOfChaosFortificationNear		= mod:NewSpecialWarningClose(164178, nil, nil, nil, 3, nil, true)
local yellMarkOfChaosFortification				= mod:NewYell(164178)
local yellMarkOfChaosReplication				= mod:NewYell(164191)

local specWarnMarkOfChaosOther					= mod:NewSpecialWarningTaunt(158605, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosDisplacementOther		= mod:NewSpecialWarningTaunt(164176, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosFortificationOther		= mod:NewSpecialWarningTaunt(164178, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosReplicationOther		= mod:NewSpecialWarningTaunt(164191, nil, nil, nil, nil, nil, true)

local specWarnBranded							= mod:NewSpecialWarningStack(156225, nil, 5)--Debuff Name "Branded" for Arcane Wrath
local specWarnBrandedDisplacement				= mod:NewSpecialWarningStack(164004, nil, 5)
local specWarnBrandedFortification				= mod:NewSpecialWarningStack(164005, nil, 8)
local specWarnBrandedReplication				= mod:NewSpecialWarningStack(164006, nil, 5)
local yellBranded								= mod:NewYell(156225, L.BrandedYell)

local specWarnBrandedDisplacementNear			= mod:NewSpecialWarningClose(164004)--Displacement version of branded makes player unable to move from raid, raid moves from player

local specWarnAberration						= mod:NewSpecialWarningSwitch("ej9945", not mod:IsHealer())--can use short name for all of them

--Intermission: Dormant Runestones
local specWarnFixate							= mod:NewSpecialWarningMoveAway(157763, nil, nil, nil, nil, nil, true)
local yellFixate								= mod:NewYell(157763)
local specWarnSlow								= mod:NewSpecialWarningDispel(157801, mod:IsHealer())--Seems CD long enough not too spammy, requested feature.
local specWarnTransitionEnd						= mod:NewSpecialWarningEnd(157278)
--Intermission: Lineage of Power
local specWarnKickToTheFace						= mod:NewSpecialWarningSpell(158563, mod:IsTank())
local specWarnKickToTheFaceOther				= mod:NewSpecialWarningTaunt(158563)

--All Phases (No need to use different timers for empowered abilities. Short names better for timers.)
local timerArcaneWrathCD						= mod:NewCDTimer(50, 156238, nil, not mod:IsTank())--Pretty much a next timer, HOWEVER can get delayed by other abilities so only reason it's CD timer anyways
local timerDestructiveResonanceCD				= mod:NewCDTimer(15, 156467, nil, not mod:IsMelee())--16-30sec variation noted. I don't like it
local timerMarkOfChaos							= mod:NewTargetTimer(8, 158605, nil, mod:IsTank())
local timerMarkOfChaosCD						= mod:NewCDTimer(50, 158605, nil, mod:IsTank())
local timerForceNovaCD							= mod:NewCDCountTimer(45, 157349)--45-52
local timerSummonArcaneAberrationCD				= mod:NewCDTimer(45, 156471, nil, not mod:IsHealer())--45-52 Variation Noted
local timerTransition							= mod:NewPhaseTimer(74)
--Intermission: Lineage of Power
local timerCrushArmorCD							= mod:NewNextTimer(6, 158553, nil, mod:IsTank())
local timerKickToFaceCD							= mod:NewNextTimer(20, 158563, nil, mod:IsTank())

local countdownArcaneWrath						= mod:NewCountdown(50, 156238, not mod:IsTank())--Probably will add for whatever proves most dangerous on mythic
local countdownMarkofChaos						= mod:NewCountdown("Alt50", 158605, mod:IsTank())
local countdownForceNova						= mod:NewCountdown("AltTwo45", 157349)
local countdownTransition						= mod:NewCountdown(74, 157278)

local voiceDestructiveResonance 				= mod:NewVoice(156467, not mod:IsMelee())
local voiceForceNova	 						= mod:NewVoice(157349)
local voiceMarkOfChaos							= mod:NewVoice(158605)
local voicePhaseChange							= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT) --this string should write into language file
local voiceFixate								= mod:NewVoice(157763)
local voiceArcaneAberration						= mod:NewVoice(156471, mod:IsDps())

mod:AddRangeFrameOption("35/13/5")
mod:AddSetIconOption("SetIconOnBrandedDebuff", 156225, false)

mod.vb.markActive = false
mod.vb.playerHasMark = false
mod.vb.jumpDistance = 13
mod.vb.lastMarkedTank = nil
mod.vb.isTransition = false
mod.vb.phase = 1

local jumpDistance1 = {
	[1] = 200, [2] = 100, [3] = 50, [4] = 25, [5] = 12.5, [6] = 7,--Or 5
}
local jumpDistance2 = {
	[1] = 200, [2] = 150, [3] = 113, [4] = 85, [5] = 63, [6] = 48, [7] =36, [8] = 27, [9] = 21, [10] = 16, [11] = 12, [12] = 9, [13] = 7,--or 5
}
local GetSpellInfo, UnitDebuff, UnitDetailedThreatSituation = GetSpellInfo, UnitDebuff, UnitDetailedThreatSituation
local chaosDebuff1 = GetSpellInfo(158605)
local chaosDebuff2 = GetSpellInfo(164176)
local chaosDebuff3 = GetSpellInfo(164178)
local chaosDebuff4 = GetSpellInfo(164191)
local brandedDebuff1 = GetSpellInfo(156225)
local brandedDebuff2 = GetSpellInfo(164004)
local brandedDebuff3 = GetSpellInfo(164005)
local brandedDebuff4 = GetSpellInfo(164006)
local fixateDebuff = GetSpellInfo(157763)
local playerName = UnitName("player")
local debuffFilterMark, debuffFilterBranded, debuffFilterCombined, debuffFilterFixate
do
	debuffFilterMark = function(uId)
		if UnitDebuff(uId, chaosDebuff1) or UnitDebuff(uId, chaosDebuff2) or UnitDebuff(uId, chaosDebuff3) or UnitDebuff(uId, chaosDebuff4) then
			return true
		end
	end
	debuffFilterBranded = function(uId)
		if UnitDebuff(uId, brandedDebuff1) or UnitDebuff(uId, brandedDebuff2) or UnitDebuff(uId, brandedDebuff3) or UnitDebuff(uId, brandedDebuff4) then
			return true
		end
	end
	debuffFilterCombined = function(uId)
		if UnitDebuff(uId, chaosDebuff1) or UnitDebuff(uId, chaosDebuff2) or UnitDebuff(uId, chaosDebuff3) or UnitDebuff(uId, chaosDebuff4) or UnitDebuff(uId, brandedDebuff1) or UnitDebuff(uId, brandedDebuff2) or UnitDebuff(uId, brandedDebuff3) or UnitDebuff(uId, brandedDebuff4) then
			return true
		end
	end
	debuffFilterFixate = function(uId)
		if UnitDebuff(uId, fixateDebuff) then
			return true
		end
	end
end

local function updateRangeFrame(self, markPreCast)
	if not self.Options.RangeFrame then return end
	if not self:IsTank() and self.vb.brandedActive > 0 then--Active branded out there, not a tank. Branded is always prioritized over mark for non tanks since 90% of time tanks handle this on their own, while rest of raid must ALWAYS handle branded
		local distance = self.vb.jumpDistance
		if mod.vb.playerHasBranded then--Player has Branded debuff
			DBM.RangeCheck:Show(distance, nil)--Show everyone
		else--No branded debuff on player, so show a filtered range finder
			if self.vb.markActive and self.vb.lastMarkedTank and self:CheckNearby(35, self.vb.lastMarkedTank) then--There is an active tank with debuff and they are too close
				DBM.RangeCheck:Show(35, debuffFilterCombined)--Show marked instead of branded if the marked tank is NOT far enough out
			else--no branded tank in range, So show ONLY branded dots
				DBM.RangeCheck:Show(distance, debuffFilterBranded)
			end
		end
	else--no branded, or player is a tank
		if markPreCast or self.vb.markActive then--Mark of Chaos is active, or is being cast
			if self.vb.playerHasMark then--Player has mark of chaos debuff, or is current highest threat during mark of chaos cast
				DBM.RangeCheck:Show(35, nil)
			else--Not boss target during cast, not debuffed, use filtered range frame to show only players affected by mark of chaos.
				DBM.RangeCheck:Show(35, debuffFilterMark)
			end
		elseif self.vb.isTransition then
			if UnitDebuff("player", fixateDebuff) then
				DBM.RangeCheck:Show(5, nil)
			else
				DBM.RangeCheck:Show(5, debuffFilterFixate)
			end
		else--We got this far, no mark of chaos, no branded, fixate, no nothing, finally hide the range frame!
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.markActive = false
	self.vb.playerHasMark = false
	self.vb.playerHasBranded = false
	self.vb.isTransition = false
	self.vb.lastMarkedTank = nil
	self.vb.brandedActive = 0
	self.vb.forceCount = 0
	self.vb.jumpDistance = 13
	self.vb.phase = 1
	timerArcaneWrathCD:Start(6-delay)
	countdownArcaneWrath:Start(6-delay)
	timerDestructiveResonanceCD:Start(15-delay)
	timerSummonArcaneAberrationCD:Start(25-delay)
	timerMarkOfChaosCD:Start(33.5-delay)
	countdownMarkofChaos:Start(33.5-delay)
	timerForceNovaCD:Start(-delay, 1)
	countdownForceNova:Start(-delay)
	voiceForceNova:Schedule(38.5-delay, "157349")
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(156238, 163988, 163989, 163990) then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	-----
	elseif spellId == 156467 then
		if self.Options.warnResonance then
			warnDestructiveResonance:Show()
		end
		specWarnDestructiveResonance:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164075 then
		if self.Options.warnResonance then
			warnDestructiveResonanceDisplacement:Show()
		end
		specWarnDestructiveResonanceDisplacement:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164076 then
		if self.Options.warnResonance then
			warnDestructiveResonanceFortification:Show()
		end
		specWarnDestructiveResonanceFortification:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164077 then
		if self.Options.warnResonance then
			warnDestructiveResonanceReplication:Show()
		end
		specWarnDestructiveResonanceReplication:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("watchstep")
	-----
	elseif spellId == 157349 then
		self.vb.forceCount = self.vb.forceCount + 1
		if self.Options.warnForceNova then
			warnForceNova:Show(self.vb.forceCount)
		end
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
	elseif spellId == 164232 then
		self.vb.forceCount = self.vb.forceCount + 1
		if self.Options.warnForceNova then
			warnForceNovaDisplacement:Show(self.vb.forceCount)
		end
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
	elseif spellId == 164235 then
		self.vb.forceCount = self.vb.forceCount + 1
		if self.Options.warnForceNova then
			warnForceNovaFortification:Show(self.vb.forceCount)
		end
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
	elseif spellId == 164240 then
		self.vb.forceCount = self.vb.forceCount + 1
		if self.Options.warnForceNova then
			warnForceNovaReplication:Show(self.vb.forceCount)
		end
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		voiceForceNova:Schedule(38.5, "157349")
		if not self:IsMelee() then
			voiceForceNova:Play("range5") --keep range 5 years
		end
	-----
	elseif spellId == 156471 then
		if self.Options.warnAberration then
			warnSummonArcaneAberration:Show()
		end
		specWarnAberration:Show()
		timerSummonArcaneAberrationCD:Start()
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164299 then
		if self.Options.warnAberration then
			warnSummonDisplacingArcaneAberration:Show()
		end
		specWarnAberration:Show()
		timerSummonArcaneAberrationCD:Start()
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164301 then
		if self.Options.warnAberration then
			warnSummonFortifiedArcaneAberration:Show()
		end
		specWarnAberration:Show()
		timerSummonArcaneAberrationCD:Start()
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164303 then
		if self.Options.warnAberration then
			warnSummonReplicatingArcaneAberration:Show()
		end
		specWarnAberration:Show()
		timerSummonArcaneAberrationCD:Start()
		voiceArcaneAberration:Play("killmob")
	elseif args:IsSpellID(158605, 164176, 164178, 164191) then
		local targetName, uId = self:GetBossTarget(77428)
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		timerMarkOfChaosCD:Start()
		countdownMarkofChaos:Start()
		if spellId == 158605 then
			if self.Options.warnMarkOfChaos then
				warnMarkOfChaos:Show(targetName)
			end
			timerMarkOfChaos:Start(targetName)
			if tanking or (status == 3) then
				specWarnMarkOfChaos:Show()
				voiceMarkOfChaos:Play("runout")
			else
				specWarnMarkOfChaosOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164176 then
			if self.Options.warnMarkOfChaos then
				warnMarkOfChaosDisplacement:Show(targetName)
			end
			if tanking or (status == 3) then
				--No action, displacement you don't run out until fast FINISHES since cast finish ports you into raid.
			else
				specWarnMarkOfChaosDisplacementOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164178 then
			if self.Options.warnMarkOfChaos then
				warnMarkOfChaosFortification:Show(targetName)
			end
			if tanking or (status == 3) then
				if not (self:IsMythic() and self.vb.phase == 2) then--Cannot run out on mythic during displacement/fort. Can during fort/replication though.
					specWarnMarkOfChaosFortification:Show()
					voiceMarkOfChaos:Play("runout")--Tank can still run out during cast
				end
			else
				specWarnMarkOfChaosFortificationOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164191 then
			if self.Options.warnMarkOfChaos then
				warnMarkOfChaosReplication:Show(targetName)
			end
			if tanking or (status == 3) then
				specWarnMarkOfChaosReplication:Show()
				yellMarkOfChaosReplication:Yell()
				voiceMarkOfChaos:Play("runout")
			else
				specWarnMarkOfChaosReplicationOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
				voiceMarkOfChaos:Schedule(1.5, "watchstep")
			end
		end
		if tanking or (status == 3) then
			self.vb.playerHasMark = true
		else
			self.vb.playerHasMark = false
		end
		updateRangeFrame(self, true)
		self:Schedule(4, updateRangeFrame, self)--Cast + 1, since sometimes tank resists, so we'll want to hide frame after 4 seconds if no debuff has gone out in 2.
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158563 then
		warnKickToTheFace:Show(args.destName)
		timerKickToFaceCD:Start()
		if args:IsPlayer() then
			specWarnKickToTheFace:Show()
		else
			specWarnKickToTheFaceOther:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 157763 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			if not self:IsLFR() then
				yellFixate:Yell()
				voiceFixate:Play("runout")
				voiceFixate:Schedule(1.5,"targetyou")
			end
			updateRangeFrame(self)
		end
	elseif args:IsSpellID(156225, 164004, 164005, 164006) then
		self.vb.brandedActive = self.vb.brandedActive + 1
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, currentStack = UnitDebuff(uId, GetSpellInfo(spellId))
		local fortified = (self:IsMythic() and self.vb.phase == 3) or spellId == 164005--Phase 3 uses replication ID, so need hack for mythic fortified/replication phase.
		if not currentStack then
			print("currentStack is nil, report to dbm authors. Branded warning disabled.")--Should never happen but added just in case.
			return
		end
		if (not fortified and currentStack > 2) or currentStack > 5 then--yells and general announces for target 2 stack before move.
			if fortified then
				self.vb.jumpDistance = jumpDistance2[currentStack] or 5
			else
				self.vb.jumpDistance = jumpDistance1[currentStack] or 5
			end
			if args:IsPlayer() then
				self.vb.playerHasBranded = true
				if not self:IsLFR() then
					yellBranded:Yell(currentStack.."-"..self.vb.jumpDistance, playerName)
				end
			end
			if spellId == 156225 then
				if self.Options.warnBranded then
					warnBranded:Show(args.destName, currentStack)
				end
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBranded:Show(currentStack)
				end
			elseif spellId == 164004 then
				if self.Options.warnBranded then
					warnBrandedDisplacement:CombinedShow(0.5, args.destName, currentStack)
				end
				if currentStack > 4  then--Special warning only for person that needs to get out
					if args:IsPlayer() then
						specWarnBrandedDisplacement:Show(currentStack)
					elseif self:CheckNearby(self.vb.jumpDistance, args.destName) then
						specWarnBrandedDisplacementNear:Show(args.destName)
					end
				end
			elseif spellId == 164005 then
				if self.Options.warnBranded then
					warnBrandedFortification:CombinedShow(0.5, args.destName, currentStack)
				end
				if args:IsPlayer() and currentStack > 6  then--Special warning only for person that needs to get out
					specWarnBrandedFortification:Show(currentStack)
				end
			elseif spellId == 164006 then
				if self.Options.warnBranded then
					warnBrandedReplication:Show(args.destName, currentStack)--Changed from combined show cause it can only be max targets, and important to have stack counts.
				end
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBrandedReplication:Show(currentStack)
				end
			end
			if self.Options.SetIconOnBrandedDebuff then
				if spellId == 164006 or (self:IsMythic() and spellId == 164004) then--On mythic, displacement/replication in phase 1. Using dipslacemnet spellid, on two targets.
					self:SetSortedIcon(1, args.destName, 1, 2)
				else
					self:SetIcon(args.destName, 1)
				end
			end
			updateRangeFrame(self)--Update it here cause we don't need it before stacks get to relevant levels.
		end
	elseif spellId == 158553 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		timerCrushArmorCD:Start()
	elseif args:IsSpellID(158605, 164176, 164178, 164191) then
		--Update frame again in case he swaped targets during cast (happens)
		self.vb.markActive = true
		self.vb.lastMarkedTank = args.destName
		if args:IsPlayer() then
			self.vb.playerHasMark = true
			if spellId == 164176 then 
				specWarnMarkOfChaosDisplacement:Show()
				voiceMarkOfChaos:Play("runout")
			elseif spellId == 164178 then
				if self:IsMythic() and self.vb.phase == 2 then
					specWarnMarkOfChaosFortification:Show()
				end
				yellMarkOfChaosFortification:Yell()--Always yell when root occurs in all modes though, because that's when raid really needs to know WHERE you are.
			end
		else
			self.vb.playerHasMark = false
			if spellId == 164178 and self:CheckNearby(35, args.destName) then
				specWarnMarkOfChaosFortificationNear:Show(args.destName)
				voiceMarkOfChaos:Play("justrun")
			end
		end
		self:Unschedule(updateRangeFrame)
		updateRangeFrame(self)
	elseif spellId == 157801 then
		specWarnSlow:Show(args.destName)
	end
end

function mod:SPELL_AURA_REFRESH(args)
	local spellId = args.spellId
	if spellId == 157763 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			if not self:IsLFR() then
				yellFixate:Yell()
				voiceFixate:Play("runout")
				voiceFixate:Schedule(1.5,"targetyou")
			end
			updateRangeFrame(self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(158605, 164176, 164178, 164191) then
		self.vb.markActive = false
		self.vb.lastMarkedTank = nil
		if args:IsPlayer() then
			self.vb.playerHasMark = false
		end
		updateRangeFrame(self)
	elseif spellId == 157763 and args:IsPlayer() and self.Options.RangeFrame then
		updateRangeFrame(self)
	elseif args:IsSpellID(156225, 164004, 164005, 164006) then
		self.vb.brandedActive = self.vb.brandedActive - 1
		if args:IsPlayer() then
			self.vb.playerHasBranded = false
		end
		if self.Options.SetIconOnBrandedDebuff then
			self:SetIcon(args.destName, 0)
		end
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 78549 then--Reaver
		timerCrushArmorCD:Cancel()
		timerKickToFaceCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164751 or spellId == 164810 then--Teleport to Fortification/Teleport to Replication. For these two, cancel all CD timers, these transitions are both over a minute long.
		self.vb.isTransition = true
		timerArcaneWrathCD:Cancel()
		countdownArcaneWrath:Cancel()
		timerDestructiveResonanceCD:Cancel()
		timerSummonArcaneAberrationCD:Cancel()
		timerMarkOfChaosCD:Cancel()
		countdownMarkofChaos:Cancel()
		timerForceNovaCD:Cancel()
		countdownForceNova:Cancel()
		voiceForceNova:Cancel()
		timerTransition:Start()
		countdownTransition:Start()
		voicePhaseChange:Play("ptran")
		updateRangeFrame(self)
		if spellId == 164810 then
			timerCrushArmorCD:Start(23)
			timerKickToFaceCD:Start(42)
		end
	elseif spellId == 158012 or spellId == 157964 then--Power of Foritification/Replication
		self.vb.forceCount = 0
		self.vb.isTransition = false
		specWarnTransitionEnd:Show()
		timerArcaneWrathCD:Start(8.5)
		countdownArcaneWrath:Start(8.5)
		timerDestructiveResonanceCD:Start(18)
		timerSummonArcaneAberrationCD:Start(28)
		timerMarkOfChaosCD:Start(36.5)
		countdownMarkofChaos:Start(36.5)
		timerForceNovaCD:Start(48.5, 1)
		voiceForceNova:Schedule(42, "157349")
		countdownForceNova:Start(48.5)
		if spellId == 158012 then
			if self:IsMythic() then
				self.vb.phase = 2
				voicePhaseChange:Play("ptwo")	
			else
				self.vb.phase = 3
				voicePhaseChange:Play("pthree")
			end
		end
		if spellId == 157964 then
			if self:IsMythic() then
				self.vb.phase = 3
				voicePhaseChange:Play("pthree")	
			else
				self.vb.phase = 4
				voicePhaseChange:Play("pfour")
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 164336 then--Teleport to Displacement (first phase change that has no transition)
		voicePhaseChange:Play("ptwo")
		self.vb.phase = 2
	end
end
