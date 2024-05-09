---@class DBMTest
local test = DBM.Test

test.Registry = {
	tests = {},
	expectedResults = {},
	sortedTests = {}
}

---@param args TestDefinition
function test:DefineTest(args)
	if self.Registry.tests[args.name] then
		error("duplicate test name " .. args.name, 2)
	end
	self.Registry.tests[args.name] = args
	table.insert(self.Registry.sortedTests, args.name)
end

-- Set the expected result of a test
function test:Report(report)
	local testName = report:match("Test:%s+([^\n]*)\r?")
	if self.Registry.expectedResults[testName] then
		error("duplicate expected report for " .. testName, 2)
	end
	self.Registry.expectedResults[testName] = report
end
