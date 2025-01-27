require "CLI.Environment"

local lfs     = require "lfs"
local cliArgs = require "ArgParser"
local parser  = require "ParseTranscriptor"

local function logInfo(str, ...)
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	io.stderr:write(str, "\n")
end

local function logFatal(str, ...)
	logInfo("Error: " .. str, ...)
	os.exit(1)
end

local function usage()
	logInfo("Usage: lua CreateTest.lua <path to SavedVariables/Transcriptor.lua> [--log <log id> --dir <out path> --start <log offset> --end <log-offset> --noheader]")
	os.exit(1)
end

local args = cliArgs:Parse(...)
if not args[1] then
	usage()
end

local transcriptorFileName = args[1]
local file, err = io.open(transcriptorFileName, "rb")
if not file then
	error(err)
end
logInfo("Loading and parsing log...")
local ts = parser:New(file:read("*a"))
local logs = ts:GetLogs()

if #logs == 0 then
	logFatal("couldn't find any log Transcriptor log entries in the given file")
end

logInfo("Found %d Transcriptor logs", #logs)
for logId, v in ipairs(logs) do
	logInfo("%d: %s", logId, os.date("%Y-%m-%d %H:%M:%S", v.timestamp))
	for i, encounter in ipairs(v.encounters) do
		logInfo("\t%d.%d: %s (%d) %s, %.0f seconds, %d log entries",
			logId, i, encounter.name, encounter.id, encounter.success and "Kill" or "Wipe", encounter.endTime - encounter.startTime, encounter.endOffset - encounter.startOffset)
	end
end

logInfo("Use --log <id> to filter which log to parse, use * as wildcard")
logInfo("For example, --log 1.3 selects the third encounter in the first Transcriptor log, *.* (default) extracts all logs")

args["log"] = args["log"] or "*.*"
local logIdSelector, encounterIdSelector = args["log"]:match("([^.]*)%.([^.]*)")

if not logIdSelector or not encounterIdSelector then
	logFatal("Invalid --log parameter: " .. args["log"])
end

local ignoreCandidates = {}

local function exportTest(file, log, firstLine, lastLine)
	local testData = parser:NewTestGenerator(log, firstLine, lastLine, args["prefix"], args["keep-names"], args["ignore-leaks"], args["verbose-roles"])
	local resultStr = ""
	if not args["noheader"] and not args["no-header"] then
		resultStr = resultStr .. testData:GetHeaderString() .. "\n"
	end
	resultStr = resultStr .. testData:GetPlayersString() .. "\n"
	resultStr = resultStr .. testData:GetLogString() .. "\n"
	resultStr = resultStr .. testData:GetCompressedLogString() .. "}\n"
	if not args["keep-names"] then
		testData.anonymizer:CheckForLeaks(resultStr, function(str)
			io.stderr:write(("Detected leak in anonymizer, string %q looks non-anonymized\n"):format(str))
			if not args["ignore-leaks"] then
				io.stderr:write("use --ignore-leaks to ignore this\n")
				os.exit(1)
			end
		end)
	end
	file:write(resultStr)
	logInfo("Parsed %d lines into %d lines (%.1f%% filtered)", testData.stats.parsedLines, testData.stats.outputLines, (1 - testData.stats.outputLines / (testData.stats.parsedLines)) * 100)
	logInfo("%.1f seconds total, %.0f entries/second", testData.stats.logTime, testData.stats.outputLines / testData.stats.logTime)

	for k, v in pairs(testData:GetIgnoreCandidates()) do
		ignoreCandidates[k] = v
	end
end

local function selectorMatches(sel, id)
	return tonumber(sel) == id or sel == "*"
end

local function getFilename(log, encounter)
	local timestamp = os.date("%Y-%m-%d %H-%M-%S", math.floor(log.timestamp + (encounter.startTime or 0)))
	local outDir = transcriptorFileName:gsub("%.[jJ][sS][oO][nN]$", ""):gsub("%.[lL][uU][aA]$", "")
	lfs.mkdir(outDir)
	if not lfs.attributes(outDir) or lfs.attributes(outDir).mode ~= "directory" then
		logFatal("Failed to create output directory at " .. outDir)
	end
	return outDir .. ("/%s %s (%d) %s %.0fs %d lines.lua"):format(timestamp, encounter.name, encounter.id, encounter.success and "Kill" or "Wipe", encounter.endTime - encounter.startTime, encounter.endOffset - encounter.startOffset + 1)
end

local function createTest(log, encounter)
	local firstLine = args["start"] or encounter.startOffset or 1
	local lastLine = args["end"] or encounter.endOffset or #log.lines
	if lastLine <= 0 then -- support counting from the end with negative offsets
		lastLine = #log.lines - lastLine
	end
	if lastLine > #log.lines then
		logInfo("Log only has %d lines, clamping --end to %d", #log.lines, #log.lines)
	end
	local outFile
	if args["stdout"] then
		outFile = io.stdout
	else
		local fileName = getFilename(log, encounter)
		logInfo("\nCreating test file: " .. fileName)
		outFile = io.open(fileName, "w+b")
	end
	xpcall(function()
		exportTest(outFile, log, firstLine, lastLine)
	end, function(err)
		logInfo(debug.traceback(err, 3))
	end)
end

for logId, log in ipairs(logs) do
	if selectorMatches(logIdSelector, logId) then
		for i, encounter in ipairs(log.encounters) do
			if selectorMatches(encounterIdSelector, i) then
				createTest(log, encounter)
			end
		end
		if #log.encounters == 0 and encounterIdSelector == "*" then
			local fakeEncounter = {
				startTime = 0,
				endTime = tonumber(log.lines[#log.lines]:match("<([%d.]*)")) or 0,
				startOffset = 1,
				endOffset = #log.lines,
				name = "None",
				id = 0,
			}
			createTest(log, fakeEncounter)
		end
	end
end

if next(ignoreCandidates) then
	logInfo("Potentially ignoreable creature IDs (healed by players):")
	local sortedIds = {}
	for cid, name in pairs(ignoreCandidates) do
		sortedIds[#sortedIds + 1] = {cid = cid, name = name}
	end
	table.sort(sortedIds, function(e1, e2) return e1.cid < e2.cid end)
	for _, v in ipairs(sortedIds) do
		logInfo(v.cid .. ", -- " .. v.name)
	end
end
