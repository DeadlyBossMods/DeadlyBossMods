---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

private.hardCodedTimers = {
	--[eventID] = timerId
}

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
	if self.Options.IgnoreBlizzAPI then return end--Set by modules, not core options to filter blizz events for hard coded mods
	if self.Options.HideDBMWarnings then return end
	--Secrets
	local text = encounterWarningInfo.text
	local casterName = encounterWarningInfo.casterName
	local targetName = encounterWarningInfo.targetName
	local targetGUID = encounterWarningInfo.targetGUID
	local formattedTargetName = targetName
	if targetGUID then
		local _, className = GetPlayerInfoByGUID(targetGUID)
		if className then
			local classColor = C_ClassColor.GetClassColor(className)
			if classColor then
			    formattedTargetName = classColor:WrapTextInColorCode(formattedTargetName);
			end
		end
	end
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
--/run C_EncounterTimeline.AddEditModeEvents()
function DBM:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo, remaining)
	if self.Options.IgnoreBlizzAPI then return end--Set by modules, not core options to filter blizz events for hard coded mods
	local source = eventInfo.source--(0-Encounter, 1-Script, 2-EditMode)
	if self.Options.HideDBMBars then return end
	if self.Options.DontShowBossTimers and source == 0 then return end
	if self.Options.DontShowUserTimers and source == 1 then return end
	local eventID = eventInfo.id
	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local duration = remaining or eventInfo.duration
	local maxQueueDuration = eventInfo.maxQueueDuration
	--Secrets
	local spellId = eventInfo.spellID
	local spellName = eventInfo.spellName or C_Spell.GetSpellName(spellId)--Spell name associated with this event. For script events, this may instead be the contents of the 'overrideName' field if it wasn't empty."
	local iconId = eventInfo.iconFileID
	local color = eventInfo.color--Color table { r = 1, g = 1, b = 1 }
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
	self:Debug("ENCOUNTER_TIMELINE_EVENT_ADDED fired for spellID: "..tostring(spellId).." with spellName: "..tostring(spellName).." and duration: "..tostring(duration).." and state: "..tostring(eventState), 3)
end


--/run C_EncounterTimeline.HasActiveEvents()
--/run C_EncounterTimeline.GetEventList()
--/run C_EncounterTimeline.PauseScriptEvent()
--/run C_EncounterTimeline.ResumeScriptEvent()
--0 = Active, 1 = Paused, 2 = Finished, 3 = Canceled
function DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
	local bar
	--Check for and update hard coded bars
	if private.hardCodedTimers[eventID] then
		bar = DBT:GetBar(private.hardCodedTimers[eventID])
	else
		bar = DBT:GetBar(eventID)
	end
	if bar then
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if eventState == 1 then
			bar:Pause()
		elseif eventState == 0 then
			bar:Resume()
		else--Finished or cancled (sometimes blizzard sends state changed instead of event removed when canceling events)
			bar:Cancel()
			private.hardCodedTimers[eventID] = nil
		end
	end
end

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
