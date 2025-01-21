-- This file is under the CC0 1.0 license, see https://creativecommons.org/publicdomain/zero/1.0/
---@meta

-- This interface is currently unstable and may be changed in non-backwards compatible ways without any notice.

---@alias DBMTestEvent "DBMTest_Start"|"DBMTest_Stop"|"DBMTest_Timewarp"|"DBMTest_Tick"|"DBMTest_Event"|"DBMTest_CombatLogEvent"

---@class DBMTest_CallbackHandlers
---@field Start fun(arg: DBMTestCallbackStart)?
---@field Stop fun(arg: DBMTestCallbackStop)?
---@field Timewarp fun(arg: DBMTestCallbackTimewarp)?
---@field Tick fun(elapsed: number)?
-- Called for every event the test injects except for COMBAT_LOG_EVENT_UNFILTERED
---@field Event fun(event: WowEvent, args...: string)? -- All events except combat log
-- Called for every COMBAT_LOG_EVENT_UNFILTERED the test injects. Tests replace a heavily filtered log, but this will still be called on the order of 1000s of times per test.
---@field CombatLogEvent fun(event: "COMBAT_LOG_EVENT_UNFILTERED", args...: string)? -- Only combat log events


---@class DBMTestCallbackStart
local Start = {
	Name			= nil, ---@type string
	-- Test run time in seconds
	Duration		= nil, ---@type number
	-- Approximate number of events to be injected, the test runner may generate extra events or filter events
	NumEvents		= nil, ---@type number
	-- Reference to a DBM mod that is expected to be triggered
	ModUnderTest	= nil, ---@type DBMMod
	-- Information about the first ENCOUNTER_START event that the test fires if the log contains one (most do).
	-- Included for informational purposes, prefer listening to DBMTest_Event for ENCOUNTER_START for triggering on all events.
	EncounterInfo	= nil, ---@type DBMTestEncounterInfo?
	-- Name of the simulated player, combat log events will be rewritten to match the current real player, but other events will refer to this name
	Perspective		= nil, ---@type string
	-- List of players participating in the fight, empty in some older test definitions
	Players			= nil, ---@type DBMTestPlayerDefinition[]
	-- Fake GetInstanceInfo() return value
	InstanceInfo	= nil, ---@type DBMInstanceInfo
	-- Mocks for global functions supported by DBM's tests, this is suitable for use as a Lua environment with setfenv, i.e., it has a metatable with __index = _G
	-- See DBM-Test/Mocks.lua for a list of functions that are mocked during tests. DBM mods loaded in test mode use this as their global environment.
	-- All mocked functions are simply a pass-through to the real globals while tests are not running.
	-- Examples:
	-- * Mocks.GetTime() returns the simulated time for timewarped tests
	-- * Mocks.CombatLogGetCurrentEventInfo() returns the current simulated combat log arguments
	-- * Mocks.Unit*() returns appropriate values reconstructed from the log for many common Unit* functions
	Mocks = {}
}

---@class DBMTestCallbackStop
local Stop = {
	Name		= nil, ---@type string
	-- Will be nil if the test got stopped by the user
	Reporter	= nil, ---@type DBMTestReporterPublic?
	-- Early test cancelation by the user
	Canceled	= nil, ---@type boolean
}

---@class DBMTestCallbackTimewarp
local Timewarp = {
	-- Timewarp factor, value <= 0 indicates dynamic speed that tries to play back the log as fast as possible.
	Speed		= nil, ---@type number
	-- Time is frozen, i.e., the test is temporarily paused
	Frozen		= nil, ---@type boolean
	Timewarper	= nil, ---@type DBMTestTimewarperPublic
}

---@class DBMTestEncounterInfo
local EncounterInfo = {
	EncounterId		= nil, ---@type number
	EncounterName	= nil, ---@type string
	DifficultyId	= nil, ---@type number
	GroupSize		= nil, ---@type number
	-- Time in seconds after which the ENCOUNTER_START event happens during the test, this will be 0 for most tests, but logs may contain extra events that happen before the pull
	StartOffset		= nil, ---@type number
}

---@class DBMInstanceInfo: InstanceInfo
---@field difficultyModifier number?

---@class DBMTestPlayerDefinition
---@field [1] string Anonymized or real name
---@field [2] string Anonymized GUID
---@field role ("Tank"|"Healer"|"Dps"|"Unknown")? Detected role, nil if it can be derived from the anonymized name
---@field class string? Class in "filename" format, missing in older Transcriptor versions
---@field logRecorder boolean? True if this player recorded the log, this is not necessarily the same as the simulated player
---@field healer number? Set if a secondary role was detected, value between 0 and 1
---@field tank number? Set if a secondary role was detected, value between 0 and 1
---@field dps number? Set if a secondary role was detected, value between 0 and 1

---@class DBMTestTimewarperPublic
local Timewarper = {}
-- Register a frame with an OnUpdate handler for timewarping
---@param frame Frame
function Timewarper:RegisterFrame(frame) end

---@class DBMTestReporterPublic
local TestReporter = {}

---@return "Success"|"Failure"
function TestReporter:GetResult() end

-- True if the mod threw any errors during the test, also returns true for errors that were allowed to propagate during the test run.
---@return boolean
function TestReporter:HasErrors() end

-- Pass on any errors that happened to the default error handler.
function TestReporter:ReportErrors() end

-- Generate a neatly formatted test report.
---@return string
function TestReporter:Report() end

-- Show the report as created by :Report() in a popup.
function TestReporter:ShowReport() end
