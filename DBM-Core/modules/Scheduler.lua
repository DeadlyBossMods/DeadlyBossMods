local _, private = ...

local twipe, tremove = table.wipe, table.remove
local floor = math.floor
local GetTime = GetTime
local pairs, next = pairs, next
local LastInstanceMapID = -1

local schedulerFrame = CreateFrame("Frame", "DBMScheduler")
schedulerFrame:Hide()

local module = private:NewModule("DBMScheduler")

--------------------------
--  OnUpdate/Scheduler  --
--------------------------

-- stack that stores a few tables (up to 8) which will be recycled
local popCachedTable, pushCachedTable
local numChachedTables = 0
do
	local tableCache

	-- gets a table from the stack, it will then be recycled.
	function popCachedTable()
		local t = tableCache
		if t then
			tableCache = t.next
			numChachedTables = numChachedTables - 1
		end
		return t
	end

	-- tries to push a table on the stack
	-- only tables with <= 4 array entries are accepted as cached tables are only used for tasks with few arguments as we don't want to have big arrays wasting our precious memory space doing nothing...
	-- also, the maximum number of cached tables is limited to 8 as DBM rarely has more than eight scheduled tasks with less than 4 arguments at the same time
	-- this is just to re-use all the tables of the small tasks that are scheduled all the time (like the wipe detection)
	-- note that the cache does not use weak references anywhere for performance reasons, so a cached table will never be deleted by the garbage collector
	function pushCachedTable(t)
		if numChachedTables < 8 and #t <= 4 then
			twipe(t)
			t.next = tableCache
			tableCache = t
			numChachedTables = numChachedTables + 1
		end
	end
end

-- priority queue (min-heap) that stores all scheduled tasks.
-- insert: O(log n)
-- deleteMin: O(log n)
-- getMin: O(1)
-- removeAllMatching: O(n)
local insert, removeAllMatching, getMin, deleteMin
do
	local heap = {}
	local firstFree = 1

	-- gets the next task
	function getMin()
		return heap[1]
	end

	-- restores the heap invariant by moving an item up
	local function siftUp(n)
		local parent = floor(n / 2)
		while n > 1 and heap[parent].time > heap[n].time do -- move the element up until the heap invariant is restored, meaning the element is at the top or the element's parent is <= the element
			heap[n], heap[parent] = heap[parent], heap[n] -- swap the element with its parent
			n = parent
			parent = floor(n / 2)
		end
	end

	-- restores the heap invariant by moving an item down
	local function siftDown(n)
		local m -- position of the smaller child
		while 2 * n < firstFree do -- #children >= 1
			-- swap the element with its smaller child
			if 2 * n + 1 == firstFree then -- n does not have a right child --> it only has a left child as #children >= 1
				m = 2 * n -- left child
			elseif heap[2 * n].time < heap[2 * n + 1].time then -- #children = 2 and left child < right child
				m = 2 * n -- left child
			else -- #children = 2 and right child is smaller than the left one
				m = 2 * n + 1 -- right
			end
			if heap[n].time <= heap[m].time then -- n is <= its smallest child --> heap invariant restored
				return
			end
			heap[n], heap[m] = heap[m], heap[n]
			n = m
		end
	end

	-- inserts a new element into the heap
	function insert(ele)
		heap[firstFree] = ele
		siftUp(firstFree)
		firstFree = firstFree + 1
	end

	-- deletes the min element
	function deleteMin()
		local min = heap[1]
		firstFree = firstFree - 1
		heap[1] = heap[firstFree]
		heap[firstFree] = nil
		siftDown(1)
		return min
	end

	-- removes multiple scheduled tasks from the heap
	-- note that this function is comparatively slow by design as it has to check all tasks and allows partial matches
	function removeAllMatching(f, mod, ...)
		-- remove all elements that match the signature, this destroyes the heap and leaves a normal array
		local v, match
		local foundMatch = false
		for i = #heap, 1, -1 do -- iterate backwards over the array to allow usage of table.remove
			v = heap[i]
			if (not f or v.func == f) and (not mod or v.mod == mod) then
				match = true
				for j = 1, select("#", ...) do
					if select(j, ...) ~= v[j] then
						match = false
						break
					end
				end
				if match then
					tremove(heap, i)
					firstFree = firstFree - 1
					foundMatch = true
				end
			end
		end
		-- rebuild the heap from the array in O(n)
		if foundMatch then
			for i = floor((firstFree - 1) / 2), 1, -1 do
				siftDown(i)
			end
		end
	end
end

