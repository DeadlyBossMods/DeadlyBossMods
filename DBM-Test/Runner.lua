
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

local function stripMarkup(text)
	if type(text) ~= "string" then
		return text
	end
	text = text:gsub("|r", "")
	text = text:gsub("|c%x%x%x%x%x%x%x%x", "")
	text = text:gsub("|T[^|]-|t", "")
	text = text:gsub("|H[^|]-|h", "")
	text = text:gsub("|h", "")
	text = text:gsub("\t", "\\t")
	text = text:gsub("\n", "\\n")
	text = text:gsub("\r", "\\r")
	return text:trim()
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
			result = result .. tostring(stripMarkup(event[i])) -- CHAT_MSG_MONSTER_* sometimes contains markup
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

local function injectTestDataIntoWarningObject(obj)
	obj.testUseCount = 0
	obj.testUsedWithPreciseShow = {}
	obj.testUsedWithPreciseShowSucess = {}
	if obj.startedTimers then
		-- used to identify this table later to filter some schedule logic on it
		obj.startedTimers._testObjClass = "Timer.startedTimers"
	end
end

---@param mod DBMModOrDBM
function test:Trace(mod, event, ...)
	if not self.testRunning then return end
	if event == "SetTimerProperty" or event == "StopTimer" or event == "UpdateTimer" or event == "PauseTimer" or event == "ResumeTimer" then
		-- Target timers may refer to the *real* player's name, we only have two options to fix that:
		-- 1. mangle the timer information here
		-- 2. add code to every single timer method in Timer.lua
		-- This implementation here is option 1.
		-- You might say there is option 3: just don't ever tell the mod the real player's name, but that's not feasible because
		-- the mod may do local playerName = UnitName("player") on load and the perspective may change between tests
		local timer, timerId = ...
		if timer.type == "target" then
			-- Timer IDs are just \t-separated list of name and timer format args, target timers always have the target as first arg
			local firstTimerArg = timerId:match("[^\t]*\t([^\t]*)")
			if firstTimerArg == UnitName("player") then
				timerId = timerId:gsub("([^\t]*)\t([^\t]*)", "%1\tPlayerName")
				return self:Trace(mod, event, timer, timerId, select(3, ...)) -- Not a potentially infinite loop because "PlayerName" is not a valid player name
			end
		end
	end
	-- Common source of non-determinism are timers that get canceled exactly as they expire, e.g., canceling on SPELL_AURA_REMOVED due normal buff expiry.
	-- It looks like the reason for this non-determinism is that we invoke the OnUpdate handlers in an effectively random order.
	-- Ultimately this is something that should probably be fixed somehow, but it's somewhat annoying (see comment in TimeWarper.lua).
	if event == "StopTimer" then
		-- If this ever happens with an UnscheduleTask event then we have a small problem, because the resulting task execution is an actual difference that's hard to get rid of here
		local _, timerId = ...
		local bar = DBT:GetBar(timerId)
		local remaining = bar and bar.timer or 0
		-- I see dead timers, they don't know they are dead
		if remaining <= 1/30 then -- Less than one frame left (at test default 30 fps)
			return
		end
	end
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
		if not obj.testUsedWithPreciseShow then
			injectTestDataIntoWarningObject(obj)
		end
		obj.testUsedWithPreciseShow[maxTotal] = true
		return
	elseif event == "CombinedWarningPreciseShowSuccess" then
		local obj, maxTotal = ...
		if not obj.testUsedWithPreciseShowSucess then
			injectTestDataIntoWarningObject(obj)
		end
		obj.testUsedWithPreciseShowSucess[maxTotal] = true
		return
	end
	if event == "SetStage" then
		if self.timeWarper then
			self.timeWarper:OnStageChanged(...)
		end
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
			injectTestDataIntoWarningObject(obj)
		end
		if event == "StartTimer" or event == "ShowAnnounce" or event == "ShowSpecialWarning" or event == "ShowYell" then
			local obj = ...
			if not obj then
				geterrorhandler()("trace of type " .. event .. " without warning object ")
			end
			if not obj.testUseCount then
				self.reporter:Taint("StrayObjects")
				injectTestDataIntoWarningObject(obj)
			end
			obj.testUseCount = obj.testUseCount + 1
		end
		if event == "EndCombat" then
			traceEntry.didTriggerCombatEnd = true
		end
		if event == "AntiSpam" then
			local id, _, result = ...
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

