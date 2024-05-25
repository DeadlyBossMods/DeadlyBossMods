---@class DBMTest
local test = DBM.Test

test.Registry = {
	---@type table<string, TestDefinition>
	tests = {},
	---@type table<string, string>
	expectedResults = {},
	---@type string[]
	sortedTests = {}
}

local testsByMod = {}

---@param def1 TestDefinition
---@param def2 TestDefinition
local function testsShareIgnores(def1, def2)
	return not (def1.ignoreWarnings and def1.ignoreWarnings.sharedWith ~= nil and not (type(def1.ignoreWarnings.sharedWith) == "string" and def2.name:match(tostring(def1.ignoreWarnings.sharedWith)))
		or def2.ignoreWarnings and def2.ignoreWarnings.sharedWith ~= nil and not (type(def2.ignoreWarnings.sharedWith) == "string" and def1.name:match(tostring(def2.ignoreWarnings.sharedWith))))
end

---@param def TestDefinition
---@param otherDefs TestDefinition[]
local function propagateIgnores(def, otherDefs)
	for _, otherDef in ipairs(otherDefs) do
		if testsShareIgnores(def, otherDef) then
			if def.ignoreWarnings and otherDef.ignoreWarnings and def.ignoreWarnings ~= otherDef.ignoreWarnings then
				error(("duplicate ignoreWarnings definition for mod %s, only a single test may set ignoreWarnings for a mod unless ignoreWarnings.thisTestOnly is set"):format(def.mod), 3)
			end
			otherDef.ignoreWarnings = otherDef.ignoreWarnings or def.ignoreWarnings
			def.ignoreWarnings = otherDef.ignoreWarnings or def.ignoreWarnings
		end
	end
end

local function processIgnores(ignores)
	if not ignores or not ignores.phaseChangeSpells then
		return
	end
	ignores.spellIdMismatches = ignores.spellIdMismatches or {}
	if type(ignores.phaseChangeSpells) ~= "table" then
		ignores.phaseChangeSpells = {ignores.phaseChangeSpells}
	end
	for _, spell in ipairs(ignores.phaseChangeSpells) do
		if ignores.spellIdMismatches[spell] then
			error("spell " .. spell .. " is used in both phaseChangeSpells and spellIdMismatches", 3)
		end
		ignores.spellIdMismatches[spell] = true
	end
end

---@param def TestDefinition
function test:DefineTest(def)
	if self.Registry.tests[def.name] then
		error("duplicate test name " .. def.name, 2)
	end
	self.Registry.tests[def.name] = def
	table.insert(self.Registry.sortedTests, def.name)
	testsByMod[def.mod] = testsByMod[def.mod] or {}
	processIgnores(def.ignoreWarnings)
	propagateIgnores(def, testsByMod[def.mod])
	table.insert(testsByMod[def.mod], def)
end

-- Set the expected result of a test
function test:Report(report)
	local testName = report:match("Test:%s+([^\n]*)\r?")
	if self.Registry.expectedResults[testName] then
		error("duplicate expected report for " .. testName, 2)
	end
	self.Registry.expectedResults[testName] = report
end
