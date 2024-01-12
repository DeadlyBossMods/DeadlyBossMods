local mod	= DBM:NewMod(2554, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(200926)
mod:SetEncounterID(2709)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(20231227000000)
mod:SetMinSyncRevision(20231213000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 414425 416996 422776 419048 416048 418531 415624",
	"SPELL_CAST_SUCCESS 424456",
	"SPELL_AURA_APPLIED 414340 414888 414367 419462 415623 414770 426056 422961",
	"SPELL_AURA_APPLIED_DOSE 414340",
	"SPELL_AURA_REMOVED 414888 422961 415623",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 414425 or ability.id = 416996 or ability.id = 422776 or ability.id = 419048 or ability.id = 416048 or ability.id = 418531 or ability.id = 415624) and type = "begincast"
 or ability.id = 424456 and type = "cast"
 or ability.id = 415020 or ability.id = 415094 or ability.id = 415090 or ability.id = 425282 or ability.id = 425283 or ability.id = 414357
 or ability.id = 422961 or ability.id = 301495
 or ability.id = 415623 and type = "applydebuff"
--]]
--TODO, secondary warning for https://wowhead.com/ptr-2/spell=424347 ?
--TODO, Smashing Viscera is a hidden aura that's not logged, but UNIT_AURA might work
--https://www.warcraftlogs.com/reports/N2k1xpg9rVqRDyQZ#fight=11&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20414425%20or%20ability.id%20%3D%20416996%20or%20ability.id%20%3D%20422776%20or%20ability.id%20%3D%20419048%20or%20ability.id%20%3D%20416048%20or%20ability.id%20%3D%20418531%20or%20ability.id%20%3D%20415624)%20and%20type%20%3D%20%22begincast%22%0A%20or%20ability.id%20%3D%20424456%20and%20type%20%3D%20%22cast%22%0A%20or%20ability.id%20%3D%20415020%20or%20ability.id%20%3D%20415094%20or%20ability.id%20%3D%20415090%20or%20ability.id%20%3D%20425282%20or%20ability.id%20%3D%20425283%20or%20ability.id%20%3D%20414357%0A%20or%20ability.name%20%3D%20%22Heart%20Stopper%22&view=events
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
local warnFleshMortification						= mod:NewYouAnnounce(419462, 4)

