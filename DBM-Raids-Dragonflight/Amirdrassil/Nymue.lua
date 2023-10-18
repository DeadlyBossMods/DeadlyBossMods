local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8, 7, 6)
mod:SetHotfixNoticeRev(20230923000000)
mod:SetMinSyncRevision(20230923000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 423094 429108 429180 429615 426855",--426519 426147 424477
	"SPELL_CAST_SUCCESS 420907",
	"SPELL_SUMMON 421419 428465",
	"SPELL_AURA_APPLIED 420554 425745 425781 423195 427722 426520",
	"SPELL_AURA_APPLIED_DOSE 420554",
	"SPELL_AURA_REMOVED 413443 425745 425781 423195 427722 426520",
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, possibly infoframe to track some things, but need the fight overview and mythic mechanics to gauge it
--TODO, redo every timer and stage detection and clean up scrapped spells that don't end up getting reused on mythic.
--TODO, verify distance filtering for warden abilities since there are two of them
--TODO, Radial Flourish doesn't have a clear cast ID
--TODO, Unravel stack tracking in Stage 2?
--TODO, Radial Flourish mechanic?
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Rapid Iteration
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28355))
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
--local warnThreadsofLife							= mod:NewCountAnnounce(425745, 2)
local warnInflorescence								= mod:NewYouAnnounce(423195, 1)

local specWarnContinuum								= mod:NewSpecialWarningYou(420846, nil, nil, nil, 2, 2)
local specWarnImpendingLoom							= mod:NewSpecialWarningDodgeCount(429615, nil, nil, nil, 2, 2)
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(427722, nil, nil, nil, 1, 2)
local yellWeaversBurden								= mod:NewShortYell(427722)
local yellWeaversBurdenFades						= mod:NewShortFadesYell(427722)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(427722, nil, nil, nil, 1, 2)
--local specWarnThreadsFixate						= mod:NewSpecialWarningYou(425745, nil, nil, nil, 1, 2)
--local yellThreadsFixate							= mod:NewShortYell(425745)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerContinuumCD								= mod:NewAITimer(90, 420846, nil, nil, nil, 3)
local timerImpendingLoomCD							= mod:NewAITimer(90, 429615, nil, nil, nil, 3)
local timerSurgingGrowthCD							= mod:NewAITimer(49, 424477, nil, nil, nil, 3)
local timerViridianRainCD							= mod:NewAITimer(49, 420907, nil, nil, nil, 3)
local timerWeaversBurdenCD							= mod:NewAITimer(11.8, 427722, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerThreadsofLifeCD							= mod:NewCDCountTimer(49, 425745, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
--mod:AddNamePlateOption("NPFixate", 425745, true)

--Stage Two: Creation Complete
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28356))
--local warnLifeWardOver								= mod:NewEndAnnounce(425794, 1)
local warnSurgingGrowth								= mod:NewCountAnnounce(424477, 2)

--local specWarnNatureVolley						= mod:NewSpecialWarningInterruptCount(426854, "HasInterrupt", nil, nil, 1, 2)
local specWarnLumberingSlam							= mod:NewSpecialWarningDodge(429108, nil, nil, nil, 2, 2)

