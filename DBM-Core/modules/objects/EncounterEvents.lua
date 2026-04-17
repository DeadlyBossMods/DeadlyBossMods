---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

private.hardCodedTimers = {
	--[eventID] = {timerId1, timerId2, ...}
}
private.hardCodedTimerEvents = private.hardCodedTimerEvents or {}
private.buggedBlizzardTimers = private.buggedBlizzardTimers or {}

--{ Name = "text", Type = "cstring", Nilable = false, SecretValue = true },
--{ Name = "casterGUID", Type = "WOWGUID", Nilable = false, SecretValue = true },
--{ Name = "casterName", Type = "cstring", Nilable = false, SecretValue = true },
--{ Name = "targetGUID", Type = "WOWGUID", Nilable = false, SecretValue = true },
--{ Name = "targetName", Type = "cstring", Nilable = false, SecretValue = true },
--{ Name = "iconFileID", Type = "number", Nilable = false, SecretValue = true },
--{ Name = "tooltipSpellID", Type = "number", Nilable = false, SecretValue = true },
--{ Name = "isDeadly", Type = "bool", Nilable = false, SecretValue = true },
--{ Name = "duration", Type = "DurationSeconds", Nilable = false },
--{ Name = "severity", Type = "EncounterEventSeverity", Nilable = false },
--{ Name = "shouldPlaySound", Type = "bool", Nilable = false },
--{ Name = "shouldShowChatMessage", Type = "bool", Nilable = false },
--{ Name = "shouldShowWarning", Type = "bool", Nilable = false },
function DBM:ENCOUNTER_WARNING(encounterWarningInfo)
	--Secrets
	local text = encounterWarningInfo.text
	local casterName = encounterWarningInfo.casterName
	local targetName = encounterWarningInfo.targetName
	local targetGUID = encounterWarningInfo.targetGUID
	local formattedTargetName = targetName
	local tooltipSpellID = encounterWarningInfo.tooltipSpellID
	if targetGUID then
		local _, className = GetPlayerInfoByGUID(targetGUID)
		if className then
			local classColor = C_ClassColor.GetClassColor(className)
			if classColor then
			    formattedTargetName = classColor:WrapTextInColorCode(formattedTargetName);
			end
		end
		if tooltipSpellID then
			self:Debug("|cffff4000ENCOUNTER_WARNING: |r fired for text: "..text.." with casterName: "..casterName.." and spellId: "..tooltipSpellID.." and targetName: "..formattedTargetName.." and targetGUID: "..targetGUID, 2, nil, nil, true)
		else
			self:Debug("|cffff4000ENCOUNTER_WARNING: |r fired for text: "..text.." with casterName: "..casterName.." and targetName: "..formattedTargetName.." and targetGUID: "..targetGUID, 2, nil, nil, true)
		end
	else
		if tooltipSpellID then
			self:Debug("|cffff4000ENCOUNTER_WARNING: |r fired for text: "..text.." with casterName: "..casterName.." and spellId: "..tooltipSpellID, 2, nil, nil, true)
		else
			self:Debug("|cffff4000ENCOUNTER_WARNING: |r fired for text: "..text.." with casterName: "..casterName, 2, nil, nil, true)
		end
	end
	if not self:AntiSpam(0.5, "ENCOUNTER_WARNING") then return end--Designers can't be assed to make sure event isn't buggy and spammy so we're forced to hard throttle
	if self.Options.IgnoreBlizzAPI and self.Options.DebugLevel ~= 3 then
		--Special cases where blizz warning is only warning possible (ie spell doesn't have timeline event)
		--For these, we have mod allow next warning through as a one time exception
		if self.Options.BlizzAPIAllowOnce then
			self.Options.BlizzAPIAllowOnce = false
		else
			return
		end
	end--Set by modules, not core options to filter blizz events for hard coded mods
	if self.Options.HideDBMWarnings then return end
	local iconFileID = encounterWarningInfo.iconFileID
	--Non secrets
	local severity = encounterWarningInfo.severity--0 low, 1 medium, 2 critical
	local formatedText = string.format(text, casterName, formattedTargetName)
	if severity == 0 then
		--Use normal warning for low severity, but we call it here to avoid duplicate event registration
		self:AddWarning(formatedText, nil, nil, self.Options.DisableSWSound and false or true, nil, nil, iconFileID)
	else
		self:AddSpecialWarning(formatedText, nil, nil, severity == 1 and 1 or 2, iconFileID)
	end
end

--TODO, Fire callbacks instead and then have modules with their own checkbox determine if timers should start or not per boss level if blizzard ever provides spellIds/names
--IE each boss will have a checkbox to enable/disable timers for that specific boss
--TODO, make sure DBM core can track timers in startedTimers table?
--TODO, re-enable icon when blizzard unfucks SetTexture
--TODO, use EncounterTimelineIconMasks to get icon mask from
--NOTE, passthroughEvent is not a real event, just one we can inject when called externally, we underscores to reserve in case blizz actually adds new args
--/run C_EncounterTimeline.AddEditModeEvents()
function DBM:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo, remaining)
	local eventID = eventInfo.id
	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local duration = remaining or eventInfo.duration
	local durationRounded = math.floor(duration + 0.5)
	local maxQueueDuration = eventInfo.maxQueueDuration
	--Secrets
	local spellId = eventInfo.spellID
	local spellName = eventInfo.spellName or C_Spell.GetSpellName(spellId)--Spell name associated with this event. For script events, this may instead be the contents of the 'overrideName' field if it wasn't empty."
	local source = eventInfo.source--(0-Encounter, 1-Script, 2-EditMode)
	local iconId = eventInfo.iconFileID
	local color = eventInfo.color--Color table { r = 1, g = 1, b = 1 }
	self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_ADDED: |r fired for eventID: "..eventID.." with spellID: "..C_ColorUtil.WrapTextInColor(spellId, color).." with spellName: "..C_ColorUtil.WrapTextInColor(spellName, color).." and duration: "..C_ColorUtil.WrapTextInColor(tostring(duration).." (Rounded: "..tostring(durationRounded)..")", color).." and state: "..tostring(eventState), 3, nil, nil, true)
	if self.Options.HideDBMBars then return end
	if self.Options.DontShowBossTimers and source == 0 then return end
	if self.Options.DontShowUserTimers and source == 1 then return end
	if self.Options.IgnoreBlizzAPI and self.Options.DebugLevel ~= 3 then return end--Set by modules, not core options to filter blizz events for hard coded mods
	--Hacky workaround to de-white blizzard timers out of combat that do not have eventIds (such as test mode)
	if not DBT.Options.ColorByType or not self:hasanysecretvalues(color.r, color.g, color.b) then--Any color that's not secret should be safe to nil out since it's not an EncounterEvent timer
		color = nil
	end
