local mod	= DBM:NewMod(1425, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90284)
mod:SetEncounterID(1785)
mod:SetZone()
mod:SetUsedIcons(4, 3, 2)
--mod.respawnTime = 20--I'm dumb and forgot

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 179889 182066 186449 181999 185282 182055 182668",
	"SPELL_AURA_APPLIED 182280 182020 182074 182001",
	"SPELL_AURA_APPLIED_DOSE 182074",
	"SPELL_AURA_REMOVED 182280",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, check falling slam for target scanning.
--TODO, see if one of the instance cast spellids are earlier than channeled casts for falling slam
local warnArtillery					= mod:NewTargetCountAnnounce(182280, 4)
local warnUnstableOrb				= mod:NewTargetCountAnnounce(182001, 3, nil, false)--Off by default do to some frequent casts. Boss fires 2 orbs. anyone then hit on landing gets debuff, if ranged properly spread, 2 targets, if numpty, could be 30 targets
local warnFuelStreak				= mod:NewCountAnnounce(182668, 3)

local specWarnArtillery				= mod:NewSpecialWarningMoveAway(182280, nil, nil, nil, 3, 2)
local yellArtillery					= mod:NewFadesYell(182108)
local specWarnImmolation			= mod:NewSpecialWarningMove(182074, nil, nil, nil, 1, 2)
local specWarnBarrage				= mod:NewSpecialWarningCount(185282, nil, nil, nil, 2, 5)--Count probably better than dodge
local specWarnPounding				= mod:NewSpecialWarningCount(182020, nil, nil, nil, 2, 2)
local specWarnBlitz					= mod:NewSpecialWarningCount(179889, nil, nil, nil, 2, 2)--Count probably better than dodge
local specWarnFullCharge			= mod:NewSpecialWarningSpell(182055, nil, nil, nil, 1)
local specWarnFallingSlam			= mod:NewSpecialWarningSpell(182066, nil, nil, nil, 2)--Phase change
local specWarnFirebomb				= mod:NewSpecialWarningSwitchCount(181999, "-Healer", nil, nil, 1, 5)

--mod:AddTimerLine(ALL)--Uncomment when ground phase and air phase are done, don't want to enable this line now and incorrectly flag everything as "All"
local timerArtilleryCD				= mod:NewNextCountTimer(15, 182108)
--mod:AddTimerLine(ALL)--Find translation that works for "Ground Phase"
local timerUnstableOrbCD			= mod:NewNextCountTimer(3, 182001, nil, "Ranged")
local timerPoundingCD				= mod:NewNextCountTimer(24, 182020)
local timerBlitzCD					= mod:NewNextCountTimer(5, 179889)
local timerBarrageCD				= mod:NewNextCountTimer(15, 185282)
local timerFullChargeCD				= mod:NewNextTimer(136, 182055)
--mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)--Find translation that works for "Air Phase"
local timerFallingSlamCD			= mod:NewNextTimer(54, 182066)
local timerFuelLeakCD				= mod:NewNextCountTimer(15, 182668)--Fire bombs always immediately after, so no timer needed
--All of bomb timers are time+2 because dbm starts timers at cast start of 181999
local timerVolatileBomb				= mod:NewCastTimer(47, 182534, nil, "Dps")--The only timer that's on normal/heroic/lfr so not too spammy to have on
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerQuickFuseBomb			= mod:NewCastTimer(22, 186652, nil, false)--Timer spam, optional, maybe make rangeddps only default?
local timerBurningBomb				= mod:NewCastTimer(42, 186667, nil, false)--Timer spam, optional, maybe make meleedps only by default?
local timerReactiveBomb				= mod:NewCastTimer(32, 186676, nil, "Tank")--Since tanks only have 1 bomb to worry about. not too spammy to have on by default.

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownFuelStreak			= mod:NewCountdown(15, 182668)
local countdownBarrage				= mod:NewCountdown(15, 185282)
local countdownArtillery			= mod:NewCountdown("AltTwo15", 182108)--Important to have different voice from fades, because they are happening at same time most of time
local countdownArtilleryFade		= mod:NewCountdownFades("Alt13", 182280)--Duration not in spell tooltip, countdown add when duration discovered from testing

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceArtillery				= mod:NewVoice(182280)--runout
local voicePounding					= mod:NewVoice(182020)--aesoon
local voiceBlitz					= mod:NewVoice(179889)--chargemove
local voiceImmolation				= mod:NewVoice(182074)--runaway
local voiceBarrage					= mod:NewVoice(185282)--185282
local voiceFirebomb					= mod:NewVoice(181999)--attbomb

