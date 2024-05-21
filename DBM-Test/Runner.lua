
---@class DBMTest
local test = DBM.Test

-- FIXME: i don't like this "global" state
local loadingTrace = {}
---@alias TestTrace TraceEntry[]
---@type TestTrace
local trace = {}
test.trace = trace -- Export for dev/debugging
-- FIXME: the way event keys are handled is pretty ugly, also the name is terrible because so many things are called "events"
local currentEventKey
---@type TestLogEntry?
local currentRawEvent
---@type table<any, table<any, TraceEntry[]>>
local antiSpams = {}

local unknownRawTrigger = {0, "Unknown trigger"}

---@param mod DBMModOrDBM
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
				---@type string
				trigger = key,
				---@type TestLogEntry
				rawTrigger = currentRawEvent or unknownRawTrigger,
				---@type TraceEntryEvent[]
				traces = {},
				-- Set if this event triggered an end of combat trace
				didTriggerCombatEnd = false,
			}
			trace[#trace + 1] = traceEntry
		end
		---@class TraceEntryEvent
		local entry = {
			mod = mod,
			event = event,
			-- For AntiSpam events: next trace entries where this AntiSpam returned false
			---@type TraceEntry[]?
			filteredAntiSpams = nil,
			...
		}
		traceEntry.traces[#traceEntry.traces + 1] = entry
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
		if event == "EndCombat" then
			traceEntry.didTriggerCombatEnd = true
		end
		if event == "AntiSpam" then
			local id, result = ...
			antiSpams[mod] = antiSpams[mod] or {}
			if result then -- starting to filter next events
				antiSpams[mod][id] = {}
				entry.filteredAntiSpams = antiSpams[mod][id]
			else -- filtered, record in previous event
				local previousAntiSpams = antiSpams[mod][id]
				if previousAntiSpams then
					previousAntiSpams[#previousAntiSpams + 1] = traceEntry
				else
					-- happens if an AntiSpam from a previous test is still active which is unlikely but not impossible because they aren't cleared
					DBM:AddMsg("Warning: incomplete trace of AntiSpam")
				end
			end
		end
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

local function enableAllWarnings(mod, objects)
	for _, obj in ipairs(objects) do
		if obj.option then
			mod.Options[obj.option] = true
		end
	end
end

function test:SetupModOptions()
	local mod = self.modUnderTest
	local modTempOverrides = self.restoreModVariables[mod]
	-- mod.Options is in a saved table, so make a copy of the whole thing to not mess it up accidentally
	modTempOverrides.Options = mod.Options
	mod["Options"] = {}
	for k, v in pairs(modTempOverrides.Options) do
		mod.Options[k] = v
	end
	enableAllWarnings(mod, mod.timers)
	enableAllWarnings(mod, mod.announces)
	enableAllWarnings(mod, mod.specwarns)
	enableAllWarnings(mod, mod.yells)
end

function test:SetupDBMOptions()
	-- Change settings to not depend on user configuration
	-- Set DBM settings to default, but don't touch DBM.Options itself because it is saved
	local dbmOptions = {
		DebugMode = DBM.Options.DebugMode,
		DebugLevel = DBM.Options.DebugLevel,
	}
	DBM:AddDefaultOptions(dbmOptions, DBM.DefaultOptions)
	self:HookDbmVar("Options", dbmOptions)
	DBM.Options.EventSoundVictory2 = false
	DBM.Options.DontShowTargetAnnouncements = false
	DBM.Options.FilterTankSpec = false
	DBM.Options.FilterBTargetFocus = false
	DBM.Options.FilterBInterruptCooldown = false
	DBM.Options.FilterTTargetFocus = false
	DBM.Options.FilterTInterruptCooldown = false
	DBM.Options.FilterDispel = false
	DBM.Options.FilterCrowdControl = false
	DBM.Options.FilterTrashWarnings2 = false
	DBM.Options.FilterVoidFormSay = false
	DBM.Options.DebugSound = false
	-- Don't spam guild members when testing
	DBM.Options.DisableGuildStatus = true
	DBM.Options.AutoRespond = false
	-- Don't show intro messages
	DBM.Options.SettingsMessageShown = true
	DBM.Options.NewsMessageShown2 = 3
end

function test:Setup()
	table.wipe(trace)
	table.wipe(antiSpams)
	self.testRunning = true
	self:SetupHooks()
	-- Store stats for all mods to not mess them up if the test or a mod trigger is bad
	for _, mod in ipairs(DBM.Mods) do
		-- Do not use DBM:ClearAllStats() here as it also messes with the saved table
		self:HookModVar(mod, "stats", DBM:CreateDefaultModStats())
		-- Avoid the recombat limit when testing the same mod multiple times
		mod.lastWipeTime = nil
		mod.lastKillTime = nil
		-- TODO: validate that stats was changed as expected on test end
	end
	-- Change settings to not depend on user configuration
	self:SetupDBMOptions()
	self:SetupModOptions()
end

function test:ForceCVar(cvar, value)
	self.restoreCVars = self.restoreCVars or {}
	if self.restoreCVars[cvar] == nil then
		self.restoreCVars[cvar] = GetCVar(cvar)
	end
	SetCVar(cvar, value)
end

function test:Teardown()
	self.testRunning = false
	self.modUnderTest = nil
	-- Get rid of any lingering :Schedule calls, they are broken anyways due to time warping
	DBM:Disable()
	DBM:Enable()
	DBT:CancelAllBars()
	self:TeardownHooks()
	if self.restoreCVars then
		for cvar, value in pairs(self.restoreCVars) do
			SetCVar(cvar, value)
		end
		self.restoreCVars = nil
	end
end

function test:OnInjectCombatLog(_, subEvent, _, srcGuid, srcName, _, _, dstGuid, dstName, _, _, spellId, spellName, _, ...)
	if (subEvent == "SWING_DAMAGE" or subEvent == "SWING_MISSED") and (srcGuid:match("^Creature%-") or srcGuid:match("^Vehicle%-")) then
		self.Mocks:SetThreat(dstGuid, dstName, srcGuid, srcName)
	end
	if subEvent == "SPELL_AURA_REMOVED" or subEvent == "SPELL_AURA_BROKEN" or subEvent == "SPELL_AURA_BROKEN_SPELL" then
		self.Mocks:RemoveUnitAura(dstName, dstGuid, spellId, spellName)
	end
	if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REMOVED_DOSE" or subEvent == "SPELL_AURA_REFRESH" then
		local auraType, amount = ...
		self.Mocks:ApplyUnitAura(dstName, dstGuid, spellId, spellName, auraType, amount)
	end
end

function test:InjectEvent(event, ...)
	if event == "IsEncounterInProgress()" then
		self.Mocks:SetEncounterInProgress(...)
		return
	end
	if event == "PLAYER_REGEN_DISABLED" then
		self.Mocks:SetUnitAffectingCombat("player", UnitName("player"), UnitGUID("player"), true)
	elseif event == "PLAYER_REGEN_ENABLED" then
		self.Mocks:SetUnitAffectingCombat("player", UnitName("player"), UnitGUID("player"), false)
	end
	if event == "UNIT_TARGET" and select("#", ...) > 1 then
		local uId, unitName, target = ...
		target = target:match("Target: (.*)")
		if target == "??" then
			target = nil
		end
		if target == self.testData.playerName then
			target = UnitName("player")
		end
		self.Mocks:UpdateTarget(uId, unitName, target)
		-- strip extra params to not provide the mod with more information than it would have in the real environment
		return self:InjectEvent(event, uId)
	end
	if event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" and select("#", ...) > 0 then
		for i = 2, select("#", ...), 8 do
			local bossUid, canAttack, exists, visible, name, guid = select(i, ...)
			if guid then
				self.Mocks:UpdateBoss(bossUid, name, guid, canAttack, exists, visible)
			end
		end
		return self:InjectEvent(event)
	end
	if event == "UNIT_POWER_UPDATE" and select("#", ...) > 2 then
		local uid, name, powerType, power = ...
		powerType = powerType:match("TYPE:(%w+)/")
		power = tonumber(power:match("(%d+)"))
		self.Mocks:UpdateUnitPower(uid, name, power)
		return self:InjectEvent(event, uid, powerType)
	end
	-- FIXME: handle UNIT_* differently, will always end up as UNIT_*_UNFILTERED which is *usually* wrong, probably best to just send them twice?
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		self.Mocks:SetFakeCLEUArgs(self.testData.playerName, ...)
		self:OnInjectCombatLog(self.Mocks.CombatLogGetCurrentEventInfo())
		self:GetPrivate("mainEventHandler")(self:GetPrivate("mainFrame"), event, self.Mocks.CombatLogGetCurrentEventInfo())
		self.Mocks:SetFakeCLEUArgs()
	else
		self:GetPrivate("mainEventHandler")(self:GetPrivate("mainFrame"), event, ...)
	end
end

local currentThread

---@param testData TestDefinition
function test:Playback(testData, timeWarp)
	DBM:AddMsg("Starting test: " .. testData.name)
	if timeWarp >= 10 then
		DBM:AddMsg("Timewarp >= 10, disabling sounds")
		self:ForceCVar("Sound_EnableAllSound", false)
	end
	self.testData = testData
	self.Mocks:SetInstanceInfo(testData.instanceInfo)
	local maxTimestamp = testData.log[#testData.log][1]
	local timeWarper = test.TimeWarper:New(timeWarp)
	self.timeWarper = timeWarper
	timeWarper:Start()
	local startTime = timeWarper.fakeTime
	for _, v in ipairs(testData.log) do
		local ts = v[1]
		timeWarper:WaitUntil(startTime + ts)
		currentEventKey = eventToString(v, maxTimestamp)
		currentRawEvent = v
		xpcall(self.InjectEvent, geterrorhandler(), self, select(2, unpack(v)))
		currentRawEvent = nil
		currentEventKey = nil
	end
	if timeWarp <= 5 then
		DBM:AddMsg("Test playback finished, waiting for delayed cleanup events (3 seconds)")
	end
	timeWarper:WaitUntil(timeWarper.fakeTime + 3.1)
	timeWarper:Stop()
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
frame:SetScript("OnUpdate", function(_, elapsed)
	if currentThread then
		if coroutine.status(currentThread) == "dead" then
			currentThread = nil
			test:Teardown()
		else
			local ok, err = coroutine.resume(currentThread, elapsed)
			if not ok then geterrorhandler()(err) end
		end
	end
end)

---@class TestDefinition
---@field name string Unique test ID.
---@field gameVersion GameVersion Required version of the game to run the test.
---@field addon string AddOn in which the mod under test is located.
---@field mod string|integer The boss mod being tested.
---@field instanceInfo InstanceInfo Fake GetInstanceInfo() data for the test.
---@field playerName string Name of the player who recorded the log.
---@field log TestLogEntry[] Log to replay

---@class TestLogEntry
---@field [1] number
---@field [2] string

-- TODO: this isn't checked or used yet, also, we probably only need to distinguish the 3 main versions because SoD should be able to run all era mods
-- TODO: this also depends on how we load/not load mods for era vs. sod, will probably be relevant once MC releases
---@alias GameVersion "Retail"|"Classic"|"ClassicEra"|"SeasonOfDiscovery"

function test:RunTest(testName, timeWarp)
	local testData = self.Registry.tests[testName]
	if not testData then
		error("test " .. testName .. " not found", 2)
	end
	if self.testRunning then
		error("only a single test can run at a time")
	end
	if not DBM:GetModByName(testData.mod) then
		self.testRunning = true
		-- Trace loading events to know about timer/warning constructor calls
		currentEventKey = "InternalLoading"
		currentRawEvent = {0, "InternalLoading"}
		DBM:LoadModByName(testData.addon, true)
		currentEventKey = nil
		currentRawEvent = nil
		self.testRunning = false
	end
	local modUnderTest = DBM:GetModByName(testData.mod)
	if not modUnderTest then
		error("could not find mod " .. testData.mod .. " after loading " .. testData.addon, 2)
	end
	self.modUnderTest = modUnderTest
	self:Setup() -- Must be done after loading the mod to prepare mod (stats, options, ...)
	-- Recover loading events for this mod stored above - must be done like this to support testing multiple mods in one addon in one session
	local loadingEvents = loadingTrace[modUnderTest]
	if not loadingEvents then
		error("could not observe mod loading events -- make sure that the addon is not yet loaded when starting the test")
	end
	local fakeLoadingEvent = {0, "ADDON_LOADED", testData.addon}
	currentEventKey = eventToString(fakeLoadingEvent, testData.log[#testData.log][1])
	currentRawEvent = fakeLoadingEvent
	for _, v in ipairs(loadingEvents) do
		self:Trace(modUnderTest, unpack(v))
	end
	currentEventKey = nil
	currentRawEvent = nil
	currentThread = coroutine.create(self.Playback)
	local ok, err = coroutine.resume(currentThread, self, testData, timeWarp or 1)
	if not ok then error(err) end
end

function test:StopTests()
	self.stopRequested = true
	if self.timeWarper then
		self.timeWarper:Stop()
	end
	 -- explicitly call teardown because the coroutine cancelation will only do so on the next frame which is too late for the stop-on-unload case
	self:Teardown()
end

function test:RunTests(testNames, timeWarp)
	self.stopRequested = false
	-- FIXME: aggregate errors and report them at the end
	local cr = coroutine.create(function()
		for _, testName in ipairs(testNames) do
			xpcall(self.RunTest, geterrorhandler(), self, testName, timeWarp)
			while self.testRunning do
				coroutine.yield()
			end
			if self.stopRequested then
				break
			end
		end
	end)
	local f = CreateFrame("Frame")
	-- FIXME: can probably be merged with the main coroutine
	f:SetScript("OnUpdate", function()
		local status = coroutine.status(cr)
		if status == "suspended" then
			coroutine.resume(cr)
		elseif status == "dead" then
			f:Hide()
		end
	end)
end

-- Undo temporary changes when logging out/reloading while a test is running
-- Some changes must touch persistent config options by design, e.g., disabling sound
local stopOnUnload = CreateFrame("Frame")
stopOnUnload:RegisterEvent("ADDONS_UNLOADING")
stopOnUnload:SetScript("OnEvent", function()
	test:StopTests()
end)
