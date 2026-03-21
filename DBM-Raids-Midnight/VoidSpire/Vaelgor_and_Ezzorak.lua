local mod	= DBM:NewMod(2735, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(250892)--Vaelgor main boss, 254109 for Ezzorak
mod:SetEncounterID(3178)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--NOTE: hardcode can probably combine cosmisis abilities into a single https://www.wowhead.com/ptr/spell=1263623/cosmosis timer
--local warnRadiantBarrier			= mod:NewCountAnnounce(1248847, 1)

local specWarnNullBeam				= mod:NewSpecialWarningCount(1262623, nil, nil, nil, 2, 2)
local specWarnVoidHowl				= mod:NewSpecialWarningCount(1244917, nil, nil, nil, 2, 2)
local specWarnGloom					= mod:NewSpecialWarningCount(1245391, nil, nil, nil, 2, 2)
local specWarnDreadBreath			= mod:NewSpecialWarningCount(1244221, nil, nil, nil, 2, 2)
local specWarnMidnightFlames		= mod:NewSpecialWarningCount(1249748, nil, nil, nil, 2, 2)
local specWarnGrabblingMaw			= mod:NewSpecialWarningDefensive(1280458, nil, nil, nil, 1, 2)
local specWarnRakfang				= mod:NewSpecialWarningDefensive(1245645, nil, nil, nil, 1, 2)
local specWarnVaelwing				= mod:NewSpecialWarningDefensive(1265131, nil, nil, nil, 1, 2)
local specWarnCosmosisGloom			= mod:NewSpecialWarningCount(1277470, nil, nil, nil, 2, 2)
local specWarnCosmosisNullbeam		= mod:NewSpecialWarningCount(1277471, nil, nil, nil, 2, 2)
local specWarnCosmosisDreadBreath	= mod:NewSpecialWarningCount(1277472, nil, nil, nil, 2, 2)
local specWarnCosmosisVoidHowl		= mod:NewSpecialWarningCount(1277473, nil, nil, nil, 2, 2)
local specWarnRadiantBarrier		= mod:NewSpecialWarningCount(1248847, nil, nil, nil, 2, 2)

local timerNullBeamCD				= mod:NewCDCountTimer(20.5, 1262623, nil, nil, nil, 3)
local timerVoidHowlCD				= mod:NewCDCountTimer(20.5, 1244917, nil, nil, nil, 2)
local timerGloomCD					= mod:NewCDCountTimer(20.5, 1245391, nil, nil, nil, 3)
local timerDreadBreathCD			= mod:NewCDCountTimer(20.5, 1244221, nil, nil, nil, 3)
local timerMidnightFlamesCD			= mod:NewCDCountTimer(20.5, 1249748, nil, nil, nil, 2)
local timerGrabblingMawCD			= mod:NewCDCountTimer(20.5, 1280458, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRakfangCD				= mod:NewCDCountTimer(20.5, 1245645, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVaelwingCD				= mod:NewCDCountTimer(20.5, 1265131, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmosisGloomCD			= mod:NewCDCountTimer(20.5, 1277470, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisNullbeamCD		= mod:NewCDCountTimer(20.5, 1277471, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisDreadBreathCD	= mod:NewCDCountTimer(20.5, 1277472, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisVoidHowlCD		= mod:NewCDCountTimer(20.5, 1277473, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerRadiantBarrierCD			= mod:NewCDCountTimer(20.5, 1248847, nil, nil, nil, 5)

mod:AddPrivateAuraSoundOption(1262999, true, 1262623, 1, 3)--Null Beam (soaked it)
mod:AddPrivateAuraSoundOption(1244672, true, 1262623, 1, 2)--Null Zone (GTFO from null beam)
mod:AddPrivateAuraSoundOption(1252157, true, 1262623, 1, 1)--Null Implosion
mod:AddPrivateAuraSoundOption(1245554, true, 1245391, 1, 3)--Gloomtouched (soaked Gloom)
mod:AddPrivateAuraSoundOption(1270852, false, 1245391, 1, 3)--Diminish (Gloomtouched ended, don't soak again)
mod:AddPrivateAuraSoundOption(1245421, true, 1245391, 1, 2)--Gloomfield (GTFO left by gloom)
mod:AddPrivateAuraSoundOption(1255612, true, 1244221, 1, 1)--Dread Breath Target
mod:AddPrivateAuraSoundOption(1255979, true, 1244221, 1, 3)--Dread Breath debuff
mod:AddPrivateAuraSoundOption(1265152, true, 1245645, 1, 3)--Impale (secondary attack of Rakfang)
mod:AddPrivateAuraSoundOption(1248865, true, 1248865, 1, 1)--Radiant Barrier
mod:AddPrivateAuraSoundOption(1270497, true, 1270497, 1, 1)--Shadowmark

mod.vb.beamCount = 0
mod.vb.howlCount = 0
mod.vb.gloomCount = 0
mod.vb.dreadCount = 0
mod.vb.flamesCount = 0
mod.vb.mawCount = 0
mod.vb.rakfangCount = 0
mod.vb.vaelwingCount = 0
mod.vb.cosmosisGloomCount = 0
mod.vb.cosmosisNullbeamCount = 0
mod.vb.cosmosisDreadBreathCount = 0
mod.vb.cosmosisVoidHowlCount = 0
mod.vb.radiantBarrierCount = 0
local badStateDetected = false
local next53IsGloom = false
local next26IsVaelwing = false
local next26S2Type = "voidhowl"
local next53S2IsGloom = true
local next31S3IsVaelwing = true
local next63S3IsNullbeam = true
local next11S3Type = "dread"
local cachedEventIDs = {}

function mod:OnLimitedCombatStart()
	table.wipe(cachedEventIDs)
	self.vb.beamCount = 1
	self.vb.howlCount = 1
	self.vb.gloomCount = 1
	self.vb.dreadCount = 1
	self.vb.flamesCount = 1
	self.vb.mawCount = 1
	self.vb.rakfangCount = 1
	self.vb.vaelwingCount = 1
	self.vb.cosmosisGloomCount = 1
	self.vb.cosmosisNullbeamCount = 1
	self.vb.cosmosisDreadBreathCount = 1
	self.vb.cosmosisVoidHowlCount = 1
	self.vb.radiantBarrierCount = 1
	next53IsGloom = true
	next26IsVaelwing = true
	next26S2Type = "voidhowl"
	next53S2IsGloom = true
	next31S3IsVaelwing = true
	next63S3IsNullbeam = true
	next11S3Type = "dread"
	--Hardcode features first
	if DBM.Options.HardcodedTimer and self:IsEasy() and not badStateDetected then
		self:SetStage(1)
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		--Blizz API fallbacks
		specWarnNullBeam:SetAlert(101, "beamincoming", 19, 3)
		timerNullBeamCD:SetTimeline(101)
		specWarnVoidHowl:SetAlert(102, "range5", 2, 2)
		timerVoidHowlCD:SetTimeline(102)
		specWarnGloom:SetAlert(103, "gloomincoming", 19, 3)
		timerGloomCD:SetTimeline(103)
		specWarnDreadBreath:SetAlert(104, "breathsoon", 2, 3, 0)
		timerDreadBreathCD:SetTimeline(104)
		specWarnMidnightFlames:SetAlert(105, "aesoon", 2, 2, 0)
		timerMidnightFlamesCD:SetTimeline(105)
		if self:IsTank() then
			specWarnGrabblingMaw:SetAlert(219, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
			specWarnRakfang:SetAlert(220, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
			specWarnVaelwing:SetAlert(221, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
		end
		timerGrabblingMawCD:SetTimeline(219)
		timerRakfangCD:SetTimeline(220)
		timerVaelwingCD:SetTimeline(221)
		specWarnCosmosisGloom:SetAlert(377, "gloomincoming", 19, 3)
		timerCosmosisGloomCD:SetTimeline(377)
		specWarnCosmosisNullbeam:SetAlert(378, "beamincoming", 19, 3)
		timerCosmosisNullbeamCD:SetTimeline(378)
		specWarnCosmosisDreadBreath:SetAlert(379, "breathsoon", 19, 3)
		timerCosmosisDreadBreathCD:SetTimeline(379)
		specWarnCosmosisVoidHowl:SetAlert(380, "range5", 2, 2)
		timerCosmosisVoidHowlCD:SetTimeline(380)
		specWarnRadiantBarrier:SetAlert(381, "findshield", 2, 3, 0)
		timerRadiantBarrierCD:SetTimeline(381)
	end

	self:EnablePrivateAuraSound({1262999,1262676,1262656}, "beamyou", 19)--iffy sound choice, might change
	self:EnablePrivateAuraSound(1244672, "watchfeet", 8)
	self:EnablePrivateAuraSound(1252157, "debuffyou", 17)
	self:EnablePrivateAuraSound(1245554, "gloomyou", 19)
	self:EnablePrivateAuraSound(1270852, "debuffyou", 17)
	self:EnablePrivateAuraSound(1245421, "watchfeet", 8)
	self:EnablePrivateAuraSound(1255612, "targetyou", 2)--Maybe a more specific sound?
	self:EnablePrivateAuraSound(1255979, "fearyou", 19)
	self:EnablePrivateAuraSound(1248865, "barrieryou", 19)--1249595 results in spam
	self:EnablePrivateAuraSound(1270497, "shadowyou", 15)
	self:EnablePrivateAuraSound(1265152, "stunyou", 19)
end

function mod:OnCombatEnd()
	table.wipe(cachedEventIDs)
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param eventID number
	local function timersEasy(self, timer, eventID)
		--Logic confirmed against normal only. LFR not available yet
		local stage = self:GetStage()
		if stage == 1 then--Stage 1
			if timer == 1 then--Nullbeam (initial cast at pull)
				timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
				cachedEventIDs[eventID] = "nullbeam"
			elseif timer == 6 then--Vaelwing (initial tank ability at pull)
				timerVaelwingCD:TLStart(timer, eventID, self.vb.vaelwingCount)
				cachedEventIDs[eventID] = "vaelwing"
			elseif timer == 19 then--Grappling Maw (initial CD)
				timerGrabblingMawCD:TLStart(timer, eventID, self.vb.mawCount)
				cachedEventIDs[eventID] = "maw"
			elseif timer == 21 then--Dread Breath (recurring CD)
				timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
				cachedEventIDs[eventID] = "dread"
			elseif timer == 28 then--Dread Breath (initial CD)
				timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
				cachedEventIDs[eventID] = "dread"
			elseif timer == 32 then--Void Howl (initial CD)
				timerVoidHowlCD:TLStart(timer, eventID, self.vb.howlCount)
				cachedEventIDs[eventID] = "voidhowl"
			elseif timer == 47 then--Void Howl (recurring CD)
				timerVoidHowlCD:TLStart(timer, eventID, self.vb.howlCount)
				cachedEventIDs[eventID] = "voidhowl"
			elseif timer == 53 then--Gloom (first) or Nullbeam (recurring), disambiguate by sequence flag
				if next53IsGloom then
					timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
					cachedEventIDs[eventID] = "gloom"
					next53IsGloom = false
				else
					timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
					cachedEventIDs[eventID] = "nullbeam"
				end
			elseif timer == 95 then--Gloom (recurring)
				timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
				cachedEventIDs[eventID] = "gloom"
			elseif timer == 26 then--Vaelwing or Grappling Maw (alternating), disambiguate by sequence flag
				if next26IsVaelwing then
					timerVaelwingCD:TLStart(timer, eventID, self.vb.vaelwingCount)
					cachedEventIDs[eventID] = "vaelwing"
					next26IsVaelwing = false
				else
					timerGrabblingMawCD:TLStart(timer, eventID, self.vb.mawCount)
					cachedEventIDs[eventID] = "maw"
					next26IsVaelwing = true
				end
			elseif timer == 111 then--Radiant Barrier (CD across all stages)
				timerRadiantBarrierCD:TLStart(timer, eventID, self.vb.radiantBarrierCount)
				cachedEventIDs[eventID] = "radiantbarrier"
			elseif timer == 8 then--Midnight Flames (phase marker, stage 1 → 2 → 3)
				next26S2Type = "voidhowl"
				next53S2IsGloom = true
				self:SetStage(0)--Calling 0 tells it to incremeate stage count by + 1
				return
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 2 then--Stage 2 (t=118 to t=256)
			if timer == 6 then--Rakfang (initial opener)
				timerRakfangCD:TLStart(timer, eventID, self.vb.rakfangCount)
				cachedEventIDs[eventID] = "rakfang"
			elseif timer == 11 then--Gloom (initial CD)
				timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
				cachedEventIDs[eventID] = "gloom"
			elseif timer == 16 then--Void Howl (initial CD)
				timerVoidHowlCD:TLStart(timer, eventID, self.vb.howlCount)
				cachedEventIDs[eventID] = "voidhowl"
			elseif timer == 19 then--Grappling Maw (initial CD)
				timerGrabblingMawCD:TLStart(timer, eventID, self.vb.mawCount)
				cachedEventIDs[eventID] = "maw"
			elseif timer == 28 then--Dread Breath (initial CD)
				timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
				cachedEventIDs[eventID] = "dread"
			elseif timer == 47 then--Nullbeam (initial CD)
				timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
				cachedEventIDs[eventID] = "nullbeam"
			elseif timer == 95 then--Nullbeam (recurring CD)
				timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
				cachedEventIDs[eventID] = "nullbeam"
			elseif timer == 111 then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timer, eventID, self.vb.radiantBarrierCount)
				cachedEventIDs[eventID] = "radiantbarrier"
			elseif timer == 26 then--Rakfang, Void Howl, or Grappling Maw (sequence in pull starts with voidhowl)
				if next26S2Type == "voidhowl" then
					timerVoidHowlCD:TLStart(timer, eventID, self.vb.howlCount)
					cachedEventIDs[eventID] = "voidhowl"
					next26S2Type = "maw"
				elseif next26S2Type == "rakfang" then
					timerRakfangCD:TLStart(timer, eventID, self.vb.rakfangCount)
					cachedEventIDs[eventID] = "rakfang"
					next26S2Type = "voidhowl"
				else--maw
					timerGrabblingMawCD:TLStart(timer, eventID, self.vb.mawCount)
					cachedEventIDs[eventID] = "maw"
					next26S2Type = "rakfang"
				end
			elseif timer == 53 then--Gloom or Dread Breath (alternating: gloom first)
				if next53S2IsGloom then
					timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
					cachedEventIDs[eventID] = "gloom"
					next53S2IsGloom = false
				else
					timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
					cachedEventIDs[eventID] = "dread"
					next53S2IsGloom = true
				end
			elseif timer == 8 then--Midnight Flames (phase marker, stage 2 → 3)
				next31S3IsVaelwing = true
				next63S3IsNullbeam = true
				next11S3Type = "dread"
				self:SetStage(0)
				return
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 3 then--Stage 3 (t=256 to t=454)
			if timer == 225 then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timer, eventID, self.vb.radiantBarrierCount)
				cachedEventIDs[eventID] = "radiantbarrier"
			elseif timer == 81 or timer == 65 then--Dread Breath
				timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
				cachedEventIDs[eventID] = "dread"
			elseif timer == 51 or timer == 25 then--Void Howl
				timerVoidHowlCD:TLStart(timer, eventID, self.vb.howlCount)
				cachedEventIDs[eventID] = "voidhowl"
			elseif timer == 50 then--Gloom opener
				timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
				cachedEventIDs[eventID] = "gloom"
			elseif timer == 15 then--Rakfang opener
				timerRakfangCD:TLStart(timer, eventID, self.vb.rakfangCount)
				cachedEventIDs[eventID] = "rakfang"
			elseif timer == 13 then--Nullbeam opener
				timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
				cachedEventIDs[eventID] = "nullbeam"
			elseif timer == 9 then--Vaelwing finisher
				timerVaelwingCD:TLStart(timer, eventID, self.vb.vaelwingCount)
				cachedEventIDs[eventID] = "vaelwing"
			elseif timer == 31 then--Vaelwing or Rakfang alternating (starts Vaelwing)
				if next31S3IsVaelwing then
					timerVaelwingCD:TLStart(timer, eventID, self.vb.vaelwingCount)
					cachedEventIDs[eventID] = "vaelwing"
					next31S3IsVaelwing = false
				else
					timerRakfangCD:TLStart(timer, eventID, self.vb.rakfangCount)
					cachedEventIDs[eventID] = "rakfang"
					next31S3IsVaelwing = true
				end
			elseif timer == 63 then--Nullbeam or Gloom alternating (starts Nullbeam)
				if next63S3IsNullbeam then
					timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
					cachedEventIDs[eventID] = "nullbeam"
					next63S3IsNullbeam = false
				else
					timerGloomCD:TLStart(timer, eventID, self.vb.gloomCount)
					cachedEventIDs[eventID] = "gloom"
					next63S3IsNullbeam = true
				end
			elseif timer == 11 then--In this pull: Dread Breath mid-stage, then Radiant Barrier + Nullbeam at end
				if next11S3Type == "dread" then
					timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
					cachedEventIDs[eventID] = "dread"
					next11S3Type = "barrier"
				elseif next11S3Type == "barrier" then
					timerRadiantBarrierCD:TLStart(timer, eventID, self.vb.radiantBarrierCount)
					cachedEventIDs[eventID] = "radiantbarrier"
					next11S3Type = "nullbeam"
				else
					timerNullBeamCD:TLStart(timer, eventID, self.vb.beamCount)
					cachedEventIDs[eventID] = "nullbeam"
				end
			elseif timer == 21 then--Dread Breath at end of fight
				timerDreadBreathCD:TLStart(timer, eventID, self.vb.dreadCount)
				cachedEventIDs[eventID] = "dread"
			elseif timer == 8 then--Vaelwing opener in stage 3
				timerVaelwingCD:TLStart(timer, eventID, self.vb.vaelwingCount)
				cachedEventIDs[eventID] = "vaelwing"
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		else--Unknown stage
			return
		end
	end
	--Note, bar stage changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timer = math.floor(eventInfo.duration + 0.5)
		if not badStateDetected then
			if self:IsEasy() then
				timersEasy(self, timer, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then--Finished (bar ending, cast happening soon)
			local eventType = cachedEventIDs[eventID]
			if eventType then
				if eventType == "nullbeam" then
					specWarnNullBeam:Show(self.vb.beamCount)
					specWarnNullBeam:Play("beamincoming")
					self.vb.beamCount = self.vb.beamCount + 1
				elseif eventType == "voidhowl" then
					specWarnVoidHowl:Show(self.vb.howlCount)
					specWarnVoidHowl:Play("range5")
					self.vb.howlCount = self.vb.howlCount + 1
				elseif eventType == "gloom" then
					specWarnGloom:Show(self.vb.gloomCount)
					specWarnGloom:Play("gloomincoming")
					self.vb.gloomCount = self.vb.gloomCount + 1
				elseif eventType == "dread" then
					specWarnDreadBreath:Show(self.vb.dreadCount)
					specWarnDreadBreath:Play("breathsoon")
					self.vb.dreadCount = self.vb.dreadCount + 1
				elseif eventType == "maw" then
					specWarnGrabblingMaw:Show()
					specWarnGrabblingMaw:Play("defensive")
					self.vb.mawCount = self.vb.mawCount + 1
				elseif eventType == "vaelwing" then
					specWarnVaelwing:Show()
					specWarnVaelwing:Play("defensive")
					self.vb.vaelwingCount = self.vb.vaelwingCount + 1
				elseif eventType == "rakfang" then
					specWarnRakfang:Show()
					specWarnRakfang:Play("defensive")
					self.vb.rakfangCount = self.vb.rakfangCount + 1
				elseif eventType == "radiantbarrier" then
					specWarnRadiantBarrier:Show(self.vb.radiantBarrierCount)
					specWarnRadiantBarrier:Play("findshield")
					self.vb.radiantBarrierCount = self.vb.radiantBarrierCount + 1
				end
				cachedEventIDs[eventID] = nil
			end
		elseif eventState == 3 then--Canceled/removed
			cachedEventIDs[eventID] = nil
		end
	end
end
