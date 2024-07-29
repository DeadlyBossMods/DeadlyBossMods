
---@class DBMTest
local test = DBM.Test

local dbmPrivate = test:GetPrivate()

local bband = bit.band
local realErrorHandler = geterrorhandler()

-- FIXME: i don't like this "global" state
local loadingTrace = {}
---@alias TestTrace TraceEntry[]
---@type TestTrace
local trace = {}
-- FIXME: the way event keys are handled is pretty ugly, also the name is terrible because so many things are called "events"
local currentEventKey
---@type TestLogEntry?
local currentRawEvent
---@type table<any, table<any, TraceEntry[]>>
local antiSpams = {}

local unknownRawTrigger = {0, "Unknown trigger"}

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

local function getRootEvent(event)
	if event[2] == "ExecuteScheduledTask" then
		return getRootEvent(event[3].rawTrigger)
	else
		return event
	end
end

-- FIXME: the term "event" is overloaded here as it's both used as the trigger and the resulting mod action, this one is for triggers, not traces
-- FIXME: this should probably be done during reporting and not playback
local function eventToString(event, includeTimestamp)
	local eventName, args, summary
	local ts = ""
	if includeTimestamp then
		local maxTimestampStrLength = math.floor(math.log10(math.floor(math.max(includeTimestamp, 1) * 100 + 0.5) / 100)) + 4
		ts = ("[%" .. maxTimestampStrLength .. ".2f] "):format(event[1])
	end
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
	elseif event[2] == "ExecuteScheduledTask" then
		local rootEvent = getRootEvent(event)
		return ("%sScheduled at %.2f by %s"):format(ts, rootEvent[1], eventToString(rootEvent, false))
	else
		eventName = event[2]
		args = string.join(", ", eventArgsToStringPretty(event, 3))
	end
	return ("%s%s: %s%s"):format(ts, eventName, summary and "[" .. summary .. "] " or "", args)
end

---@type table<integer, ScheduledTask>
local scheduledTasks = {}
local tableUtils = dbmPrivate:GetPrototype("TableUtils")
local difficulties = dbmPrivate:GetPrototype("Difficulties")

local function shortObjectName(obj, currentMod)
	return obj == DBM and "DBM"
		or obj == currentMod and "mod"
		or type(obj) == "table" and (
			obj.objClass == "Timer" and "timer" .. (obj.spellId or "") .. obj.type
			or obj.objClass == "Announce" and "announce" .. (obj.spellId or "") .. (obj.announceType or "")
			or obj.objClass == "SpecialWarning" and "specWarn" .. (obj.spellId or "") .. (obj.announceType or "")
			or obj.objClass == "Yell" and "yell" .. (obj.spellId or "") .. (obj.yellType or "")
		)
		or "(unknown object)"
end

