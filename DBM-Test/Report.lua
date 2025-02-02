---@class DBMTest
local test = DBM.Test

---@class TestReporter
local reporter = {}
local reporterMt = {__index = reporter}

---@param testData TestDefinition
---@param trace TestTrace
---@return TestReporter
function test:NewReporter(testData, trace)
	---@class TestReporter
	local obj = setmetatable({
		testData = testData,
		trace = trace,
		---@diagnostic disable-next-line: dbm-event-checker
		mod = DBM:GetModByName(testData.mod), ---@type DBMMod
		errors = {},
		taints = {},
		strayObjects = {}, -- Warning objects that didn't show up while loading but were triggered by the test
	}, reporterMt)
	return obj
end

-- Sorts warning objects by class/text/type
local function compareObjects(obj1, obj2)
	local class1, class2 = obj1.objClass, obj2.objClass
	local key1, key2 = obj1.spellId or obj1.text or obj1, obj2.spellId or obj2.text or obj2
	local type1, type2 = obj1.type or obj1.announceType or obj1.yellType or "unknown", obj2.type or obj2.announceType or obj2.yellType or "unknown"
	local creationOrder1, creationOrder2 = obj1.testCreationOrder or math.huge, obj2.testCreationOrder or math.huge
	if class1 ~= class2 then
		return class1 < class2
	elseif type(key1) ~= type(key2) then
		return type(key1) == "string"
	elseif key1 ~= key2 then
		return key1 < key2
	elseif type1 ~= type2 then
		return type1 < type2
	else
		return creationOrder1 < creationOrder2
	end
end

local function triggerDeltasPretty(times)
	if not times or #times == 0 then
		return ""
	end
	local res = {}
	local prev = 0
	for _, v in ipairs(times) do
		res[#res + 1] = ("%.2f"):format(v - prev)
		prev = v
	end
	return ", triggerDeltas = " .. table.concat(res, ", ")
end

function reporter:ObjectToString(obj, skipType, showTriggerTimes)
	if type(obj) == "string" then -- used for PlaySound from voice packs which doesn't have an object, this is a bit ugly
		local fileName = obj:match("Interface\\AddOns\\DBM%-VP[^\\]-\\(.-)%.ogg")
		return ("%sVoicePack/%s"):format(not skipType and "[PlaySound] " or "", fileName)
	end
	local spellId = type(obj.spellId) == "number" and obj.spellId > 50 and tostring(obj.spellId) or "<none>"
	if obj.objClass == "Timer" then
		-- FIXME: this should be fixed in timers, not here, can't see a good reason for the late evaluation of the localized text in timers whereas everything else can do it early
		local text = type(obj.text) == "string" and obj.text or obj.type and obj.mod:GetLocalizedTimerText(obj.type, obj.spellId, obj.name) or obj.name
		return ("%s%s, time=%.2f, type=%s, spellId=%s%s"):format(not skipType and "[Timer] " or "", text, obj.timer, obj.type, spellId, triggerDeltasPretty(showTriggerTimes))
	elseif obj.objClass == "Announce" then
		return ("%s%s, type=%s, spellId=%s%s"):format(not skipType and "[Announce] " or "", obj.text, tostring(obj.announceType), spellId, triggerDeltasPretty(showTriggerTimes))
	elseif obj.objClass == "SpecialWarning" then
		return ("%s%s, type=%s, spellId=%s%s"):format(not skipType and "[Special Warning] " or "", obj.text, tostring(obj.announceType), spellId, triggerDeltasPretty(showTriggerTimes))
	elseif obj.objClass == "Yell" then
		-- Handle localizations that insert the player's name *on loading*
		-- TODO: this will fail if you are testing with a character named like a spell...
		local text = obj.text:gsub(UnitName("player"), "PlayerName")
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Yell] " or "", text, tostring(obj.yellType), spellId)
	else
		return "<unknown object type>"
	end
end

function reporter:ObjectsToString(objs, skipType)
	for k, v in ipairs(objs) do
		objs[k] = self:ObjectToString(v, skipType)
	end
end