local timerFullBloomCD								= mod:NewAITimer(49, 426855, nil, nil, nil, 6)
--local timerNatureVolleyCD							= mod:NewCDNPTimer(11.8, 426854, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
--local timerLumberingSlamCD						= mod:NewCDTimer(11.8, 429108, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {7, 6})
mod:AddSetIconOption("SetIconOnManifestedDream", -28223, true, 5, {8})

mod.vb.contCount = 0
mod.vb.loomCount = 0
mod.vb.burdenCount = 0
--mod.vb.threadsCount = 0
mod.vb.surgingCount = 0
mod.vb.rainCount = 0
mod.vb.wardenIcon = 7
local castsPerGUID = {}
local playerInflorescence = false
local difficultyName = "heroic"
local allTimers = {
	["heroic"] = {--All timers are obsolete, from before rework
		--Surging Growth
		[424477] = {15.1, 13.4, 14.4, 12.1, 8.4, 13.5, 31.8, 20.0, 20.0, 21.5, 26.6, 9.9, 15.2, 12.0, 6.5, 12.0, 32.1, 7.8, 15.0, 14.0, 4.5, 15.5, 32.5, 20.0, 20.0, 21.6, 26.5, 9.9, 15.1},
		--Weaver's Burden
		[426520] = {27.0, 25.1, 23.5, 64.1, 25.5, 64.4, 24.0, 69.5, 20.0, 64.6, 25.5},
		--Threads of Life
--		[425745] = {35.0, 13.0, 12.0, 18.7, 36.7, 8.0, 12.0, 18.0, 10.4, 29.4, 11.0, 18.0, 12.0, 18.0, 28.6, 2.1, 10.3, 16.5, 12.0, 20.9, 37.1, 8.0, 12.0, 18.0, 13.6, 29.5, 12.5, 16.4},
		--Viridian Rain
		[420907] = {7.0, 33.0, 37.0, 31.8, 15.0, 20.5, 29.5, 23.1, 7.8, 11.7, 6.5, 10.4, 8.0, 10.5, 4.5, 112.5, 15.6, 20.0, 29.4, 23.1, 7.9, 12.0, 9.5},--the 112-114 is not a mistake, saw in more than one pull
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	self.vb.contCount = 0
	self.vb.loomCount = 0
	self.vb.burdenCount = 0
--	self.vb.threadsCount = 0
	self.vb.surgingCount = 0
	self.vb.rainCount = 0
	self.vb.wardenIcon = 7
	timerViridianRainCD:Start(1)
	timerImpendingLoomCD:Start(1)
	timerSurgingGrowthCD:Start(1)
	timerWeaversBurdenCD:Start(1)
--	timerThreadsofLifeCD:Start(1)
	timerContinuumCD:Start(1)
	timerFullBloomCD:Start(1)
	if self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
	--Just so luacheck doesn't bitch these are set but not accessed
	if allTimers[difficultyName] then
		--Do absolutely nothing
		DBM:Debug("Break yourself upon my body", 3)
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
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420846 then
		self.vb.contCount = self.vb.contCount + 1
		self.vb.wardenIcon = 7
		specWarnContinuum:Show(self.vb.contCount)
		specWarnContinuum:Play("aesoon")
		timerContinuumCD:Start(nil, self.vb.contCount+1)
	elseif spellId == 429615 then
		self.vb.loomCount = self.vb.loomCount + 1
		specWarnImpendingLoom:Show(self.vb.loomCount)
		specWarnImpendingLoom:Play("watchstep")
		timerImpendingLoomCD:Start()
	elseif spellId == 426855 then--Full Bloom
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerViridianRainCD:Stop()
		timerImpendingLoomCD:Stop()
		timerSurgingGrowthCD:Stop()
		timerWeaversBurdenCD:Stop()
--		timerThreadsofLifeCD:Stop()
		timerContinuumCD:Stop()
--	elseif spellId == 423094 then
--		self.vb.threadsCount = self.vb.threadsCount + 1
--		warnThreadsofLife:Show(self.vb.threadsCount)
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.threadsCount+1)
--		if timer then
--			timerThreadsofLifeCD:Start(timer, self.vb.threadsCount+1)
--		end
--	elseif spellId == 426854 then
--		timerNatureVolleyCD:Start(nil, args.sourceGUID)
--		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but just in case
--			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnWarden then
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.wardenIcon, 1, nil, 12, "SetIconOnWarden")
--			end
--			self.vb.wardenIcon = self.vb.wardenIcon - 1
--		end
--		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
--		local count = castsPerGUID[args.sourceGUID]
--		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
--			specWarnNatureVolley:Show(args.sourceName, count)
--			if count < 6 then
--				specWarnNatureVolley:Play("kick"..count.."r")
--			else
--				specWarnNatureVolley:Play("kickcast")
--			end
--		end
	elseif spellId == 429108 or spellId == 429180 then
		if self:CheckBossDistance(args.sourceGUID, false, 32321, 13) then--fine tune, maybe use 18/6450
			specWarnLumberingSlam:Show()
			specWarnLumberingSlam:Play("shockwave")
		end
		--timerLumberingSlamCD:Start(nil, args.sourceGUID)
--	elseif spellId == 426519 then
--		self.vb.burdenCount = self.vb.burdenCount + 1
--		timerWeaversBurdenCD:Start()
--	elseif spellId == 424477 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		specWarnSurgingGrowth:Show(self.vb.surgingCount)
--		specWarnSurgingGrowth:Play("watchstep")
--		timerSurgingGrowthCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 420907 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnViridianRain:Show(self.vb.rainCount)
		specWarnViridianRain:Play("watchstep")
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.rainCount+1)
--		if timer then
			timerViridianRainCD:Start(100, self.vb.rainCount+1)
