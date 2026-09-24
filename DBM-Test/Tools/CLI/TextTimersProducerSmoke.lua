-- Run from DBM-Retail: lua DBM-Test/Tools/CLI/TextTimersProducerSmoke.lua
---@diagnostic disable: redundant-parameter
-- Load actual addon code with private WoW globals, not LuaLS-visible global mocks.
local mockGlobals = setmetatable({}, {__index = _G})
mockGlobals._G = mockGlobals
local function loadMock(path)
	local chunk = assert(loadfile(path, "t", mockGlobals))
	if setfenv then setfenv(chunk, mockGlobals) end -- Lua 5.1 / LuaJIT
	return chunk
end
local events, bars, schedules, formats, now = {}, {}, {}, 0, 10
mockGlobals.DBM_CORE_L = {}
mockGlobals.GetTime = function() return now end
mockGlobals.abs, mockGlobals.tinsert, mockGlobals.tremove = math.abs, table.insert, table.remove
mockGlobals.tContains = function(t, value)
	for _, entry in ipairs(t) do if entry == value then return true end end
	return false
end
local function removeEntry(t, value)
	for i, entry in ipairs(t) do if entry == value then table.remove(t, i); return end end
end
local prototypes = {DBM = {}, Timer = {}, DBMMod = {}, Announce = {}, DBMTest = {testRunning = false, Trace = function() end}}
local private = {isRetail = true}
function private:GetPrototype(name)
	if name == "StringUtils" then return {pformat = string.format, stripServerName = function(s) return s end} end
	if name == "TableUtils" then return {removeEntry = removeEntry} end
	return prototypes[name]
end
function private:GetModule() return {Schedule = function() end, Unschedule = function() end, ScheduleLoop = function() end} end
local DBM = prototypes.DBM
mockGlobals.DBM = DBM
DBM.Options = {HideDBMBars = true, TextTimersEnabled = false}
function DBM:IsRestricted() return false end
function DBM:IsNonPlayableGUID() return false end
function DBM:Unschedule(fn, _, id)
	if fn == removeEntry then schedules[id] = nil end
end
function DBM:ParseSpellIcon(icon) return icon end
local textState = {}
DBM.TextTimers = {}
function DBM.TextTimers:GetBarlessRemaining(id)
	local state = textState[id]
	if state then return state.paused or state.expires - now, state.paused ~= nil, state.keep end