--	local icons = eventInfo.icons
--	local severity = eventInfo.severity ("Normal", "Deadly")
--	local isApproximate = eventInfo.isApproximate

	--We want to store timer references for secret timers so we can stop them later
	--if not tContains(self.startedTimers, eventID) then--Make sure timer doesn't exist already before adding it
	--	tinsert(self.startedTimers, eventID)
	--end
	--self:Unschedule(removeEntry, self.startedTimers, eventID)
	--self:Schedule(duration, removeEntry, self.startedTimers, eventID)
	if DBT.Options.VarianceEnabled2 and maxQueueDuration and maxQueueDuration > 0 then--Currently not functional due to a bug where maxQueueDuration always returns 0 even if it's not
		DBT:CreateBar("v"..tostring(duration).."-"..tostring(maxQueueDuration+duration), eventID, iconId, nil, nil, color, nil, nil, nil, nil, nil, nil, nil, nil, spellName, true, eventState == 1)--barState 1 is "paused"
	else
		DBT:CreateBar(duration, eventID, iconId, nil, nil, color, nil, nil, nil, nil, nil, nil, nil, nil, spellName, true, eventState == 1)--barState 1 is "paused"
	end
end


--/run C_EncounterTimeline.HasActiveEvents()
--/run C_EncounterTimeline.GetEventList()
--/run C_EncounterTimeline.PauseScriptEvent()
--/run C_EncounterTimeline.ResumeScriptEvent()
--0 = Active, 1 = Paused, 2 = Finished, 3 = Canceled
function DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
	local hardcodedIds = private.hardCodedTimers[eventID]
	local ignoredEventID = private.buggedBlizzardTimers[eventID] or false
	local hardcodedTimerId
	local staleHardcodedEvent = false
	if type(hardcodedIds) == "table" then
		hardcodedTimerId = hardcodedIds[1]
	else
		hardcodedTimerId = hardcodedIds
	end
	local bar
	--Check for and update hard coded bars
	if hardcodedTimerId then
		local mappedEventID = private.hardCodedTimerEvents[hardcodedTimerId]
		if not ignoredEventID then
			if mappedEventID and mappedEventID ~= eventID then
				staleHardcodedEvent = true
			else
				bar = DBT:GetBar(hardcodedTimerId)
			end
		end
	else
		bar = DBT:GetBar(eventID)
	end
	local eventState = C_EncounterTimeline.GetEventState(eventID)
	if eventState == 1 then
		if bar then
			bar:Pause()
			if hardcodedTimerId then
				DBM:FireEvent("DBM_TimerPause", hardcodedTimerId)
			end
		elseif staleHardcodedEvent then
			self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED: |r ignoring stale pause for eventID: "..tostring(eventID).." (timerID now belongs to a newer event)", 3, nil, nil, DBM.Options.DebugLevel == 3)
		end
	elseif eventState == 0 then
		if bar then
			bar:Resume()
			if hardcodedTimerId then
				DBM:FireEvent("DBM_TimerResume", hardcodedTimerId)
			end
		elseif staleHardcodedEvent then
			self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED: |r ignoring stale resume for eventID: "..tostring(eventID).." (timerID now belongs to a newer event)", 3, nil, nil, DBM.Options.DebugLevel == 3)
		end
	else--Finished or canceled (sometimes blizzard sends state changed instead of event removed when canceling events)
		--Ignore Finished or canceled event for a bugged ID, since it's onen of blizzards early cancel bugs
		if ignoredEventID then
			self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED: |r ignoring cancel for eventID: "..tostring(eventID).." (timerID belongs to a known bugged Blizzard timer)", 2, nil, nil, DBM.Options.DebugLevel == 3)
			--Don't clear buggedBlizzardTimers here; the module's handler still needs to check IsBuggedEventID and will call UnsetBuggedEventID itself
		else
			if bar then
				bar:Cancel()
				if hardcodedTimerId then
					DBM:FireEvent("DBM_TimerStop", hardcodedTimerId)
				end
			elseif staleHardcodedEvent then
				self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED: |r ignoring stale cancel for eventID: "..tostring(eventID).." (timerID now belongs to a newer event)", 3, nil, nil, DBM.Options.DebugLevel == 3)
			end
			if hardcodedTimerId then
				if private.hardCodedTimerEvents[hardcodedTimerId] == eventID then
					private.hardCodedTimerEvents[hardcodedTimerId] = nil
				end
				if type(hardcodedIds) == "table" then
					table.remove(hardcodedIds, 1)
					if #hardcodedIds == 0 then
						private.hardCodedTimers[eventID] = nil
					end
				else
					private.hardCodedTimers[eventID] = nil
				end
				self:Debug("|cffffff00Hardcoded timer terminated for eventID: |r"..tostring(eventID).." (timerID: "..tostring(hardcodedTimerId)..")", 3, nil, nil, true)
			end
		end
	end
	self:Debug("|cffffff00ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED: |r fired for eventID: "..tostring(eventID).." with state: "..tostring(eventState), 3, nil, nil, true)
