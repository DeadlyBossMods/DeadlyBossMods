---@class DBMTest
local test = DBM.Test

test.Registry = {
	---@type table<string, TestDefinition>
	tests = {},
	---@type string[]
	sortedTests = {}
}

---@type table<string|integer, TestDefinition[]>
local testsByMod = {}

function test:GetTestsForMod(mod)
	mod = type(mod) == "table" and mod.id or mod
	return testsByMod[mod]
end

---@param def TestDefinition
function test:DefineTest(def)
	if self.Registry.tests[def.name] then
		error("duplicate test name " .. def.name, 2)
	end
	self.Registry.tests[def.name] = def
	table.insert(self.Registry.sortedTests, def.name)
	def.mod = tostring(def.mod) -- Canonicalize mod ids to strings because DBM:NewMod() does so internally and the UI only has the stringified ID available
	testsByMod[def.mod] = testsByMod[def.mod] or {}
	table.insert(testsByMod[def.mod], def)
end

-- Deprecated, test reports were deleted in favor of DBM-Offline
function test:Report()
	DBM:Debug("called deprecated DBM.Test:Report()")
end
