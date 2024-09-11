require "CLI.Environment"

local lfs     = require "lfs"
local cliArgs = require "ArgParser"

local function usage()
	print("Usage: lua ImportTestResults.lua <path to SavedVariables/DBM-Test.lua> <path to folder containing reports> [--prefix <prefix>] [--create-files]")
	os.exit(1)
end

local args = cliArgs:Parse(...)

if #args < 2 then
	usage()
end

local savedVarsName, reportsFolderName = args[1], args[2]

local env = {}
if _VERSION == "Lua 5.1" then
	local f, err = loadfile(savedVarsName)
	if not f then error(err) end
	setfenv(f, env)
	f()
else
	---@diagnostic disable-next-line: redundant-parameter
	local f, err = loadfile(savedVarsName, nil, env)
	if not f then error(err) end
	f()
end
local testResults = env.DBM_TestResults_Export

-- Since this is a destructive operation on files let's be very sure that it is indeed a test report file, checks implemented here:
-- 1. Must be a ".lua" file (checked below)
-- 2. First line must be a test report definition
-- 3. Second line must be test name
-- 4. Third line must be the name of DBM AddOn/Mod
-- 5. All main sections must be there
local function scanTestReportFile(file)
	local line1 = file:read("*l")
	if not line1 or not line1:match("^DBM%.Test:Report%[%[\r?$") then return end
	local line2 = file:read("*l")
	local testName = line2 and line2:match("^Test: ([^\r\n]+)")
	if not testName then return end
	local line3 = file:read("*l")
	if not line3 or not line3:match("^Mod:  DBM%-[^/]*/[^/]*$") then return end
	local sections = {
		["Findings"] = true,
		["Timers"] = true,
		["Announces"] = true,
		["Special warnings"] = true,
		["Yells"] = true,
		["Event trace"] = true,
	}
	for line in file:lines() do
		local section = line:match("^([%w%s]+):\r?$")
		if section then
			sections[section] = nil
		end
	end
	if next(sections) then
		return
	end
	file:seek("set", 0)
	return testName, file:read("*a")
end

local reportFiles = {}
for entry in lfs.dir(reportsFolderName) do
	local fileName = reportsFolderName .. "/" .. entry
	if fileName:match("%.lua$") and lfs.attributes(fileName, "mode") == "file" then
		local f, err = io.open(fileName, "rb")
		if not f then error(err) end
		local testName, contents = scanTestReportFile(f)
		if testName then
			reportFiles[testName] = {fileName = fileName, contents = contents}
		end
		f:close()
	end
end

local function testNameToFilename(testName)
	testName = testName:gsub("^[^/]*/[^/]*/", "")
	return testName:gsub("-", ""):gsub("/", "-"):gsub("\\", "-"):gsub(":", "-")
end

local function handleResult(testName, testResult)
	local reportFile = reportFiles[testName] and reportFiles[testName].fileName
	local oldResult = reportFiles[testName] and reportFiles[testName].contents
	if not reportFile and not args["create-files"] then
		print("no file found for test '" .. testName .. "' use --create-files to create one")
		return
	end
	if not reportFile then
		reportFile = reportsFolderName .. "/" .. testNameToFilename(testName) .. ".lua"
		if lfs.attributes(reportFile) then
			print("Cannot write test report for test " .. testName .. " to " .. reportFile .. ": file already exists and is not a report for that test")
		end
	end
	if testResult ~= oldResult then
		print("Writing updated report for test " .. testName .. " to " .. reportFile)
		local f, err = io.open(reportFile, "w+b")
		if not f then
			error(err)
		end
		f:write(testResult)
		f:close()
	end
end

for name, result in pairs(testResults) do
	if not args.prefix or name:match("^" .. args.prefix) then
		handleResult(name, result)
	end
end
