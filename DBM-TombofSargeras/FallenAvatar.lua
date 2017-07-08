local mod	= DBM:NewMod(1873, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116939)--Maiden of Valor 120437
mod:SetEncounterID(2038)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)--All 7 on mythic
mod:SetHotfixNoticeRev(16307)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 239207 239132 235572 233856 233556 240623 235597",
	"SPELL_CAST_SUCCESS 239132 236494",
	"SPELL_AURA_APPLIED 234059 236494 240728 239739 241008",
	"SPELL_AURA_APPLIED_DOSE 236494 240728 241008",
	"SPELL_AURA_REMOVED 239739",
	"SPELL_PERIODIC_DAMAGE 239212",
	"SPELL_PERIODIC_MISSED 239212",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, two entirely different version sof Touch of Sargeras. Figure out which one is actually used where
--TODO, figure out mythic stack count to start warning. Right now it's 4
--TODO, improve Dark Mark to match Touch of Sargeras if multiple targets, else, clean it up for 1 target
--TODO, unbound chaos seems affected by something, possibly energy getting to boss.
--TOOD, dark mark cast not in combat log, see if need to use APPIED or UNIT event
--TODO, and again, black winds not in combat log, find way to do it besides spell damage
--[[
(ability.id = 239207 or ability.id = 239132 or ability.id = 236571 or ability.id = 233856 or ability.id = 233556 or ability.id = 240623 or ability.id = 239418 or ability.id = 235597) and type = "begincast" or
(ability.id = 236571 or ability.id = 236494 or ability.id = 239739) and type = "cast" or
(ability.id = 234009 or ability.id = 234059) and type = "applydebuff"
 or ability.name = "Shadowy Blades" or ability.name = "Black Winds"
--]]
--Stage One: A Slumber Disturbed
local warnUnboundChaos				= mod:NewTargetAnnounce(234059, 3, nil, false, 2)
local warnShadowyBlades				= mod:NewTargetAnnounce(236571, 3)
local warnDesolate					= mod:NewStackAnnounce(236494, 3, nil, "Healer|Tank")
local warnCleansingEnded			= mod:NewEndAnnounce(241008, 1)
--Stage Two: An Avatar Awakened
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnDarkmark					= mod:NewTargetAnnounce(239739, 3)
--local warnBlackWinds				= mod:NewSpellAnnounce(239418, 2)

--Stage One: A Slumber Disturbed
local specWarnTouchofSargerasGround	= mod:NewSpecialWarningSpell(239207, "-Tank", nil, 2, 1, 2)
local specWarnRuptureRealities		= mod:NewSpecialWarningRun(239132, nil, nil, nil, 4, 2)
local specWarnUnboundChaos			= mod:NewSpecialWarningMoveAway(234059, nil, nil, nil, 1, 2)
local yellUnboundChaos				= mod:NewYell(234059, nil, false, 2)
local specWarnShadowyBlades			= mod:NewSpecialWarningMoveAway(236571, nil, nil, nil, 1, 2)
local yellShadowyBlades				= mod:NewPosYell(236571)
local specWarnLingeringDarkness		= mod:NewSpecialWarningMove(239212, nil, nil, nil, 1, 2)
local specWarnDesolateYou			= mod:NewSpecialWarningStack(236494, nil, 2, nil, nil, 1, 6)
local specWarnDesolateOther			= mod:NewSpecialWarningTaunt(236494, nil, nil, nil, 1, 2)
----Maiden of Valor
local specWarnCorruptedMatrix		= mod:NewSpecialWarningMoveTo(233556, "Tank", nil, nil, 1, 7)
local specWarnCleansingProtocol		= mod:NewSpecialWarningSwitch(233856, "-Healer", nil, nil, 3, 2)
local specWarnTaintedEssence		= mod:NewSpecialWarningStack(240728, nil, 3, nil, nil, 1, 6)
--Stage Two: An Avatar Awakened
local specWarnDarkMark				= mod:NewSpecialWarningYou(239739, nil, nil, nil, 1, 2)
local specWarnDarkMarkOther			= mod:NewSpecialWarningMoveTo(239739, nil, nil, nil, 1, 2)
local yellDarkMark					= mod:NewPosYell(239739)
local yellDarkMarkFades				= mod:NewFadesYell(239739)
local specWarnRainoftheDestroyer	= mod:NewSpecialWarningDodge(240396, nil, nil, nil, 2, 2)

