local mod	= DBM:NewMod(2167, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135452)--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
mod:SetEncounterID(2141)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267787 268198",
	"SPELL_CAST_SUCCESS 267795 267945 267885 267878 269827 268089 277973 277961 277742",
	"SPELL_AURA_APPLIED 267787 274205 269051",
	"SPELL_AURA_APPLIED_DOSE 267787",
	"SPELL_SUMMON 268871"
)

--More mythic timer work
--[[
ability.id = 267787 and type = "begincast"
 or (ability.id = 267795 or ability.id = 267945 or ability.id = 269827 or ability.id = 277973 or ability.id = 277961 or ability.id = 268089 or ability.id = 277742) and type = "cast"
 or ability.id = 269051 and type = "applybuff"
--]]
local warnSanitizingStrike				= mod:NewStackAnnounce(267787, 3, nil, "Tank")
local warnWindTunnel					= mod:NewSpellAnnounce(267945, 2)
local warnDepletedEnergy				= mod:NewSpellAnnounce(274205, 1)
local warnCleansingPurgeFinish			= mod:NewTargetNoFilterAnnounce(268095, 4)

local specWarnSanitizingStrike			= mod:NewSpecialWarningDodge(267787, nil, nil, nil, 1, 2)
local specWarnPurifyingFlame			= mod:NewSpecialWarningDodge(267795, nil, nil, nil, 2, 2)
local specWarnClingingCorruption		= mod:NewSpecialWarningInterrupt(268198, "HasInterrupt", nil, nil, 1, 2)
local specWarnSurgicalBeam				= mod:NewSpecialWarningDodgeLoc(269827, nil, nil, nil, 3, 2)

--mod:AddTimerLine(Nexus)
local timerSanitizingStrikeCD			= mod:NewNextTimer(23.1, 267787, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPurifyingFlameCD				= mod:NewNextTimer(20.1, 267795, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerWindTunnelCD					= mod:NewNextTimer(39.8, 267945, nil, nil, nil, 2)
local timerSurgicalBeamCD				= mod:NewCDSourceTimer(30, 269827, 143444, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--Shortname "Laser"
local timerCleansingFlameCD				= mod:NewCastSourceTimer(180, 268095, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPurifyingFlame			= mod:NewCountdown(20, 267795, true, nil, 3)
local countdownSanitizingStrike			= mod:NewCountdown("Alt23", 267787, "Tank", nil, 3)
local countdownSurgicalBeam				= mod:NewCountdown("AltTwo30", 269827, nil, nil, 3)

mod:AddInfoFrameOption(268095, true)
mod:AddSetIconOption("SetIconOnAdds", 268871, true, true)

mod.vb.startIcon = 1
mod.vb.phase = 1
mod.vb.bossInICD = false
mod.vb.nextLaser = 1--1 side 2 top

local function clearBossICD(self)
	self.vb.bossInICD = false
end

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
	if timerSanitizingStrikeCD:GetRemaining() < ICD then
		local elapsed, total = timerSanitizingStrikeCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSanitizingStrikeCD extended by: "..extend, 2)
		timerSanitizingStrikeCD:Stop()
		timerSanitizingStrikeCD:Update(elapsed, total+extend)
		countdownSanitizingStrike:Cancel()
		countdownSanitizingStrike:Start(ICD)
	end
	if timerWindTunnelCD:GetRemaining() < ICD then
		local elapsed, total = timerWindTunnelCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerWindTunnelCD extended by: "..extend, 2)
		timerWindTunnelCD:Stop()
		timerWindTunnelCD:Update(elapsed, total+extend)
	end
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
		--Player personal checks
		--local spellName, _, _, _, _, expireTime = DBM:UnitDebuff("player", 267821)
		--if spellName and expireTime then--Personal Defense Grid. Same spellId is used for going through and lingering, but expire time will only exist for lingering
			--local remaining = expireTime-GetTime()
			--addLine(spellName, remaining)
		--end
		--TODO, player tracking per chamber if possible
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.startIcon = 1
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
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
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
		updateAllTimers(self, 4.9)
	elseif spellId == 268198 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnClingingCorruption:Show(args.sourceName)
		specWarnClingingCorruption:Play("kickcast")
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
		timerWindTunnelCD:Show()--40-47
	elseif spellId == 269827 or spellId == 277973 or spellId == 277961 or spellId == 277742 then
		if spellId == 277961 or spellId == 277742 or spellId == 269827 then--Top (277961 mythic chamber 2, 277742 heroic Chamber 2, 269827 heroic chamber 3)
			specWarnSurgicalBeam:Show(DBM_CORE_TOP)
			--Next Beam side
			timerSurgicalBeamCD:Start(16, DBM_CORE_SIDE)
			countdownSurgicalBeam:Start(16)
			self.vb.nextLaser = 1
		else--Sides (277973 all)
			specWarnSurgicalBeam:Show(DBM_CORE_SIDE)
			if self:IsEasy() then--No top down lasers in LFR/Normal, but side happen more often
				timerSurgicalBeamCD:Start(30, DBM_CORE_SIDE)--30-31
				countdownSurgicalBeam:Start(30)
				self.vb.nextLaser = 1
			else
				self.vb.nextLaser = 2
				if self.vb.phase == 3 then
					timerSurgicalBeamCD:Start(24, DBM_CORE_TOP)
					countdownSurgicalBeam:Start(24)
				else--TODO, confirm it's 30 here and not just always delayed by 6/5 second ICD
					timerSurgicalBeamCD:Start(30, DBM_CORE_TOP)
					countdownSurgicalBeam:Start(30)
				end
			end
		end
		specWarnSurgicalBeam:Play("watchstep")--laserrun wasn't quite right, cause it says "on you" Needed "laser, run" not "laser on you, run"
	elseif spellId == 268089 and self:AntiSpam(3, 1) then--End Cast of Cleansing Purge
		warnCleansingPurgeFinish:Show(args.sourceName)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 268871 then
		if self.Options.SetIconOnAdds then--136949 CID
			self:ScanForMobs(args.sourceGUID, 2, self.vb.startIcon, 1, 0.2, 10, "SetIconOnAdds")
		end
		self.vb.startIcon = self.vb.startIcon + 1
		if self.vb.startIcon == 9 then self.vb.startIcon = 1 end
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
