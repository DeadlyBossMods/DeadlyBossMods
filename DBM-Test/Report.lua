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
		mod = DBM:GetModByName(testData.mod) ---@type DBMMod
	}, reporterMt)
	return obj
end

local function compareObjects(obj1, obj2)
	local class1, class2 = obj1.objClass, obj2.objClass
	local key1, key2 = obj1.spellId or obj1.text or obj1, obj2.spellId or obj2.text or obj2
	if class1 ~= class2 then
		return class1 < class2
	elseif type(key1) ~= type(key2) then
		return type(key1) == "string"
	else
		return key1 < key2
	end
end

local function objectToString(obj, skipType)
	if type(obj) == "string" then -- used for PlaySound from voice packs which doesn't have an object, this is a bit ugly
		local fileName = obj:match("Interface\\AddOns\\DBM%-VP[^\\]-\\(.-)%.ogg")
		return ("%sVoicePack/%s"):format(not skipType and "[PlaySound] " or "", fileName)
	end
	if obj.objClass == "Timer" then
		-- FIXME: this should be fixed in timers, not here, can't see a good reason for the late evaluation of the localized text in timers whereas everything else can do it early
		local text = obj.text or obj.type and obj.mod:GetLocalizedTimerText(obj.type, obj.spellId, obj.name) or obj.name
		return ("%s%s, time=%.2f, type=%s, spellId=%s"):format(not skipType and "[Timer] " or "", text, obj.timer, obj.type, tostring(obj.spellId))
	elseif obj.objClass == "Announce" then
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Announce] " or "", obj.text, tostring(obj.announceType), tostring(obj.spellId))
	elseif obj.objClass == "SpecialWarning" then
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Special Warning] " or "", obj.text, tostring(obj.announceType), tostring(obj.spellId))
	elseif obj.objClass == "Yell" then
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Yell] " or "", obj.text, tostring(obj.announceType), obj.yellType, tostring(obj.spellId))
	else
		return "<unknown object type>"
	end
end

local function objectsToString(objs, skipType)
	for k, v in ipairs(objs) do
		objs[k] = objectToString(v, skipType)
	end
end

