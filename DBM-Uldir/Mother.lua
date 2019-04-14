local mod	= DBM:NewMod(2167, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetCreatureID(135452)--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
mod:SetEncounterID(2141)
mod:DisableESCombatDetection()--ES breaks if you pull boss through door to skip trash. Then after that the trash bugs and continues to throw ES events even after mother is defeated
mod:SetZone()
mod:SetHotfixNoticeRev(17778)
mod:SetMinSyncRevision(18111)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267787 268198 279669",
	"SPELL_CAST_SUCCESS 267795 267945 267885 267878 269827 268089 277973 277961 277742",
	"SPELL_AURA_APPLIED 267787 274205 269051 279662 279663",
	"SPELL_AURA_APPLIED_DOSE 267787",
	"SPELL_AURA_REMOVED 279662 279663"
)

--[[
ability.id = 267787 and type = "begincast"
 or (ability.id = 267795 or ability.id = 267945 or ability.id = 269827 or ability.id = 277973 or ability.id = 277961 or ability.id = 268089 or ability.id = 277742) and type = "cast"
 or ability.id = 269051 and type = "applybuff"
--]]
local warnSanitizingStrike				= mod:NewStackAnnounce(267787, 3, nil, "Tank")
local warnWindTunnel					= mod:NewSpellAnnounce(267945, 2)
local warnDepletedEnergy				= mod:NewSpellAnnounce(274205, 1)
local warnCleansingPurgeFinish			= mod:NewTargetNoFilterAnnounce(268095, 4)
local warnBacterialOutbreak				= mod:NewSpellAnnounce(279669, 3)

local specWarnSanitizingStrike			= mod:NewSpecialWarningDodge(267787, nil, nil, nil, 1, 2)
local specWarnPurifyingFlame			= mod:NewSpecialWarningDodge(267795, nil, nil, nil, 2, 2)
local specWarnClingingCorruption		= mod:NewSpecialWarningInterrupt(268198, "HasInterrupt", nil, nil, 1, 2)
local specWarnSurgicalBeam				= mod:NewSpecialWarningDodgeLoc(269827, nil, nil, nil, 3, 2)
local specWarnEndemicVirus				= mod:NewSpecialWarningMoveAway(279662, nil, nil, nil, 1, 2)
local yellEndemicVirus					= mod:NewYell(279662)
local yellEndemicVirusFades				= mod:NewShortFadesYell(279662)
local specWarnSpreadingEpidemic			= mod:NewSpecialWarningMoveAway(279663, nil, nil, nil, 1, 2)
local yellSpreadingEpidemic				= mod:NewYell(279663)

