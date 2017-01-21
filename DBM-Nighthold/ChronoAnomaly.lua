local mod	= DBM:NewMod(1725, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104415)--104731 (Depleted Time Particle). 104676 (Waning Time Particle). 104491 (Accelerated Time particle). 104492 (Slow Time Particle)
mod:SetEncounterID(1865)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)--sometimes it was 5 targets, sometimes it was whole raid. even post nerf. have to see
mod:SetHotfixNoticeRev(15705)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 211927 207228",
	"SPELL_CAST_SUCCESS 219815",
	"SPELL_AURA_APPLIED 206617 206609 207052 207051 206607 211927",
	"SPELL_AURA_APPLIED_DOSE 206607",
	"SPELL_AURA_REMOVED 206617 206609 207052 207051",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1",
	"UNIT_SPELLCAST_STOP boss1"
)

--TODO, figure out how often tanks need to swap, adjust warnings accordingly
--TODO, More data to complete sequences of timers
--TODO, info frame with debuff shield (health) remaining sorted highest to lowest.
--(ability.id = 206618 or ability.id = 206610 or ability.id = 206614) and type = "cast" or ability.id = 211927
local warnTimeBomb					= mod:NewTargetAnnounce(206617, 3)
local warnTimeRelease				= mod:NewTargetAnnounce(206610, 3, nil, false)--Too many targets
local warnChronometricPart			= mod:NewStackAnnounce(206607, 3, nil, "Tank")

