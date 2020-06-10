local setmetatable, type, ipairs, tinsert = setmetatable, type, ipairs, table.insert
local DBM, DBM_GUI = DBM, DBM_GUI

local ListFrameButtonsPrototype = {}

function ListFrameButtonsPrototype:CreateCategory(frame, parent)
	if not type(frame) == "table" then
		DBM:AddMsg("Failed to create category - frame is not a table")
		return false
	elseif not frame.name then
		DBM:AddMsg("Failed to create category - frame.name is missing")
		return false
	elseif self:IsPresent(frame.name) then
		DBM:AddMsg("Frame (" .. frame.name .. ") already exists")
		return false
	end
	frame.depth = parent and self:GetDepth(parent) or 1
	self:SetParentHasChilds(parent)
	tinsert(self.Buttons, {
		frame	= frame,
		parent	= parent
	})
	return #self.Buttons
end

function ListFrameButtonsPrototype:IsPresent(name)
	for _, v in ipairs(self.Buttons) do
		if v.frame.name == name then
			return true
		end
	end
	return false
end

function ListFrameButtonsPrototype:GetDepth(name, depth)
	depth = depth or 1
	for _, v in ipairs(self.Buttons) do
		if v.frame.name == name then
			if v.parent == nil then
				return depth + 1
			else
				depth = depth + self:GetDepth(v.parent, depth)
			end
		end
	end
	return depth
end

function ListFrameButtonsPrototype:SetParentHasChilds(parent)
	if not parent then
		return
	end
	for _, v in ipairs(self.Buttons) do
		if v.frame.name == parent then
			v.frame.haschilds = true
		end
	end
end

function ListFrameButtonsPrototype:GetVisibleTabs()
	local tabs = {}
	for _, v in ipairs(self.Buttons) do
		if v.parent == nil then
			tinsert(tabs, v)
			if v.frame.showSub then
				self:GetVisibleSubTabs(v.frame.name, tabs)
			end
		end
	end
	return tabs
end

function ListFrameButtonsPrototype:GetVisibleSubTabs(parent, tabs)
	for _, v in ipairs(self.Buttons) do
		if v.parent == parent then
			tinsert(tabs, v)
			if v.frame.showSub then
				self:GetVisibleSubTabs(v.frame.name, tabs)
			end
		end
	end
end

function DBM_GUI:CreateNewFauxScrollFrameList()
	local mt = setmetatable({
		Buttons = {}
	}, {
		__index = ListFrameButtonsPrototype
	})
	DBM_GUI.frameTypes[#DBM_GUI.frameTypes + 1] = mt
	return mt
end

-- TODO: Should this go somewhere else?
_G["DBM_GUI_Bosses"] = DBM_GUI:CreateNewFauxScrollFrameList()
_G["DBM_GUI_Options"] = DBM_GUI:CreateNewFauxScrollFrameList()
