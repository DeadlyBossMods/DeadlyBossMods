local mod	= DBM:NewMod(1391, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(89890)
mod:SetEncounterID(1777)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetRespawnTime(30)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 179406 181461 179582",
	"SPELL_CAST_SUCCESS 181508 179709",
	"SPELL_AURA_APPLIED 181508 181515 182008 179670 179711 179681 179407 179667",
	"SPELL_AURA_REMOVED 179711 181508 181515 179667"
)

--TODO, two versions of seed? one with shorter duration? shorter one mythic?
--TODO, need voice for "Soul Cleave". Maybe voice for seeds as well. Not all strats are run out strats. Plus, might use run out for Befouled, if it's fixed.
--TODO, auto send latent energy targets down for disembodied?
--Encounter-Wide Mechanics
local warnLatentEnergy					= mod:NewTargetAnnounce(182008, 3, nil, false)--Spammy, optional
local warnEnrage						= mod:NewSpellAnnounce(179681, 3)
--Armed
local warnRumblingFissure				= mod:NewCountAnnounce(179582, 2)
local warnBefouled						= mod:NewTargetCountAnnounce(179711, 2, nil, "Healer")--Only healer really needs list of targets, player only needs to know if it's on self
local warnDisembodied					= mod:NewTargetCountAnnounce(179407, 2)--Needed to know for transport down.
--Disarmed
local warnSeedofDestruction				= mod:NewTargetCountAnnounce(181508, 4)

--Encounter-Wide Mechanics
local specWarnWakeofDestruction			= mod:NewSpecialWarningSpell(181499, nil, nil, nil, 2, nil, 2)--Triggered by 3 different things
--Armed
local specWarnDisarmedEnd				= mod:NewSpecialWarningEnd(179667)
local specWarnSoulCleave				= mod:NewSpecialWarningCount(179406, "Melee", nil, nil, 1, nil, 5)
local specWarnDisembodied				= mod:NewSpecialWarningTaunt(179407)
local specWarnBefouled					= mod:NewSpecialWarningMoveAway(179711)--Aoe damage was disabled on ptr, bug?
local specWarnBefouledOther				= mod:NewSpecialWarningTargetCount(179711, false)
--Disarmed
local specWarnDisarmed					= mod:NewSpecialWarningSpell(179667)
local specWarnSeedofDestruction			= mod:NewSpecialWarningYou(181508, nil, nil, nil, 3, nil, 2)
local yellSeedsofDestruction			= mod:NewYell(181508)

--Armed
local timerRumblingFissureCD			= mod:NewCDTimer(40, 179582)
local timerBefouledCD					= mod:NewCDTimer(38, 179711)
local timerSoulCleaveCD					= mod:NewCDTimer(40, 179406)
local timerCavitationCD					= mod:NewCDTimer(40, 181461)
--Disarmed
local timerDisarmCD						= mod:NewCDTimer(85.8, 179667)
local timerSeedsofDestructionCD			= mod:NewCDTimer(14.5, 181508)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownDisarm					= mod:NewCountdown(85.8, 179667)
local countdownDisembodied				= mod:NewCountdownFades("AltTwo10", 179407, false)--Depends on whether or not you are going down.
local countdownSeedsofDestructionCD		= mod:NewCountdown(14.5, 181508)--Seeds cannot be cast while disarm countdown is running, so this is fine.
local countdownSeedsofDestruction		= mod:NewCountdownFades("Alt5", 181508)--Alt voice for expiring is good.

local voiceSoulCleave					= mod:NewVoice(179406)--"179406"
local voiceWakeofDestruction			= mod:NewVoice(181499)--watchwave
local voiceSeedsofDestruction			= mod:NewVoice(181508)--Runout

mod:AddRangeFrameOption(10, 179711)
--Icon options will conflict at 25-30 players (when you get 5 targets for each debuff). Below that, they can coexist.
mod:AddSetIconOption("SetIconOnBefouled", 179711, false)--Start at 1, ascending
mod:AddSetIconOption("SetIconOnSeeds", 181508, true)--Start at 8, descending. On by default, because it's quite imperative to know who/where seed targets are at all times.
mod:AddHudMapOption("HudMapOnSeeds", 181508)

mod.vb.befouledTargets = 0
mod.vb.FissureCount = 0
mod.vb.BefouledCount = 0
mod.vb.SoulCleaveCount = 0
mod.vb.CavitationCount = 0
mod.vb.SeedsCount = 0
mod.vb.Enraged = false