local specWarnDrenchedBlades						= mod:NewSpecialWarningTaunt(414340, nil, nil, nil, 1, 2)
local specWarnBlisteringSpear						= mod:NewSpecialWarningYou(414888, nil, 369351, nil, 1, 2)
local yellBlisteringSpear							= mod:NewShortPosYell(414888, 369351, false)--Shorttext "Spear"
local yellBlisteringSpearFades						= mod:NewIconFadesYell(414888, nil, false)
local specWarnBlisteringTorment						= mod:NewSpecialWarningYou(414770, nil, 184656, nil, 1, 2)--Shorttext "Chains"
local yellBlisteringTorment							= mod:NewShortYell(414770, 184656)
local specWarnTwistingBlade							= mod:NewSpecialWarningDodgeCount(416996, nil, 138737, nil, 2, 2)
local specWarnRuinousEnd							= mod:NewSpecialWarningSpell(419048, nil, nil, nil, 3, 2)
--Torments
local specWarnUmbralDestruction						= mod:NewSpecialWarningCount(416048, nil, nil, nil, 2, 2)
local specWarnSmashingViscera						= mod:NewSpecialWarningYou(424456, nil, 47482, nil, 1, 2)--Not in combat log
local yellSmashingViscera							= mod:NewShortYell(424456, 47482)
local yellSmashingVisceraFades						= mod:NewShortFadesYell(424456)
local specWarnHeartStopper							= mod:NewSpecialWarningYou(415623, nil, nil, nil, 1, 2)
local specWarnHeartStopperTaunt						= mod:NewSpecialWarningTaunt(415623, nil, nil, nil, 1, 2)
local yellHeartStopperFades							= mod:NewShortFadesYell(415623)
local specWarnVitalRupture							= mod:NewSpecialWarningYou(426056, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerBlisteringSpearCD						= mod:NewCDCountTimer(49, 414888, 282481, nil, nil, 3)--Short text "Spears"
local timerTwistingBladeCD							= mod:NewCDCountTimer(20.6, 416996, 138737, nil, nil, 3)--Short Text "Blades"

local timerMarkedforTorment							= mod:NewCastTimer(20, 422776, 99256, nil, nil, 2)--Short text "Torment"
local timerMarkedforTormentCD						= mod:NewCDCountTimer(49, 422776, 99256, nil, nil, 6)--Short text "Torment"
--Torments
local timerUmbralDestructionCD						= mod:NewCDCountTimer(49, 416048, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 5)--Shorttext "Soak"
local timerSmashingVisceraCD						= mod:NewCDCountTimer(49, 424456, 47482, nil, nil, 3)--Shorttext "Leap"
local timerHeartStopperCD							= mod:NewCDCountTimer(49, 415623, L.HealAbsorbs, nil, nil, 3)
local berserkTimer									= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnBlisteringSpear", 414888, false, false, {1, 2, 3, 4, 5, 6})

local blisteringMythicTimers = {14, 32.1, 35.1, 20.2}
local blisteringHeroicTimers = {14, 23.0, 23.0, 22.5, 20.2}
local blisteringEasyTimers = {14, 30.3, 38.9, 20.6}

mod.vb.spearCount = 0--used for sequencing
mod.vb.spearTotal = 0--Used for timer text
mod.vb.spearIcon = 1
mod.vb.TwistingCount = 0--used for sequencing
mod.vb.TwistingTotal = 0--Used for timer text
mod.vb.tormentCount = 0
--Toremnts
mod.vb.umbralCount = 0
mod.vb.heartCount = 0
--mod.vb.heartIcon = 1
mod.vb.smashingCount = 0
mod.vb.useHeartStopperBackup = false
local tormentOverTime = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spearCount = 0
	self.vb.spearTotal = 0
	self.vb.spearIcon = 1
	self.vb.TwistingCount = 0
	self.vb.TwistingTotal = 0
	self.vb.tormentCount = 0
	self.vb.useHeartStopperBackup = false
	tormentOverTime = 0
	if self:IsMythic() then
		timerBlisteringSpearCD:Start(4.5-delay, 1)
		timerTwistingBladeCD:Start(15.4-delay, 1)
		timerMarkedforTormentCD:Start(45.8-delay, 1)
		berserkTimer:Start(420-delay)--430 if a specific weapon combo is done 3rd
	else
		timerBlisteringSpearCD:Start(10.6-delay, 1)
		timerTwistingBladeCD:Start(4.5-delay, 1)
		timerMarkedforTormentCD:Start(44.7-delay, 1)
		berserkTimer:Start(600-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 414425 then
		self.vb.spearCount = self.vb.spearCount + 1
		self.vb.spearTotal = self.vb.spearTotal + 1
		self.vb.spearIcon = 1
		--If initial timer before any weapons
		if (self.vb.tormentCount == 0 and self.vb.spearCount == 1) then
			timerBlisteringSpearCD:Start(20.5, self.vb.spearTotal+1)
		--WHen out of weapons
		elseif self:IsHard() and self.vb.tormentCount >= 4 then
			timerBlisteringSpearCD:Start(30, self.vb.spearTotal+1)
		elseif self.vb.tormentCount >= 1 then--Timers will follow sequence of event during active weapons basically
			local timer = self:IsMythic() and blisteringMythicTimers[self.vb.spearCount+1] or self:IsHeroic() and blisteringHeroicTimers[self.vb.spearCount+1] or blisteringEasyTimers[self.vb.spearCount+1]
			if timer then
				timerBlisteringSpearCD:Start(timer, self.vb.spearTotal+1)
			end
		end
	elseif spellId == 416996 then
		self.vb.TwistingCount = self.vb.TwistingCount + 1
		self.vb.TwistingTotal = self.vb.TwistingTotal + 1
		specWarnTwistingBlade:Show(self.vb.TwistingTotal)
		specWarnTwistingBlade:Play("watchstep")
		--Changes to 25.5 when out of weapons
		if self:IsHard() and self.vb.tormentCount >= 4 then
			timerTwistingBladeCD:Start(25.5, self.vb.TwistingTotal+1)
		--Always two Twisting blades in each set, so if count 1 then always start 2nd timer
		elseif self.vb.TwistingCount == 1 then
			timerTwistingBladeCD:Start(20.6, self.vb.TwistingTotal+1)
		end
	elseif spellId == 422776 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		self.vb.useHeartStopperBackup = false
		warnMarkedforTorment:Show(self.vb.tormentCount)
		self:SetStage(self.vb.tormentCount)--Matching BW behavior which is kinda meh, but WA parity is needed
	elseif spellId == 419048 then
		specWarnRuinousEnd:Show()
		specWarnRuinousEnd:Play("aesoon")
	elseif spellId == 416048 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		specWarnUmbralDestruction:Show(self.vb.umbralCount)
		specWarnUmbralDestruction:Play("specialsoon")--Vague voice instead of backseating til more time to review strategies
		if self.vb.umbralCount == 1 then
			timerUmbralDestructionCD:Start(self:IsMythic() and 32.7 or self:IsHeroic() and 25 or 30, 2)
		end
	elseif spellId == 418531 then
		self.vb.smashingCount = self.vb.smashingCount + 1
		if self.vb.smashingCount == 1 then
			timerSmashingVisceraCD:Start(self:IsMythic() and 32.7 or self:IsHeroic() and 25 or 30, 2)
		end
	elseif spellId == 415624 and self:AntiSpam(8, 1) then
		self.vb.heartCount = self.vb.heartCount + 1
		if self.vb.heartCount == 1 then
			timerHeartStopperCD:Start(self:IsMythic() and 32.7 or self:IsHeroic() and 25 or 30, 2)--Cast start only in combat log on mythic
		end
	end
end

--[[
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
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 414340 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 or amount > 6 then--Placeholder until review
				if amount > 6 and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
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
		warnBlisteringSpear:CombinedShow(0.5, self.vb.spearTotal, args.destName)
		self.vb.spearIcon = self.vb.spearIcon + 1
	elseif spellId == 414367 and args:IsPlayer() then
		warnGatheringTorment:Show()
	elseif spellId == 419462 and args:IsPlayer() then
		warnFleshMortification:Show()
	elseif spellId == 415623 then
		if self:AntiSpam(8, 1) then
			self.vb.heartCount = self.vb.heartCount + 1
			if self.vb.heartCount == 1 then
				timerHeartStopperCD:Start(self:IsMythic() and 32.7 or self:IsHeroic() and 25 or 30, 2)--Cast start not in combat log on non mythic
			end
		end
		if args:IsPlayer() then
			specWarnHeartStopper:Show()
			specWarnHeartStopper:Play("targetyou")
			yellHeartStopperFades:Countdown(spellId)--, nil, icon
			--Unschedule if you also got it
			specWarnHeartStopperTaunt:Cancel()
			specWarnHeartStopperTaunt:CancelVoice()
		elseif self.vb.useHeartStopperBackup then--Mythic difficulty and boss has debuffs and soaks
			local uId = DBM:GetRaidUnitId(args.destName)
			--If heartstopper is on tank that isn't you and you do not have it, taunt the boss on mythic difficulty
			if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then
				--Scheduled so first wait to make sure you don't also get it
				specWarnHeartStopperTaunt:Schedule(0.8, args.destName)
				specWarnHeartStopperTaunt:ScheduleVoice(0.8, "tauntboss")
			end
		end
		warnHeartStopper:CombinedShow(1.1, self.vb.heartCount, args.destName)
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
	elseif spellId == 422961 then--Torment Beginning
		tormentOverTime = GetTime() + 20--Expected duration
		timerMarkedforTorment:Start()
		--Timers started in applied instead of removed, so they don't need adjusting later in LFR due to overtime
		if self:IsHard() and self.vb.tormentCount >= 4 then
			timerTwistingBladeCD:Start(self:IsMythic() and 138.8 or 31.5, self.vb.TwistingTotal+1)--Mythic twisted not seen yet
			timerBlisteringSpearCD:Start(38.8, self.vb.spearTotal+1)
			timerMarkedforTormentCD:Start(self:IsMythic() and 139.8 or 74, self.vb.tormentCount+1)
		else
			timerBlisteringSpearCD:Start(34, self.vb.spearTotal+1)
			timerTwistingBladeCD:Start(self:IsMythic() and 114.1 or 97.7, self.vb.TwistingTotal+1)
			timerMarkedforTormentCD:Start(self:IsMythic() and 139.8 or 133.8, self.vb.tormentCount+1)
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
	elseif spellId == 415623 then
		if args:IsPlayer() then
			yellHeartStopperFades:Cancel()
		end
	elseif spellId == 422961 then--Torment Ending
		tormentOverTime = GetTime() - tormentOverTime--Should be 0 all the time in non LFR, in LFR it will be 0 or greater
		timerMarkedforTorment:Stop()
		--Handle initial timer resets
		self.vb.spearCount = 0
		self.vb.TwistingCount = 0
	end
end

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

-- "<72.49 22:05:33> [CLEU] SPELL_AURA_REMOVED#Creature-0-4251-2549-21526-200926-000057D47F#Igira the Cruel#Creature-0-4251-2549-21526-207999-000057D47F#Flesh Mortification#422961#Marked for Torment#BUFF#nil",
-- "<77.51 22:05:38> [UNIT_SPELLCAST_SUCCEEDED] Igira the Cruel(72.7%-0.0%){Target:??} -Axe Knife Stance- [[boss1:Cast-3-4251-2549-21526-425282-004257D59D:425282]]",
--<217.25 22:07:58> [CLEU] SPELL_AURA_REMOVED#Creature-0-4251-2549-21526-200926-000057D47F#Igira the Cruel#Creature-0-4251-2549-21526-207999-000057D47F#Flesh Mortification#422961#Marked for Torment#BUFF#nil",
--"<222.27 22:08:03> [UNIT_SPELLCAST_SUCCEEDED] Igira the Cruel(34.2%-0.0%){Target:??} -Axe Sword Stance- [[boss1:Cast-3-4251-2549-21526-425283-001757D62E:425283]]",
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--Non Mythic specific weapon handling
	if spellId == 415020 then--Sword Stance
		self.vb.smashingCount = 0
		warnSmashingVisceraSoon:Show()
		local initialTimer = self:IsLFR() and 24.7 or 19.9
		local adjustedTimer = self:IsLFR() and (initialTimer - tormentOverTime) or initialTimer
		timerSmashingVisceraCD:Start(adjustedTimer, 1)
	elseif spellId == 415094 then--Knife Stance
		self.vb.heartCount = 0
		warnHeartstopperSoon:Show()
		local initialTimer = self:IsLFR() and 23.9 or 19
		local adjustedTimer = self:IsLFR() and (initialTimer - tormentOverTime) or initialTimer
		timerHeartStopperCD:Start(adjustedTimer, 1)
	elseif spellId == 415090 then--Axe Stance
		self.vb.umbralCount = 0
		warnUmbralDestructionSoon:Show()
		local initialTimer = self:IsLFR() and 23.7 or 18.8
		local adjustedTimer = self:IsLFR() and (initialTimer - tormentOverTime) or initialTimer
		timerUmbralDestructionCD:Start(adjustedTimer, 1)
	--Mythic specific weapon handling
	elseif spellId == 425282 then--Axe Knife Stance
		self.vb.umbralCount = 0
		self.vb.heartCount = 0
		self.vb.useHeartStopperBackup = true
		warnUmbralDestructionSoon:Show()
		warnHeartstopperSoon:Show()
		timerHeartStopperCD:Start(21.2, 1)
		timerUmbralDestructionCD:Start(25.2, 1)
	elseif spellId == 425283 then--Axe Sword Stance
		self.vb.smashingCount = 0
		self.vb.umbralCount = 0
		warnSmashingVisceraSoon:Show()
		warnUmbralDestructionSoon:Show()
		timerUmbralDestructionCD:Start(18.8, 1)
		timerSmashingVisceraCD:Start(25.3, 1)
	elseif spellId == 414357 then--Sword Knife Stance
		self.vb.smashingCount = 0
		self.vb.heartCount = 0
		warnSmashingVisceraSoon:Show()
		warnHeartstopperSoon:Show()
		timerHeartStopperCD:Start(18.8, 1)
		timerSmashingVisceraCD:Start(22.8, 1)
	end
end

