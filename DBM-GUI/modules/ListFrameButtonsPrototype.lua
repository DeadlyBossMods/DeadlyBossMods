local setmetatable, type, ipairs, tinsert = setmetatable, type, ipairs, table.insert
local DBM, DBM_GUI = DBM, DBM_GUI

local function GetDepth(self, parentID, depth) -- Called internally
	depth = depth or 1
	for _, v in ipairs(self.buttons) do
		if v.frame.ID == parentID then
			if not v.parentID then
				return depth + 1
			else
				depth = depth + GetDepth(self, v.parentID, depth)
			end
		end
	end
	return depth
end

local function GetVisibleSubTabs(self, parentID, tabs)
	for _, v in ipairs(self.buttons) do
		if v.parentID == parentID then
			tinsert(tabs, v)
			if v.frame.showSub then
				GetVisibleSubTabs(self, v.frame.ID, tabs)
			end
		end
	end
end

local function SetParentHasChilds(self, parentID)
	if not parentID then
		return
	end
	for _, v in ipairs(self.buttons) do
		if v.frame.ID == parentID then
			v.frame.haschilds = true
		end
	end
end

local ListFrameButtonsPrototype = {}

function ListFrameButtonsPrototype:CreateCategory(frame, parentID)
	if not type(frame) == "table" then
		DBM:AddMsg("Failed to create category - frame is not a table")
		return false
	end
	frame.depth = parentID and GetDepth(self, parentID) or 1
	SetParentHasChilds(self, parentID)
	tinsert(self.buttons, {
		frame		= frame,
		parentID	= parentID
	})
	return #self.buttons
end

function ListFrameButtonsPrototype:GetVisibleTabs()
	local tabs = {}
	for _, v in ipairs(self.buttons) do
		if not v.parentID then
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
		buttons = {}
	}, {
		__index = ListFrameButtonsPrototype
	})
	self.tabs[#self.tabs + 1] = mt
	return mt
end

-- TODO: Should this go somewhere else?
_G["DBM_GUI_Bosses"] = DBM_GUI:CreateNewFauxScrollFrameList()
_G["DBM_GUI_Options"] = DBM_GUI:CreateNewFauxScrollFrameList()
