local mod	= DBM:NewMod(2393, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164406)
mod:SetEncounterID(2398)
mod:SetZone()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328857 328921 340047 330711",
	"SPELL_CAST_SUCCESS 321511 336337 336235",
	"SPELL_AURA_APPLIED 328897 329370 336338 336235",
	"SPELL_AURA_APPLIED_DOSE 328897",
	"SPELL_AURA_REMOVED 329370 328921 336338 336235",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, determine actual tank swap stacks, 3 assumed for now but this could be inaccurate
--TODO, probably fix Feast event
--TODO, do more with descend and murder pray if the Deadly Descent targets have enough time to still get away
--TODO, who do stone claws target? says a frontal cone but it doesn't indicate it's a tank ability so boss can easily spin toward random player for this attack
--TODO, Sonar shriek is what exactly? dodgable? spamable aoe damage just to give healers a purpose during this phase?
--TODO, dark descent is probably just players who get too much sound in phase 1?
--TODO, icons for Sanguine curse? depends on how many get it and if it still exists
--TODO, honestly, should this mod watch player power or boss power? I have a feeling fight will have a noise level alternate power setup like atramedes so going with player for now
--TODO, echo screech cast how often? what event? timer/warning?
--Stage One - Thirst for Blood
local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnSanguineFeast							= mod:NewSpellAnnounce(340322, 2)
local warnSanguineCurse							= mod:NewTargetNoFilterAnnounce(336338, 3, nil, "RemoveCurse")
local warnDarkDescent							= mod:NewTargetAnnounce(336235, 3)
--Stage Two - Terror of Castle Nathria
local warnDarkSonar								= mod:NewSpellAnnounce(321511, 4, nil, false)--Probably spammy?
local warnDeadlyDescent							= mod:NewTargetNoFilterAnnounce(329370, 4)
local warnBloodgorgeOver						= mod:NewEndAnnounce(328921, 1)
local warnSonarShriek							= mod:NewCastAnnounce(340047, 2)

