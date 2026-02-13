local mod	= DBM:NewMod(2691, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233824, 241517, 234478)--Yes, they're all used
mod:SetEncounterID(3135)
mod:SetBossHPInfoToHighest()--Boss Heals
mod:SetHotfixNoticeRev(20250823000000)
mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--Midnight private aura replacements
--TODO, add Null Binding? spam can't be controlled
mod:AddPrivateAuraSoundOption(1228206, true, 1228206, 1)
mod:AddPrivateAuraSoundOption(1243577, true, 1243577, 1)
mod:AddPrivateAuraSoundOption(1232394, true, 1232394, 1)--P3 gravity Well
mod:AddPrivateAuraSoundOption(1234243, true, 1234243, 1)
mod:AddPrivateAuraSoundOption(1234244, true, 1234244, 1)--P2 Inverse gravity
mod:AddPrivateAuraSoundOption(1249425, true, 1249425, 1)
mod:AddPrivateAuraSoundOption(1237696, true, 1237696, 1)--GTFO

mod:RegisterEventsInCombat(
	--For whatever reason ENCOUNTER_TIMELINE_EVENT_REMOVED is unrecognized by api LuaLS
	---@diagnostic disable-next-line: dbm-event-checker
	"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
)

--[[
ability.id = 1234898 and type = "begincast" or ability.id = 1245292 and type = "applydebuff" or ability.id = 1237102 and type = "applybuff"
--]]
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Critical Mass
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32292))
local specWarnMassiveSmash							= mod:NewSpecialWarningCount(1230087, nil, 212336, nil, 2, 2)
local specWarnDarkMatter							= mod:NewSpecialWarningMoveAwayCount(1230979, nil, nil, nil, 1, 2)
local specWarnShatteredSpace						= mod:NewSpecialWarningDodgeCount(1243690, nil, nil, nil, 2, 2)
local specWarnDevourP1								= mod:NewSpecialWarningCount(1229038, nil, nil, nil, 3, 2)

