------------------------
-- Deadly Bar Timers ---
------------------------
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--    * Martin Verges (Nitram @ EU-Azshara)
-- 
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share — to copy, distribute, display, and perform the work
--    * to Remix — to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.

DBT = {}

local options = {
	BarXOffset = {
		type = "number",
		default = 0,
	},	
	BarYOffset = {
		type = "number",
		default = 0,
	},
	ExpandUpwards = {
		type = "boolean",
		default = false,
	}
}

local function stringFromTimer(t)
	if t <= 60 then
		return ("%.1f"):format(t)
	else
		return ("%d:%d"):format(t/60, math.fmod(t, 60))
	end
end

function DBT:SetOption(option, value)
	if not options[option] then
		error(("Invalid option: %s"):format(tostring(option)), 2)
	elseif options[option].type and type(value) ~= options[option].type then
		error(("The option %s requires a %s value. (tried to assign a %s value)"):format(tostring(option), tostring(options[option].type), tostring(type(value))), 2)
	elseif options[option].checkFunc then
		local ok, errMsg = options[option].checkFunc(self, option, value)
		if not ok then
			error(("Error while setting option %s to %s: %s"):format(tostring(option), tostring(value), tostring(errMsg)), 2)
		end
	end
	local oldValue = self.options[option]
	self.options[option] = value
	if options[option].onChange then
		options[option].onChange(self, value, oldValue)
	end
end

function DBT:GetOption(option)
	return self.options[option]
end

do
	local mt = {__index = DBT}
	local optionMT = {
		__index = function(t, k)
			if options[k] then
				return options[k].default
			else
				return nil
			end
		end
	}
	function DBT:New()
		local obj = setmetatable(
			{
				options = setmetatable({}, optionMT),
				mainAnchor = CreateFrame("Frame", nil, UIParent),
				secAnchor = CreateFrame("Frame", nil, UIParent),
				mainFirstBar = nil,
				mainLastBar = nil,
				secFirstBar = nil,
				secLastBar = nil,
			},
			mt
		)
		obj.mainAnchor:SetHeight(1)
		obj.mainAnchor:SetWidth(1)
		obj.mainAnchor:SetPoint("CENTER", 0, 0)
		obj.mainAnchor:SetClampedToScreen(true)
		obj.mainAnchor:SetMovable(true)
		obj.mainAnchor:Show()
		return obj
	end
end

local fCounter = 1
local barPrototype = {}
local unusedBars = {}
local unusedBarObjects = {}
setmetatable(unusedBarObjects, {__mode = "kv"})

do
	local function createBarFrame(self)
		local frame
		if unusedBars[#unusedBars] then
			frame = unusedBars[#unusedBars]
			unusedBars[#unusedBars] = nil
		else
			frame = CreateFrame("Frame", "DBT_Bar_"..fCounter, self.mainAnchor, "DBTBarTemplate")
			fCounter = fCounter + 1
		end
		return frame
	end	
	local mt = {__index = barPrototype}
	
	function DBT:CreateBar(timer, id, icon)
		local newBar = self:GetBar(id)
		if newBar then
			newBar:SetTimer(timer)
			newBar:SetElapsed(0)
		else
			newBar = next(unusedBarObjects, nil)
			if newBar then
				unusedBarObjects[newBar] = nil
			else
				newBar = setmetatable({}, mt)
			end
			newBar.prev = self.mainLastBar
			newBar.next = nil
			newBar.frame = createBarFrame(self)
			newBar.id = id
			newBar.timer = timer
			newBar.totalTime = timer
			newBar.owner = self
			if self.mainLastBar then
				self.mainLastBar.next = newBar
			end
			self.mainLastBar = newBar
			self.mainFirstBar = self.mainFirstBar or newBar		
			newBar.frame.obj = newBar
			newBar:ApplyStyle()
			newBar:SetPosition()
			newBar:SetText(id)
			newBar:Update(0)
		end
		return newBar
	end
end

do
	local function iterator(self, frame)
		return not frame and self.mainFirstBar or frame and frame.next
	end
	
	local function reverseIterator(self, frame)
		return not frame and self.mainLastBar or frame and frame.prev
	end

	function DBT:GetBarIterator(reverse)
		return (reverse and reverseIterator) or iterator, self, nil
	end
end

function DBT:GetBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			return bar
		end
	end
end

function DBT:CancelBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar:Cancel()
			return true
		end
	end
	return false
end

function DBT:UpdateOrientation()
	for bar in self:GetBarIterator() do
		bar:SetPosition()
	end
end
options.ExpandUpwards.onChange = DBT.UpdateOrientation

function barPrototype:ApplyStyle()
	self.frame:Show()
end

function barPrototype:SetTimer(timer)
	self.totalTime = timer
	self:Update(0)
end

function barPrototype:SetElapsed(elapsed)
	self.timer = self.totalTime - elapsed
	self:Update(0)
end

function barPrototype:Update(elapsed)
	local bar = getglobal(self.frame:GetName().."Bar")
	local spark = getglobal(self.frame:GetName().."BarSpark")
	local timer = getglobal(self.frame:GetName().."BarTimer")
	self.timer = self.timer - elapsed
	if self.timer <= 0 then
		self:Cancel()
	else
		bar:SetValue(self.timer/self.totalTime)
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", bar:GetValue() * bar:GetWidth(), 0)
		timer:SetText(stringFromTimer(self.timer))
	end
end

function barPrototype:SetText(text)
	getglobal(self.frame:GetName().."BarName"):SetText(text)
end

function barPrototype:Cancel()
	table.insert(unusedBars, self.frame)
	self.frame:Hide()
	self.frame.obj = nil
	if self == self.owner.mainFirstBar then
		if self.next then
			self.next.prev = nil
			self.owner.mainFirstBar = self.next
		else
			self.owner.mainFirstBar = nil
			self.owner.mainLastBar = nil
		end
	elseif self == self.owner.mainLastBar then
		if self.prev then
			self.prev.next = nil
			self.owner.mainLastBar = self.prev
		else
			self.owner.mainLastBar = nil
			self.owner.mainFirstBar = nil
		end
	else
		self.prev.next = self.next
		self.next.prev = self.prev
	end
	if self.next then
		self.next:SetPosition()
	end
	unusedBarObjects[self] = self
end

function barPrototype:SetPosition()
	self.frame:ClearAllPoints()
	if self == self.owner.mainFirstBar then
		self.frame:SetPoint("CENTER", self.owner.mainAnchor, "CENTER", 0, 0)
	else
		if self.owner.options.ExpandUpwards then
			self.frame:SetPoint("BOTTOM", self.prev.frame, "TOP", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
		else
			self.frame:SetPoint("TOP", self.prev.frame, "BOTTOM", self.owner.options.BarXOffset, self.owner.options.BarYOffset)
		end
	end
end