--		end
	end
end

--https://www.wowhead.com/ptr-2/spell=418491/everweaving-threads
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 421419 then--Cycle Warden
		if not castsPerGUID[args.destGUID] then
--			timerNatureVolleyCD:Start(nil, args.destGUID)
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnWarden then
				self:ScanForMobs(args.destGUID, 2, self.vb.wardenIcon, 1, nil, 12, "SetIconOnWarden")
			end
			self.vb.wardenIcon = self.vb.wardenIcon - 1
		end
	elseif spellId == 428465 then--Manifested Dream
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnManifestedDream then
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnManifestedDream")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420554 then
		if args:IsPlayer() and not playerInflorescence then
			warnVerdantMatrix:Cancel()
			warnVerdantMatrix:Schedule(1, args.amount or 1)
		end
	elseif spellId == 427722 or spellId == 426520 then--427722 to be only one now
		DBM:AddMsg("Tank mechanic was completely reworked so old warnings disabled until they too can be reworked")
		if args:IsPlayer() then
			specWarnWeaversBurden:Show()
			specWarnWeaversBurden:Play("runout")
			yellWeaversBurden:Yell()
			yellWeaversBurdenFades:Countdown(spellId)
		else
			specWarnWeaversBurdenOther:Show(args.destName)
			specWarnWeaversBurdenOther:Play("tauntboss")
		end
--	elseif spellId == 425745 or spellId == 425781 then--425745 confirmed on heroic
--		if args:IsPlayer() then
--			specWarnThreadsFixate:Show()
--			specWarnThreadsFixate:Play("targetyou")
--			yellThreadsFixate:Yell()
--			if self.Options.NPFixate then
--				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
--			end
--		end
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
	if spellId == 413443 then--Both wardens dead and shield on boss removed (assumed)
		self:SetStage(1)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("pone")
		timerViridianRainCD:Start(2)
		timerImpendingLoomCD:Start(2)
		timerSurgingGrowthCD:Start(2)
		timerWeaversBurdenCD:Start(2)
--		timerThreadsofLifeCD:Start(1)
		timerContinuumCD:Start(2)
		timerFullBloomCD:Start(2)
	elseif spellId == 427722 or spellId == 426520 then--426520 confirmed on heroic
		if args:IsPlayer() then
			yellWeaversBurdenFades:Cancel()
		end
--	elseif spellId == 425745 or spellId == 425781 then--425745 confirmed on heroic
--		if args:IsPlayer() then
--			if self.Options.NPFixate then
--				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
--			end
--		end
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden
--		timerNatureVolleyCD:Stop(args.destGUID)
		--timerLumberingSlamCD:Stop(args.destGUID)
--	elseif cid == 428465 then--Manifested Dream

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 423858 then--Surging Growth
		self.vb.surgingCount = self.vb.surgingCount + 1
		warnSurgingGrowth:Show(self.vb.surgingCount)
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.surgingCount+1)
--		if timer then
			timerSurgingGrowthCD:Start(100, self.vb.surgingCount+1)
--		end
	elseif spellId == 426519 then--Weaver's Burden
		self.vb.burdenCount = self.vb.burdenCount + 1
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.burdenCount+1)
--		if timer then
			timerWeaversBurdenCD:Start(100, self.vb.burdenCount+1)
--		end
	end
end
