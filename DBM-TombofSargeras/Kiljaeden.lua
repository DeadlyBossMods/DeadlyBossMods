local mod	= DBM:NewMod(1898, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(117269)--121227 Illiden? 121193 Shadowsoul
mod:SetEncounterID(2051)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(16350)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 237725 238999 243982 240910 241983 239932",
	"SPELL_CAST_SUCCESS 236378 236710 237590 236498 238502 238430 238999",
	"SPELL_AURA_APPLIED 239932 236378 236710 237590 236498 236597 241721 245509",
	"SPELL_AURA_APPLIED_DOSE 245509",
	"SPELL_AURA_REMOVED 236378 236710 237590 236498 241721 239932 241983",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"--Illiden might cast important stuff, or adds?
)

--TODO, fine tune reflections with appropriate functions like range, etc if needed. Custom voices with correct actions other than "targetyou"
--TODO, verify Shadow Reflection expire times, 3 8s and a 7. one has a cast time and other 3 do not. suspicious!
--TODO, verify/correct event for Malignant Anguish, it's likely a channeled/buff type interrupt since spellID has no cast time.
--TODO, if multiple hopelessness adds spawn at once, auto mark them so healers can be assigned to diff targets by raid icon
--TODO, do we need shadow gaze warnings for player other then self?
--TODO, how many shadowsouls? Also add a "remaining warning" for it as well.
--TODO, buff active timer for expiring rifts? they seem to last 50 seconds based on data. So timer similar to elisande bubble timer?
--TODO, flame orb work. target of fixate after spawn. more than one spawn? if not, remove antispam
--TODO, if above is successful, add range frame (10 yards) for fixated flame orb person.
--TODO, deal wih wailing if tank suicides during spell cast start (and before success fires)
--[[
(ability.id = 238502 or ability.id = 237725 or ability.id = 238999 or ability.id = 243982 or ability.id = 240910 or ability.id = 241983) and type = "begincast"
 or (ability.id = 239932 or ability.id = 235059 or ability.id = 238502 or ability.id = 239785 or ability.id = 236378 or ability.id = 236710 or ability.id = 237590 or ability.id = 236498 or ability.id = 238430) and type = "cast"
 or ability.id = 244834 and type = "applybuff" or (ability.id = 241983 or ability.id = 244834) and type = "removebuff"
 or ability.name = "Rupturing Singularity" and target.name = "Omegal"
 --]]
local warnEruptingRelections		= mod:NewTargetAnnounce(236710, 2)
--Intermission: Eternal Flame
local warnBurstingDreadFlame		= mod:NewTargetAnnounce(238430, 2)--Generic for now until more known, likely something cast fairly often
--Stage Two:
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnWailingReflection			= mod:NewTargetAnnounce(236378, 4)
--Stage Three: Darkness of A Thousand Souls
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnTearRift					= mod:NewCountAnnounce(243982, 2)--Positive message color?
local warnDarknessofStuffEnded		= mod:NewEndAnnounce(238999, 1)

