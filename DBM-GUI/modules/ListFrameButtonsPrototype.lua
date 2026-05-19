---@class DBMGUI
local DBM_GUI = DBM_GUI

local setmetatable, type, ipairs, tinsert = setmetatable, type, ipairs, table.insert
local DBM = DBM

local function GetDepth(self, parentID) -- Called internally
	if not self.depthCache then
		self.depthCache = {}
	end
	local cachedDepth = self.depthCache[parentID]
	if cachedDepth then
		return cachedDepth
	end

	local depth = 1
	local currentID = parentID
	local visited = {}

	while currentID do
		if visited[currentID] then
			break -- Circular reference detected
		end
		visited[currentID] = true

		local buttonInfo = self.idIndex and self.idIndex[currentID]
		if not buttonInfo then
			for _, v in ipairs(self.buttons) do
				if v.frame.ID == currentID then
					buttonInfo = v
					if self.idIndex then
						self.idIndex[currentID] = v
					end
					break
				end
			end
		end

		if not buttonInfo then
			break
		end

		if buttonInfo.parentID then
			depth = depth + 1
			currentID = buttonInfo.parentID
		else
			currentID = nil
		end
	end

	local resolvedDepth = depth + 1
	self.depthCache[parentID] = resolvedDepth
	return resolvedDepth
end

local function GetVisibleSubTabs(self, parentID, tabs, parentIndex)
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
	if not parentID then
		return
	end

	local parent = self.idIndex and self.idIndex[parentID]
	if parent then
		parent.frame.haschilds = true
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.frame.ID == parentID then
			v.frame.haschilds = true
			if self.idIndex then
				self.idIndex[parentID] = v
			end
			return
		end
	end
end

local ListFrameButtonsPrototype = {}

function ListFrameButtonsPrototype:CreateCategory(frame, parentID, forceChildren)
	if type(frame) ~= "table" then
		DBM:AddMsg("Failed to create category - frame is not a table")
		return false
	end
	if not self.idIndex then
		self.idIndex = {}
	end
	if not self.depthCache then
		self.depthCache = {}
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
		idIndex = {},
		depthCache = {}
	}, {
		__index = ListFrameButtonsPrototype
	})
	self.tabs[#self.tabs + 1] = mt
	return mt
end