local function functionArgsPretty(...)
	local res = {}
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if type(arg) == "number" then
			res[#res + 1] = ("%.1f"):format(arg)
		elseif type(arg) == "string" then
			-- to handle announce:CombinedShow(args.destName) since we fake args.destName to set to the current real player
			if arg == UnitName("player") then
				arg = "PlayerName"
			end
			res[#res + 1] = ("%q"):format(arg)
		elseif type(arg) == "table" then
			res[#res + 1] = shortObjectName(arg)
		elseif type(arg) == "boolean" then
			res[#res + 1] = tostring(arg)
		elseif type(arg) == "nil" then
			res[#res + 1] = "nil"
		else
			res[#res + 1] = "(unknown " .. type(arg) .. ")"
		end
	end
	while res[#res] == "nil" do -- drop trailing nils to omit unused args
		res[#res] = nil
	end
	return table.concat(res, ", ")
end

---@param mod DBMModOrDBM
function test:Trace(mod, event, ...)
	if not self.testRunning then return end
	if event == "ScheduleTask" then -- the other Scheduler-traces for events discarded here are filtered by the "did we see the schedule?" logic below
		-- Filter non-mod schedules because they're used a lot internally
		if mod ~= self.modUnderTest then
			return
		end
		-- Timers use Schedule in the mod namespace internally
		local func, tbl, val = select(3, ...)
		if func == tableUtils.removeEntry and type(tbl) == "table" and tbl._testObjClass == "Timer.startedTimers" and type(val) == "string" then
			return
		end
	end
	-- We only care about timers where we observed the schedule event
	if event == "UnscheduleTask" or event == "ExecuteScheduledTaskPre" or event == "ExecuteScheduledTaskPost" or event == "SetScheduleMethodName" or event == "SchedulerHideFromTraceIfUnscheduled" then
		local id = ...
		if not scheduledTasks[id] then
			return
		end
	end
	if event == "SetScheduleMethodName" then
		local id, obj, method = ...
		local objString = shortObjectName(obj, mod)
		local methodStr = method:match("^[%a_][%w_]*$") and ":" .. method or ("[%q]"):format(method)
		scheduledTasks[id].scheduledBy.scheduleData.funcName = objString .. methodStr .. "(" .. functionArgsPretty(select(4, ...)) .. ")"
		return
	end
	if event == "SchedulerHideFromTraceIfUnscheduled" then
		local id = ...
		---@class ScheduledTask
		local scheduledTask = scheduledTasks[id]
		scheduledTask.hideIfUnscheduled = true
	end
	if event == "CombinedWarningPreciseShow" then
		local obj, maxTotal = ...
		obj.testUsedWithPreciseShow[maxTotal] = true
		return
	elseif event == "CombinedWarningPreciseShowSuccess" then
		local obj, maxTotal = ...
		obj.testUsedWithPreciseShowSucess[maxTotal] = true
		return
	end
	local key = currentEventKey or "Unknown trigger" -- TODO: can we somehow include the timestamp here without messing up determinism?
	-- FIXME: this logic will get real messy real fast as we add more events -- come up with a way to define per-event behavior somehow
	if key == "InternalLoading" then
		if mod then -- We only care about mod-related events, sometimes other events such as internal Schedules can trigger during load (e.g., timer recovery)
			local entries = loadingTrace[mod] or {}
			loadingTrace[mod] = entries
			entries[#entries + 1] = {event, ...}
		end
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
			-- For ScheduleTask events: information on execution or cancelation
			---@type {scheduleExecution: TraceEntry?, unscheduledBy: TestLogEntry?, unscheduledTask: ScheduledTask?, funcName: string?, time: number, delta: number}
			scheduleData = nil,
			...
		}
		if currentRawEvent and currentRawEvent[2] == "ExecuteScheduledTask" then
			local origEntry = currentRawEvent[3].scheduledBy
			origEntry.scheduleData.scheduleExecution = traceEntry
		end
		traceEntry.traces[#traceEntry.traces + 1] = entry
		if event == "NewTimer" or event == "NewAnnounce" or event == "NewSpecialWarning" or event == "NewYell" then
			local obj = ...
			obj.testUseCount = 0
			obj.testUsedWithPreciseShow = {}
			obj.testUsedWithPreciseShowSucess = {}
			if obj.startedTimers then
				-- used to identify this table later to filter some schedule logic on it
				obj.startedTimers._testObjClass = "Timer.startedTimers"
			end
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
		if event == "ScheduleTask" then
			local traceId, time = ...
			---@class ScheduledTask
			scheduledTasks[traceId] = {
				scheduledBy = entry,
				rawTrigger = currentRawEvent,
				time = time
			}
			entry.scheduleData = {
				delta = time,
				time = time + (currentRawEvent and currentRawEvent[1] or 0)
			}
		elseif event == "UnscheduleTask" then
			local traceId = ...
			local scheduledTask = scheduledTasks[traceId]
			scheduledTask.scheduledBy.scheduleData.unscheduledBy = currentRawEvent
			entry.scheduleData = {unscheduledTask = scheduledTasks[traceId]}
			if scheduledTask.hideIfUnscheduled then
				entry.hidden = true
				scheduledTask.scheduledBy.hidden = true
			end
		elseif event == "ExecuteScheduledTaskPre" then
			local traceId = ...
			local scheduledTask = scheduledTasks[traceId]
			local scheduleTrigger = {scheduledTask.scheduledBy.scheduleData.time, "ExecuteScheduledTask", scheduledTask}
			currentEventKey = eventToString(scheduleTrigger, self.testData.log[#self.testData.log][1])
			currentRawEvent = scheduleTrigger
		elseif event == "ExecuteScheduledTaskPost" then
			-- Note: this is not guaranteed to trigger if the scheduled task throws an error, but that doesn't actually matter
			currentEventKey = nil
			currentRawEvent = nil
		end
	end
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
		DebugSound = DBM.Options.DebugSound
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
	DBM.Options.FilterVoidFormSay2 = false
	-- Don't spam guild members when testing
	DBM.Options.DisableGuildStatus = true
	DBM.Options.AutoRespond = false
	-- Don't show intro messages
	DBM.Options.SettingsMessageShown = true
	DBM.Options.NewsMessageShown2 = 3
end

function test:Setup(testData)
	trace = {}
	table.wipe(antiSpams)
	self.reporter = self:NewReporter(testData, trace)
	self.reporter:SetupErrorHandler()
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
	if self.reporter then self.reporter:UnsetErrorHandler() end
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
	if subEvent == "SPELL_CAST_START" and srcGuid and srcName then
		self.Mocks:LearnGuidNameMapping(srcGuid, srcName)
	end
end

local fakeUnitEventFrame = CreateFrame("Frame")

-- Inject an extra event from somewhere in the event loop, will be triggered after the current event is done processing.
-- Doing it like this is important to not mess up event trigger tracing.
function test:InjectExtraEvent(event, ...)
	self.extraEvents = self.extraEvents or {}
	self.extraEvents[#self.extraEvents + 1] = {0, event, ...}
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
		if target == self.logPlayerName then
			target = UnitName("player")
		end
		self.Mocks:UpdateTarget(uId, unitName, target)
		-- strip extra params to not provide the mod with more information than it would have in the real environment
		return self:InjectEvent(event, uId)
	end
	if event:match("^UNIT_SPELLCAST") and select("#", ...) > 3 then
		local uId, castGuid, spellId, unitName, unitHealth, unitPower, unitTarget = ...
		if unitTarget == "??" then
			unitTarget = nil
		end
		if unitTarget == self.logPlayerName then
			unitTarget = UnitName("player")
		end
		self.Mocks:UpdateTarget(uId, unitName, unitTarget)
		self.Mocks:UpdateUnitHealth(uId, unitName, unitHealth)
		self.Mocks:UpdateUnitPower(uId, unitName, unitPower)
		-- UNIT_HEALTH is usually used like this: UnitGUID(uId), check cid, then call UnitHealth(uId)
		if uId:match("^boss") then
			self:InjectExtraEvent("UNIT_HEALTH", uId)
		else
			-- Relevant for classic :(
			local guessedGuid = self.Mocks:GuessGuid(unitName)
			if guessedGuid then
				-- Annoyingly we'll need to do it by faking *target* because by default UNIT_* registrations are only for target in classic
				-- Easiest way to do so is to just treat target as a boss unit id
				self.Mocks:UpdateBoss("target", unitName, guessedGuid, true, true, true)
				self.Mocks:UpdateUnitHealth("target", nil, unitHealth)
				self:InjectExtraEvent("UNIT_HEALTH", "target")
			end
		end
		return self:InjectEvent(event, uId, castGuid, spellId) -- strip extra params
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
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		self.Mocks:SetFakeCLEUArgs(...)
		self:OnInjectCombatLog(self.Mocks.CombatLogGetCurrentEventInfo())
		dbmPrivate.mainEventHandler(dbmPrivate.mainFrame, event, self.Mocks.CombatLogGetCurrentEventInfo())
		self.Mocks:SetFakeCLEUArgs()
	else
		dbmPrivate.mainEventHandler(dbmPrivate.mainFrame, event, ...)
	end
	-- UNIT_* events will be mapped to _UNFILTERED if we fake them on the main frame, so we trigger them twice with just a random fake frame
	if event:match("^UNIT_") then
		dbmPrivate.mainEventHandler(fakeUnitEventFrame, event, ...)
	end
end

---@param log TestLogEntry[]
local function findRecordingPlayer(log)
	for _, v in ipairs(log) do
		if v[2] == "COMBAT_LOG_EVENT_UNFILTERED" then
			local srcFlags = v[6]
			local dstFlags = v[10]
			if bband(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
				return v[5]
			elseif bband(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
				return v[9]
			end
		end
	end
	error("failed to deduce who recorded the log based on flags, make sure at least one player has flags AFFILIATION_MINE and OBJECT_TYPE_PLAYER set")
end

local currentThread

local function errorHandlerWithStack(err)
	local msg = err .. "\n Stack:\n" .. debugstack(2)
	geterrorhandler()(msg)
end

---@param testData TestDefinition
function test:Playback(testData, timeWarp)
	coroutine.yield() -- To make sure all calls including the first come from the coroutine OnUpdate handler to correctly handle errors
	DBM:AddMsg("Starting test: " .. testData.name)
	if self.testCallback then
		self.testCallback("TestStart", testData, nil)
	end
	self.testData = testData
	-- Currently only required to correctly handle UNIT_TARGET messages.
	-- An alternative to this pre-parsing would be to use a special name/flag in UNIT_TARGET at test generation time for the recording player.
	-- However, this would mean we'd need to update all old tests, so preparsing it is for now. It should fine the player within the first few
	-- 100 messages or so anyways, so whatever.
	self.logPlayerName = findRecordingPlayer(testData.log)
	self.Mocks:SetInstanceInfo(testData.instanceInfo)
	if testData.instanceInfo.difficultyModifier then
		-- Only MC is supported right now
	   if testData.instanceInfo.instanceID == 409 then
			local heatLevel = testData.instanceInfo.difficultyModifier
			if heatLevel == 1 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458841, "Sweltering Heat", "DEBUFF")
			elseif heatLevel == 2 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458842, "Blistering Heat", "DEBUFF")
			elseif heatLevel == 3 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458843, "Molten Heat", "DEBUFF")
			end
	   end
   end
	local maxTimestamp = testData.log[#testData.log][1]
	local timeWarper = test.TimeWarper:New()
	self.timeWarper = timeWarper
	timeWarper:Start()
	timeWarper:SetSpeed(timeWarp)
	local startTime = timeWarper.fakeTime
	local ts = 0
	local i = 1
	while i <= #testData.log do
		local v
		-- Events may trigger additional events, e.g., UNIT_HEALTH from logs that contain health info about units
		if self.extraEvents and #self.extraEvents > 0 then
			v = self.extraEvents[#self.extraEvents]
			self.extraEvents[#self.extraEvents] = nil
			v[1] = ts
		else
			v = testData.log[i]
			i = i + 1
		end
		ts = v[1]
		timeWarper:WaitUntil(startTime + ts)
		currentEventKey = eventToString(v, maxTimestamp)
		currentRawEvent = v
		xpcall(self.InjectEvent, errorHandlerWithStack, self, select(2, unpack(v)))
		currentRawEvent = nil
		currentEventKey = nil
	end
	if timeWarp <= 5 then
		DBM:AddMsg("Test playback finished, waiting for delayed cleanup events (3 seconds)")
	end
	timeWarper:WaitFor(3.1) -- Events like AURA_REMOVED are only unregistered after 3 seconds for icon cleanup
	local extraTime = 0
	if DBM:InCombat() then
		-- Worldbosses wait for 15 seconds for wipe, everything else for 5. Using 3.1 for normal mods because checkWipe runs every 3 seconds.
		extraTime = difficulties.savedDifficulty == "worldboss" and 12.1 or 3.1
		DBM:AddMsg("DBM is still reporting in combat, waiting for " .. math.floor(extraTime) .. " more seconds")
		timeWarper:WaitFor(extraTime)
	end
	timeWarper:Stop()
	local reporter = self.reporter
	if DBM:InCombat() then
		reporter:FlagCombat(extraTime + 3.1)
	end
	local report = reporter:ReportWithHeader()
	DBM_TestResults_Export = DBM_TestResults_Export or {}
	DBM_TestResults_Export[testData.name] = report
	local cb = self.testCallback
	if cb then
		self.testCallback = nil -- coroutine scheduler also attempts to call this on failure, prevent calling it twice if this throws
		cb("TestFinish", testData, reporter)
	end
end

local frame = CreateFrame("Frame")
frame:Show()
frame:SetScript("OnUpdate", function(self)
	if currentThread then
		if coroutine.status(currentThread) == "dead" then
			currentThread = nil
			test:Teardown()
		else
			local ok, err = coroutine.resume(currentThread)
			if not ok then
				if err:match("^[^\n]*test stopped, time warp canceled") then
					return
				end
				geterrorhandler()(err)
				-- The error we encountered in the coroutine still belongs to the test, but anything after is just a bug in the callback
				if test.reporter then test.reporter:UnsetErrorHandler() end
				-- We might still need to call the callback to update UI etc in case the main function above throws
				-- The typically scenario were this happens is if findRecordingPlayer() throws
				if test.testCallback then
					test.testCallback("TestFinish", test.testData, test.reporter)
				end
			end
		end
	end
end)

---@class DBMInstanceInfo: InstanceInfo
---@field difficultyModifier number?

---@class TestDefinition
---@field name string Unique test ID.
---@field gameVersion GameVersion Required version of the game to run the test.
---@field addon string AddOn in which the mod under test is located.
---@field mod string|integer The boss mod being tested.
---@field ignoreWarnings? TestIgnoreWarnings Acknowledge findings to remove them from the report.
---@field instanceInfo DBMInstanceInfo Fake GetInstanceInfo() data for the test.
---@field playerName string? (Deprecated, no longer required) Name of the player who recorded the log.
---@field log TestLogEntry[] Log to replay

--[[
I'm a bit torn on this ignore warning stuff: having the warnings in the report also serves as acknowledgement, however,
you can't add comments there (cause they themselves would be a diff), so acknowledging them in the test definition is better.
But putting them there is extra work, extra code, and the ignore logic is somewhat messy and error-prone.

Maybe a better solution would be to support some kind of comment in the report?
]]

---@class TestIgnoreWarnings
---@field sharedWith boolean|string? By default the ignoreWarnings field is shared across all tests for the mod, set this to a regex to match only certain test names of the same mod. Set to false to not share this.
--- List of spell IDs or spell names that are used to detect phase changes, this surpresses spellID mismatch warnings caused by these spells.
---@field phaseChangeSpells string|number|(string|number)[]?
--- Suppress warning spellID mismatch warnings if the spell ID or spell name given as key is used to trigger a warning associated with a spell ID or spell name in the value. Set value to true to ignore all mismatches.
---@field spellIdMismatches table<string|number, string|number|boolean|(string|number)[]>?

---@class TestLogEntry
---@field [1] number
---@field [2] string

-- TODO: this isn't checked or used yet, also, we probably only need to distinguish the 3 main versions because SoD should be able to run all era mods
-- TODO: this also depends on how we load/not load mods for era vs. sod, will probably be relevant once MC releases
---@alias GameVersion "Retail"|"Classic"|"ClassicEra"|"SeasonOfDiscovery"

---@alias TestCallbackEvent "TestStart"|"TestFinish"

---@param callback? fun(event: TestCallbackEvent, testData: TestDefinition, reporter: TestReporter?)
function test:RunTest(testName, timeWarp, callback)
	timeWarp = timeWarp or DBM_Test_DefaultTimeWarp or 0
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
	-- Recover loading events for this mod stored above - must be done like this to support testing multiple mods in one addon in one session
	local loadingEvents = loadingTrace[modUnderTest]
	if not loadingEvents then
		error("could not observe mod loading events -- make sure that the addon is not yet loaded when starting the test")
	end
	self:Setup(testData) -- Must be done after loading the mod to prepare mod (stats, options, ...)
	local fakeLoadingEvent = {0, "ADDON_LOADED", testData.addon}
	currentEventKey = eventToString(fakeLoadingEvent, testData.log[#testData.log][1])
	currentRawEvent = fakeLoadingEvent
	for _, v in ipairs(loadingEvents) do
		self:Trace(modUnderTest, unpack(v))
	end
	currentEventKey = nil
	currentRawEvent = nil
	self.testCallback = callback
	currentThread = coroutine.create(self.Playback)
	local ok, err = coroutine.resume(currentThread, self, testData, timeWarp)
	if not ok then realErrorHandler(err) end
end

function test:StopTests()
	self.stopRequested = true
	if self.timeWarper then
		self.timeWarper:Stop()
	end
	 -- explicitly call teardown because the coroutine cancelation will only do so on the next frame which is too late for the stop-on-unload case
	self:Teardown()
end

---@param testsOrNames (TestDefinition|string)[]
---@param callback? fun(event: TestCallbackEvent, testData: TestDefinition, reporter: TestReporter?, count: integer, total: integer)
function test:RunTests(testsOrNames, timeWarp, callback)
	local startTime = GetTimePreciseSec()
	self.stopRequested = false
	local cr = coroutine.create(function()
		for i, testOrName in ipairs(testsOrNames) do
			local testName = type(testOrName) == "string" and testOrName or testOrName.name
			xpcall(self.RunTest, errorHandlerWithStack, self, testName, timeWarp, function(event, testDef, reporter)
				if callback then callback(event, testDef, reporter, i, #testsOrNames) end
			end)
			while self.testRunning do
				coroutine.yield()
			end
			if self.stopRequested then
				break
			end
		end
		DBM:Debug(("Running %d |1test;tests; took %.2f seconds real time."):format(#testsOrNames, GetTimePreciseSec() - startTime), 1)
	end)
	local f = CreateFrame("Frame")
	f:SetScript("OnUpdate", function()
		local status = coroutine.status(cr)
		if status == "suspended" then
			local ok, err = coroutine.resume(cr)
			if not ok then realErrorHandler(err) end
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
