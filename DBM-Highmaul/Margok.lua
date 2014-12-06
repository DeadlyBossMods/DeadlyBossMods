local mod	= DBM:NewMod(1197, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(71859)
mod:SetEncounterID(1705)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)--Unknown total number of icons replication will use.

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156238 156467 157349 163988 164075 156471 164299 164232 164301 163989 164076 164235 163990 164077 164240 164303 158605 164176 164178 164191",
	"SPELL_CAST_SUCCESS 158563",
	"SPELL_AURA_APPLIED 157763 158553 156225 164004 164005 164006 158605 164176 164178 164191",
	"SPELL_AURA_APPLIED_DOSE 158553",
	"SPELL_AURA_REMOVED 158605 164176 164178 164191 157763 156225 164004 164005 164006",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, probably add http://beta.wowhead.com/spell=158547 for second intermission once find the pre cast ID
--TODO, combine options to reduce GUI mod options in same manor that was done with paragons.
--Phase 1: Might of the Crown
local warnBranded								= mod:NewTargetAnnounce(156225, 4)
local warnDestructiveResonance					= mod:NewSpellAnnounce(156467, 3)--Find out if target scanning works
local warnMarkOfChaos							= mod:NewTargetAnnounce(158605, 4)
local warnForceNova								= mod:NewSpellAnnounce(157349, 3)
local warnSummonArcaneAberration				= mod:NewSpellAnnounce(156471, 3)
--Phase 2: Rune of Displacement
local warnBrandedDisplacement					= mod:NewTargetAnnounce(164004, 4)
local warnDestructiveResonanceDisplacement		= mod:NewSpellAnnounce(164075, 4)--Find out if target scanning works
local warnMarkOfChaosDisplacement				= mod:NewTargetAnnounce(164176, 4)
local warnForceNovaDisplacement					= mod:NewSpellAnnounce(164232, 3)
local warnSummonDisplacingArcaneAberration		= mod:NewSpellAnnounce(164299, 3)
--Intermission: Dormant Runestones
local warnFixate								= mod:NewTargetAnnounce("OptionVersion2", 157763, 3, nil, not mod:IsTank())
--Phase 3: Rune of Fortification
local warnBrandedFortification					= mod:NewTargetAnnounce(164005, 4)
local warnDestructiveResonanceFortification		= mod:NewSpellAnnounce(164076, 4)--Find out if target scanning works
local warnMarkOfChaosFortification				= mod:NewTargetAnnounce(164178, 4)
local warnForceNovaFortification				= mod:NewSpellAnnounce(164235, 3)
local warnSummonFortifiedArcaneAberration		= mod:NewSpellAnnounce(164301, 3)
--Intermission: Lineage of Power
local warnKickToTheFace							= mod:NewTargetAnnounce("OptionVersion2", 158563, 3, nil, mod:IsTank())
local warnCrushArmor							= mod:NewStackAnnounce(158553, 2, nil, mod:IsTank())
--Phase 4: Rune of Replication
local warnBrandedReplication					= mod:NewTargetAnnounce(164006, 4)
local warnDestructiveResonanceReplication		= mod:NewSpellAnnounce(164077, 4)--Find out if target scanning works
local warnMarkOfChaosReplication				= mod:NewTargetAnnounce(164191, 4)
local warnForceNovaReplication					= mod:NewSpellAnnounce(164240, 3)
local warnSummonReplicatingArcaneAberration		= mod:NewSpellAnnounce(164303, 3)

