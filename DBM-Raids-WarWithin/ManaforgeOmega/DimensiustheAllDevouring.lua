local mod	= DBM:NewMod(2691, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233824, 241517, 234478)--Yes, they're all used
mod:SetEncounterID(3135)
mod:SetHotfixNoticeRev(20250813000000)
mod:SetMinSyncRevision(20250813000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1230087 1248240 1229038 1230979 1238765 1237319 1237694 1249423 1239262 1237695 1233539 1234044 1234263 1232973 1234898",--1243690
	"SPELL_CAST_SUCCESS 1234242 1231716 1246541",--1237690
	"SPELL_AURA_APPLIED 1231005 1228206 1228207 1230168 1229674 1243699 1243577 1243609 1235114 1246930 1234243 1234244 1246145 1245292 1232394 1234266 1250055",
	"SPELL_AURA_APPLIED_DOSE 1228207 1230168 1229674 1246145 1234266",
	"SPELL_AURA_REMOVED 1228207 1229038 1243577 1243609 1234243 1234244 1233539 1237690",
	"SPELL_AURA_REMOVED_DOSE 1228207",
	"SPELL_PERIODIC_DAMAGE 1231002 1237696",
	"SPELL_PERIODIC_MISSED 1231002 1237696",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_START boss1 boss2 boss3"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, who should be warned about massive smash and what should it say?
--TODO, add antimatter to GTFO if you soak too long
--TODO, get true spellcast for reverse gravity
--TODO, Stellar Core counter for intermission 1?
--TODO, https://www.wowhead.com/ptr-2/spell=1232888/phenomenal-cosmic-power might be a phase change event
--TODO, how to handle Eclipse timers in stage 2
--TODO, distance filter alerts and timers for Artoshion and Pargoth?
--TODO, how to handle conquerors cross since both mini bosses use it
--TODO, does https://www.wowhead.com/ptr-2/spell=1239270/voidwarding activate sometimes or is it always active (thus not needing warning)?
--TODO, nullbinding nameplate timer and clarification on warning
--TODO, probably don't need to do anything with https://www.wowhead.com/ptr-2/spell=1233292/accretion-disk but noting just in case
--TODO, stuff with https://www.wowhead.com/ptr-2/spell=1234054/shadowquake ?
--[[
ability.id = 1234898 and type = "begincast" or ability.id = 1245292 and type = "applydebuff" or ability.id = 1237690 and type = "removebuff"
--]]
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Critical Mass
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32292))
local warnExcessMass								= mod:NewTargetNoFilterAnnounce(1228206, 1)
local warnMortalFragility							= mod:NewYouAnnounce(1230168, 4)
local warnDevourP1Over								= mod:NewEndAnnounce(1229038, 1)
local warnSpatialFragment							= mod:NewTargetNoFilterAnnounce(1243699, 1)
local warnAirbornRemoved							= mod:NewFadesAnnounce(1243609, 1)

local specWarnMassiveSmash							= mod:NewSpecialWarningCount(1230087, nil, 212336, nil, 2, 2)
local specWarnExcessMass							= mod:NewSpecialWarningYou(1228206, nil, nil, nil, 1, 2)
local specWarnMortalFragility						= mod:NewSpecialWarningTaunt(1230168, nil, nil, nil, 1, 2)
local specWarnDevourP1								= mod:NewSpecialWarningMoveTo(1229038, nil, nil, nil, 3, 2)
local specWarnDarkMatter							= mod:NewSpecialWarningCount(1230979, nil, nil, nil, 1, 2)
local specWarnShatteredSpace						= mod:NewSpecialWarningDodgeCount(1243690, nil, nil, nil, 2, 2)
local specWarnReverseGravity						= mod:NewSpecialWarningMoveAwayCount(1243577, nil, nil, nil, 1, 2)
local yellReverseGravity							= mod:NewShortYell(1243577)
local yellReverseGravityFades						= mod:NewShortFadesYell(1243577)
local specWarnAirborn								= mod:NewSpecialWarningYou(1243609, nil, nil, nil, 1, 2)
--local specWarnReverseGravityDispel				= mod:NewSpecialWarningDispel(1243577, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1231002, nil, nil, nil, 1, 8)