function test:SetupDBMOptions(defaults, disableFilters, deterministicSorting)
	-- Change settings to not depend on user configuration
	-- Set DBM settings to default, but don't touch DBM.Options itself because it is saved
	local dbmOptions = {
		DebugMode = DBM.Options.DebugMode,
		DebugLevel = DBM.Options.DebugLevel,
		DebugSound = DBM.Options.DebugSound
	}
	DBM:AddDefaultOptions(dbmOptions, defaults)
	self:HookDbmVar("Options", dbmOptions)
	if disableFilters then
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
	end
	if deterministicSorting then
		-- Order player names by log order because the default is non-deterministic due to the replaying player's name sneaking in during replay
		DBM.Options.WarningAlphabetical = false
		DBM.Options.SWarningAlphabetical = false
	end
	-- Forced settings for all tests
	-- Don't spam guild members when testing
	DBM.Options.DisableGuildStatus = true
	DBM.Options.AutoRespond = false
	-- Don't show intro messages
	DBM.Options.SettingsMessageShown = true
	DBM.Options.NewsMessageShown2 = 3
end

---@param testOptions DBMTestOptions
function test:Setup(testData, testOptions)
	trace = {}
	table.wipe(antiSpams)
	self.reporter = self:NewReporter(testData, trace)
	self.reporter:SetupErrorHandler(testOptions.allowErrors)
	self.testRunning = true
	self:SetupHooks()
	-- Store stats for all mods to not mess them up if the test or a mod trigger is bad
	for _, mod in ipairs(DBM.Mods) do
		-- Do not use DBM:ClearAllStats() here as it also messes with the saved table
		self:HookModVar(mod, "stats", DBM:CreateDefaultModStats())
		-- Avoid the recombat limit when testing the same mod multiple times
		---@diagnostic disable-next-line: inject-field
		mod.lastWipeTime = nil
		---@diagnostic disable-next-line: inject-field
		mod.lastKillTime = nil
		-- TODO: validate that stats was changed as expected on test end
	end
	if testOptions.playground then
		-- Even in playground mode we still need this, there are some options we simply must always override: syncing to your guild, auto-reply etc
		self:SetupDBMOptions(DBM.Options)
	else
		-- Change settings to not depend on user configuration
		self:SetupDBMOptions(DBM.DefaultOptions, true, true)
		self:SetupModOptions()
	end
end

function test:ForceCVar(cvar, value)
	self.restoreCVars = self.restoreCVars or {}
	if self.restoreCVars[cvar] == nil then
		self.restoreCVars[cvar] = GetCVar(cvar)
	end
	SetCVar(cvar, value)
end