--Stage One - Thirst for Blood
local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 4, nil, nil, 1, 6)
local specWarnExsanguinatedTaunt				= mod:NewSpecialWarningTaunt(328897, nil, nil, nil, 1, 2)
local specWarnDarkDescent						= mod:NewSpecialWarningMoveAway(336235, nil, nil, nil, 1, 2)
local yellDarkDescent							= mod:NewYell(336235)
local yellDarkDescentFades						= mod:NewShortFadesYell(336235)
local specWarnSanguineCurse						= mod:NewSpecialWarningMoveAway(336338, nil, nil, nil, 1, 2)
local yellSanguineCurse							= mod:NewYell(336338)
local yellSanguineCurseFades					= mod:NewShortFadesYell(336338)
local specWarnEarsplittingShriek				= mod:NewSpecialWarningMoveTo(330711, nil, nil, nil, 1, 2)
--Stage Two - Terror of Castle Nathria
local specWarnBloodgorge						= mod:NewSpecialWarningSpell(328921, nil, nil, nil, 2, 2)
local specWarnDeadlyDescent						= mod:NewSpecialWarningYou(329370, nil, nil, nil, 3, 2)
local yellDeadlyDescent							= mod:NewYell(329370)
local yellDeadlyDescentFades					= mod:NewShortFadesYell(329370)
local specWarnDeadlyDescentNear					= mod:NewSpecialWarningClose(329370, nil, nil, nil, 3, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--Stage One - Thirst for Blood
--mod:AddTimerLine(BOSS)
local timerExsanguinatingBiteCD					= mod:NewAITimer(16.6, 328857, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerSanguineFeastCD						= mod:NewAITimer(44.3, 340322, nil, nil, nil, 2)
local timerSanguineCurseCD						= mod:NewAITimer(44.3, 336337, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerDarkDescentCD						= mod:NewAITimer(44.3, 336235, nil, nil, nil, 3)
local timerEarsplittingShriekCD					= mod:NewAITimer(44.3, 330711, nil, nil, nil, 2)
--Stage Two - Terror of Castle Nathria
local timerSonarShriekCD						= mod:NewAITimer(44.3, 340047, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(12, 329373)
mod:AddInfoFrameOption(328921, true)
mod:AddSetIconOption("SetIconOnSanguineCurse", 336338, true, false, {1, 2, 3, 4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)
--mod:AddDropdownOption("TauntBehavior", {"TwoHardThreeEasy", "TwoAlways", "ThreeAlways"}, "TwoHardThreeEasy", "misc")

mod.vb.curseIcon = 1

function mod:OnCombatStart(delay)
	self.vb.curseIcon = 1
	timerExsanguinatingBiteCD:Start(1-delay)
	timerSanguineFeastCD:Start(1-delay)
	timerEarsplittingShriekCD:Start(1-delay)
--	if self:IsMythic() then
		timerSanguineCurseCD:Start(1-delay)--Likely now mythic only
--	end
	timerDarkDescentCD:Start(1-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(2, "playerpower", 1, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328857 then
		timerExsanguinatingBiteCD:Start()
	elseif spellId == 328921 then
		specWarnBloodgorge:Show()
		specWarnBloodgorge:Play("phasechange")
		timerExsanguinatingBiteCD:Stop()
		timerSanguineFeastCD:Stop()
		timerSanguineCurseCD:Stop()
		timerDarkDescentCD:Stop()
		timerSonarShriekCD:Start(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	elseif spellId == 340047 then
		warnSonarShriek:Show()
		timerSonarShriekCD:Start()
	elseif spellId == 330711 then
		specWarnEarsplittingShriek:Show(DBM_CORE_L.BREAK_LOS)
		specWarnEarsplittingShriek:Play("findshelter")
		timerEarsplittingShriekCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 321511 then
		warnDarkSonar:Show()
	elseif spellId == 336337 then
		self.vb.curseIcon = 1
		timerSanguineCurseCD:Start()
	elseif spellId == 336235 then
		timerDarkDescentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328897 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--local tauntStack = 3
			--if self:IsHard() and self.Options.TauntBehavior == "TwoHardThreeEasy" or self.Options.TauntBehavior == "TwoAlways" then
			--	tauntStack = 2
			--end
			if amount >= 4 then
				if args:IsPlayer() then
					specWarnExsanguinated:Show(amount)
					specWarnExsanguinated:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and not self:IsHealer() then--Can't taunt less you've dropped yours off, period.
						specWarnExsanguinatedTaunt:Show(args.destName)
						specWarnExsanguinatedTaunt:Play("tauntboss")
					else
						warnExsanguinated:Show(args.destName, amount)
					end
				end
			else
				warnExsanguinated:Show(args.destName, amount)
			end
		end
	elseif spellId == 329370 then
		if args:IsPlayer() then
			specWarnDeadlyDescent:Show()
			specWarnDeadlyDescent:Play("targetyou")
			yellDeadlyDescent:Yell()
			yellDeadlyDescentFades:Countdown(spellId)
		elseif self:CheckNearby(12, args.destName) then
			specWarnDeadlyDescentNear:CombinedShow(0.3, args.destName)
			specWarnDeadlyDescentNear:ScheduleVoice(0.3, "runaway")
		else
			warnDeadlyDescent:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 336338 then
		warnSanguineCurse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSanguineCurse:Show()
			specWarnSanguineCurse:Play("runout")
			yellSanguineCurse:Yell()
			yellSanguineCurseFades:Countdown(spellId)
		end
		if self.Options.SetIconOnSanguineCurse then
			self:SetIcon(args.destName, self.vb.curseIcon)
		end
		self.vb.curseIcon = self.vb.curseIcon + 1
	elseif spellId == 336235 then
		warnDarkDescent:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnDarkDescent:Show()
			specWarnDarkDescent:Play("runout")
			yellDarkDescent:Yell()
			yellDarkDescentFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329370 then
		if args:IsPlayer() then
			yellDeadlyDescentFades:Cancel()
		end
	elseif spellId == 328921 then--Bloodgorge removed
		timerSonarShriekCD:Stop()
		warnBloodgorgeOver:Show()
		timerExsanguinatingBiteCD:Start(2)
		timerSanguineFeastCD:Start(2)
		timerSanguineCurseCD:Start(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 336338 then
		if args:IsPlayer() then
			yellSanguineCurseFades:Cancel()
		end
		if self.Options.SetIconOnSanguineCurse then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 336235 then
		if args:IsPlayer() then
			yellDarkDescentFades:Cancel()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 340322 then--Sanguine Feast
		warnSanguineFeast:Show()
		timerSanguineFeastCD:Start()
	end
end
