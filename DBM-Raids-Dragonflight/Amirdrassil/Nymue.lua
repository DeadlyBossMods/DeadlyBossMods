local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8)
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 426147 426519 424477",
	"SPELL_CAST_SUCCESS 418490",
	"SPELL_SUMMON 421419",
	"SPELL_AURA_APPLIED 420554 420920 425745 425781 423195",
	"SPELL_AURA_APPLIED_DOSE 420554 420920",
	"SPELL_AURA_REMOVED 413443 425745 425781 423195"
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, timer sequences, since they get faster each Continuum. AI timers will be lousy for Rain and flora. they are placeholder!
--TODO, https://www.wowhead.com/ptr-2/spell=413540/dream-tether for mythic?
--TODO, possibly infoframe to track some things, but need the fight overview and mythic mechanics to gauge it
--TODO, honestly figure out what damn spells this fight actually still uses. journal is so badly unfinished
--TODO, right threads ID
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(22309))
--local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnProtectorsShroudOver						= mod:NewEndAnnounce(425794, 1)
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
local warnLifeSplice								= mod:NewStackAnnounce(420920, 2, nil, "Tank|Healer")--Not grouped, so spell key is shown separate in GUI
local warnThreadsofLife								= mod:NewCountAnnounce(425745, 2)
local warnInflorescence								= mod:NewYouAnnounce(423195, 1)

local specWarnContinuum								= mod:NewSpecialWarningYou(420846, nil, nil, nil, 2, 2)
local specWarnThreadedBlast							= mod:NewSpecialWarningDefensive(426147, nil, nil, nil, 1, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(426520, nil, nil, nil, 1, 2)
local yellWeaversBurden								= mod:NewShortYell(426520)
local yellWeaversBurdenFades						= mod:NewShortFadesYell(426520)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(426520, nil, nil, nil, 1, 2)
local specWarnThreadsFixate							= mod:NewSpecialWarningYou(425745, nil, nil, nil, 1, 2)
local yellThreadsFixate								= mod:NewShortYell(425745)
local specWarnViolentFlora							= mod:NewSpecialWarningDodgeCount(424477, nil, nil, nil, 2, 2)
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerContinuumCD								= mod:NewAITimer(49, 420846, nil, nil, nil, 3)
local timerThreadedBlastCD							= mod:NewAITimer(11.8, 426147, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerWeaversBurdenCD							= mod:NewAITimer(11.8, 426520, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerThreadsofLifeCD							= mod:NewAITimer(49, 425745, nil, nil, nil, 3)
local timerViolentFloraCD							= mod:NewAITimer(49, 424477, nil, nil, nil, 3)
local timerViridianRainCD							= mod:NewAITimer(49, 420907, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {8})
mod:AddNamePlateOption("NPFixate", 425745, true)

local castsPerGUID = {}
local playerInflorescence = false
mod.vb.contCount = 0
mod.vb.blastCount = 0
mod.vb.burdenCount = 0
mod.vb.threadsCount = 0
mod.vb.floraCount = 0
mod.vb.rainCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.contCount = 0
	self.vb.blastCount = 0
	self.vb.burdenCount = 0
	self.vb.threadsCount = 0
	self.vb.floraCount = 0
	self.vb.rainCount = 0
	timerContinuumCD:Start(1-delay)
	timerThreadedBlastCD:Start(1-delay)
	timerWeaversBurdenCD:Start(1-delay)
	timerThreadsofLifeCD:Start(1-delay)
	timerViolentFloraCD:Start(1-delay)
	timerViridianRainCD:Start(1-delay)
	if self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitBuff("player", 423195) then
		playerInflorescence = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420846 then
		self.vb.contCount = self.vb.contCount + 1
		specWarnContinuum:Show(self.vb.contCount)
		specWarnContinuum:Play("aesoon")
		timerContinuumCD:Start()
	elseif spellId == 426147 then
		self.vb.blastCount = self.vb.blastCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnThreadedBlast:Show(self.vb.blastCount)
			specWarnThreadedBlast:Play("defensive")
		end
		timerThreadedBlastCD:Start()
	elseif spellId == 426519 then
		self.vb.burdenCount = self.vb.burdenCount + 1
		timerWeaversBurdenCD:Start()
	elseif spellId == 424477 then
		self.vb.floraCount = self.vb.floraCount + 1
		specWarnViolentFlora:Show(self.vb.floraCount)
		specWarnViolentFlora:Play("watchstep")
		timerViolentFloraCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 418490 then
		self.vb.threadsCount = self.vb.threadsCount + 1
		warnThreadsofLife:Show(self.vb.threadsCount)
		timerThreadsofLifeCD:Start()
	elseif spellId == 420907 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnViridianRain:Show(self.vb.rainCount)
		specWarnViridianRain:Play("watchstep")
		timerViridianRainCD:Start()
	end
end

--https://www.wowhead.com/ptr-2/spell=418491/everweaving-threads
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 421419 then--Cycle Warden
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnWarden then
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnWarden")
			end
		end
--	elseif spellId == 384757 then--Thunder Caller

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420554 then
		if args:IsPlayer() and not playerInflorescence then
			warnVerdantMatrix:Cancel()
			warnVerdantMatrix:Schedule(1, args.amount or 1)
		end
	elseif spellId == 420920 then
		local amount = args.amount or 1
--		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--		local remaining
--		if expireTime then
--			remaining = expireTime-GetTime()
--		end
--		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 376279, self.vb.slamCount+1) or 17.9) - 5
--		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--			specWarnConcussiveSlamTaunt:Show(args.destName)
--			specWarnConcussiveSlamTaunt:Play("tauntboss")
--		else
			warnLifeSplice:Show(args.destName, amount)
--		end
	elseif spellId == 427722 or spellId == 426520 then
		if args:IsPlayer() then
			specWarnWeaversBurden:Show()
			specWarnWeaversBurden:Play("runout")
			yellWeaversBurden:Yell()
			yellWeaversBurdenFades:Countdown(spellId)
		else
			specWarnWeaversBurdenOther:Show(args.destName)
			specWarnWeaversBurdenOther:Play("tauntboss")
		end
	elseif spellId == 425745 or spellId == 425781 then
		if args:IsPlayer() then
			specWarnThreadsFixate:Show()
			specWarnThreadsFixate:Play("targetyou")
			yellThreadsFixate:Yell()
			if self.Options.NPFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = true
			if self:AntiSpam(3, 1) then
				warnInflorescence:Show()
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 413443 then
		warnProtectorsShroudOver:Show()
	elseif spellId == 427722 or spellId == 426520 then
		if args:IsPlayer() then
			yellWeaversBurdenFades:Cancel()
		end
	elseif spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = false
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 409058 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--https://www.wowhead.com/ptr-2/spell=421419/continuum
--https://www.wowhead.com/ptr-2/npc=208813/threads-of-life
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 then

	end
end
--]]
