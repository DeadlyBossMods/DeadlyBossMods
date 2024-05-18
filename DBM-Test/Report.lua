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

-- Sorts warning objects by class/text/type
local function compareObjects(obj1, obj2)
	local class1, class2 = obj1.objClass, obj2.objClass
	local key1, key2 = obj1.spellId or obj1.text or obj1, obj2.spellId or obj2.text or obj2
	local type1, type2 = obj1.type or obj1.announceType or obj1.yellType or "unknown", obj2.type or obj2.announceType or obj2.yellType or "unknown"
	if class1 ~= class2 then
		return class1 < class2
	elseif type(key1) ~= type(key2) then
		return type(key1) == "string"
	elseif key1 ~= key2 then
		return key1 < key2
	else
		return type1 < type2
	end
end

function reporter:ObjectToString(obj, skipType)
	if type(obj) == "string" then -- used for PlaySound from voice packs which doesn't have an object, this is a bit ugly
		local fileName = obj:match("Interface\\AddOns\\DBM%-VP[^\\]-\\(.-)%.ogg")
		return ("%sVoicePack/%s"):format(not skipType and "[PlaySound] " or "", fileName)
	end
	local spellId = obj.spellId and obj.spellId > 50 and tostring(obj.spellId) or "<none>"
	if obj.objClass == "Timer" then
		-- FIXME: this should be fixed in timers, not here, can't see a good reason for the late evaluation of the localized text in timers whereas everything else can do it early
		local text = obj.text or obj.type and obj.mod:GetLocalizedTimerText(obj.type, obj.spellId, obj.name) or obj.name
		return ("%s%s, time=%.2f, type=%s, spellId=%s"):format(not skipType and "[Timer] " or "", text, obj.timer, obj.type, spellId)
	elseif obj.objClass == "Announce" then
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Announce] " or "", obj.text, tostring(obj.announceType), spellId)
	elseif obj.objClass == "SpecialWarning" then
		return ("%s%s, type=%s, spellId=%s"):format(not skipType and "[Special Warning] " or "", obj.text, tostring(obj.announceType), spellId)
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
		local name = spellId and spellId ~= "0" and DBM:GetSpellInfo(spellId) or "Unknown spell"
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
			findings[#findings + 1] = {type = "untriggered-event", event = event, text = "Unused event registration: " .. addSpellNames(event)}
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
					if obj.spellId and obj.spellId > 50 and obj.spellId ~= triggerSpellId then
						findings[#findings + 1] = {
							type = "spell-mismatch", spellId = obj.spellId, triggerSpellId = triggerSpellId,
							text = ("%s for spell ID %s is triggered by event %s %s"):format(obj.objClass, addSpellNames(obj.spellId), triggerEvent, addSpellNames(triggerSpellId))
						}
					end
				end
			end
		end
	end
end

function reporter:ReportFindings()
	local findings = {}
	self:FindUntriggeredEvents(findings)
	self:FindSpellIdMismatches(findings)
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
		if e1.type ~= e2.type then
			return e1.type < e2.type
		else
			return (e1.event or e1.spellId or e1.text) < (e2.event or e2.spellId or e2.text)
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
	self:ObjectsToString(unusedObjects)
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
		-- FIXME: should use some other type here, but both trigger and rawTrigger are kinda ugly at the moment
		local timestamp, id = trigger:match("^%[%s*(%d*%.%d*)%] (.*)")
		timestamp = tonumber(timestamp)
		if not timestamp or not id then -- Schedule() currently triggers an unknown source without a timestamp
			result[#result + 1] = {firstTrigger = trigger, repeated = {}}
		else
			-- group SPELL_AURA_APPLIED_DOSE
			-- FIXME: rather ugly and doesn't support everything, we should also group non-DOSE and DOSE, DAMAGE and MISSED, REFRESH etc but we need some way to report that both events happened
			if id:match("^SPELL_AURA_APPLIED_DOSE") then
				id = id:gsub(", (%d+), (%d+)$", "")
			end
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
					filterExcluded = filterExcluded or f(v, entry)
				end
				if not filterExcluded then
					local obj = v[1]
					local entries = objs[obj] or {}
					objs[obj] = entries
					-- Don't report the same trigger twice if it runs multiple actions on an object (e.g., timer restart)
					if entry.trigger ~= entries[#entries] then
						entries[#entries + 1] = entry.trigger
					end
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
		result = result .. "\t" .. self:ObjectToString(v.obj, true) .. "\n"
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
local function eventToStringForReport(event)
	local result = {}
	local extraLines = {}
	for _, v in ipairs(event) do
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
			result[#result + 1] = tostring(v)
		end -- TODO: would it be useful to have a short string representation of the object instead of dropping it?
	end
	if event.event == "AntiSpam" then
		result[#result] = nil -- filter bool result
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
	local str = event.event .. ": " .. table.concat(result, ", ")
	if #extraLines > 0 then
		return str .. "\n\t\t\t" .. table.concat(extraLines, "\n\t\t\t")
	else
		return str
	end
end

local genericWarningSounds = {
	[DBM.Options.RaidWarningSound] = true,
	[DBM.Options.SpecialWarningSound] = true,
}

---@param entry TraceEntryEvent
---@param trigger TraceEntry
function reporter:FilterTraceEntry(entry, trigger)
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
	if entry.event == "AntiSpam" and not entry[2] then
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
	return entry.event:match("^New")
end

function reporter:ReportEventTrace()
	local result = ""
	for _, entry in ipairs(self.trace) do
		local traces = {}
		for _, v in ipairs(entry.traces) do
			if not self:FilterTraceEntry(v, entry) then
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