function test:RestoreCVar(cvar)
	self.restoreCVars = self.restoreCVars or {}
	if self.restoreCVars[cvar] then
		SetCVar(cvar, self.restoreCVars[cvar])
		self.restoreCVars[cvar] = nil
	end
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
	if (subEvent == "SPELL_CAST_START" or subEvent == "SWING_DAMAGE" or subEvent == "SWING_MISSED") and srcGuid and srcName then
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
		if target == self.logPlayerName or self.allOnYou and self.players[target] then
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
		if unitTarget == self.logPlayerName or self.allOnYou and self.players[unitTarget] then
			unitTarget = UnitName("player")
		end
		-- For some reason UNIT_SPELLCAST events from units where UnitName() is nil exist and for some reason those come from arena unit IDs in raids...?
		if unitName then
			self.Mocks:UpdateTarget(uId, unitName, unitTarget)
			self.Mocks:UpdateUnitHealth(uId, unitName, unitHealth)
			self.Mocks:UpdateUnitPower(uId, unitName, unitPower)
		end
		-- UNIT_HEALTH is usually used like this: UnitGUID(uId), check cid, then call UnitHealth(uId)
		if uId:match("^boss") then
			self:InjectExtraEvent("UNIT_HEALTH", uId)
			self:InjectExtraEvent("UNIT_POWER_UPDATE", uId)
		else
			-- Relevant for classic :(
			local guessedGuid = self.Mocks:GuessGuid(unitName)
			if guessedGuid then
				-- Annoyingly we'll need to do it by faking *target* because by default UNIT_* registrations are only for target in classic
				-- Easiest way to do so is to just treat target as a boss unit id
				self.Mocks:UpdateBoss("target", unitName, guessedGuid, true, true, true)
				self.Mocks:UpdateTarget("target", unitName, unitTarget)
				self.Mocks:UpdateUnitHealth("target", nil, unitHealth)
				self:InjectExtraEvent("UNIT_HEALTH", "target")
				self:InjectExtraEvent("UNIT_POWER_UPDATE", "target")
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
	if event == "CHAT_MSG_RAID_BOSS_WHISPER" and select(2, ...) ~= self.logPlayerName and not self.allOnYou then
		return
	end
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		self.Mocks:SetFakeCLEUArgs(...)
		self:OnInjectCombatLog(self.Mocks.CombatLogGetCurrentEventInfo())
		dbmPrivate.mainEventHandler(dbmPrivate.mainFrame, event, self.Mocks.CombatLogGetCurrentEventInfo())
		DBM:FireEvent("DBMTest_CombatLogEvent", event, self.Mocks.CombatLogGetCurrentEventInfo())
		self.Mocks:SetFakeCLEUArgs()
	else
		dbmPrivate.mainEventHandler(dbmPrivate.mainFrame, event, ...)
		DBM:FireEvent("DBMTest_Event", event, ...)
	end
	-- UNIT_* events will be mapped to _UNFILTERED if we fake them on the main frame, so we trigger them twice with just a random fake frame
	if event:match("^UNIT_") then
		dbmPrivate.mainEventHandler(fakeUnitEventFrame, event, ...)
	end
end

---@param testData TestDefinition
local function findRecordingPlayer(testData)
	if testData.perspective then
		return testData.perspective
	end
	-- Older test files without an explicitly defined perspective had this implicitly encoded in flags
	for _, v in ipairs(testData.log) do
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
	error("failed to deduce who recorded the log, please set testData.perspective or make sure at least one player has flags AFFILIATION_MINE and OBJECT_TYPE_PLAYER set")
end

---@param testData TestDefinition
local function adjustFlagsForPerspective(testData, playerName, allOnYou)
	local clearFlags = bit.bnot(bit.bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID))
	for _, v in ipairs(testData.log) do
		if v[2] == "COMBAT_LOG_EVENT_UNFILTERED" then
			local srcName = v[5]
			local srcFlags = v[6]
			local dstName = v[9]
			local dstFlags = v[10]
			if bband(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
				srcFlags = bband(srcFlags, clearFlags)
				if srcName == playerName or allOnYou then
					srcFlags = srcFlags + COMBATLOG_OBJECT_AFFILIATION_MINE
				else
					srcFlags = srcFlags + COMBATLOG_OBJECT_AFFILIATION_PARTY
				end
				v[6] = srcFlags
			end
			if bband(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
				dstFlags = bband(dstFlags, clearFlags)
				if dstName == playerName or allOnYou then
					dstFlags = dstFlags + COMBATLOG_OBJECT_AFFILIATION_MINE
				else
					dstFlags = dstFlags + COMBATLOG_OBJECT_AFFILIATION_PARTY
				end
				v[10] = dstFlags
			end
		end
	end
end

local currentThread

local function errorHandlerWithStack(err)
	local msg = err .. "\n Stack:\n" .. debugstack(2)
	geterrorhandler()(msg)
end

local function extractEncounterInfo(log)
	local res ---@type DBMTestEncounterInfo?
	for _, v in ipairs(log) do
		if v[2] == "ENCOUNTER_START" then
			res = {
				StartOffset = v[1],
				EncounterId = v[3],
				EncounterName = v[4],
				DifficultyId = v[5],
				GroupSize = v[6],
			}
			break
		end
	end
	return res
end

---@param testData TestDefinition
---@param testOptions DBMTestOptions
function test:Playback(testData, timeWarp, testOptions)
	coroutine.yield() -- To make sure all calls including the first come from the coroutine OnUpdate handler to correctly handle errors
	DBM:AddMsg("Starting test: " .. testData.name)
	if self.testCallback then
		self.testCallback("TestStart", testData, testOptions, nil)
	end
	self.testData = testData
	self.testOptions = testOptions
	-- Currently only required to correctly handle UNIT_TARGET messages.
	-- An alternative to this pre-parsing would be to use a special name/flag in UNIT_TARGET at test generation time for the recording player.
	-- However, this would mean we'd need to update all old tests, so preparsing it is for now. It should fine the player within the first few
	-- 100 messages or so anyways, so whatever.
	local perspective = findRecordingPlayer(testData)
	if testOptions.perspective and testOptions.perspective ~= perspective or testOptions.allOnYou then
		self.reporter:Taint("Perspective", perspective, testOptions.perspective or testOptions.allOnYou and "Everyone")
	end
	self.logPlayerName = testOptions.perspective or perspective
	self.allOnYou = testOptions.allOnYou
	self.players = {}
	if testData.players then
		for _, v in ipairs(testData.players) do
			self.players[v[1]] = true
		end
	end
	adjustFlagsForPerspective(testData, self.logPlayerName, self.allOnYou)
	self.Mocks:SetInstanceInfo(testData.instanceInfo)
	DBM:ScenarioCheck(0)
	if testData.instanceInfo.difficultyModifier then
	   if testData.instanceInfo.instanceID == 409 then -- Molten Core
			local heatLevel = testData.instanceInfo.difficultyModifier
			if heatLevel == 1 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458841, "Sweltering Heat", "DEBUFF")
			elseif heatLevel == 2 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458842, "Blistering Heat", "DEBUFF")
			elseif heatLevel == 3 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 458843, "Molten Heat", "DEBUFF")
			end
		elseif testData.instanceInfo.instanceID == 469 then -- BWL
			local trials = testData.instanceInfo.difficultyModifier or 0
			if bit.band(trials, DBM.Difficulties.SOD_BWL_TRIAL_BLACK) ~= 0 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 467047, "Black Essence", "DEBUFF")
			end
			if bit.band(trials, DBM.Difficulties.SOD_BWL_TRIAL_GREEN) ~= 0 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 466416, "Green Trial", "DEBUFF")
			end
			if bit.band(trials, DBM.Difficulties.SOD_BWL_TRIAL_BLUE) ~= 0 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 466277, "Blue Trial", "DEBUFF")
			end
			if bit.band(trials, DBM.Difficulties.SOD_BWL_TRIAL_BRONZE) ~= 0 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 466071, "Bronze Trial", "DEBUFF")
			end
			if bit.band(trials, DBM.Difficulties.SOD_BWL_TRIAL_RED) ~= 0 then
				self.Mocks:ApplyUnitAura(UnitName("player"), UnitGUID("player"), 466261, "Red Trial", "DEBUFF")
			end
		end
   end
	local maxTimestamp = testData.log[#testData.log][1]
	local timeWarper = test.TimeWarper:New()
	self.timeWarper = timeWarper
	timeWarper:Start()
	timeWarper:SetSpeed(timeWarp)
	---@type DBMTestCallbackStart
	local testStartCallbackArgs = {
		Name = testData.name,
		Duration = maxTimestamp + 3.1,
		NumEvents = #testData.log,
		InstanceInfo = testData.instanceInfo,
		ModUnderTest = self.modUnderTest,
		EncounterInfo = extractEncounterInfo(testData.log),
		Perspective = self.logPlayerName,
		Players = testData.players or {},
		Mocks = self.Mocks:GetMockEnvironment()
	}
	DBM:FireEvent("DBMTest_Start", testStartCallbackArgs)
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
	if timeWarper.factor <= 5 then
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
	DBM:AddMsg("Test playback for test " .. testData.name .. " finished.")
	local reporter = self.reporter
	if DBM:InCombat() then
		reporter:FlagCombat(extraTime + 3.1)
	end
	---@type DBMTestCallbackStop
	local testStopCallbackArgs = {
		Name = test.testData.name,
		Reporter = reporter,
		Canceled = false
	}
	DBM:FireEvent("DBMTest_Stop", testStopCallbackArgs) -- Must fire before stopping the time warper otherwise Public/Example.lua breaks
	timeWarper:Stop()
	if not reporter:IsTainted() then
		DBM_TestResults_Export = DBM_TestResults_Export or {}
		DBM_TestResults_Export[testData.name] = reporter:ReportWithHeader()
	end
	local cb = self.testCallback
	if cb then
		self.testCallback = nil -- coroutine scheduler also attempts to call this on failure, prevent calling it twice if this throws
		xpcall(cb, realErrorHandler, "TestFinish", testData, testOptions, reporter)
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
					DBM:FireEvent("DBMTest_Stop", {Name = test.testData.name, Canceled = true})
					return
				end
				geterrorhandler()(err)
				-- The error we encountered in the coroutine still belongs to the test, but anything after is just a bug in the callback
				if test.reporter then test.reporter:UnsetErrorHandler() end
				-- We might still need to call the callback to update UI etc in case the main function above throws
				-- The typically scenario were this happens is if findRecordingPlayer() throws
				if test.testCallback then
					xpcall(test.testCallback, realErrorHandler, "TestFinish", test.testData, test.testOptions, test.reporter)
				end
			end
		end
	end
end)

