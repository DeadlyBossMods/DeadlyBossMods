local mod	= DBM:NewMod(2553, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(208445)
mod:SetEncounterID(2731)
mod:SetUsedIcons(6, 7, 8)
mod:SetHotfixNoticeRev(20240315000000)
mod:SetMinSyncRevision(20231115000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 425889 426524 422614 418637 426206 417634 427252 427343 429973 421325",
	"SPELL_CAST_SUCCESS 417653 419485 427299",
	"SPELL_AURA_APPLIED 425888 425468 420544 426387 423719 426249 426256 421316 427299 427306 421594 418520 429032",-- 428946 421407
	"SPELL_AURA_APPLIED_DOSE 426249 426256 418520 429032",-- 428946 421407
	"SPELL_AURA_REMOVED 421316 427299 421594",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 417632",
	"SPELL_PERIODIC_MISSED 417632",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--[[
(ability.id = 425889 or ability.id = 426524 or ability.id = 422614 or ability.id = 418637 or ability.id = 426206 or ability.id = 417634 or ability.id = 427252 or ability.id = 427343 or ability.id = 429973 or ability.id = 421325) and type = "begincast"
 or (ability.id = 417653 or ability.id = 427299 or ability.id = 428901) and type = "cast"
 or ability.id = 421316 and (type = "applybuff" or type = "removebuff")
 or ability.id = 419485 and type = "cast"
--]]
--TODO, repeat yells for igniting growth? depends on if it's few targets or everyone.
--TODO, https://www.wowhead.com/ptr-2/spell=426393/seed-of-life is probably cast on pull, so no reason to alert, unless cast more than once
--TODO, best way to track https://www.wowhead.com/ptr-2/spell=425531/dream-fatigue ? Infoframe?
--TODO, nameplate aura for 424997 on Seed of life? (IE do they have visible nameplates it'd be usefulf or)
--TODO, maybe infoframe for tracking Blazing Coal stacks?
--TODO, more with the tank stuff?
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(417632, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Cycle of Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27241))
local warnForces									= mod:NewCountAnnounce(417653, 3)
local warnBlisteringSplinters						= mod:NewCountAnnounce(418520, 3, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(418520))--Player
--local warnDreamBlossom							= mod:NewTargetNoFilterAnnounce(425468, 2, nil, false)--non filtered, but off by default
local warnScorchingRoots							= mod:NewCountAnnounce(422614, 3)
local warnCharredTreant								= mod:NewSpellAnnounce(417667, 2, nil, "Healer")
local warnRenewedTreant								= mod:NewSpellAnnounce(417668, 1)
local warnScorchingBramblethorn						= mod:NewTargetNoFilterAnnounce(426387, 2, nil, false)--Hella spammy. not to be defaulted
local warnNaturesBulwark							= mod:NewSpellAnnounce(419485, 1)
local warnBlazingCoalescence						= mod:NewCountAnnounce(426249, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(426249))--Player
local warnBlazingCoalescenceBoss					= mod:NewStackAnnounce(426256, 4)--Boss
local warnEverlastingBlaze							= mod:NewCountAnnounce(429032, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(429032))--Player
local warnIgnitingGrowth							= mod:NewCountAnnounce(425889, 3)

local specWarnCharredBrambles						= mod:NewSpecialWarningSwitch(418655, "Healer", nil, nil, 1, 2)
--local specWarnIgnitingGrowth						= mod:NewSpecialWarningMoveAway(425889, nil, nil, nil, 1, 2, 4)
--local yellIgnitingGrowth							= mod:NewShortYell(425889, nil, false)
--local specWarnDreamBlossom						= mod:NewSpecialWarningYou(425468, nil, nil, nil, 1, 2)
--local yellDreamBlossom							= mod:NewShortYell(425468, nil, false)
local specWarnFieryFlourish							= mod:NewSpecialWarningInterruptCount(426524, "HasInterrupt", nil, nil, 1, 2)
--local specWarnScorchingPursuit					= mod:NewSpecialWarningRun(420544, nil, nil, nil, 4, 2)--BW using 420546, but may change to 420544
--local yellScorchingPursuit						= mod:NewShortYell(420544)
local specWarnScorchingBramblethorn					= mod:NewSpecialWarningYou(426387, nil, nil, nil, 1, 2)
local specWarnFuriousCharge							= mod:NewSpecialWarningRun(418637, nil, 100, nil, 4, 2)
local yellFuriousCharge								= mod:NewShortYell(418637, 100)
local specWarnFuriousChargePreTaunt					= mod:NewSpecialWarningTaunt(418637, nil, 100, nil, 1, 2)--Taunt on cast start
local specWarnNaturesFury							= mod:NewSpecialWarningTaunt(423719, nil, nil, nil, 1, 2)--Yell to taunt again if you didn't taunt in pre cast
local specWarnBlazingThornsAvoid					= mod:NewSpecialWarningDodgeCount(426206, "-Healer", nil, nil, 1, 2)--Initial cast to dodge
local specWarnBlazingThornsSoak						= mod:NewSpecialWarningSoakCount(426249, "-Healer", nil, nil, 1, 2)--Follow up orbs to soak
local specWarnRagingInferno							= mod:NewSpecialWarningMoveTo(417634, nil, 37625, nil, 3, 2)--Shortname Inferno

local timerIgnitingGrowthCD							= mod:NewCDCountTimer(49, 425889, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFieryForceofNatureCD						= mod:NewCDCountTimer(11.8, 417653, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerFieryFlourishCD							= mod:NewCDNPTimer(9.7, 426524, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
local timerScorchingRootsCD							= mod:NewCDCountTimer(49, 422614, DBM_COMMON_L.ROOTS.." (%s)", nil, nil, 3)
local timerFuriousChargeCD							= mod:NewCDCountTimer(22.5, 418637, 100, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--SN "Charge"
local timerBlazingThornsCD							= mod:NewCDCountTimer(49, 426206, DBM_COMMON_L.DODGES.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerBlazingThornsSoak						= mod:NewCastTimer(5, 426249, DBM_COMMON_L.ORBS.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)
local timerRagingInfernoCD							= mod:NewCDCountTimer(49, 417634, 37625, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--SN "Inferno"

mod:AddPrivateAuraSoundOption(425888, true, 425889, 1)--Igniting Growth
mod:AddPrivateAuraSoundOption(425468, true, 425468, 1)--Dream Blossom
mod:AddPrivateAuraSoundOption(420544, true, 420544, 4)--Scorching Pursuit
mod:AddSetIconOption("SetIconOnForces", 417653, true, 5, {8, 7, 6})

mod:JustSetCustomKeys(426256, "|cff69ccf0426256|r (" .. DBM_COMMON_L.BOSS .. ")")
mod:JustSetCustomKeys(426249, "|cff69ccf0426249|r (" .. PLAYER .. ")")
--Intermission: Unreborn Again
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27242))
local warnConsumingFlame							= mod:NewTargetNoFilterAnnounce(421316, 2)

local timerConsumingFlame							= mod:NewBuffActiveTimer(16, 421316, nil, nil, nil, 6)
--Stage Two: Avatar of Ash
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27243))
local warnFlashFire									= mod:NewTargetNoFilterAnnounce(427299, 3, nil, "Healer")
local warnEncasedInAsh								= mod:NewTargetNoFilterAnnounce(427306, 4, nil, "RemoveMagic")
local warnAshenCall									= mod:NewCountAnnounce(421325, 2)
--local warnSearingAsh								= mod:NewCountAnnounce(421407, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(426249))
local warnAshenDevastation							= mod:NewCountAnnounce(428896, 3, nil, nil, 167180)--Shortname "Bombs"

local specWarnFallingEmbers							= mod:NewSpecialWarningSoakCount(427252, nil, nil, nil, 2, 2)
local specWarnFlashFire								= mod:NewSpecialWarningMoveAway(427299, nil, nil, nil, 1, 2)--Blizzard didn't flag right spellids as private aura, so this probably still works for now
local yellFlashFire									= mod:NewShortYell(427299)--Blizzard didn't flag right spellids as private aura, so this probably still works for now
local yellFlashFireFades							= mod:NewShortFadesYell(427299)--Blizzard didn't flag right spellids as private aura, so this probably still works for now
local specWarnEncasedInAsh							= mod:NewSpecialWarningYou(427306, nil, nil, nil, 1, 2)
local yellEncasedInAsh								= mod:NewShortYell(427306)
local specWarnFireWhirl								= mod:NewSpecialWarningDodgeCount(427343, nil, 86189, nil, 2, 2)
local specWarnSmolderingBackdraft					= mod:NewSpecialWarningDefensive(429973, nil, nil, nil, 1, 2)
local specWarnSmolderingSuffocation					= mod:NewSpecialWarningTaunt(421594, nil, nil, nil, 1, 2)
local yellSmolderingSuffocationRepeater				= mod:NewIconRepeatYell(421594, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell, false, nil, "YELL")--using custom yell text "%s" because of custom needs (it has to use not only icons but two asci emoji
--local specWarnAshenDevestation					= mod:NewSpecialWarningMoveAway(428896, nil, 37859, nil, 1, 2, 4)
--local yellAshenDevestation						= mod:NewShortYell(428896, 37859)--Shortname "Bomb"
--local yellAshenDevestationFades					= mod:NewShortFadesYell(428896)

local timerFallingEmbersCD							= mod:NewCDCountTimer(49, 427252, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)
local timerFlashFireCD								= mod:NewCDCountTimer(49, 427299, L.HealAbsorb, nil, nil, 3)
local timerFireWhirlCD								= mod:NewCDCountTimer(50, 427343, 86189, nil, nil, 3)--Shortname "Tornados"
local timerSmolderingBackdraftCD					= mod:NewCDCountTimer(49, 429973, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAshenCallCD								= mod:NewCDCountTimer(11.8, 421325, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerAshenDevestationCD						= mod:NewCDCountTimer(49, 428896, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddPrivateAuraSoundOption(421461, true, 427299, 1)--Flash Fire
mod:AddPrivateAuraSoundOption(428901, true, 428896, 1)--Ashen Devestation

--Stage 1
mod.vb.ignitingCount = 0--Reused in stage 2 for Ashen Devestation
mod.vb.forcesCount = 0--Reused in Stage 2 for Ashen Call
mod.vb.treeIcon = 8
mod.vb.scorchingRootCount = 0--Reused in Stage 2 for Falling Embers
mod.vb.furiousChargeCount = 0--Reused in Stage 2 for Smoldering Backdraft
mod.vb.thornsCount = 0--Reused in Stage 2 for Flash Fire
mod.vb.infernoCount = 0--Reused in Stage 2 for Fire Whirl

local castsPerGUID = {}
local difficultyName = "other"
local allTimers = {
	["mythic"] = {--Stage 1 seems same as other difficulties, but kept split for now
		--Stage 1
		--Fiery Force of Nature
		[417653] = {6.5, 104.9, 97.7},
				--	6.6, 105.5, 98.3
				--	6.5, 104.9, 98.8
				--	6.6, 104.9, 98.6
		--Blazing Thorns
		[426206] = {30.7, 24.2, 24.2, 37.3, 52.7, 64.4, 24.2, 24.2, 46.5, 65.5},
				--	30.7, 24.2, 24.2, 38.5, 52.8, 64.3, 24.2
				--	30.7, 24.2, 24.2, 38.0, 52.6, 64.7, 24.2, 24.1
				--	30.8, 24.2, 24.2, 37.8, 52.8, 64.5, 24.2
		--Furious Charge
		--[418637] = {21.9, 22.0, 24.2, 24.2, 24.2, 28.6, 25.2},--Wildly variant, no longer used, auto corrected elsewhere
				--	21.9, 22.0, 24.2, 36.2, 24.2, 28.6, 25.3
				--	21.9, 24.2, 35.1, 24.2, 28.6, 25.2, 43.5, 22.0, 24.2, 22.50, 46.60, 22.30, 31.10, 13.30
				--	22.0, 22.0, 24.2, 35.6, 24.2, 28.6, 25.2, 43.7, 21.9
		--Scorching Roots
		[422614] = {37.3, 110.3, 92.8, 120.2},
				--	37.3, 110.9, 93.0, 120.2
				--	37.3, 111.0, 92.8
				--	37.3, 110.5, 93.3
				--	37.4, 110.3, 93.1
		--Igniting Growth (Mythic Only)
		[425889] = {14.2, 123.5, 79.0},
				--	14.2, 124.1, 79.0
				--	14.3, 124.2, 79.6
				--	14.3, 123.5, 79.9
		--Stage 2
		--Falling Embers
		[427252] = {7.4, 26.7, 35.9, 21.7, 18.4, 38.5, 23.4},
				--	7.4, 26.7, 35.9, 21.7
				--	7.4, 26.7, 35.9, 21.8
				--	7.4, 26.7, 35.9, 21.7

		--FlashFire
		[427299] = {29.0, 50.1, 27.6, 50.2},
				--	29.0, 50.1, 36.7, 50.2
				--	29.0, 51.8, 27.6
				--	29.0, 51.8
				--	29.0, 51.8
		--Fire Whirl
		[427343] = {59.1, 32.5, 50.2},
				--	60.8, 32.5, 50.2
				--	59.1, 38.4
				--	59.1, 38.
		--Smoldering backdraft
		[429973] = {14.0, 25.8, 19.2, 21.7, 16.7, 25.10, 18.4},
				--	14.0, 25.8, 19.2, 21.7, 16.7, 25.10, 18.4
				--	14.0, 25.9, 24.2, 21.7, 16.7
				--	14.1, 25.9, 24.2, 21.8, 16.7
				--	14.0, 25.9, 24.2, 21.7
		--Ashen Call
		[421325] = {20.7, 55.1, 56.9},
				--	20.7, 55.1, 56.9
				--	20.7, 55.1
		--Ashen Devestation
		[428896] = {45.4, 68.5},--Lowest of each used until can figure out how to detect which sequence is used on demand
	},
	["other"] = {
		--Stage 1 (same as mythic stage 1 likely)
		--Fiery Force of Nature
		[417653] = {6.5, 103.6, 98.6},
		--Blazing Thorns
		[426206] = {30.7, 24.1, 24.2, 37.6, 52.7, 63.7, 24.1, 24.1},
		--Furious Charge
--		[418637] = {21.9, 22.0, 24.2, 35.6, 24.2, 28.5, 25.3, 42.8, 22.0},
		--Scorching Roots
		[422614] = {37.3, 109.1, 92.2},
		--Stage 2
		--Falling Embers
		[427252] = {7.4, 26.7, 25.0, 23.3, 30.0, 20.0, 25.0, 25.0, 25.0, 26.7, 23.3},
				  --7.4, 26.7, 25.0, 23.3, 30.1, 20.0, 25.0, 25.0, 25.0, 26.7, 23.3
				  --7.4, 26.7, 25.0, 23.3, 30.0, 20.0, 25.0, 25.0, 25.0, 26.7, 23.3
		--FlashFire
		[427299] = {29.1, 46.7, 26.6, 36.7, 30.9, 37.5, 37.5},--Lowest times used of variations
				  --29.1, 46.7, 26.6, 36.7, 36.7, 37.5
				  --29.1, 46.7, 26.6, 42.5, 30.9, 37.5, 37.5
		--Fire Whirl
		[427343] = {54.0, 40.9, 32.5, 36.6, 36.7, 39.1},
				  --54.1, 40.9, 32.4, 36.7, 36.6, 39.2
		--Smoldering backdraft
		[429973] = {14.0, 25.9, 30.0, 19.1, 29.2, 20.7, 25.0, 24.1, 25.0, 26.7},--Lowest times used of variations
				  --14.0, 25.9, 30.0, 19.2, 29.2, 25.8, 25.0, 24.2, 25.0, 26.7
				  --14.1, 25.9, 30.0, 19.1, 29.2, 20.7, 30.0, 24.1, 25.0, 26.7
		--Ashen Call
		[421325] = {20.7, 44.2, 42.5, 42.5, 38.3, 40.8},
				  --20.7, 44.2, 42.5, 42.5, 38.3, 40.8
	},
}

---@param self DBMMod
local function smolderingYellRepeater(self)
	local health = UnitHealth("player") / UnitHealthMax("player") * 100
	if health < 75 then -- Only let players know when you are below 75%
		local playerIcon = GetRaidTargetIndex("player")
		local text = playerIcon and L.currentHealthIcon:format(playerIcon, health) or L.currentHealth:format(health)
		yellSmolderingSuffocationRepeater:Yell(text)
	end
	self:Schedule(2, smolderingYellRepeater, self)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ignitingCount = 0
	self.vb.forcesCount = 0
	self.vb.scorchingRootCount = 0
	self.vb.furiousChargeCount = 0
	self.vb.thornsCount = 0
	self.vb.infernoCount = 0
	table.wipe(castsPerGUID)
	self:EnablePrivateAuraSound(425888, "targetyou", 2)--Igniting Growth
	self:EnablePrivateAuraSound(425468, "targetyou", 2)--Dream Blossom. Bad sound, needs better?
	self:EnablePrivateAuraSound(420544, "justrun", 2)--Scorching Pursuit
	self:EnablePrivateAuraSound(421461, "runout", 2)--Flash Fire
	self:EnablePrivateAuraSound(428901, "runout", 2)--Ashen Devastation
	if self:IsMythic() then
		difficultyName = "mythic"
		timerFieryForceofNatureCD:Start(6.5-delay, 1)
		timerIgnitingGrowthCD:Start(14.2-delay, 1)
		timerFuriousChargeCD:Start(21.9-delay, 1)
		timerBlazingThornsCD:Start(30.7-delay, 1)
		timerScorchingRootsCD:Start(37.3-delay, 1)
	else--Only normal vetted
		difficultyName = "other"
		timerFieryForceofNatureCD:Start(6.1-delay, 1)
		timerFuriousChargeCD:Start(21.9-delay, 1)
		timerBlazingThornsCD:Start(30.7-delay, 1)
		timerScorchingRootsCD:Start(37.3-delay, 1)
	end
	timerRagingInfernoCD:Start(90.3-delay, 1)
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	else
		difficultyName = "other"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 425889 then
		self.vb.ignitingCount = self.vb.ignitingCount + 1
		warnIgnitingGrowth:Show(self.vb.ignitingCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.ignitingCount+1)
		if timer then
			timerIgnitingGrowthCD:Start(timer, self.vb.ignitingCount+1)
		end
		--Charge timer correction
		if timerFuriousChargeCD:GetRemaining(self.vb.furiousChargeCount+1) < 7.7 then
			local elapsed, total = timerFuriousChargeCD:GetTime(self.vb.furiousChargeCount+1)
			local extend = 7.7 - (total-elapsed)
			DBM:Debug("timerFuriousChargeCD extended by: "..extend, 2)
			timerFuriousChargeCD:Update(elapsed, total+extend, self.vb.furiousChargeCount+1)
		end
	elseif spellId == 426524 then
		timerFieryFlourishCD:Start(self:IsMythic() and 4.9 or 9.7, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but just in case
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnForces then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.treeIcon, 1, nil, 12, "SetIconOnForces")
			end
			self.vb.treeIcon = self.vb.treeIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnFieryFlourish:Show(args.sourceName, count)
			if count < 6 then
				specWarnFieryFlourish:Play("kick"..count.."r")
			else
				specWarnFieryFlourish:Play("kickcast")
			end
		end
	elseif spellId == 422614 then
		self.vb.scorchingRootCount = self.vb.scorchingRootCount + 1
		warnScorchingRoots:Show(self.vb.scorchingRootCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.scorchingRootCount+1)
		if timer then
			timerScorchingRootsCD:Start(timer, self.vb.scorchingRootCount+1)
		end
	elseif spellId == 418637 then
		self.vb.furiousChargeCount = self.vb.furiousChargeCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFuriousCharge:Show()
			specWarnFuriousCharge:Play("justrun")
			yellFuriousCharge:Yell()
		else
			--Delayed by half cast to ensure taunt debuff lasts til charge ends
			local bossTarget = UnitName("boss1target") or DBM_COMMON_L.UNKNOWN
			specWarnFuriousChargePreTaunt:Schedule(1.5, bossTarget)
			specWarnFuriousChargePreTaunt:ScheduleVoice(1.5, "tauntboss")
		end
		--local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.furiousChargeCount+1) or 22
		--if timer then
		--	timerFuriousChargeCD:Start(timer, self.vb.furiousChargeCount+1)
		--end
		timerFuriousChargeCD:Start(22.0, self.vb.furiousChargeCount+1)
	elseif spellId == 426206 then
		self.vb.thornsCount = self.vb.thornsCount + 1
		specWarnBlazingThornsAvoid:Show(self.vb.thornsCount)
		specWarnBlazingThornsAvoid:Play("watchstep")
		if not DBM:UnitDebuff("player", 429032) and not self:IsEasy() then
			specWarnBlazingThornsSoak:Schedule(4, self.vb.thornsCount)
			specWarnBlazingThornsSoak:ScheduleVoice(4, "helpsoak")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.thornsCount+1)
		if timer then
			timerBlazingThornsCD:Start(timer, self.vb.thornsCount+1)
		end
		if self:IsHard() then
			timerBlazingThornsSoak:Start(5, self.vb.thornsCount)
		end
	elseif spellId == 417634 then
		self.vb.infernoCount = self.vb.infernoCount + 1
		specWarnRagingInferno:Show(DBM_COMMON_L.SHIELD)
		specWarnRagingInferno:Play("findshield")
		timerRagingInfernoCD:Start(101, self.vb.infernoCount+1)
		--Charge timer correction
		if timerFuriousChargeCD:GetRemaining(self.vb.furiousChargeCount+1) < 13 then
			local elapsed, total = timerFuriousChargeCD:GetTime(self.vb.furiousChargeCount+1)
			local extend = 13 - (total-elapsed)
			DBM:Debug("timerFuriousChargeCD extended by: "..extend, 2)
			timerFuriousChargeCD:Update(elapsed, total+extend, self.vb.furiousChargeCount+1)
		end
	elseif spellId == 427252 then
		self.vb.scorchingRootCount = self.vb.scorchingRootCount + 1
		specWarnFallingEmbers:Show(self.vb.scorchingRootCount)
		specWarnFallingEmbers:Play("helpsoak")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.scorchingRootCount+1)
		if timer then
			timerFallingEmbersCD:Start(timer, self.vb.scorchingRootCount+1)
		end
	elseif spellId == 427343 then
		self.vb.infernoCount = self.vb.infernoCount + 1
		specWarnFireWhirl:Show(self.vb.infernoCount)
		specWarnFireWhirl:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.infernoCount+1)
		if timer then
			timerFireWhirlCD:Start(timer, self.vb.infernoCount+1)
		end
	elseif spellId == 429973 then
		self.vb.furiousChargeCount = self.vb.furiousChargeCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSmolderingBackdraft:Show()
			specWarnSmolderingBackdraft:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.furiousChargeCount+1)
		if timer then
			timerSmolderingBackdraftCD:Start(timer, self.vb.furiousChargeCount+1)
		end
	elseif spellId == 421325 then
		self.vb.forcesCount = self.vb.forcesCount + 1
		warnAshenCall:Show(self.vb.forcesCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.forcesCount+1)
		if timer then
			timerAshenCallCD:Start(timer, self.vb.forcesCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 417653 then
		self.vb.forcesCount = self.vb.forcesCount + 1
		warnForces:Show(self.vb.forcesCount)
		self.vb.treeIcon = 8
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.forcesCount+1)
		if timer then
			timerFieryForceofNatureCD:Start(timer, self.vb.forcesCount+1)
		end
	elseif spellId == 419485 then
		--event fires for every player moving in and out of it, we just want to announce barrier is up per root, once
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			warnNaturesBulwark:Show()
		end
	elseif spellId == 427299 and self:AntiSpam(5, 1) then
		self.vb.thornsCount = self.vb.thornsCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.thornsCount+1)
		if timer then
			timerFlashFireCD:Start(timer, self.vb.thornsCount+1)
		end
--	elseif spellId == 428901 and self:AntiSpam(5, 2) then
--		self.vb.ignitingCount = self.vb.ignitingCount + 1
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.ignitingCount+1)
--		if timer then
--			timerAshenDevestationCD:Start(timer, self.vb.ignitingCount+1)
--		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 426387 and self:AntiSpam(3.5, args.destName) then
		if args:IsPlayer() then
			specWarnScorchingBramblethorn:Show()
			specWarnScorchingBramblethorn:Play("targetyou")
		else
			warnScorchingBramblethorn:Show(args.destName)
		end
--	elseif spellId == 425888 then
--		if args:IsPlayer() then
--			specWarnIgnitingGrowth:Show()
--			specWarnIgnitingGrowth:Play("runout")
--			yellIgnitingGrowth:Yell()
--		end
--	elseif spellId == 425468 then
--		if args:IsPlayer() then
--			specWarnDreamBlossom:Show()
--			specWarnDreamBlossom:Play("targetyou")
--			yellDreamBlossom:Yell()
--		else
--			warnDreamBlossom:Show(args.destName)
--		end
--	elseif spellId == 420544 then
--		if args:IsPlayer() then
--			specWarnScorchingPursuit:Show()
--			specWarnScorchingPursuit:Play("justrun")
--			yellScorchingPursuit:Yell()
--		end
	elseif spellId == 423719 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--May be unnessesary, but precaution for a drycode, remove later
			--Redundant tanking check done so it doesn't warn to taunt again if you already did in pre cast.
			if not self:IsTanking("player", "boss1", nil, true) then
				specWarnNaturesFury:Show(args.destName)
				specWarnNaturesFury:Play("tauntboss")
			end
		end
	elseif spellId == 421594 then
		if args:IsPlayer() then
			self:Unschedule(smolderingYellRepeater)
			self:Schedule(2, smolderingYellRepeater, self)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnSmolderingSuffocation:Show(args.destName)
				specWarnSmolderingSuffocation:Play("tauntboss")
			end
		end
	elseif spellId == 426249 then
		if args:IsPlayer() then
--			warnBlazingCoalescence:Cancel()
--			warnBlazingCoalescence:Schedule(1, args.amount or 1)
			warnBlazingCoalescence:Show(args.amount or 1)
		end
	elseif spellId == 429032 then
		if args:IsPlayer() then
			warnEverlastingBlaze:Cancel()
			warnEverlastingBlaze:Schedule(1, args.amount or 1)
		end
	elseif spellId == 418520 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount % 2 == 1 then -- 1, 3, 5...
				warnBlisteringSplinters:Show(amount)
			end
		end
--	elseif spellId == 421407 then
--		warnSearingAsh:Show(args.amount or 1)
	elseif spellId == 426256 then
		warnBlazingCoalescenceBoss:Show(args.destName, args.amount or 1)
	elseif spellId == 427299 then
		warnFlashFire:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFlashFire:Show()
			specWarnFlashFire:Play("runout")
			yellFlashFire:Yell()
			yellFlashFireFades:Countdown(spellId)
		end
--	elseif spellId == 428901 then
--		warnAshenDevastation:CombinedShow(0.5, args.destName)
--		if args:IsPlayer() then
--			specWarnAshenDevestation:Show()
--			specWarnAshenDevestation:Play("runout")
--			yellAshenDevestation:Yell()
--			yellAshenDevestationFades:Countdown(spellId)
--		end
	elseif spellId == 427306 then
		warnEncasedInAsh:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnEncasedInAsh:Show()
			specWarnEncasedInAsh:Play("targetyou")
			yellEncasedInAsh:Yell()
		end
	elseif spellId == 421316 then--Consuming Flame
		self:SetStage(1.5)
		timerFieryForceofNatureCD:Stop()
		timerScorchingRootsCD:Stop()
		timerFuriousChargeCD:Stop()
		timerBlazingThornsCD:Stop()
		timerRagingInfernoCD:Stop()
		timerIgnitingGrowthCD:Stop()
		warnConsumingFlame:Show(args.destName)
		timerConsumingFlame:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421316 then--Consuming Flame
		self:SetStage(2)
		self.vb.ignitingCount = 0--Reused in stage 2 for Ashen Devestation
		self.vb.scorchingRootCount = 0--Reused in stage 2 for Fallen Embers
		self.vb.forcesCount = 0--Reused in Stage 2 for Ashen Call
		self.vb.furiousChargeCount = 0--Reused in Stage 2 for Smoldering Backdraft
		self.vb.thornsCount = 0--Reused in Stage 2 for Flash Fire
		self.vb.infernoCount = 0--Reused in Stage 2 for Fire Whirl
		timerConsumingFlame:Stop()
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		if self:IsMythic() then
			timerFallingEmbersCD:Start(7.4, 1)
			timerSmolderingBackdraftCD:Start(14.0, 1)
			timerAshenCallCD:Start(20.7, 1)
			timerFlashFireCD:Start(29, 1)
			timerAshenDevestationCD:Start(45.4, 1)
			timerFireWhirlCD:Start(59.1, 1)
		elseif self:IsHeroic() then
			timerFallingEmbersCD:Start(7.4, 1)
			timerSmolderingBackdraftCD:Start(14, 1)
			timerAshenCallCD:Start(20.7, 1)
			timerFlashFireCD:Start(29.1, 1)
			timerFireWhirlCD:Start(54, 1)
		else--Normal needs rechecking. Ashen and smoldering likely changed to match mythic and heroic
			timerFallingEmbersCD:Start(7.3, 1)
			timerSmolderingBackdraftCD:Start(14, 1)
			timerAshenCallCD:Start(20, 1)
			timerFlashFireCD:Start(29, 1)
			timerFireWhirlCD:Start(54, 1)
		end
	elseif spellId == 421594 then
		if args:IsPlayer() then
			self:Unschedule(smolderingYellRepeater)
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 417632 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 208459 then--fiery-treant
		timerFieryFlourishCD:Stop(args.destGUID)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not castsPerGUID[GUID] then
			castsPerGUID[GUID] = 0
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 208459 then--Fiery Treant
				timerFieryFlourishCD:Start(4, GUID)
				if self.Options.SetIconOnForces then
					self:ScanForMobs(GUID, 2, self.vb.treeIcon, 1, nil, 12, "SetIconOnForces")
				end
				self.vb.treeIcon = self.vb.treeIcon - 1
			end
		end
	end
end

--"<36.79 01:24:52> [UNIT_SPELLCAST_SUCCEEDED] Scorching Roots(0.0%-0.0%){Target:Luxvertwo} -Charred Brambles- [[nameplate7:Cast-3-5770-2549-63-418655-00198E2244:418655]]",
--"<51.80 01:25:07> [UNIT_SPELLCAST_SUCCEEDED] Charred Brambles(100.0%-0.0%){Target:??} -Renewed Bramble Barrier- [[nameplate7:Cast-3-5770-2549-63-418653-00280E2253:418653]]",
--"<51.81 01:25:08> [UNIT_SPELLCAST_SUCCEEDED] Renewed Bramble Barrier(100.0%-0.0%){Target:??} -Nature's Bulwark- [[nameplate7:Cast-3-5770-2549-63-419485-002A8E2253:419485]]",
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 417667 and self:AntiSpam(3, 4) then
		warnCharredTreant:Show()
	elseif spellId == 417668 and self:AntiSpam(3, 5) then
		warnRenewedTreant:Show()
	elseif spellId == 418655 and self:AntiSpam(3, 6) then
		specWarnCharredBrambles:Show()
		specWarnCharredBrambles:Play("healfull")
	elseif spellId == 428896 and self:AntiSpam(3, 7) then
		self.vb.ignitingCount = self.vb.ignitingCount + 1
		warnAshenDevastation:Show(self.vb.ignitingCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.ignitingCount+1)
		if timer then
			timerAshenDevestationCD:Start(timer, self.vb.ignitingCount+1)
		end
	end
end
