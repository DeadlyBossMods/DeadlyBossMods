local mod	= DBM:NewMod(1725, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104415)--104731 (Depleted Time Particle). 104676 (Waning Time Particle). 104491 (Accelerated Time particle). 104492 (Slow Time Particle)
mod:SetEncounterID(1865)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)--sometimes it was 5 targets, sometimes it was whole raid. even post nerf. have to see
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 211927 207228",
--	"SPELL_CAST_SUCCESS 206618 206610 206614",
	"SPELL_AURA_APPLIED 206617 206609 207052 207051 206607 211927",
	"SPELL_AURA_APPLIED_DOSE 206607",
	"SPELL_AURA_REMOVED 206617 206609 207052 207051 211927",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, figure out how often tanks need to swap, adjust warnings accordingly
--TODO, More data to complete sequences of timers
--TODO, Determine if not interrupting OP affects things badly. For most part it shouldn't
--TODO, info frame with debuff shield (health) remaining sorted highest to lowest.
--(ability.id = 206618 or ability.id = 206610 or ability.id = 206614) and type = "cast" or ability.id = 211927
local warnTimeBomb					= mod:NewTargetAnnounce(206617, 3)
local warnTimeRelease				= mod:NewTargetAnnounce(206610, 3, nil, false)--Too many targets
local warnChronometricPart			= mod:NewStackAnnounce(206607, 3, nil, "Tank")

local specWarnPowerOverwhelming		= mod:NewSpecialWarningDodge(211927, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelmingKick	= mod:NewSpecialWarningInterrupt(211927, "Tank", nil, nil, 3, 2)
local specWarnTimeBomb				= mod:NewSpecialWarningMoveAway(206617, nil, nil, nil, 1, 2)--When close to expiring, not right away
local yellTimeBomb					= mod:NewFadesYell(206617)
local specWarnWarp					= mod:NewSpecialWarningInterrupt(207228, "HasInterrupt", nil, nil, 1, 2)
local specWarnBigAdd				= mod:NewSpecialWarningSwitch(206700, "-Healer", nil, nil, 1, 2)--Switch to waning time particle when section info known
local specWarnSmallAdd				= mod:NewSpecialWarningSwitch(206699, "Tank", nil, nil, 1, 2)

local timerPowerOverwhelmingCD		= mod:NewNextTimer(60, 211927, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerTimeBomb					= mod:NewBuffFadesTimer(30, 206617, nil, nil, nil, 5)
local timerTimeBombCD				= mod:NewNextTimer(30, 206617, nil, nil, nil, 3)
local timerBurstofTimeCD			= mod:NewNextCountTimer(30, 206614, nil, nil, nil, 3)
local timerTimeReleaseCD			= mod:NewNextCountTimer(30, 206610, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerChronoPartCD				= mod:NewCDTimer(10.4, 206607, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBigAddCD					= mod:NewNextTimer(30, 206700, nil, nil, nil, 1)--Switch to waning time particle when section info known
local timerSmallAddCD				= mod:NewNextTimer(30, 206699, nil, nil, nil, 1)--Switch to Depleted Time Particle when section info known

local countdownBigAdd				= mod:NewCountdown(30, 206700)--Switch to waning time particle when section info known
local countdownTimeBomb				= mod:NewCountdownFades("AltTwo30", 206617)

local voicePowerOverwhelming		= mod:NewVoice(211927)--kickcast/watchstep
local voiceTimeBomb					= mod:NewVoice(206617)--scatter
local voiceWarp						= mod:NewVoice(207228, "HasInterrupt")--kickcast
local voiceBigAdd					= mod:NewVoice(206700, "-Healer")
local voiceSmallAdd					= mod:NewVoice(206699, "Tank")

mod:AddRangeFrameOption(10, 206617)
--mod:AddSetIconOption("SetIconOnTimeRelease", 206610, true)

mod.vb.OPActive = false

function mod:OnCombatStart(delay)
	self.vb.OPActive = false
	--No timers here, started by speed events
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 211927 then
		timerChronoPartCD:Stop()--Will be used immediately when this ends.
		timerPowerOverwhelmingCD:Start()
		specWarnPowerOverwhelming:Show()
		voicePowerOverwhelming:Play("watchstep")
	elseif spellId == 207228 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnWarp:Show(args.sourceName)
		voiceWarp:Play("kickcast")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206618 then
		timerTimeBombCD:Start()
	elseif spellId == 206610 then
		timerTimeReleaseCD:Start()
	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206617 then
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206617 then
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
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then--207051 and 207052 didn't appear on heroic
--		if self.Options.SetIconOnTimeRelease then
--			self:SetIcon(args.destName, 0)
--		end
	elseif spellId == 211927 then--Overwhelming Power ended
		self.vb.OPActive = false
	end
end

local function delayedBurst(self, time, count)
	timerBurstofTimeCD:Start(time, count)
end
local function delayedTimeRelease(self, time, count)
	timerTimeReleaseCD:Start(time, count)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 207012 then--Speed: Normal
		timerTimeReleaseCD:Start(7, 1)
		timerBurstofTimeCD:Start(10, 1)
		timerSmallAddCD:Start(10)
		self:Schedule(10, delayedTimeRelease, self, 15, 2)--22
		timerBigAddCD:Start(25)
		countdownBigAdd:Start(25)
		timerTimeBombCD:Start(35)
		self:Schedule(10, delayedBurst, self, 25, 2)--35
		self:Schedule(35, delayedBurst, self, 5, 3)--40
		self:Schedule(22, delayedTimeRelease, self, 25, 3)--47
		self:Schedule(47, delayedTimeRelease, self, 10, 3)--57
		timerPowerOverwhelmingCD:Start(60)
	elseif spellId == 207011 then--Speed: Slow
		timerTimeReleaseCD:Start(7.5, 1)
		timerBigAddCD:Start(15)
		countdownBigAdd:Start(15)
		timerBurstofTimeCD:Start(20, 1)
		timerTimeBombCD:Start(20)
	elseif spellId == 207013 then--Speed: Fast
		timerBurstofTimeCD:Start(5, 1)
		timerTimeReleaseCD:Start(6.5, 1)
		timerTimeBombCD:Start(10)
		self:Schedule(6.5, delayedTimeRelease, self, 10, 2)--16.5
		self:Schedule(5, delayedBurst, self, 15, 2)--20
		timerSmallAddCD:Start(20)
		timerBigAddCD:Start(25)
		countdownBigAdd:Start(25)
		timerPowerOverwhelmingCD:Start(35)
	elseif spellId == 206699 then--Summon Haste Add (Small Adds)
		specWarnSmallAdd:Show()
		voiceSmallAdd:Play("mobsoon")
	elseif spellId == 206700 then--Summon Slow Add (Big Adds)
		specWarnBigAdd:Show()
		voiceBigAdd:Play("bigmobsoon")
	elseif spellId == 212072 then--Temporal Rift (Slightly faster than combat log)
		if self.vb.OPActive and self:AntiSpam(5, 1) then--Rift available, boss is casting Overwhelming Power, warn to interrupt now
			specWarnPowerOverwhelmingKick:Show(UnitName("boss1"))
			voicePowerOverwhelming:Play("kickcast")
		end
	end
end
