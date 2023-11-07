local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2554, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200926)
mod:SetEncounterID(2709)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20231013000000)
mod:SetMinSyncRevision(20231013000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 414425 416996 422776 419048 416048 418531 415624",
	"SPELL_CAST_SUCCESS 424456",
	"SPELL_AURA_APPLIED 414340 414888 414367 419462 415623 414770 426056",
	"SPELL_AURA_APPLIED_DOSE 414340",
	"SPELL_AURA_REMOVED 414888",--415623
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, secondary warning for https://wowhead.com/ptr-2/spell=424347 ?
--TODO, Smashing Viscera is a hidden aura that's not logged, but UNIT_AURA might work
local warnDrenchedBlades							= mod:NewStackAnnounce(414340, 2, nil, "Tank|Healer")
local warnBlisteringSpear							= mod:NewTargetCountAnnounce(414888, 3, nil, nil, 282481, nil, nil, nil, true)
local warnMarkedforTorment							= mod:NewCountAnnounce(422776, 3, nil, nil, 99256)
local warnGatheringTorment							= mod:NewYouAnnounce(414367, 4)
--Torments
local warnSmashingVisceraSoon						= mod:NewSoonAnnounce(424456, 2, nil, nil, 47482)--Sword Stance
local warnHeartstopperSoon							= mod:NewSoonAnnounce(415623, 2)--Knife Stance
local warnUmbralDestructionSoon						= mod:NewSoonAnnounce(416048, 2)--Axe Stance
--local warnSmashingViscera							= mod:NewTargetNoFilterAnnounce(424456, 3)--Re-add if it gets put back in combat log
local warnHeartStopper								= mod:NewTargetCountAnnounce(415623, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnDrenchedBlades						= mod:NewSpecialWarningTaunt(414340, nil, nil, nil, 1, 2)
local specWarnBlisteringSpear						= mod:NewSpecialWarningYou(414888, nil, 369351, nil, 1, 2)
local yellBlisteringSpear							= mod:NewShortPosYell(414888, 369351, false)--Shorttext "Spear"
local yellBlisteringSpearFades						= mod:NewIconFadesYell(414888, nil, false)
local specWarnBlisteringTorment						= mod:NewSpecialWarningYou(414770, nil, 184656, nil, 1, 2)--Shorttext "Chains"
local yellBlisteringTorment							= mod:NewShortPosYell(414770, 184656)
local specWarnTwistedBlade							= mod:NewSpecialWarningDodgeCount(416996, nil, 138737, nil, 2, 2)
local specWarnFleshMortification					= mod:NewSpecialWarningYou(419462, nil, nil, nil, 1, 2)
local specWarnRuinousEnd							= mod:NewSpecialWarningSpell(419048, nil, nil, nil, 3, 2)
--Torments
local specWarnUmbralDestruction						= mod:NewSpecialWarningCount(416048, nil, nil, nil, 2, 2)
local specWarnSmashingViscera						= mod:NewSpecialWarningYou(424456, nil, 47482, nil, 1, 2)--Not in combat log
local yellSmashingViscera							= mod:NewShortYell(424456, 47482)
local yellSmashingVisceraFades						= mod:NewShortFadesYell(424456)
local specWarnHeartStopper							= mod:NewSpecialWarningYou(415623, nil, nil, nil, 1, 2)
local yellHeartStopperFades							= mod:NewShortFadesYell(415623)
local specWarnVitalRupture							= mod:NewSpecialWarningYou(426056, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerBlisteringSpearCD						= mod:NewCDCountTimer(49, 414888, 282481, nil, nil, 3)--Short text "Spears"
local timerTwistedBladeCD							= mod:NewCDCountTimer(49, 416996, 138737, nil, nil, 3)--Short Text "Blades"
local timerMarkedforTormentCD						= mod:NewCDCountTimer(49, 422776, 99256, nil, nil, 6)--Short text "Torment"
--Torments
local timerUmbralDestructionCD						= mod:NewCDCountTimer(49, 416048, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 5)--Shorttext "Soak"
local timerSmashingVisceraCD						= mod:NewCDCountTimer(49, 424456, 47482, nil, nil, 3)--Shorttext "Leap"
local timerHeartStopperCD							= mod:NewCDCountTimer(49, 415623, L.HealAbsorbs, nil, nil, 3)
local berserkTimer									= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnBlisteringSpear", 414888, false, false, {1, 2, 3, 4, 5, 6})
--mod:AddSetIconOption("SetIconOnHeartStopper", 415623, false, false, {1, 2, 3, 4, 5, 6})

mod.vb.spearCount = 0
mod.vb.spearIcon = 1
mod.vb.twistedCount = 0
mod.vb.tormentCount = 0
--Toremnts
mod.vb.umbralCount = 0
mod.vb.heartCount = 0
--mod.vb.heartIcon = 1
mod.vb.smashingCount = 0
local bladesNormalTimers = {8.2, 25.6, 47.6, 25.1, 25.9, 15.8, 25.6, 46.3, 25.6, 25.5, 15.8, 25.5, 48.6, 25.5, 25.6, 15.8, 25.5, 47.4, 25.5, 25.5, 14.6, 25.6, 49.9, 25.6}
local bladesHeroicTimers = {7.2, 25.4, 48.9, 25.7, 25.4, 15.9, 26.1, 47.7, 25.6, 25.7, 15.8, 25.7, 48.6, 25.5, 25.6, 15.9, 25.6, 43.8, 25.5}
local bladesMythicTimers = {15.8, 20.8, 68.3, 30.5, 26.8, 20.8, 43.9, 25.5, 25.7, 25.6, 20.7, 61.0, 30.4, 26.8, 20.0}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spearCount = 0
	self.vb.spearIcon = 1
	self.vb.twistedCount = 0
	self.vb.tormentCount = 0
	if self:IsMythic() then
		timerBlisteringSpearCD:Start(4.5-delay, 1)
		timerTwistedBladeCD:Start(15.5-delay, 1)
		timerMarkedforTormentCD:Start(46-delay, 1)
		berserkTimer:Start(420-delay)
	else
		timerBlisteringSpearCD:Start(15.9-delay, 1)
		timerTwistedBladeCD:Start(7.2-delay, 1)
		timerMarkedforTormentCD:Start(40.5-delay, 1)
	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 414425 then
		self.vb.spearCount = self.vb.spearCount + 1
		self.vb.spearIcon = 1
		if self:IsMythic() then
			--4.7, 20.9, 125.6, 20.8, 120.7, 20.7, 118.2, 20.7
			if self.vb.spearCount % 2 == 0 then
				--Not done here, done at weapons on mythic (and possibly other difficulties too when re-reviewed
				if self.vb.spearCount >= 8 then--Not sure this is still true but leaving for now
					timerBlisteringSpearCD:Start(47.4, self.vb.spearCount+1)
				--else
				--	timerBlisteringSpearCD:Start(120, self.vb.spearCount+1)
				end
			else
				timerBlisteringSpearCD:Start(20.5, self.vb.spearCount+1)
			end
		else
			if not self:IsEasy() and self.vb.spearCount >= 4 then
				timerBlisteringSpearCD:Start(70, self.vb.spearCount+1)
			else
				timerBlisteringSpearCD:Start(140, self.vb.spearCount+1)
			end
		end
	elseif spellId == 416996 then
		self.vb.twistedCount = self.vb.twistedCount + 1
		specWarnTwistedBlade:Show(self.vb.twistedCount)
		specWarnTwistedBlade:Play("watchstep")
		local timer
		if self:IsMythic() then
			timer = bladesMythicTimers[self.vb.twistedCount+1]
		elseif self:IsHeroic() then
			timer = bladesHeroicTimers[self.vb.twistedCount+1]
		else
			timer = bladesNormalTimers[self.vb.twistedCount+1]
		end
		timerTwistedBladeCD:Start(timer, self.vb.twistedCount+1)
	elseif spellId == 422776 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		warnMarkedforTorment:Show(self.vb.tormentCount)
		self:SetStage(self.vb.tormentCount)--Matching BW behavior which is kinda meh, but WA parity is needed
		if not self:IsEasy() and self.vb.tormentCount >= 4 then
			timerMarkedforTormentCD:Start(70, self.vb.tormentCount+1)
		else
			timerMarkedforTormentCD:Start(140, self.vb.tormentCount+1)
		end
	elseif spellId == 419048 then
		specWarnRuinousEnd:Show()
		specWarnRuinousEnd:Play("aesoon")
	elseif spellId == 416048 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		specWarnUmbralDestruction:Show()
		specWarnUmbralDestruction:Play("specialsoon")--Vague voice instead of backseating til more time to review strategies
		if self.vb.umbralCount == 1 then
			timerUmbralDestructionCD:Start(30, 2)
		end
	elseif spellId == 418531 then
		self.vb.smashingCount = self.vb.smashingCount + 1
		if self.vb.smashingCount == 1 then
			timerSmashingVisceraCD:Start(30, 2)
		end
	elseif spellId == 415624 then
		self.vb.heartCount = self.vb.heartCount + 1
--		self.vb.heartIcon = 1
		if self.vb.heartCount == 1 then
			timerHeartStopperCD:Start(30, 2)
		end
	end
end
--]]

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 424456 then
		--if args:IsPlayer() then
		--	specWarnSmashingViscera:Show()
		--	specWarnSmashingViscera:Play("runout")
		--	yellSmashingViscera:Yell()
		--else
		--	warnSmashingViscera:Show(args.destName)
		--end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 414340 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 or amount > 6 then--Placeholder until review
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnDrenchedBlades:Show(args.destName)
					specWarnDrenchedBlades:Play("tauntboss")
				else
					warnDrenchedBlades:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 414888 then
		local icon = self.vb.spearIcon
		if self.Options.SetIconOnBlisteringSpear then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlisteringSpear:Show()
			specWarnBlisteringSpear:Play("spear")
			yellBlisteringSpear:Yell(icon, icon)
			yellBlisteringSpearFades:Countdown(spellId, nil, icon)
		end
		warnBlisteringSpear:CombinedShow(0.5, self.vb.spearCount, args.destName)
		self.vb.spearIcon = self.vb.spearIcon + 1
	elseif spellId == 414367 and args:IsPlayer() then
		warnGatheringTorment:Show()
	elseif spellId == 419462 and args:IsPlayer() then
		specWarnFleshMortification:Show()
		specWarnFleshMortification:Play("otherout")--Still reviewing best sound for this or if new one needed
	elseif spellId == 415623 then
--		local icon = self.vb.heartIcon
--		if self.Options.SetIconOnHeartStopper then
--			self:SetIcon(args.destName, icon)
--		end
		if args:IsPlayer() then
			specWarnHeartStopper:Show()
			specWarnHeartStopper:Play("targetyou")
--			yellHeartStopper:Yell(icon, icon)
			yellHeartStopperFades:Countdown(spellId)--, nil, icon
		end
		warnHeartStopper:CombinedShow(1.1, self.vb.heartCount, args.destName)
--		self.vb.heartIcon = self.vb.heartIcon + 1
	elseif spellId == 414770 then
		if args:IsPlayer() then
			specWarnBlisteringTorment:Show()
			specWarnBlisteringTorment:Play("targetyou")
			yellBlisteringTorment:Yell()
		end
	elseif spellId == 426056 then
		if args:IsPlayer() then
			specWarnVitalRupture:Show()
			specWarnVitalRupture:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 414888 then
		if self.Options.SetIconOnBlisteringSpear then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlisteringSpearFades:Cancel()
		end
--	elseif spellId == 415623 then
--		if self.Options.SetIconOnHeartStopper then
--			self:SetIcon(args.destName, 0)
--		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 409058 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--https://www.wowhead.com/ptr-2/npc=207341/blistering-spear
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then

	end
end
--]]