local specWarnTemporalOrbs			= mod:NewSpecialWarningDodge(219815, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelmingKick	= mod:NewSpecialWarningInterrupt(211927, "Tank", nil, nil, 3, 2)
local specWarnTimeBomb				= mod:NewSpecialWarningMoveAway(206617, nil, nil, nil, 1, 2)--When close to expiring, not right away
local yellTimeBomb					= mod:NewFadesYell(206617)
local specWarnWarp					= mod:NewSpecialWarningInterrupt(207228, "HasInterrupt", nil, nil, 1, 2)
local specWarnBigAdd				= mod:NewSpecialWarningSwitch(206700, "-Healer", nil, nil, 1, 2)--Switch to waning time particle when section info known
local specWarnSmallAdd				= mod:NewSpecialWarningSwitch(206699, "Tank", nil, nil, 1, 2)

local timerTemporalOrbsCD			= mod:NewNextCountTimer(30, 219815, nil, nil, nil, 2)
local timerPowerOverwhelmingCD		= mod:NewNextCountTimer(60, 211927, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerTimeBomb					= mod:NewBuffFadesTimer(30, 206617, nil, nil, nil, 5)
local timerTimeBombCD				= mod:NewNextCountTimer(30, 206617, nil, nil, nil, 3)
local timerBurstofTimeCD			= mod:NewNextCountTimer(30, 206614, nil, nil, nil, 3)
local timerTimeReleaseCD			= mod:NewNextCountTimer(30, 206610, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerChronoPartCD				= mod:NewCDTimer(5, 206607, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBigAddCD					= mod:NewNextCountTimer(30, 206700, nil, nil, nil, 1)--Switch to waning time particle when section info known
local timerNextPhase				= mod:NewPhaseTimer(74)--Used anywhere phase change is NOT immediately after power overwhelming.

local countdownBigAdd				= mod:NewCountdown(30, 206700)--Switch to waning time particle when section info known
local countdownTimeBomb				= mod:NewCountdownFades("AltTwo30", 206617)

local voiceTemporalOrbs				= mod:NewVoice(219815)--watchstep
local voicePowerOverwhelming		= mod:NewVoice(211927)--kickcast
local voiceTimeBomb					= mod:NewVoice(206617)--scatter
local voiceWarp						= mod:NewVoice(207228, "HasInterrupt")--kickcast
local voiceBigAdd					= mod:NewVoice(206700, "-Healer")
local voiceSmallAdd					= mod:NewVoice(206699, "Tank")

mod:AddRangeFrameOption(10, 206617)
mod:AddInfoFrameOption(206617)
--mod:AddSetIconOption("SetIconOnTimeRelease", 206610, true)

mod.vb.OPActive = false
mod.vb.riftActive = 0
mod.vb.normCount = 0
mod.vb.fastCount = 0
mod.vb.slowCount = 0
mod.vb.currentPhase = 2
mod.vb.interruptCount = 0
mod.vb.timeBombDebuffCount = 0

function mod:OnCombatStart(delay)
	self.vb.OPActive = false
	self.vb.riftActive = 0
	self.vb.currentPhase = 2
	self.vb.interruptCount = 0
	self.vb.normCount = 0
	self.vb.fastCount = 0
	self.vb.slowCount = 0
	self.vb.timeBombDebuffCount = 0
	--No timers here, started by speed events
	if self:IsHeroic() then
		DBM:AddMsg("There is strong chance all timers for Heroic difficulty were changed. If they are all wrong, I'll fix them as soon as I can. ")
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
	if spellId == 211927 then
		timerChronoPartCD:Stop()--Will be used immediately when this ends.
	elseif spellId == 207228 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnWarp:Show(args.sourceName)
		voiceWarp:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 219815 then
		specWarnTemporalOrbs:Show()
		voiceTemporalOrbs:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		self.vb.timeBombDebuffCount = self.vb.timeBombDebuffCount + 1
		warnTimeBomb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local debuffTime = expires - GetTime()
				specWarnTimeBomb:Schedule(debuffTime - 5)	-- Show "move away" warning 5secs before explode
				voiceTimeBomb:Schedule(debuffTime - 5, "scatter")
				timerTimeBomb:Start(debuffTime)
				countdownTimeBomb:Start(debuffTime)
				yellTimeBomb:Schedule(debuffTime-1, 1)
				yellTimeBomb:Schedule(debuffTime-2, 2)
				yellTimeBomb:Schedule(debuffTime-3, 3)
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(10)
				end
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then--207051 and 207052 didn't appear on heroic
		warnTimeRelease:CombinedShow(0.5, args.destName)
--		if self.Options.SetIconOnTimeRelease then
--			self:SetSortedIcon(0.5, args.destName, 1)--Add expected max count when known?
--		end
	elseif spellId == 206607 then
		local amount = args.amount or 1
		warnChronometricPart:Show(args.destName, amount)
		timerChronoPartCD:Start()--Move timer to success if this can be avoided
	elseif spellId == 211927 then
		self.vb.OPActive = true
		if self.vb.riftActive > 0 then
			specWarnPowerOverwhelmingKick:Show(UnitName("boss1"))
			voicePowerOverwhelming:Play("kickcast")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		self.vb.timeBombDebuffCount = self.vb.timeBombDebuffCount - 1
		if args:IsPlayer() then
			specWarnTimeBomb:Cancel()
			voiceTimeBomb:Cancel()
			timerTimeBomb:Stop()
			countdownTimeBomb:Cancel()
			yellTimeBomb:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.InfoFrame and self.vb.timeBombDebuffCount == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then--207051 and 207052 didn't appear on heroic
--		if self.Options.SetIconOnTimeRelease then
--			self:SetIcon(args.destName, 0)
--		end
	end
end

local function delayedBurst(self, time, count)
	timerBurstofTimeCD:Start(time, count)
end
local function delayedTimeRelease(self, time, count)
	timerTimeReleaseCD:Start(time, count)
end
local function delayedTimeBomb(self, time, count)
	timerTimeBombCD:Start(time, count)
end
local function delayedOrbs(self, time, count)
	timerTemporalOrbsCD:Start(time, count)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 207012 then--Speed: Normal
		self.vb.currentPhase = 2
		self.vb.interruptCount = 0
		self.vb.normCount = self.vb.normCount + 1
		if self.vb.normCount == 1 then
			if self:IsMythic() then
				timerTimeBombCD:Start(5, 1)
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(15, 1)
				self:Schedule(15, delayedBurst, self, 10, 2)--25
				self:Schedule(10, delayedTimeRelease, self, 20, 2)--30
				self:Schedule(25, delayedBurst, self, 10, 3)--35
			elseif self:IsHeroic() then--UPDATED Jan 18
				timerTimeReleaseCD:Start(5, 1)
				self:Schedule(5, delayedTimeRelease, self, 13, 2)--18
				timerBigAddCD:Start(23, 1)
				countdownBigAdd:Start(23)
				timerTimeBombCD:Start(28, 1)
				self:Schedule(28, delayedTimeBomb, self, 5, 2)--33
				timerTemporalOrbsCD:Start(38, 1)
				self:Schedule(30, delayedTimeRelease, self, 13, 3)--43
				timerPowerOverwhelmingCD:Start(53, 1)
			elseif self:IsNormal() then--Updated Jan 17
				timerTimeReleaseCD:Start(5, 1)
				self:Schedule(5, delayedTimeRelease, self, 15, 2)--20
				timerBigAddCD:Start(28, 1)
				countdownBigAdd:Start(28)
				timerTimeBombCD:Start(35, 1)
				timerTemporalOrbsCD:Start(48, 1)
				timerPowerOverwhelmingCD:Start(84, 1)
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--[[
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(20, 1)
				self:Schedule(20, delayedBurst, self, 5, 2)--25
				timerBigAddCD:Start(35, 1)
				countdownBigAdd:Start(35)
				self:Schedule(10, delayedTimeRelease, self, 35, 2)--45
				self:Schedule(25, delayedBurst, self, 25, 3)--50
				self:Schedule(50, delayedBurst, self, 5, 4)--55
				timerTemporalOrbsCD:Start(65, 1)
				timerPowerOverwhelmingCD:Start(75, 1)--]]
			end
		elseif self.vb.normCount == 2 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerTemporalOrbsCD:Start(10, 1)
				timerTimeBombCD:Start(15, 1)
				timerPowerOverwhelmingCD:Start(25, 1)
			elseif self:IsHeroic() then--Updated Dec 2
			--[[	timerTimeBombCD:Start(2, 1)--Yep, two seconds.
				timerBurstofTimeCD:Start(4, 1)
				timerBurstofTimeCD:Start(6, 2)
				timerTemporalOrbsCD:Start(8, 1)
				self:Schedule(4, delayedBurst, self, 6, 3)--10
				self:Schedule(2, delayedTimeBomb, self, 10, 2)--12
				self:Schedule(6, delayedBurst, self, 8, 4)--14
				timerBigAddCD:Start(16, 1)
				countdownBigAdd:Start(16)
				--Only show up to 2 burst timers at a time for this utter chaos
				self:Schedule(14, delayedBurst, self, 4, 5)--18
				self:Schedule(14, delayedBurst, self, 6, 6)--20
				self:Schedule(18, delayedBurst, self, 4, 7)--22
				self:Schedule(18, delayedBurst, self, 6, 8)--24
				self:Schedule(22, delayedBurst, self, 4, 9)--26
				self:Schedule(22, delayedBurst, self, 6, 10)--28
				self:Schedule(22, delayedBurst, self, 8, 11)--30
				timerTemporalOrbsCD:Start(35, 1)
				timerPowerOverwhelmingCD:Start(40, 1)--]]
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--Triggers special extention phase after interrupt
			elseif self:IsNormal() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--[[
				timerTemporalOrbsCD:Start(5, 1)
				timerBurstofTimeCD:Start(10, 1)
				self:Schedule(10, delayedBurst, self, 5, 2)--15
				timerTimeReleaseCD:Start(25, 1)
				timerBigAddCD:Start(35, 1)
				countdownBigAdd:Start(35)
				self:Schedule(25, delayedTimeRelease, self, 20, 2)--45
				self:Schedule(15, delayedBurst, self, 35, 2)--50
				self:Schedule(50, delayedBurst, self, 5, 3)--55
				self:Schedule(5, delayedOrbs, self, 60, 2)--65
				timerPowerOverwhelmingCD:Start(75, 1)--]]
			end
		elseif self.vb.normCount == 3 then
			if self:IsMythic() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else
			DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
		end
	elseif spellId == 207011 then--Speed: Slow
		self.vb.currentPhase = 1
		self.vb.interruptCount = 0
		self.vb.slowCount = self.vb.slowCount + 1
		if self.vb.slowCount == 1 then
			if self:IsMythic() then
				timerTemporalOrbsCD:Start(5, 1)
				timerBurstofTimeCD:Start(15, 1)
				timerTimeBombCD:Start(18, 1)--Odd, the only non 5s timer in like all of this bosses tables.
				timerTimeReleaseCD:Start(20, 1)
				timerPowerOverwhelmingCD:Start(25, 1)
			elseif self:IsHeroic() then--Updated Jan 18
				timerTimeReleaseCD:Start(10, 1)
				timerTimeBombCD:Start(15, 1)
				timerTemporalOrbsCD:Start(20, 1)
				self:Schedule(10, delayedTimeBomb, self, 15, 2)--25
				self:Schedule(5, delayedTimeRelease, self, 25, 2)--30
				self:Schedule(25, delayedTimeBomb, self, 10, 3)--35
				self:Schedule(20, delayedOrbs, self, 18, 2)--38
				self:Schedule(25, delayedTimeBomb, self, 15, 3)--40
				timerBigAddCD:Start(43, 1)
				countdownBigAdd:Start(43)
				self:Schedule(38, delayedOrbs, self, 7, 3)--45
				timerPowerOverwhelmingCD:Start(55, 1)
			elseif self:IsNormal() then--Updated Jan 17
				timerTimeReleaseCD:Start(5, 1)
				timerTimeBombCD:Start(20, 1)
				self:Schedule(5, delayedTimeRelease, self, 23, 2)--28
				timerTemporalOrbsCD:Start(30, 1)
				timerBigAddCD:Start(38, 1)
				countdownBigAdd:Start(38)
				timerPowerOverwhelmingCD:Start(90, 1)
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--[[
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(20, 1)
				self:Schedule(20, delayedBurst, self, 5, 2)--25
				timerBigAddCD:Start(30, 1)
				countdownBigAdd:Start(30)
				timerTemporalOrbsCD:Start(40, 1)
				self:Schedule(25, delayedBurst, self, 25, 3)--50
				self:Schedule(10, delayedTimeRelease, self, 50, 2)--60
				self:Schedule(50, delayedBurst, self, 20, 4)--70
				self:Schedule(40, delayedOrbs, self, 40, 2)--80
				timerPowerOverwhelmingCD:Start(90, 1)--]]
			end
		elseif self.vb.slowCount == 2 then
			if self:IsMythic() then
				timerBurstofTimeCD:Start(5, 1)
				timerTimeReleaseCD:Start(15, 1)
				self:Schedule(5, delayedBurst, self, 20, 2)--25
				self:Schedule(25, delayedBurst, self, 5, 3)--30
				self:Schedule(15, delayedTimeRelease, self, 20, 2)--35
				self:Schedule(25, delayedBurst, self, 20, 4)--45
				timerTemporalOrbsCD:Start(50, 1)
				timerPowerOverwhelmingCD:Start(60, 1)
			elseif self:IsHeroic() then--Probably changed.
				--[[timerTimeReleaseCD:Start(5, 1)
				timerTemporalOrbsCD:Start(15, 1)
				timerBurstofTimeCD:Start(20, 1)
				timerBigAddCD:Start(25, 1)
				countdownBigAdd:Start(25)
				self:Schedule(20, delayedBurst, self, 10, 2)--30
				self:Schedule(30, delayedBurst, self, 5, 3)--35
				timerPowerOverwhelmingCD:Start(40, 1)--]]
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		elseif self.vb.slowCount == 3 then
			if self:IsMythic() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else
			DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
		end
	elseif spellId == 207013 then--Speed: Fast
		self.vb.currentPhase = 3
		self.vb.interruptCount = 0
		self.vb.fastCount = self.vb.fastCount + 1
		if self.vb.fastCount == 1 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerBigAddCD:Start(10, 1)
				countdownBigAdd:Start(10)
				timerBurstofTimeCD:Start(15, 1)
				timerTemporalOrbsCD:Start(25, 1)
				timerPowerOverwhelmingCD:Start(30, 1)
			elseif self:IsHeroic() then--Updated Dec 2
				--[[timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(8, 1)
				timerBurstofTimeCD:Start(10, 2)
				self:Schedule(5, delayedTimeRelease, self, 10, 2)--15
				timerTimeBombCD:Start(20, 1)
				self:Schedule(15, delayedTimeRelease, self, 20, 3)--25
				self:Schedule(25, delayedTimeRelease, self, 5, 4)--30
				self:Schedule(30, delayedTimeRelease, self, 5, 5)--35
				timerBigAddCD:Start(38, 1)
				countdownBigAdd:Start(38)
				self:Schedule(35, delayedTimeRelease, self, 8, 6)--43
				self:Schedule(10, delayedBurst, self, 35, 3)--45
				timerPowerOverwhelmingCD:Start(50, 1)--]]
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				timerTimeReleaseCD:Start(10, 1)
				timerTemporalOrbsCD:Start(15, 1)
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--[[
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(15, 1)
				self:Schedule(10, delayedTimeRelease, self, 15, 2)--25
				timerBigAddCD:Start(35, 1)
				countdownBigAdd:Start(35)
				timerTemporalOrbsCD:Start(45, 1)
				self:Schedule(25, delayedTimeRelease, self, 30, 3)--55
				self:Schedule(15, delayedBurst, self, 50, 3)--65
				self:Schedule(55, delayedTimeRelease, self, 20, 3)--75
				timerPowerOverwhelmingCD:Start(85, 1)--]]
			end
		elseif self.vb.fastCount == 2 then
			if self:IsMythic() then
				timerBurstofTimeCD:Start(5, 1)
				timerBurstofTimeCD:Start(8, 2)
				timerTemporalOrbsCD:Start(13, 1)
				timerTimeReleaseCD:Start(23, 1)
				self:Schedule(8, delayedBurst, self, 17, 3)--25
				timerTimeBombCD:Start(30, 1)
				self:Schedule(23, delayedTimeRelease, self, 12, 2)--35
				self:Schedule(35, delayedTimeRelease, self, 5, 3)--40
				self:Schedule(25, delayedBurst, self, 20, 4)--45
				self:Schedule(13, delayedOrbs, self, 37, 2)--50
				timerBigAddCD:Start(55, 1)
				countdownBigAdd:Start(55)
				timerPowerOverwhelmingCD:Start(60, 1)
			elseif self:IsHeroic() then--Updated Dec 2
				--[[timerTemporalOrbsCD:Start(5, 1)
				timerBurstofTimeCD:Start(10, 1)
				self:Schedule(10, delayedBurst, self, 5, 2)--15--]]
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else--LFR
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
				--[[
				timerBurstofTimeCD:Start(5, 1)
				self:Schedule(5, delayedBurst, self, 5, 2)--10
				timerTemporalOrbsCD:Start(20, 1)
				timerBigAddCD:Start(30, 1)
				countdownBigAdd:Start(30)
				self:Schedule(10, delayedBurst, self, 25, 3)--35
				self:Schedule(35, delayedBurst, self, 10, 4)--45
				self:Schedule(45, delayedBurst, self, 5, 5)--50
				timerNextPhase:Start(55)--]]
			end
		elseif self.vb.fastCount == 3 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(10, 1)
				self:Schedule(10, delayedBurst, self, 5, 2)--15
				self:Schedule(5, delayedTimeRelease, self, 15, 2)--20
				self:Schedule(15, delayedBurst, self, 10, 3)--25
				self:Schedule(20, delayedTimeRelease, self, 10, 3)--30
				self:Schedule(30, delayedTimeRelease, self, 5, 4)--35
				self:Schedule(35, delayedTimeRelease, self, 5, 5)--40
				DBM:AddMsg("There is incomplete timer data beyond 40 second mark of Fast-3 phase. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsNormal() then--Normal confirmed
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else--LFR
			DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
		end
	elseif spellId == 206699 then--Summon Haste Add (Small Adds)
		specWarnSmallAdd:Show()
		voiceSmallAdd:Play("mobsoon")
	elseif spellId == 206700 then--Summon Slow Add (Big Adds)
		specWarnBigAdd:Show()
		voiceBigAdd:Play("bigmobsoon")
	elseif spellId == 212072 and self:AntiSpam(5, 1) then--Temporal Rift (Slightly faster than combat log)
		self.vb.riftActive = self.vb.riftActive + 1
		if self.vb.OPActive then--Rift available and boss is already casting Overwhelming Power, warn to interrupt now
			specWarnPowerOverwhelmingKick:Show(UnitName("boss1"))
			voicePowerOverwhelming:Play("kickcast")
		end
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 211927 then--Power Overwhelming
		self.vb.OPActive = false
		self.vb.riftActive = self.vb.riftActive - 1
		self.vb.interruptCount = self.vb.interruptCount + 1
		if self.vb.currentPhase == 1 then--slow
			if self.vb.normCount == 2 then
				if self:IsMythic() then
					timerBurstofTimeCD:Start(10, 1)
					timerTimeBombCD:Start(15, 2)
					timerBigAddCD:Start(20, 1)
					countdownBigAdd:Start(20)
				elseif self:IsHeroic() then--Probably changed.
					--timerBurstofTimeCD:Start(5, 4)
					--self:Schedule(5, delayedBurst, self, 5, 5)--10
					--DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				elseif self:IsNormal() then
					timerBurstofTimeCD:Start(5, 2)
					self:Schedule(5, delayedBurst, self, 5, 3)--10
					timerTimeReleaseCD:Start(18, 2)
					timerTimeBombCD:Start(25, 1)
					timerNextPhase:Start(30)
				else
					DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				end
			end
		elseif self.vb.currentPhase == 2 then--normal
			if self.vb.normCount == 2 then
				if self:IsMythic() then
					DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				elseif self:IsHeroic() then--Updated Dec 2
					timerTimeReleaseCD:Start(5, 1)
					timerNextPhase:Start(10)
				elseif self:IsNormal() then
					timerTimeReleaseCD:Start(5, 3)
					timerNextPhase:Start(10)
				else--LFR
					timerTimeReleaseCD:Start(10, 3)
					timerNextPhase:Start(15)
				end
			elseif self.vb.normCount == 3 then
				if self:IsMythic() then
					--DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				elseif self:IsHeroic() then--Probably changed.
					--DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				elseif self:IsNormal() then
					if self.vb.interruptCount == 1 then
						timerBigAddCD:Start(5, 2)
						countdownBigAdd:Start(5)
						timerTimeReleaseCD:Start(13, 1)
						timerBurstofTimeCD:Start(18, 1)
						timerBigAddCD:Start(25, 3)
						countdownBigAdd:Start(25)
						timerPowerOverwhelmingCD:Start(30, 2)
					else
						timerNextPhase:Start(5)
					end
				else
					--DBM:AddMsg("There is incomplete timer data here and a spell or two might be missing. Please submit transcriptor log to improve this mod")
				end
			end
		else--fast

		end
	end
end
mod.UNIT_SPELLCAST_STOP = mod.UNIT_SPELLCAST_CHANNEL_STOP