local befouledName = GetSpellInfo(179711)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, befouledName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", befouledName) then
		DBM.RangeCheck:Show(10)
	elseif self.vb.befouledTargets > 0 then
		DBM.RangeCheck:Show(10, debuffFilter)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.befouledTargets = 0
	self.vb.FissureCount = 0
	self.vb.BefouledCount = 0
	self.vb.SoulCleaveCount = 0
	self.vb.CavitationCount = 0
	self.vb.SeedsCount = 0
	self.vb.Enraged = false
	timerRumblingFissureCD:Start(6-delay, 1)
	timerBefouledCD:Start(17.5-delay, 1)
	timerSoulCleaveCD:Start(25-delay, 1)
	timerCavitationCD:Start(35-delay, 1)
	timerDisarmCD:Start(87.8-delay)
	countdownDisarm:Start(87.8-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnSeeds then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 179406 then
		self.vb.SoulCleaveCount = self.vb.SoulCleaveCount + 1
		specWarnSoulCleave:Show(self.vb.SoulCleaveCount)
		voiceSoulCleave:Play("179406")
		if self.vb.Enraged or self.vb.SoulCleaveCount == 1 then--Only casts two between phases, unless enraged
			timerSoulCleaveCD:Start(nil, self.vb.SoulCleaveCount+1)
		end
	elseif spellId == 181461 then
		self.vb.CavitationCount = self.vb.CavitationCount + 1
		specWarnWakeofDestruction:Show()
		voiceWakeofDestruction:Play("watchwave")
		if self.vb.Enraged or self.vb.CavitationCount == 1 then--Only casts two between phases, unless enraged
			timerCavitationCD:Start(nil, self.vb.CavitationCount+1)
		end
	elseif spellId == 179582 then
		self.vb.FissureCount = self.vb.FissureCount + 1
		warnRumblingFissure:Show(self.vb.FissureCount)
		if self.vb.Enraged or self.vb.FissureCount == 1 then--Only casts two between phases, unless enraged
			timerRumblingFissureCD:Start(nil, self.vb.FissureCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181508 then--Seed
		self.vb.SeedsCount = self.vb.SeedsCount + 1
		if self.vb.Enraged or self.vb.SeedsCount == 1 then--Only casts two between phases, unless enraged
			timerSeedsofDestructionCD:Start(nil, self.vb.SeedsCount+1)
			countdownSeedsofDestructionCD:Start(14.5)
		end
	elseif spellId == 179709 then--Foul
		self.vb.BefouledCount = self.vb.BefouledCount + 1
		if self.vb.Enraged or self.vb.BefouledCount == 1 then--Only casts two between phases, unless enraged
			timerBefouledCD:Start(nil, self.vb.BefouledCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181508 or spellId == 181515 then--No idea what 181515 is. 181508 confirmed heroic
		warnSeedofDestruction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSeedofDestruction:Show()
			yellSeedsofDestruction:Yell()
			voiceSeedsofDestruction:Play("runout")
		end
		if self:AntiSpam(5, 3) then
			specWarnWakeofDestruction:Schedule(3.5)--When debuff expires, waves (-1.5)
			voiceWakeofDestruction:Schedule(3.5, "watchwave")
			countdownSeedsofDestruction:Start()--Everyone, because waves occur.
		end
		if self.Options.SetIconOnSeeds and not self:IsLFR() then
			self:SetSortedIcon(0.7, args.destName, 8, nil, true)
		end
		if self.Options.HudMapOnSeeds then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 13, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
		end
	elseif spellId == 182008 then
		warnLatentEnergy:CombinedShow(1, args.destName)
	elseif spellId == 179667 then--Disarmed
		self.vb.SeedsCount = 0
		specWarnDisarmed:Show()
		timerSeedsofDestructionCD:Start(8.5, 1)
		countdownSeedsofDestructionCD:Start(8.5)
	elseif spellId == 179681 then--Enrage (has both armed and disarmed abilities)
		timerDisarmCD:Cancel()--Assumed
		countdownDisarm:Cancel()
		self.vb.Enraged = true
		warnEnrage:Show()
		DBM:AddMsg("Timers may not be correct for remainder of fight. Do not have data beyond this point")
		--TODO, figure out timers, depending on what phase he was in when he enraged, start timers that need starting, or maybe update all timers if that's how it works
	elseif spellId == 179711 then
		self.vb.befouledTargets = self.vb.befouledTargets + 1
		if args:IsPlayer() then
			specWarnBefouled:Show()
		end
		if self.Options.SpecWarn179771targetcount then
			specWarnBefouledOther:CombinedShow(0.3, self.vb.BefouledCount, args.destName)
		else
			warnBefouled:CombinedShow(0.3, self.vb.BefouledCount, args.destName)
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnBefouled and not self:IsLFR() then
			self:SetSortedIcon(0.7, args.destName, 1)
		end
	elseif spellId == 179407 then
		warnDisembodied:Show(self.vb.SoulCleaveCount, args.destName)
		specWarnWakeofDestruction:Schedule(8.5)--Waves when they return (-1.5)
		voiceWakeofDestruction:Schedule(8.5, "watchwave")
		countdownDisembodied:Start()--Everyone, because waves occur
		if not args:IsPlayer() then
			specWarnDisembodied:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 179711 then
		self.vb.befouledTargets = self.vb.befouledTargets - 1
		updateRangeFrame(self)
	elseif spellId == 181508 or spellId == 181515 then
		if self.Options.SetIconOnSeeds and not self:IsLFR() then
			self:SetIcon(args.destName, 0)--Number of targets not known yet, probably never will be if it's flexible and not mythic
		end
		if self.Options.HudMapOnSeeds then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 179667 then--Disarmed removed (armed)
		self.vb.FissureCount = 0
		self.vb.BefouledCount = 0
		self.vb.SoulCleaveCount = 0
		self.vb.CavitationCount = 0
		specWarnDisarmedEnd:Show()
		timerRumblingFissureCD:Start(3.5, 1)
		timerBefouledCD:Start(13.5, 1)
		timerSoulCleaveCD:Start(23, 1)
		timerCavitationCD:Start(33, 1)
		timerDisarmCD:Start()
		countdownDisarm:Start()
	end
end
