local mod	= DBM:NewMod(2004, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122578)
mod:SetEncounterID(2088)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(16945)
mod:SetMinSyncRevision(16975)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244312 254926 245807 252758 246692 246833 246516 257978 254919",
	"SPELL_CAST_SUCCESS 252758 246692 248214",
	"SPELL_AURA_APPLIED 254919 257978 246687 249680 246698 252760",
	"SPELL_AURA_APPLIED_DOSE 254919 257978",
	"SPELL_AURA_REMOVED 246687 249680 246516 246698 252760",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, how does mythic reverberating decimatino work (18 yard spread?)
--TODO, analyze DiabolicBomb
--TODO, how to detect http://ptr.wowhead.com/spell=249920/weapons-upgrade
--TODO, workin http://ptr.wowhead.com/spell=246629/apocalypse-blast
--TODO, more work on infoframe for fel reaver construction status, etc.
--TODO, currently annihilation are only detectable via nameplate/target casts as such, it's pretty bad idea to support it unless it's really required
--[[
(ability.id = 244312 or ability.id = 254926 or ability.id = 245807 or ability.id = 252758 or ability.id = 246692 or ability.id = 246833 or ability.id = 246516 or ability.id = 257997 or ability.id = 257978 or ability.id = 254919) and type = "begincast"
 or (ability.id = 252758 or ability.id = 246692 or ability.id = 248214) and type = "cast"
 or (ability.id = 246516 or ability.id = 246698 or ability.id = 252760) and (type = "removebuff" or type = "removedebuff")
--]]
--Stage: Deployment
local warnShatteringStrike				= mod:NewSpellAnnounce(248375, 2)
local warnDiabolicBomb					= mod:NewSpellAnnounce(246779, 3, nil, nil, nil, nil, nil, 2)
local warnReverberatingStrike			= mod:NewTargetAnnounce(254926, 3)
--Reavers (or empowered boss from reaver deaths)
local warnDecimation					= mod:NewTargetAnnounce(246687, 4)
local warnDemolish						= mod:NewTargetAnnounce(246692, 4)

--Stage: Deployment
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
local specWarnForgingStrike				= mod:NewSpecialWarningDefensive(244312, nil, nil, nil, 1, 2)
local specWarnForgingStrikeOther		= mod:NewSpecialWarningTaunt(244312, nil, nil, nil, 1, 2)
local specWarnReverberatingStrike		= mod:NewSpecialWarningYou(254926, nil, nil, nil, 1, 2)
local yellReverberatingStrike			= mod:NewYell(254926)
local specWarnReverberatingStrikeNear	= mod:NewSpecialWarningClose(254926, nil, nil, nil, 1, 2)
local specWarnRuiner					= mod:NewSpecialWarningDodge(246840, nil, nil, nil, 3, 2)
--Stage: Construction
local specWarnInitializing				= mod:NewSpecialWarningSwitch(246504, nil, nil, nil, 1, 2)
--Reavers (or empowered boss from reaver deaths)
local specWarnDecimation				= mod:NewSpecialWarningMoveAway(246687, nil, nil, nil, 1, 2)
local yellDecimation					= mod:NewShortFadesYell(246687)
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(245807, nil, nil, nil, 2, 2)
local specWarnDemolish					= mod:NewSpecialWarningYou(246692, nil, nil, nil, 1, 2)
local specWarnDemolishOther				= mod:NewSpecialWarningMoveTo(246692, nil, nil, nil, 1, 2)
local yellDemolish						= mod:NewPosYell(246692)
local yellDemolishFades					= mod:NewIconFadesYell(246692)

