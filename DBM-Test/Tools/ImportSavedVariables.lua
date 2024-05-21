local lfs = require "lfs"

local function usage()
	print("Usage: lua ImportSavedVariables.lua <path to SavedVariables/DBM-Test.lua> <path to folder containing reports>")
	os.exit(1)
end

local savedVarsName, reportsFolderName = ...

if not savedVarsName or not reportsFolderName then
	usage()
end

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

local reportFiles = {}
for entry in lfs.dir(reportsFolderName) do
	local fileName = reportsFolderName .. "/" .. entry
	if lfs.attributes(fileName, "mode") == "file" then
		local f, err = io.open(fileName, "r")
		if not f then error(err) end
		local testName = f:read("*l") and f:read("*l"):match("^Test: ([^\r\n]+)")
		if testName then
			reportFiles[testName] = fileName
		end
		f:close()
	end
end

for testName, testResult in pairs(testResults) do
	local reportFile = reportFiles[testName]
	if not reportFile then
		reportFile = reportsFolderName .. "/" .. testName:gsub("-", ""):gsub("/", "-"):gsub("\\", "-"):gsub(":", "-") .. ".lua"
		if lfs.attributes(reportFile) then
			print("Cannot write test report for test " .. testName .. " to " .. reportFile .. ": file already exists and is not a report for that test")
		end
	end
	print("Writing test report for test " .. testName .. " to " .. reportFile)
	local f, err = io.open(reportFile, "w+b")
	if not f then
		error(err)
	end
	f:write(testResult)
	f:close()
end