---@class TestDefinition
---@field name string Unique test ID.
---@field gameVersion GameVersion Required version of the game to run the test.
---@field addon string AddOn in which the mod under test is located.
---@field mod string|integer The boss mod being tested.
---@field ignoreWarnings? TestIgnoreWarnings Acknowledge findings to remove them from the report.
---@field instanceInfo DBMInstanceInfo Fake GetInstanceInfo() data for the test.
---@field playerName string? (Deprecated, no longer required) Name of the player who recorded the log.
---@field perspective string? Player name from whose perspective the log gets replayed
---@field players DBMTestPlayerDefinition[]? Players participating in the fight (some players may have no log entries due to filtering)
---@field log TestLogEntry[] Log to replay
---@field ephemeral boolean? Set to true for tests imported from Transcriptor via the test UI


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
---@alias GameVersion "Any"|"Retail"|"Classic"|"ClassicEra"|"SeasonOfDiscovery"

---@alias TestCallbackEvent "TestStart"|"TestFinish"


---@class DBMTestOptions
---@field perspective string? Override the perspective from which the log is played back
---@field allOnYou boolean? Rewrite every single combat log entry to match the player
---@field allowErrors boolean? Throw errors immediately
---@field playground boolean? True if the test was started from playground mode

function test:OnBeforeLoadAddOn()
	self.testRunning = true
	-- Trace loading events to know about timer/warning constructor calls
	currentEventKey = "InternalLoading"
	currentRawEvent = {0, "InternalLoading"}
