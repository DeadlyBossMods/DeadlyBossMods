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
	"SPELL_CAST_START 328857 328921 329780",
	"SPELL_CAST_SUCCESS 329386 321511 336337",
	"SPELL_AURA_APPLIED 328897 329370 336338",
	"SPELL_AURA_APPLIED_DOSE 328897",
	"SPELL_AURA_REMOVED 329370 328921 336338"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, determine actual tank swap stacks, 3 assumed for now but this could be inaccurate
--TODO, probably fix spikes event
--TODO, do more with descend and murder pray if the cower targets have enough time to still get away
--TODO, who do stone claws target? says a frontal cone but it doesn't indicate it's a tank ability so boss can easily spin toward random player for this attack
--TODO, reverberating shriek is what exactly? dodgable? spamable aoe damage just to give healers a purpose during this phase?
--TODO, dark descent is probably just players who get too much sound in phase 1?
--TODO, icons for Sanguine curse? depends on how many get it
--TODO, honestly, should this mod watch player power or boss power? I have a feeling fight will have a noise level alternate power setup like atramedes so going with player for now
--Stage One - Thirst for Blood
local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnSanguineCurse							= mod:NewTargetNoFilterAnnounce(336338, 3, nil, "RemoveCurse")
--Stage Two - Terror of Castle Nathria
local warnDarkSonar								= mod:NewSpellAnnounce(321511, 4, nil, false)--Probably spammy?
local warnCower									= mod:NewTargetNoFilterAnnounce(329370, 4)
local warnBloodgorgeOver						= mod:NewEndAnnounce(328921, 1)
local warnReverberatingShriek					= mod:NewSpellAnnounce(329780, 2, nil, false)--My theory was this ability was added because phase 2 left healers nothing to do, so it probably spams

--Stage One - Thirst for Blood
local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 3, nil, nil, 1, 6)
local specWarnExsanguinatedTaunt				= mod:NewSpecialWarningTaunt(328897, nil, nil, nil, 1, 2)
local specWarnBloodSpikes						= mod:NewSpecialWarningDodge(329386, nil, nil, nil, 2, 2)
local specWarnSanguineCurse						= mod:NewSpecialWarningMoveAway(336338, nil, nil, nil, 1, 2)
local yellSanguineCurse							= mod:NewYell(336338)
local yellSanguineCurseFades					= mod:NewShortFadesYell(336338)
--Stage Two - Terror of Castle Nathria
local specWarnBloodgorge						= mod:NewSpecialWarningSpell(328921, nil, nil, nil, 2, 2)
local specWarnCower								= mod:NewSpecialWarningYou(329370, nil, nil, nil, 3, 2)
local yellCower									= mod:NewYell(329370)
local yellCowerFades							= mod:NewShortFadesYell(329370)
local specWarnCowerNear							= mod:NewSpecialWarningClose(329370, nil, nil, nil, 3, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--Stage One - Thirst for Blood
--mod:AddTimerLine(BOSS)
local timerExsanguinatingBiteCD					= mod:NewAITimer(16.6, 328857, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerBloodSpikesCD						= mod:NewAITimer(44.3, 329386, nil, nil, nil, 3)
local timerSanguineCurseCD						= mod:NewAITimer(44.3, 336337, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
--Stage Two - Terror of Castle Nathria
local timerReverberatingShriekCD				= mod:NewAITimer(44.3, 329780, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(12, 329373)
mod:AddInfoFrameOption(328921, true)
--mod:AddSetIconOption("SetIconOnMuttering", 310358, true, false, {2, 3, 4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)
--mod:AddDropdownOption("TauntBehavior", {"TwoHardThreeEasy", "TwoAlways", "ThreeAlways"}, "TwoHardThreeEasy", "misc")

function mod:OnCombatStart(delay)
	timerExsanguinatingBiteCD:Start(1-delay)
	timerBloodSpikesCD:Start(1-delay)
	timerSanguineCurseCD:Start(1-delay)
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
		timerBloodSpikesCD:Stop()
		timerSanguineCurseCD:Stop()
		timerReverberatingShriekCD:Start(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	elseif spellId == 329780 then
		warnReverberatingShriek:Show()
		timerReverberatingShriekCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 329386 then
		specWarnBloodSpikes:Show()
		specWarnBloodSpikes:Play("watchstep")
		timerBloodSpikesCD:Start()
	elseif spellId == 321511 then
		warnDarkSonar:Show()
	elseif spellId == 336337 then
		timerSanguineCurseCD:Start()
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
			if amount >= 3 then
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
			specWarnCower:Show()
			specWarnCower:Play("targetyou")
			yellCower:Yell()
			yellCowerFades:Countdown(spellId)
		elseif self:CheckNearby(12, args.destName) then
			specWarnCowerNear:CombinedShow(0.3, args.destName)
			specWarnCowerNear:ScheduleVoice(0.3, "runaway")
		else
			warnCower:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 336338 then
		warnSanguineCurse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSanguineCurse:Show()
			specWarnSanguineCurse:Play("runout")
			yellSanguineCurse:Yell()
			yellSanguineCurseFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329370 then
		if args:IsPlayer() then
			yellCowerFades:Cancel()
		end
	elseif spellId == 328921 then--Bloodgorge removed
		timerReverberatingShriekCD:Stop()
		warnBloodgorgeOver:Show()
		timerExsanguinatingBiteCD:Start(2)
		timerBloodSpikesCD:Start(2)
		timerSanguineCurseCD:Start(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 336338 then
		if args:IsPlayer() then
			yellSanguineCurseFades:Cancel()
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
