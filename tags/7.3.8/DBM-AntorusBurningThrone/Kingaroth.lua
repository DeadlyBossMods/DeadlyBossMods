local mod	= DBM:NewMod(2004, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122578)
mod:SetEncounterID(2088)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244312 254926 245807 252758 246692 246833 246516 257978 254919",
	"SPELL_CAST_SUCCESS 252758 246692",
	"SPELL_AURA_APPLIED 254919 257978 244410 245770 246687 252797 246698 252760",
	"SPELL_AURA_APPLIED_DOSE 257978",
	"SPELL_AURA_REMOVED 244410 245770 246687 252797 246516 246698 252760",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, see if Reverberating Strike can be on anyone or just another tank only mechanic (determines what kind of range frame we need)
--TODO, how does mythic reverberating decimatino work (18 yard spread?)
--TODO, analyze DiabolicBomb
--TODO, how to detect http://ptr.wowhead.com/spell=249920/weapons-upgrade
--TODO, workin http://ptr.wowhead.com/spell=246629/apocalypse-blast
--TODO, more work on infoframe for fel reaver construction status, etc.
--TODO, review all timers, they were adjusting his rate of energy gain throughough attempts
--TODO, review timers even more cause they keep tweaking them
--TODO, currently decimation & annihilation are only detectable via nameplate/target casts as such, it's pretty bad idea to support it unless it's really required
--[[
(ability.id = 244312 or ability.id = 254926 or ability.id = 245807 or ability.id = 252758 or ability.id = 246692 or ability.id = 246833 or ability.id = 246516 or ability.id = 257997 or ability.id = 257978 or ability.id = 254919) and type = "begincast"
 or (ability.id = 252758 or ability.id = 246692) and type = "cast"
 or (ability.id = 246516 or ability.id = 246698 or ability.id = 252760) and (type = "removebuff" or type = "removedebuff")
--]]
--Stage: Deployment
--local warnRuiner						= mod:NewTargetAnnounce(246840, 3)
local warnShatteringStrike				= mod:NewSpellAnnounce(248375, 2)
local warnDiabolicBomb					= mod:NewSpellAnnounce(246779, 3)
local warnReverberatingStrike			= mod:NewTargetAnnounce(246692, 3)
--Reavers (or empowered boss from reaver deaths)
--local warnDecimation					= mod:NewTargetAnnounce(244410, 4)
local warnDemolish						= mod:NewTargetAnnounce(246692, 4)

--Stage: Deployment
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnForgingStrike				= mod:NewSpecialWarningDefensive(244312, nil, nil, nil, 1, 2)
local specWarnForgingStrikeOther		= mod:NewSpecialWarningTaunt(244312, nil, nil, nil, 1, 2)
local specWarnReverberatingStrike		= mod:NewSpecialWarningYou(254926, nil, nil, nil, 1, 2)
local yellReverberatingStrike			= mod:NewYell(254926)
local specWarnReverberatingStrikeNear	= mod:NewSpecialWarningClose(254926, nil, nil, nil, 1, 2)
--local specWarnDiabolicBomb				= mod:NewSpecialWarningDodge(246779, nil, nil, nil, 2, 2)
local specWarnRuiner					= mod:NewSpecialWarningDodge(246840, nil, nil, nil, 3, 2)
--local yellRuiner						= mod:NewPosYell(246840)
--Stage: Construction
local specWarnInitializing				= mod:NewSpecialWarningSwitch(246504, nil, nil, nil, 1, 2)
--Reavers (or empowered boss from reaver deaths)
local specWarnDecimation				= mod:NewSpecialWarningSpell(244410, nil, nil, nil, 1, 2)
--local yellDecimation					= mod:NewShortFadesYell(244410)
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(245807, nil, nil, nil, 2, 2)
local specWarnDemolish					= mod:NewSpecialWarningYou(246692, nil, nil, nil, 1, 2)
local specWarnDemolishOther				= mod:NewSpecialWarningMoveTo(246692, nil, nil, nil, 1, 2)
local yellDemolish						= mod:NewPosYell(246692)
local yellDemolishFades					= mod:NewIconFadesYell(246692)

