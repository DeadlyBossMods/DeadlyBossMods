local mod	= DBM:NewMod(1873, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116939)--Maiden of Valor 120437
mod:SetEncounterID(2038)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(16307)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 239207 239132 235572 233856 233556 240623 235597",
	"SPELL_CAST_SUCCESS 236494 233556",
	"SPELL_AURA_APPLIED 234059 236494 240728 239739 241008",
	"SPELL_AURA_APPLIED_DOSE 236494 240728 241008",
	"SPELL_AURA_REMOVED 239739",
	"SPELL_PERIODIC_DAMAGE 239212",
	"SPELL_PERIODIC_MISSED 239212",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

--[[
(ability.id = 239207 or ability.id = 239132 or ability.id = 236571 or ability.id = 233856 or ability.id = 233556 or ability.id = 240623 or ability.id = 239418 or ability.id = 235597 or ability.id = 235572) and type = "begincast" or
(ability.id = 236571 or ability.id = 236494) and type = "cast" or
(ability.id = 234009 or ability.id = 234059 or ability.id = 239739) and type = "applydebuff"
 or ability.name = "Shadowy Blades"
--]]
--Stage One: A Slumber Disturbed
local warnUnboundChaos				= mod:NewTargetAnnounce(234059, 3, nil, false, 2)
local warnShadowyBlades				= mod:NewTargetAnnounce(236571, 3)
local warnDesolate					= mod:NewStackAnnounce(236494, 3, nil, "Healer|Tank")
local warnCleansingEnded			= mod:NewEndAnnounce(241008, 1)
local warnTaintedMatrix				= mod:NewCastAnnounce(240623, 3)
--Stage Two: An Avatar Awakened
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnDarkmark					= mod:NewTargetCountAnnounce(239739, 3)