end
function DBM:FireEvent(event, ...)
	local args = {...}
	events[#events + 1] = {event = event, args = args, count = select("#", ...)}
	local id = args[1]
	if event == "DBM_TimerBegin" and args[19] == true then
		textState[id] = {expires = now + args[3], keep = args[9]}
	elseif event == "DBM_TimerStop" then
		textState[id] = nil
	elseif event == "DBM_TimerPause" and textState[id] then
		textState[id].paused = textState[id].expires - now
	elseif event == "DBM_TimerResume" and textState[id] then
		textState[id].expires = now + textState[id].paused
		textState[id].paused = nil
	elseif event == "DBM_TimerUpdate" and textState[id] then
		textState[id].expires = now + args[3] - args[2]
	end
end
local DBT = {Options = {VarianceEnabled2 = false}}
mockGlobals.DBT = DBT
function DBT:GetBar(id) return bars[id] end
function DBT:CancelBar(id) bars[id] = nil end
function DBT:CreateBar(timer, id)
	local bar = {id = id, timer = timer, totalTime = timer}
	function bar:SetText() end
	bars[id] = bar
	return bar
end
loadMock("DBM-Core/modules/objects/Timer.lua")("DBM-Core", private)
local mod = {id = "TestMod", Options = {TimerOpt = true, TimerOptCVoice = 0}, timers = {}}
function mod:GetLocalizedTimerText()
	formats = formats + 1
	return "Test Timer"
end
function mod:Schedule(delay, fn, _, id) schedules[id] = delay end
function mod:Unschedule(fn, _, id) schedules[id] = nil end
local function newTimer()
	return setmetatable({id = "Timer1", type = "cd", simpType = "cd", option = "TimerOpt", mod = mod, timer = 12, icon = 136116, startedTimers = {}}, {__index = prototypes.Timer})
end
local function clear()
	for k in pairs(events) do events[k] = nil end
	for k in pairs(schedules) do schedules[k] = nil end
	for k in pairs(bars) do bars[k] = nil end
	for k in pairs(textState) do textState[k] = nil end
	formats = 0
	mod.Options.TimerOpt = true
	mod.isTrashMod = false
	DBM.Options.DontShowBossTimers = false
	DBM.Options.DontShowTrashTimers = false
end
local function begin()
	for _, event in ipairs(events) do if event.event == "DBM_TimerBegin" then return event.args end end
end
local timer = newTimer()
assert(timer:Start(12) == nil and not begin() and not next(bars) and not next(schedules) and formats == 0, "disabled hidden bars did unnecessary work")
DBM.Options.TextTimersEnabled = true
clear()
timer = newTimer()
timer:Start(12)
assert(begin() and begin()[18] == false and begin()[19] == true and events[1].count == 19 and not next(bars) and formats == 1, "hidden start failed barless callback contract")
assert(schedules.Timer1 == 12, "barless start did not schedule removal")
now = 12
timer:Pause()
assert(not schedules.Timer1 and DBM.TextTimers:GetBarlessRemaining("Timer1") == 10, "barless pause failed")
now = 18
timer:Resume()
assert(schedules.Timer1 == 10, "barless resume failed")
timer:AddTime(3)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 13 and schedules.Timer1 == 13, "barless AddTime failed")
timer:RemoveTime(2)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 11 and schedules.Timer1 == 11, "barless RemoveTime failed")
timer:Update(2, 8)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 6, "barless Update failed")
timer:UpdateName("Renamed")
timer:UpdateIcon(135812)
now = 19
timer:UpdateKey(100)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 5, "barless UpdateKey failed")
timer:Stop()
assert(not DBM.TextTimers:GetBarlessRemaining("Timer1") and not schedules.Timer1, "barless Stop failed")
clear()
timer = newTimer()
timer:Start(12)
timer:HardStop()
assert(not DBM.TextTimers:GetBarlessRemaining("Timer1") and not schedules.Timer1, "barless HardStop leaked scheduled cleanup")
clear()
mod.Options.TimerOpt = false
newTimer():Start(12)
assert(not begin() and formats == 0, "unchecked timer produced hidden text")
clear()
DBM.Options.DontShowBossTimers = true
newTimer():Start(12)
assert(not begin() and formats == 0, "boss category suppression produced text")
clear()
mod.isTrashMod = true
DBM.Options.DontShowTrashTimers = true
newTimer():Start(12)
assert(not begin() and formats == 0, "trash category suppression produced text")
clear()
timer = newTimer()
timer.simpType, timer.type = "cdnp", "cdnp"
timer:Start(12)
assert(not begin() and formats == 0, "nameplate-only timer produced text")
clear()
DBM.Options.HideDBMBars = false
timer = newTimer()
timer:Start(12)
assert(bars.Timer1 and begin() and begin()[18] == true and events[1].count == 18, "ordinary bar callback changed")
clear()
DBM.Options.HideDBMBars = true
timer = newTimer()
timer:Start(12)
DBM.Debug = function() end
local state = 0
mockGlobals.C_EncounterTimeline = {GetEventState = function() return state end}
loadMock("DBM-Core/modules/EncounterEvents.lua")("DBM-Core", private)
private.hardCodedTimers[42] = "Timer1"
private.hardCodedTimerEvents["Timer1"] = 42
now = 20
state = 1
DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(42)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 11, "mapped barless timeline pause failed")
now = 22
state = 0
DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(42)
assert(DBM.TextTimers:GetBarlessRemaining("Timer1") == 11, "mapped barless timeline resume failed")
state = 3
DBM:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(42)
assert(not DBM.TextTimers:GetBarlessRemaining("Timer1"), "mapped barless timeline cancel failed")
print("TextTimersProducerSmoke: OK")