--Stage One: The Betrayer
local specWarnFelclaws				= mod:NewSpecialWarningDefensive(239932, nil, nil, nil, 1, 2)
local specWarnFelclawsOther			= mod:NewSpecialWarningTaunt(239932, nil, nil, nil, 1, 2)
local specWarnRupturingSingularity	= mod:NewSpecialWarningSoon(235059, nil, nil, nil, 3, 2)
local specWarnArmageddon			= mod:NewSpecialWarningCount(240910, nil, nil, nil, 2, 2)
local specWarnSRWailing				= mod:NewSpecialWarningYou(236378, nil, nil, nil, 1, 2)
local yellSRWailing					= mod:NewFadesYell(236378, 236075)--Keep name in tank one for now
local specWarnSRErupting			= mod:NewSpecialWarningYou(236710, nil, nil, nil, 1, 2)
local yellSRErupting				= mod:NewShortFadesYell(236710, 243160)
--Intermission: Eternal Flame
local specWarnFocusedDreadflame		= mod:NewSpecialWarningYou(238502, nil, nil, nil, 1, 2)
local yellFocusedDreadflame			= mod:NewShortYell(238502)
local yellFocusedDreadflameFades	= mod:NewFadesYell(236498)
local specWarnFocusedDreadflameOther= mod:NewSpecialWarningTarget(238502, nil, nil, nil, 1, 2)
local specWarnBurstingDreadflame	= mod:NewSpecialWarningMoveAway(238430, nil, nil, nil, 1, 2)
local yellBurstingDreadflame		= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--Stage Two: Reflected Souls
local specWarnSRHopeless			= mod:NewSpecialWarningYou(237590, nil, nil, nil, 1, 2)
local yellSRHopeless				= mod:NewShortFadesYell(237590, 237724)
local specWarnSRMalignant			= mod:NewSpecialWarningYou(236498, nil, nil, nil, 1, 2)
local yellSRMalignant				= mod:NewShortFadesYell(236498)
local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local specWarnDarknessofSouls		= mod:NewSpecialWarningMoveTo(238999, nil, nil, nil, 3, 2)
local specWarnObelisk				= mod:NewSpecialWarningCount(239785, nil, nil, nil, 2, 2)
local specWarnFlamingOrbSpawn		= mod:NewSpecialWarningDodge(239253, nil, nil, nil, 2, 2)--Spawn warning