--Stage One: A Slumber Disturbed
local specWarnTouchofSargerasGround	= mod:NewSpecialWarningCount(239207, "-Tank", nil, 2, 1, 2)
local specWarnRuptureRealities		= mod:NewSpecialWarningRun(239132, nil, nil, nil, 4, 2)
local specWarnUnboundChaos			= mod:NewSpecialWarningDodge(234059, nil, nil, nil, 2, 2)
local yellUnboundChaos				= mod:NewYell(234059, nil, false, 2)
local specWarnShadowyBlades			= mod:NewSpecialWarningMoveAway(236571, nil, nil, nil, 1, 2)
local yellShadowyBlades				= mod:NewPosYell(236571)
local specWarnLingeringDarkness		= mod:NewSpecialWarningMove(239212, nil, nil, nil, 1, 2)
local specWarnDesolateYou			= mod:NewSpecialWarningStack(236494, nil, 2, nil, nil, 1, 6)
local specWarnDesolateOther			= mod:NewSpecialWarningTaunt(236494, nil, nil, nil, 1, 2)
----Maiden of Valor
local specWarnCorruptedMatrix		= mod:NewSpecialWarningMoveTo(233556, "Tank", nil, nil, 1, 7)
local specWarnCleansingProtocol		= mod:NewSpecialWarningSwitch(233856, "-Healer", nil, nil, 3, 2)
local specWarnTaintedEssence		= mod:NewSpecialWarningStack(240728, nil, 6, nil, nil, 1, 6)
local yellTaintedEssence			= mod:NewShortFadesYell(240728)
--Stage Two: An Avatar Awakened
local specWarnDarkMark				= mod:NewSpecialWarningYouPos(239739, nil, nil, nil, 1, 2)
local specWarnDarkMarkOther			= mod:NewSpecialWarningMoveTo(239739, nil, nil, nil, 1, 2)
local yellDarkMark					= mod:NewPosYell(239739, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local yellDarkMarkFades				= mod:NewIconFadesYell(239739)
local specWarnRainoftheDestroyer	= mod:NewSpecialWarningCount(240396, nil, nil, 2, 3, 2)

--Stage One: A Slumber Disturbed
local timerRP						= mod:NewRPTimer(41)
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerTouchofSargerasCD		= mod:NewCDCountTimer(42, 239207, nil, nil, nil, 3)--42+
local timerRuptureRealitiesCD		= mod:NewCDCountTimer(60, 239132, nil, nil, nil, 2)
local timerUnboundChaosCD			= mod:NewCDCountTimer(35, 234059, nil, nil, nil, 3)--35-60 (lovely huh?)
local timerShadowyBladesCD			= mod:NewCDTimer(30, 236571, nil, nil, nil, 3)--30-46
local timerDesolateCD				= mod:NewCDTimer(11.4, 236494, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Maiden of Valor
mod:AddTimerLine(DBM:EJ_GetSectionInfo(14713))
local timerCorruptedMatrixCD		= mod:NewNextTimer(40, 233556, nil, nil, nil, 5)
local timerCorruptedMatrix			= mod:NewCastTimer(10, 233556, nil, nil, nil, 5)
--Stage Two: An Avatar Awakened
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerDarkMarkCD				= mod:NewNextCountTimer(34, 239739, nil, nil, nil, 3)
local timerRainoftheDestroyerCD		= mod:NewNextCountTimer(35, 240396, nil, nil, nil, 3)
local timerRainoftheDestroyer		= mod:NewCastTimer(5.5, 240396, 206577, nil, nil, 3)--Shortname: Comet Impact

local berserkTimer					= mod:NewBerserkTimer(420)

--Stage One: A Slumber Disturbed
local countdownCleansingProtocol	= mod:NewCountdownFades(18, 233856)
local countdownDesolate				= mod:NewCountdown("Alt11", 236494, "Tank", nil, 3)
local countdownCorruptedMatrix		= mod:NewCountdown("AltTwo40", 233556)
--Stage Two
local countdownRuptureRealities		= mod:NewCountdown(60, 239132)
local countdownDarkMark				= mod:NewCountdown("Alt40", 239739, "-Tank", 2)
local countdownRainofthedDestroyer	= mod:NewCountdown("AltTwo35", 240396)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)

mod:AddSetIconOption("SetIconOnShadowyBlades", 236571, true)
mod:AddSetIconOption("SetIconOnDarkMark", 239739, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddRangeFrameOption(10, 236571)
local abilitiesonCD = {
	[239207] = true,--Touch of Sargeras
	[239132] = true,--Rupture Realities
	[234059] = true,--Unbound Chaos
	[236571] = true--Shadowy Blades
}

mod.vb.phase = 1
mod.vb.bladesIcon = 1
mod.vb.shieldActive = false
mod.vb.touchCast = 0
mod.vb.darkMarkCast = 0
mod.vb.chaosCount = 0
mod.vb.realityCount = 0
mod.vb.rainCount = 0
local darkMarkTargets = {}
local playerName = UnitName("player")
local beamName = DBM:GetSpellInfo(238244)
local showTouchofSarg = true

local function warnDarkMarkTargets(self, spellName)
--	table.sort(darkMarkTargets)
	warnDarkmark:Show(self.vb.darkMarkCast, table.concat(darkMarkTargets, "<, >"))
	--if self:IsLFR() then return end
	for i = 1, #darkMarkTargets do
		local icon = i == 1 and 6 or i == 2 and 4 or i == 3 and 3--Bigwigs icon compatability
		local name = darkMarkTargets[i]
		if name == playerName then
			yellDarkMark:Yell(icon, spellName, icon)
			local _, _, _, _, _, _, expires = UnitDebuff("player", spellName)
			if expires then
				local remaining = expires-GetTime()
				yellDarkMarkFades:Countdown(remaining, nil, icon)
			end
			specWarnDarkMark:Show(self:IconNumToTexture(icon))
			specWarnDarkMark:Play("targetyou")
		end
		if self.Options.SetIconOnDarkMark then
			self:SetIcon(name, icon)
		end
	end
	if not UnitDebuff("player", spellName) then
		specWarnDarkMarkOther:Show(DBM_ALLY)
		specWarnDarkMarkOther:Play("gathershare")
	end
end

local function setabilityStatus(self, spellId, status)
	if status == 1 then--Ability on cooldown
		abilitiesonCD[spellId] = true
	else--Ability ready to use
		abilitiesonCD[spellId] = false
	end
end

local updateInfoFrame
do
	local touch, rupture, unbound, shadowy, shieldName = DBM:GetSpellInfo(239207), DBM:GetSpellInfo(239132), DBM:GetSpellInfo(234059), DBM:GetSpellInfo(236571), DBM:GetSpellInfo(241008)
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Maiden shield amount i active first
		if mod.vb.shieldActive then
			local absorbAmount = select(17, UnitBuff("boss2", shieldName)) or select(17, UnitDebuff("boss2", shieldName))
			if absorbAmount then
				local percent = absorbAmount / mod.vb.shieldActive * 100
				addLine(shieldName, math.floor(percent))
			end
		end
		--Boss Powers second
		for i = 1, 2 do
			local uId = "boss"..i
			if UnitExists(uId) then
				local currentPower = UnitPower(uId) or 0
				addLine(UnitName(uId), currentPower)
			end
		end
		--Fallen Avatar Cooldowns third
		--addLine(L.Oncooldown, "")
		if showTouchofSarg then
			if abilitiesonCD[239207] then--Touch of Sargeras
				addLine(touch, "|cFF088A08"..YES.."|r")
			else
				addLine(touch, "|cffff0000"..NO.."|r")
			end
		end
		if abilitiesonCD[239132] then--Rupture Realities
			addLine(rupture, "|cFF088A08"..YES.."|r")
		else
			addLine(rupture, "|cffff0000"..NO.."|r")
		end
		if abilitiesonCD[234059] then--Unbound Chaos
			addLine(unbound, "|cFF088A08"..YES.."|r")
		else
			addLine(unbound, "|cffff0000"..NO.."|r")
		end
		if abilitiesonCD[236571] then--Shadowy Blades
			addLine(shadowy, "|cFF088A08"..YES.."|r")
		else
			addLine(shadowy, "|cffff0000"..NO.."|r")
		end

		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(darkMarkTargets)
	self.vb.phase = 1
	self.vb.bladesIcon = 1
	self.vb.touchCast = 0
	self.vb.darkMarkCast = 0
	self.vb.chaosCount = 0
	self.vb.realityCount = 0
	self.vb.rainCount = 0
	timerUnboundChaosCD:Start(7-delay, 1)--7
	self:Schedule(7, setabilityStatus, self, 234059, 0)--Unbound Chaos
	timerDesolateCD:Start(13-delay)--13
	countdownDesolate:Start(13-delay)
	if not self:IsEasy() then
		showTouchofSarg = true
		timerTouchofSargerasCD:Start(14.5-delay, 1)
		self:Schedule(14.5, setabilityStatus, self, 239207, 0)--Touch of Sargeras
	else
		showTouchofSarg = false
	end
	timerShadowyBladesCD:Start(27-delay)
	self:Schedule(27, setabilityStatus, self, 236571, 0)--Shadowy Blades
	timerRuptureRealitiesCD:Start(31-delay, 1)--31-37
	self:Schedule(31, setabilityStatus, self, 239132, 0)--Ruptured Realities
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		--DBM.InfoFrame:Show(2, "enemypower", 2)
		DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	if self:IsLFR() then--7 min in LFR
		berserkTimer:Start(-delay)
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
	if spellId == 239207 then
		self.vb.touchCast = self.vb.touchCast + 1
		specWarnTouchofSargerasGround:Show(self.vb.touchCast)
		specWarnTouchofSargerasGround:Play("helpsoak")
		self:Unschedule(setabilityStatus, self, 239207)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 239207, 1)--Set on Cooldown
		if self:IsMythic() then
			timerTouchofSargerasCD:Start(60, self.vb.touchCast+1)--42
			self:Schedule(60, setabilityStatus, self, 239207, 0)--Set ready to use when CD expires
		else
			timerTouchofSargerasCD:Start(42, self.vb.touchCast+1)--42
			self:Schedule(42, setabilityStatus, self, 239207, 0)--Set ready to use when CD expires
		end
	elseif spellId == 239132 or spellId == 235572 then
		self.vb.realityCount = self.vb.realityCount + 1
		specWarnRuptureRealities:Show()
		specWarnRuptureRealities:Play("justrun")
		if self.vb.phase == 2 then
			timerRuptureRealitiesCD:Start(37, self.vb.realityCount+1)
			countdownRuptureRealities:Start(37)
			local elapsedDark, totalDark = timerDarkMarkCD:GetTime(self.vb.darkMarkCast+1)
			local remaining = totalDark - elapsedDark
			if remaining < 9.8 then
				countdownDarkMark:Cancel()
				countdownDarkMark:Start(9.8)
				if totalDark == 0 then--Timer aleady expired
					timerDarkMarkCD:Start(9.8, self.vb.darkMarkCast+1)
					DBM:Debug("Timer extend firing for Dark Mark. Extend amount: ".."9.8", 2)
				else
					local extend = 9.8 - totalDark
					timerDarkMarkCD:Update(elapsedDark, totalDark+extend, self.vb.darkMarkCast+1)
					DBM:Debug("Timer extend firing for Dark Mark. Extend amount: "..extend, 2)
				end
			end
		else
			timerRuptureRealitiesCD:Start(60, self.vb.realityCount+1)--60
			self:Unschedule(setabilityStatus, self, 239132)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
			setabilityStatus(self, 239132, 1)--Set on cooldown
			self:Schedule(60, setabilityStatus, self, 239132, 0)--Set ready to use when CD expires
		end
	elseif spellId == 233856 then
		specWarnCleansingProtocol:Show()
		specWarnCleansingProtocol:Play("targetchange")
		countdownCleansingProtocol:Start()
	elseif spellId == 233556 and self:AntiSpam(2, 2) and self.vb.phase == 1 then
		specWarnCorruptedMatrix:Show(beamName)
		specWarnCorruptedMatrix:Play("bosstobeam")
		if self:IsMythic() then
			timerCorruptedMatrix:Start(8)
		else
			timerCorruptedMatrix:Start(10)
		end
	elseif spellId == 240623 and self:AntiSpam(2, 3) and self.vb.phase == 1 then
		warnTaintedMatrix:Show()
	elseif spellId == 235597 then
		self:Unschedule(setabilityStatus)--Unschedule all
		self.vb.phase = 2
		timerTouchofSargerasCD:Stop()
		timerShadowyBladesCD:Stop()
		timerRuptureRealitiesCD:Stop()
		timerDesolateCD:Stop()
		countdownDesolate:Cancel()
		timerUnboundChaosCD:Stop()
		timerCorruptedMatrix:Stop()
		timerCorruptedMatrixCD:Stop()
		countdownCorruptedMatrix:Cancel()
		
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerDesolateCD:Start(19)
		countdownDesolate:Start(19)
		timerRuptureRealitiesCD:Start(38, 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		if self:IsMythic() then
			timerRainoftheDestroyerCD:Start(15, 1)
			countdownRainofthedDestroyer:Start(15)
			timerDarkMarkCD:Start(31.6, 1)
			countdownDarkMark:Start(31.6)
		else
			timerDarkMarkCD:Start(21, 1)
			countdownDarkMark:Start(21)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236494 then
		timerDesolateCD:Start()
		countdownDesolate:Start(11.4)
	elseif spellId == 233556 and self:AntiSpam(2, 4) then
		if self:IsMythic() then
			timerCorruptedMatrixCD:Start(12)
			countdownCorruptedMatrix:Start(12)
		else
			timerCorruptedMatrixCD:Start()
			countdownCorruptedMatrix:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239739 then
		if not tContains(darkMarkTargets, args.destName) then
			darkMarkTargets[#darkMarkTargets+1] = args.destName
		end
		self:Unschedule(warnDarkMarkTargets)
		if #darkMarkTargets == 3 then
			warnDarkMarkTargets(self, args.spellName)
		else
			self:Schedule(0.5, warnDarkMarkTargets, self, args.spellName)--At least 0.5, maybe bigger needed if warning still splits
		end
--		if args:IsPlayer() then
--			specWarnDarkMark:Show(self:IconNumToString())
--			specWarnDarkMark:Play("targetyou")
--		end
	elseif spellId == 234059 then
		warnUnboundChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellUnboundChaos:Yell()
		end
	elseif spellId == 236494 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnDesolateYou:Show(amount)
				specWarnDesolateYou:Play("stackhigh")
			else
				local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 10) then
					specWarnDesolateOther:Show(args.destName)
					specWarnDesolateOther:Play("tauntboss")
				else
					warnDesolate:Show(args.destName, amount)
				end
			end
		else
			warnDesolate:Show(args.destName, amount)
		end
	elseif spellId == 240728 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount >= 6 then
				specWarnTaintedEssence:Show(amount)
				specWarnTaintedEssence:Play("stackhigh")
				yellTaintedEssence:Yell(amount)
			end
		end
	elseif spellId == 241008 then--Cleansing Protocol Shield
		self.vb.shieldActive = UnitGetTotalAbsorbs("boss2")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 239739 then
		if args:IsPlayer() then
			yellDarkMarkFades:Cancel()
		end
		if self.Options.SetIconOnDarkMark then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 241008 then--Cleansing Protocol Shield
		self.vb.shieldActive = false
		warnCleansingEnded:Show()
		countdownCleansingProtocol:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 239212 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnLingeringDarkness:Show()
		specWarnLingeringDarkness:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("234418") then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnRainoftheDestroyer:Show(self.vb.rainCount)
		specWarnRainoftheDestroyer:Play("helpsoak")
		timerRainoftheDestroyer:Start()
		timerRainoftheDestroyerCD:Start(nil, self.vb.rainCount+1)
		countdownRainofthedDestroyer:Start()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("236604") then
		specWarnShadowyBlades:Show()
		specWarnShadowyBlades:Play("runout")
		--yellShadowyBlades:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("236604") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			local icon = self.vb.bladesIcon
			warnShadowyBlades:CombinedShow(0.5, targetName)
			if self.Options.SetIconOnShadowyBlades then
				self:SetIcon(targetName, icon, 5)
			end
			if targetName == playerName then
				yellShadowyBlades:Yell(icon, icon, icon)
			end
			self.vb.bladesIcon = self.vb.bladesIcon + 1
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if (msg == L.FallenAvatarDialog or msg:find(L.FallenAvatarDialog)) then
		self:SendSync("FallenAvatarRP")--Syncing to help unlocalized clients
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 234057 then
		self.vb.chaosCount = self.vb.chaosCount + 1
		specWarnUnboundChaos:Show()
		specWarnUnboundChaos:Play("watchstep")
		timerUnboundChaosCD:Start(nil, self.vb.chaosCount+1)--35
		self:Unschedule(setabilityStatus, self, 234059)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 234059, 1)--Set on cooldown
		self:Schedule(35, setabilityStatus, self, 234059, 0)--Set ready to use when CD expires
	elseif spellId == 239739 or spellId == 239825 then
		table.wipe(darkMarkTargets)
		self.vb.darkMarkCast = self.vb.darkMarkCast + 1
		if self:IsMythic() then
			timerDarkMarkCD:Start(25, self.vb.darkMarkCast+1)
			countdownDarkMark:Start(25)
		else
			timerDarkMarkCD:Start(nil, self.vb.darkMarkCast+1)--34
			countdownDarkMark:Start(34)
		end
	elseif spellId == 236571 or spellId == 236573 then--Shadow Blades
		self.vb.bladesIcon = 1--SHOULD always fire first
		self:Unschedule(setabilityStatus, self, 236571)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 236571, 1)--Set on cooldown
		if self:IsEasy() then
			timerShadowyBladesCD:Start(34)
			self:Schedule(34, setabilityStatus, self, 236571, 0)--Set ready to use when CD expires
		else
			if self:IsMythic() then
				timerShadowyBladesCD:Start(35)
				self:Schedule(35, setabilityStatus, self, 236571, 0)--Set ready to use when CD expires
			else
				timerShadowyBladesCD:Start(30)
				self:Schedule(30, setabilityStatus, self, 236571, 0)--Set ready to use when CD expires
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, nil, nil, 5)
		end
	end
end

function mod:OnSync(msg, targetname)
	if msg == "FallenAvatarRP" and self:AntiSpam(60, 6) then
		timerRP:Start()
	end
end