--Stage One: A Slumber Disturbed
local timerTouchofSargerasCD		= mod:NewCDTimer(42, 239207, nil, nil, nil, 3)--42+
local timerRuptureRealitiesCD		= mod:NewCDTimer(60, 239132, nil, nil, nil, 2)
local timerUnboundChaosCD			= mod:NewCDTimer(35, 234059, nil, nil, nil, 3)--35-60 (lovely huh?)
local timerShadowyBladesCD			= mod:NewCDTimer(30, 236571, nil, nil, nil, 3)--30-46
local timerDesolateCD				= mod:NewCDTimer(11.4, 236494, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Maiden of Valor
local timerCorruptedMatrixCD		= mod:NewNextTimer(40, 233556, nil, nil, nil, 5)
local timerCorruptedMatrix			= mod:NewCastTimer(10, 233556, nil, nil, nil, 5)
local timerTaintedMatrixCD			= mod:NewCastTimer(10, 240623, nil, nil, nil, 6)--Mythic
--Stage Two: An Avatar Awakened
local timerDarkMarkCD				= mod:NewCDTimer(34, 239739, nil, nil, nil, 3)
--local timerBlackWindsCD				= mod:NewCDTimer(31, 239418, nil, nil, nil, 3)
--local timerRainoftheDestroyerCD		= mod:NewCDTimer(44, 240396, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage One: A Slumber Disturbed
local countdownRuptureRealities		= mod:NewCountdown(60, 239132)
local countdownCorruptedMatrix		= mod:NewCountdown("Alt40", 233556)

--Stage One: A Slumber Disturbed
local voiceTouchofSargerasGround	= mod:NewVoice(239207, "-Tank", nil, 2)--helpsoak
local voiceRuptureRealities			= mod:NewVoice(239132)--justrun
local voiceUnboundChaos				= mod:NewVoice(234059)--runout/keepmove
local voiceShadowyBlades			= mod:NewVoice(236571)--scatter
local voiceLingeringDarkness		= mod:NewVoice(239212)--runaway
local voiceDesolate					= mod:NewVoice(236494, "Tank")--stackhigh/tauntboss
----Maiden of Valor
local voiceCorruptedMatrix			= mod:NewVoice(233556, "Tank")--bosstobeam
local voiceCleansingProtocol		= mod:NewVoice(233856, "-Healer")--targetchange
local voiceTaintedEssence			= mod:NewVoice(240728)--stackhigh
--Stage Two: An Avatar Awakened
local voiceDarkMark					= mod:NewVoice(239739)--gathershare/targetyou
local voiceRainoftheDestroyer		= mod:NewVoice(240396)--watchstep

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
local darkMarkTargets = {}
local playerName = UnitName("player")
local beamName = GetSpellInfo(238244)
local showTouchofSarg = true

local function warnDarkMarkTargets(self, spellName)
--	table.sort(darkMarkTargets)
	warnDarkmark:Show(table.concat(darkMarkTargets, "<, >"))
	--if self:IsLFR() then return end
	for i = 1, #darkMarkTargets do
		local icon = i == 1 and 6 or i == 2 and 4 or i == 3 and 3--Bigwigs icon compatability
		local name = darkMarkTargets[i]
		if name == playerName then
			yellDarkMark:Yell(icon, icon, icon)
		end
		if self.Options.SetIconOnDarkMark then
			self:SetIcon(name, icon)
		end
	end
	if not UnitDebuff("player", spellName) then
		specWarnDarkMarkOther:Show(DBM_ALLY)
		voiceDarkMark:Play("gathershare")
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
	local touch, rupture, unbound, shadowy, shieldName = GetSpellInfo(239207), GetSpellInfo(239132), GetSpellInfo(234059), GetSpellInfo(236571), GetSpellInfo(241008)
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
				addLine(shieldName, absorbAmount)
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
	timerUnboundChaosCD:Start(7-delay)--7
	self:Schedule(7, setabilityStatus, self, 234059, 0)--Unbound Chaos
	timerDesolateCD:Start(13-delay)--13
	if not self:IsEasy() then
		showTouchofSarg = true
		timerTouchofSargerasCD:Start(14.5-delay)
		self:Schedule(14.5, setabilityStatus, self, 239207, 0)--Touch of Sargeras
	else
		showTouchofSarg = false
	end
	timerShadowyBladesCD:Start(20.7-delay)
	self:Schedule(20.7, setabilityStatus, self, 236571, 0)--Shadowy Blades
	timerRuptureRealitiesCD:Start(31-delay)--31-37
	self:Schedule(31, setabilityStatus, self, 239132, 0)--Ruptured Realities
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		--DBM.InfoFrame:Show(2, "enemypower", 2)
		DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
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
		specWarnTouchofSargerasGround:Show()
		voiceTouchofSargerasGround:Play("helpsoak")
		timerTouchofSargerasCD:Start()--42
		self:Unschedule(setabilityStatus, self, 239207)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 239207, 1)--Set on Cooldown
		self:Schedule(42, setabilityStatus, self, 239207, 0)--Set ready to use when CD expires
	elseif spellId == 239132 or spellId == 235572 then
		specWarnRuptureRealities:Show()
		voiceRuptureRealities:Play("justrun")
		if self.vb.phase == 2 then
			timerRuptureRealitiesCD:Start(37)
			countdownRuptureRealities:Start(37)
		else
			timerRuptureRealitiesCD:Start()--60
			self:Unschedule(setabilityStatus, self, 239132)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
			setabilityStatus(self, 239132, 1)--Set on cooldown
			self:Schedule(60, setabilityStatus, self, 239132, 0)--Set ready to use when CD expires
		end
	elseif spellId == 233856 then
		specWarnCleansingProtocol:Show()
		voiceCleansingProtocol:Play("targetchange")
	elseif spellId == 233556 and self:AntiSpam(2, 2) then
		specWarnCorruptedMatrix:Show(beamName)
		voiceCorruptedMatrix:Play("bosstobeam")
		timerCorruptedMatrix:Start(10)
	elseif spellId == 240623 and self:AntiSpam(2, 3) then
		timerTaintedMatrixCD:Start(10)
	elseif spellId == 235597 then
		self:Unschedule(setabilityStatus)--Unschedule all
		self.vb.phase = 2
		timerTouchofSargerasCD:Stop()
		timerShadowyBladesCD:Stop()
		timerRuptureRealitiesCD:Stop()
		timerDesolateCD:Stop()
		timerUnboundChaosCD:Stop()
		timerCorruptedMatrix:Stop()
		timerCorruptedMatrixCD:Stop()
		countdownCorruptedMatrix:Cancel()
		timerTaintedMatrixCD:Stop()
		
		warnPhase2:Show()
		timerDesolateCD:Start(19)
		timerDarkMarkCD:Start(21)
		timerRuptureRealitiesCD:Start(39)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236494 then
		timerDesolateCD:Start()
	elseif spellId == 233556 and self:AntiSpam(2, 4) then
		timerCorruptedMatrixCD:Start()
		countdownCorruptedMatrix:Start()
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
		if args:IsPlayer() then
			specWarnDarkMark:Show()
			voiceDarkMark:Play("targetyou")
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellDarkMarkFades:Countdown(remaining)
		end
	elseif spellId == 234059 then
		warnUnboundChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUnboundChaos:Show()
			voiceUnboundChaos:Play("watchstep")
			yellUnboundChaos:Yell()
		end
	elseif spellId == 236494 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnDesolateYou:Show(amount)
				voiceDesolate:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
					specWarnDesolateOther:Show(args.destName)
					voiceDesolate:Play("tauntboss")
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
			if amount >= 4 then
				specWarnTaintedEssence:Show(amount)
				voiceTaintedEssence:Play("stackhigh")
			end
		end
	elseif spellId == 241008 then--Cleansing Protocol Shield
		self.vb.shieldActive = true
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
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 239212 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnLingeringDarkness:Show()
		voiceLingeringDarkness:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:234418") then
		specWarnRainoftheDestroyer:Show()
		voiceRainoftheDestroyer:Play("watchstep")
		--timerRainoftheDestroyerCD:Start()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:236604") then
		specWarnShadowyBlades:Show()
		voiceShadowyBlades:Play("runout")
		--yellShadowyBlades:Yell()
	end
end

function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:236604") then--Rapid fire
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 234057 then
		timerUnboundChaosCD:Start()--35
		self:Unschedule(setabilityStatus, self, 234059)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 234059, 1)--Set on cooldown
		self:Schedule(35, setabilityStatus, self, 234059, 0)--Set ready to use when CD expires
	elseif spellId == 239739 or spellId == 239825 then
		table.wipe(darkMarkTargets)
		timerDarkMarkCD:Start()
	elseif spellId == 236571 or spellId == 236573 then--Shadow Blades
		self.vb.bladesIcon = 1--SHOULD always fire first
		self:Unschedule(setabilityStatus, self, 236571)--Unschedule for good measure in case next cast start fires before timer expires (in which case have a bad timer)
		setabilityStatus(self, 236571, 1)--Set on cooldown
		if self:IsEasy() then
			timerShadowyBladesCD:Start(34)
			self:Schedule(34, setabilityStatus, self, 236571, 0)--Set ready to use when CD expires
		else
			timerShadowyBladesCD:Start(30)
			self:Schedule(30, setabilityStatus, self, 236571, 0)--Set ready to use when CD expires
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, nil, nil, 5)
		end
	end
end

