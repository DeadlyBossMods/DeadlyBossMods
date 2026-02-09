---@class DBMGUI
local DBM_GUI = DBM_GUI

local setmetatable, type, ipairs, tinsert = setmetatable, type, ipairs, table.insert
local DBM = DBM

local function GetDepth(self, parentID) -- Called internally
	-- Optimized to avoid recursion by using cached depth
	if not self.depthCache then
		self.depthCache = {}
	end
	if self.depthCache[parentID] then
		return self.depthCache[parentID]
	end

	local depth = 1
	local currentID = parentID
	local visited = {}

	-- Walk up the parent chain to calculate depth
	while currentID do
		if visited[currentID] then
			-- Circular reference detected, break to prevent infinite loop
			break
		end
		visited[currentID] = true
		
		local found = false
		for _, v in ipairs(self.buttons) do
			if v.frame.ID == currentID then
				found = true
				if v.parentID then
					currentID = v.parentID
					depth = depth + 1
				else
					currentID = nil
				end
				break
			end
		end
		if not found then
			-- Parent not found, stop
			break
		end
	end

	self.depthCache[parentID] = depth + 1
	return depth + 1
end

local function GetVisibleSubTabs(self, parentID, tabs, parentIndex)
	-- Optimized with parent index to avoid searching from position 0 each time
	for i = (parentIndex or 1), #self.buttons do
		local v = self.buttons[i]
		if v.parentID == parentID then
			tinsert(tabs, v)
			if v.frame.showSub then
				GetVisibleSubTabs(self, v.frame.ID, tabs, i)
			end
		end
	end
end

local function SetParentHasChildsAndCache(self, parentID)
	-- Combined function and caching
	if not parentID or not self.idIndex then
		return
	end
	local parent = self.idIndex[parentID]
	if parent then
		parent.frame.haschilds = true
	end
end

local ListFrameButtonsPrototype = {}

function ListFrameButtonsPrototype:CreateCategory(frame, parentID, forceChildren)
	if type(frame) ~= "table" then
		DBM:AddMsg("Failed to create category - frame is not a table")
		return false
	end

	-- Initialize indexes on first use
	if not self.idIndex then
		self.idIndex = {}
	end

	frame.depth = parentID and GetDepth(self, parentID) or 1
	if forceChildren then
		frame.haschilds = true
	end

	SetParentHasChildsAndCache(self, parentID)

	local buttonInfo = {
		frame		= frame,
		parentID	= parentID
	}

	-- Maintain ID index for O(1) lookups
	self.idIndex[frame.ID] = buttonInfo

	tinsert(self.buttons, buttonInfo)
	return #self.buttons
end

function ListFrameButtonsPrototype:GetVisibleTabs()
	local tabs = {}
	for _, v in ipairs(self.buttons) do
		if not v.parentID and not v.hidden then
			tinsert(tabs, v)
			if v.frame.showSub then
				GetVisibleSubTabs(self, v.frame.ID, tabs)
			end
		end
	end
	return tabs
end

function DBM_GUI:CreateNewFauxScrollFrameList()
	local mt = setmetatable({
		buttons = {},
		idIndex = {},		-- ID-based lookup cache for O(1) access
		depthCache = {}		-- Depth cache to avoid recalculation
	}, {
		__index = ListFrameButtonsPrototype
	})
	self.tabs[#self.tabs + 1] = mt
	return mt
end