local timerMassiveSmashCD							= mod:NewCDCountTimer(97.3, 1230087, 212336, nil, nil, 2)--Shortname "Smash"
--local timerInfinitePossibilities					= mod:NewCastNPTimer(8, 1248240, nil, nil, nil, 5)
local timerDevourP1CD								= mod:NewCDCountTimer(97.3, 1229038, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDarkMatterCD								= mod:NewCDCountTimer(97.3, 1230979, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerShatteredSpaceCD							= mod:NewCDCountTimer(97.3, 1243690, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerReverseGravityCD							= mod:NewCDCountTimer(97.3, 1243577, nil, nil, nil, 3)
--Stage Two: The Dark Heart
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32477))
--local warnCrushingGravityFaded					= mod:NewFadesAnnounce(1234243, 1)
--local warnInverseGravityFaded						= mod:NewFadesAnnounce(1234244, 1)
local warnGravitationalDistortion					= mod:NewCountAnnounce(1234242, 2)

local specWarnExtinction							= mod:NewSpecialWarningDodgeCount(1238765, nil, nil, nil, 3, 2)
local specWarnGammaBurst							= mod:NewSpecialWarningCount(1237319, nil, nil, DBM_COMMON_L.PUSHBACK, 2, 13)
--local specWarnCrushingGravity						= mod:NewSpecialWarningYou(1234243, nil, nil, nil, 1, 2, 4)
--local specWarnInverseGravity						= mod:NewSpecialWarningYou(1234244, nil, nil, nil, 1, 2, 4)

local timerSoaringReshiiCD							= mod:NewNextTimer(35.2, 1235114, 140013, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Short Text "Flight"
local timerExtinctionCD								= mod:NewCDCountTimer(35.2, 1238765, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGammaBurstCD								= mod:NewCDCountTimer(35, 1237319, DBM_COMMON_L.PUSHBACK.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGravitationalDistortionCD				= mod:NewCDCountTimer(97.3, 1234242, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
--The Devoured Lords
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32738))

--local specWarnMassEjection						= mod:NewSpecialWarningDodgeCount(1237694, nil, nil, nil, 2, 15)
local specWarnConquerorsCross						= mod:NewSpecialWarningSwitchCount(1239262, "-Healer", nil, DBM_COMMON_L.ADDS, 1, 2)
local specWarnStardustNova							= mod:NewSpecialWarningDodgeCount(1237695, nil, 142775, nil, 2, 2)
local specWarnStarshardNova							= mod:NewSpecialWarningDodgeCount(1251619, nil, 142775, nil, 2, 2, 4)--Mythic version of above

local timerMassEjectionCD							= mod:NewCDCountTimer(17.6, 1237694, nil, nil, nil, 3)
local timerMassDestructionCD						= mod:NewCDCountTimer(97.3, 1249423, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Mythic version of above
local timerConquerorsCrossCD						= mod:NewCDCountTimer(35, 1239262, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerStardustNovaCD							= mod:NewCDCountTimer(35.2, 1237695, 142775, nil, nil, 3)--Shortname "Nova"
local timerStarshardNovaCD							= mod:NewCDCountTimer(31.6, 1251619, 142775, nil, nil, 3)--Mythic version of above
local timerEclipseCD								= mod:NewNextTimer(35.2, 1237690, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--Stage Three: Singularity
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32479))
local warnGravityWell								= mod:NewSpellAnnounce(1232394, 1)--Positive alert during devour

local specWarnExtinguishTheStars					= mod:NewSpecialWarningDodgeCount(1231716, nil, 62134, nil, 2, 2)--shortname "Stars"
local specWarnDarkenedSky							= mod:NewSpecialWarningDodgeCount(1234044, nil, nil, DBM_COMMON_L.RINGS, 2, 2)
local specWarnCosmicCollapse						= mod:NewSpecialWarningDefensive(1234263, nil, 298160, nil, 2, 2)
local specWarnSuperNova								= mod:NewSpecialWarningRunCount(1232973, nil, nil, nil, 4, 2)
local specWarnVoidgrasp								= mod:NewSpecialWarningYouCount(1250055, nil, nil, nil, 1, 2)

local timerExtinguishTheStarsCD						= mod:NewCDTimer(97.3, 1231716, 62134, nil, nil, 3)--shortname "Stars"
local timerDevourP3CD								= mod:NewCDCountTimer(97.3, 1233539, nil, nil, nil, 2)
local timerDarkenedSkyCD							= mod:NewCDCountTimer(97.3, 1234044, DBM_COMMON_L.RINGS.." (%s)", nil, nil, 3)
local timerCosmicCollapseCD							= mod:NewCDCountTimer(97.3, 1234263, 298160, nil, nil, 5)--Shortname "Collapse"
local timerSuperNovaCD								= mod:NewCDCountTimer(97.3, 1232973, nil, nil, nil, 2)
local timerVoidgraspCD								= mod:NewCDCountTimer(97.3, 1250055, nil, nil, nil, 3)

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
mod.vb.massEjectionCount = 0--Also used for Mythic variant Mass destruction
mod.vb.conquerorsCrossCount = 0
mod.vb.stardustCount = 0
mod.vb.blueberriesEngaged = 0
--Stage 3
mod.vb.extinguishTheStarsCount = 0
mod.vb.darkenedSkyCount = 0
mod.vb.cosmicCollapseCount = 0
mod.vb.superNovaCount = 0
mod.vb.voidgraspCount = 0

--local eventCount = 0
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			[1230087] = {21.0, 42.1, 42.1, 42.1},--Massive Smash
			[1229038] = {10.5, 84.2, 84.2},--Devour P1
			[1230979] = {31.6, 39.0, 45.2, 39.0},--Dark Matter
			[1243690] = {36.8, 42.1, 42.1, 42.1},--Shattered Space
			[1243577] = {43.1, 42.1, 42.1, 42.1},--Reverse Gravity
		},
		[3] = {
			[1233539] = {47.6, 80, 80},--Devour P3
			[1234044] = {29.5, 43.0, 30.0, 50.0, 30.0},--Darkened Sky
			[1234263] = {57.4, 30.0, 30.0, 30.0, 30.0},--Cosmic Collapse
			[1234242] = {59.5, 26.0, 32.0, 26.0, 32.0},--Gravitational Distortion
		},
	},
	["heroic"] = {
		[1] = {
			[1230087] = {23.5, 47.0, 47.0, 47.0},--Massive Smash
			[1229038] = {11.7, 94.1, 94.1},--Devour P1
			[1230979] = {35.3, 43.5, 50.6, 43.5},--Dark Matter
			[1243690] = {41.2, 47.0, 47.1, 47.0},--Shattered Space
			[1243577] = {52.9, 42.4, 51.7, 42.4},--Reverse Gravity
		},
		[3] = {
			[1233539] = {47.5, 100},--Devour P3
			[1234044] = {29.7, 51.2, 33.1, 66.6, 33.1},--Darkened Sky
			[1234263] = {65, 33.3, 33.3, 33.3, 33.3, 33.3},--Cosmic Collapse
			[1232973] = {56.1, 14.4, 33.3, 33.3, 18.9, 14.5, 33.3, 33.3},--Super Nova
			[1250055] = {60, 33.3, 33.3, 33.3, 33.3, 33.3},--Voidgrasp
		},
	},
	["other"] = {
		[1] = {
			[1230087] = {25, 50, 50, 50},--Massive Smash
			[1229038] = {12.5, 100, 100},--Devour P1
			[1230979] = {37.5, 46.2, 53.7, 46.2},--Dark Matter
			[1243690] = {43.7, 50, 50, 50},--Shattered Space
			[1243577] = {56.2, 45, 55, 45},--Reverse Gravity (normal only, not used in LFR)
		},
		[3] = {
			[1233539] = {47.4, 100},--Devour P3
			[1234044] = {29.7, 51.2, 33.1, 66.6, 33.1},
			[1234263] = {65, 33.3, 33.3, 33.3, 33.3, 33.3, 33.3},--Cosmic Collapse
			[1232973] = {56.1, 14.4, 33.3, 33.3, 18.9, 14.4, 33.3, 33.3},--Super Nova
			[1250055] = {60, 33.3, 33.3, 33.3, 33.3, 33.3},--Voidgrasp
		},
	},
}

function mod:OnLimitedCombatStart(delay)
	self:SetStage(1)
	self:EnablePrivateAuraSound(1228206, "targetyou", 2)
	self:EnablePrivateAuraSound(1243577, "scatter", 2)
	self:EnablePrivateAuraSound(1232394, "safenow", 2)
	self:EnablePrivateAuraSound(1234243, "scatter", 2)
	self:EnablePrivateAuraSound(1234244, "scatter", 2)
	self:EnablePrivateAuraSound(1249425, "lineyou", 17)
	self:EnablePrivateAuraSound(1237696, "watchfeet", 8)
	if DBM.Options.DebugMode then
		self:IgnoreBlizzardAPI()
		--eventCount = 0
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
		self.vb.superNovaCount = 0
		self.vb.voidgraspCount = 0
		self.vb.blueberriesEngaged = 0
		if self:IsMythic() then
			savedDifficulty = "mythic"
		elseif self:IsHeroic() then
			savedDifficulty = "heroic"
		else--Combine LFR and Normal
			savedDifficulty = "other"
		end
		--if DBM is in debug mode, we initialize experimental scheduled support
		specWarnMassiveSmash:Loop(allTimers[savedDifficulty][1][1230087], 0)
		specWarnMassiveSmash:LoopVoice(allTimers[savedDifficulty][1][1230087], 0, "carefly")
		specWarnDevourP1:Loop(allTimers[savedDifficulty][1][1229038], 0)
		specWarnDevourP1:LoopVoice(allTimers[savedDifficulty][1][1229038], 0, "gather")
		specWarnDarkMatter:Loop(allTimers[savedDifficulty][1][1230979], 0)
		specWarnDarkMatter:LoopVoice(allTimers[savedDifficulty][1][1230979], 0, "scatter")
		specWarnShatteredSpace:Loop(allTimers[savedDifficulty][1][1243690], 0)
		specWarnShatteredSpace:LoopVoice(allTimers[savedDifficulty][1][1243690], 0, "aesoon")
		--Looped Timers
		timerMassiveSmashCD:Loop(allTimers[savedDifficulty][1][1230087], 0, true)
		timerDevourP1CD:Loop(allTimers[savedDifficulty][1][1229038], 0, true)
		timerDarkMatterCD:Loop(allTimers[savedDifficulty][1][1230979], 0, true)
		timerShatteredSpaceCD:Loop(allTimers[savedDifficulty][1][1243690], 0, true)
		if not self:IsLFR() then
			timerReverseGravityCD:Loop(allTimers[savedDifficulty][1][1243577], 0, true)
		end
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "other"
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

do
--	local function resetCount()
--		eventCount = 0
--	end
	local function delayedIEEURegister()
		--Registration must be delayed because a lot of false events fire in stage 1 and stage 1 to 2 transition
		mod:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	end
	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if eventState == 3 and self:AntiSpam(10, 1) and self:GetStage(4, 1) then--Blizzard is canceling bars. Phase change
--		eventCount = eventCount + 1
--		if eventCount == 5 then--Backup, if blizzard makes canceling bars secret we'll just count events instead
			self:SetStage(0)
			if self:GetStage(2) then--first platform
				DBM:Debug("Ending Stage 1")
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
				warnPhase:Play("ptwo")
				--Stop stage 1 timers and warning loops
				if DBM.Options.DebugMode then
					timerMassiveSmashCD:Cancel()
					specWarnMassiveSmash:Cancel()
					specWarnMassiveSmash:CancelVoice()
					timerDevourP1CD:Cancel()
					specWarnDevourP1:Cancel()
					specWarnDevourP1:CancelVoice()
					timerDarkMatterCD:Cancel()
					specWarnDarkMatter:Cancel()
					specWarnDarkMatter:CancelVoice()
					timerShatteredSpaceCD:Cancel()
					specWarnShatteredSpace:Cancel()
					specWarnShatteredSpace:CancelVoice()
					timerReverseGravityCD:Cancel()
					self:Schedule(10, delayedIEEURegister)
				end
				--Start platform 1 stuff
				self.vb.extinctionCount = 0
				self.vb.gammaBurstCount = 0
				self.vb.distortionCount = 0
				self.vb.massEjectionCount = 0
				self.vb.conquerorsCrossCount = 0
				self.vb.stardustCount = 0
				timerSoaringReshiiCD:Start(13.8)
				--Timers for platform one handled in IEEU handler
			elseif self:GetStage(3) then--second platform
				DBM:Debug("starting Platform 2")
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2.5))
				warnPhase:Play("phasechange")
				self.vb.extinctionCount = 0
				self.vb.gammaBurstCount = 0
				self.vb.distortionCount = 0
				self.vb.massEjectionCount = 0
				self.vb.conquerorsCrossCount = 0
				self.vb.stardustCount = 0
				if DBM.Options.DebugMode then
					timerConquerorsCrossCD:Cancel()
					timerGammaBurstCD:Cancel()
					timerExtinctionCD:Cancel()
					timerMassEjectionCD:Cancel()
					timerMassDestructionCD:Cancel()
					timerEclipseCD:Cancel()
					timerGravitationalDistortionCD:Cancel()
					--Cancel all first platform timers andloops
					specWarnConquerorsCross:Cancel()
					specWarnConquerorsCross:CancelVoice()
					specWarnExtinction:Cancel()
					specWarnExtinction:CancelVoice()
					warnGravitationalDistortion:Cancel()
					specWarnGammaBurst:Cancel()
					specWarnGammaBurst:CancelVoice()
				end
				timerSoaringReshiiCD:Start(15)
				--if self:IsMythic() then
				--	--Adds basically come immediately on mythic
				--	--Could start a fake one sooner then update it at last second like BW does but I don't see point
				--	--Since it's really just an estimated "engage" timer
				--	timerConquerorsCrossCD:Start(1, 1)
				--	timerExtinctionCD:Start(11.6, 1)
				--	timerGammaBurstCD:Start(22.1, 1)
				--	timerStarshardNovaCD:Start(4.2, 1)
				--	timerGravitationalDistortionCD:Start(13.8, 1)
				--	timerEclipseCD:Start(60)
				--else
				--	timerConquerorsCrossCD:Start(6, 1)
				--	timerStardustNovaCD:Start(13, 1)
				--	timerExtinctionCD:Start(17.8, 1)
				--	timerGammaBurstCD:Start(31.9, 1)
				--	timerEclipseCD:Start(90)
				--end
			else--Main Platform
				DBM:Debug("starting final phase")
				warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
				warnPhase:Play("pthree")
				self.vb.devourCount = 0
				self.vb.distortionCount = 0
				--timerConquerorsCrossCD:Stop()
				--timerGammaBurstCD:Stop()
				--timerExtinctionCD:Stop()
				--timerStardustNovaCD:Stop()
				--timerStarshardNovaCD:Stop()
				--timerEclipseCD:Stop()
				--timerGravitationalDistortionCD:Stop()
