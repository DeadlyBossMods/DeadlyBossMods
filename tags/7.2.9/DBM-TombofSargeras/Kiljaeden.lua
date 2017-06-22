local mod	= DBM:NewMod(1898, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(108573)--121227 Illiden? 121193 Shadowsoul
mod:SetEncounterID(2051)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(16288)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 237725 238999 243982 240910 241983",
	"SPELL_CAST_SUCCESS 239932 236378 236710 237590 236498 238502 238430 238999",
	"SPELL_AURA_APPLIED 239932 236378 236710 237590 236498 236597 241721",
	"SPELL_AURA_APPLIED_DOSE 239932",
	"SPELL_AURA_REMOVED 236378 236710 237590 236498 241721",
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
--[[
(ability.id = 238502 or ability.id = 237725 or ability.id = 238999 or ability.id = 243982 or ability.id = 240910 or ability.id = 241983) and type = "begincast"
 or (ability.id = 239932 or ability.id = 235059 or ability.id = 238502 or ability.id = 239785 or ability.id = 236378 or ability.id = 236710 or ability.id = 237590 or ability.id = 236498 or ability.id = 238430) and type = "cast"
 or ability.name = "Rupturing Singularity" and target.name = "Omegal"
 --]]
--Intermission: Eternal Flame
local warnBurstingDreadFlame		= mod:NewTargetAnnounce(238430, 2)--Generic for now until more known, likely something cast fairly often
--Stage Two:
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
--Stage Three: Darkness of A Thousand Souls
local warnTearRift					= mod:NewSpellAnnounce(243982, 2)--Positive message color?
local warnDarknessofStuff			= mod:NewEndAnnounce(238999, 1)

--Stage One: The Betrayer
local specWarnFelclaws				= mod:NewSpecialWarningStack(239932, nil, 2, nil, nil, 1, 2)
local specWarnFelclawsOther			= mod:NewSpecialWarningTaunt(239932, nil, nil, nil, 1, 2)
local specWarnRupturingSingularity	= mod:NewSpecialWarningMoveTo(235059, nil, nil, nil, 2, 2)
local specWarnArmageddon			= mod:NewSpecialWarningSpell(240910, nil, nil, nil, 2, 2)
local specWarnSRWailing				= mod:NewSpecialWarningYou(236378, nil, nil, nil, 1, 2)
local yellSRWailing					= mod:NewFadesYell(236378)
local specWarnSRErupting			= mod:NewSpecialWarningYou(236710, nil, nil, nil, 1, 2)
local yellSRErupting				= mod:NewFadesYell(236710)
--Intermission: Eternal Flame
local specWarnFocusedDreadflame		= mod:NewSpecialWarningYou(238502, nil, nil, nil, 1, 2)
local yellFocusedDreadflame			= mod:NewYell(238502)
local specWarnFocusedDreadflameOther= mod:NewSpecialWarningTarget(238502, nil, nil, nil, 1, 2)
local specWarnBurstingDreadflame	= mod:NewSpecialWarningMoveAway(238430, nil, nil, nil, 1, 2)
local yellBurstingDreadflame		= mod:NewYell(238430)
--Stage Two: Reflected Souls
local specWarnSRHopeless			= mod:NewSpecialWarningYou(237590, nil, nil, nil, 1, 2)
local yellSRHopeless				= mod:NewFadesYell(237590)
local specWarnSRMalignant			= mod:NewSpecialWarningYou(236498, nil, nil, nil, 1, 2)
local yellSRMalignant				= mod:NewFadesYell(236498)
local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local specWarnDarknessofSouls		= mod:NewSpecialWarningMoveTo(238999, nil, nil, nil, 3, 2)
local specWarnFlamingOrbSpawn		= mod:NewSpecialWarningSpell(239253, nil, nil, nil, 1, 2)--Spawn warning (todo, another warning for fixate target if possible)

--Stage One: The Betrayer
local timerFelclawsCD				= mod:NewCDTimer(25, 239932, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRupturingSingularityCD	= mod:NewCDTimer(61, 235059, nil, nil, nil, 3)--61-68?
local timerArmageddonCD				= mod:NewCDTimer(42, 240910, nil, nil, nil, 5)--
local timerShadowReflectionCD		= mod:NewCDTimer(35, "ej15238", nil, nil, nil, 3, 236378)--Wailing icon used.
--Intermission: Eternal Flame
local timerTransition				= mod:NewPhaseTimer(57.9)
local timerFocusedDreadflameCD		= mod:NewCDTimer(31, 238502, nil, nil, nil, 3)
local timerBurstingDreadflameCD		= mod:NewCDTimer(31, 238430, nil, nil, nil, 3)
--Stage Two: Reflected Souls
local timerHopelessness				= mod:NewCastTimer(8, 237725, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
--Intermission: Deceiver's Veil
local timerSightlessGaze			= mod:NewBuffActiveTimer(20, 241721, nil, nil, nil, 5)
--Stage Three: Darkness of A Thousand Souls
local timerDarknessofSoulsCD		= mod:NewCDTimer(90, 238999, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerTearRiftCD				= mod:NewCDTimer(95, 243982, nil, nil, nil, 3)
local timerFlamingOrbCD				= mod:NewAITimer(31, 239253, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage One: The Betrayer
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Stage One: The Betrayer
local voiceFelclaws					= mod:NewVoice(239932)--tauntboss
local voiceRupturingSingularity		= mod:NewVoice(235059)--watchstep
local voiceArmageddon				= mod:NewVoice(240910)--helpsoak
local voiceSRWailing				= mod:NewVoice(236378)--targetyou (temp, more customized after seen)
local voiceSRErupting				= mod:NewVoice(236710)--targetyou (temp, more customized after seen)
--Intermission: Eternal Flame
local voiceFocusedDreadflame		= mod:NewVoice(238502)--helpsoak/range5/targetyou
local voiceBurstingDreadFlame		= mod:NewVoice(238430)--scatter
--Stage Two: Reflected Souls
local voiceSRHopeless				= mod:NewVoice(237590)--targetyou (temp, more customized after seen)
local voiceSRMalignant				= mod:NewVoice(236498)--targetyou (temp, more customized after seen)
local voiceMalignantAnguish			= mod:NewVoice(236597)--kickcast
--Intermission: Deceiver's Veil

--Stage Three: Darkness of A Thousand Souls
local voiceDarknesofSouls			= mod:NewVoice(238999)--findshelter

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
local shelterName, gravitySqueezeBuff = GetSpellInfo(239130), GetSpellInfo(239154)
local phase2NormalArmageddonTimers = {55, 45, 31}
local phase2HeroicArmageddonTimers = {55, 75, 35}
local phase2NormalBurstingTimers = {57, 44}--Not used yet, needs more data to verify and improve
local phase2HeroicBurstingTimers = {57, 47, 55}--Not used yet, needs more data to verify and improve
local phase2NormalFocusedTimers = {81.5}--Not used yet, needs more data to verify and improve
local phase2HeroicFocusedTimers = {35, 45, 53, 46}

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

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.armageddonCast = 0
	self.vb.focusedDreadCast = 0
	self.vb.burstingDreadCast = 0
	timerArmageddonCD:Start(10-delay, 1)
	if not self:IsEasy() then
		timerShadowReflectionCD:Start(21-delay)--Erupting
	end
	timerFelclawsCD:Start(26-delay)
	timerRupturingSingularityCD:Start(58-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 237725 and self:AntiSpam(5, 2) then--Assume they all spawn/begin casting at same time
		timerHopelessness:Start()
	elseif spellId == 238999 then
		specWarnDarknessofSouls:Show(shelterName)
		voiceDarknesofSouls:Play("findshelter")
		timerDarknessofSoulsCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_NO_DEBUFF:format(gravitySqueezeBuff))
			DBM.InfoFrame:Show(10, "playergooddebuff", gravitySqueezeBuff)
		end
	elseif spellId == 243982 then
		warnTearRift:Show()
		timerTearRiftCD:Start()
	elseif spellId == 240910 then--Armageddon.
		self.vb.armageddonCast = self.vb.armageddonCast + 1
		specWarnArmageddon:Show()
		voiceArmageddon:Play("helpsoak")
		if self.vb.phase == 1.5 then
			if self.vb.armageddonCast < 2 then
				timerArmageddonCD:Start(28, self.vb.armageddonCast+1)
			end
		elseif self.vb.phase == 2 then
			local timer = self:IsNormal() and phase2NormalArmageddonTimers[self.vb.armageddonCast+1] or self:IsHeroic() and phase2HeroicArmageddonTimers[self.vb.armageddonCast+1]
			if timer then
				timerArmageddonCD:Start(timer, self.vb.armageddonCast+1)
			end
		end
	elseif spellId == 241983 and self.vb.phase < 2.5 then--Deceiver's Veil
		timerFelclawsCD:Stop()
		timerFocusedDreadflameCD:Stop()
		timerBurstingDreadflameCD:Stop()
		timerArmageddonCD:Stop()
		timerShadowReflectionCD:Stop()--Stop erupting and wailing when split
		self.vb.phase = 2.5
		self.vb.shadowSoulsRemaining = 5--Normal count anyways
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 239932 then
		timerFelclawsCD:Start()
	elseif spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if self.vb.phase == 2 then
			timerShadowReflectionCD:Start(112)--Erupting
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
					timerBurstingDreadflameCD:Start(44)--44 on normal 47 on heroic?
				else--After second time he casts it in 1.5, he begins to land
					self.vb.phase = 2
					self.vb.armageddonCast = 0
					self.vb.focusedDreadCast = 0
					self.vb.burstingDreadCast = 0
					warnPhase2:Schedule(5)
					timerFelclawsCD:Start(15)
					timerShadowReflectionCD:Start(17)--Erupting
					timerArmageddonCD:Start(55.3, 1)
					timerBurstingDreadflameCD:Start(57.3, 1)
					if self:IsEasy() then
						timerFocusedDreadflameCD:Start(81.5, 1)
					else
						timerFocusedDreadflameCD:Start(35, 1)
					end
				end
			elseif self.vb.phase == 2 then
				timerBurstingDreadflameCD:Start(48, self.vb.burstingDreadCast+1)
			else--Phase 3, seems 25 across board here
				timerBurstingDreadflameCD:Start(25, self.vb.burstingDreadCast+1)
			end
		end
		warnBurstingDreadFlame:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBurstingDreadflame:Show()
			voiceBurstingDreadFlame:Play("scatter")
			yellBurstingDreadflame:Yell()
		end
		if self.Options.SetIconOnBurstingDread then
			self:SetIcon(args.destName, self.vb.burstingDreadIcon, 5)
		end
		self.vb.burstingDreadIcon = self.vb.burstingDreadIcon + 1
	elseif spellId == 238999 then
		warnDarknessofStuff:Show()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239932 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--timerFelclaws:Start(args.destName)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnFelclaws:Show(amount)
					voiceFelclaws:Play("stackhigh")
				else
					if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnFelclawsOther:Show(args.destName)
						voiceFelclaws:Play("tauntboss")
					end
				end
			end
		end
	elseif spellId == 236378 then--Wailing Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			specWarnSRWailing:Show()
			voiceSRWailing:Play("targetyou")
			yellSRWailing:Schedule(4, 3)
			yellSRWailing:Schedule(5, 2)
			yellSRWailing:Schedule(6, 1)
		end
	elseif spellId == 236710 then--Erupting Shadow Reflection (Stage 1)
		if args:IsPlayer() then
			specWarnSRErupting:Show()
			voiceSRErupting:Play("targetyou")
			yellSRErupting:Schedule(5, 3)
			yellSRErupting:Schedule(6, 2)
			yellSRErupting:Schedule(7, 1)
		end
	elseif spellId == 237590 then--Hopeless Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRHopeless:Show()
			voiceSRHopeless:Play("targetyou")
			yellSRHopeless:Schedule(5, 3)
			yellSRHopeless:Schedule(6, 2)
			yellSRHopeless:Schedule(7, 1)
		end
	elseif spellId == 236498 then--Malignant Shadow Reflection (Stage 2)
		if args:IsPlayer() then
			specWarnSRMalignant:Show()
			voiceSRMalignant:Play("targetyou")
			yellSRMalignant:Schedule(5, 3)
			yellSRMalignant:Schedule(6, 2)
			yellSRMalignant:Schedule(7, 1)
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
				timerFocusedDreadflameCD:Start(12)
			end
		elseif self.vb.phase == 2 then
			local timer = self:IsHeroic() and phase2HeroicFocusedTimers[self.vb.focusedDreadCast+1]
			if timer then
				timerFocusedDreadflameCD:Start(timer, self.vb.focusedDreadCast+1)
			end
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
			else
				specWarnFocusedDreadflameOther:Show(target)
				voiceFocusedDreadflame:Play("helpsoak")
			end
			if self.Options.SetIconOnFocusedDread then
				self:SetIcon(target, 1)
			end
		end
	elseif msg:find("spell:235059") then
		specWarnRupturingSingularity:Show()
		voiceRupturingSingularity:Play("watchstep")
		timerRupturingSingularityCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then--Shadowsoul
		--Do more with when 5 count confirmed in more difficulties or all normal sizes
		self.vb.shadowSoulsRemaining = self.vb.shadowSoulsRemaining - 1
	end
end

function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if (cid == 108573) and UnitExists(uId) and self.vb.phase < 3 then--Boss becoming targetable again after illiden phase
		self.vb.phase = 3
		self.vb.armageddonCast = 0
		self.vb.focusedDreadCast = 0
		self.vb.burstingDreadCast = 0
		--timerDarknessofSoulsCD:Start(1)--Cast intantly
		timerTearRiftCD:Start(14)
		timerBurstingDreadflameCD:Start(44, 1)
		timerFocusedDreadflameCD:Start(80, 1)
		timerFlamingOrbCD:Start(1)
		self:UnregisterShortTermEvents()
	end
end	

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 242377 then--Kil'jaeden Take Off Sound (intermission 1)
		self.vb.phase = 1.5
		self.vb.armageddonCast = 0
		self.vb.focusedDreadCast = 0
		self.vb.burstingDreadCast = 0
		timerFelclawsCD:Stop()
		timerRupturingSingularityCD:Stop()
		timerArmageddonCD:Stop()
		timerShadowReflectionCD:Stop()
		timerArmageddonCD:Start(7.5, 1)
		timerBurstingDreadflameCD:Start(8.7, 1)
		timerFocusedDreadflameCD:Start(24.7, 1)
		timerTransition:Start(57.9)
	elseif spellId == 242902 then--Kil'jaden Intro Conversation (not my typo, blizz spelled their own npc wrong)
		
	elseif spellId == 239254 and self:AntiSpam(5, 3) then--Flaming Orb (more likely than combat log. this spell looks like it's entirely scripted)
		specWarnFlamingOrbSpawn:Show()
		timerFlamingOrbCD:Start()
	end
end
