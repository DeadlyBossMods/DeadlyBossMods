---@class DBMTest
local test = DBM.Test

local active = nil

---@class TimeWarper
test.TimeWarper = {
	---@type table<Frame, boolean|function>
	-- true if it needs to be hooked, function is the previous function or false if the handler was cleared while it was hooked
	framesToHook = {},
	sortedFramesToHook = {} -- Frames sorted by name, resolves some determinism problems around ordering OnUpdate calls
}
local timeWarperMt = {__index = test.TimeWarper}

---@param frame Frame
function test.TimeWarper:RegisterFrame(frame)
	if self.framesToHook[frame] ~= nil then
		return
	end
	if active then
		self:HookOnUpdateHandler(frame)
	else
		self.framesToHook[frame] = true
	end
end

-- This mod loads on demand after frames are already registered
for frame in pairs(test.framesForTimeWarp) do
	test.TimeWarper:RegisterFrame(frame)
end
table.wipe(test.framesForTimeWarp)


-- Avoid non-monotonic timestamps between multiple time warp invocations.
-- This is important for state that persists across multiple tests, e.g., global AntiSpam timestamps
local highestSeenTime = GetTime()

function test.TimeWarper:HookOnUpdateHandler(frame)
	local onUpdate = frame:GetScript("OnUpdate")
	self.framesToHook[frame] = onUpdate or false
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
	-- Invalidate cache, important to use an empty table and not null, since this is actually a static variable and re-setting it would make it a class variable
	-- (Yes, the class setup for timewarper is a mess)
	table.wipe(self.sortedFramesToHook)
end

function test.TimeWarper:Start()
	if active then
		error("only a single time warp can be active at a time")
	end
	active = self
	for frame, val in pairs(self.framesToHook) do
		if val == true then
			self:HookOnUpdateHandler(frame)
		end
	end
	self.fakeTime = math.max(highestSeenTime, GetTime())
	self.fakeTimeSinceLastFrame = 0
	self.lastFrameTime = 0
	 -- Unhooking is done by the generic unhook all in test:Teardown()
	test:HookPrivate("GetTime", function() return self:GetTime() end)
end

function test.TimeWarper:GetTime()
	if self.fakeTime then
		return self.fakeTime
	else
		return GetTime()
	end
end

function test.TimeWarper:Stop()
	if not active then
		return
	end
	if active ~= self then
		return active:Stop()
	end
	for frame, val in pairs(self.framesToHook) do
		frame.SetScript = nil
		if val ~= true then -- true means it was never hooked
			frame:SetScript("OnUpdate", val or nil)
		end
	end
	highestSeenTime = self.fakeTime
	self.fakeTime = nil
	active = nil
end

local function checkActive()
	if not active then
		error("test stopped, time warp canceled")
	end
end

local GetTimePreciseSec = GetTimePreciseSec

