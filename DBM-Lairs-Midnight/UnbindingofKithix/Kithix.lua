if DBM:GetTOC() < 120105 then return end
local mod	= DBM:NewMod(2896, "DBM-Lairs-Midnight", 1, 1324)--Change order when 12.1.5 ships

mod.statTypes = "story,lfr,normal,heroic,mythic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(267861)
mod:SetEncounterID(3513)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3095)

mod:RegisterCombat("combat")

--NOTE. https://www.wowhead.com/ptr-2/spell=1303406/abyssal-grasp has event ID of 864 but we'll use aura for now until we can confirm ENCOUNTER_WARNING is used
--TODO, cleanup objects that don't have timeline events
--TODO, gtfo for https://www.wowhead.com/ptr-2/spell=1304950/voidscar ?
--TODO, more renames
DBM:RegisterAltSpellName(1304930, DBM_COMMON_L.TANK .. " " .. DBM_COMMON_L.BIG_CIRCLE)--Dark Devastation -> Tank Big Circle
DBM:RegisterAltSpellName(1301511, DBM_COMMON_L.ADDS)--Voidswarm -> Adds
DBM:RegisterAltSpellName(1304045, DBM_COMMON_L.FEAR .. " " .. DBM_COMMON_L.DEBUFFS)--Unspeakable Horrors -> Fear Debuffs
DBM:RegisterAltSpellName(1302951, DBM_COMMON_L.INTERMISSION)--Suffocating Darkness -> Intermission
DBM:RegisterAltSpellName(1303681, 61618)--Twisted Appendage -> Tentacles
DBM:RegisterAltSpellName(1303406, DBM_COMMON_L.HEALABSORBS)--Abyssal Grasp -> Heal Absorbs
DBM:RegisterAltSpellName(1303169, DBM_COMMON_L.INTERMISSION .. " " .. DBM_COMMON_L.OVER)--Divine Radiance -> Intermission Over
DBM:RegisterAltSpellName(1318467, DBM_COMMON_L.TANKDEBUFF)--Negation -> Tank Debuff
--Stage 1
local warnEightfoldEclipse				= mod:NewCountAnnounce(1301479, 4)--Hardcode Only