local timerMassiveSmashCD							= mod:NewCDCountTimer(97.3, 1230087, 212336, nil, nil, 2)--Shortname "Smash"
local timerInfinitePossibilities					= mod:NewCastNPTimer(8, 1248240, nil, nil, nil, 5)
local timerDevourP1CD								= mod:NewCDCountTimer(97.3, 1229038, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDarkMatterCD								= mod:NewCDCountTimer(97.3, 1230979, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerShatteredSpaceCD							= mod:NewCDCountTimer(97.3, 1243690, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerReverseGravityCD							= mod:NewCDCountTimer(97.3, 1243577, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnLivingMass", -33474, true, 5, {6, 1, 2, 4, 7})
--mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)
--Intermission: Event Horizon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32735))
local warnSoaringReshii								= mod:NewYouAnnounce(1235114, 1, nil, nil, 140013)--Short Text "Flight"
local warnStellarCore								= mod:NewYouAnnounce(1246930, 1)
--Stage Two: The Dark Heart
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32477))
local warnCrushingGravityFaded						= mod:NewFadesAnnounce(1234243, 1)
local warnInverseGravityFaded						= mod:NewFadesAnnounce(1234244, 1)

local specWarnExtinction							= mod:NewSpecialWarningDodgeCount(1238765, nil, nil, nil, 2, 2)
local specWarnGammaBurst							= mod:NewSpecialWarningCount(1237319, nil, DBM_COMMON_L.PUSHBACK, nil, 2, 2)
local specWarnCrushingGravity						= mod:NewSpecialWarningYou(1234243, nil, nil, nil, 3, 2, 4)
local specWarnInverseGravity						= mod:NewSpecialWarningYou(1234244, nil, nil, nil, 3, 2, 4)