mod:AddRangeFrameOption("8/30")
mod:AddSetIconOption("SetIconOnArtillery", 182280, true)
mod:AddHudMapOption("HudMapOnArt", 182108)

mod.vb.artilleryActive = 0--Number of debuffs count. Room is MASSIVE and combat log range could be an issue. Unsure at this time. DBM didn't seem to miss any artillery debuffs in testing.
mod.vb.groundPhase = true
mod.vb.tankIcon = 2
mod.vb.artilleryCount = 0--Cast count
mod.vb.barrageCount = 0
mod.vb.poundingCount = 0
mod.vb.blitzCount = 0
mod.vb.unstableOrbCount = 0
mod.vb.firebombCount = 0
mod.vb.fuelCount = 0
--All timers are energy based and scripted. boss uses x ability at y energy.
--These tables establish the cast sequence by ability.
--If energy rates are different in different modes, then each table will need to be different.
--These tables are Heroic/LFR timers. Hopefully all modes the same. If not, easily fixed
local artilleryTimers = {8.9, 9, 30, 15, 9, 24, 15}--Phase 1, phase 2 is just 15
local barrageTimers = {11.7, 30, 12, 45}
local blitzTimers = {63, 5, 58, 4.7}
local unstableOrbsTimers = {3, 3, 3, 9, 6, 3, 21, 3, 30, 15}--While it may seem most of the timers (3 seconds apart) aren't useful. they can be quite useful for grouped movement/healing in the larger gaps
local poundingTimers = {32.6, 54, 24}

local debuffFilter
local UnitDebuff = UnitDebuff
local debuffName = GetSpellInfo(182280)
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame or not self:IsInCombat() then return end
	if (self:IsTank() or not self.vb.groundPhase) and self.vb.artilleryActive > 0 then--Artillery
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(30, nil)
		else
			DBM.RangeCheck:Show(30, debuffFilter)
		end
	elseif self:IsRanged() and self.vb.groundPhase then--Unstable Orb
		DBM.RangeCheck:Show(8)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.artilleryActive = 0
	self.vb.groundPhase = true
	self.vb.tankIcon = 2
	self.vb.artilleryCount = 0
	self.vb.barrageCount = 0
	self.vb.poundingCount = 0
	self.vb.blitzCount = 0
	self.vb.unstableOrbCount = 0
	self.vb.firebombCount = 0
	self.vb.fuelCount = 0
	updateRangeFrame(self)
