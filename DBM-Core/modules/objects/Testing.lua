---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMTest
local test = private:GetPrototype("DBMTest")
DBM.Test = test

-- Overriden by DBM-Test once loaded.
-- This field is intentionally set in an odd way to prevent LuaLS from suggesting this function.
local traceField = "Trace"
test[traceField] = function() end

function test:HandleCommand(args)
	local numTestAddOnsFound = 0
	C_AddOns.LoadAddOn("DBM-Test")
	for i = 1, C_AddOns.GetNumAddOns() do
		if C_AddOns.GetAddOnMetadata(i, "X-DBM-Test") then
			numTestAddOnsFound = numTestAddOnsFound + 1
			C_AddOns.LoadAddOn(i)
		end
	end
	if numTestAddOnsFound == 0 then
		DBM:AddMsg("No test AddOns installed, install an alpha or dev version of DBM to get DBM-Test-* mods.")
	end
	if args:lower() == "list" or args:lower() == "help" then
		DBM:AddMsg("Available tests:")
		for _, testName in ipairs(self.Registry.sortedTests) do
			DBM:AddMsg("  " .. testName)
		end
		if #self.Registry.sortedTests == 0 then
			DBM:AddMsg("  (none)")
		end
		DBM:AddMsg("Run /dbm test <name> to execute a test.")
	else
		if not self.Registry.tests[args] then
			DBM:AddMsg("Test " .. args .. " not found, run /dbm test list to see available tests.")
			return
		end
		self:RunTest(args)
	end
end

-- Expose DBM private's namespace for tests.
-- These functions are intentionally disabled in release builds to prevent people from using these to tamper with DBM's private namespace in release builds.

local function checkDevBuild()
--[===[@non-alpha@
	error("this function is only available in dev and alpha builds of DBM", 3)
	do return false end -- Safety to prevent people from just overriding error() to circumvent the alpha check.
--@end-non-alpha@]===]
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

function test:GetPrivate(key)
	if not checkDevBuild() then return end
	return private[key]
end
