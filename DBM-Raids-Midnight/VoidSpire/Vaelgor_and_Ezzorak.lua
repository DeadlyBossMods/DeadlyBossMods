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
local warnGrabblingMaw				= mod:NewCountAnnounce(1280458, 2, nil, "Tank")
local warnDreadBreath				= mod:NewBlizzTargetAnnounce(1244221, 4)

local specWarnNullBeam				= mod:NewSpecialWarningCount(1262623, nil, nil, nil, 2, 2)
local specWarnVoidHowl				= mod:NewSpecialWarningCount(1244917, nil, nil, DBM_COMMON_L.ORBS, 2, 2)
local specWarnGloom					= mod:NewSpecialWarningCount(1245391, nil, nil, nil, 2, 2)
local specWarnDreadBreath			= mod:NewSpecialWarningCount(1244221, nil, 17088, nil, 2, 2)
local specWarnMidnightFlames		= mod:NewSpecialWarningCount(1249748, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
--local specWarnGrabblingMaw		= mod:NewSpecialWarningCount(1280458, nil, nil, nil, 1, 2)
local specWarnRakfang				= mod:NewSpecialWarningDefensive(1245645, nil, nil, nil, 1, 2)
local specWarnVaelwing				= mod:NewSpecialWarningDefensive(1265131, nil, nil, nil, 1, 2)
local specWarnCosmosisGloom			= mod:NewSpecialWarningCount(1277470, nil, nil, nil, 2, 2)
local specWarnCosmosisNullbeam		= mod:NewSpecialWarningCount(1277471, nil, nil, nil, 2, 2)
local specWarnCosmosisDreadBreath	= mod:NewSpecialWarningCount(1277472, nil, nil, nil, 2, 2)
local specWarnCosmosisVoidHowl		= mod:NewSpecialWarningCount(1277473, nil, nil, nil, 2, 2)
local specWarnRadiantBarrier		= mod:NewSpecialWarningCount(1248847, nil, nil, nil, 2, 2)

local timerNullBeamCD				= mod:NewCDCountTimer(20.5, 1262623, nil, nil, nil, 3)
local timerVoidHowlCD				= mod:NewCDCountTimer(20.5, 1244917, DBM_COMMON_L.ORBS.." (%s)", nil, nil, 2)
local timerGloomCD					= mod:NewCDCountTimer(20.5, 1245391, nil, nil, nil, 3)
local timerDreadBreathCD			= mod:NewCDCountTimer(20.5, 1244221, 17088, nil, nil, 3)
local timerMidnightFlamesCD			= mod:NewCDCountTimer(20.5, 1249748, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2)
local timerGrabblingMawCD			= mod:NewCDCountTimer(20.5, 1280458, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRakfangCD				= mod:NewCDCountTimer(20.5, 1245645, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVaelwingCD				= mod:NewCDCountTimer("d20.5", 1265131, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmosisGloomCD			= mod:NewCDCountTimer(20.5, 1277470, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisNullbeamCD		= mod:NewCDCountTimer(20.5, 1277471, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisDreadBreathCD	= mod:NewCDCountTimer(20.5, 1277472, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCosmosisVoidHowlCD		= mod:NewCDCountTimer(20.5, 1277473, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerRadiantBarrierCD			= mod:NewCDCountTimer(20.5, 1248847, nil, nil, nil, 5)

mod:AddPrivateAuraSoundOption({1262999,1262676,1262656}, false, 1262623, 1, 3, "beamyou", 19)--Null Beam (soaked it)
mod:AddPrivateAuraSoundOption(1244672, true, 1262623, 1, 2, "lineapart", 2)--Null Zone Grippy hand
mod:AddPrivateAuraSoundOption(1252157, false, 1262623, 1, 1, "debuffyou", 17)--Null Implosion
mod:AddPrivateAuraSoundOption(1245554, true, 1245391, 1, 3, "gloomyou", 19)--Gloomtouched (soaked Gloom)
mod:AddPrivateAuraSoundOption(1270852, false, 1245391, 1, 3, "debuffyou", 17)--Diminish (Gloomtouched ended, don't soak again)
mod:AddPrivateAuraSoundOption(1245421, true, 1245391, 1, 2, "watchfeet", 8)--Gloomfield (GTFO left by gloom)
mod:AddPrivateAuraSoundOption(1255612, true, 1244221, 1, 3, "runout", 2)--Dread Breath Target
--mod:AddPrivateAuraSoundOption(1255979, true, 1244221, 1, 3)--Dread Breath debuff
mod:AddPrivateAuraSoundOption(1265152, true, 1245645, 1, 3, "stunyou", 19)--Impale (secondary attack of Rakfang)
--mod:AddPrivateAuraSoundOption(1248865, true, 1248865, 1, 1, "barrieryou", 19)--Radiant Barrier (Ultra Spammy)
mod:AddPrivateAuraSoundOption(1270497, true, 1270497, 1, 1, "shadowyou", 15)--Shadowmark

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
local showOnNextWarning = 0
local badStateDetected = false
local next53IsGloom = false
local next26S1Type = "vaelwing"
local next26S2Type = "rakfang"
local next53S2IsGloom = true
local next31S3IsVaelwing = true
local next63S3IsNullbeam = true
local next25S3Type = "voidhowl"
local lastS3Type = nil
--Heroic state variables
local next25H1Type = "vaelwing"
local next50H1IsGloom = true
local next25H2Type = "rakfang"
local next31H3IsVaelwing = true
local next62H3IsNullbeam = true
local next25H3Type = "voidhowl"
local nullbeamH3InitialDone = false
--Mythic stage 1 state variables
local next50M1IsGloom = true
local next25M1Type = "rakfang"
local mythicStage2TransitionSeen = false

---@param self DBMMod
local function setFallback(self)
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
	timerGrabblingMawCD:SetTimeline(219)
	if self:IsTank() then
		warnGrabblingMaw:SetAlert(219, "pullin", 2, 3)
		specWarnRakfang:SetAlert(220, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
		specWarnVaelwing:SetAlert(221, "defensive", 2, 3, 0)--Assumed 0 will scope it to player only, needs vetting
	end
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

function mod:OnLimitedCombatStart()
	self:TLCountReset()
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
	showOnNextWarning = 0
	next53IsGloom = true
	next26S1Type = "vaelwing"
	next26S2Type = "rakfang"
	next53S2IsGloom = true
	next31S3IsVaelwing = true
	next63S3IsNullbeam = true
	next25S3Type = "voidhowl"
	lastS3Type = nil
	next25H1Type = "vaelwing"
	next50H1IsGloom = true
	next25H2Type = "rakfang"
	next31H3IsVaelwing = true
	next62H3IsNullbeam = true
	next25H3Type = "voidhowl"
	nullbeamH3InitialDone = false
	next50M1IsGloom = true
	next25M1Type = "rakfang"
	mythicStage2TransitionSeen = false
	--Hardcode features first
	if DBM.Options.HardcodedTimer and not badStateDetected then
		self:SetStage(1)
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
			"ENCOUNTER_WARNING"
		)
	else
		setFallback(self)
	end
	--self:EnablePrivateAuraSound(1255979, "fearyou", 19)
end

function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	local function fallbackMythicStage2(self)
		if DBM.Options.IgnoreBlizzAPI then
			DBM.Options.IgnoreBlizzAPI = false
			DBM:FireEvent("DBM_ResumeBlizzAPI")
		end
		self:UnregisterShortTermEvents()
		setFallback(self)
		DBM:Debug("|cffffff00Mythic stage 2 hardcode is not implemented yet, falling back to Blizzard API|r", nil, nil, nil, true)
	end

	---@param self DBMMod
	---@param timer number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		--Logic confirmed against normal only. LFR not available yet
		local stage = self:GetStage()
		if stage == 1 then--Stage 1
			if self:IsRoundedTimer(timer, 1) or self:IsRoundedTimer(timer, 11) then--Nullbeam opener (legacy at 1s, current at 11s)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 6) then--Vaelwing (initial tank ability at pull)
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			elseif self:IsRoundedTimer(timer, 13) then--Rakfang opener (now present in stage 1)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
			elseif self:IsRoundedTimer(timer, 19) then--Grappling Maw (initial CD)
				timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
			elseif self:IsRoundedTimer(timer, 21) then--Dread Breath (recurring CD)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 28) then--Dread Breath (initial CD)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 17) then--Dread Breath (new short interval seen in stage 1)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 32) then--Void Howl (initial CD)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 47) then--Void Howl (recurring CD)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 53) then--Gloom (first) or Nullbeam (recurring), disambiguate by sequence flag
				if next53IsGloom then
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					next53IsGloom = false
				else
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
				end
			elseif self:IsRoundedTimer(timer, 95) then--Gloom (recurring)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			elseif self:IsRoundedTimer(timer, 26) then--Vaelwing, Rakfang, Grappling Maw cycle
				if next26S1Type == "vaelwing" then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next26S1Type = "rakfang"
				elseif next26S1Type == "rakfang" then
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next26S1Type = "maw"
				else
					timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
					next26S1Type = "vaelwing"
				end
			elseif self:IsRoundedTimer(timer, 111) then--Radiant Barrier (CD across all stages)
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			elseif self:IsRoundedTimer(timer, 8) then--Midnight Flames (phase marker, stage 1 → 2 → 3)
				next26S2Type = "rakfang"
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
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 2 then--Stage 2 (t=118 to t=256)
			if self:IsRoundedTimer(timer, 6) then--Rakfang (initial opener)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
			elseif self:IsRoundedTimer(timer, 11) then--Gloom (initial CD)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			elseif self:IsRoundedTimer(timer, 13) then--Vaelwing (initial CD)
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			elseif self:IsRoundedTimer(timer, 16) then--Void Howl (initial CD)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 19) then--Grappling Maw (initial CD)
				timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
			elseif self:IsRoundedTimer(timer, 28) then--Dread Breath (initial CD)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 47) then--Nullbeam (initial CD)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 90) or self:IsRoundedTimer(timer, 95) then--Nullbeam (recurring CD, seen around 90 in this log)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 111) then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			elseif self:IsRoundedTimer(timer, 25) then--Rakfang, Vaelwing, Void Howl, Grappling Maw repeating lane
				if next26S2Type == "rakfang" then
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next26S2Type = "vaelwing"
				elseif next26S2Type == "vaelwing" then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next26S2Type = "voidhowl"
				elseif next26S2Type == "voidhowl" then
					timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
					next26S2Type = "maw"
				else--maw
					timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
					next26S2Type = "rakfang"
				end
			elseif self:IsRoundedTimer(timer, 51) then--Dread Breath recurring (raw ~51.3-51.6, rounds to 51 or 52); checked before ~53 to win the overlap at 52
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
				next53S2IsGloom = true
			elseif self:IsRoundedTimer(timer, 53) then--Gloom or Dread Breath (alternating: gloom first)
				if next53S2IsGloom then
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					next53S2IsGloom = false
				else
					timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
					next53S2IsGloom = true
				end
			elseif self:IsRoundedTimer(timer, 8) then--Midnight Flames (phase marker, stage 2 → 3)
				next31S3IsVaelwing = true
				next63S3IsNullbeam = true
				next25S3Type = "voidhowl"
				lastS3Type = nil
				self:SetStage(0)
				return
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 3 then--Stage 3 (t=256 to t=454)
			if self:IsRoundedTimer(timer, 225) then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
				lastS3Type = "radiantbarrier"
			elseif self:IsRoundedTimer(timer, 81) or self:IsRoundedTimer(timer, 65) then--Dread Breath
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
				lastS3Type = "dread"
			elseif self:IsRoundedTimer(timer, 50, 0) then--Gloom opener (exact match to avoid overlap with ~51 Void Howl)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
				lastS3Type = "gloom"
			elseif self:IsRoundedTimer(timer, 51) then--Void Howl
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
				lastS3Type = "voidhowl"
			elseif self:IsRoundedTimer(timer, 15) then--Rakfang opener
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
				lastS3Type = "rakfang"
				next31S3IsVaelwing = true
			elseif self:IsRoundedTimer(timer, 13) then--Collision bucket: Nullbeam opener or drifted Rakfang/Gloom
				if not lastS3Type or lastS3Type == "dread" or lastS3Type == "radiantbarrier" then--Nullbeam opener context (early stage 3)
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
					lastS3Type = "nullbeam"
				elseif lastS3Type == "voidhowl" then--14 Gloom drifted down to 13
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					lastS3Type = "gloom"
				elseif lastS3Type == "gloom" then--12 Rakfang drifted up to 13
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					lastS3Type = "rakfang"
					next25S3Type = "rakfang"
					next31S3IsVaelwing = true
				else--Conservative fallback in compressed cadence: prefer Rakfang over opener Nullbeam
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					lastS3Type = "rakfang"
					next25S3Type = "rakfang"
					next31S3IsVaelwing = true
				end
			elseif self:IsRoundedTimer(timer, 9) then--Vaelwing finisher
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
				lastS3Type = "vaelwing"
			elseif self:IsRoundedTimer(timer, 31) then--Vaelwing or Rakfang alternating (starts Vaelwing)
				if next31S3IsVaelwing then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next31S3IsVaelwing = false
					lastS3Type = "vaelwing"
				else
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next31S3IsVaelwing = true
					lastS3Type = "rakfang"
				end
			elseif self:IsRoundedTimer(timer, 63, 2) then--Nullbeam or Gloom alternating (starts Nullbeam); variance 2 covers raw 61-63
				if next63S3IsNullbeam then
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
					next63S3IsNullbeam = false
					lastS3Type = "nullbeam"
				else
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					next63S3IsNullbeam = true
					lastS3Type = "gloom"
				end
			elseif self:IsRoundedTimer(timer, 11) then--Void Howl (late-stage compressed cadence seen in new log)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
				lastS3Type = "voidhowl"
			elseif self:IsRoundedTimer(timer, 14) then--Gloom (late-stage compressed cadence)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
				lastS3Type = "gloom"
			elseif self:IsRoundedTimer(timer, 12) or self:IsRoundedTimer(timer, 3) then--Rakfang (late-stage compressed cadence)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
				next25S3Type = "rakfang"
				next31S3IsVaelwing = true
				lastS3Type = "rakfang"
			elseif self:IsRoundedTimer(timer, 25) then--Void Howl (opener), then Rakfang for all subsequent
				if next25S3Type == "rakfang" then
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next31S3IsVaelwing = true
					lastS3Type = "rakfang"
				else
					timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
					lastS3Type = "voidhowl"
					next25S3Type = "rakfang"--First ~25 is always VoidHowl opener; all subsequent are Rakfang
				end
			elseif self:IsRoundedTimer(timer, 21) then--Dread Breath at end of fight
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
				lastS3Type = "dread"
			elseif self:IsRoundedTimer(timer, 8) then--Vaelwing opener in stage 3
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
				lastS3Type = "vaelwing"
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				if not DBM.Options.DebugMode then
					badStateDetected = true
					if DBM.Options.IgnoreBlizzAPI then
						DBM.Options.IgnoreBlizzAPI = false
						DBM:FireEvent("DBM_ResumeBlizzAPI")
					end
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		else--Unknown stage
			--TODO, get long pull that actually goes into stage 4. which should also be triggered by barrier/midnight flames combo
			if not DBM.Options.DebugMode then
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
			return
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersMythic(self, timer, timerExact, eventID)
		if self:GetStage() ~= 1 then
			fallbackMythicStage2(self)
			return
		end
		if self:IsRoundedTimer(timer, 6) or self:IsRoundedTimer(timer, 17) or self:IsRoundedTimer(timer, 19) then--Vaelwing cadence confirmed in mythic stage 1
			timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
		elseif self:IsRoundedTimer(timer, 7) or self:IsRoundedTimer(timer, 65) then--Dread Breath opener and repeats
			timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
		elseif self:IsRoundedTimer(timer, 10) then--Gloom opener
			timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
		elseif self:IsRoundedTimer(timer, 12) then--Rakfang opener
			timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
		elseif self:IsRoundedTimer(timer, 21) then--Rakfang recurring cadence
			timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
		elseif self:IsRoundedTimer(timer, 25) then--Late stage-1 drift bucket: Rakfang first, then Vaelwing
			if next25M1Type == "rakfang" then
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
				next25M1Type = "vaelwing"
			else
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			end
		elseif self:IsRoundedTimer(timer, 30) then--Nullbeam opener
			timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
		elseif self:IsRoundedTimer(timer, 35) or self:IsRoundedTimer(timer, 40) then--Void Howl opener and repeats
			timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
		elseif self:IsRoundedTimer(timer, 50) then--Alternates Gloom then Nullbeam through mythic stage 1
			if next50M1IsGloom then
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
				next50M1IsGloom = false
			else
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
				next50M1IsGloom = true
			end
		elseif self:IsRoundedTimer(timer, 120) then--Radiant Barrier at pull and again on the stage-2 handoff
			timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			if mythicStage2TransitionSeen then
				fallbackMythicStage2(self)
			else
				mythicStage2TransitionSeen = true
			end
		elseif self:IsRoundedTimer(timer, 8) or self:IsRoundedTimer(timer, 13) or self:IsRoundedTimer(timer, 18) or self:IsRoundedTimer(timer, 23) then--Stage 2 bundle begins here in current mythic evidence
			fallbackMythicStage2(self)
		else--Reached end of mythic stage-1 evidence without a valid timer, hardcode has failed, fall back to Blizz API
			badStateDetected = true
			if DBM.Options.IgnoreBlizzAPI then
				DBM.Options.IgnoreBlizzAPI = false
				DBM:FireEvent("DBM_ResumeBlizzAPI")
			end
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected mythic stage 1 timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		--Logic confirmed against heroic week 2+3 pulls. All 3 stages hardcoded.
		local stage = self:GetStage()
		if stage == 1 then--Stage 1
			if self:IsRoundedTimer(timer, 6) then--Vaelwing (initial)
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			elseif self:IsRoundedTimer(timer, 10) then--Nullbeam (initial)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 12) then--Rakfang (initial)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
			elseif self:IsRoundedTimer(timer, 18) then--Grappling Maw (initial)
				timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
			elseif self:IsRoundedTimer(timer, 27) then--Dread Breath (initial)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 30) then--Void Howl (initial)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 105) then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			elseif self:IsRoundedTimer(timer, 50) then--Gloom (first) then Nullbeam (recurring)
				if next50H1IsGloom then
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					next50H1IsGloom = false
				else
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
				end
			elseif self:IsRoundedTimer(timer, 20) then--Dread Breath (recurring)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 16) then--Dread Breath (short variant)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 45) then--Void Howl (recurring)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 90) then--Gloom (recurring)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			elseif self:IsRoundedTimer(timer, 25) then--Vaelwing, Rakfang, Grappling Maw cycle
				if next25H1Type == "vaelwing" then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next25H1Type = "rakfang"
				elseif next25H1Type == "rakfang" then
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next25H1Type = "maw"
				else
					timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
					next25H1Type = "vaelwing"
				end
			elseif self:IsRoundedTimer(timer, 8) then--Midnight Flames (stage 1 → 2)
				next25H2Type = "rakfang"
				self:SetStage(0)
				return
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 2 then--Stage 2
			if self:IsRoundedTimer(timer, 6) then--Rakfang (initial)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
			elseif self:IsRoundedTimer(timer, 10) then--Gloom (initial)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			elseif self:IsRoundedTimer(timer, 12) then--Vaelwing (initial)
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			elseif self:IsRoundedTimer(timer, 15) then--Void Howl (initial)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 18) then--Grappling Maw (initial)
				timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
			elseif self:IsRoundedTimer(timer, 27) then--Dread Breath (initial); must be before ~25 catch-all
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 45) then--Nullbeam (initial)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 85) then--Nullbeam (recurring)
				timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
			elseif self:IsRoundedTimer(timer, 105) then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			elseif self:IsRoundedTimer(timer, 49) then--Dread Breath (raw ~48.7-49.0) or Gloom (raw ~49.96-49.97); disambiguate by rounded value
				--Keep an eye on this rule as more data comes in to make sure this doesn't become a point of failure
				if timerExact >= 50 then--Gloom recurring (rounds to 50)
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
				else--Dread Breath recurring (rounds to 49)
					timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
				end
			elseif self:IsRoundedTimer(timer, 25, 2) then--4-way cycle: Rakfang → Vaelwing → VoidHowl → Maw (raw 23.5-25.0)
				if next25H2Type == "rakfang" then
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next25H2Type = "vaelwing"
				elseif next25H2Type == "vaelwing" then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next25H2Type = "voidhowl"
				elseif next25H2Type == "voidhowl" then
					timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
					next25H2Type = "maw"
				else--maw
					timerGrabblingMawCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maw", "mawCount"))
					next25H2Type = "rakfang"
				end
			elseif self:IsRoundedTimer(timer, 8) then--Midnight Flames (stage 2 → 3)
				next31H3IsVaelwing = true
				next62H3IsNullbeam = true
				next25H3Type = "voidhowl"
				nullbeamH3InitialDone = false
				self:SetStage(0)
				return
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 3 then--Stage 3
			if self:IsRoundedTimer(timer, 225) then--Radiant Barrier
				timerRadiantBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiantbarrier", "radiantBarrierCount"))
			elseif self:IsRoundedTimer(timer, 65) then--Dread Breath (initial); must be before ~62 variance 2
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 81) then--Dread Breath (recurring)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 76) then--Dread Breath (recurring variant)
				timerDreadBreathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "dread", "dreadCount"))
			elseif self:IsRoundedTimer(timer, 50) then--Gloom (initial); must be before ~51 to prevent overlap
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			elseif self:IsRoundedTimer(timer, 51) then--Void Howl (recurring)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 46) then--Void Howl (late-stage variant)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 13) then--Nullbeam (initial) or Rakfang (late-stage compressed cadence)
				if not nullbeamH3InitialDone then
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
					nullbeamH3InitialDone = true
				else
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next31H3IsVaelwing = true
				end
			elseif self:IsRoundedTimer(timer, 8) then--Vaelwing (initial)
				timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
			elseif self:IsRoundedTimer(timer, 15) then--Rakfang (initial)
				timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
			elseif self:IsRoundedTimer(timer, 31) then--Vaelwing / Rakfang alternating (starts Vaelwing)
				if next31H3IsVaelwing then
					timerVaelwingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vaelwing", "vaelwingCount"))
					next31H3IsVaelwing = false
				else
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next31H3IsVaelwing = true
				end
			elseif self:IsRoundedTimer(timer, 62, 2) then--Nullbeam / Gloom alternating (starts Nullbeam); raw 61.2-62.5
				if next62H3IsNullbeam then
					timerNullBeamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullbeam", "beamCount"))
					next62H3IsNullbeam = false
				else
					timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
					next62H3IsNullbeam = true
				end
			elseif self:IsRoundedTimer(timer, 25) then--Void Howl (first) then drifted Rakfang (subsequent)
				if next25H3Type == "voidhowl" then
					timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
					next25H3Type = "rakfang"
				else
					timerRakfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rakfang", "rakfangCount"))
					next31H3IsVaelwing = true--Drifted Rakfang consumed outside ~31 alternator, reset to Vaelwing
				end
			elseif self:IsRoundedTimer(timer, 21) then--Void Howl (late-stage compressed cadence)
				timerVoidHowlCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidhowl", "howlCount"))
			elseif self:IsRoundedTimer(timer, 26) then--Gloom (late-stage compressed cadence)
				timerGloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloom", "gloomCount"))
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				if not DBM.Options.DebugMode then
					badStateDetected = true
					if DBM.Options.IgnoreBlizzAPI then
						DBM.Options.IgnoreBlizzAPI = false
						DBM:FireEvent("DBM_ResumeBlizzAPI")
					end
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		else--Unknown stage
			return
		end
	end

	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timer = eventInfo.duration
		local timerExact = math.floor(timer + 0.5)
		if not badStateDetected then
			if self:IsMythic() then
				timersMythic(self, timer, timerExact, eventID)
			elseif self:IsEasy() then
				timersEasy(self, timer, timerExact, eventID)
			else
				timersHeroic(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then--Finished (bar ending, cast happening soon)
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "nullbeam" then
					specWarnNullBeam:Show(eventCount)
					specWarnNullBeam:Play("beamincoming")
				elseif eventType == "voidhowl" then
					specWarnVoidHowl:Show(eventCount)
					specWarnVoidHowl:Play("range5")
				elseif eventType == "gloom" then
					specWarnGloom:Show(eventCount)
					specWarnGloom:Play("gloomincoming")
				elseif eventType == "dread" then
					showOnNextWarning = eventCount
					specWarnDreadBreath:Show(eventCount)
					specWarnDreadBreath:Play("breathsoon")
				elseif eventType == "maw" then
					if self:IsTank() then
						warnGrabblingMaw:Show(eventCount)
					end
				elseif eventType == "vaelwing" then
					if self:IsTank() then
						specWarnVaelwing:Show()
						specWarnVaelwing:Play("defensive")
					end
				elseif eventType == "rakfang" then
					if self:IsTank() then
						specWarnRakfang:Show()
						specWarnRakfang:Play("defensive")
					end
				elseif eventType == "radiantbarrier" then
					specWarnRadiantBarrier:Show(eventCount)
					specWarnRadiantBarrier:Play("findshield")
				end
			end
		elseif eventState == 3 then--Canceled/removed
			self:TLCountCancel(eventID)
		end
	end
end

function mod:ENCOUNTER_WARNING(encounterWarningInfo)
	if showOnNextWarning > 0 then
		--Secrets
		local targetName = encounterWarningInfo.targetName
		local targetGUID = encounterWarningInfo.targetGUID
		local formattedTargetName = targetName or UNKNOWN
		if targetGUID then
			local _, className = GetPlayerInfoByGUID(targetGUID)
			if className then
				local classColor = C_ClassColor.GetClassColor(className)
				if classColor then
				    formattedTargetName = classColor:WrapTextInColorCode(formattedTargetName);
				end
			end
		end
		warnDreadBreath:Show(showOnNextWarning, formattedTargetName)
		showOnNextWarning = 0
	end
end