--Phase 1: Might of the Crown
local specWarnDestructiveResonance				= mod:NewSpecialWarningSpell(156467, nil, nil, nil, 2)--If target scanning works make this personal.
local specWarnMarkOfChaos						= mod:NewSpecialWarningMoveAway(158605, nil, nil, nil, 3)
local specWarnMarkOfChaosOther					= mod:NewSpecialWarningTaunt(158605)
local specWarnBranded							= mod:NewSpecialWarningStack(156225, nil, 5)--Debuff Name "Branded"
local yellBranded								= mod:NewYell(156225, L.BrandedYell)--Always use the short yell, to reduce clutter. Maybe only need to yell on fortification though? (the one player can't move for)
--Phase 2: Rune of Displacement
local specWarnDestructiveResonanceDisplacement	= mod:NewSpecialWarningSpell(164075, nil, nil, nil, 2)--If target scanning works make this personal.
local specWarnMarkOfChaosDisplacement			= mod:NewSpecialWarningMoveAway(164176, nil, nil, nil, 3)
local specWarnMarkOfChaosDisplacementOther		= mod:NewSpecialWarningTaunt(164176)
local specWarnBrandedDisplacement				= mod:NewSpecialWarningStack(164004, nil, 5)
local specWarnBrandedDisplacementNear			= mod:NewSpecialWarningClose(164004)--Displacement version of branded makes player unable to move from raid, raid moves from player
--Intermission: Dormant Runestones
local specWarnFixate							= mod:NewSpecialWarningYou(157763)--Change to run warning?
local specWarnTransitionEnd						= mod:NewSpecialWarningEnd(157278)
--Phase 3: Rune of Fortification
local specWarnDestructiveResonanceFortification	= mod:NewSpecialWarningSpell(164076, nil, nil, nil, 2)--If target scanning works make this personal.
local specWarnMarkOfChaosFortification			= mod:NewSpecialWarningYou(164178, nil, nil, nil, 3)--Debuffed player can not move for this one
local yellMarkOfChaosFortification				= mod:NewYell(164178)--So give yell
local specWarnMarkOfChaosFortificationNear		= mod:NewSpecialWarningClose(164178, nil, nil, nil, 3)--And super important "near" warning.
local specWarnMarkOfChaosFortificationOther		= mod:NewSpecialWarningTaunt(164178)
local specWarnBrandedFortification				= mod:NewSpecialWarningStack(164005, nil, 8)
--Intermission: Lineage of Power
local specWarnKickToTheFace						= mod:NewSpecialWarningSpell(158563, mod:IsTank())
local specWarnKickToTheFaceOther				= mod:NewSpecialWarningTaunt(158563)
--Phase 4: Rune of Replication
local specWarnDestructiveResonanceReplication	= mod:NewSpecialWarningSpell(164077, nil, nil, nil, 2)--If target scanning works make this personal.
local specWarnMarkOfChaosReplication			= mod:NewSpecialWarningYou(164191, nil, nil, nil, 3)--Debuffed player can not move for this one
local yellMarkOfChaosReplication				= mod:NewYell(164191)--Give a yell to this one too since balls form at that location of player
local specWarnMarkOfChaosReplicationOther		= mod:NewSpecialWarningTaunt(164191)
local specWarnBrandedReplication				= mod:NewSpecialWarningStack(164006, nil, 5)

--All Phases (No need to use different timers for empowered abilities. Short names better for timers.)
local timerArcaneWrathCD						= mod:NewCDTimer(50, 156238, nil, not mod:IsTank())--Pretty much a next timer, HOWEVER can get delayed by other abilities so only reason it's CD timer anyways
local timerDestructiveResonanceCD				= mod:NewCDTimer(15, 156467, nil, not mod:IsMelee())--16-30sec variation noted. I don't like it
local timerMarkOfChaos							= mod:NewTargetTimer(8, 158605, nil, mod:IsTank())
local timerMarkOfChaosCD						= mod:NewCDTimer(50, 158605, nil, mod:IsTank())
local timerForceNovaCD							= mod:NewCDTimer(45, 157349)--45-52
local timerSummonArcaneAberrationCD				= mod:NewCDTimer(45, 156471, nil, not mod:IsHealer())--45-52 Variation Noted
local timerTransition							= mod:NewCastTimer(76.5, 157278)

local countdownArcaneWrath						= mod:NewCountdown(50, 156238, not mod:IsTank())--Probably will add for whatever proves most dangerous on mythic
local countdownMarkofChaos						= mod:NewCountdown("Alt50", 158605, mod:IsTank())

mod:AddRangeFrameOption("35/5")
mod:AddSetIconOption("SetIconOnBrandedDebuff", 156225, false)

local GetSpellInfo = GetSpellInfo
local chaosDebuff1 = GetSpellInfo(158605)
local chaosDebuff2 = GetSpellInfo(164176)
local chaosDebuff3 = GetSpellInfo(164178)
local chaosDebuff4 = GetSpellInfo(164191)
local UnitDebuff = UnitDebuff
local playerName = UnitName("player")
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, chaosDebuff1) or UnitDebuff(uId, chaosDebuff2) or UnitDebuff(uId, chaosDebuff3) or UnitDebuff(uId, chaosDebuff4) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)
	timerArcaneWrathCD:Start(6-delay)
	countdownArcaneWrath:Start(6-delay)
	timerDestructiveResonanceCD:Start(15-delay)
	timerSummonArcaneAberrationCD:Start(25-delay)
	timerMarkOfChaosCD:Start(33.5-delay)
	countdownMarkofChaos:Start(33.5-delay)
	timerForceNovaCD:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156238 then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	elseif spellId == 163988 then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	elseif spellId == 163989 then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	elseif spellId == 163990 then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	-----
	elseif spellId == 156467 then
		warnDestructiveResonance:Show()
		specWarnDestructiveResonance:Show()
		timerDestructiveResonanceCD:Start()
	elseif spellId == 164075 then
		warnDestructiveResonanceDisplacement:Show()
		specWarnDestructiveResonanceDisplacement:Show()
		timerDestructiveResonanceCD:Start()
	elseif spellId == 164076 then
		warnDestructiveResonanceFortification:Show()
		specWarnDestructiveResonanceFortification:Show()
		timerDestructiveResonanceCD:Start()
	elseif spellId == 164077 then
		warnDestructiveResonanceReplication:Show()
		specWarnDestructiveResonanceReplication:Show()
		timerDestructiveResonanceCD:Start()
	-----
	elseif spellId == 157349 then
		warnForceNova:Show()
		timerForceNovaCD:Start()
	elseif spellId == 164232 then
		warnForceNovaDisplacement:Show()
		timerForceNovaCD:Start()
	elseif spellId == 164235 then
		warnForceNovaFortification:Show()
		timerForceNovaCD:Start()
	elseif spellId == 164240 then
		warnForceNovaReplication:Show()
		timerForceNovaCD:Start()
	-----
	elseif spellId == 156471 then
		warnSummonArcaneAberration:Show()
		timerSummonArcaneAberrationCD:Start()
	elseif spellId == 164299 then
		warnSummonDisplacingArcaneAberration:Show()
		timerSummonArcaneAberrationCD:Start()
	elseif spellId == 164301 then
		warnSummonFortifiedArcaneAberration:Show()
		timerSummonArcaneAberrationCD:Start()
	elseif spellId == 164303 then
		warnSummonReplicatingArcaneAberration:Show()
		timerSummonArcaneAberrationCD:Start()
	elseif args:IsSpellID(158605, 164176, 164178, 164191) then
		local targetName = UnitName("boss1target")
		timerMarkOfChaosCD:Start()
		countdownMarkofChaos:Start()
		if spellId == 158605 then
			warnMarkOfChaos:Show(targetName)
			timerMarkOfChaos:Start(targetName)
			if UnitIsUnit("boss1target", "player") then
				specWarnMarkOfChaos:Show()
			else
				specWarnMarkOfChaosOther:Show(targetName)
			end
		elseif spellId == 164176 then
			warnMarkOfChaosDisplacement:Show(targetName)
			if UnitIsUnit("boss1target", "player") then
				specWarnMarkOfChaosDisplacement:Show()
			else
				specWarnMarkOfChaosDisplacementOther:Show(targetName)
			end
		elseif spellId == 164178 then
			warnMarkOfChaosFortification:Show(targetName)
			if UnitIsUnit("boss1target", "player") then
				specWarnMarkOfChaosFortification:Show()
				yellMarkOfChaosFortification:Yell()
			else
				specWarnMarkOfChaosFortificationOther:Show()
				if self:CheckNearby(35, targetName) then
					specWarnMarkOfChaosFortificationNear:Show(targetName)
				end
			end
		elseif spellId == 164191 then
			warnMarkOfChaosReplication:Show(targetName)
			if UnitIsUnit("boss1target", "player") then
				specWarnMarkOfChaosReplication:Show()
				yellMarkOfChaosReplication:Yell()
			else
				specWarnMarkOfChaosReplicationOther:Show(targetName)
			end
		end
		if self.Options.RangeFrame then
			if self:IsTanking("player", "boss1") then--You have threat, show everyone (debuff check not work, when using SPELL_CAST_START for early warning)
				DBM.RangeCheck:Show(35, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(35, debuffFilter)
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158563 then
		warnKickToTheFace:Show(args.destName)
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
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif args:IsSpellID(156225, 164004, 164005, 164006) then
		local uId = DBM:GetRaidUnitId(args.destName)
		local currentStack = select(15, UnitDebuff(uId, GetSpellInfo(spellId)))
		if not currentStack then
			print("Branded/Arcane Wrath stack count drycode failed, warnings aren't going to work")
			return
		end
		if (spellId == 164005 and currentStack > 6) or currentStack > 3 then--yells and general announces for target 1 stack before move.
			if not self:IsLFR() and args:IsPlayer() then
				yellBranded:Yell(currentStack, playerName)
			end
			if spellId == 156225 then
				warnBranded:Show(args.destName)
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBranded:Show(currentStack)
				end
			elseif spellId == 164004 then
				warnBrandedDisplacement:Show(args.destName)
				if currentStack > 4  then--Special warning only for person that needs to get out
					if args:IsPlayer() then
						specWarnBrandedDisplacement:Show(currentStack)
					elseif self:CheckNearby(13, args.destName) then
						specWarnBrandedDisplacementNear:Show(args.destName)
					end
				end
			elseif spellId == 164005 then
				warnBrandedFortification:Show(args.destName)
				if args:IsPlayer() and currentStack > 7  then--Special warning only for person that needs to get out
					specWarnBrandedFortification:Show(currentStack)
				end
			elseif spellId == 164006 then
				warnBrandedReplication:CombinedShow(0.5, args.destName)
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBrandedReplication:Show(currentStack)
				end
			end
			if self.Options.SetIconOnBrandedDebuff then
				self:SetSortedIcon(0.5, args.destName, 1)
			end
		end
	elseif spellId == 158553 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
	elseif args:IsSpellID(158605, 164176, 164178, 164191) and self.Options.RangeFrame then
		--Update frame again in case he swaped targets during cast (happens)
		if UnitDebuff("player", GetSpellInfo(spellId)) then
			DBM.RangeCheck:Show(35, nil)
		else--You do not have debuff, only show players who do
			DBM.RangeCheck:Show(35, debuffFilter)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(158605, 164176, 164178, 164191) and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 157763 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif args:IsSpellID(156225, 164004, 164005, 164006) and self.Options.SetIconOnBrandedDebuff then
		self:SetIcon(args.destName, 0)--TODO, find out number of targets and add
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164751 or spellId == 164810 then--Teleport to Fortification/Teleport to Replication. For these two, cancel all CD timers, these transitions are both over a minute long.
		timerArcaneWrathCD:Cancel()
		countdownArcaneWrath:Cancel()
		timerDestructiveResonanceCD:Cancel()
		timerSummonArcaneAberrationCD:Cancel()
		timerMarkOfChaosCD:Cancel()
		countdownMarkofChaos:Cancel()
		timerForceNovaCD:Cancel()
		timerTransition:Start()
	elseif spellId == 158012 or spellId == 157964 then--Power of Foritification/Replication
		specWarnTransitionEnd:Show()
		timerArcaneWrathCD:Start(8.5)
		countdownArcaneWrath:Start(8.5)
		timerDestructiveResonanceCD:Start(18)
		timerSummonArcaneAberrationCD:Start(28)
		timerMarkOfChaosCD:Start(36.5)
		countdownMarkofChaos:Start(36.5)
		timerForceNovaCD:Start(48.5)	
	end
end