local function addSpellNames(str)
	str = tostring(str)
	return str:gsub("(%d+)", function(spellId)
		local name = spellId and spellId ~= "0" and DBM:GetSpellInfo(tonumber(spellId) or -1) or "Unknown spell"
		return spellId .. " (" .. name .. ")"
	end)
end

local function extractSpellId(rawEvent)
	local event, subEvent = unpack(rawEvent, 2)
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" or not (subEvent:match("^SPELL_") or subEvent:match("^RANGE_")) then
		return
	end
	return rawEvent[12]
end

function reporter:FindUntriggeredEvents(findings)
	-- TODO: validate the logic for UNIT_ events with params
	local registeredEvents = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			-- All events are eventually registered as "Regular"
			if v.event == "RegisterEvents" and v[1] == "Regular" then
				for i = 2, #v do
					local fullEvent = v[i]
					local event = fullEvent:match("^([%S]+)")
					if event:match("^UNIT_.*_UNFILTERED$") then
						event = event:gsub("_UNFILTERED$", "")
					end
					registeredEvents[event] = 0
					if event:match("^SPELL_") then
						local args = {select(2, (" "):split(fullEvent))}
						for _, arg in ipairs(args) do
							registeredEvents[event .. " " .. arg] = 0
						end
					end
				end
			end
			local triggerEvent = entry.rawTrigger[2]
			if registeredEvents[triggerEvent] then
				registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
			end
			if triggerEvent == "COMBAT_LOG_EVENT_UNFILTERED" then
				triggerEvent = entry.rawTrigger[3]
				if registeredEvents[triggerEvent] then
					registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
				end
				local spellId = extractSpellId(entry.rawTrigger)
				if spellId then
					triggerEvent = triggerEvent .. " " .. spellId
					if registeredEvents[triggerEvent] then
						registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
					end
				end
			end
		end
	end
	-- if an args event went unused (e.g., FOO 123) then mark the main event (FOO) as used to not report it twice
	for fullEvent, count in pairs(registeredEvents) do
		if count == 0 then
			local event = fullEvent:match("^([%S]+) ")
			if event then
				registeredEvents[event] = 1
			end
		end
	end
	for event, count in pairs(registeredEvents) do
		if count == 0 then
			findings[#findings + 1] = {type = "untriggered-event", event = event, sortKey = 1, extraSortKey = event, text = "Unused event registration: " .. addSpellNames(event)}
		end
	end
end

function reporter:FindSpellIdMismatches(findings)
	for _, trigger in ipairs(self.trace) do
		local triggerSpellId = extractSpellId(trigger.rawTrigger)
		local triggerEvent = trigger.rawTrigger[3]
		if triggerSpellId and triggerEvent then
			for _, v in ipairs(trigger.traces) do
				-- Just checks starts/shows, stopping/Unscheduling etc on other spell IDs is common and okay (e.g., phase changes)
				-- TODO: handle schedules
				if v.event == "StartTimer" or v.event == "ShowAnnounce" or v.event == "ShowSpecialWarning" or v.event == "ShowYell" then
					local obj = v[1]
					-- spellId field is sometimes used for non-spellId things like phases/stages
					if type(obj.spellId) == "number" and obj.spellId > 50 and obj.spellId ~= triggerSpellId then
						findings[#findings + 1] = {
							type = "spell-mismatch", spellId = obj.spellId, triggerSpellId = triggerSpellId, sortKey = 2,
							text = ("%s for spell ID %s is triggered by event %s %s"):format(obj.objClass, addSpellNames(obj.spellId), triggerEvent, addSpellNames(triggerSpellId))
						}
					end
				end
			end
		end
	end
end

function reporter:FindPreciseShowsThatAlwaysFailed(findings)
	local objs = self:FindObjects()
	for _, obj in ipairs(objs) do
		if obj.testUsedWithPreciseShow then
			for maxTotal in pairs(obj.testUsedWithPreciseShow) do
				if not obj.testUsedWithPreciseShowSucess[maxTotal] then
					findings[#findings + 1] = {
						type = "precise-show-always-failed", spellId = obj.spellId, sortKey = 3, extraSortKey = maxTotal,
						text = ("%s uses PreciseShow(%d) but never gets %d targets"):format(self:ObjectToString(obj), maxTotal, maxTotal)
					}
				end
			end
		end
	end
end

function reporter:FindWipeDetectionFailure(findings)
	if self.inCombatAfterTest then
		findings[#findings + 1] = {
			type = "combat-didnt-end", sortKey = 4,
			text = ("DBM still reported a mod in combat %.1f seconds after log playback"):format(self.inCombatAfterTest)
		}
	end
end

function reporter:FindEarlyTimerRefreshes(findings)
	for _, trigger in ipairs(self.trace) do
		for _, trace in ipairs(trigger.traces) do
			if trace.event == "EarlyTimerRefresh" then
				local timer, remaining, totalTime, variance = unpack(trace)
				findings[#findings + 1] = {
					type = "early-timer-refresh", sortKey = 5,
					text = ("Timer %s (time=%.2f, variance=%.2f) got refreshed early with %.2fs remaining\n\t\tRefreshed by: %s"):format(self:ObjectToString(timer, true), totalTime, variance or 0, remaining, trigger.trigger)
				}
			end
		end
	end
end

function reporter:ReportFindings()
	local findings = {}
	self:FindUntriggeredEvents(findings)
	self:FindSpellIdMismatches(findings)
	self:FindPreciseShowsThatAlwaysFailed(findings)
	self:FindWipeDetectionFailure(findings)
	self:FindEarlyTimerRefreshes(findings)
	local dedup = {}
	for _, v in ipairs(findings) do
		dedup[v.text] = v
	end
	table.wipe(findings)
	for _, v in pairs(dedup) do
		findings[#findings + 1] = v
	end
	-- Make order more deterministic
	table.sort(findings, function(e1, e2)
		if e1.sortKey ~= e2.sortKey then
			return e1.sortKey < e2.sortKey
		elseif e1.spellId ~= e2.spellId then
			if type(e1.spellId) ~= type(e2.spellId) then
				return type(e1.spellId) < type(e2.spellId)
			else
				return e1.spellId < e2.spellId
			end
		elseif e1.extraSortKey ~= e2.extraSortKey then
			return e1.extraSortKey < e2.extraSortKey
		else
			return e1.text < e2.text
		end
	end)
	if #findings > 0 then
		for i, v in ipairs(findings) do
			findings[i] = v.text or v.type or "Unknown"
		end
		return "\t" .. table.concat(findings, "\n\t")
	else
		return "\tNone"
	end
end

function reporter:FindObjects()
	if self.cachedObjects then
		return self.cachedObjects
	end
	local seenObjs = {}
	local objs = {}
	-- Objects we saw during loading
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			if v.mod == self.mod and (v.event == "NewTimer" or v.event == "NewAnnounce" or v.event == "NewSpecialWarning" or v.event == "NewYell") then
				local obj = v[1]
				objs[#objs + 1] = obj
				seenObjs[obj] = true
			end
		end
	end
	local function gatherObjects(list)
		for _, obj in ipairs(list) do
			if not seenObjs[obj] then
				objs[#objs + 1] = obj
				seenObjs[obj] = true
			end
		end
	end
	-- Objects the mod defines, these should be identical to what we already saw above if the mod was loaded properly
	gatherObjects(self.mod.timers)
	gatherObjects(self.mod.announces)
	gatherObjects(self.mod.specwarns)
	gatherObjects(self.mod.yells)
	-- Objects we saw during test execution but not during test load, if there is anything new here then a second mod triggered
	gatherObjects(self.strayObjects) -- TODO: We might want to tag these in the report, because we usually don't want that (but I do have some interesting multi-encounter pull logs)
	table.sort(objs, compareObjects)
	self.cachedObjects = objs
	return objs
end

function reporter:ReportUnusedObjects()
	local objs = self:FindObjects()
	local unusedObjects = {}
	for _, v in ipairs(objs) do
		if not v.testUseCount or v.testUseCount == 0 then
			unusedObjects[#unusedObjects + 1] = v
		end
	end
	self:ObjectsToString(unusedObjects)
	if #unusedObjects > 0 then
		return "\t" .. table.concat(unusedObjects, "\n\t")
	else
		return "\tNone"
	end
end

-- Group similar events for deduplication of events
local function getDeduplicationKey(trigger)
	-- group SPELL_AURA_APPLIED_DOSE
	-- FIXME: rather ugly and doesn't support everything, we should also group non-DOSE and DOSE, DAMAGE and MISSED, REFRESH etc but we need some way to report that both events happened
	if trigger:match("^SPELL_AURA_APPLIED_DOSE") then
		trigger = trigger:gsub(", (%d+), (%d+)$", "")
	end
	-- group different NPCs with same cID
	trigger = trigger:gsub("(Creature%-%d+%-%d+%-%d+%-%d+%-%d+)%-%x+", "%1")
	trigger = trigger:gsub("(Vehicle%-%d+%-%d+%-%d+%-%d+%-%d+)%-%x+", "%1")
	return trigger
end

local function condenseTriggers(triggers)
	local result = {}
	local ids = {}
	local lastTimestamp = {}
	for _, trigger in ipairs(triggers) do
		-- FIXME: should use some other type here, but both trigger and rawTrigger are kinda ugly at the moment
		local timestamp, id = trigger:match("^%[%s*(%d*%.%d*)%] (.*)")
		timestamp = tonumber(timestamp)
		if not timestamp or not id then -- Schedule() currently triggers an unknown source without a timestamp
			result[#result + 1] = {firstTrigger = trigger, repeated = {}}
		else
			id = getDeduplicationKey(id)
			local entries = ids[id] or {}
			ids[id] = entries
			entries[#entries + 1] = lastTimestamp[id] and timestamp - lastTimestamp[id] or timestamp
			lastTimestamp[id] = timestamp
			if #entries == 1 then
				result[#result + 1] = {firstTrigger = trigger, repeated = entries}
			end
		end
	end
	return result
end

function reporter:ReportWarningObject(...)
	local eventNames = {}
	local filtersFunctions = {}
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if type(arg) == "function" then
			filtersFunctions[#filtersFunctions + 1] = arg
		else
			eventNames[arg] = true
		end
	end
	local showEvent = ...
	local objs = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			if eventNames[v.event] then
				local filterExcluded = false
				for _, f in ipairs(filtersFunctions) do
					filterExcluded = filterExcluded or f(v, entry)
				end
				if not filterExcluded then
					local obj = v[1]
					local entries = objs[obj] or {showTriggerTimes = {}}
					objs[obj] = entries
					-- Don't report the same trigger twice if it runs multiple actions on an object (e.g., timer restart)
					if entry.trigger ~= entries[#entries] then
						entries[#entries + 1] = entry.trigger
					end
					if v.event == showEvent then -- ShowAnnounce/StartTimer etc
						entries.showTriggerTimes[#entries.showTriggerTimes + 1] = entry.rawTrigger[1]
					end
				end
			end
		end
	end
	local sortedObjs = {}
	for k, v in pairs(objs) do
		sortedObjs[#sortedObjs + 1] = {obj = k, triggers = condenseTriggers(v), showTriggerTimes = v.showTriggerTimes}
	end
	table.sort(sortedObjs, function(e1, e2)
		return compareObjects(e1.obj, e2.obj)
	end)
	local result = ""
	for _, v in ipairs(sortedObjs) do
		result = result .. "\t" .. self:ObjectToString(v.obj, true, v.showTriggerTimes) .. "\n"
		for _, trigger in ipairs(v.triggers) do
			result = result .. "\t\t" .. trigger.firstTrigger .. "\n"
			if #trigger.repeated > 1 then
				-- avoid stupid floating point things like 98.84 - 98.44 showing up as 0.40000000000001
				local deltas = {}
				for i, delta in ipairs(trigger.repeated) do
					deltas[i] = ("%.2f"):format(delta)
				end
				result = result .. "\t\t\t Triggered " .. #trigger.repeated .. "x, delta times: " .. table.concat(deltas, ", ") .. "\n"
			end
		end
	end
	if result == "" then
		result = "\tNone"
	end
	return result:gsub("\n$", "")
end

function reporter:ReportIcons()
	-- FIXME: support grouping, something like the eggs in Gnomeregan/Menagerie are a good example
	-- FIXME: lots of duplication vs. ReportWarningObject, could these be merged?
	local icons = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			if v.event == "ScanForMobs" then
				local scanId, iconSetMethod, mobIcon = unpack(v)
				icons[#icons + 1] = {
					scanId = scanId, iconSetMethod = iconSetMethod, mobIcon = mobIcon,
					triggers = {{firstTrigger = entry.trigger}}
				}
			end
		end
	end
	table.sort(icons, function(e1, e2)
		if e1.mobIcon and e2.mobIcon and e1.mobIcon ~= e2.mobIcon then
			return e1.mobIcon < e2.mobIcon
		else
			return e1.scanId < e2.scanId
		end
	end)
	local result = ""
	for _, v in ipairs(icons) do
		result = result .. ("\tIcon %s, target=%s, scanMethod=%s\n"):format(tostringall(v.mobIcon, v.scanId, v.iconScanMethod))
		for _, trigger in ipairs(v.triggers) do
			result = result .. "\t\t" .. trigger.firstTrigger .. "\n"
		end
	end
	if result == "" then
		result = "\tNone"
	end
	return result:gsub("\n$", "")
end

local function stripMarkup(text)
	if type(text) ~= "string" then
		return text
	end
	text = text:gsub("|r", "")
	text = text:gsub("|c%x%x%x%x%x%x%x%x", "")
	-- TODO: fully stripping texture for now, but for some things it may be useful to show it
	text = text:gsub("|T[^|]-|t", "")
	text = text:gsub("|H[^|]-|h", "")
	text = text:gsub("|h", "")
	text = text:gsub("\t", "\\t")
	text = text:gsub("\n", "\\n")
	text = text:gsub("\r", "\\r")
	return text:trim()
end

---@param event TraceEntryEvent
function reporter:EventToStringForReport(event, indent, subIndent)
	local result = {}
	local extraLines = {}
	if event.event == "ScheduleTask" then
		local funcName = event.scheduleData.funcName or "(anonymous function)"
		result[#result + 1] = ("%s at %.2f (+%.2f)"):format(funcName, event.scheduleData.time, event.scheduleData.delta)
	elseif event.event == "UnscheduleTask" then
		local unscheduledTask = event.scheduleData.unscheduledTask
		if unscheduledTask then
			local funcName = unscheduledTask.scheduledBy.scheduleData.funcName or "(anonymous function)"
			result[#result + 1] = ("%s scheduled by %s at %s"):format(funcName, unscheduledTask.scheduledBy.event, unscheduledTask.rawTrigger and ("%.02f"):format(unscheduledTask.rawTrigger[1]) or "<unknown>")
		else
			result[#result + 1] = "(unknown function)" -- can't happen
		end
	else
		for paramId, v in ipairs(event) do
			-- TODO: is this a good place to filter/simplify colors/textures etc?
			v = stripMarkup(v)
			if event.event == "PlaySound" then
				-- Make voice packs show up as VoicePack/<id>
				if type(v) == "string" and v:match("^Interface\\AddOns\\DBM%-VP") then
					v = "VoicePack/" .. v:match("Interface\\AddOns\\DBM%-VP[^\\]-\\(.-)%.ogg")
				-- Make core sounds show up as DBM/<file>
				elseif type(v) == "string" and v:match("^Interface\\AddOns\\DBM-Core\\sounds\\") then
					v = "DBM/" .. v:gsub("Interface\\AddOns\\DBM-Core\\sounds\\", ""):gsub("\\", "/"):gsub("%.ogg$", "")
				-- Special warnings with the non-default "1" sound show up as DBM/SpecialWarningSound1
				-- (Sound 1 is filtered)
				else
					for i = 2, 5 do
						if v == DBM.Options["SpecialWarningSound" .. i] then
							v = "DBM/SpecialWarningSound" .. i
							break
						end
					end
				end
			end
			if type(v) ~= "table" then
				if event.event == "StartTimer" and type(v) == "number" then
					-- StartTimer can have a dynamic arg, so round to one .1 second precision to avoid flakes
					result[#result + 1] = ("%.1f"):format(v)
				else
					if (event.event == "ShowAnnounce" or event.event == "ShowYell" or event.event == "ShowSpecialWarning") and paramId == 2 then
						-- These sometimes include the player name, either from UnitName("player") or from the name/guid translation from the test runner
						-- FIXME: these can fail if your character name matches a spell name
						if v == UnitName("player") then
							v = "PlayerName"
						elseif v:match(" on .*" .. UnitName("player")) then
							v = v:gsub(UnitName("player"), "PlayerName")
						end
					elseif event.event == "ModTrace" then
						if v == UnitName("player") then -- FIXME: we might need an explicit way to tag player names in custom traces
							v = "PlayerName"
						elseif v == UnitGUID("player") then
							v = "FIXME: leaking player GUID: " .. v
						end
					end
					result[#result + 1] = tostring(v)
				end
			end -- TODO: would it be useful to have a short string representation of the object instead of dropping it?
		end
	end
	if event.event == "AntiSpam" then
		local targetName = event[2]
		result[#result] = nil -- filter bool result
		result[#result] = nil -- filter target name as it's already part of the ID
		if targetName and targetName == UnitName("player") then -- May refer to the player due to combat log rewriting
			-- id is "<id> on <targetName>" if targetName is specified
			result[#result] = result[#result]:gsub("on " .. UnitName("player") .. "$", "on PlayerName")
		end
		local filteredSpams = {}
		if event.filteredAntiSpams and #event.filteredAntiSpams > 0 then
			for _, v in ipairs(event.filteredAntiSpams) do
				local ts, filteredEvent, arg1 = unpack(v.rawTrigger)
				if filteredEvent == "COMBAT_LOG_EVENT_UNFILTERED" then
					filteredEvent = arg1
				end
				filteredSpams[filteredEvent] = filteredSpams[filteredEvent] or {}
				table.insert(filteredSpams[filteredEvent], ts)
			end
		end
		for k, v in pairs(filteredSpams) do
			filteredSpams[#filteredSpams + 1] = {event = k, ts = v}
		end
		table.sort(filteredSpams, function(e1, e2) return #e1.ts < #e2.ts end)
		if #filteredSpams > 0 then
			for _, filtered in ipairs(filteredSpams) do
				extraLines[#extraLines + 1] = "Filtered: " .. #filtered.ts .. "x " .. filtered.event .. " at " .. table.concat(filtered.ts, ", ")
			end
		end
	end
	if event.event == "ScheduleTask" then
		if event.scheduleData.unscheduledBy then
			local unscheduleEvent = event.scheduleData.unscheduledBy[2]
			if unscheduleEvent == "COMBAT_LOG_EVENT_UNFILTERED" then
				unscheduleEvent = event.scheduleData.unscheduledBy[3]
			end
			extraLines[#extraLines + 1] = "Unscheduled by " .. unscheduleEvent .. " at " .. ("%.2f"):format(event.scheduleData.unscheduledBy[1])
		end
		if event.scheduleData.scheduleExecution then
			for _, v in ipairs(event.scheduleData.scheduleExecution.traces) do
				if not self:FilterTraceEntry(v, event.scheduleData.scheduleExecution) then
					extraLines[#extraLines + 1] = self:EventToStringForReport(v, 0, math.max((subIndent or 1) - 1, indent) + 2)
				end
			end
		end
	end
	local str = event.event .. ": " .. table.concat(result, ", ")
	if #extraLines > 0 then
		return ("\t"):rep(indent) .. str .. "\n" .. ("\t"):rep(indent + (subIndent or 1)) .. table.concat(extraLines, "\n" .. ("\t"):rep(indent + (subIndent or 1)))
	else
		return ("\t"):rep(indent) .. str
	end
end

local genericWarningSounds = {
	[DBM.Options.RaidWarningSound] = true,
	[DBM.Options.SpecialWarningSound] = true,
}

---@param entry TraceEntryEvent
---@param trigger TraceEntry
function reporter:FilterTraceEntry(entry, trigger)
	if entry.hidden then
		return true
	end
	if entry.event == "UnregisterEvents" or entry.event == "RegisterEvents" then
		if entry.mod ~= self.mod then
			return true
		end
		-- InCombat events show up during load and on start, filter the first one
		if entry.event == "RegisterEvents" and entry[1] == "InCombat" and trigger.rawTrigger[2] == "ADDON_LOADED" then
			return true
		end
	end
	-- Internal usage of AntiSpam
	if entry.event == "AntiSpam" and entry.mod == DBM then
		return true
	end
	-- AntiSpams returned false, they are summarized in the previous true event
	if entry.event == "AntiSpam" and not entry[3] then
		return true
	end
	-- Generic warning sounds
	if entry.event == "PlaySound" and genericWarningSounds[entry[1]] then
		return true
	end
	-- Avoid spam during encounter end
	if trigger.didTriggerCombatEnd then
		if entry.event == "UnregisterEvents" or entry.event == "StopTimer" then
			return true
		end
	end
	-- Schedule-related events are only in here for backtracking and are shown with the corresponding ScheduleTask method
	if entry.event == "ExecuteScheduledTaskPre" or entry.event == "ExecuteScheduledTaskPost" or entry.event == "SchedulerHideFromTraceIfUnscheduled" then
		return true
	end
	return entry.event:match("^New")
end

function reporter:ReportEventTrace()
	local result = ""
	for _, entry in ipairs(self.trace) do
		local traces = {}
		-- Task executions are reported at the point they are scheduled, don't report them at the top level
		if entry.rawTrigger[2] ~= "ExecuteScheduledTask" then
			for _, v in ipairs(entry.traces) do
				if not self:FilterTraceEntry(v, entry) then
					traces[#traces + 1] = self:EventToStringForReport(v, 2)
				end
			end
		end
		if #traces > 0 then
			result = result .. "\t" .. entry.trigger .. "\n" .. table.concat(traces, "\n") .. "\n"
		end
	end
	return result:gsub("\n$", "")
end

function reporter:ReportWithHeader()
	return "DBM.Test:Report[[\n" .. self:Report() .. "]]\n"
end

local function filterEncounterEnd(_, trigger)
	return trigger.didTriggerCombatEnd
end

local function filterNonVoicepack(entry)
	local file = tostring(entry[1])
	return not file:match("^Interface\\AddOns\\DBM%-VP")
end

function reporter:Report(forceRefresh)
	if self.cachedReport and not forceRefresh then
		return self.cachedReport
	end
	local reportFormat = [[
Test: %s
Mod:  %s/%s

Findings:
%s

Unused objects:
%s

Timers:
%s

Announces:
%s

Special warnings:
%s

Yells:
%s

Voice pack sounds:
%s

Icons:
%s

Event trace:
%s
]]
	self.cachedReport = reportFormat:format(
		self.testData.name,
		self.testData.addon, self.testData.mod,
		self:ReportFindings(),
		self:ReportUnusedObjects(),
		self:ReportWarningObject("StartTimer", "StopTimer", "UpdateTimer", "PauseTimer", "ResumeTimer", filterEncounterEnd),
		self:ReportWarningObject("ShowAnnounce"),
		self:ReportWarningObject("ShowSpecialWarning"),
		self:ReportWarningObject("ShowYell"),
		self:ReportWarningObject("PlaySound", filterNonVoicepack),
		self:ReportIcons(),
		self:ReportEventTrace()
	)
	return self:Report()
end

function reporter:HasDiff()
	DBM:Debug("called deprecated DBM.Test:HasDiff()")
	return false
end

function reporter:ReportDiff()
	local expected = test.Registry.expectedResults[self.testData.name]
	local msg = ("Test report for %s (mod %s) got unexpected diff. "):format(self.testData.name, self.testData.mod)
	if not expected then
		msg = msg .. "No golden test report available, please update golden data."
	else
		local firstDiff, lastNewLine = 0, 0
		-- \t doesn't work in WoW
		local want = expected:trim():gsub("\t", "  ")
		local got = self:Report():trim():gsub("\t", "  ")
		for i = 1, math.min(#want, #got) do
			if want:sub(i, i) == "\n" then
				lastNewLine = i
			end
			if want:byte(i, i) ~= got:byte(i, i) then
				firstDiff = i
				break
			end
		end
		local diffWant = want:sub(math.max(firstDiff - 100, lastNewLine + 1), math.min(want:find("\n", firstDiff + 1) or #want, firstDiff + 50) - 1)
		local diffGot = got:sub(math.max(firstDiff - 100, lastNewLine + 1), math.min(got:find("\n", firstDiff + 1) or #got, firstDiff + 50) - 1)
		local lastCommon = want:sub(math.max(firstDiff - 10, lastNewLine + 1), math.max(firstDiff - 1, 0))
		local diffAfter = ""
		if not lastCommon:match("^%s*$") then
			diffAfter = "\ndiff after: " .. lastCommon
		end
		msg = msg .. ("\nUpdate golden if this diff is expected, first diff:\n%s (want)\n%s (got)%s"):format(
			diffWant, diffGot, diffAfter
		)
	end
	DBM:ShowUpdateReminder(nil, nil, msg, self:ReportWithHeader(), 300, "LEFT")
end

function reporter:ShowReport()
	test:ShowTestReportFrame(self:Report())
end

---@alias TestResultEnum "Success"|"Failure"
---@return TestResultEnum
function reporter:GetResult()
	return not self:HasErrors() and "Success" or "Failure"
end

function reporter:HasErrors()
	return #self.errors > 0
end

local realErrorHandler
local ourErrorHandlers = setmetatable({}, {__mode = "k"})

function reporter:GetRealErrorHandler()
	local errorHandler = geterrorhandler()
	if ourErrorHandlers[errorHandler] then
		-- handle the case when you click on report errors while another test is running
		errorHandler = realErrorHandler or HandleLuaError
	end
	return errorHandler
end

function reporter:ReportErrors()
	local errorHandler = self:GetRealErrorHandler()
	for _, err in ipairs(self.errors) do
		errorHandler(err)
	end
end

function reporter:SetupErrorHandler(passthroughErrors)
	self.oldErrorHandler = geterrorhandler()
	realErrorHandler = self.oldErrorHandler
	local errorHandler = function(err)
		self.errors[#self.errors + 1] = err
		if passthroughErrors then
			realErrorHandler(err)
		end
	end
	ourErrorHandlers[errorHandler] = true
	seterrorhandler(errorHandler)
end

function reporter:UnsetErrorHandler()
	if self.oldErrorHandler then
		seterrorhandler(self.oldErrorHandler)
		self.oldErrorHandler = nil
	end
end

function reporter:FlagCombat(waitedFor)
	self.inCombatAfterTest = waitedFor
end

---@alias DBMTestTaintType "Lang"|"ModEnv"|"DBMOptions"|"ModOptions"|"Perspective"|"StrayObjects"|"Playground"

---@type table<DBMTestTaintType, string>
local taintDescriptions = {
	Lang = "Running on an %s client, golden test reports are created with English clients",
	ModEnv = "Mod was not loaded with full test support enabled, global hooks in mods are disabled",
	DBMOptions = "Running with DBM options set to something other than the test defaults",
	ModOptions = "Running with mod options set to something other than the test defaults",
	Perspective = "Test specifies player %s, but running as player %s",
	StrayObjects = "Encountered stray warning objects during test run, an unexpected mod might have been triggered or mod was loaded without full test support",
	Playground = "Test was started in playground mode"
}

---@param taintType DBMTestTaintType
function reporter:Taint(taintType, ...)
	self.taints[#self.taints + 1] = {type = taintType, description = taintDescriptions[taintType]:format(...)}
end

function reporter:IsTainted()
	return #self.taints > 0
end