--
				--timerExtinguishTheStarsCD:Start(16.5)
				--timerDevourP3CD:Start(allTimers[savedDifficulty][3][1233539][1], 1)
				--timerDarkenedSkyCD:Start(allTimers[savedDifficulty][3][1234044][1], 1)
				--timerCosmicCollapseCD:Start(allTimers[savedDifficulty][3][1234263][1], 1)
				--if not self:IsMythic() then
				--	timerVoidgraspCD:Start(allTimers[savedDifficulty][3][1250055][1], 1)
				--	timerSuperNovaCD:Start(allTimers[savedDifficulty][3][1232973][1], 1)
				--else
				--	timerGravitationalDistortionCD:Start(allTimers[savedDifficulty][3][1234242][1], 1)
				--end
			end
		end
--		self:Unschedule(resetCount)
--		self:Schedule(3, resetCount)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:GetStage(2) then
		if UnitExists("boss2") and self.vb.blueberriesEngaged == 0 then--Second boss is added, start timers
			self.vb.blueberriesEngaged = 1
			DBM:Debug("starting Platform 1 add timers from INSTANCE_ENCOUNTER_ENGAGE_UNIT")
			if self:IsMythic() then
				specWarnConquerorsCross:Loop({3.1, 31.5}, 0)
				specWarnConquerorsCross:LoopVoice({3.1, 31.5}, 0, "mobsoon")
				timerConquerorsCrossCD:Loop({3.1, 31.5}, 0, true)
				specWarnExtinction:Loop({13.6, 31.5}, 0)
				specWarnExtinction:LoopVoice({13.6, 31.5}, 0, "frontal")
				timerExtinctionCD:Loop({13.6, 31.5}, 0, true)
				warnGravitationalDistortion:Loop({1, 31.5}, 0)
				timerGravitationalDistortionCD:Loop({15.7, 31.5}, 0, true)
				specWarnGammaBurst:Loop({24.2, 31.5}, 0)
				specWarnGammaBurst:LoopVoice({24.2, 31.5}, 0, "pushbackincoming")
				timerGammaBurstCD:Loop({24.2, 31.5}, 0, true)
				timerEclipseCD:Start(65.2)
			else
				--Guestimated based on mythic midnight timers
				timerConquerorsCrossCD:Start(7, 1)
				timerMassEjectionCD:Start(14.1, 1)
				timerExtinctionCD:Start(18.8, 1)
				timerGammaBurstCD:Start(32.9, 1)

				specWarnConquerorsCross:Loop({3.1, 35}, 0)
				specWarnConquerorsCross:LoopVoice({3.1, 35}, 0, "mobsoon")
				specWarnExtinction:Loop({13.6, 35}, 0)
				specWarnExtinction:LoopVoice({13.6, 35}, 0, "frontal")
				specWarnGammaBurst:Loop({24.2, 35}, 0)
				specWarnGammaBurst:LoopVoice({24.2, 35}, 0, "pushbackincoming")

				timerEclipseCD:Start(95.2)
			end
			self:UnregisterShortTermEvents()
		end
	end