local timerSoaringReshiiCD							= mod:NewNextTimer(35.2, 1235114, 140013, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Short Text "Flight"
local timerExtinctionCD								= mod:NewCDCountTimer(35.2, 1238765, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGammaBurstCD								= mod:NewCDCountTimer(35, 1237319, DBM_COMMON_L.PUSHBACK.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGravitationalDistortionCD				= mod:NewCDCountTimer(97.3, 1234242, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
--The Devoured Lords
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32738))
--local warnEclipseCast								= mod:NewCastAnnounce(1237690, 1, 32)
--Artoshion & Pargoth
local warnTouchofOblivion							= mod:NewStackAnnounce(1246145, 2, nil, "Tank|Healer")

local specWarnMassEjection							= mod:NewSpecialWarningDodgeCount(1237694, nil, nil, nil, 2, 15)
local specWarnMassDestruction						= mod:NewSpecialWarningDodgeCount(1249423, nil, nil, nil, 2, 15, 4)--Mythic version of above
local specWarnConquerorsCross						= mod:NewSpecialWarningSwitchCount(1239262, "-Healer", nil, DBM_COMMON_L.ADDS, 1, 2)
local specWarnStardustNova							= mod:NewSpecialWarningDodgeCount(1237695, nil, 142775, nil, 2, 2)

local timerMassEjectionCD							= mod:NewCDCountTimer(17.6, 1237694, nil, nil, nil, 3)
--local timerMassDestructionCD						= mod:NewCDCountTimer(97.3, 1249423, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerConquerorsCrossCD						= mod:NewCDCountTimer(35, 1239262, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerStardustNovaCD							= mod:NewCDCountTimer(35.2, 1237695, 142775, nil, nil, 3)--Shortname "Nova"

--Adds they both summon
local specWarnNullBinding							= mod:NewSpecialWarningYou(1246541, nil, nil, nil, 1, 2)

--local timerNullBindingCD							= mod:NewCDNPTimer(97.3, 1246541, nil, nil, nil, 2)
--Stage Three: Singularity
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32479))
local warnDestabalized 								= mod:NewTargetNoFilterAnnounce(1245292, 1)
local warnGravityWell								= mod:NewSpellAnnounce(1232394, 1)--Positive alert during devour
local warnDevourP3Over								= mod:NewEndAnnounce(1233539, 1)

local specWarnExtinguishTheStars					= mod:NewSpecialWarningDodgeCount(1231716, nil, 62134, nil, 2, 2)--shortname "Stars"
local specWarnDevourP3								= mod:NewSpecialWarningMoveTo(1233539, nil, nil, nil, 3, 2)
local specWarnDarkenedSky							= mod:NewSpecialWarningDodgeCount(1234044, nil, nil, DBM_COMMON_L.RINGS, 2, 2)
local specWarnCosmicCollapse						= mod:NewSpecialWarningDefensive(1234263, nil, 298160, nil, 2, 2)
local yellCosmicCollapse							= mod:NewShortYell(1234263, 298160)
local specWarnCosmicFragility						= mod:NewSpecialWarningTaunt(1234266, nil, nil, nil, 2, 2)
local specWarnSuperNova								= mod:NewSpecialWarningRunCount(1232973, nil, nil, nil, 4, 2)
local specWarnVoidgrasp								= mod:NewSpecialWarningYouCount(1250055, nil, nil, nil, 1, 2)

local timerExtinguishTheStarsCD						= mod:NewCDCountTimer(97.3, 1231716, 62134, nil, nil, 3)--shortname "Stars"
local timerDevourP3CD								= mod:NewCDCountTimer(97.3, 1233539, nil, nil, nil, 2)
local timerDarkenedSkyCD							= mod:NewCDCountTimer(97.3, 1234044, DBM_COMMON_L.RINGS.." (%s)", nil, nil, 3)
local timerCosmicCollapseCD							= mod:NewCDCountTimer(97.3, 1234263, 298160, nil, nil, 5)--Shortname "Collapse"
local timerSuperNovaCD								= mod:NewCDCountTimer(97.3, 1232973, nil, nil, nil, 2)
local timerVoidgraspCD								= mod:NewCDCountTimer(97.3, 1250055, nil, nil, nil, 3)

--BW Compatible Icon Marking
local livingMassMarkerMapTable = {6, 1, 2, 4, 7}

local playerStacks, bossStacks = 0, 0
local nearArtoshion, nearPargoth = true, true
local collectiveGravityName = DBM:GetSpellName(1228207)
local gravityWellName = DBM:GetSpellName(1232394)
local devourCasting = false
--Stage 1
mod.vb.massiveSmashCount = 0
mod.vb.massSpawns = 0
mod.vb.devourCount = 0
mod.vb.darkMatterCount = 0
mod.vb.shatteredSpaceCount = 0
mod.vb.reverseGravityCount = 0
--Stage 2
mod.vb.extinctionCount = 0
mod.vb.gammaBurstCount = 0
mod.vb.distortionCount = 0
mod.vb.massEjectionCount = 0
mod.vb.conquerorsCrossCount = 0
mod.vb.stardustCount = 0
--Stage 3
mod.vb.extinguishTheStarsCount = 0
mod.vb.darkenedSkyCount = 0
mod.vb.cosmicCollapseCount = 0
mod.vb.superNovaCount = 0
mod.vb.voidgraspCount = 0

local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {--Placeholder
			[1230087] = {25, 50, 50},--Massive Smash
			[1229038] = {12.5, 100},--Devour P1
			[1230979] = {37.5, 46.2},--Dark Matter
			[1243690] = {43.7, 50},--Shattered Space
			[1243577] = {56.2, 45},--Reverse Gravity
		},
		[3] = {
			[1231716] = {16.6},--Extinguish the Stars
			[1233539] = {47.6, 100},--Devour P3
			[1234044] = {80.5, 33.3, 66.3, 33.3},--Darkened Sky (alternating? need more data)
			[1234263] = {65, 33.3, 33.3, 33.3, 33.3, 33.3, 33.3},--Cosmic Collapse
			[1232973] = {56.1, 14.4, 33.3, 33.3, 18.9, 14.5, 33.3},--Super Nova
			[1250055] = {60, 33.3, 33.3, 33.3, 33.3, 33.3, 33.3},--Voidgrasp
		},
	},
	["other"] = {
		[1] = {
			[1230087] = {25, 50, 50},--Massive Smash
			[1229038] = {12.5, 100},--Devour P1
			[1230979] = {37.5, 46.2},--Dark Matter
			[1243690] = {43.7, 50},--Shattered Space
			[1243577] = {56.2, 45},--Reverse Gravity
		},
		[3] = {
			[1231716] = {16.6},--Extinguish the Stars
			[1233539] = {47.6, 100},--Devour P3
			[1234044] = {80.5, 33.3, 66.3, 33.3},--Darkened Sky (alternating? need more data)
			[1234263] = {65, 33.3, 33.3, 33.3, 33.3, 33.3, 33.3},--Cosmic Collapse
			[1232973] = {56.1, 14.4, 33.3, 33.3, 18.9, 14.5, 33.3},--Super Nova
			[1250055] = {60, 33.3, 33.3, 33.3, 33.3, 33.3, 33.3},--Voidgrasp
		},
	},
}

