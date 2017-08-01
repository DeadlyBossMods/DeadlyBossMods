local mod	= DBM:NewMod(2004, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(125050)
mod:SetEncounterID(2088)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244312 248475 248375 245807 252758 246692",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 244312 244410 245770 246687 252797 246516 246698 252760",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 244410 245770 246687 252797 246516 246698 252760",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, see if Reverberating Strike can be on anyone or just another tank only mechanic (determines what kind of range frame we need)
--TODO, how does mythic reverberating decimatino work (18 yard spread?)
--TODO, analyze DiabolicBomb
--TODO, work in http://ptr.wowhead.com/spell=246504/initializing somehow
--TODO, how to detect http://ptr.wowhead.com/spell=249920/weapons-upgrade
--TODO, workin http://ptr.wowhead.com/spell=246629/apocalypse-blast
--TODO, more work on infoframe for fel reaver construction status, etc.
--Stage: Deployment
local warnRuiner						= mod:NewTargetAnnounce(246840, 3)
local warnShatteringStrike				= mod:NewSpellAnnounce(248375, 2)
--Reavers (or empowered boss from reaver deaths)
local warnDecimation					= mod:NewTargetAnnounce(244410, 4)
local warnDemolish						= mod:NewTargetAnnounce(246692, 4)

--Stage: Deployment
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnForgingStrike				= mod:NewSpecialWarningDefensive(244312, nil, nil, nil, 1, 2)
local specWarnForgingStrikeOther		= mod:NewSpecialWarningTaunt(244312, nil, nil, nil, 1, 2)
local specWarnReverberatingStrike		= mod:NewSpecialWarningDodge(248475, nil, nil, nil, 2, 2)
local specWarnDiabolicBomb				= mod:NewSpecialWarningDodge(246779, nil, nil, nil, 2, 2)
local specWarnRuiner					= mod:NewSpecialWarningMoveAway(246840, nil, nil, nil, 1, 2)
local yellRuiner						= mod:NewPosYell(246840)
--Stage: Construction
local specWarnInitializing				= mod:NewSpecialWarningSwitch(246504, nil, nil, nil, 1, 2)
--Reavers (or empowered boss from reaver deaths)
local specWarnDecimation				= mod:NewSpecialWarningMoveAway(244410, nil, nil, nil, 3, 2)
local yellDecimation					= mod:NewShortFadesYell(244410)
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(245807, nil, nil, nil, 2, 2)
local specWarnDemolish					= mod:NewSpecialWarningYou(246692, nil, nil, nil, 1, 2)
local specWarnDemolishOther				= mod:NewSpecialWarningMoveTo(246692, nil, nil, nil, 1, 2)
local yellDemolish						= mod:NewPosYell(246692)
local yellDemolishFades					= mod:NewShortFadesYell(246692)

--Stage: Deployment
local timerForgingStrikeCD				= mod:NewAITimer(25, 244312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReverberatingStrikeCD		= mod:NewAITimer(61, 248475, nil, nil, nil, 3)
local timerDiabolicBombCD				= mod:NewAITimer(61, 246779, nil, nil, nil, 3)
local timerRuinerCD						= mod:NewAITimer(30, 246840, nil, nil, nil, 3)
local timerShatteringStrikeCD			= mod:NewAITimer(30, 248375, nil, nil, nil, 2)
local timerApocProtocolCD				= mod:NewAITimer(30, 246516, nil, nil, nil, 6)
--Stage: Construction
--local timerCleansingProtocolCD		= mod:NewAITimer(30, 248061, nil, nil, nil, 6)
--Reavers (or empowered boss from reaver deaths)
--local timerDecimationCD				= mod:NewAITimer(30, 244410, nil, nil, nil, 3)
--local timerAnnihilationCD				= mod:NewAITimer(30, 245807, nil, nil, nil, 3)
--local timerDemolishCD					= mod:NewAITimer(34, 246692, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage: Deployment
--local countdownSingularity			= mod:NewCountdown(50, 235059)

--Stage: Deployment
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
local voiceForgingStrike				= mod:NewVoice(244312)--defensive
local voiceReverberatingStrike			= mod:NewVoice(248475)--watchstep
local voiceDiabolicBomb					= mod:NewVoice(246779)--watchstep/watchorb?
local voiceRuiner						= mod:NewVoice(246840)--runout
local voiceInitializing					= mod:NewVoice(246504)--killmob
--Reavers (or empowered boss from reaver deaths)
local voiceDecimation					= mod:NewVoice(244410)--runout
local voiceAnnihilation					= mod:NewVoice(245807)--helpsoak
local voiceDemolish						= mod:NewVoice(246692)--gathershare/targetyou

mod:AddSetIconOption("SetIconOnDemolish", 246692, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddRangeFrameOption(5, 248475)--?

local DemolishTargets = {}
local playerName = DBM:GetMyPlayerInfo()

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
	table.wipe(DemolishTargets)
	timerForgingStrikeCD:Start(1-delay)
	timerReverberatingStrikeCD:Start(1-delay)
	timerDiabolicBombCD:Start(1-delay)
	timerRuinerCD:Start(1-delay)
	timerShatteringStrikeCD:Start(1-delay)
	timerApocProtocolCD:Start(1-delay)
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
		timerForgingStrikeCD:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then--Player is current target
			specWarnForgingStrike:Show()
			voiceForgingStrike:Play("defensive")
		end
	elseif spellId == 248475 then
		specWarnReverberatingStrike:Show()
		voiceReverberatingStrike:Play("watchstep")
		timerReverberatingStrikeCD:Start()
	elseif spellId == 248375 then
		warnShatteringStrike:Show()
		timerShatteringStrikeCD:Start()
	elseif spellId == 245807 then
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
	elseif spellId == 252758 or spellId == 246692 then
		table.wipe(DemolishTargets)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 236378 then
	
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244312 and not args:IsPlayer() and not UnitDebuff("player", args.spellName) then
		specWarnForgingStrikeOther:Show(args.destName)
		voiceForgingStrike:Play("tauntboss")
	elseif (spellId == 244410 or spellId == 245770 or spellId == 246687 or spellId == 252797) and args:IsDestTypePlayer() then--244410 3 seconds, rest 5, for good measure, just pulling duration from UnitDebuff()
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			voiceDecimation:Play("runout")
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			yellDecimation:Countdown(remaining)
		end
	elseif spellId == 246516 then--Apocolypse Protocol
		timerForgingStrikeCD:Stop()
		timerReverberatingStrikeCD:Stop()
		timerDiabolicBombCD:Stop()
		timerRuinerCD:Stop()
		timerShatteringStrikeCD:Stop()
		specWarnInitializing:Show()
		voiceInitializing:Play("killmob")
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
			yellDecimation:Cancel()
		end
	elseif spellId == 246516 then--Apocolypse Protocol
		timerForgingStrikeCD:Start(2)
		timerReverberatingStrikeCD:Start(2)
		timerDiabolicBombCD:Start(2)
		timerRuinerCD:Start(2)
		timerShatteringStrikeCD:Start(2)
		timerApocProtocolCD:Start(2)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

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
			--[[if self.Options.SetIconOnRuiner then
				self:SetIcon(targetName, icon, 5)
			end
			if targetName == playerName then
				yellRuiner:Yell(icon, icon, icon)
			end
			self.vb.bladesIcon = self.vb.bladesIcon + 1--]]
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 248214 then--Diabolic Bomb
		specWarnDiabolicBomb:Show()
		voiceDiabolicBomb:Play("watchstep")
		timerDiabolicBombCD:Start()
	elseif spellId == 246798 then--Ruiner
		timerRuinerCD:Start()
	end
end
