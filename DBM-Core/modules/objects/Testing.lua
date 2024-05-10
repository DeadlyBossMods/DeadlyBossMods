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

local restorePrivates = {}
-- Temporarily change the value of a field in DBM's private namespace.
-- DBM explicitly exposes Hook functions to write some locals, e.g., private.HookLastInstanceMapID overrides the LastInstanceMapID local in core.
function test:HookPrivate(key, value)
	if not checkDevBuild() then return end
	if private["Hook" .. key] then
		local old = private["Hook" .. key](value)
		-- Only store old value once since it may be hooked multiple times
		restorePrivates[key] = restorePrivates[key] or old
	else
		restorePrivates[key] = restorePrivates[key] or private[key]
		private[key] = value
	end
end

function test:UnhookPrivates()
	if not checkDevBuild() then return end
	for k, v in pairs(restorePrivates) do
		if private["Hook" .. k] then
			private["Hook" .. k](v)
		else
			private[k] = v
		end
	end
	table.wipe(restorePrivates)
end

function test:GetPrivate(key)
	if not checkDevBuild() then return end
	return private[key]
end
