---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

---@class DBMTest
local test = private:GetPrototype("DBMTest")

function DBM:SetFakeMapId(id)
	private.SetLastInstanceMapID(id)
end

local testRunning = false
---@class DBMMod?
local modUnderTest = nil
local currentEventKey = nil
---@type TraceEntry[]
local trace = {}
local loadingTrace = {}
local objectsByMod = {}

function test:Trace(mod, event, ...)
	if not testRunning then return end
	local key = currentEventKey or "Unknown trigger" -- TODO: can we somehow include the timestamp here without messing up determinism?
	-- FIXME: this logic will get real messy real fast as we add more events -- come up with a way to define per-event behavior somehow
	if key == "InternalLoading" then
		local entries = loadingTrace[mod] or {}
		loadingTrace[mod] = entries
		entries[#entries + 1] = {event, ...}
	elseif event == "NewTimer" or event == "NewAnnounce" or event == "NewSpecialWarning" or event == "NewYell" then
		local obj = ...
		obj.testUseCount = 0
		local objects = objectsByMod[mod] or {}
		objectsByMod[mod] = objects
		objects[#objects + 1] = obj
	else
		if event == "UnregisterEvents" or event == "RegisterEvents" then
			if mod ~= modUnderTest then
				return
			end
		end
		local traceEntry = trace[#trace]
		if not traceEntry or traceEntry.trigger ~= key then
			---@class TraceEntry
			traceEntry = {
				trigger = key,
				traces = {}
			}
			trace[#trace + 1] = traceEntry
		end
		if event == "StartTimer" or event == "ShowAnnounce" or event == "ShowSpecialWarning" or event == "ShowYell" then
			local obj = ...
			obj.testUseCount = obj.testUseCount + 1
		end
		---@class TraceEntryEvent
		traceEntry.traces[#traceEntry.traces + 1] = {
			mod = mod,
			event = event,
			...
		}
	end
end

-- FIXME: the term "event" is overloaded here as it's both used as the trigger and the resulting mod action, this one is for triggers, not traces
local function eventToString(event)
	local isCombatLog = event[2] == "COMBAT_LOG_EVENT_UNFILTERED"
	-- FIXME: remove useless alloc
	local args = table.concat({tostringall(unpack(event))}, ", ", isCombatLog and 6 or 3)
	local eventName = isCombatLog and "CLEU - " .. event[4] or event[2]
	return ("[%.2f] %s: %s"):format(event[1], eventName, args)
end

local fakeCLEUArgs
local function combatLogGetCurrentEventInfoHook()
	if fakeCLEUArgs then
		return unpack(fakeCLEUArgs)
	else
		return CombatLogGetCurrentEventInfo()
	end
end

---@type InstanceInfo
local fakeInstanceInfo
local function getInstanceInfoHook()
	if fakeInstanceInfo then
		return fakeInstanceInfo.name, fakeInstanceInfo.instanceType, fakeInstanceInfo.difficultyID,
			fakeInstanceInfo.difficultyName, fakeInstanceInfo.maxPlayers, fakeInstanceInfo.dynamicDifficulty,
			fakeInstanceInfo.isDynamic, fakeInstanceInfo.instanceID, fakeInstanceInfo.instanceGroupSize,
			fakeInstanceInfo.lfgDungeonID
	else
		return GetInstanceInfo()
	end
end

---@param instanceInfo InstanceInfo
function test:SetFakInstanceInfo(instanceInfo)
	fakeInstanceInfo = instanceInfo
	DBM:SetFakeMapId(instanceInfo.instanceID)
end

local fakeIsEncounterInProgress
local function isEncounterInProgressHook()
	return fakeIsEncounterInProgress
end

local restorePrivates = {}
local function hookPrivate(key, value)
	restorePrivates[key] = private[key]
	private[key] = value
end

function test:Setup()
	table.wipe(trace)
	testRunning = true
	private.HookCombatLogGetCurrentEventInfo(combatLogGetCurrentEventInfoHook)
	hookPrivate("GetInstanceInfo", getInstanceInfoHook)
	fakeIsEncounterInProgress = false
	hookPrivate("IsEncounterInProgress", isEncounterInProgressHook)
	hookPrivate("restoreGuildStatus", true)
	for _, mod in ipairs(DBM.Mods) do
		mod._testingTempOverrides = mod._testingTempOverrides or {}
		mod._testingTempOverrides.stats = mod.stats
		-- Do not use DBM:ClearAllStats() here as it also messes with the saved variables, this one doesn't
		mod.stats = private.createDefaultModStats()
		-- Avoid the recombat limit when testing the same mod multiple times
		mod.lastWipeTime = nil
		mod.lastKillTime = nil
	end
end

function test:Teardown()
	testRunning = false
	for k, v in pairs(restorePrivates) do
		private[k] = v
	end
	table.wipe(restorePrivates)
	for _, mod in ipairs(DBM.Mods) do
		if mod._testingTempOverrides then
			for k, v in pairs(mod._testingTempOverrides) do
				mod[k] = v
			end
		end
	end
end

function test:InjectEvent(event, ...)
	if event == "ENCOUNTER_START" then
		fakeIsEncounterInProgress = true
	elseif event == "ENCOUNTER_END" then
		fakeIsEncounterInProgress = false
	end
	-- FIXME: handle UNIT_* differently, will always end up as UNIT_*_UNFILTERED which is *usually* wrong, probably best to just send them twice?
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		fakeCLEUArgs = {...}
		private.mainEventHandler(private.mainFrame, event, ...)
		fakeCLEUArgs = nil
	else
		private.mainEventHandler(private.mainFrame, event, ...)
	end
end

local function sortObjects(obj1, obj2)
	local class1, class2 = obj1.objClass, obj2.objClass
	local spellId1, spellId2 = obj1.spellId or obj1.text, obj2.spellId or obj2.text
	if class1 ~= class2 then
		return class1 < class2
	elseif type(spellId1) ~= type(spellId2) then
		return type(spellId1) == "string"
	else
		return spellId1 < spellId2
	end
end

local function objectToString(obj, skipType)
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

function test:ReportUntriggeredEvents()
	return "\tNYI"
end

-- FIXME: expand to generic warnings (but the word "warning" is overloaded here -- maybe "findings", "potential bugs", or "oddities"?)
function test:ReportUnusedObjects()
	local objs = objectsByMod[modUnderTest]
	local unusedObjects = {}
	for _, v in ipairs(objs) do
		if not v.testUseCount or v.testUseCount == 0 then
			unusedObjects[#unusedObjects + 1] = v
		end
	end
	table.sort(unusedObjects, sortObjects)
	objectsToString(unusedObjects)
	if #unusedObjects > 0 then
		return "\t" .. table.concat(unusedObjects, "\n\t")
	else
		return "\tNone"
	end
end

function test:ReportTimers()
	local timers = {}
	for _, entry in ipairs(trace) do
		for _, v in ipairs(entry.traces) do
			if v.event == "StartTimer" then
				local obj = v[1]
				local entries = timers[obj] or {}
				timers[obj] = entries
				entries[#entries + 1] = entry.trigger
			end
		end
	end
	-- FIXME: actually sort this
	local sortedTimers = {}
	for k, v in pairs(timers) do
		sortedTimers[#sortedTimers + 1] = {timer = k, triggers = v}
	end
	local result = ""
	for _, v in ipairs(sortedTimers) do
		result = result .. "\t" .. objectToString(v.timer, true) .. "\n"
		result = result .. "\t\t" .. table.concat(v.triggers, "\n\t\t") .. "\n"
	end
	return result:gsub("\n$", "")
end

-- FIXME: duplicated from timers
function test:ReportAnnounces()
	local announces = {}
	for _, entry in ipairs(trace) do
		for _, v in ipairs(entry.traces) do
			if v.event == "ShowAnnounce" then
				local obj = v[1]
				local entries = announces[obj] or {}
				announces[obj] = entries
				entries[#entries + 1] = entry.trigger
			end
		end
	end
	-- FIXME: actually sort this
	local sortedAnnounces = {}
	for k, v in pairs(announces) do
		sortedAnnounces[#sortedAnnounces + 1] = {announce = k, triggers = v}
	end
	local result = ""
	for _, v in ipairs(sortedAnnounces) do
		result = result .. "\t" .. objectToString(v.announce, true) .. "\n"
		result = result .. "\t\t" .. table.concat(v.triggers, "\n\t\t") .. "\n"
	end
	return result:gsub("\n$", "")
end

function test:ReportSpecialWarnings()
	return "\tNYI"
end

function test:ReportYells()
	return "\tNYI"
end

local function stripMarkup(text)
	if type(text) ~= "string" then
		return text
	end
	-- TODO: fully stripping texture for now, but for some things it may be useful to show it
	return text:gsub("|r", ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|T[^|]*|t", ""):gsub("|H[^|]*|h", ""):trim()
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

function test:ReportEventTrace()
	local result = ""
	for _, entry in ipairs(trace) do
		local traces = {}
		for _, v in ipairs(entry.traces) do
			traces[#traces + 1] =  eventToStringForReport(v)
		end
		result = result .. "\t " .. entry.trigger .. "\n\t\t" .. table.concat(traces, "\n\t\t") .. "\n"
	end
	return result:gsub("\n$", "")
end

function test:PrepareReportForCopying(report)
	return "DBM.Test:Report[[\n" .. report .. "]]\n"
end

function test:CreateReport(testName)
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

SpecialWarnings:
%s

Yells:
%s

Event trace:
%s
]]
	return reportFormat:format(
		testName,
		modUnderTest.modId, modUnderTest.id,
		self:ReportUntriggeredEvents(),
		self:ReportUnusedObjects(),
		self:ReportTimers(),
		self:ReportAnnounces(),
		self:ReportSpecialWarnings(),
		self:ReportYells(),
		self:ReportEventTrace()
	)
end

local currentThread
local function sleepUntil(time)
	while time - GetTime() > 0 do
		coroutine.yield()
	end
end

---@type table<string, string>
local expectedResultRegistry = {}

---@param testData TestDefinition
function test:Playback(testData)
	DBM:AddMsg("Starting test: " .. testData.name)
	self:SetFakInstanceInfo(testData.instanceInfo)
	local startTime = GetTime()
	for _, v in ipairs(testData.log) do
		local ts = v[1]
		if startTime + ts > GetTime() then
			sleepUntil(startTime + ts)
		end
		currentEventKey = eventToString(v)
		self:InjectEvent(select(2, unpack(v)))
		currentEventKey = nil
	end
	local cleanReport = self:CreateReport(testData.name)
	local report = self:PrepareReportForCopying(cleanReport)
	DBM_TestResults_Export = DBM_TestResults_Export or {}
	DBM_TestResults_Export[testData.name] = report
	local expected = expectedResultRegistry[testData.name]
	if not expected or expected:trim() ~= cleanReport:trim() then
		DBM:AddMsg("Test failed!")
		if not expected then
			geterrorhandler()("no golden test report available, please update golden data")
		else
			local firstDiff, lastNewLine = 0, 0
			-- \t doesn't work in WoW
			local want = expected:trim():gsub("\t", "  ")
			local got = cleanReport:trim():gsub("\t", "  ")
			for i = 1, math.min(#want, #got) do
				if want:sub(i, i) == "\n" then
					lastNewLine = i
				end
				if want:byte(i, i) ~= got:byte(i, i) then
					firstDiff = i
					break
				end
			end
			local diffWant = want:sub(math.max(firstDiff - 100, lastNewLine + 1), math.min(want:find("\n", firstDiff + 1) or #want, firstDiff + 20) - 1)
			local diffGot = got:sub(math.max(firstDiff - 100, lastNewLine + 1), math.min(got:find("\n", firstDiff + 1) or #got, firstDiff + 20) - 1)
			local lastCommon = want:sub(math.max(firstDiff - 10, lastNewLine + 1), math.max(firstDiff - 1, 0))
			geterrorhandler()("test got unexpected result, please update golden if this diff is expected, first diff:\n" .. diffWant .. " (want)\n" .. diffGot .. " (got)\ndiff after: " .. lastCommon)
		end

		DBM:ShowUpdateReminder(nil, nil, "Test report for mod " .. modUnderTest.id .. ".", report) -- Show after error so it grabs keyboard focus
	else
		DBM:AddMsg("Test succeeded!")
	end
end

local frame = CreateFrame("Frame")
frame:Show()
frame:SetScript("OnUpdate", function()
	if currentThread then
		if coroutine.status(currentThread) == "dead" then
			currentThread = nil
			test:Teardown()
		else
			local ok, err = coroutine.resume(currentThread)
			if not ok then geterrorhandler()(err) end
		end
	end
end)

---@class TestDefinition
---@field name string Unique test ID.
---@field addon string AddOn in which the mod under test is located.
---@field mod string The boss mod being tested.
---@field instanceInfo InstanceInfo Fake GetInstanceInfo() data for the test.
---@field playerName string Name of the player who recorded the log.
---@field log table[] Log to replay

---@type table<string, TestDefinition>
local testRegistry = {}

function test:RunTest(testName)
	local testData = testRegistry[testName]
	if not testData then
		error("test " .. testName .. " not found", 2)
	end
	if testRunning then
		error("only a single test can run at a time")
	end
	if not DBM:GetModByName(testData.mod) then
		testRunning = true -- Trace loading events
		currentEventKey = "InternalLoading"
		DBM:LoadModByName(testData.addon, true)
		currentEventKey = nil
		testRunning = false
	end
	modUnderTest = DBM:GetModByName(testData.mod)
	if not modUnderTest then
		error("could not find mod " .. testData.mod .. " after loading " .. testData.addon, 2)
	end
	self:Setup() -- Must be done after loading the mod to prepare mod (stats, options, ...)
	-- Recover loading events for this mod stored above - must be done like this to support testing multiple mods in one addon in one session
	local loadingEvents = loadingTrace[modUnderTest]
	if not loadingEvents then
		error("could not observe mod loading events -- make sure that the addon is not yet loaded when starting the test")
	end
	-- FIXME: not nice to build the event key like this here
	currentEventKey = "[0.00] ADDON_LOADED: " .. testData.addon
	for _, v in ipairs(loadingEvents) do
		self:Trace(modUnderTest, unpack(v))
	end
	currentEventKey = nil
	currentThread = coroutine.create(self.Playback)
	coroutine.resume(currentThread, self, testData)
end

---@param args TestDefinition
function test:DefineTest(args)
	if testRegistry[args.name] then
		error("duplicate test name " .. args.name, 2)
	end
	testRegistry[args.name] = args
end

-- Set the expected result of a test
function test:Report(report)
	local testName = report:match("Test:%s+([^\n]*)\r?")
	expectedResultRegistry[testName] = report
end

function test:HandleCommand(args)
	local numTestAddOnsFound = 0
	for i = 1, C_AddOns.GetNumAddOns() do
		if C_AddOns.GetAddOnMetadata(i, "X-DBM-Test") then
			numTestAddOnsFound = numTestAddOnsFound + 1
			C_AddOns.LoadAddOn(i)
		end
	end
	if numTestAddOnsFound == 0 then
		DBM:AddMsg("No test AddOns installed, install a dev version of DBM to get DBM-Test-* mods.")
	end
	if args:lower() == "list" or args:lower() == "help" then
		DBM:AddMsg("Available tests:")
		-- TODO: sort in a useful way
		for testName in pairs(testRegistry) do
			DBM:AddMsg("  " .. testName)
		end
		if not next(testRegistry) then
			DBM:AddMsg("  (none)")
		end
		DBM:AddMsg("Run /dbm test <name> to run.")
	else
		self:RunTest(args)
	end
end

DBM.Test = test