--Stage One: The Betrayer
local timerFelclawsCD				= mod:NewCDCountTimer(25, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRupturingSingularityCD	= mod:NewCDCountTimer(61, 235059, nil, nil, nil, 3)--61-68?
local timerRupturingSingularity		= mod:NewCastTimer(9.7, 235059, 206577, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--Shortname: Comet Impact
local timerArmageddonCD				= mod:NewCDCountTimer(42, 240910, nil, nil, nil, 5)
local timerArmageddon				= mod:NewCastTimer(9, 234295, nil, nil, nil, 2)--Armageddon Rain
local timerShadReflectionEruptingCD	= mod:NewCDTimer(35, 236710, 243160, nil, nil, 3)--Shortname : erupting souls
--Intermission: Eternal Flame
local timerTransition				= mod:NewPhaseTimer(57.9)
local timerFocusedDreadflameCD		= mod:NewCDCountTimer(31, 238502, nil, nil, nil, 3)
local timerBurstingDreadflameCD		= mod:NewCDCountTimer(31, 238430, nil, nil, nil, 3)
--Stage Two: Reflected Souls
local timerHopelessness				= mod:NewCastTimer(8, 237725, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerShadReflectionWailingCD	= mod:NewCDTimer(35, 236378, 236075, nil, nil, 3)--Shortname : wailing souls
--Intermission: Deceiver's Veil
local timerSightlessGaze			= mod:NewBuffActiveTimer(20, 241721, nil, nil, nil, 5)
--Stage Three: Darkness of A Thousand Souls
local timerDarknessofSoulsCD		= mod:NewCDCountTimer(90, 238999, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerTearRiftCD				= mod:NewCDCountTimer(95, 243982, nil, nil, nil, 3)
local timerFlamingOrbCD				= mod:NewCDCountTimer(30, 239253, nil, nil, nil, 3)
local timerObeliskCD				= mod:NewCDCountTimer(42, 239785, nil, nil, nil, 3)
local timerObelisk					= mod:NewCastTimer(13, 239785, L.Obelisklasers, nil, nil, 3)

local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: The Betrayer
local countdownSingularity			= mod:NewCountdown(50, 235059, nil, nil, 5)
local countdownArmageddon			= mod:NewCountdown("Alt25", 240910, false)
local countdownFocusedDread			= mod:NewCountdown("AltTwo", 238502)
local countdownFelclaws				= mod:NewCountdown("Alt25", 239932, "Tank", 2)

--Stage One: The Betrayer
local voiceFelclaws					= mod:NewVoice(239932)--tauntboss
local voiceRupturingSingularity		= mod:NewVoice(235059)--carefly
local voiceArmageddon				= mod:NewVoice(240910)--helpsoak
local voiceSRWailing				= mod:NewVoice(236378)--targetyou (temp, more customized after seen)
local voiceSRErupting				= mod:NewVoice(236710)--targetyou (temp, more customized after seen)
--Intermission: Eternal Flame
local voiceFocusedDreadflame		= mod:NewVoice(238502)--helpsoak/range5/targetyou
local voiceBurstingDreadFlame		= mod:NewVoice(238430)--scatter
--Stage Two: Reflected Souls
local voiceSRHopeless				= mod:NewVoice(237590)--targetyou (temp, more customized after seen)
local voiceSRMalignant				= mod:NewVoice(236498)--targetyou (temp, more customized after seen)
local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt", nil, 2)--kickcast
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local voiceDarknesofSouls			= mod:NewVoice(238999)--findshelter
local voiceObelisk					= mod:NewVoice(239785)--farfromline
local voiceFlameOrbSpawn			= mod:NewVoice(239253)--watchstep/runout

mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
mod:AddSetIconOption("SetIconOnBurstingDread", 238430, true)
mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("5/10")--238502/239253

mod.vb.phase = 1
mod.vb.shadowSoulsRemaining = 5--Need real number
mod.vb.armageddonCast = 0
mod.vb.focusedDreadCast = 0
mod.vb.burstingDreadCast = 0
mod.vb.burstingDreadIcon = 2
mod.vb.singularityCount = 0
mod.vb.felClawsCount = 0
mod.vb.orbCount = 0
mod.vb.darknessCount = 0
mod.vb.riftCount = 0
mod.vb.lastTankHit = "None"
mod.vb.clawCount = 0
mod.vb.obeliskCount = 0
local riftName, gravitySqueezeBuff = GetSpellInfo(239130), GetSpellInfo(239154)
local phase2NormalArmageddonTimers = {55, 45, 31}
local phase2HeroicArmageddonTimers = {55, 75, 35, 30}
local phase2NormalBurstingTimers = {57, 44}--Not used yet, needs more data to verify and improve
local phase2HeroicBurstingTimers = {57, 47, 55}--Not used yet, needs more data to verify and improve
local phase2NormalFocusedTimers = {81.5}--Not used yet, needs more data to verify and improve
local phase2HeroicFocusedTimers = {35, 45, 53, 46}
local phase2HeroicSingularityTimers = {79, 26, 55, 44}
local playerName = UnitName("player")

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

--https://www.warcraftlogs.com/reports/CTMzhXkF6W3majct#fight=5&pins=2%24Off%24%23244F4B%24expression%24ability.name%20%3D%20%22Demonic%20Obelisk%22%20or%20ability.id%20%3D%20238999%20and%20type%20%3D%20%22begincast%22&view=events
--https://www.warcraftlogs.com/reports/CTMzhXkF6W3majct#fight=17&pins=2%24Off%24%23244F4B%24expression%24ability.name%20%3D%20%22Demonic%20Obelisk%22%20or%20ability.id%20%3D%20238999%20and%20type%20%3D%20%22begincast%22&view=events
local function ObeliskWarning(self)
	self.vb.obeliskCount = self.vb.obeliskCount + 1
	specWarnObelisk:Show(self.vb.obeliskCount)
	voiceObelisk:Play("farfromline")
	timerObelisk:Start()
	if self.vb.obeliskCount % 2 == 0 then
		timerObeliskCD:Start(36, self.vb.obeliskCount+1)
		self:Schedule(36, ObeliskWarning, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.armageddonCast = 0
	self.vb.focusedDreadCast = 0
	self.vb.burstingDreadCast = 0
	self.vb.singularityCount = 0
	self.vb.felClawsCount = 0
	self.vb.orbCount = 0
	self.vb.darknessCount = 0
	self.vb.riftCount = 0
	self.vb.lastTankHit = "None"
	self.vb.clawCount = 0
	self.vb.obeliskCount = 0
	timerArmageddonCD:Start(10-delay, 1)
	countdownArmageddon:Start(10-delay)
	if not self:IsEasy() then
		timerShadReflectionEruptingCD:Start(21-delay)--Erupting
	end
	timerFelclawsCD:Start(25-delay, 1)
	countdownFelclaws:Start(25-delay)
	timerRupturingSingularityCD:Start(58-delay, 1)
	berserkTimer:Start(600-delay)
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
	if spellId == 237725 and self:AntiSpam(5, 2) then--Assume they all spawn/begin casting at same time
		timerHopelessness:Start()
	elseif spellId == 238999 then
		self.vb.darknessCount = self.vb.darknessCount + 1
		if self.vb.darknessCount == 1 then--No rift yet, stack with group
			specWarnDarknessofSouls:Show(GROUP)
			self:Schedule(25, ObeliskWarning, self)
			timerObeliskCD:Start(25, 1)
		else--Move to rift
			specWarnDarknessofSouls:Show(riftName)
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(DBM_NO_DEBUFF:format(DBM_CORE_SAFE))
				DBM.InfoFrame:Show(10, "playergooddebuff", gravitySqueezeBuff)
			end
			self:Schedule(28.5, ObeliskWarning, self)
			timerObeliskCD:Start(28.5, self.vb.obeliskCount+1)
		end
		voiceDarknesofSouls:Play("findshelter")
		timerDarknessofSoulsCD:Start(nil, self.vb.darknessCount+1)
	elseif spellId == 243982 then
		self.vb.riftCount = self.vb.riftCount + 1
		warnTearRift:Show(self.vb.riftCount)
		timerTearRiftCD:Start(nil, self.vb.riftCount+1)
	elseif spellId == 240910 then--Armageddon.
		self.vb.armageddonCast = self.vb.armageddonCast + 1
		specWarnArmageddon:Show(self.vb.armageddonCast)
		voiceArmageddon:Play("helpsoak")
		timerArmageddon:Start()
		if self.vb.phase == 1.5 then
			if self.vb.armageddonCast < 2 then
				if self:IsEasy() then
					timerArmageddonCD:Start(28, self.vb.armageddonCast+1)
					countdownArmageddon:Start(28)
				else
					timerArmageddonCD:Start(30, self.vb.armageddonCast+1)
					countdownArmageddon:Start(30)
				end
			end
		elseif self.vb.phase == 2 then
			local timer = self:IsNormal() and phase2NormalArmageddonTimers[self.vb.armageddonCast+1] or self:IsHeroic() and phase2HeroicArmageddonTimers[self.vb.armageddonCast+1]
			if timer then
				timerArmageddonCD:Start(timer, self.vb.armageddonCast+1)
				countdownArmageddon:Start(timer)
			end
		else--Phase 1
			timerArmageddonCD:Start(64, self.vb.armageddonCast+1)
			countdownArmageddon:Start(64)
		end
	elseif spellId == 239932 then
		self.vb.clawCount = 0
		self.vb.felClawsCount = self.vb.felClawsCount + 1
		--Special snow flake (https://www.warcraftlogs.com/reports/xntG1J4r7MmwAPqB#fight=3&type=summary&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20238502%20or%20ability.id%20%3D%20237725%20or%20ability.id%20%3D%20238999%20or%20ability.id%20%3D%20243982%20or%20ability.id%20%3D%20240910%20or%20ability.id%20%3D%20241983)%20and%20type%20%3D%20%22begincast%22%0A%20or%20(ability.id%20%3D%20239932%20or%20ability.id%20%3D%20235059%20or%20ability.id%20%3D%20238502%20or%20ability.id%20%3D%20239785%20or%20ability.id%20%3D%20236378%20or%20ability.id%20%3D%20236710%20or%20ability.id%20%3D%20237590%20or%20ability.id%20%3D%20236498%20or%20ability.id%20%3D%20238430)%20and%20type%20%3D%20%22cast%22%0A%20or%20ability.id%20%3D%20244834%20and%20type%20%3D%20%22applybuff%22%20or%20(ability.id%20%3D%20241983%20or%20ability.id%20%3D%20244834)%20and%20type%20%3D%20%22removebuff%22%0A%20or%20ability.name%20%3D%20%22Rupturing%20Singularity%22%20and%20target.name%20%3D%20%22Omegal%22&view=events)
		--TODO, see if this happens more than once (8th claw, etc)
		if self.vb.phase == 3 and self.vb.felClawsCount == 4 then
			timerFelclawsCD:Start(20, self.vb.felClawsCount+1)
			countdownFelclaws:Start(20)
		else
			timerFelclawsCD:Start(24, self.vb.felClawsCount+1)
			countdownFelclaws:Start()
		end
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnFelclaws:Show()
			voiceFelclaws:Play("defensive")
		end
	elseif spellId == 241983 and self.vb.phase < 2.5 then--Deceiver's Veil
		timerFelclawsCD:Stop()
		countdownFelclaws:Cancel()
		timerFocusedDreadflameCD:Stop()
		countdownFocusedDread:Cancel()
		timerBurstingDreadflameCD:Stop()
		timerArmageddonCD:Stop()
		countdownArmageddon:Cancel()
		timerShadReflectionEruptingCD:Stop()
		timerShadReflectionWailingCD:Stop()
		self.vb.phase = 2.5
		self.vb.shadowSoulsRemaining = 5--Normal count anyways
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		timerShadReflectionWailingCD:Start(112)
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if self.vb.phase == 2 then
			timerShadReflectionEruptingCD:Start(112)--Erupting
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)

	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)

	elseif spellId == 238502 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnFocusedDread then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 238430 then
		if self:AntiSpam(2, 5) then
			self.vb.burstingDreadCast = self.vb.burstingDreadCast + 1
			self.vb.burstingDreadIcon = 2
			if self.vb.phase == 1.5 then
				if self.vb.burstingDreadCast < 2 then
					if self:IsEasy() then
						timerBurstingDreadflameCD:Start(44, 2)
					else
						timerBurstingDreadflameCD:Start(47, 2)--Delayed by singularity which doesn't happen on normal/LFR
					end
				else--After second time he casts it in 1.5, he begins to land
					self.vb.phase = 2
					self.vb.armageddonCast = 0
					self.vb.focusedDreadCast = 0
					self.vb.burstingDreadCast = 0
					self.vb.singularityCount = 0
					self.vb.felClawsCount = 0
					warnPhase2:Schedule(5)
					timerFelclawsCD:Start(14, 1)
					countdownFelclaws:Start(14)
					timerShadReflectionEruptingCD:Start(17)--Erupting
					timerArmageddonCD:Start(55, 1)
					countdownArmageddon:Start(55)
					timerBurstingDreadflameCD:Start(57.3, 1)
					timerRupturingSingularityCD:Start(79, 1)
					if self:IsEasy() then
						timerFocusedDreadflameCD:Start(81.5, 1)
						countdownFocusedDread:Start(81.5)
					else
						timerFocusedDreadflameCD:Start(35, 1)
						countdownFocusedDread:Start(35)
						timerShadReflectionWailingCD:Start(53)
					end
				end
			elseif self.vb.phase == 2 then
				timerBurstingDreadflameCD:Start(48, self.vb.burstingDreadCast+1)
			else--Phase 3, seems 25 across board here
				if self.vb.burstingDreadCast % 2 == 0 then
					timerBurstingDreadflameCD:Start(70, self.vb.burstingDreadCast+1)
				else
					timerBurstingDreadflameCD:Start(25, self.vb.burstingDreadCast+1)
				end
			end
		end
		warnBurstingDreadFlame:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBurstingDreadflame:Show()
			voiceBurstingDreadFlame:Play("scatter")
			yellBurstingDreadflame:Yell(self.vb.burstingDreadIcon, args.spellName, self.vb.burstingDreadIcon)
		end
		if self.Options.SetIconOnBurstingDread then
			self:SetIcon(args.destName, self.vb.burstingDreadIcon, 5)
		end
		self.vb.burstingDreadIcon = self.vb.burstingDreadIcon + 1
	elseif spellId == 238999 then
		warnDarknessofStuffEnded:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 245509 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			self.vb.lastTankHit = args.destName
		end
		if self:AntiSpam(0.5, 6) then
			self.vb.clawCount = self.vb.clawCount + 1
		end
		if self.vb.clawCount == 5 then
			if (self.vb.lastTankHit ~= playerName) and self:AntiSpam(3, self.vb.lastTankHit) then
				specWarnFelclawsOther:Show(self.vb.lastTankHit)
				voiceFelclaws:Play("tauntboss")
			end
		end
	elseif spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			specWarnSRWailing:Show()
			voiceSRWailing:Play("targetyou")
			yellSRWailing:Countdown(7)
		else
			warnWailingReflection:Show(args.destName)
		end
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		warnEruptingRelections:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSRErupting:Show()
			voiceSRErupting:Play("targetyou")
			yellSRErupting:Countdown(8)
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRHopeless:Show()
			voiceSRHopeless:Play("targetyou")
			yellSRHopeless:Countdown(8)
		end
	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRMalignant:Show()
			voiceSRMalignant:Play("targetyou")
			yellSRMalignant:Countdown(8)
		end
	elseif spellId == 236597 then
		if self:CheckInterruptFilter(args.destGUID) then
			specWarnMalignantAnguish:Show(args.destName)
			voiceMalignantAnguish:Play("kickcast")
		end
	elseif spellId == 241721 and args:IsPlayer() then
		timerSightlessGaze:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			yellSRWailing:Cancel()
		end
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			yellSRErupting:Cancel()
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			yellSRHopeless:Cancel()
		end
	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			yellSRMalignant:Cancel()
		end
	elseif spellId == 241721 and args:IsPlayer() then
		timerSightlessGaze:Stop()
	elseif spellId == 239932 then--Felclaws ended
		if (self.vb.lastTankHit ~= playerName) and self:AntiSpam(3, self.vb.lastTankHit) then
			specWarnFelclawsOther:Show(self.vb.lastTankHit)
			voiceFelclaws:Play("tauntboss")
		end
	elseif spellId == 241983 and self:IsInCombat() then--Deceiver's Veil
		self.vb.phase = 3
		self.vb.armageddonCast = 0
		self.vb.focusedDreadCast = 0
		self.vb.burstingDreadCast = 0
		self.vb.felClawsCount = 0
		--timerDarknessofSoulsCD:Start(1, 1)--Cast intantly
		warnPhase3:Show()
		timerTearRiftCD:Start(14, 1)
		if not self:IsEasy() then
			timerFlamingOrbCD:Start(30, 1)
		end
		timerBurstingDreadflameCD:Start(44, 1)--Review on Heroic
		timerFocusedDreadflameCD:Start(80, 1)
		countdownFocusedDread:Start(80)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then
		self.vb.focusedDreadCast = self.vb.focusedDreadCast + 1
		if self.vb.phase == 1.5 then
			if self.vb.focusedDreadCast < 2 then
				timerFocusedDreadflameCD:Start(12, 2)
				countdownFocusedDread:Start(12)
			end
		elseif self.vb.phase == 2 then
			local timer = self:IsHeroic() and phase2HeroicFocusedTimers[self.vb.focusedDreadCast+1]
			if timer then
				timerFocusedDreadflameCD:Start(timer, self.vb.focusedDreadCast+1)
				countdownFocusedDread:Start(timer)
			end
		else--Phase 3
			timerFocusedDreadflameCD:Start(95)
			countdownFocusedDread:Start(95)
		end
		if not self:IsEasy() then--TODO, this isn't mentioned in intermission, only in phase 2+ version. Investigate
			voiceFocusedDreadflame:Schedule(1, "range5")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
		local target = DBM:GetUnitFullName(target)
		if target then
			if target == UnitName("player") then
				specWarnFocusedDreadflame:Show()
				voiceFocusedDreadflame:Play("targetyou")
				yellFocusedDreadflame:Yell()
				yellFocusedDreadflameFades:Countdown(5)
			else
				specWarnFocusedDreadflameOther:Show(target)
				voiceFocusedDreadflame:Play("helpsoak")
			end
			if self.Options.SetIconOnFocusedDread then
				self:SetIcon(target, 1)
			end
		end
	elseif msg:find("spell:235059") then
		self.vb.singularityCount = self.vb.singularityCount + 1
		specWarnRupturingSingularity:Show()
		voiceRupturingSingularity:Play("carefly")
		timerRupturingSingularity:Start(9.7)
		countdownSingularity:Start(9.7)
		if self.vb.phase == 1.5 then
			if self.vb.singularityCount == 1 then
				timerRupturingSingularityCD:Start(30, self.vb.singularityCount+1)
			end
		elseif self.vb.phase == 2 then
			local timer = phase2HeroicSingularityTimers[self.vb.singularityCount+1]--Split difficulties up if they aren't all same
			if timer then
				timerRupturingSingularityCD:Start(timer, self.vb.singularityCount+1)
			end
		else--Phase 1
			if self:IsEasy() then
				timerRupturingSingularityCD:Start(80, self.vb.singularityCount+1)
			else
				timerRupturingSingularityCD:Start(55, self.vb.singularityCount+1)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then--Shadowsoul
		--Do more with when 5 count confirmed in more difficulties or all normal sizes
		self.vb.shadowSoulsRemaining = self.vb.shadowSoulsRemaining - 1
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 242377 then--Kil'jaeden Take Off Sound (intermission 1)
		self.vb.phase = 1.5
		self.vb.armageddonCast = 0
		self.vb.focusedDreadCast = 0
		self.vb.burstingDreadCast = 0
		self.vb.singularityCount = 0
		timerFelclawsCD:Stop()
		countdownFelclaws:Cancel()
		timerRupturingSingularityCD:Stop()
		timerArmageddonCD:Stop()
		countdownArmageddon:Cancel()
		timerShadReflectionEruptingCD:Stop()
		timerArmageddonCD:Start(7.5, 1)
		countdownArmageddon:Start(7.5)
		timerBurstingDreadflameCD:Start(8.7, 1)
		if not self:IsEasy() then
			timerRupturingSingularityCD:Start(14.7, 1)
		end
		timerFocusedDreadflameCD:Start(24.7, 1)
		countdownFocusedDread:Start(24.7)
		timerTransition:Start(57.9)
	elseif spellId == 244856 and self:AntiSpam(5, 3) then--Flaming Orb (more likely than combat log. this spell looks like it's entirely scripted)
		self.vb.orbCount = self.vb.orbCount + 1
		specWarnFlamingOrbSpawn:Show(self.vb.orbCount)
		voiceFlameOrbSpawn:Play("watchstep")
		voiceFlameOrbSpawn:Schedule(1, "runout")
		if self.vb.orbCount % 2 == 0 then
			timerFlamingOrbCD:Start(64, self.vb.orbCount+1)
		else
			timerFlamingOrbCD:Start(31, self.vb.orbCount+1)
		end
	end
end