--Stage: Deployment
local timerForgingStrikeCD				= mod:NewCDTimer(14.3, 244312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReverberatingStrikeCD		= mod:NewCDCountTimer(28, 254926, nil, nil, nil, 3)
--local timerDiabolicBombCD				= mod:NewAITimer(61, 246779, nil, nil, nil, 3)
local timerRuinerCD						= mod:NewCDCountTimer(29.1, 246840, nil, nil, nil, 3)
--local timerShatteringStrikeCD			= mod:NewCDTimer(30, 248375, nil, nil, nil, 2)
local timerApocProtocolCD				= mod:NewCDCountTimer(85.8, 246516, nil, nil, nil, 6)
local timerApocProtocol					= mod:NewCastTimer(30, 246504, nil, nil, nil, 6)
--Stage: Construction
--local timerCleansingProtocolCD		= mod:NewAITimer(30, 248061, nil, nil, nil, 6)
--Reavers (or empowered boss from reaver deaths)
local timerDecimationCD					= mod:NewCDTimer(15.1, 244410, nil, nil, nil, 3)
local timerAnnihilationCD				= mod:NewCDTimer(15.4, 245807, nil, nil, nil, 3)
local timerDemolishCD					= mod:NewCDTimer(15.8, 246692, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage: Deployment
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--Stage: Deployment
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
local voiceForgingStrike				= mod:NewVoice(244312)--defensive
local voiceReverberatingStrike			= mod:NewVoice(254926)--watchstep
--local voiceDiabolicBomb					= mod:NewVoice(246779)--watchstep/watchorb?
local voiceRuiner						= mod:NewVoice(246840)--farfromline (iffy) Maybe when it's not INVISIBLE I'll have better idea how to describe it
local voiceInitializing					= mod:NewVoice(246504)--killmob
--Reavers (or empowered boss from reaver deaths)
local voiceDecimation					= mod:NewVoice(244410)--scatter
local voiceAnnihilation					= mod:NewVoice(245807)--helpsoak
local voiceDemolish						= mod:NewVoice(246692)--gathershare/targetyou

mod:AddSetIconOption("SetIconOnDemolish", 246692, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddRangeFrameOption(5, 254926)--?

mod.vb.ruinerCast = 0
mod.vb.forgingStrikeCast = 0
mod.vb.reverbStrikeCast = 0
mod.vb.apocProtoCount = 0
mod.vb.ruinerTimeLeft = 0
mod.vb.reverbTimeLeft = 0
mod.vb.forgingTimeLeft = 0

local DemolishTargets = {}
local playerName = DBM:GetMyPlayerInfo()

function mod:ReverberatingTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnReverberatingStrike:Show()
		voiceReverberatingStrike:Play("runaway")
		yellReverberatingStrike:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnReverberatingStrikeNear:Show(targetname)
		voiceReverberatingStrike:Play("watchstep")
	else
		warnReverberatingStrike:Show(targetname)
	end
end

local function warnDemolishTargets(self, spellName)
--	table.sort(DemolishTargets)
	warnDemolish:Show(table.concat(DemolishTargets, "<, >"))
	--if self:IsLFR() then return end
	for i = 1, #DemolishTargets do
		--local icon = i == 1 and 6 or i == 2 and 4 or i == 3 and 3--Because I'm sure bigwigs will do something funky with icons
		local icon = i
		local name = DemolishTargets[i]
		if name == playerName then
			yellDemolish:Yell(icon, icon, icon)
			local _, _, _, _, _, _, expires = UnitDebuff("player", spellName)
			local remaining = expires-GetTime()
			yellDemolishFades:Countdown(remaining, nil, icon)
		end
		if self.Options.SetIconOnDemolish then
			self:SetIcon(name, icon)
		end
	end
	if not UnitDebuff("player", spellName) then
		specWarnDemolishOther:Show(DBM_ALLY)
		voiceDemolish:Play("gathershare")
	end
end

local updateInfoFrame
do
	local demolishDebuff = GetSpellInfo(246692)
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
		--TODO, fel reaver construction status info
		if #DemolishTargets == 0 then--None found, hide infoframe because all broke
			DBM.InfoFrame:Hide()
		end
		for i = 1, #DemolishTargets do
			local name = DemolishTargets[i]
			addLine(name, i)
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.ruinerCast = 0
	self.vb.forgingStrikeCast = 0
	self.vb.reverbStrikeCast = 0
	self.vb.apocProtoCount = 0
	self.vb.ruinerTimeLeft = 0
	self.vb.reverbTimeLeft = 0
	self.vb.forgingTimeLeft = 0
	table.wipe(DemolishTargets)
	timerForgingStrikeCD:Start(6-delay, 1)--6-7
	--timerDiabolicBombCD:Start(11-delay)
	timerReverberatingStrikeCD:Start(14.2-delay, 1)--14-15
	timerRuinerCD:Start(21.1-delay, 1)--21-25
	--timerShatteringStrikeCD:Start(1-delay)--Not cast on pull
	timerApocProtocolCD:Start(31.8-delay, 1)--31.8-36.5
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
--[[	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false, true)
	end--]]
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
	if spellId == 244312 or spellId == 257978 or spellId == 254919 then
		self.vb.forgingStrikeCast = self.vb.forgingStrikeCast + 1
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then--Player is current target
			specWarnForgingStrike:Show()
			voiceForgingStrike:Play("defensive")
		end
		--1.5, 27.6, 30.1
		if self:IsLFR() then
			timerForgingStrikeCD:Start(8.5, self.vb.forgingStrikeCast+1)
		else
			timerForgingStrikeCD:Start(14.6, self.vb.forgingStrikeCast+1)
		end
	elseif spellId == 254926 or spellId == 257997 then
		self:BossTargetScanner(args.sourceGUID, "ReverberatingTarget", 0.1, 9)
		if self:AntiSpam(5, 3) then--Sometimes stutter casts
			self.vb.reverbStrikeCast = self.vb.reverbStrikeCast + 1
			local cooldown = 28
			if self:IsLFR() then
				cooldown = 26
			else
				cooldown = 28--28-30
			end
			timerReverberatingStrikeCD:Start(cooldown, self.vb.reverbStrikeCast+1)--More work needed
		end
	elseif spellId == 245807 then
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
	elseif spellId == 252758 or spellId == 246692 then
		table.wipe(DemolishTargets)
	elseif spellId == 246833 then--Ruiner
		self.vb.ruinerCast = self.vb.ruinerCast + 1
		specWarnRuiner:Show()
		voiceRuiner:Play("farfromline")
		voiceRuiner:Schedule(1, "keepmove")
		timerRuinerCD:Start(nil, self.vb.ruinerCast+1)--28-30 depending on difficulty
		timerForgingStrikeCD:Stop()
		timerForgingStrikeCD:Start(10, self.vb.forgingStrikeCast+1)
	elseif spellId == 246516 then--Apocolypse Protocol
		self.vb.ruinerTimeLeft = timerRuinerCD:GetRemaining(self.vb.ruinerCast+1)
		self.vb.reverbTimeLeft = timerReverberatingStrikeCD:GetRemaining(self.vb.reverbStrikeCast+1)
		self.vb.forgingTimeLeft = timerForgingStrikeCD:GetRemaining(self.vb.forgingStrikeCast+1)
		timerForgingStrikeCD:Stop()
		timerReverberatingStrikeCD:Stop()
		timerRuinerCD:Stop()
		--timerDiabolicBombCD:Stop()
		--timerShatteringStrikeCD:Stop()
		specWarnInitializing:Show()
		voiceInitializing:Play("killmob")
		if self:IsLFR() then
			timerApocProtocol:Start(42)
		else
			timerApocProtocol:Start()--30
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 252758 or spellId == 246692 then
		timerDemolishCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 254919 then--Always swap after each cast
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) and not args:IsPlayer() then
			local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 14) then
				specWarnForgingStrikeOther:Show(args.destName)
				voiceForgingStrike:Play("changemt")
			end
		end
	elseif spellId == 257978 then--LFR special edition, swap at 2 stacks
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 and not args:IsPlayer() then
				local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 8.5) then
					specWarnForgingStrikeOther:Show(args.destName)
					voiceForgingStrike:Play("tauntboss")
				end
			end
		end