--[[
---@param self DBMMod
local function updateBossDistance(self)
--	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Torq
	if self:CheckBossDistance(245255, true, 32825, 60) then
		if not nearArtoshion then
			nearArtoshion = true
--			timerStaticChargeCD:SetFade(false, self.vb.staticChargeCount+1)
		end
	else
		if nearArtoshion then
			nearArtoshion = false
--			timerStaticChargeCD:SetFade(true, self.vb.staticChargeCount+1)
		end
	end
	--Check if near or far from Flarendo
	if self:CheckBossDistance(245222, true, 32825, 60) then
		if not nearPargoth then
			nearPargoth = true
--			timerScrapBombCD:SetFade(false, self.vb.scrapbombCount+1)
		end
	else
		if nearPargoth then
			nearPargoth = false
--			timerScrapBombCD:SetFade(true, self.vb.scrapbombCount+1)
		end
	end
	self:Schedule(2, updateBossDistance, self)
end
--]]

function mod:OnCombatStart(delay)
	nearArtoshion, nearPargoth = true, true
	devourCasting = false
	self:SetStage(1)
	self.vb.massiveSmashCount = 0
	self.vb.massSpawns = 0
	self.vb.devourCount = 0
	self.vb.darkMatterCount = 0
	self.vb.shatteredSpaceCount = 0
	self.vb.reverseGravityCount = 0
	self.vb.extinctionCount = 0
	self.vb.gammaBurstCount = 0
	self.vb.massEjectionCount = 0
	self.vb.conquerorsCrossCount = 0
	self.vb.stardustCount = 0
	self.vb.extinguishTheStarsCount = 0
	self.vb.darkenedSkyCount = 0
	self.vb.cosmicCollapseCount = 0
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	if self:IsMythic() then
		savedDifficulty = "mythic"
--	elseif self:IsHeroic() then
--		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "other"
	end
	timerMassiveSmashCD:Start(allTimers[savedDifficulty][1][1230087][1]-delay, 1)
	timerDevourP1CD:Start(allTimers[savedDifficulty][1][1229038][1]-delay, 1)
	timerDarkMatterCD:Start(allTimers[savedDifficulty][1][1230979][1]-delay, 1)
	timerShatteredSpaceCD:Start(allTimers[savedDifficulty][1][1243690][1]-delay, 1)
	timerReverseGravityCD:Start(allTimers[savedDifficulty][1][1243577][1]-delay, 1)
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
--	elseif self:IsHeroic() then
--		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "other"
	end
	if DBM:UnitDebuff("player", 1228207) then
		local _, _, stack = DBM:UnitDebuff("player", 1228207)
		playerStacks = stack or 0
	end
end