end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1230087 then
		self.vb.massSpawns = 0
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
		specWarnDevourP1:Show(collectiveGravityName)
		specWarnDevourP1:Play("gather")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.devourCount+1)
		if timer then
			timerDevourP1CD:Start(timer, self.vb.devourCount+1)
		end
		self:Schedule(2.5, extraWarnDevour, self)
	elseif spellId == 1230979 then
		self.vb.darkMatterCount = self.vb.darkMatterCount + 1
		specWarnDarkMatter:Show(self.vb.darkMatterCount)
		specWarnDarkMatter:Play("scatter")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.darkMatterCount+1)
		if timer then
			timerDarkMatterCD:Start(timer, self.vb.darkMatterCount+1)
		end
	elseif spellId == 1238765 then
		self.vb.extinctionCount = self.vb.extinctionCount + 1
		specWarnExtinction:Show(self.vb.extinctionCount)
		specWarnExtinction:Play("aesoon")
		timerExtinctionCD:Start(self:IsMythic() and 31.5 or 35.2, self.vb.extinctionCount+1)
	elseif spellId == 1237694 then
		self.vb.massEjectionCount = self.vb.massEjectionCount + 1
		specWarnMassEjection:Show(self.vb.massEjectionCount)
		specWarnMassEjection:Play("frontal")
		timerMassEjectionCD:Start(17.6, self.vb.massEjectionCount+1)
	elseif spellId == 1249423 then
		self.vb.massEjectionCount = self.vb.massEjectionCount + 1
		--timerMassDestructionCD:Start(35.2, self.vb.massEjectionCount+1)
	elseif spellId == 1239262 then
		--More consistent stage 2 setter for MRT and WAs and in sync with BW
		if self:GetStage(2, 1) then
			self:SetStage(2)
		end
		self.vb.conquerorsCrossCount = self.vb.conquerorsCrossCount + 1
		specWarnConquerorsCross:Show(self.vb.conquerorsCrossCount)
		specWarnConquerorsCross:Play("mobsoon")
		timerConquerorsCrossCD:Start(self:IsMythic() and 31.5 or 35, self.vb.conquerorsCrossCount+1)
	elseif spellId == 1237695 then
		self.vb.stardustCount = self.vb.stardustCount + 1
		specWarnStardustNova:Show(self.vb.stardustCount)
		specWarnStardustNova:Play("watchstep")
		timerStardustNovaCD:Start(35.2, self.vb.stardustCount+1)
	elseif spellId == 1251619 then
		self.vb.stardustCount = self.vb.stardustCount + 1
		specWarnStarshardNova:Show(self.vb.stardustCount)
		specWarnStarshardNova:Play("watchstep")
		timerStarshardNovaCD:Start(31.5, self.vb.stardustCount+1)
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
	if spellId == 1231716 then
		self.vb.extinguishTheStarsCount = self.vb.extinguishTheStarsCount + 1
		specWarnExtinguishTheStars:Show(self.vb.extinguishTheStarsCount)
		specWarnExtinguishTheStars:Play("watchstep")
	elseif spellId == 1246541 then--Spell is constantly stutter cast so we moved to success to reduce spam
		if self:AntiSpam(5, 1) and args:IsPlayer() then
			specWarnNullBinding:Show()
			specWarnNullBinding:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1231005 and not activeBossGUIDS[args.destGUID] then
		self.vb.massSpawns = self.vb.massSpawns + 1
		if self.Options.SetIconOnLivingMass then
			self:ScanForMobs(args.destGUID, 2, livingMassMarkerMapTable[self.vb.massSpawns], 1, nil, 12, "SetIconOnLivingMass")
		end
	elseif spellId == 1228206 then
		warnExcessMass:CombinedShow(1.5, args.destName)
		if args:IsPlayer() then
			specWarnExcessMass:Show()
			specWarnExcessMass:Play("runout")
		end
	elseif spellId == 1230168 then
		if args:IsPlayer() then
			warnMortalFragility:Show()
		else
			specWarnMortalFragility:Show(args.destName)
			specWarnMortalFragility:Play("tauntboss")
		end
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
			self.vb.distortionCount = 0
			timerExtinctionCD:Stop()
			timerGammaBurstCD:Stop()
			timerGravitationalDistortionCD:Stop()

			timerExtinguishTheStarsCD:Start(16.5)
			timerDevourP3CD:Start(allTimers[savedDifficulty][3][1233539][1], 1)
			timerDarkenedSkyCD:Start(allTimers[savedDifficulty][3][1234044][1], 1)
			timerCosmicCollapseCD:Start(allTimers[savedDifficulty][3][1234263][1], 1)
			if not self:IsMythic() then
				timerVoidgraspCD:Start(allTimers[savedDifficulty][3][1250055][1], 1)
				timerSuperNovaCD:Start(allTimers[savedDifficulty][3][1232973][1], 1)
			else
				timerGravitationalDistortionCD:Start(allTimers[savedDifficulty][3][1234242][1], 1)
			end
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
	elseif spellId == 1249425 then
		warnMassDestruction:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnMassDestruction:Show(self.vb.massEjectionCount)
			specWarnMassDestruction:Play("lineyou")
			yellMassDestruction:Yell()
			yellMassDestructionFades:Countdown(spellId)
		end
	elseif spellId == 1237102 then--Worldsoul Consumption
		self.vb.extinctionCount = 0
		self.vb.gammaBurstCount = 0
		self.vb.distortionCount = 0
		self.vb.massEjectionCount = 0
		self.vb.conquerorsCrossCount = 0
		self.vb.stardustCount = 0
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1229038 then
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
	elseif spellId == 1249425 then
		if args:IsPlayer() then
			yellMassDestructionFades:Cancel()
		end
	end
