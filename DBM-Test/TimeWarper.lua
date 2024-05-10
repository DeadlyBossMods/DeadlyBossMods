---@class DBMTest
local test = DBM.Test

---@class TimeWarper
test.TimeWarper = {
	---@type table<Frame, boolean|function>
	-- true if it needs to be hooked, function is the previous function or false if the handler was cleared while it was hooked
	framesToHook = {}
}
local timeWarperMt = {__index = test.TimeWarper}

---@param frame Frame
function test.TimeWarper:RegisterFrame(frame)
	self.framesToHook[frame] = true
end

-- This mod loads on demand after frames are already registered
for frame in pairs(test.framesForTimeWarp) do
	test.TimeWarper:RegisterFrame(frame)
end
table.wipe(test.framesForTimeWarp)

local active = false

-- Avoid non-monotonic timestamps between multiple time warp invocations.
-- This is important for state that persists across multiple tests, e.g., global AntiSpam timestamps
local highestSeenTime = GetTime()

function test.TimeWarper:Start()
	if active then
		error("only a single time warp can be active at a time")
	end
	active = true
	for frame, val in pairs(self.framesToHook) do
		if val == true then
			local onUpdate = frame:GetScript("OnUpdate")
			self.framesToHook[frame] = onUpdate
			frame:SetScript("OnUpdate", function() end)
			local oldSetScript = frame.SetScript
			---@diagnostic disable-next-line: duplicate-set-field
			frame.SetScript = function(frame, scriptType, handler)
				if scriptType == "OnUpdate" then
					self.framesToHook[frame] = handler or false
				else
					return oldSetScript(frame, scriptType, handler)
				end
			end
		end
	end
	self.fakeTime = math.max(highestSeenTime, GetTime())
	self.fakeTimeSteps = 0
	test:HookPrivate("GetTime", function() -- Unhooking is done by the generic unhook all in test:Teardown()
		if self.fakeTime then
			return self.fakeTime
		else
			return GetTime()
		end
	end)
end

function test.TimeWarper:Stop()
	for frame, val in pairs(self.framesToHook) do
		frame.SetScript = nil
		if val ~= true then -- true means it was never hooked
			frame:SetScript("OnUpdate", val or nil)
		end
	end
	highestSeenTime = self.fakeTime
	self.fakeTime = nil
	active = false
end

-- Call coroutine.yield() until a given point in (fake) time has been reached.
-- Pass the real time elapsed since the last coroutine.resume to coroutine.resume, i.e., run the coroutine in an OnUpdate handler.
function test.TimeWarper:WaitUntil(time)
	while time > self.fakeTime do
		if self.fakeTimeSteps >= self.factor or not self.lastFrameTime then
			self.lastFrameTime = coroutine.yield()
			self.fakeTimeSteps = 0
		end
		self.fakeTime = self.fakeTime + self.lastFrameTime
		self.fakeTimeSteps = self.fakeTimeSteps + 1
		for frame, updateFunc in pairs(self.framesToHook) do
			if frame:IsVisible() and type(updateFunc) == "function" then
				updateFunc(frame, self.lastFrameTime)
			end
		end
	end
end

function test.TimeWarper:New(factor)
	---@class TimeWarper
	local obj = setmetatable({
		factor = factor
	}, timeWarperMt)
	return obj
end