local function extraWarnDevour(self)
	if not devourCasting then return end
	if self:GetStage(1) then
		if playerStacks < bossStacks then
			specWarnDevourP1:Show(collectiveGravityName)
			specWarnDevourP1:Play("gather")
		end
	else--Stage 3
		if not DBM:UnitDebuff("player", 1232394) then
			specWarnDevourP3:Show(gravityWellName)
			specWarnDevourP3:Play("findshelter")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1230087 then
		self.vb.massiveSmashCount = self.vb.massiveSmashCount + 1
		specWarnMassiveSmash:Show(self.vb.massiveSmashCount)
		specWarnMassiveSmash:Play("carefly")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.massiveSmashCount+1)
		if timer then
			timerMassiveSmashCD:Start(timer, self.vb.massiveSmashCount+1)
		end
	elseif spellId == 1248240 then
		timerInfinitePossibilities:Start(nil, args.sourceGUID)
	elseif spellId == 1229038 then
		devourCasting = true
		self.vb.devourCount = self.vb.devourCount + 1
		specWarnDevourP1:Show(self.vb.devourCount)
		specWarnDevourP1:Play("gather")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.devourCount+1)
		if timer then
			timerDevourP1CD:Start(timer, self.vb.devourCount+1)
		end
		self:Schedule(2.5, extraWarnDevour, self)
	elseif spellId == 1230979 then
		self.vb.darkMatterCount = self.vb.darkMatterCount + 1
		specWarnDarkMatter:Show(self.vb.darkMatterCount)
		specWarnDarkMatter:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.darkMatterCount+1)
		if timer then
			timerDarkMatterCD:Start(timer, self.vb.darkMatterCount+1)
		end
	elseif spellId == 1238765 then
		self.vb.extinctionCount = self.vb.extinctionCount + 1
		specWarnExtinction:Show(self.vb.extinctionCount)
		specWarnExtinction:Play("aesoon")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.extinctionCount+1)
		--if timer then
			timerExtinctionCD:Start(35.2, self.vb.extinctionCount+1)
		--end
	elseif spellId == 1237694 then
		self.vb.massEjectionCount = self.vb.massEjectionCount + 1
		if nearArtoshion then
			specWarnMassEjection:Show(self.vb.massEjectionCount)
			specWarnMassEjection:Play("frontal")
		end
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.massEjectionCount+1)
		--if timer then
			timerMassEjectionCD:Start(17.6, self.vb.massEjectionCount+1)
		--end
	elseif spellId == 1249423 then
		self.vb.distortionCount = self.vb.distortionCount + 1
		if nearPargoth then
			specWarnMassDestruction:Show(self.vb.distortionCount)
			specWarnMassDestruction:Play("frontal")
		end
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.distortionCount+1)
		--if timer then
		--	timerMassDestructionCD:Start(timer, self.vb.distortionCount+1)
		--end
	elseif spellId == 1239262 then
		self.vb.conquerorsCrossCount = self.vb.conquerorsCrossCount + 1
		specWarnConquerorsCross:Show(self.vb.conquerorsCrossCount)
		specWarnConquerorsCross:Play("mobsoon")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.conquerorsCrossCount+1)
		--if timer then
			timerConquerorsCrossCD:Start(35, self.vb.conquerorsCrossCount+1)
		--end
	elseif spellId == 1237695 then
		self.vb.stardustCount = self.vb.stardustCount + 1
		specWarnStardustNova:Show(self.vb.stardustCount)
		specWarnStardustNova:Play("watchstep")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.stardustCount+1)
		--if timer then
			timerStardustNovaCD:Start(35.2, self.vb.stardustCount+1)
		--end
	elseif spellId == 1233539 then
		devourCasting = true
		self.vb.devourCount = self.vb.devourCount + 1
		specWarnDevourP3:Show(gravityWellName)
		specWarnDevourP3:Play("findshelter")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.devourCount+1)
		if timer then
			timerDevourP3CD:Start(timer, self.vb.devourCount+1)
		end
		self:Schedule(2.5, extraWarnDevour, self)
	elseif spellId == 1234044 then
		self.vb.darkenedSkyCount = self.vb.darkenedSkyCount + 1
		specWarnDarkenedSky:Show(self.vb.darkenedSkyCount)
		specWarnDarkenedSky:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.darkenedSkyCount+1)
		if timer then
			timerDarkenedSkyCD:Start(timer, self.vb.darkenedSkyCount+1)
		end
	elseif spellId == 1234263 then
		self.vb.cosmicCollapseCount = self.vb.cosmicCollapseCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnCosmicCollapse:Show()
			specWarnCosmicCollapse:Play("defensive")
			yellCosmicCollapse:Yell()
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.cosmicCollapseCount+1)
		if timer then
			timerCosmicCollapseCD:Start(timer, self.vb.cosmicCollapseCount+1)
		end
	elseif spellId == 1232973 then
		self.vb.superNovaCount = self.vb.superNovaCount + 1
		specWarnSuperNova:Show(self.vb.superNovaCount)
		specWarnSuperNova:Play("runout")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.superNovaCount+1)
		if timer then
			timerSuperNovaCD:Start(timer, self.vb.superNovaCount+1)
		end
	elseif spellId == 1234898 then--Event Horizon
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self:SetStage(1.5)
		timerMassiveSmashCD:Stop()
		timerDevourP1CD:Stop()
		timerDarkMatterCD:Stop()
		timerShatteredSpaceCD:Stop()
		timerReverseGravityCD:Stop()
		timerSoaringReshiiCD:Start(13.8)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 1234242 then
		self.vb.distortionCount = self.vb.distortionCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.distortionCount+1)
		if timer then
			timerGravitationalDistortionCD:Start(timer, self.vb.distortionCount+1)
		end