end

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
		timerMassDestructionCD:Stop()
		timerEclipseCD:Stop()
		timerGravitationalDistortionCD:Stop()
	elseif cid == 245222 then--Pargoth
		timerConquerorsCrossCD:Stop()
		timerGammaBurstCD:Stop()
		timerExtinctionCD:Stop()
		timerStardustNovaCD:Stop()
		timerStarshardNovaCD:Stop()
		timerEclipseCD:Stop()
		timerGravitationalDistortionCD:Stop()
	end
end

--First cast is not in combat log (rest are)
--First cast can also be missing emote too though so we also have to do backup scheduling
--Because even emote doesn't COMPLETELY work around blizzard bug.
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:1234052") then
		self.vb.darkenedSkyCount = self.vb.darkenedSkyCount + 1
		specWarnDarkenedSky:Show(self.vb.darkenedSkyCount)
		specWarnDarkenedSky:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 1234044, self.vb.darkenedSkyCount+1)
		if timer then
			timerDarkenedSkyCD:Start(timer, self.vb.darkenedSkyCount+1)
		end
	end
end

--"<43.79 11:27:27> [UNIT_SPELLCAST_START] Dimensius(62.0%-24.0%){Target:??} -Shattered Space- 3.25s boss1:Cast-3-4241-2810-1727-1243690-00681C5A7F:1243690",
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
		specWarnGammaBurst:Play("pushbackincoming")
		timerGammaBurstCD:Start(self:IsMythic() and 31.5 or 35, self.vb.gammaBurstCount+1)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 1248483 and self:AntiSpam(5, 5) then
		self.vb.distortionCount = self.vb.distortionCount + 1
		warnGravitationalDistortion:Show(self.vb.distortionCount)
		local timer = self:GetStage(2) and 31.5 or self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.distortionCount+1)
		if timer then
			timerGravitationalDistortionCD:Start(timer, self.vb.distortionCount+1)
		end
	end
