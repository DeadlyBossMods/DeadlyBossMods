---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
local CL = DBM_COMMON_L

---@class DBMTest
local test = private:GetPrototype("DBMTest")
DBM.Test = test

-- Indicates whether a test is currently running.
test.testRunning = false

-- Overriden by DBM-Test once loaded.
-- This field is intentionally set in an odd way to prevent LuaLS from suggesting this function.
local traceField = "Trace"
test[traceField] = function() end

local LoadAddOn = _G.C_AddOns.LoadAddOn or LoadAddOn ---@diagnostic disable-line:deprecated

function test:Load()
	local loaded, err = LoadAddOn("DBM-Test")
	if not loaded then
		DBM:AddMsg("Failed to load DBM-Test: " .. (_G["ADDON_" .. err] or CL.UNKNOWN))
		return loaded, err
	end
	return true
end

function test:LoadAllTests()
	local numTestAddOnsFound = 0
	if not self:Load() then
		return nil
	end
	for i = 1, C_AddOns.GetNumAddOns() do
		if C_AddOns.GetAddOnMetadata(i, "X-DBM-Test") then
			numTestAddOnsFound = numTestAddOnsFound + 1
			C_AddOns.LoadAddOn(i)
		end
	end
	return numTestAddOnsFound
end

function test:TestsLoaded()
	return self.Registry ~= nil and #self.Registry.sortedTests > 0
end

local function checkTestRunning()
	if not DBM.Test.testRunning or not DBM.Test.timeWarper then
		DBM:AddMsg("No test is currently running")
		return false
	end
	return true
end

function test:HandleCommand(testName, timeWarp)
	timeWarp = timeWarp and tonumber(timeWarp:match("(%d+)"))
	local numTestAddOnsFound = self:LoadAllTests()
	if not numTestAddOnsFound then return end
	if numTestAddOnsFound == 0 then
		DBM:AddMsg("No test AddOns installed, install an alpha or dev version of DBM to get DBM-Test-* mods.")
	end
	if testName:lower() == "list" or testName:lower() == "help" then
		DBM:AddMsg("Available tests:")
		for _, v in ipairs(self.Registry.sortedTests) do
			DBM:AddMsg("  " .. v)
		end
		if #self.Registry.sortedTests == 0 then
			DBM:AddMsg("  (none)")
		end
		DBM:AddMsg("/dbm test freeze -- freeze a currently running test")
		DBM:AddMsg("/dbm test resume -- resume a frozen test")
		DBM:AddMsg("/dbm test toggle-freeze -- freeze or resume a running test")
		DBM:AddMsg("/dbm test <name> <time warp factor> -- execute a test")
		DBM:AddMsg("/dbm test * <time warp factor> -- run all tests")
		DBM:AddMsg("<name> can be a prefix, e.g., /dbm test Dragonflight runs all tests for Dragonflight.")
		DBM:AddMsg("/dbm test clear -- clear exported test data")
	elseif testName:lower() == "stop" then
		test:StopTests()
		DBM:AddMsg("Stopping running tests.")
	elseif testName:lower() == "clear" then
		DBM_TestResults_Export = {}
		DBM:AddMsg("Cleared exported test results.")
	elseif testName:lower() == "freeze" then
		if not checkTestRunning() then
			return
		end
		DBM.Test.timeWarper:Freeze()
	elseif testName:lower() == "resume" then
		if not checkTestRunning() then
			return
		end
		DBM.Test.timeWarper:Resume()
	elseif testName:lower() == "toggle-freeze" then
		if not checkTestRunning() then
			return
		end
		DBM.Test.timeWarper:ToggleFreeze()
	else
		local tests = {}
		if testName == "*" then
			testName = ""
		end
		for _, v in ipairs(self.Registry.sortedTests) do
			if v:sub(1, #testName) == testName then
				tests[#tests + 1] = v
			end
		end
		if #tests == 0 then
			DBM:AddMsg("No tests matching prefix " .. testName .. " found, run /dbm test list to see available tests.")
			return
		end
		local successes = 0
		self:RunTests(tests, timeWarp, nil, function(event, test, testOptions, report, count, totalTests)
			if event ~= "TestFinish" then return end
			DBM:AddMsg("Test " .. test.name .. " finished, result: " .. report:GetResult())
			if report:GetResult() == "Success" then
				successes = successes + 1
			end
			if report:HasErrors() then
				report:ReportErrors()
			end
			if count == totalTests and totalTests > 1 then
				DBM:AddMsg(("%d/%d tests succeeded!"):format(successes, totalTests))
			end
		end)
	end
end

---@type table<Frame>
test.framesForTimeWarp = {}

function test:RegisterTimeWarpFrame(frame)
	-- Frames are registered on DBM load -- which is before the full testing module containing the time warper loads
	if test.TimeWarper then
		test.TimeWarper:RegisterFrame(frame)
	else
		test.framesForTimeWarp[frame] = true
	end
end

-- Expose DBM private's namespace for tests.
-- These functions are intentionally disabled in release builds to prevent people from using these to tamper with DBM's private namespace in release builds.

local function checkDevBuild()
	return true
end

local localHooks = {}
local restoreLocalHooks = {}
local restorePrivates = {}

-- Temporarily change the value of a field in DBM's private namespace or update a local variable in a file.
-- Updating locals works by files registering a callback via RegisterLocalHook below.
function test:HookPrivate(key, value)
	if not checkDevBuild() then return end
	if localHooks[key] then
		restoreLocalHooks[key] = restoreLocalHooks[key] or {}
		for _, v in ipairs(localHooks[key]) do
			local old = v(value)
			if restoreLocalHooks[key][v] == nil then -- handle nested hooking calls
				restoreLocalHooks[key][v] = old
			end
		end
	end
	if private[key] ~= nil then -- FIXME: support privates that are currently nil
		if restorePrivates[key] == nil then
			restorePrivates[key] = private[key]
		end
		private[key] = value
	end
end

-- Register a function to change a file-local variable temporarily via HookPrivate
function test:RegisterLocalHook(id, hookingFunc)
	local entries = localHooks[id] or {}
	localHooks[id] = entries
	entries[#entries + 1] = hookingFunc
end

function test:UnhookPrivates()
	if not checkDevBuild() then return end
	for k, v in pairs(restorePrivates) do
		private[k] = v
	end
	table.wipe(restorePrivates)
	for _, v in pairs(restoreLocalHooks) do
		for func, val in pairs(v) do
			func(val)
		end
	end
	table.wipe(restoreLocalHooks)
end

function test:GetPrivate()
	if not checkDevBuild() then error() end
	return private
end