--Stage: Deployment
mod:AddTimerLine(BOSS)
local timerForgingStrikeCD				= mod:NewCDTimer(14.3, 244312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReverberatingStrikeCD		= mod:NewCDCountTimer(28, 254926, nil, nil, nil, 3)
local timerDiabolicBombCD				= mod:NewCDTimer(20, 246779, nil, nil, nil, 3)
local timerRuinerCD						= mod:NewCDCountTimer(28.8, 246840, nil, nil, nil, 3)
--local timerShatteringStrikeCD			= mod:NewCDTimer(30, 248375, nil, nil, nil, 2)
local timerApocProtocolCD				= mod:NewCDCountTimer(77, 246516, nil, nil, nil, 6)
--Stage: Construction
mod:AddTimerLine(DBM_ADDS)
local timerInitializing					= mod:NewCastTimer(30, 246504, nil, nil, nil, 6)
local timerDecimationCD					= mod:NewCDTimer(10.9, 246687, nil, nil, nil, 3)
local timerAnnihilationCD				= mod:NewCDTimer(15.4, 245807, nil, nil, nil, 3)
local timerDemolishCD					= mod:NewCDTimer(15.8, 246692, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage: Deployment
local countdownApocProtocol				= mod:NewCountdown(77, 246516)
local countdownForgingStrike			= mod:NewCountdown("Alt14", 244312, "Tank", nil, 3)
local countdownRuiner					= mod:NewCountdown("AltTwo29", 246840)

mod:AddSetIconOption("SetIconOnDemolish", 246692, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("UseAddTime", true)
mod:AddRangeFrameOption(5, 254926)--?

mod.vb.ruinerCast = 0
mod.vb.forgingStrikeCast = 0
mod.vb.reverbStrikeCast = 0
mod.vb.apocProtoCount = 0
mod.vb.ruinerTimeLeft = 0
mod.vb.reverbTimeLeft = 0
mod.vb.forgingTimeLeft = 0
mod.vb.bombTimeLeft = 0

local DemolishTargets = {}
local playerName = DBM:GetMyPlayerInfo()

function mod:ReverberatingTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnReverberatingStrike:Show()
		specWarnReverberatingStrike:Play("targetyou")
		yellReverberatingStrike:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnReverberatingStrikeNear:Show(targetname)
		specWarnReverberatingStrikeNear:Play("runaway")
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
	if not UnitDebuff("player", spellName) and not self:IsTank() then
		specWarnDemolishOther:Show(DBM_ALLY)
		specWarnDemolishOther:Play("gathershare")
	end
end

local demolishDebuff = DBM:GetSpellInfo(246692)
local updateInfoFrame
do
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

--/run DBM:GetModByName("2004"):TestFunction(20)
function mod:TestFunction(time)
	timerForgingStrikeCD:AddTime(time, 1)
	timerDiabolicBombCD:AddTime(time)
	timerRuinerCD:AddTime(time, self.vb.ruinerCast+1)
	timerReverberatingStrikeCD:AddTime(time, 1)
end

function mod:OnCombatStart(delay)
	demolishDebuff = DBM:GetSpellInfo(246692)
	self.vb.ruinerCast = 0
	self.vb.forgingStrikeCast = 0
	self.vb.reverbStrikeCast = 0
	self.vb.apocProtoCount = 0
	self.vb.ruinerTimeLeft = 0
	self.vb.reverbTimeLeft = 0
	self.vb.forgingTimeLeft = 0
	self.vb.bombTimeLeft = 0
	table.wipe(DemolishTargets)
	timerForgingStrikeCD:Start(6-delay, 1)--6-7
	countdownForgingStrike:Start(6-delay)
	timerDiabolicBombCD:Start(11-delay)
	timerReverberatingStrikeCD:Start(14.2-delay, 1)--14-15
	timerRuinerCD:Start(21.1-delay, 1)--21-25
	countdownRuiner:Start(21.1-delay)
	--timerShatteringStrikeCD:Start(1-delay)--Not cast on pull
	timerApocProtocolCD:Start(31.8-delay, 1)--31.8-36.5
	countdownApocProtocol:Start(31.8)
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
			specWarnForgingStrike:Play("defensive")
		end
		--1.5, 27.6, 30.1
		if self:IsLFR() then
			timerForgingStrikeCD:Start(8.5, self.vb.forgingStrikeCast+1)
		else
			timerForgingStrikeCD:Start(14.6, self.vb.forgingStrikeCast+1)
			countdownForgingStrike:Start(14.6)
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
		specWarnAnnihilation:Play("helpsoak")
	elseif spellId == 252758 or spellId == 246692 then
		table.wipe(DemolishTargets)
	elseif spellId == 246833 then--Ruiner
		self.vb.ruinerCast = self.vb.ruinerCast + 1
		timerForgingStrikeCD:Cancel()
		countdownForgingStrike:Cancel()
		specWarnRuiner:Show()
		specWarnRuiner:Play("farfromline")
		specWarnRuiner:ScheduleVoice(1.5, "keepmove")
		timerRuinerCD:Start(nil, self.vb.ruinerCast+1)--28-30 depending on difficulty
		countdownRuiner:Start(29.1)
		timerForgingStrikeCD:Start(10, self.vb.forgingStrikeCast+1)
		countdownForgingStrike:Start()
	elseif spellId == 246516 and self:IsInCombat() then--Apocolypse Protocol
		self.vb.ruinerTimeLeft = timerRuinerCD:GetRemaining(self.vb.ruinerCast+1)
		self.vb.reverbTimeLeft = timerReverberatingStrikeCD:GetRemaining(self.vb.reverbStrikeCast+1)
		self.vb.forgingTimeLeft = timerForgingStrikeCD:GetRemaining(self.vb.forgingStrikeCast+1)
		self.vb.bombTimeLeft = timerDiabolicBombCD:GetRemaining()
		countdownForgingStrike:Cancel()
		countdownRuiner:Cancel()
		if self.Options.UseAddTime then
			timerDiabolicBombCD:AddTime(42.3)
			timerRuinerCD:AddTime(42.3, self.vb.ruinerCast+1)
			countdownRuiner:Start(self.vb.ruinerTimeLeft+42.3)
			timerReverberatingStrikeCD:AddTime(42.3, self.vb.reverbStrikeCast+1)
			timerForgingStrikeCD:AddTime(42.3, self.vb.forgingStrikeCast+1)
			countdownForgingStrike:Start(self.vb.forgingTimeLeft+42.3)
		else--times are stored in variables so can stop timers now
			timerForgingStrikeCD:Stop()
			timerReverberatingStrikeCD:Stop()
			timerRuinerCD:Stop()
			timerDiabolicBombCD:Stop()
		end
		--timerDiabolicBombCD:Stop()
		--timerShatteringStrikeCD:Stop()
		specWarnInitializing:Show()
		specWarnInitializing:Play("killmob")
		if self:IsLFR() then
			timerInitializing:Start(42.3)
		else
			timerInitializing:Start(32.3)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 252758 or spellId == 246692 then
		timerDemolishCD:Start(nil, args.sourceGUID)
	elseif spellId == 248214 then
		warnDiabolicBomb:Show()
		warnDiabolicBomb:Play("bombsoon")
		timerDiabolicBombCD:Start()
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
				specWarnForgingStrikeOther:Play("changemt")
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
					specWarnForgingStrikeOther:Play("tauntboss")
				end
			end
		end
	elseif spellId == 246687 or spellId == 249680 then
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDecimation:Show()
			specWarnDecimation:Play("runout")
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellDecimation:Countdown(remaining)
			end
		end
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
			specWarnDemolish:Play("targetyou")
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
	if spellId == 246687 or spellId == 249680 then
		if args:IsPlayer() then
			yellDecimation:Cancel()
		end
	elseif spellId == 246516 and self:IsInCombat() then--Apocolypse Protocol
		self.vb.apocProtoCount = self.vb.apocProtoCount + 1
		if self.vb.apocProtoCount % 2 == 1 then
			DBM:Debug("Reverb first", 2)
		else
			DBM:Debug("Ruiner first", 2)
		end
		if not self.Options.UseAddTime then
			--Restore timers with stored times
			if self.vb.ruinerTimeLeft > 0 then
				timerRuinerCD:Start(self.vb.ruinerTimeLeft, self.vb.ruinerCast+1)
				countdownRuiner:Start(self.vb.ruinerTimeLeft)
			end
			if self.vb.reverbTimeLeft > 0 then
				timerReverberatingStrikeCD:Start(self.vb.reverbTimeLeft-1, self.vb.reverbStrikeCast+1)
			end
			if self.vb.forgingTimeLeft > 0 then
				timerForgingStrikeCD:Start(self.vb.forgingTimeLeft, self.vb.forgingStrikeCast+1)
				countdownForgingStrike:Start(self.vb.forgingTimeLeft)
			end
			if self.vb.bombTimeLeft > 0 then
				timerDiabolicBombCD:Start(self.vb.bombTimeLeft)
			end
		end
		--timerDiabolicBombCD:Start(2)
		--timerShatteringStrikeCD:Start(42)
		timerApocProtocolCD:Start(77, self.vb.apocProtoCount+1)--77
		countdownApocProtocol:Start(77)
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
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 248319 then--Consume Energy 100% (reaver fully charged and activated)
		--Info Frame usage situation?
	elseif spellId == 246686 then--Decimation (ignore 246691 I'm pretty sure)
		--specWarnDecimation:Show()
		--specWarnDecimation:Play("scatter")
		timerDecimationCD:Start(nil, UnitGUID(uId))
	elseif spellId == 246657 then--Annihilation
		specWarnAnnihilation:Show()
		specWarnAnnihilation:Play("helpsoak")
		timerAnnihilationCD:Start(nil, UnitGUID(uId))
	elseif spellId == 248375 and self:AntiSpam(5, 2) then--Shattering Strike
		warnShatteringStrike:Show()
		--timerShatteringStrikeCD:Start()
	end
end