local specWarnDarkDevastation			= mod:NewSpecialWarningDefensive(1304930, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnVoidswarm					= mod:NewSpecialWarningCount(1301511, nil, nil, nil, 1, 2, nil, nil, "killmob")
local warnSuffocatingDarkness			= mod:NewSpecialWarningCount(1302951, nil, nil, nil, 2, 2, nil, nil, "findshield")
local specWarnExtinguish				= mod:NewSpecialWarningCount(1304424, nil, nil, nil, 3, 18, nil, nil, "movetoyelloworb")
local specWarnTwistedAppendage			= mod:NewSpecialWarningDodgeCount(1303681, nil, nil, nil, 2, 2, nil, nil, "watchfeet")
local specWarnDivineRadiance			= mod:NewSpecialWarningCount(1303169, nil, nil, nil, 2, 2, nil, nil, "phasechange")

local timerUnspeakableHorrorsCD			= mod:NewCDCountTimer(20.5, 1304045, nil, nil, nil, 3)
local timerDarkDevastationCD			= mod:NewCDCountTimer(20.5, 1304930, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerVoidswarmCD					= mod:NewCDCountTimer(20.5, 1301511, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.HEALER_ICON)
local timerSuffocatingDarknessCD		= mod:NewCDCountTimer(20.5, 1302951, nil, nil, nil, 2)
local timerExtinguishCD					= mod:NewCDCountTimer(20.5, 1304424, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTwistedAppendageCD			= mod:NewCDCountTimer(20.5, 1303681, nil, nil, nil, 3)
local timerNullgateCD					= mod:NewCDCountTimer(20.5, 1308873, nil, nil, nil, 3)
local timerAbyssalGraspCD				= mod:NewCDCountTimer(20.5, 1303406, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerDivineRadianceCD				= mod:NewCDCountTimer(20.5, 1303169, nil, nil, nil, 6)--Technically not a cd but a buff active timer, but that doesn't use count
local timerNegationCD					= mod:NewCDCountTimer(20.5, 1318467, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEightfoldEclipseCD			= mod:NewCDCountTimer(20.5, 1301479, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddBoolOption("warnAddCasts", true, "announce")--Hardcode Only

mod:AddAuraSoundOption(1304045, true, 1304045, 1, 1, "runout", 2)--Unbreakable Horror (pre debuff that leads to Overwhelming Fear
mod:AddAuraSoundOption(1304046, true, 1304045, 1, 3, "fearyou", 2)--Overwhelming Fear
mod:AddAuraSoundOption(1303406, true, 1302951, 1, 1, "absorbyou", 19)--Abyssal Grasp, part of Suffocating Darkness
mod:AddAuraSoundOption(1308873, true, 1308873, 1, 1, "runout", 2)--Null gate (make custom audio later?)
mod:AddAuraSoundOption(1318467, true, 1318467, 1, 1, "movetogate", 20)--Negation
mod:AddAuraSoundOption(1304040, true, 1301511, 1, 1, "stunyou", 19)--Mindsting
mod:AddAuraSoundOption(1302334, false, 1301511, 1, 1, "beamyou", 19)--Voidweave
mod:AddAuraSoundOption(1304434, true, 1301511, 1, 1, "fixateyou", 19)--Fixate (verify ID)
--mod:AddAuraSoundOption(1303257, true, 1302951, 1, 2, "findshelter", 2)--Suffocation (debuff from not being in barrier)

local badStateDetected = false

---@param self DBMMod
---@param dontSetAlerts boolean? Called on engage when we only want to set timeline parameters and not touch encounter alerts
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnDarkDevastation:SetAlert(858, "defensive", 2, 2)
		end
		specWarnVoidswarm:SetAlert(859, "killmob", 2, 3)
		warnSuffocatingDarkness:SetAlert(860, "findshield", 2, 2)
		specWarnExtinguish:SetAlert(861, "movetoyelloworb", 18, 4)
		specWarnTwistedAppendage:SetAlert(862, "watchstep", 2, 2)
		specWarnDivineRadiance:SetAlert(951, "phasechange", 2, 2)
	end

	--If user has dbm bars enabled, countdowns will be sent by dbm bars
	--if user has dbm bars off, SetTimeline will set color and countdowns
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerUnspeakableHorrorsCD:SetTimeline(838, onlyColor)
	timerDarkDevastationCD:SetTimeline(858, onlyColor)
	timerVoidswarmCD:SetTimeline(859, onlyColor)
	timerSuffocatingDarknessCD:SetTimeline(860, onlyColor)
	timerExtinguishCD:SetTimeline(861, onlyColor)
	timerTwistedAppendageCD:SetTimeline(862, onlyColor)
	timerAbyssalGraspCD:SetTimeline(864, onlyColor)
	timerNullgateCD:SetTimeline(903, onlyColor)
	timerDivineRadianceCD:SetTimeline(951, onlyColor)
	timerNegationCD:SetTimeline(1002, onlyColor)
	timerEightfoldEclipseCD:SetTimeline(1003, onlyColor)
end

do
	local stage1TwentyNineCount = 0
	local stage1FiftyTwoCount = 0
	local stage1HundredNineCount = 0
	local stage2TenCount = 0
	local storyFortyFiveCount = 0
	local storyFiftySevenCount = 0
	local storyHundredNineteenCount = 0
	local addWindowActive = false
	---@type table<number, {timerObj: Timer, count: number?}>
	local scheduledEvents = {}

	---@param self DBMMod
	local function finishTimelineEvent(self, eventID)
		local eventType, eventCount = self:TLCountFinish(eventID)
		if not eventType or not eventCount then return end
		if eventType == "devastation" then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnDarkDevastation:Show()
				specWarnDarkDevastation:Play("defensive")
			end
		elseif eventType == "voidswarm" then
			addWindowActive = true
			specWarnVoidswarm:Show(eventCount)
			specWarnVoidswarm:Play("killmob")
		elseif eventType == "darkness" then
			addWindowActive = false
			warnSuffocatingDarkness:Show(eventCount)
			warnSuffocatingDarkness:Play("findshield")
		elseif eventType == "extinguish" then
			specWarnExtinguish:Show(eventCount)
			specWarnExtinguish:Play("movetoyelloworb")
		elseif eventType == "appendage" then
			specWarnTwistedAppendage:Show(eventCount)
			specWarnTwistedAppendage:Play("watchfeet")
		elseif eventType == "radiance" then
			specWarnDivineRadiance:Show(eventCount)
			specWarnDivineRadiance:Play("phasechange")
		elseif eventType == "eclipse" then
			warnEightfoldEclipse:Show(eventCount)
		end
		--Horrors, Grasp, Null Gate and Negation already have personal aura audio.
	end

	---@param self DBMMod
	local function finishScheduledEvent(self, eventID)
		local entry = scheduledEvents[eventID]
		if not entry then return end
		scheduledEvents[eventID] = nil
		entry.timerObj:Stop(entry.count)
		entry.timerObj:UnsetBuggedEventID(eventID)
		--Let core release the timer mapping it retained for the premature terminal event.
		DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		finishTimelineEvent(self, eventID)
	end

	---@param self DBMMod
	local function cancelScheduledEvent(self, eventID)
		local entry = scheduledEvents[eventID]
		if not entry then return end
		scheduledEvents[eventID] = nil
		self:Unschedule(finishScheduledEvent, self, eventID)
		entry.timerObj:Stop(entry.count)
		entry.timerObj:UnsetBuggedEventID(eventID)
		DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		self:TLCountCancel(eventID)
	end

	---@param self DBMMod
	local function resetScheduledEvents(self)
		for eventID in pairs(scheduledEvents) do
			cancelScheduledEvent(self, eventID)
		end
	end

	---@param self DBMMod
	---@param timerObj Timer
	local function startScheduledEvent(self, timerObj, timerExact, eventID, eventType, countKey)
		--These events report state 2 immediately; the raw duration is their real cooldown.
		local count = self:TLCountStart(eventID, eventType, countKey)
		timerObj:SetBuggedEventID(eventID)
		timerObj:TLStart(timerExact, eventID, count)
		scheduledEvents[eventID] = {timerObj = timerObj, count = count}
		self:Schedule(timerExact, finishScheduledEvent, self, eventID)
	end

	---@param self DBMMod
	local function hardcodeFailed(self)
		badStateDetected = true
		addWindowActive = false
		resetScheduledEvents(self)
		self:Stop()
		self:TLCountReset()
		self:ResumeBlizzardAPI()
		self:UnregisterShortTermEvents()
		setFallback(self)
		DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, true, nil, true)
	end

	---@param self DBMMod
	local function timersEasy(self, timer, timerExact, eventID)
		--Story transitions on Eclipse; LFR/Normal transition on their first Null Gate.
		if ((self:IsStory() and timer == 121) or (not self:IsStory() and timer == 3)) and not self:GetStage(2) then
			addWindowActive = false
			resetScheduledEvents(self)
			self:Stop()
			self:TLCountReset()
			self:SetStage(2)
		end
		if self:IsStory() and timer == 121 then
			timerEightfoldEclipseCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "eclipse", "eclipseCount"))
		elseif self:GetStage(1) then
			if timer == 5 then
				timerVoidswarmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidswarm", "voidswarmCount"))
			elseif timer == 15 or timer == 21 or timer == 34 then
				timerTwistedAppendageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "appendage", "appendageCount"))
			elseif timer == 20 or timer == 22 or timer == 77 or (self:IsNormal() and (timer == 23 or timer == 54)) then
				timerDarkDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			elseif timer == 31 or timer == 62 then
				timerExtinguishCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "extinguish", "extinguishCount"))
			elseif timer == 45 then--Story/LFR: opening Devastation, then Radiance. Normal: Radiance only.
				storyFortyFiveCount = storyFortyFiveCount + 1
				if storyFortyFiveCount == 1 and not self:IsNormal() then
					timerDarkDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
				else
					timerDivineRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiance", "radianceCount"))
				end
			elseif timer == 57 then--Identical raw 57: opening Darkness, then Extinguish.
				storyFiftySevenCount = storyFiftySevenCount + 1
				if storyFiftySevenCount == 1 then
					timerSuffocatingDarknessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkness", "darknessCount"))
				else
					timerExtinguishCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "extinguish", "extinguishCount"))
				end
			elseif timer == 119 then--Raw 119 is shared; Voidswarm also has 118.999. Alternate in ADDED order.
				storyHundredNineteenCount = storyHundredNineteenCount + 1
				if storyHundredNineteenCount % 2 == 1 then
					timerVoidswarmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidswarm", "voidswarmCount"))
				else
					timerSuffocatingDarknessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkness", "darknessCount"))
				end
			elseif not self:IsStory() and timer == 40 then
				timerUnspeakableHorrorsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "horrors", "horrorsCount"))
			elseif not self:IsStory() and (timer == 37 or timer == 82) then
				startScheduledEvent(self, timerUnspeakableHorrorsCD, timerExact, eventID, "horrors", "horrorsCount")
			elseif not self:IsStory() and timer == 67 then
				timerAbyssalGraspCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspCount"))
			elseif not self:IsStory() and (timer == 30 or timer == 89) then
				startScheduledEvent(self, timerAbyssalGraspCD, timerExact, eventID, "grasp", "graspCount")
			else
				return false
			end
		elseif self:GetStage(2) and not self:IsStory() then
			if timer == 3 then
				timerNullgateCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullGate", "nullGateCount"))
			elseif timer == 15 and self:IsNormal() then
				timerNegationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "negation", "negationCount"))
			elseif timer == 10 then--Normal opens with Negation; LFR has only premature-finished Null Gate recasts.
				stage2TenCount = stage2TenCount + 1
				if self:IsNormal() and stage2TenCount == 1 then
					timerNegationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "negation", "negationCount"))
				else
					startScheduledEvent(self, timerNullgateCD, timerExact, eventID, "nullGate", "nullGateCount")
				end
			elseif timer == 61 then
				timerEightfoldEclipseCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "eclipse", "eclipseCount"))
			else
				return false
			end
		else
			return false
		end
		return true
	end

	---@param self DBMMod
	local function timersHeroic(self, timer, timerExact, eventID)
		if timer == 3 and not self:GetStage(2) then--The first Null Gate identifies stage 2.
			addWindowActive = false
			resetScheduledEvents(self)
			self:Stop()
			self:TLCountReset()
			self:SetStage(2)
		end
		if self:GetStage(1) then
			if timer == 5 then
				timerVoidswarmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidswarm", "voidswarmCount"))
			elseif timer == 12 or timer == 15 or timer == 18 or timer == 32 then
				timerTwistedAppendageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "appendage", "appendageCount"))
			elseif timer == 20 or timer == 22 or timer == 69 then
				timerDarkDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			elseif timer == 57 then
				timerExtinguishCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "extinguish", "extinguishCount"))
			elseif timer == 37 then
				timerUnspeakableHorrorsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "horrors", "horrorsCount"))
			elseif timer == 33 or timer == 76 then
				startScheduledEvent(self, timerUnspeakableHorrorsCD, timerExact, eventID, "horrors", "horrorsCount")
			elseif timer == 62 then
				timerAbyssalGraspCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspCount"))
			elseif timer == 27 or timer == 82 then
				startScheduledEvent(self, timerAbyssalGraspCD, timerExact, eventID, "grasp", "graspCount")
			elseif timer == 40 then
				timerDivineRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "radiance", "radianceCount"))
			elseif timer == 29 then--Both abilities use raw 29: the opener is Extinguish, subsequent rows are Appendage.
				stage1TwentyNineCount = stage1TwentyNineCount + 1
				if stage1TwentyNineCount == 1 then
					timerExtinguishCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "extinguish", "extinguishCount"))
				else
					timerTwistedAppendageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "appendage", "appendageCount"))
				end
			elseif timer == 52 then--Both abilities use raw 52: initial Darkness, then Extinguish.
				stage1FiftyTwoCount = stage1FiftyTwoCount + 1
				if stage1FiftyTwoCount == 1 then
					timerSuffocatingDarknessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkness", "darknessCount"))
				else
					timerExtinguishCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "extinguish", "extinguishCount"))
				end
			elseif timer == 109 then--Voidswarm and Darkness share raw 109 (Darkness also 108.999); alternate in ADDED order.
				stage1HundredNineCount = stage1HundredNineCount + 1
				if stage1HundredNineCount % 2 == 1 then
					timerVoidswarmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidswarm", "voidswarmCount"))
				else
					timerSuffocatingDarknessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkness", "darknessCount"))
				end
			else
				return false
			end
		elseif self:GetStage(2) then
			if timer == 3 then
				timerNullgateCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullGate", "nullGateCount"))
			elseif timer == 15 then
				timerNegationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "negation", "negationCount"))
			elseif timer == 10 then--Identical raw 10: opening Negation, then immediately-finished Null Gate recasts.
				stage2TenCount = stage2TenCount + 1
				if stage2TenCount == 1 then
					timerNegationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "negation", "negationCount"))
				else
					startScheduledEvent(self, timerNullgateCD, timerExact, eventID, "nullGate", "nullGateCount")
				end
			elseif timer == 61 then
				timerEightfoldEclipseCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "eclipse", "eclipseCount"))
			else
				return false
			end
		else
			return false
		end
		return true
	end

	function mod:OnLimitedCombatStart()
		addWindowActive = false
		resetScheduledEvents(self)
		self:TLCountReset()
		self:SetStage(1)
		stage1TwentyNineCount = 0
		stage1FiftyTwoCount = 0
		stage1HundredNineCount = 0
		stage2TenCount = 0
		storyFortyFiveCount = 0
		storyFiftySevenCount = 0
		storyHundredNineteenCount = 0
		self.vb.horrorsCount = 1
		self.vb.devastationCount = 1
		self.vb.voidswarmCount = 1
		self.vb.darknessCount = 1
		self.vb.extinguishCount = 1
		self.vb.appendageCount = 1
		self.vb.graspCount = 1
		self.vb.radianceCount = 1
		self.vb.nullGateCount = 1
		self.vb.negationCount = 1
		self.vb.eclipseCount = 1
		--Story, LFR, Normal and Heroic have been verified against complete 12.1 Week9 pulls.
		if DBM.Options.HardcodedTimer and (self:IsStory() or self:IsLFR() or self:IsNormal() or self:IsHeroic()) and not badStateDetected then
			self:IgnoreBlizzardAPI()
			self:RegisterShortTermEvents(true,
				"ENCOUNTER_TIMELINE_EVENT_ADDED",
				"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
				"UNIT_SPELLCAST_START boss2 boss3 boss4",
				"UNIT_SPELLCAST_CHANNEL_START boss2 boss3 boss4"
			)
			setFallback(self, true)
		else
			setFallback(self)
		end
	end

	function mod:OnCombatEnd()
		addWindowActive = false
		resetScheduledEvents(self)
		self:TLCountReset()
		stage1TwentyNineCount = 0
		stage1FiftyTwoCount = 0
		stage1HundredNineCount = 0
		stage2TenCount = 0
		storyFortyFiveCount = 0
		storyFiftySevenCount = 0
		storyHundredNineteenCount = 0
		self:UnregisterShortTermEvents()
	end

	--Voidswarm completion arms these generic announcements; Darkness completion disarms them.
	--Boss slots can become eggs during the wave, so never infer an ability from the unit token.
	function mod:UNIT_SPELLCAST_START(unit, _, spellID)
		if not addWindowActive or not self.Options.warnAddCasts then return end
		local unitIsTarget = UnitIsUnit("target", unit)
		DBM:AddSecretGenericWarning(unit, spellID, nil, unitIsTarget)
	end

	mod.UNIT_SPELLCAST_CHANNEL_START = mod.UNIT_SPELLCAST_START

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		if scheduledEvents[eventID] then return end--Don't reserve a second count for a still-running bugged event.
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		local handled
		if self:IsStory() or self:IsLFR() or self:IsNormal() then
			handled = timersEasy(self, timer, timerExact, eventID)
		else
			handled = timersHeroic(self, timer, timerExact, eventID)
		end
		if not handled then
			hardcodeFailed(self)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		if not eventID then return end
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventState then return end
		if eventState == 2 then
			if scheduledEvents[eventID] then return end--Premature finish; raw duration is authoritative.
			finishTimelineEvent(self, eventID)
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			cancelScheduledEvent(self, eventID)
			--Phase 1 cancels its active rows together on transition. Already-finished
			--bugged rows never receive that cancel, so discard their schedules as well.
			if eventType and self:GetStage(1) then
				addWindowActive = false
				resetScheduledEvents(self)
			end
		end
	end
end