--	elseif spellId == 1237690 then
--		warnEclipseCast:Show()
	elseif spellId == 1231716 then
		self.vb.extinguishTheStarsCount = self.vb.extinguishTheStarsCount + 1
		specWarnExtinguishTheStars:Show(self.vb.extinguishTheStarsCount)
		specWarnExtinguishTheStars:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.extinguishTheStarsCount+1)
		if timer then
			timerExtinguishTheStarsCD:Start(timer, self.vb.extinguishTheStarsCount)
		end
	elseif spellId == 1246541 then--Spell is constantly stutter cast so we moved to success to reduce spam
		if self:AntiSpam(5, 1) and args:IsPlayer() then
			specWarnNullBinding:Show()
			specWarnNullBinding:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1231005 then
		self.vb.massSpawns = self.vb.massSpawns + 1
		if self.Options.SetIconOnLivingMass and self.vb.massSpawns < 6 then
			self:ScanForMobs(args.destGUID, 2, livingMassMarkerMapTable[self.vb.massSpawns], 1, nil, 12, "SetIconOnLivingMass")
		end
	elseif spellId == 1228206 then
		if args:IsPlayer() then
			specWarnExcessMass:Show()
			specWarnExcessMass:Play("runout")
		else
			warnExcessMass:Show(args.destName)
		end
	elseif spellId == 1228207 then
		if args:IsPlayer() then
			playerStacks = args.amount or 1
		end
	elseif spellId == 1230168 then
		if args:IsPlayer() then
			warnMortalFragility:Show()
		else
			specWarnMortalFragility:Show(args.destName)
			specWarnMortalFragility:Play("tauntboss")
		end
	elseif spellId == 1229674 then
		bossStacks = args.amount or 1
	elseif spellId == 1243699 then
		warnSpatialFragment:CombinedShow(1, args.destName)
	elseif spellId == 1243577 then
		if self:AntiSpam(8, 2) then
			self.vb.reverseGravityCount = self.vb.reverseGravityCount + 1
			local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.reverseGravityCount+1)
			if timer then
				timerReverseGravityCD:Start(timer, self.vb.reverseGravityCount)
			end
		end
		if args:IsPlayer() then
			specWarnReverseGravity:Show(self.vb.reverseGravityCount)
			specWarnReverseGravity:Play("scatter")
			yellReverseGravity:Yell()
			yellReverseGravityFades:Countdown(spellId)
		end
	elseif spellId == 1243609 then
		if args:IsPlayer() then
			specWarnAirborn:Show()
			specWarnAirborn:Play("targetyou")--Record goofy audio later?
		end
	elseif spellId == 1235114 then
		if args:IsPlayer() then
			warnSoaringReshii:Show()
		end
	elseif spellId == 1246930 then
		if args:IsPlayer() then
			warnStellarCore:Show()
		end
	elseif spellId == 1234243 and args:IsPlayer() then
		specWarnCrushingGravity:Show()
		specWarnCrushingGravity:Play("scatter")
	elseif spellId == 1234244 and args:IsPlayer() then
		specWarnInverseGravity:Show()
		specWarnInverseGravity:Play("scatter")
	elseif spellId == 1246145 then
		local amount = args.amount or 1
		if amount >= 4 and amount % 2 == 0 then
			warnTouchofOblivion:Show(args.destName, args.amount)
		end
	elseif spellId == 1245292 then
		warnDestabalized:Show(args.destName)
		if self:GetStage(3, 1) then
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			self:SetStage(3)
			self.vb.devourCount = 0
			timerExtinctionCD:Stop()
			timerGammaBurstCD:Stop()
			timerGravitationalDistortionCD:Stop()

			timerExtinguishTheStarsCD:Start(allTimers[savedDifficulty][3][1231716][1], 1)
			timerDevourP3CD:Start(allTimers[savedDifficulty][3][1233539][1], 1)
			timerDarkenedSkyCD:Start(allTimers[savedDifficulty][3][1234044][1], 1)
			timerCosmicCollapseCD:Start(allTimers[savedDifficulty][3][1234263][1], 1)
			timerSuperNovaCD:Start(allTimers[savedDifficulty][3][1232973][1], 1)
		end
	elseif spellId == 1232394 and args:IsPlayer() then
		if devourCasting then
			warnGravityWell:Show()
		else
			specWarnGTFO:Show(gravityWellName)
			specWarnGTFO:Play("watchfeet")
		end
	elseif spellId == 1234266 and not args:IsPlayer() then
		specWarnCosmicFragility:Show(args.destName)
		specWarnCosmicFragility:Play("tauntboss")
	elseif spellId == 1250055 then
		if self:AntiSpam(8, 3) then
			self.vb.voidgraspCount = self.vb.voidgraspCount + 1
			specWarnVoidgrasp:Show(self.vb.voidgraspCount)
			specWarnVoidgrasp:Play("runout")
			local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.voidgraspCount+1)
			if timer then
				timerVoidgraspCD:Start(timer, self.vb.voidgraspCount+1)
			end
		end
		if args:IsPlayer() then
			specWarnVoidgrasp:Show(self.vb.voidgraspCount)
			specWarnVoidgrasp:Play("runout")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1228207 then
		if args:IsPlayer() then
			playerStacks = args.amount or 0
		end
	elseif spellId == 1229038 then
		devourCasting = false
		warnDevourP1Over:Show()
		self:Unschedule(extraWarnDevour)
	elseif spellId == 1243577 then
		if args:IsPlayer() then
			yellReverseGravityFades:Cancel()
		end
	elseif spellId == 1243609 and args:IsPlayer() then
		warnAirbornRemoved:Show()
	elseif spellId == 1234243 and args:IsPlayer() then
		warnCrushingGravityFaded:Show()
	elseif spellId == 1234244 and args:IsPlayer() then
		warnInverseGravityFaded:Show()
	elseif spellId == 1233539 then
		warnDevourP3Over:Show()
	elseif spellId == 1237690 then--Eclipse Removed
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.conquerorsCrossCount = 0
		self.vb.extinctionCount = 0
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 245255 then--Artoshion
			timerConquerorsCrossCD:Start("v4.4-8.6", 1)
			timerMassEjectionCD:Start("v11.5-14.9", 1)
			timerExtinctionCD:Start("v16.1-19.6", 1)
			timerGammaBurstCD:Start("v34-35.8", 1)
			--if self:IsMythic() then
			--	timerGravitationalDistortionCD:Start(50.5, 1)
			--end
		elseif cid == 245222 then--Pargoth
			timerConquerorsCrossCD:Start("v11.3-12.0", 1)
			timerStardustNovaCD:Start(18.2, 1)
			timerExtinctionCD:Start(22.9, 1)
			timerGammaBurstCD:Start("v37.2-39.1", 1)
			--if self:IsMythic() then
			--	timerGravitationalDistortionCD:Start(50.5, 1)
			--end
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 1237696 or spellId == 1231002) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 242587 then--Living Mass
		timerInfinitePossibilities:Stop(args.destGUID)
	elseif cid == 245255 then--Artoshion
		timerConquerorsCrossCD:Stop()
		timerGammaBurstCD:Stop()
		timerExtinctionCD:Stop()
		timerMassEjectionCD:Stop()
	elseif cid == 245222 then--Pargoth
		timerConquerorsCrossCD:Stop()
		timerGammaBurstCD:Stop()
		timerExtinctionCD:Stop()
		timerStardustNovaCD:Stop()