end

--[[
function DBM:ENCOUNTER_TIMELINE_EVENT_REMOVED(eventID)
	if private.hardCodedTimers[eventID] then
		local bar = DBT:GetBar(private.hardCodedTimers[eventID])
		if bar then
			bar:Cancel()
		end
		private.hardCodedTimers[eventID] = nil
	else
		DBT:CancelBar(eventID)
	end
end
--]]

--/run DBM:RecoverBlizzardTimers()
function DBM:RecoverBlizzardTimers()
	if self.Options.IgnoreBlizzAPI then return end--Set by modules, not core options to filter blizz events for hard coded mods
	if C_EncounterTimeline.HasActiveEvents() then
		local eventList = C_EncounterTimeline.GetEventList()
		for _, v in ipairs(eventList) do
			local eventInfo = C_EncounterTimeline.GetEventInfo(v)
			local remaining = C_EncounterTimeline.GetEventTimeRemaining(v)
			self:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo, remaining)
		end
	end
end

--/run DBM:GigaTimerTest(0, 5)
--/run DBM:GigaTimerTest(1, 0)
function DBM:GigaTimerTest(size, maxQueue)
	for i = 1, size == 2 and 60 or size == 1 and 30 or 15 do
		local duration = (10 * i)
		---@diagnostic disable-next-line: assign-type-mismatch
		C_EncounterTimeline.AddScriptEvent({duration = duration,spellID = 12345,overrideName = "Test Spell "..i,iconFileID = 237550,maxQueueDuration = maxQueue or 0})
	end
end
