require "CLI.Environment"

local cliArgs    = require "ArgParser"
local parser     = require "ParseTranscriptor"


local unpack = unpack or table.unpack -- Lua 5.1 compat

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
	logInfo("Usage: lua ConvertTranscriptor.lua <path to SavedVariables/Transcriptor.lua> [--log <log id> --start <log offset> --end <log-offset> --noheader]")
	os.exit(1)
end

local args = cliArgs:Parse(...)
if not args[1] then
	usage()
end

local file, err = io.open(args[1], "rb")
if not file then
	error(err)
end
local ts = parser:New(file:read("*a"))
local logs = ts:GetLogs()

if #logs == 0 then
	logFatal("couldn't find any log Transcriptor log entries in the given file")
end

logInfo("Found %d Transcriptor logs", #logs)
for logId, v in ipairs(logs) do
	logInfo("%d: %s", logId, os.date("%Y-%m-%d %H:%M:%d", v.timestamp))
	for i, encounter in ipairs(v.encounters) do
		logInfo("\t%d.%d: %s (%d) %s, %.0f seconds, %d log entries",
			logId, i, encounter.name, encounter.id, encounter.success and "Kill" or "Wipe", encounter.endTime - encounter.startTime, encounter.endOffset - encounter.startOffset)
	end
end

if not args["log"] and #logs == 1 then
	args["log"] = "1"
end

if not args["log"] and not args["start"] and not args["end"] and (#logs > 1 or logs[1] and #logs[1].encounters > 1) then
	logInfo("Found more than one encounter, please use --log <id> to specify which one to parse or specify --start, and --end referring to log offsets")
	logInfo("For example, --log 1.3 selects the third encounter in the first Transcriptor log")
end

local log
local firstLine, lastLine

if args["log"] then
	local logId, encounterId = args["log"]:match("(%d+)%.?(%d*)")
	log = logs[tonumber(logId)]
	encounterId = tonumber(encounterId)
	if not log then
		logFatal("Invalid log id %d", logId)
	end
	if not encounterId and #log.encounters == 1 then
		encounterId = 1
	end
	if not encounterId and #log.encounters > 1 and not args["start"] and not args["end"] then
		logFatal("No encounter offset given but log contains %d encounters", #log.encounters)
	elseif args["start"] and args["end"] then
		firstLine = args["start"]
		lastLine = args["end"]
		if lastLine > #log.lines then
			logInfo("Log only has %d lines, clamping --end to %d", #log.lines, #log.lines)
			lastLine = #log.lines
		end
	elseif not log.encounters[encounterId] then
		logFatal("Invalid encounter offset %s", tostring(encounterId))
	else
		firstLine = log.encounters[encounterId].startOffset
		lastLine = log.encounters[encounterId].endOffset
	end
end

local testData = parser:NewTestGenerator(log, firstLine, lastLine, args["prefix"], args["keep-names"], args["ignore-leaks"], args["verbose-roles"])

if not args["noheader"] and not args["no-header"] then
	io.stdout:write(testData:GetHeaderString())
	io.stdout:write("\n")
end

io.stdout:write(testData:GetPlayersString())
io.stdout:write("\n")
io.stdout:write(testData:GetLogString())
io.stdout:write("\n")
io.stdout:write("}\n")

logInfo("Parsed %d lines into %d lines (%.1f%% filtered)", testData.stats.parsedLines, testData.stats.outputLines, (1 - testData.stats.outputLines / (testData.stats.parsedLines)) * 100)
logInfo("%.1f seconds total, %.0f entries/second", testData.stats.logTime, testData.stats.outputLines / testData.stats.logTime)


if next(testData:GetIgnoreCandidates()) then
	logInfo("Potentially ignoreable creature IDs (healed by players):")
	for cid, name in pairs(testData:GetIgnoreCandidates()) do
		logInfo(cid .. ", -- " .. name)
	end
end
