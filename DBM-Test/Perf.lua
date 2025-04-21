---@class DBMTest
local test = DBM.Test

---@class DBMTestPerf
local perf = {}
test.Perf = perf

---@class DBMTestPerfData
local data

function perf:Start()
	---@class DBMTestPerfData
	data = {
		startReal = GetTimePreciseSec(),
		startFake = test.Mocks.GetTime(),
		times = {},
		frames = {0},
		slowestFrameTime = 0,
		slowestFrameEvents = {},
		curFrameEvents = {}
	}
end

function perf:Stop()
	data.stopReal = GetTimePreciseSec()
	data.stopFake = test.Mocks.GetTime()
end

function perf:Track(category, event, delta)
	local times = data.times
	times[category] = times[category] or {time = 0, calls = 0, eventTimes = {}, eventCalls = {}}
	times[category].time = times[category].time + delta
	times[category].calls = times[category].calls + 1
	times[category].eventTimes[event] = (times[category].eventTimes[event] or 0) + delta
	times[category].eventCalls[event] = (times[category].eventCalls[event] or 0) + 1
	data.frames[#data.frames] = data.frames[#data.frames] + delta
	data.curFrameEvents[category .. "/" .. event] = (data.curFrameEvents[category .. "/" .. event] or 0) + delta
end

function perf:Frame()
	if data.frames[#data.frames] > data.slowestFrameTime then
		data.slowestFrameTime = data.frames[#data.frames]
		table.wipe(data.slowestFrameEvents)
		for k, v in pairs(data.curFrameEvents) do
			data.slowestFrameEvents[k] = v
		end
	end
	table.wipe(data.curFrameEvents)
	data.frames[#data.frames + 1] = 0
end

function perf:Report()
	local sortedCats = {}
	local totalTime = 0
	for k, v in pairs(data.times) do
		totalTime = totalTime + v.time
		local cat = {name = k, time = v.time, calls = v.calls, eventTimes = {}, eventCalls = {}}
		sortedCats[#sortedCats + 1] = cat
		for ev, time in pairs(v.eventTimes) do
			cat.eventTimes[#cat.eventTimes + 1] = {name = ev, time = time, calls = v.eventCalls[ev]}
		end
		table.sort(cat.eventTimes, function(e1, e2) return e1.time > e2.time end)
	end
	table.sort(sortedCats, function(e1, e2) return e1.time > e2.time end)
	local sortedFrames = {}
	for frame, time in ipairs(data.frames) do
		sortedFrames[#sortedFrames + 1] = {frame = frame, time = time}
	end
	table.sort(sortedFrames, function(e1, e2) return e1.time > e2.time end)
	local sortedSlowestFrameEvents = {}
	for event, time in pairs(data.slowestFrameEvents) do
		sortedSlowestFrameEvents[#sortedSlowestFrameEvents + 1] = {name = event, time = time}
	end
	table.sort(sortedSlowestFrameEvents, function(e1, e2) return e1.time > e2.time end)

	-- Dont' use DBM:AddMsg or DBM:Debug here to avoid this from showing up in test diffs
	print("DBM-Test performance report")
	print("Simulated frames:", #sortedFrames)
	print("Simulated time:", ("%.1fs"):format(data.stopFake - data.startFake))
	if test.environment == "DBM-Offline" then -- DBM-Offline uses fake time for GetTimePreciseSec(), so the data is nonsense there
		return
	end
	print("Real time:", ("%.1fs"):format(data.stopReal - data.startReal))
	print("Effective timewarp:", ("%.0fx"):format((data.stopFake - data.startFake) / (data.stopReal - data.startReal)))
	print(" ")
	print("Per-category results")
	for _, cat in ipairs(sortedCats) do
		print(cat.name, ("%.1f ms"):format(cat.time * 1000), ("%d events"):format(cat.calls))
		for i, ev in ipairs(cat.eventTimes) do
			print("  ", ev.name, ("%.1f ms"):format(ev.time * 1000), ("%d events"):format(ev.calls))
			if i >= 5 and i ~= #cat.eventTimes then
				print("  ", ("(%d more entries skipped)"):format(#cat.eventTimes - i))
				break
			end
		end
	end
	print(" ")
	print("Slowest frames")
	for i = 1, 3 do
		print(
			"  ",
			("Frame #%d at time ~%.2fs: "):format(sortedFrames[i].frame, (sortedFrames[i].frame / #sortedFrames) * (data.stopFake - data.startFake)),
			("%.1f ms (%.1f%% CPU at 60 fps, %.1f%% CPU at 120 fps)"):format(sortedFrames[i].time * 1000, sortedFrames[i].time / (1 / 60) * 100, sortedFrames[i].time / (1 / 120) * 100)
		)
	end
	print(("Breakdown for slowest frame #%d"):format(sortedFrames[1].frame))
	for i, ev in ipairs(sortedSlowestFrameEvents) do
		print("  ", ev.name, ("%.1f ms"):format(ev.time * 1000))
		if i >= 5 and i ~= #sortedSlowestFrameEvents then
			print("  ", ("(%d more entries skipped)"):format(#sortedSlowestFrameEvents - i))
			break
		end
	end
	print(" ")
	print("Overall average CPU load:", ("%.1f%%"):format(totalTime / (data.stopFake - data.startFake) * 100))
end