--[[	elseif (spellId == 244410 or spellId == 245770 or spellId == 246687 or spellId == 252797) and args:IsDestTypePlayer() then--244410 3 seconds, rest 5, for good measure, just pulling duration from UnitDebuff()
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			voiceDecimation:Play("runout")
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellDecimation:Countdown(remaining)
		end--]]
	elseif spellId == 246698 or spellId == 252760 then
		if not tContains(DemolishTargets, args.destName) then
			DemolishTargets[#DemolishTargets+1] = args.destName
		end
		self:Unschedule(warnDemolishTargets)
		--if #DemolishTargets == 3 then--(uncomment when upper camp known)
			--warnDemolishTargets(self, args.spellName)
		--else
			self:Schedule(0.8, warnDemolishTargets, self, args.spellName)--At least 0.8, maybe bigger needed if warning still splits
		--end
		if args:IsPlayer() then
			specWarnDemolish:Show()
			voiceDemolish:Play("targetyou")
		end
		if self.Options.InfoFrame then
			if #DemolishTargets == 1 then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false, true)
			else
				DBM.InfoFrame:Update()
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 244410 or spellId == 245770 or spellId == 246687 or spellId == 252797) and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			--yellDecimation:Cancel()
		end
	elseif spellId == 246516 then--Apocolypse Protocol
		self.vb.ruinerCast = 0
		self.vb.forgingStrikeCast = 0
		self.vb.reverbStrikeCast = 0
		self.vb.apocProtoCount = self.vb.apocProtoCount + 1
		if self.vb.apocProtoCount % 2 == 1 then
			DBM:Debug("Reverb first", 2)
		else
			DBM:Debug("Ruiner first", 2)
		end
		if self.vb.reverbTimeLeft > 0 then
			timerReverberatingStrikeCD:Start(self.vb.reverbTimeLeft, 1)
		end
		if self.vb.ruinerTimeLeft > 0 then
			timerRuinerCD:Start(self.vb.ruinerTimeLeft, 1)
		end
		if self.vb.forgingTimeLeft > 0 then
			timerForgingStrikeCD:Start(self.vb.forgingTimeLeft, 1)
		end
		--timerDiabolicBombCD:Start(2)
		--timerShatteringStrikeCD:Start(42)
		timerApocProtocolCD:Start(77, self.vb.apocProtoCount+1)--77
	elseif spellId == 246698 or spellId == 252760 then
		tDeleteItem(DemolishTargets, args.destName)
		if args:IsPlayer() then
			yellDemolishFades:Cancel()
		end
		if self.Options.SetIconOnDemolish then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 127235 then--Garothi Demolisher
		timerDemolishCD:Stop(args.destGUID)
	elseif cid == 127231 then--Garothi Decimator
		timerDecimationCD:Stop(args.destGUID)
	elseif cid == 127230 then--Garothi Annihilator
		timerAnnihilationCD:Stop(args.destGUID)
	end