end

function mod:UNIT_POWER_UPDATE(uId)
	local guid = UnitGUID(uId)
	local cid = self:GetCIDFromGUID(guid)
	if cid == 245255 or cid == 245222 then
		local power = UnitPower(uId)
		if power == 1 then
			DBM:Debug("First Power")
			if cid == 245255 then--Artoshion
				if self:IsMythic() then
					--Adds basically come immediately on mythic
					--Could start a fake one sooner then update it at last second like BW does but I don't see point
					--Since it's really just an estimated "engage" timer
					timerConquerorsCrossCD:Start(2.1, 1)
					timerExtinctionCD:Start(12.7, 1)
					timerGammaBurstCD:Start(23.2, 1)
					timerMassDestructionCD:Start(5.3, 1)
					timerGravitationalDistortionCD:Start(14.9, 1)
				else
					timerConquerorsCrossCD:Start(6, 1)
					timerMassEjectionCD:Start(13.1, 1)
					timerExtinctionCD:Start(17.8, 1)
					timerGammaBurstCD:Start(31.9, 1)
				end
			elseif cid == 245222 then--Pargoth
				if self:IsMythic() then
					--Adds basically come immediately on mythic
					--Could start a fake one sooner then update it at last second like BW does but I don't see point
					--Since it's really just an estimated "engage" timer
					timerConquerorsCrossCD:Start(1, 1)
					timerExtinctionCD:Start(11.6, 1)
					timerGammaBurstCD:Start(22.1, 1)
					timerStarshardNovaCD:Start(4.2, 1)
					timerGravitationalDistortionCD:Start(13.8, 1)
				else
					timerConquerorsCrossCD:Start(6, 1)
					timerStardustNovaCD:Start(13, 1)
					timerExtinctionCD:Start(17.8, 1)
					timerGammaBurstCD:Start(31.9, 1)
				end
			end
			timerEclipseCD:Start(self:IsMythic() and 60 or 90)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 8 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if unitGUID and UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 242587 then--Living Mass
				self.vb.massSpawns = self.vb.massSpawns + 1
				if self.Options.SetIconOnLivingMass then
					self:ScanForMobs(unitGUID, 2, livingMassMarkerMapTable[self.vb.massSpawns], 1, nil, 12, "SetIconOnLivingMass")
				end
			end
		end
	end
end
--]]