local wrappers = {}
local function range(max, cur, ...)
	cur = cur or 1
	if cur > max then
		return ...
	end
	return cur, range(max, cur + 1, select(2, ...))
end
local function getWrapper(n)
	wrappers[n] = wrappers[n] or loadstring(([[
		return function(func, tbl)
			return func(]] .. ("tbl[%s], "):rep(n):sub(0, -3) .. [[)
		end
	]]):format(range(n)))()
	return wrappers[n]
end

local nextModSyncSpamUpdate = 0
--mainFrame:SetScript("OnUpdate", function(self, elapsed)
local function onUpdate(self, elapsed)
	local time = GetTime()

	-- execute scheduled tasks
	local nextTask = getMin()
	while nextTask and nextTask.func and nextTask.time <= time do
		deleteMin()
		local n = nextTask.n
		if n == #nextTask then
			nextTask.func(unpack(nextTask))
		else
			-- too many nil values (or a trailing nil)
			-- this is bad because unpack will not work properly
			-- TODO: is there a better solution?
			getWrapper(n)(nextTask.func, nextTask)
		end
		pushCachedTable(nextTask)
		nextTask = getMin()
	end

	-- execute OnUpdate handlers of all modules
	local foundModFunctions = 0
	for i, v in pairs(private.updateFunctions) do
		foundModFunctions = foundModFunctions + 1
		if i.Options.Enabled and (not i.zones or i.zones[LastInstanceMapID]) then
			i.elapsed = (i.elapsed or 0) + elapsed
			if i.elapsed >= (i.updateInterval or 0) then
				v(i, i.elapsed)
				i.elapsed = 0
			end
		end
	end

	-- clean up sync spam timers and auto respond spam blockers
	if time > nextModSyncSpamUpdate then
		nextModSyncSpamUpdate = time + 20
		-- TODO: optimize this; using next(t, k) all the time on nearly empty hash tables is not a good idea...doesn't really matter here as modSyncSpam only very rarely contains more than 4 entries...
		-- we now do this just every 20 seconds since the earlier assumption about modSyncSpam isn't true any longer
		-- note that not removing entries at all would be just a small memory leak and not a problem (the sync functions themselves check the timestamp)
		local k, v = next(private.modSyncSpam, nil)
		if v and (time - v > 8) then
			private.modSyncSpam[k] = nil
		end
	end
	if not nextTask and foundModFunctions == 0 then--Nothing left, stop scheduler
		schedulerFrame:SetScript("OnUpdate", nil)
		schedulerFrame:Hide()
	end
end

function module:StartScheduler()
	if not schedulerFrame:IsShown() then
		schedulerFrame:Show()
		schedulerFrame:SetScript("OnUpdate", onUpdate)
	end
end

--For updating zone cache locally
--without needing to monitor for changes in onupdate functions or registering zone change events
function module:UpdateZone()
	LastInstanceMapID = DBM and DBM:GetCurrentArea() or -1
end

local function schedule(t, f, mod, ...)
	if type(f) ~= "function" then
		error("usage: schedule(time, func, [mod, args...])", 2)
	end
	module:StartScheduler()
	local v
	if numChachedTables > 0 and select("#", ...) <= 4 then -- a cached table is available and all arguments fit into an array with four slots
		v = popCachedTable()
		v.time = GetTime() + t
		v.func = f
		v.mod = mod
		v.n = select("#", ...)
		for i = 1, v.n do
			v[i] = select(i, ...)
		end
		-- clear slots if necessary
		for i = v.n + 1, 4 do
			v[i] = nil
		end
	else -- create a new table
		v = {time = GetTime() + t, func = f, mod = mod, n = select("#", ...), ...}
	end
	insert(v)
end

--Boss mod prototype usage methods (for announces countdowns and yell scheduling
function module:ScheduleCountdown(time, numAnnounces, func, mod, prototype, ...)
	time = time or 5
	numAnnounces = numAnnounces or 3
	for i = 1, numAnnounces do
		--In event time is < numbmer of announces (ie 2 second time, with 3 announces)
		local validTime = time - i
		if validTime >= 1 then
			schedule(validTime, func, mod, prototype, i, ...)
		end
	end
end

local function unschedule(f, mod, ...)
	if not f and not mod then
		--Dangerous to use, should only ever happen with a force disable
		removeAllMatching()
	end
	return removeAllMatching(f, mod, ...)
end

function module:Schedule(t, f, mod, ...)
	if type(f) ~= "function" then
		error("usage: DBM:Schedule(time, func, [args...])", 2)
	end
	return schedule(t, f, mod, ...)
end

function module:Unschedule(f, mod, ...)
	return unschedule(f, mod, ...)
end
