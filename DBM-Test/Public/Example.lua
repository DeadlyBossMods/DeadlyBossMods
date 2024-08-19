-- This file is under the CC0 1.0 license, see https://creativecommons.org/publicdomain/zero/1.0/

-- Example integration for DBM-Test for 3rd party mods

---@type DBMTest_CallbackHandlers
local handlers = {}

local function printf(str, ...)
	print(str:format(...))
end

local mocks
local startTimeReal = 0
local startTimeFake = 0
local measuredTime = 0
local dontSpamTicks, dontSpamEvents, dontSpamCLEUEvents = 0, 0, 0
local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(_, elapsed) measuredTime = measuredTime + elapsed end)


function handlers.Start(args)
	printf("Starting DBM test %s (%d seconds, %d events) for DBM mod %s", args.Name, args.Duration, args.NumEvents, args.ModUnderTest:GetLocalizedStrings().name)
	local encounter = args.EncounterInfo
	if encounter then
		printf("Encounter %s (id %d, difficulty %d, group size %d) starts after %.2f seconds", encounter.EncounterName, encounter.EncounterId, encounter.DifficultyId, encounter.GroupSize, encounter.StartOffset)
	end
	 -- Callings mocks.GetInstanceInfo() also works, but it's included in the args explicitly because it has an extra field: difficultyModifier (used for Mythic+ and Molten Core heat levels)
	local instanceInfo = args.InstanceInfo
	printf("Instance: %s (%d), difficulty: %s (%d)", instanceInfo.name, instanceInfo.instanceID, instanceInfo.difficultyName, instanceInfo.difficultyID)
	printf("Players in log: %d, playing back from perspective of player %s", #args.Players, args.Perspective)
	mocks = args.Mocks
	startTimeReal = GetTime()
	startTimeFake = mocks.GetTime() -- Does not necessarily match GetTime() even at test start to ensure that it's monotonic across multiple tests
	measuredTime = 0
	dontSpamTicks, dontSpamEvents, dontSpamCLEUEvents = 3, 3, 3
end


function handlers.Stop(args)
	local realTime = GetTime() - startTimeReal
	local fakeTime = mocks.GetTime() - startTimeFake
	printf("DBM test %s stopped after %.2f seconds real time", args.Name, realTime)
	printf("Fake time passed: %.2f seconds (%.1fx speedup)", fakeTime, fakeTime / realTime)
	printf("Measured time passed: %.2f seconds (%.1fx speedup)", measuredTime, measuredTime / realTime)
end

function handlers.Timewarp(args)
	printf("Timewarping set to %dx", args.Speed)
	args.Timewarper:RegisterFrame(frame)
end

function handlers.Tick(elapsed)
	if dontSpamTicks <= 0 then
		return
	end
	dontSpamTicks = dontSpamTicks - 1
	-- Note how this will print a consistent value even with timewarping at 1x -- DBM tests always use the full timewarping to simulate a consistent frame rate
	printf("DBM test tick, %.2f seconds passed (message filter after %d more events)", elapsed, dontSpamTicks)
end

function handlers.Event(event, ...)
	if dontSpamEvents <= 0 then
		return
	end
	dontSpamEvents = dontSpamEvents - 1
	printf("Injected fake event (filtering message after %d more events)\n %s,%s", dontSpamEvents, event, strjoin(",", tostringall(...)))
end

function handlers.CombatLogEvent(event, ...)
	if dontSpamCLEUEvents <= 0 then
		return
	end
	dontSpamCLEUEvents = dontSpamCLEUEvents - 1
	printf("Injected fake event (filtering message after %d more events)\n %s,%s", dontSpamCLEUEvents, event, strjoin(",", tostringall(...)))
end


local function callback(event, ...)
	event = event:sub(#"DBMTest_" + 1)
	if handlers[event] then
		handlers[event](...)
	end
end

DBM:RegisterCallback("DBMTest_Start", callback)
DBM:RegisterCallback("DBMTest_Stop", callback)
DBM:RegisterCallback("DBMTest_Timewarp", callback)
DBM:RegisterCallback("DBMTest_Tick", callback)
DBM:RegisterCallback("DBMTest_Event", callback)
DBM:RegisterCallback("DBMTest_CombatLogEvent", callback)
