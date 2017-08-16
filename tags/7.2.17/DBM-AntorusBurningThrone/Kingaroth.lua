local mod	= DBM:NewMod(2004, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(122578)
mod:SetEncounterID(2088)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244312 248475 245807 252758 246692 246833 246516",
	"SPELL_CAST_SUCCESS 252758 246692",
	"SPELL_AURA_APPLIED 244312 244410 245770 246687 252797 246698 252760",
--	"SPELL_AURA_APPLIED_DOSE",
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
--TODO, currently decimation & annihilation are only detectable via nameplate/target casts as such, it's pretty bad idea to support it unless it's really required
--[[
(ability.id = 244312 or ability.id = 248475 or ability.id = 245807 or ability.id = 252758 or ability.id = 246692 or ability.id = 246833 or ability.id = 246516) and type = "begincast"
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
local specWarnReverberatingStrike		= mod:NewSpecialWarningYou(248475, nil, nil, nil, 1, 2)
local yellReverberatingStrike			= mod:NewYell(248475)
local specWarnReverberatingStrikeNear	= mod:NewSpecialWarningClose(248475, nil, nil, nil, 1, 2)
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
local yellDemolishFades					= mod:NewShortFadesYell(246692)

--Stage: Deployment
local timerForgingStrikeCD				= mod:NewAITimer(25, 244312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReverberatingStrikeCD		= mod:NewAITimer(61, 248475, nil, nil, nil, 3)
--local timerDiabolicBombCD				= mod:NewAITimer(61, 246779, nil, nil, nil, 3)
local timerRuinerCD						= mod:NewCDTimer(28.1, 246840, nil, nil, nil, 3)
--local timerShatteringStrikeCD			= mod:NewCDTimer(30, 248375, nil, nil, nil, 2)
local timerApocProtocolCD				= mod:NewCDTimer(77.58, 246516, nil, nil, nil, 6)
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
local voiceReverberatingStrike			= mod:NewVoice(248475)--watchstep
--local voiceDiabolicBomb					= mod:NewVoice(246779)--watchstep/watchorb?
local voiceRuiner						= mod:NewVoice(246840)--farfromline (iffy) Maybe when it's not INVISIBLE I'll have better idea how to describe it
local voiceInitializing					= mod:NewVoice(246504)--killmob
--Reavers (or empowered boss from reaver deaths)
local voiceDecimation					= mod:NewVoice(244410)--scatter
local voiceAnnihilation					= mod:NewVoice(245807)--helpsoak
local voiceDemolish						= mod:NewVoice(246692)--gathershare/targetyou

mod:AddSetIconOption("SetIconOnDemolish", 246692, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddRangeFrameOption(5, 248475)--?

mod.vb.ruinerCast = 0
mod.vb.forgingStrikeCast = 0
mod.vb.reverbStrikeCast = 0

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
	self.vb.ruinerCast = 1--only 1 cast on pull so set this to 1 to handle timer
	self.vb.forgingStrikeCast = 2--Only 1 cast on pull, 2 already passed
	self.vb.reverbStrikeCast = 2
	table.wipe(DemolishTargets)
	timerForgingStrikeCD:Start(3-delay)
	--timerDiabolicBombCD:Start(6.2-delay)
	timerReverberatingStrikeCD:Start(10.3-delay)--10-14
	timerRuinerCD:Start(17.7-delay)--17-22
	--timerShatteringStrikeCD:Start(1-delay)--Not cast on pull
	timerApocProtocolCD:Start(26.2-delay)--26-31
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
	if spellId == 244312 then
		self.vb.forgingStrikeCast = self.vb.forgingStrikeCast + 1
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then--Player is current target
			specWarnForgingStrike:Show()
			voiceForgingStrike:Play("defensive")
		end
		--1.5, 26.9, 33.5
		if self.vb.forgingStrikeCast == 1 then
			timerForgingStrikeCD:Start(26.9)
		elseif self.vb.forgingStrikeCast == 2 then
			timerForgingStrikeCD:Start(33.5)
		end
	elseif spellId == 248475 then
		self:BossTargetScanner(args.sourceGUID, "ReverberatingTarget", 0.1, 9)
		if self:AntiSpam(5, 3) then--Sometimes stutter casts
			--6.5, 22.3, 26.0
			self.vb.reverbStrikeCast = self.vb.reverbStrikeCast + 1
			if self.vb.reverbStrikeCast == 1 then
				timerReverberatingStrikeCD:Start(22.3)
			elseif self.vb.reverbStrikeCast == 2 then
				timerReverberatingStrikeCD:Start(26)
			end
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
		if self.vb.ruinerCast == 1 then
			timerRuinerCD:Start()
		end
	elseif spellId == 246516 then--Apocolypse Protocol
		timerForgingStrikeCD:Stop()
		timerReverberatingStrikeCD:Stop()
		--timerDiabolicBombCD:Stop()
		timerRuinerCD:Stop()
		--timerShatteringStrikeCD:Stop()
		specWarnInitializing:Show()
		voiceInitializing:Play("killmob")
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
	if spellId == 244312 and not args:IsPlayer() and not UnitDebuff("player", args.spellName) then
		specWarnForgingStrikeOther:Show(args.destName)
		voiceForgingStrike:Play("tauntboss")
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
			self:Schedule(0.5, warnDemolishTargets, self, args.spellName)--At least 0.5, maybe bigger needed if warning still splits
		--end
		if args:IsPlayer() then
			specWarnDemolish:Show()
			voiceDemolish:Play("targetyou")
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellDemolishFades:Countdown(remaining)
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
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
		--timerForgingStrikeCD:Start(1.5)--Used too fast for a timer
		timerReverberatingStrikeCD:Start(6.5)
		--timerDiabolicBombCD:Start(2)
		timerRuinerCD:Start(20.2)
		--timerShatteringStrikeCD:Start(42)
		timerApocProtocolCD:Start()
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