-- Call coroutine.yield() until a given point in (fake) time has been reached.
-- Pass the real time elapsed since the last coroutine.resume to coroutine.resume, i.e., run the coroutine in an OnUpdate handler.
function test.TimeWarper:WaitUntil(time)
	-- Tests simulate 30 FPS by default, using anything else might give slightly different outcomes which we don't want for the golden tests
	-- Fine to use different values in playground mode.
	-- It's tempting to use a number that's neatly representable in IEEE 754 here like 1 / 32 and round up the start time to fix potential floating point messes.
	-- but that doesn't help anything here because mods are full of 0.1 granularity type timers and test events are at 0.01 granularity (neither are representable).
	local timeStep = 1 / 30
	local minRealFps = 20 -- the exact value here doesn't really matter, and it's not accurate anyways, this is mainly here to implement dynamic speed without terrible lag
	self.currentFrameStart = self.currentFrameStart or GetTimePreciseSec()
	while time > self.fakeTime do
		while self.fakeTimeSinceLastFrame >= self.lastFrameTime * self.factor or GetTimePreciseSec() - self.currentFrameStart > 1 / minRealFps do
			coroutine.yield()
			checkActive()
			self.lastFrameTime = GetTimePreciseSec() - self.currentFrameStart
			self.currentFrameStart = GetTimePreciseSec()
			-- this goes negative if we hit the fps limit, so it effectively speeds up later to catch up
			if not self.frozen then
				self.fakeTimeSinceLastFrame = self.fakeTimeSinceLastFrame - self.lastFrameTime * self.factor
			end
		end
		self.fakeTime = self.fakeTime + timeStep
		self.fakeTimeSinceLastFrame = self.fakeTimeSinceLastFrame + timeStep
		-- Enforce deterministic order for calling OnUpdate handlers, this resolves some annoying problems with code that gets timer info from DBT in a scheduled task
		if #self.sortedFramesToHook == 0 then
			for frame, updateFunc in pairs(self.framesToHook) do
				self.sortedFramesToHook[#self.sortedFramesToHook + 1] = {frame = frame, updateFunc = updateFunc}
			end
			-- Reverse order by name, this runs DBT before the DBM scheduler to run DBT first and then the scheduler
			-- That's the better order for determinism because it potentially expires DBT timers before running scheduled tasks that operate on them
			table.sort(self.sortedFramesToHook, function(e1, e2)
				local n1, n2 = e1.frame:GetName(), e2.frame:GetName()
				if n1 and n2 then
					return n1 > n2
				elseif not n1 and not n2 then
					return tostring(e1.frame) > tostring(e2.frame)
				else
					return not not n1
				end
			end)
		end
		for _, hookedFrame in ipairs(self.sortedFramesToHook) do
			local frame, updateFunc = hookedFrame.frame, hookedFrame.updateFunc
			if frame:IsVisible() and type(updateFunc) == "function" then
				updateFunc(frame, timeStep)
			end
		end
		DBM:FireEvent("DBMTest_Tick", timeStep)
	end
end

function test.TimeWarper:WaitFor(seconds)
	return self:WaitUntil(self.fakeTime + seconds)
end

function test.TimeWarper:DisableSound()
	if not self.soundDisabled then
		DBM:AddMsg("Timewarp >= 10, disabling sounds")
		test:ForceCVar("Sound_EnableAllSound", false)
		self.soundDisabled = true
	end
end

function test.TimeWarper:EnableSound()
	test:RestoreCVar("Sound_EnableAllSound")
	self.soundDisabled = false
end

-- Sets fake time to a fixed multiplier of real time.
-- Simulated FPS will stay consistent at 30 fps no matter how much your real FPS drop.
-- Set to 0 to simulate as fast as possible.
function test.TimeWarper:SetSpeed(factor)
	if factor >= 10 or factor <= 0 then
		self:DisableSound()
	else
		self:EnableSound()
	end
	self.factor = factor <= 0 and 1e9 or factor
	if self.factor > 1 then
		DBM.TaintedByTests = true
	end
	---@type DBMTestCallbackTimewarp
	local testStopCallbackArgs = {
		Speed = factor,
		Frozen = self.frozen,
		Timewarper = self --[[@as DBMTestTimewarperPublic]]
	}
	DBM:FireEvent("DBMTest_Timewarp", testStopCallbackArgs)
end

local frozenWarningSpamScheduled = false
local function spamFrozenWarning(self)
	if not self.frozen then
		frozenWarningSpamScheduled = false
		return
	end
	if frozenWarningSpamScheduled then
		return
	end
	frozenWarningSpamScheduled = true
	C_Timer.After(60, function() -- Do not use DBM:Schedule() here, it's also frozen
		frozenWarningSpamScheduled = false
		if not self.frozen then
			return
		end
		DBM:AddMsg("DBM is in test mode and frozen, it will not react to any event (including real events). Run /dbm test resume to unfreeze.")
		spamFrozenWarning(self)
	end)
end

function test.TimeWarper:Freeze()
	self.frozen = true
	spamFrozenWarning(self)
end

function test.TimeWarper:Resume()
	self.frozen = false
end

function test.TimeWarper:ToggleFreeze()
	self.frozen = not self.frozen
	spamFrozenWarning(self)
end

-- Skip to a stage/phase (default: the next stage)
function test.TimeWarper:SkipToStage(stage)
	self.skipToStage = stage or true
	self.skipOldFactor = self.factor
	-- FIXME: there is some internal mess in the time keeping logic above that makes jumping back from a very large to a very small value unreliable
	-- Somehow this either manifests as the time freezing for 1-2 seconds or as stopping too late, for now just using some value that is reasonably fast and reliable
	self:SetSpeed(100)
end

function test.TimeWarper:OnStageChanged(stage)
	if active ~= self then
		return
	end
	if stage == self.skipToStage or self.skipToStage == true then
		self.skipToStage = nil
		self:SetSpeed(self.skipOldFactor)
	end
end

function test.TimeWarper:New()
	---@class TimeWarper
	local obj = setmetatable({
		factor = 1
	}, timeWarperMt)
	return obj
end