end

--[[
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:246840") then
		specWarnRuiner:Show()
		voiceRuiner:Play("runout")
		voiceRuiner:Schedule(1, "keepmove")
		yellRuiner:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:246840") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			--local icon = self.vb.bladesIcon
			warnRuiner:CombinedShow(0.5, targetName)
			--if self.Options.SetIconOnRuiner then
			--	self:SetIcon(targetName, icon, 5)
			--end
			--if targetName == playerName then
			--	yellRuiner:Yell(icon, icon, icon)
			--end
			--self.vb.bladesIcon = self.vb.bladesIcon + 1
		end
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 246779 or spellId == 248214) and self:AntiSpam(3, 1) then--Diabolic Bomb
		warnDiabolicBomb:Show()
		--voiceDiabolicBomb:Play("watchstep")
		--timerDiabolicBombCD:Start()
	elseif spellId == 248319 then--Consume Energy 100% (reaver fully charged and activated)
		--Info Frame usage situation?
	elseif spellId == 246686 then--Decimation (ignore 246691 I'm pretty sure)
		specWarnDecimation:Show()
		voiceDecimation:Play("scatter")
		timerDecimationCD:Start(nil, UnitGUID(uId))
	elseif spellId == 246657 then--Annihilation
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
		timerAnnihilationCD:Start(nil, UnitGUID(uId))
	elseif spellId == 248375 and self:AntiSpam(5, 2) then--Shattering Strike
		warnShatteringStrike:Show()
		--timerShatteringStrikeCD:Start()
	end
end
