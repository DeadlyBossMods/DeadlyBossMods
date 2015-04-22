local mod	= DBM:NewMod(1391, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91394)
mod:SetEncounterID(1777)
mod:SetZone()
mod:SetUsedIcons(3, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 179406 181461",
	"SPELL_CAST_SUCCESS 179582",
	"SPELL_AURA_APPLIED 181508 181515 182008 179670 179711 179681 179407",
	"SPELL_AURA_REMOVED 179711",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, two versions of seed? one with shorter duration? shorter one mythic?
--TODO, does first armed fire afer ENCOUNTER_START, or does he already have buff and first armed timers started with oncombatstart?
--TODO, need voice for "Soul Cleave"
--TODO, auto send latent energy targets down for disembodied?
--TODO, maybe add seeds HUD
--Encounter-Wide Mechanics
local warnLatentEnergy					= mod:NewTargetAnnounce(182008, 3, nil, false)
local warnEnrage						= mod:NewSpellAnnounce(179681, 3)
local warnDisembodied					= mod:NewTargetAnnounce(179407, 2)
--Armed
local warnArmed							= mod:NewTargetAnnounce(179670, 2)
local warnRumblingFissure				= mod:NewSpellAnnounce(179582, 2)
local warnBefouled						= mod:NewTargetAnnounce(179711, 2, nil, "Healer")
--Disarmed
local warnDisarmed						= mod:NewSpellAnnounce(179667, 2)--Switch to throw axe maybe? This one more likely in combat log
local warnSeedofDestruction				= mod:NewTargetAnnounce(181508, 4)

--Encounter-Wide Mechanics
local specWarnWakeofDestruction			= mod:NewSpecialWarningSpell(181499, nil, nil, nil, 2, nil, 2)--Triggered by 3 different things
--Armed
local specWarnSoulCleave				= mod:NewSpecialWarningSpell(179406, nil, nil, nil, 1, nil, 5)--Tanks and anyone else that needs to get disembodied, so warn all
local specWarnBefouled					= mod:NewSpecialWarningMoveAway(179711)
local specWarnBefouledOther				= mod:NewSpecialWarningTarget(179711, false)
--Disarmed
local specWarnSeedofDestruction			= mod:NewSpecialWarningMoveAway(181508, nil, nil, nil, 1, nil, 2)

--Encounter-Wide Mechanics
--local timerSeedsofDestructionCD			= mod:NewCDTimer(107, 181508)
--Armed
--local timerSoulCleaveCD					= mod:NewCDTimer(107, 179406)
--local timerCavitationCD					= mod:NewCDTimer(107, 181461)
--local timerBefouledCD						= mod:NewCDTimer(107, 179711)

--local berserkTimer						= mod:NewBerserkTimer(360)

local countdownDisembodied					= mod:NewCountdownFades("AltTwo10", 179407)
--local countdownSeedsofDestruction			= mod:NewCountdownFades("Alt4", 181508)--Do something with later

local voiceSoulCleave						= mod:NewVoice(179406)--"179406"
local voiceWakeofDestruction				= mod:NewVoice(181499)--watchwave
local voiceSeedsofDestruction				= mod:NewVoice(181508)--Runout

mod:AddRangeFrameOption(10, 179711)
mod:AddSetIconOption("SetIconOnBefouled", 179711, false)

mod.vb.befouledTargets = 0

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
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 179406 then
		specWarnSoulCleave:Show()
		voiceSoulCleave:Play("179406")
		--timerSoulCleaveCD:Start()
	elseif spellId == 181461 then
		specWarnWakeofDestruction:Show()
		voiceWakeofDestruction:Play("watchwave")
		--timerCavitationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 179582 and self:AntiSpam(2, 1) then
		warnRumblingFissure:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181508 or spellId == 181515 then
		warnSeedofDestruction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSeedofDestruction:Show()
			voiceSeedsofDestruction:Play("runout")
		end
		if self:AntiSpam(3, 2) then
			specWarnWakeofDestruction:Schedule(3)--When debuff expires, waves
			voiceWakeofDestruction:Schedule(3, "watchwave")
			--countdownSeedsofDestruction:Start()--Everyone, because waves occur. Need to get duration from buff Id though?
		end
	elseif spellId == 182008 then
		warnLatentEnergy:CombinedShow(0.3, args.destName)
	elseif spellId == 179670 then--Armed
		--Cancel timers for abilities he loses while armed.
		--timerSoulCleaveCD:Start()
		--timerCavitationCD:Start()
		warnArmed:Show(args.destName)
	elseif spellId == 179667 then--Disarmed
		--timerSoulCleaveCD:Cancel()
		--timerCavitationCD:Cancel()
	elseif spellId == 179681 then--Enrage (has both armed and disarmed abilities)
		--Start timers for armed again? do timers for disarmed reset?
		--timerSoulCleaveCD:Start()
		--timerCavitationCD:Start()
	elseif spellId == 179711 then
		self.vb.befouledTargets = self.vb.befouledTargets + 1
		if args:IsPlayer() then
			specWarnBefouled:Show()
		end
		--If not more than 1 target, move this part to else rule to above IsPlayer
		if self.Options.SpecWarn179771target then
			specWarnBefouled:CombinedShow(0.3, args.destName)
		else
			warnBefouled:CombinedShow(0.3, args.destName)
		end
		updateRangeFrame(self)
		--If not more than 1 target, move this part to else rule to above IsPlayer
		if self.Options.SetIconOnBefouled and not self:IsLFR() then
			self:SetSortedIcon(1, args.destName, 1)--Number of targets not known yet, probably never will be if it's flexible and not mythic
		end
	elseif spellId == 179407 then
		warnDisembodied:CombinedShow(0.3, args.destName)
		if self:AntiSpam(3, 3) then
			specWarnWakeofDestruction:Schedule(8.5)--Waves when they return
			voiceWakeofDestruction:Schedule(8.5, "watchwave")
			countdownDisembodied:Start()--Everyone, because waves occur
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 179711 then
		self.vb.befouledTargets = self.vb.befouledTargets - 1
		updateRangeFrame(self)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