do
	local warnedLeap = false
	function mod:UNIT_AURA(uId)
		local hasLeap = DBM:UnitDebuff("player", 424456)
		if hasLeap and not warnedLeap then
			warnedLeap = true
			specWarnSmashingViscera:Show()
			specWarnSmashingViscera:Play("targetyou")
			yellSmashingViscera:Yell()
			yellSmashingVisceraFades:Countdown(4)
		elseif not hasLeap and warnedLeap then
			warnedLeap = false
			yellSmashingVisceraFades:Cancel()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 415020 then--Sword Stance
		self.vb.smashingCount = 0
		warnSmashingVisceraSoon:Show()
		timerSmashingVisceraCD:Start(19, 1)
	elseif spellId == 415094 then--Knife Stance
		self.vb.heartCount = 0
		warnHeartstopperSoon:Show()
		timerHeartStopperCD:Start(19, 1)
	elseif spellId == 415090 then--Axe Stance
		self.vb.umbralCount = 0
		warnUmbralDestructionSoon:Show()
		timerUmbralDestructionCD:Start(19, 1)
	--Mythic
	elseif spellId == 425282 then--Axe Knife Stance
		self.vb.umbralCount = 0
		self.vb.heartCount = 0
		warnUmbralDestructionSoon:Show()
		warnHeartstopperSoon:Show()
		timerHeartStopperCD:Start(14.3, 1)
		timerUmbralDestructionCD:Start(18.3, 1)
		timerBlisteringSpearCD:Start(73.6, self.vb.spearCount+1)
	elseif spellId == 425283 then--Axe Sword Stance
		self.vb.smashingCount = 0
		self.vb.umbralCount = 0
		warnSmashingVisceraSoon:Show()
		warnUmbralDestructionSoon:Show()
		timerUmbralDestructionCD:Start(7.9, 1)
		timerSmashingVisceraCD:Start(13.4, 1)
		timerBlisteringSpearCD:Start(73.6, self.vb.spearCount+1)
	elseif spellId == 414357 then--Sword Knife Stance
		self.vb.smashingCount = 0
		self.vb.heartCount = 0
		warnSmashingVisceraSoon:Show()
		warnHeartstopperSoon:Show()
		timerHeartStopperCD:Start(7.5, 1)
		timerSmashingVisceraCD:Start(11.5, 1)
		timerBlisteringSpearCD:Start(73.6, self.vb.spearCount+1)
	end
end