function reporter:ReportUntriggeredEvents()
	-- TODO: validate the logic for UNIT_ events with params
	local registeredEvents = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
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
			if entry.rawTrigger then
				local triggerEvent = entry.rawTrigger[2]
				if registeredEvents[triggerEvent] then
					registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
				end
				if triggerEvent == "COMBAT_LOG_EVENT_UNFILTERED" then
					triggerEvent = entry.rawTrigger[3]
					if registeredEvents[triggerEvent] then
						registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
					end
					local spellId = triggerEvent:match("^SPELL_") and entry.rawTrigger[12]
					if spellId then
						triggerEvent = triggerEvent .. " " .. spellId
						if registeredEvents[triggerEvent] then
							registeredEvents[triggerEvent] = registeredEvents[triggerEvent] + 1
						end
					end
				end
			end
		end
	end
	local unusedEvents = {}
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
			unusedEvents[#unusedEvents + 1] = event
		end
	end
	table.sort(unusedEvents)
	if #unusedEvents > 0 then
		return "\t" .. table.concat(unusedEvents, "\n\t")
	else
		return "\tNone"
	end
end

-- FIXME: expand to generic warnings (but the word "warning" is overloaded here -- maybe "findings", "potential bugs", or "oddities"?)
function reporter:ReportUnusedObjects()
	local objs = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			if v.mod == self.mod and (v.event == "NewTimer" or v.event == "NewAnnounce" or v.event == "NewSpecialWarning" or v.event == "NewYell") then
				objs[#objs + 1] = v[1]
			end
		end
	end
	local unusedObjects = {}
	for _, v in ipairs(objs) do
		if not v.testUseCount or v.testUseCount == 0 then
			unusedObjects[#unusedObjects + 1] = v
		end
	end
	table.sort(unusedObjects, compareObjects)
	objectsToString(unusedObjects)
	if #unusedObjects > 0 then
		return "\t" .. table.concat(unusedObjects, "\n\t")
	else
		return "\tNone"
	end
end

local function condenseTriggers(triggers)
	local result = {}
	local ids = {}
	local lastTimestamp = {}
	for _, trigger in ipairs(triggers) do
		local timestamp, id = trigger:match("^%[%s*(%d*%.%d*)%] (.*)")
		timestamp = tonumber(timestamp)
		if not timestamp or not id then -- Schedule() current triggers an unknown source without a timestamp
			result[#result + 1] = {firstTrigger = trigger, repeated = {}}
		else
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
	local objs = {}
	for _, entry in ipairs(self.trace) do
		for _, v in ipairs(entry.traces) do
			if eventNames[v.event] then
				local filterExcluded = false
				for _, f in ipairs(filtersFunctions) do
					filterExcluded = filterExcluded or f(v, entry.trigger)
				end
				if not filterExcluded then
					local obj = v[1]
					local entries = objs[obj] or {}
					objs[obj] = entries
					entries[#entries + 1] = entry.trigger
				end
			end
		end
	end
	local sortedObjs = {}
	for k, v in pairs(objs) do
		sortedObjs[#sortedObjs + 1] = {obj = k, triggers = condenseTriggers(v)}
	end
	table.sort(sortedObjs, function(e1, e2)
		return compareObjects(e1.obj, e2.obj)
	end)
	local result = ""
	for _, v in ipairs(sortedObjs) do
		result = result .. "\t" .. objectToString(v.obj, true) .. "\n"
		for _, trigger in ipairs(v.triggers) do
			result = result .. "\t\t" .. trigger.firstTrigger .. "\n"
			if #trigger.repeated > 1 then
				result = result .. "\t\t\t Triggered " .. #trigger.repeated .. "x, delta times: " .. table.concat(trigger.repeated, ", ") .. "\n"
			end
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

local function eventToStringForReport(event)
	local result = {}
	for _, v in ipairs(event) do
		-- TODO: is this a good place to filter/simplify colors/textures etc?
		v = stripMarkup(v)
		if event.event == "PlaySound" and type(v) == "string" and v:match("^Interface\\AddOns\\DBM%-VP") then
			v = "VoicePack/" .. v:match("Interface\\AddOns\\DBM%-VP[^\\]-\\(.-)%.ogg")
		end
		if type(v) ~= "table" then
			result[#result + 1] = tostring(v)
		end -- TODO: would it be useful to have a short string representation of the object instead of dropping it?
	end
	return event.event .. ": " .. table.concat(result, ", ")
end

function reporter:FilterTraceEntry(entry, trigger)
	if entry.event == "UnregisterEvents" or entry.event == "RegisterEvents" then
		if entry.mod ~= self.mod then
			return true
		end
		-- InCombat events show up during load and on start, filter the first one
		if entry.event == "RegisterEvents" and entry[1] == "InCombat" and trigger:match("^%[[%d%.]+%] ADDON_LOADED: ") then
			return true
		end
	end
	-- Internal usage of AntiSpam
	if entry.event == "AntiSpam" then
		local id = entry[1]
		return id == "FLASH" or id == "EE"
	end
	-- Generic announce sound
	if entry.event == "PlaySound" and entry[1] == 566558 then
		return true
	end
	-- Avoid spam during encounter end
	if trigger:match("^%[[%d%.]+%] ENCOUNTER_END: ") then
		if entry.event == "UnregisterEvents" or entry.event == "StopTimer" then
			return true
		end
	end
	return entry.event:match("^New")
end

function reporter:ReportEventTrace()
	local result = ""
	for _, entry in ipairs(self.trace) do
		local traces = {}
		for _, v in ipairs(entry.traces) do
			if not self:FilterTraceEntry(v, entry.trigger) then
				traces[#traces + 1] = eventToStringForReport(v)
			end
		end
		if #traces > 0 then
			result = result .. "\t" .. entry.trigger .. "\n\t\t" .. table.concat(traces, "\n\t\t") .. "\n"
		end
	end
	return result:gsub("\n$", "")
end

function reporter:ReportWithHeader()
	return "DBM.Test:Report[[\n" .. self:Report() .. "]]\n"
end

local function filterEncounterEnd(_, trigger)
	return trigger:match("^%[[%d%.]+%] ENCOUNTER_END: ")
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

Registered but untriggered events:
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

Event trace:
%s
]]
	self.cachedReport = reportFormat:format(
		self.testData.name,
		self.testData.addon, self.testData.mod,
		self:ReportUntriggeredEvents(),
		self:ReportUnusedObjects(),
		self:ReportWarningObject("StartTimer", "StopTimer", "UpdateTimer", "PauseTimer", "ResumeTimer", filterEncounterEnd),
		self:ReportWarningObject("ShowAnnounce"),
		self:ReportWarningObject("ShowSpecialWarning"),
		self:ReportWarningObject("ShowYell"),
		self:ReportWarningObject("PlaySound", filterNonVoicepack),
		self:ReportEventTrace()
	)
	return self:Report()
end

function reporter:ReportDiff(expected)
	if not expected then
		geterrorhandler()("no golden test report available, please update golden data")
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
		geterrorhandler()(("test got unexpected result, please update golden if this diff is expected, first diff:\n%s (want)\n%s (got)\ndiff after: %s"):format(
			diffWant, diffGot, lastCommon
		))
	end
	-- Show after error so it grabs keyboard focus
	DBM:ShowUpdateReminder(nil, nil, ("Test report for %s (%s/%s)"):format(self.testData.name, self.testData.addon, self.testData.mod), self:ReportWithHeader())
end