--mod:AddTimerLine(Nexus)
local timerSanitizingStrikeCD			= mod:NewNextTimer(23.1, 267787, 191540, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Short name "Strike"
local timerPurifyingFlameCD				= mod:NewNextTimer(20.1, 267795, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerWindTunnelCD					= mod:NewNextTimer(39.5, 267945, nil, nil, nil, 2)
local timerSurgicalBeamCD				= mod:NewCDSourceTimer(30, 269827, 143444, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--Shortname "Laser"
local timerCleansingFlameCD				= mod:NewCastSourceTimer(180, 268095, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPurifyingFlame			= mod:NewCountdown(20, 267795, true, nil, 3)
local countdownSanitizingStrike			= mod:NewCountdown("Alt23", 267787, "Tank", nil, 3)
local countdownSurgicalBeam				= mod:NewCountdown("AltTwo30", 269827, nil, nil, 3)

mod:AddInfoFrameOption(268095, true)
mod:AddRangeFrameOption(5, 272407)

mod.vb.phase = 1
mod.vb.bossInICD = false
mod.vb.nextLaser = 1--1 side 2 top

local function clearBossICD(self)
	self.vb.bossInICD = false
end

--All timers are affected by other timers, EXCEPT tank ability, that is always cast regardless of ICD
local function updateAllTimers(self, ICD)
	self.vb.bossInICD = true
	self:Unschedule(clearBossICD)
	self:Schedule(ICD, clearBossICD, self)
	DBM:Debug("updateAllTimers running", 3)
	if timerPurifyingFlameCD:GetRemaining() < ICD then
		local elapsed, total = timerPurifyingFlameCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerPurifyingFlameCD extended by: "..extend, 2)
		timerPurifyingFlameCD:Stop()
		timerPurifyingFlameCD:Update(elapsed, total+extend)
		countdownPurifyingFlame:Cancel()
		countdownPurifyingFlame:Start(ICD)
	end
	if timerWindTunnelCD:GetRemaining() < ICD then
		local elapsed, total = timerWindTunnelCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerWindTunnelCD extended by: "..extend, 2)
		timerWindTunnelCD:Stop()
		timerWindTunnelCD:Update(elapsed, total+extend)
	end
	if self.vb.phase >= 2 then
		if self:IsMythic() then
			if timerSurgicalBeamCD:GetRemaining(DBM_CORE_BOTH) < ICD then
				local elapsed, total = timerSurgicalBeamCD:GetTime(DBM_CORE_BOTH)
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerSurgicalBeamCD BOTH extended by: "..extend, 2)
				timerSurgicalBeamCD:Stop()
				timerSurgicalBeamCD:Update(elapsed, total+extend, DBM_CORE_BOTH)
				countdownSurgicalBeam:Cancel()
				countdownSurgicalBeam:Start(ICD)
			end
		else
			if (self.vb.nextLaser == 1) and timerSurgicalBeamCD:GetRemaining(DBM_CORE_SIDE) < ICD then
				local elapsed, total = timerSurgicalBeamCD:GetTime(DBM_CORE_SIDE)
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerSurgicalBeamCD SIDE extended by: "..extend, 2)
				timerSurgicalBeamCD:Stop()
				timerSurgicalBeamCD:Update(elapsed, total+extend, DBM_CORE_SIDE)
				countdownSurgicalBeam:Cancel()
				countdownSurgicalBeam:Start(ICD)
			end
			if (self.vb.nextLaser == 2) and timerSurgicalBeamCD:GetRemaining(DBM_CORE_TOP) < ICD then
				local elapsed, total = timerSurgicalBeamCD:GetTime(DBM_CORE_TOP)
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerSurgicalBeamCD TOP extended by: "..extend, 2)
				timerSurgicalBeamCD:Stop()
				timerSurgicalBeamCD:Update(elapsed, total+extend, DBM_CORE_TOP)
				countdownSurgicalBeam:Cancel()
				countdownSurgicalBeam:Start(ICD)
			end
		end
	end
end

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
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				if currentPower / maxPower * 100 >= 1 then
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		--TODO, player tracking per chamber if possible
		return lines, sortedLines
	end
end

local updateRangeFrame
do
	local function debuffFilter(uId)
		if DBM:UnitDebuff(uId, 279662, 279663) then--Endemic Virus, Spreading Epidemic
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if DBM:UnitDebuff("player", 279662, 279663) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.bossInICD = false
	self.vb.nextLaser = 1--1 side 2 top
	timerSanitizingStrikeCD:Start(5.9-delay)
	countdownSanitizingStrike:Start(5.9-delay)
	timerPurifyingFlameCD:Start(10.8-delay)
	countdownPurifyingFlame:Start(10.8-delay)
	timerWindTunnelCD:Start(20.6-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, false)
	end
	if self:AntiSpam(3, 1) then
		--Do nothing
	end
	if self:IsMythic() then
		updateRangeFrame(self)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267787 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSanitizingStrike:Show()
			specWarnSanitizingStrike:Play("shockwave")
		end
		timerSanitizingStrikeCD:Start()
		countdownSanitizingStrike:Start()
		updateAllTimers(self, 4.8)
	elseif spellId == 268198 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnClingingCorruption:Show(args.sourceName)
		specWarnClingingCorruption:Play("kickcast")
	elseif spellId == 279669 then
		warnBacterialOutbreak:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267795 then
		specWarnPurifyingFlame:Show()
		specWarnPurifyingFlame:Play("watchstep")
		timerPurifyingFlameCD:Start()
		countdownPurifyingFlame:Start()
		updateAllTimers(self, 6)
	elseif spellId == 267878 then--Directional IDs for winds (Coming from east blowing to west?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267885 then--Directional IDs for winds (Coming from west blowing to east?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267945 then--Global Id for winds
		warnWindTunnel:Show()
		timerWindTunnelCD:Start()--40 unless delayed by ICD
		updateAllTimers(self, 5.6)
	elseif spellId == 269827 or spellId == 277973 or spellId == 277961 or spellId == 277742 then
		if self:IsMythic() then--All the things
			specWarnSurgicalBeam:Show(DBM_CORE_BOTH)
			if self.vb.phase == 3 then
				timerSurgicalBeamCD:Start(20.5, DBM_CORE_BOTH)--20, but almost always delayed by ICD
				countdownSurgicalBeam:Start(20.5)
			else
				timerSurgicalBeamCD:Start(50, DBM_CORE_BOTH)--50, but often delayed by ICD
				countdownSurgicalBeam:Start(50)
			end
			updateAllTimers(self, 8.5)
		elseif self:IsEasy() then--Only side
			specWarnSurgicalBeam:Show(DBM_CORE_SIDE)
			timerSurgicalBeamCD:Start(30, DBM_CORE_SIDE)--30-31
			countdownSurgicalBeam:Start(30)
			self.vb.nextLaser = 1
			updateAllTimers(self, 8.5)
		else--Heroic (alternating)
			if spellId == 277961 or spellId == 277742 or spellId == 269827 then--Top spellIds
				specWarnSurgicalBeam:Show(DBM_CORE_TOP)
				--Next Beam side
				timerSurgicalBeamCD:Start(11, DBM_CORE_SIDE)--Usually delayed, but yes it's 11
				countdownSurgicalBeam:Start(11)
				self.vb.nextLaser = 1
				updateAllTimers(self, 10.9)--Top down beams on non mythic granted even MORE extend
			else--Sides (277973 all)
				specWarnSurgicalBeam:Show(DBM_CORE_SIDE)
				self.vb.nextLaser = 2
				if self.vb.phase == 3 then
					timerSurgicalBeamCD:Start(24, DBM_CORE_TOP)
					countdownSurgicalBeam:Start(24)
				else--TODO, confirm it's 29 here and not just always delayed by 6/5 second ICD (I'm even more confident it's 24 here too based on watching stream, think it's usually 30 cause of ICD)
					timerSurgicalBeamCD:Start(29, DBM_CORE_TOP)
					countdownSurgicalBeam:Start(29)
				end
				updateAllTimers(self, 8.5)
			end
		end
		specWarnSurgicalBeam:Play("watchstep")--laserrun wasn't quite right, cause it says "on you" Needed "laser, run" not "laser on you, run"
	elseif spellId == 268089 and self:AntiSpam(3, 1) then--End Cast of Cleansing Purge
		warnCleansingPurgeFinish:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267787 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnSanitizingStrike:Show(args.destName, amount)
		end
	elseif spellId == 274205 then
		warnDepletedEnergy:Show()
	elseif spellId == 269051 then--Begin Cast of Cleansing Purge
		--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
		local cid = self:GetCIDFromGUID(args.destGUID)
		local time = self:IsMythic() and 123 or 180
		if cid == 136429 then
			self.vb.phase = 1
			timerCleansingFlameCD:Start(time, 1)
		elseif cid == 137022 then
			self.vb.phase = 2
			timerCleansingFlameCD:Start(time, 2)
			--Example of no strike delay. It's almost always 10 though because of current dps timing and her being in ICD when she transitions, delaying first beam by 5+ seconds
			--However, I'm an overachiever and figured this out first :)
			--"<177.86 23:14:27> [CLEU] SPELL_AURA_APPLIED##nil#Creature-0-3019-1861-22695-137022-00000F4965#Chamber 02#269051#Cleansing Purge#BUFF#nil", -- [4372]
			--"<183.09 23:14:32> [CLEU] SPELL_CAST_SUCCESS#Creature-0-3019-1861-22695-135452-00000F44FF#MOTHER##nil#277973#Uldir Defensive Beam#nil#nil", -- [4534]
			if not self.vb.bossInICD then
				timerSurgicalBeamCD:Start(5, DBM_CORE_SIDE)
			else
				timerSurgicalBeamCD:Start(10, DBM_CORE_SIDE)
			end
		elseif cid == 137023 then
			self.vb.phase = 3
			self.vb.nextLaser = 1
			timerSurgicalBeamCD:Stop()--Resets, kinda
			countdownSurgicalBeam:Cancel()
			timerSurgicalBeamCD:Start(15, DBM_CORE_SIDE)--15 if delayed by nothing, but can be longer if flames ICD gets triggered
			timerCleansingFlameCD:Start(time, 3)
		end
	elseif spellId == 279662 then
		if args:IsPlayer() then
			specWarnEndemicVirus:Show()
			specWarnEndemicVirus:Play("runout")
			yellEndemicVirus:Yell()
			yellEndemicVirusFades:Countdown(20)
			updateRangeFrame(self)
		end
	elseif spellId == 279663 then
		if args:IsPlayer() then
			specWarnSpreadingEpidemic:Show()
			specWarnSpreadingEpidemic:Play("runout")
			yellSpreadingEpidemic:Yell()
			updateRangeFrame(self)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 279662 then
		if args:IsPlayer() then
			updateRangeFrame(self)
			yellEndemicVirusFades:Cancel()
		end
	elseif spellId == 279663 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end
