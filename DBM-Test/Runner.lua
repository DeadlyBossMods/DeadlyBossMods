
---@class DBMTest
local test = DBM.Test

local loadingTrace = {}
---@alias TestTrace TraceEntry[]
---@type TestTrace
local trace = {}
-- FIXME: the way event keys are handled is pretty ugly, also the name is terrible because so many things are called "events"
local currentEventKey
local currentRawEvent

function test:Trace(mod, event, ...)
	if not self.testRunning then return end
	local key = currentEventKey or "Unknown trigger" -- TODO: can we somehow include the timestamp here without messing up determinism?
	-- FIXME: this logic will get real messy real fast as we add more events -- come up with a way to define per-event behavior somehow
	if key == "InternalLoading" then
		local entries = loadingTrace[mod] or {}
		loadingTrace[mod] = entries
		entries[#entries + 1] = {event, ...}
	else
		local traceEntry = trace[#trace]
		if not traceEntry or traceEntry.trigger ~= key then
			---@class TraceEntry
			traceEntry = {
				trigger = key,
				rawTrigger = currentRawEvent,
				---@type TraceEntryEvent[]
				traces = {}
			}
			trace[#trace + 1] = traceEntry
		end
		if event == "NewTimer" or event == "NewAnnounce" or event == "NewSpecialWarning" or event == "NewYell" then
			local obj = ...
			obj.testUseCount = 0
		end
		if event == "StartTimer" or event == "ShowAnnounce" or event == "ShowSpecialWarning" or event == "ShowYell" then
			local obj = ...
			if not obj or not obj.testUseCount then
				geterrorhandler()("trace of type " .. event .. " without warning object ")
			end
			obj.testUseCount = (obj.testUseCount or 0) + 1
		end
		---@class TraceEntryEvent
		traceEntry.traces[#traceEntry.traces + 1] = {
			mod = mod,
			event = event,
			...
		}
	end
end

local function eventArgsToStringPretty(event, offset, isCleu)
	local result = ""
	for i = offset, #event do
		local filtered = false
		if event[i] == "" then
			result = result .. '""'
		elseif isCleu and (i == 6 or i == 10) then -- flags
			result = result .. "0x" .. ("%x"):format(tonumber(event[i]) or 0)
		elseif isCleu and (i == 7 or i == 11) then -- raidFlags, we don't set them in test data, so no reason to include
			filtered = true
		else
			result = result .. tostring(event[i])
		end
		if i < #event and not filtered then
			result = result .. ", "
		end
	end
	return result:gsub(", $", "")
end

-- FIXME: the term "event" is overloaded here as it's both used as the trigger and the resulting mod action, this one is for triggers, not traces
-- FIXME: this should probably be done during reporting and not playback
local function eventToString(event, maxTimestamp)
	local eventName, args, summary
	if event[2] == "COMBAT_LOG_EVENT_UNFILTERED" then
		eventName = event[3]
		args = string.join(", ", eventArgsToStringPretty(event, 4, true))
		local sourceName = event[5]
		local destName = event[9]
		local spellName = event[13]
		if destName then
			summary = (sourceName or "") .. "->" .. destName
		else
			summary = sourceName
		end
		if eventName:match("^SPELL_") and spellName and summary then
			summary = summary .. ": " .. spellName
		end
	else
		eventName = event[2]
		args = string.join(", ", eventArgsToStringPretty(event, 3))
	end
	local maxTimestampStrLength = math.floor(math.log10(math.floor(math.max(maxTimestamp, 1) * 100 + 0.5) / 100)) + 4
	return ("[%" .. maxTimestampStrLength .. ".2f] %s: %s%s"):format(event[1], eventName, summary and "[" .. summary .. "] " or "", args)
end

local fakeCLEUArgs = {
	-- Number of args to handle nil values gracefully
	n = nil
}
local function combatLogGetCurrentEventInfoHook()
	if fakeCLEUArgs.n then
		return unpack(fakeCLEUArgs, 1, fakeCLEUArgs.n)
	else
		return CombatLogGetCurrentEventInfo()
	end
end

local function setFakeCLEUArgs(...)
	table.wipe(fakeCLEUArgs)
	fakeCLEUArgs.n = 0
	for i = 1, select("#", ...) do
		-- Add missing args, see transcribeCleu() in ParseTranscriptor
		if fakeCLEUArgs.n == 0 then
			fakeCLEUArgs.n = fakeCLEUArgs.n + 1
			fakeCLEUArgs[fakeCLEUArgs.n] = 0 -- timestamp
		elseif fakeCLEUArgs.n == 2 then
			fakeCLEUArgs.n = fakeCLEUArgs.n + 1
			fakeCLEUArgs[fakeCLEUArgs.n] = false -- hideCaster
		end
		fakeCLEUArgs.n = fakeCLEUArgs.n + 1
		fakeCLEUArgs[fakeCLEUArgs.n] = select(i, ...)
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
function test:SetFakeInstanceInfo(instanceInfo)
	fakeInstanceInfo = instanceInfo
	self:HookPrivate("LastInstanceMapID", instanceInfo.instanceID)
end

local fakeIsEncounterInProgress
local function isEncounterInProgressHook()
	return fakeIsEncounterInProgress
end

function test:Setup()
	table.wipe(trace)
	self.testRunning = true
	self:HookPrivate("CombatLogGetCurrentEventInfo", combatLogGetCurrentEventInfoHook)
	self:HookPrivate("GetInstanceInfo", getInstanceInfoHook)
	fakeIsEncounterInProgress = false
	self:HookPrivate("IsEncounterInProgress", isEncounterInProgressHook)
	self:HookPrivate("statusGuildDisabled", true) -- FIXME: this only stays active until first EndCombat, use options instead?
	self:HookPrivate("statusWhisperDisabled", true)
	for _, mod in ipairs(DBM.Mods) do
		mod._testingTempOverrides = mod._testingTempOverrides or {}
		mod._testingTempOverrides.stats = mod.stats
		-- Do not use DBM:ClearAllStats() here as it also messes with the saved variables
		mod.stats = DBM:CreateDefaultModStats()
		-- Avoid the recombat limit when testing the same mod multiple times
		mod.lastWipeTime = nil
		mod.lastKillTime = nil
	end
end

function test:Teardown()
	self.testRunning = false
	self:UnhookPrivates()
	for _, mod in ipairs(DBM.Mods) do
		if mod._testingTempOverrides then
			for k, v in pairs(mod._testingTempOverrides) do
				mod[k] = v
			end
		end
	end
end

function test:InjectEvent(event, ...)
	if event == "IsEncounterInProgress()" then
		fakeIsEncounterInProgress = ...
		return
	end
	-- FIXME: handle UNIT_* differently, will always end up as UNIT_*_UNFILTERED which is *usually* wrong, probably best to just send them twice?
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		setFakeCLEUArgs(...)
		self:GetPrivate("mainEventHandler")(self:GetPrivate("mainFrame"), event, combatLogGetCurrentEventInfoHook())
		table.wipe(fakeCLEUArgs)
	else
		self:GetPrivate("mainEventHandler")(self:GetPrivate("mainFrame"), event, ...)
	end
end

local currentThread
local function sleepUntil(time)
	while time - GetTime() > 0 do
		coroutine.yield()
	end
end

---@param testData TestDefinition
function test:Playback(testData)
	DBM:AddMsg("Starting test: " .. testData.name)
	self:SetFakeInstanceInfo(testData.instanceInfo)
	local startTime = GetTime()
	local maxTimestamp = testData.log[#testData.log][1]
	for _, v in ipairs(testData.log) do
		local ts = v[1]
		if startTime + ts > GetTime() then
			sleepUntil(startTime + ts)
		end
		currentEventKey = eventToString(v, maxTimestamp)
		currentRawEvent = v
		self:InjectEvent(select(2, unpack(v)))
		currentRawEvent = nil
		currentEventKey = nil
	end
	local reporter = self:NewReporter(testData, trace)
	local report = reporter:ReportWithHeader()
	DBM_TestResults_Export = DBM_TestResults_Export or {}
	DBM_TestResults_Export[testData.name] = report
	local expected = self.Registry.expectedResults[testData.name]
	if not expected or expected:trim() ~= reporter:Report():trim() then
		DBM:AddMsg("Test failed!")
		reporter:ReportDiff(expected)
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
---@field gameVersion GameVersion Required version of the game to run the test.
---@field addon string AddOn in which the mod under test is located.
---@field mod string The boss mod being tested.
---@field instanceInfo InstanceInfo Fake GetInstanceInfo() data for the test.
---@field playerName string Name of the player who recorded the log.
---@field log table[] Log to replay

-- TODO: this isn't checked or used yet, also, we probably only need to distinguish the 3 main versions because SoD should be able to run all era mods
-- TODO: this also depends on how we load/not load mods for era vs. sod, will probably be relevant once MC releases
---@alias GameVersion "SeasonOfDiscovery"

function test:RunTest(testName)
	local testData = self.Registry.tests[testName]
	if not testData then
		error("test " .. testName .. " not found", 2)
	end
	if self.testRunning then
		error("only a single test can run at a time")
	end
	if not DBM:GetModByName(testData.mod) then
		self.testRunning = true -- Trace loading events
		currentEventKey = "InternalLoading"
		currentRawEvent = nil
		DBM:LoadModByName(testData.addon, true)
		currentEventKey = nil
		self.testRunning = false
	end
	local modUnderTest = DBM:GetModByName(testData.mod)
	if not modUnderTest then
		error("could not find mod " .. testData.mod .. " after loading " .. testData.addon, 2)
	end
	self:Setup() -- Must be done after loading the mod to prepare mod (stats, options, ...)
	-- Recover loading events for this mod stored above - must be done like this to support testing multiple mods in one addon in one session
	local loadingEvents = loadingTrace[modUnderTest]
	if not loadingEvents then
		error("could not observe mod loading events -- make sure that the addon is not yet loaded when starting the test")
	end
	currentEventKey = eventToString({0, "ADDON_LOADED", testData.addon}, testData.log[#testData.log][1])
	currentRawEvent = nil
	for _, v in ipairs(loadingEvents) do
		self:Trace(modUnderTest, unpack(v))
	end
	currentEventKey = nil
	currentThread = coroutine.create(self.Playback)
	coroutine.resume(currentThread, self, testData)
end