end

function test:OnAfterLoadAddOn()
	if currentEventKey == "InternalLoading" then
		currentEventKey = nil
		currentRawEvent = nil
		self.testRunning = false
	end
end

---@param callback? fun(event: TestCallbackEvent, testData: TestDefinition, testOptions: DBMTestOptions, reporter: TestReporter?)
---@param testOptions? DBMTestOptions
function test:RunTest(testNameOrdata, timeWarp, testOptions, callback)
	testOptions = testOptions or {}
	timeWarp = timeWarp or DBM_Test_DefaultTimeWarp or 0
	local testData
	if type(testNameOrdata) == "string" then
		testData = self.Registry.tests[testNameOrdata]
		if not testData then
			error("test " .. testNameOrdata .. " not found", 2)
		end
	elseif type(testNameOrdata) == "table" then
		testData = testNameOrdata
	else
		error("RunTest(): expected test name or definition as first parameter, got " .. type(testNameOrdata))
	end
	if self.testRunning then
		error("only a single test can run at a time")
	end
	if not DBM:GetModByName(testData.mod) then
		DBM:LoadModByName(testData.addon, true, true) -- calls the OnBefore/OnAfter handlers above
	end
	local modUnderTest = DBM:GetModByName(testData.mod)
	if not modUnderTest then
		error("could not find mod " .. testData.mod .. " after loading " .. testData.addon, 2)
	end
	self.modUnderTest = modUnderTest
	self:Setup(testData, testOptions) -- Must be done after loading the mod to prepare mod (stats, options, ...)
	-- Recover loading events for this mod stored above - must be done like this to support testing multiple mods in one addon in one session
	local loadingEvents = loadingTrace[modUnderTest]
	if not loadingEvents then
		self.reporter:Taint("ModEnv")
	else
		local fakeLoadingEvent = {0, "ADDON_LOADED", testData.addon}
		currentEventKey = eventToString(fakeLoadingEvent, testData.log[#testData.log][1])
		currentRawEvent = fakeLoadingEvent
		for _, v in ipairs(loadingEvents) do
			self:Trace(modUnderTest, unpack(v))
		end
	end
	if not GetLocale():match("^en") then
		self.reporter:Taint("Lang", GetLocale())
	end
	if testOptions.playground then
		self.reporter:Taint("Playground")
	end
	currentEventKey = nil
	currentRawEvent = nil
	self.testCallback = callback
	currentThread = coroutine.create(self.Playback)
	local ok, err = coroutine.resume(currentThread, self, testData, timeWarp, testOptions)
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
---@param callback? fun(event: TestCallbackEvent, testData: TestDefinition, testOptions: DBMTestOptions, reporter: TestReporter?, count: integer, total: integer)
---@param testOptions? DBMTestOptions
function test:RunTests(testsOrNames, timeWarp, testOptions, callback)
	testOptions = testOptions or {}
	local startTime = GetTimePreciseSec()
	self.stopRequested = false
	local cr = coroutine.create(function()
		for i, testOrName in ipairs(testsOrNames) do
			local testName = type(testOrName) == "string" and testOrName or testOrName.name
			xpcall(self.RunTest, errorHandlerWithStack, self, testName, timeWarp, testOptions, function(event, testDef, testOptions, reporter)
				if callback then
					xpcall(callback, realErrorHandler, event, testDef, testOptions, reporter, i, #testsOrNames)
				end
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