--	elseif cid == 245705 then--Voidwarden

	end
end

--"<43.79 11:27:27> [UNIT_SPELLCAST_START] Dimensius(62.0%-24.0%){Target:??} -Shattered Space- 3.25s [[boss1:Cast-3-4241-2810-1727-1243690-00681C5A7F:1243690]]",
function mod:UNIT_SPELLCAST_START(_, _, spellId)
	if spellId == 1243690 then
		self.vb.shatteredSpaceCount = self.vb.shatteredSpaceCount + 1
		specWarnShatteredSpace:Show(self.vb.shatteredSpaceCount)
		specWarnShatteredSpace:Play("aesoon")
		specWarnShatteredSpace:ScheduleVoice(4, "helpsoak")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.shatteredSpaceCount+1)
		if timer then
			timerShatteredSpaceCD:Start(timer, self.vb.shatteredSpaceCount+1)
		end
	elseif spellId == 1237319 then
		self.vb.gammaBurstCount = self.vb.gammaBurstCount + 1
		specWarnGammaBurst:Show(self.vb.gammaBurstCount)
		specWarnGammaBurst:Play("aesoon")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.gammaBurstCount+1)
		--if timer then
			timerGammaBurstCD:Start(35, self.vb.gammaBurstCount+1)
		--end
	end
end