--	berserkTimer:Start(-delay)
	--Boss uses "Ground Phase" trigger after pull. Do not start timers here
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnArt then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 179889 then
		self.vb.blitzCount = self.vb.blitzCount + 1
		specWarnBlitz:Show(self.vb.blitzCount)
		voiceBlitz:Play("chargemove")
		local cooldown = blitzTimers[self.vb.blitzCount+1]
		if cooldown then
			timerBlitzCD:Start(cooldown, self.vb.blitzCount+1)
		end
	elseif spellId == 182066 or spellId == 186449 then--182066 confirmed on heroic. Mythic uses 186449 (Confirmed)
		self.vb.groundPhase = true
		specWarnFallingSlam:Show()
		updateRangeFrame(self)
		voicePhaseChange:Play("phasechange")
	elseif spellId == 181999 then
		self.vb.firebombCount = self.vb.firebombCount + 1
		specWarnFirebomb:Show(self.vb.firebombCount)
		voiceFirebomb:Play("attbomb")
		--Count is used as a unique timer arg, so 2nd and 3rd bombs start different timers, not replace existing ones.
		--Count doesn't show in timer text itself, they are cast timers.
		timerVolatileBomb:Start(nil, self.vb.firebombCount)
		if self:IsMythic() then
			timerQuickFuseBomb:Start(nil, self.vb.firebombCount)
			timerBurningBomb:Start(nil, self.vb.firebombCount)
			timerReactiveBomb:Start(nil, self.vb.firebombCount)
		end
	elseif spellId == 185282 then
		self.vb.barrageCount = self.vb.barrageCount + 1
		specWarnBarrage:Show(self.vb.barrageCount)
		local cooldown = barrageTimers[self.vb.barrageCount+1]
		if cooldown then
			timerBarrageCD:Start(cooldown, self.vb.barrageCount+1)
			countdownBarrage:Start(cooldown)
		end
		voiceBarrage:Play("185282")
	elseif spellId == 182055 then
		self.vb.groundPhase = false
		specWarnFullCharge:Show()
		self.vb.fuelCount = 0
		self.vb.firebombCount = 0
		self.vb.artilleryCount = 0--Also used in air phase, with it's own air phase counter
		timerFuelLeakCD:Start(9, 1)
		countdownFuelStreak:Start(9)
		timerArtilleryCD:Start(9, 1)
		countdownArtillery:Start(9)
		timerFallingSlamCD:Start()
		voicePhaseChange:Play("phasechange")
	elseif spellId == 182668 then
		self.vb.fuelCount = self.vb.fuelCount + 1
		warnFuelStreak:Show(self.vb.fuelCount)
		if self.vb.fuelCount < 3 then
			timerFuelLeakCD:Start(nil, self.vb.fuelCount+1)
			countdownFuelStreak:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182280 then
		self.vb.artilleryActive = self.vb.artilleryActive + 1
		if self:AntiSpam(3, 1) then
			self.vb.artilleryCount = self.vb.artilleryCount + 1
			if self.vb.groundPhase then
				local cooldown = artilleryTimers[self.vb.artilleryCount+1]
				if cooldown and self:IsTank() then--Only show timer to tanks in phase 1
					timerArtilleryCD:Start(cooldown, self.vb.artilleryCount+1)
					countdownArtillery:Start(cooldown)
				end
			else
				if self.vb.artilleryCount < 3 then--Only 3 casts in air phase
					timerArtilleryCD:Start(15, self.vb.artilleryCount+1)
					countdownArtillery:Start(15)
				end
			end
		end
		warnArtillery:CombinedShow(0.3, self.vb.artilleryCount, args.destName)
		if args:IsPlayer() then
			specWarnArtillery:Show()
			yellArtillery:Schedule(11.5, 1)
			yellArtillery:Schedule(10.5, 2)
			yellArtillery:Schedule(9.5, 3)
			yellArtillery:Schedule(8.5, 4)
			yellArtillery:Schedule(7.5, 5)
			voiceArtillery:Play("runout")
			countdownArtilleryFade:Start()
		end
		if self.Options.SetIconOnArtillery then
			if self.vb.groundPhase then--1 target, alternating icons because two debuffs will overlap but not cast at same time
				self:SetIcon(args.destName, self.vb.tankIcon)
				if self.vb.tankIcon == 2 then
					self.vb.tankIcon = 3
				else
					self.vb.tankIcon = 2
				end
			else
				self:SetSortedIcon(0.5, args.destName, 2, 3)--3 targets at once
			end
		end
		if self.Options.HudMapOnArt then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 13, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
		updateRangeFrame(self)
	elseif spellId == 182020 then
		self.vb.poundingCount = self.vb.poundingCount + 1
		specWarnPounding:Show(self.vb.poundingCount)
		voicePounding:Play("aesoon")
		local cooldown = poundingTimers[self.vb.poundingCount+1]
		if cooldown then
			timerPoundingCD:Start(cooldown, self.vb.poundingCount+1)
		end
	elseif spellId == 182074 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnImmolation:Show()
		voiceImmolation:Play("runaway")
	elseif spellId == 182001 then
		warnUnstableOrb:CombinedShow(0.3, self.vb.unstableOrbCount, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 182280 then
		self.vb.artilleryActive = self.vb.artilleryActive - 1
		if args:IsPlayer() then
			countdownArtilleryFade:Cancel()
			yellArtillery:Cancel()
		end
		if self.Options.SetIconOnArtillery then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapOnArt then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		updateRangeFrame(self)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 185250 and self:AntiSpam(2, 3) then--Unstable Orb Cast
		self.vb.unstableOrbCount = self.vb.unstableOrbCount + 1
		local cooldown = unstableOrbsTimers[self.vb.unstableOrbCount+1]
		if cooldown then
			timerUnstableOrbCD:Start(cooldown, self.vb.unstableOrbCount+1)
		end
	elseif spellId == 181923 then--Ground Phase (using this to start timers because it's more accurate than "falling" cast, because falling cast is shorter on mythic)
		--Reset Counts
		self.vb.artilleryCount = 0
		self.vb.barrageCount = 0
		self.vb.blitzCount = 0
		self.vb.poundingCount = 0
		self.vb.unstableOrbCount = 0
		--Start ground phase timers
		--Tiny variation in the firsts, 0.3-0.4, lowest times used. but for example 8.9 could be 9.3
		timerUnstableOrbCD:Start(3, 1)
		timerArtilleryCD:Start(8.9, 1)
		countdownArtillery:Start(8.9)
		timerBarrageCD:Start(11.7, 1)
		countdownBarrage:Start(11.7)
		timerPoundingCD:Start(32.6, 1)
		timerBlitzCD:Start(63, 1)
		timerFullChargeCD:Start()
	end
end
