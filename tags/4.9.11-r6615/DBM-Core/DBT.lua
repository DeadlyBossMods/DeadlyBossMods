-- ***************************************************
-- **               Deadly Bar Timers               **
-- **         http://www.deadlybossmods.com         **
-- ***************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
-- 
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://wow.gamespot.com.cn
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: BlueNyx/nBlueWiz			bluenyx@gmail.com / everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
-- 
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share ?to copy, distribute, display, and perform the work
--    * to Remix ?to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.


---------------
--  Globals  --
---------------
DBT = {}
DBT_SavedOptions = {}


--------------
--  Locals  --
--------------
local fCounter = 1
local barPrototype = {}
local unusedBars = {}
local unusedBarObjects = setmetatable({}, {__mode = "kv"})
local instances = {}
local updateClickThrough
local options
local function stringFromTimer(t)
	if t <= 60 then
		return ("%.1f"):format(t)
	else
		return ("%d:%0.2d"):format(t/60, math.fmod(t, 60))
	end
end


-----------------------
--  Default Options  --
-----------------------
options = {
	BarXOffset = {
		type = "number",
		default = 0,
	},	
	BarYOffset = {
		type = "number",
		default = 0,
	},
	HugeBarXOffset = {
		type = "number",
		default = 0,
	},	
	HugeBarYOffset = {
		type = "number",
		default = 0,
	},
	ExpandUpwards = {
		type = "boolean",
		default = false,
	},
	Flash = {
		type = "boolean",
		default = true,
	},
	FadeIn = {
		type = "boolean",
		default = true,
	},
	Break = {
		type = "boolean",
		default = true,
	},
	IconLeft = {
		type = "boolean",
		default = true,
	},
	IconRight = {
		type = "boolean",
		default = false,
	},
	Texture = {
		type = "string",
		default = "Interface\\AddOns\\DBM-Core\\textures\\default.tga",
	},
	StartColorR = {
		type = "number",
		default = 1,
	},
	StartColorG = {
		type = "number",
		default = 0.7,
	},
	StartColorB = {
		type = "number",
		default = 0,
	},
	EndColorR = {
		type = "number",
		default = 1,
	},
	EndColorG = {
		type = "number",
		default = 0,
	},
	EndColorB = {
		type = "number",
		default = 0,
	},
	TextColorR = {
		type = "number",
		default = 1,
	},
	TextColorG = {
		type = "number",
		default = 1,
	},
	TextColorB = {
		type = "number",
		default = 1,
	},
	DynamicColor = {
		type = "boolean",
		default = true,
	},
	Width = {
		type = "number",
		default = 183,
	},
	Scale = {
		type = "number",
		default = 0.9,
	},
	HugeBarsEnabled = {
		type = "boolean",
		default = true,
	},
	HugeWidth = {
		type = "number",
		default = 200,
	},
	HugeScale = {
		type = "number",
		default = 1.03,
	},
	TimerPoint = {
		type = "string",
		default = "TOPRIGHT",
	},
	TimerX = {
		type = "number",
		default = -223,
	},
	TimerY = {
		type = "number",
		default = -260,
	},
	HugeTimerPoint = {
		type = "string",
		default = "CENTER",
	},
	HugeTimerX = {
		type = "number",
		default = 0,
	},
	HugeTimerY = {
		type = "number",
		default = -120,
	},
	EnlargeBarsTime = {
		type = "number",
		default = 8,
	},
	EnlargeBarsPercent = {
		type = "number",
		default = 0.125,
	},
	FillUpBars = {
		type = "boolean",
		default = true,
	},
	ClickThrough = {
		type = "boolean",
		default = false,
	},
	Font = {
		type = "string",
		default = STANDARD_TEXT_FONT,
	},
	FontSize = {
		type = "number",
		default = 10
	}
}

--------------------------
--  Double Linked List  --
--------------------------
--
-- this linked list can only contain tables that do not use the fields "prev" and "next"
-- this restriction especially means that an object must not be in two different linked lists at the same time
-- but this is sufficient for DBT here, having a wrapper object would just be an unnecessary overhead
-- special table keys for "prev"/"next" (e.g. userdata values) would add unnecessary complexity

local DLL = {}
DLL.__index = DLL

function DLL:Append(obj)
	if self.first == nil then -- list is empty
		self.first = obj
		self.last = obj
	else -- list is not empty
		obj.prev = self.last
		self.last.next = obj
		self.last = obj
	end
	return obj
end

function DLL:Remove(obj)
	if self.first == nil then -- list is empty...
		-- ...meaning the object is not even in the list, nothing we can do here expect for removing the "prev" and "next" entries from obj
	elseif self.first == obj and self.last == obj then -- list has only one element
		self.first = nil
		self.last = nil
	elseif self.first == obj then -- trying to remove the first element
		self.first = obj.next
		self.first.prev = nil
	elseif self.last == obj then -- trying to remove the last element
		self.last = obj.prev
		self.last.next = nil
	elseif obj.prev and obj.next then -- trying to remove something in the middle of the list
		obj.prev.next, obj.next.prev = obj.next, obj.prev
	end
	obj.prev = nil
	obj.next = nil
end

function DLL:New()
	return setmetatable({
		first = nil,
		last = nil
	}, self)
end
setmetatable(DLL, {__call = DLL.New})


-------------------------------
--  DBT Constructor/Options  --
-------------------------------
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
				defaultOptions = setmetatable({}, optionMT),
				mainAnchor = CreateFrame("Frame", nil, UIParent),
				secAnchor = CreateFrame("Frame", nil, UIParent),
				bars = {},
				smallBars = DLL(),
				hugeBars = DLL()
			},
			mt
		)
		obj.mainAnchor:SetHeight(1)
		obj.mainAnchor:SetWidth(1)
		obj.mainAnchor:SetPoint("TOPRIGHT", 223, -260)
		obj.mainAnchor:SetClampedToScreen(true)
		obj.mainAnchor:SetMovable(true)
		obj.mainAnchor:Show()
		obj.secAnchor:SetHeight(1)
		obj.secAnchor:SetWidth(1)
		obj.secAnchor:SetPoint("CENTER", 0, -120)
		obj.secAnchor:SetClampedToScreen(true)
		obj.secAnchor:SetMovable(true)
		obj.secAnchor:Show()
		table.insert(instances, obj)
		return obj
	end
	
	function DBT:LoadOptions(id)
		DBT_SavedOptions[id] = DBT_SavedOptions[id] or {}
		self.options = setmetatable(DBT_SavedOptions[id], optionMT)
		self.mainAnchor:ClearAllPoints()
		self.secAnchor:ClearAllPoints()
		self.mainAnchor:SetPoint(self.options.TimerPoint, UIParent, self.options.TimerPoint, self.options.TimerX, self.options.TimerY)
		self.secAnchor:SetPoint(self.options.HugeTimerPoint, UIParent, self.options.HugeTimerPoint, self.options.HugeTimerX, self.options.HugeTimerY)
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
	self:ApplyStyle()
end

function DBT:GetOption(option)
	return self.options[option]
end

function DBT:GetDefaultOption(option)
	return self.defaultOptions[option]
end


-----------------------
--  Bar Constructor  --
-----------------------
do
	local function createBarFrame(self)
		local frame
		if unusedBars[#unusedBars] then
			frame = unusedBars[#unusedBars]
			unusedBars[#unusedBars] = nil
			frame:Show()
		else
			frame = CreateFrame("Frame", "DBT_Bar_"..fCounter, self.mainAnchor, "DBTBarTemplate")
			fCounter = fCounter + 1
		end
		frame:EnableMouse(not self.options.ClickThrough or self.movable)
		return frame
	end	
	local mt = {__index = barPrototype}
	
	function DBT:CreateBar(timer, id, icon, huge, small, color, isDummy)
		if timer <= 0 then return end
		if (self.numBars or 0) >= 15 and not isDummy then return end
		local newBar = self:GetBar(id)
		if newBar then -- update an existing bar
			newBar:SetTimer(timer) -- this can kill the timer and the timer methods don't like dead timers
			if newBar.dead then return end
			newBar:SetElapsed(0) -- same
			if newBar.dead then return end
			newBar:ApplyStyle()
			newBar:SetText(id)
			newBar:SetIcon(icon)
		else -- create a new one
			newBar = next(unusedBarObjects, nil)
			local newFrame = createBarFrame(self)
			if newBar then
				unusedBarObjects[newBar] = nil
				newBar.dead = nil -- resurrected it :)
				newBar.frame = newFrame
				newBar.id = id
				newBar.timer = timer
				newBar.totalTime = timer
				newBar.owner = self
				newBar.moving = nil
				newBar.enlarged = nil
				newBar.fadingIn = 0
				newBar.small = small
				newBar.color = color
				newBar.flashing = nil
			else  -- duplicate code ;(
				newBar = setmetatable({
					frame = newFrame,
					id = id,
					timer = timer,
					totalTime = timer,
					owner = self,
					moving = nil,
					enlarged = nil,
					fadingIn = 0,
					small = small,
					color = color,
					flashing = nil
				}, mt)
			end
			newFrame.obj = newBar
			self.numBars = (self.numBars or 0) + 1
			if (timer <= self.options.EnlargeBarsTime or huge) and self:GetOption("HugeBarsEnabled") then -- starts enlarged?
				newBar.enlarged = true
				self.hugeBars:Append(newBar)
			else
				self.smallBars:Append(newBar)
			end
			newBar:ApplyStyle()
			newBar:SetText(id)
			newBar:SetIcon(icon)
			newBar:SetPosition()
			newBar:Update(0)
			self.bars[newBar] = true
		end
		return newBar
	end
end


-----------------
--  Dummy Bar  --
-----------------
do
	local dummyBars = 0
	local function dummyCancel(self)
		self.timer = self.totalTime
		self.flashing = nil
		self:Update(0)
		self.flashing = nil
		_G[self.frame:GetName().."BarSpark"]:SetAlpha(1)
	end
	function DBT:CreateDummyBar()
		dummyBars = dummyBars + 1
		local dummy = self:CreateBar(25, "dummy"..dummyBars, "Interface\\Icons\\Spell_Nature_WispSplode", nil, true, nil, true)
		dummy:SetText("Dummy")
		dummy:Cancel()
		self.bars[dummy] = true
		unusedBars[#unusedBars] = nil
		unusedBarObjects[dummy] = nil
		dummy.frame.obj = dummy
		dummy.frame:SetParent(UIParent)
		dummy.frame:ClearAllPoints()
		dummy.frame:SetScript("OnUpdate", nil)
		dummy.Cancel = dummyCancel
		dummy:ApplyStyle()
		dummy.dummy = true
		return dummy
	end
end


-----------------------------
--  General Bar Functions  --
-----------------------------
--do
--	local function iterator(self, frame)
--		return not frame and self.mainFirstBar or frame and frame.next
--	end
--	
--	local function reverseIterator(self, frame)
--		return (not frame and self.mainLastBar) or frame and frame.prev
--	end
--
--	function DBT:GetBarIterator(reverse)
--		return (reverse and reverseIterator) or iterator, self, nil
--	end
--end
function DBT:GetBarIterator()
	return pairs(self.bars)
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

function DBT:UpdateBar(id, elapsed, totalTime)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar:SetTimer(totalTime or bar.totalTime)
			bar:SetElapsed(elapsed or self.totalTime - self.timer)
			return true
		end
	end
	return false
end


---------------------------
--  General Bar Methods  --
---------------------------
function DBT:ShowTestBars()
	self:CreateBar(10, "Test 1", "Interface\\Icons\\Spell_Nature_WispSplode")
	self:CreateBar(14, "Test 2", "Interface\\Icons\\Spell_Nature_WispSplode")
	self:CreateBar(20, "Test 3", "Interface\\Icons\\Spell_Nature_WispSplode")
	self:CreateBar(12, "Test 4", "Interface\\Icons\\Spell_Nature_WispSplode")
	self:CreateBar(21.5, "Test 5", "Interface\\Icons\\Spell_Nature_WispSplode")
end

function barPrototype:SetTimer(timer)
	self.totalTime = timer
	self:Update(0)
end

function barPrototype:SetElapsed(elapsed)
	self.timer = self.totalTime - elapsed
	if (self.enlarged or self.moving == "enlarge") and not (self.timer <= self.owner.options.EnlargeBarsTime or (self.timer/self.totalTime) <= self.owner.options.EnlargeBarsPercent) then
		local next = self.next
		self:RemoveFromList()
		self.enlarged = nil
		self.moving = nil
		if next then
			next:MoveToNextPosition()
		end
		self.owner.smallBars:Append(self)
		self:SetPosition()
	end
	self:Update(0)
end

function barPrototype:SetText(text)
	_G[self.frame:GetName().."BarName"]:SetText(text)
end

function barPrototype:SetIcon(icon)
	_G[self.frame:GetName().."BarIcon1"]:SetTexture("")
	_G[self.frame:GetName().."BarIcon1"]:SetTexture(icon)
	_G[self.frame:GetName().."BarIcon2"]:SetTexture("")
	_G[self.frame:GetName().."BarIcon2"]:SetTexture(icon)
end

function barPrototype:SetColor(color)
	self.color = color
	_G[self.frame:GetName().."Bar"]:SetStatusBarColor(color.r, color.g, color.b)
	_G[self.frame:GetName().."BarSpark"]:SetVertexColor(color.r, color.g, color.b)
end

------------------
--  Bar Update  --
------------------
function barPrototype:Update(elapsed)
	local frame = self.frame
	local bar = _G[frame:GetName().."Bar"]
	local texture = _G[frame:GetName().."BarTexture"]
	local spark = _G[frame:GetName().."BarSpark"]
	local timer = _G[frame:GetName().."BarTimer"]
	local obj = self.owner
	self.timer = self.timer - elapsed
	if obj.options.DynamicColor and not self.color then
		local r = obj.options.StartColorR  + (obj.options.EndColorR - obj.options.StartColorR) * (1 - self.timer/self.totalTime)
		local g = obj.options.StartColorG  + (obj.options.EndColorG - obj.options.StartColorG) * (1 - self.timer/self.totalTime)
		local b = obj.options.StartColorB  + (obj.options.EndColorB - obj.options.StartColorB) * (1 - self.timer/self.totalTime)
		bar:SetStatusBarColor(r, g, b)
		spark:SetVertexColor(r, g, b)
	end
	if self.timer <= 0 then
		return self:Cancel()
	else
		if obj.options.FillUpBars then
			bar:SetValue(1 - self.timer/self.totalTime)
		else
			bar:SetValue(self.timer/self.totalTime)
		end
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", bar:GetValue() * bar:GetWidth(), -1)
		timer:SetText(stringFromTimer(self.timer))
	end
	if obj.options.FadeIn and self.fadingIn and self.fadingIn < 0.5 then
		self.fadingIn = self.fadingIn + elapsed
		frame:SetAlpha((self.fadingIn) / 0.5)
	elseif self.fadingIn then
		self.fadingIn = nil
	end
	
	if self.timer <= 7.75 and not self.flashing and obj.options.Flash then
		self.flashing = true
		self.ftimer = 0
	end
	if self.flashing then
		local ftime = self.ftimer % 1.25
		if ftime >= 0.5 then
			texture:SetAlpha(1)
			spark:SetAlpha(1)
		elseif ftime >= 0.25 then
			texture:SetAlpha(1 - (0.5 - ftime) / 0.25)
			spark:SetAlpha(1 - (0.5 - ftime) / 0.25)
		else
			texture:SetAlpha(1 - (ftime / 0.25))
			spark:SetAlpha(1 - (ftime / 0.25))
		end
		self.ftimer = self.ftimer + elapsed
	end
	if self.moving == "move" and self.moveElapsed <= 0.5 then
		self.moveElapsed = self.moveElapsed + elapsed
		local newX = self.moveOffsetX + (obj.options.BarXOffset - self.moveOffsetX) * (self.moveElapsed / 0.5)
		local newY
		if self.owner.options.ExpandUpwards then
			newY = self.moveOffsetY + 40 + (obj.options.BarYOffset - self.moveOffsetY) * (self.moveElapsed / 0.5)
		else
			newY = self.moveOffsetY + (-obj.options.BarYOffset - self.moveOffsetY) * (self.moveElapsed / 0.5)
		end
		frame:ClearAllPoints()
		frame:SetPoint(self.movePoint, self.moveAnchor, self.moveRelPoint, newX, newY)
	elseif self.moving == "move" then
		self.moving = nil
		self:SetPosition()
	elseif self.moving == "enlarge" and self.moveElapsed <= 1 then
		self:AnimateEnlarge(elapsed)
	elseif self.moving == "enlarge" then
		self.moving = nil
		self.enlarged = true
		self.owner.hugeBars:Append(self)
		self:ApplyStyle()
		self:SetPosition()
	end
	if (self.timer <= self.owner.options.EnlargeBarsTime or (self.timer/self.totalTime) <= self.owner.options.EnlargeBarsPercent) and (not self.small) and not self.enlarged and self.moving ~= "enlarge" and self.owner:GetOption("HugeBarsEnabled") then
		local next = self.next
		self:RemoveFromList()
		if next then
			local oldX = next.frame:GetRight() - next.frame:GetWidth()/2 -- the next frame's point needs to be cleared before we enlarge the bar to prevent the frame from "jumping around"
			local oldY = next.frame:GetTop() -- so we need to save the old point for :MoveToNextPosition() as :GetTop() and :GetRight() might return nil (sometimes? happened only once in 2 weeks of raiding...but it crashed DBT...) after :ClearAllPoints()
			next.frame:ClearAllPoints()
		end
		self:Enlarge()
		if next then
			next:MoveToNextPosition(oldX, oldY) -- ugly?
		end
	end
end

do
	local frame = CreateFrame("Frame")
	frame:SetScript("OnUpdate", function(self, elapsed)
		if UIParent:IsShown() then return end
		for i, v in ipairs(instances) do
			for bar in v:GetBarIterator() do
				bar:Update(elapsed)
			end
		end
	end)
end


-------------------
--  Movable Bar  --
-------------------
function DBT:SavePosition()
	local point, _, _, x, y = self.mainAnchor:GetPoint(1)
	self:SetOption("TimerPoint", point)
	self:SetOption("TimerX", x)
	self:SetOption("TimerY", y)
	local point, _, _, x, y = self.secAnchor:GetPoint(1)
	self:SetOption("HugeTimerPoint", point)
	self:SetOption("HugeTimerX", x)
	self:SetOption("HugeTimerY", y)
end

do
	local function moveEnd(self)
		updateClickThrough(self, self:GetOption("ClickThrough"))
		self.movable = false
	end
	
	function DBT:ShowMovableBar(small, large)
		if small or small == nil then
			local bar1 = self:CreateBar(20, "Move1", "Interface\\Icons\\Spell_Nature_WispSplode", nil, true)
			bar1:SetText(DBM_CORE_MOVABLE_BAR)
		end
		if large or large == nil then
			local bar2 = self:CreateBar(20, "Move2", "Interface\\Icons\\Spell_Nature_WispSplode", true)
			bar2:SetText(DBM_CORE_MOVABLE_BAR)
		end
		updateClickThrough(self, false)
		self.movable = true
		DBM:Unschedule(moveEnd, self)
		DBM:Schedule(20, moveEnd, self)
	end
end


--------------------
--  Bar Handling  --
--------------------
function barPrototype:RemoveFromList()
	if self.moving ~= "enlarge" then
		(self.enlarged and self.owner.hugeBars or self.owner.smallBars):Remove(self)
	end
end


------------------
--  Bar Cancel  --
------------------
function barPrototype:Cancel()
	local next = self.next
	table.insert(unusedBars, self.frame)
	self.frame:Hide()
	self.frame.obj = nil
	self:RemoveFromList()
	if next then
		next:MoveToNextPosition()
	end
	self.owner.bars[self] = nil
	unusedBarObjects[self] = self
	self.dead = true
	self.owner.numBars = (self.owner.numBars or 1) - 1
end


-----------------
--  Bar Style  --
-----------------
function DBT:ApplyStyle()
	for bar in self:GetBarIterator() do
		bar:ApplyStyle()
	end
end

function barPrototype:ApplyStyle()
	local frame = self.frame
	local bar = _G[frame:GetName().."Bar"]
	local spark = _G[frame:GetName().."BarSpark"]
	local texture = _G[frame:GetName().."BarTexture"]
	local icon1 = _G[frame:GetName().."BarIcon1"]
	local icon2 = _G[frame:GetName().."BarIcon2"]
	local name = _G[frame:GetName().."BarName"]
	local timer = _G[frame:GetName().."BarTimer"]
	texture:SetTexture(self.owner.options.Texture)
	if self.color then
		bar:SetStatusBarColor(self.color.r, self.color.g, self.color.b)
		spark:SetVertexColor(self.color.r, self.color.g, self.color.b)
	else
		bar:SetStatusBarColor(self.owner.options.StartColorR, self.owner.options.StartColorG, self.owner.options.StartColorB)
		spark:SetVertexColor(self.owner.options.StartColorR, self.owner.options.StartColorG, self.owner.options.StartColorB)
	end
	name:SetTextColor(self.owner.options.TextColorR, self.owner.options.TextColorG, self.owner.options.TextColorB)
	timer:SetTextColor(self.owner.options.TextColorR, self.owner.options.TextColorG, self.owner.options.TextColorB)
	if self.owner.options.IconLeft then icon1:Show() else icon1:Hide() end
	if self.owner.options.IconRight then icon2:Show() else icon2:Hide() end
	if self.enlarged then frame:SetWidth(self.owner.options.HugeWidth) else frame:SetWidth(self.owner.options.Width) end
	if self.enlarged then bar:SetWidth(self.owner.options.HugeWidth) else bar:SetWidth(self.owner.options.Width) end
	if self.enlarged then frame:SetScale(self.owner.options.HugeScale) else frame:SetScale(self.owner.options.Scale) end
	self.frame:Show()
	spark:SetAlpha(1)
	texture:SetAlpha(1)
	bar:SetAlpha(1)
	frame:SetAlpha(1)
	name:SetFont(self.owner.options.Font, self.owner.options.FontSize)
	timer:SetFont(self.owner.options.Font, self.owner.options.FontSize)
	self:Update(0)
end

local function updateOrientation(self)
	for bar in self:GetBarIterator() do
		if not bar.dummy then
			if bar.moving == "enlarge" then
				bar.enlarged = true
				bar.moving = false
				self.owner.hugeBars:Append(self)
				bar:ApplyStyle()
			end
			bar.moving = nil
			bar:SetPosition()
		end
	end
end
options.ExpandUpwards.onChange = updateOrientation
options.BarYOffset.onChange = updateOrientation
options.BarXOffset.onChange = updateOrientation

function updateClickThrough(self, newValue)
	if not self.movable then
		for bar in self:GetBarIterator() do
			if not bar.dummy then
				bar.frame:EnableMouse(not newValue)
			end
		end
	end
end
	
options.ClickThrough.onChange = updateClickThrough


--------------------
--  Bar Announce  --
--------------------
function barPrototype:Announce()
	local msg
	if self.owner.announceHook then
		msg = self.owner.announceHook(self)
	end
	msg = msg or ("%s  %d:%02d"):format(_G[self.frame:GetName().."BarName"]:GetText(), math.floor(self.timer / 60), self.timer % 60)
	local chatWindow = ChatEdit_GetActiveWindow()
	if chatWindow then
		chatWindow:Insert(msg)
	else
		SendChatMessage(msg, (select(2, IsInInstance()) == "pvp" and "BATTLEGROUND") or (GetNumRaidMembers() > 0 and "RAID") or "PARTY")
	end
end

function DBT:SetAnnounceHook(f)
	self.announceHook = f
end

-----------------------
--  Bar Positioning  --
-----------------------
function barPrototype:SetPosition()
	if self.moving == "enlarge" then return end
	local anchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor
	self.frame:ClearAllPoints()
	if self.owner.options.ExpandUpwards then
		self.frame:SetPoint("TOP", anchor, "BOTTOM", self.owner.options.BarXOffset, 40 + self.owner.options.BarYOffset)
	else
		self.frame:SetPoint("TOP", anchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
	end
end

function barPrototype:MoveToNextPosition(oldX, oldY)
	if self.moving == "enlarge" then return end
	local newAnchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor
	local oldX = oldX or (self.frame:GetRight() - self.frame:GetWidth()/2)
	local oldY = oldY or (self.frame:GetTop())
	self.frame:ClearAllPoints()
	if self.owner.options.ExpandUpwards then
		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, 40 + self.owner.options.BarYOffset)
	else
		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
	end
	local newX = self.frame:GetRight() - self.frame:GetWidth()/2
	local newY = self.frame:GetTop()
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", newAnchor, "BOTTOM", -(newX - oldX), -(newY - oldY))
	self.moving = "move"
	self.movePoint = "TOP"
	self.moveRelPoint = "BOTTOM"
	self.moveAnchor = newAnchor
	self.moveOffsetX = -(newX - oldX)
	self.moveOffsetY = -(newY - oldY)
	self.moveElapsed = 0
end

function barPrototype:Enlarge()
	local newAnchor = (self.owner.hugeBars.last and self.owner.hugeBars.last.frame) or self.owner.secAnchor
	local oldX = self.frame:GetRight() - self.frame:GetWidth()/2
	local oldY = self.frame:GetTop()
	self.frame:ClearAllPoints()
	if self.owner.options.ExpandUpwards then
		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, 40 + self.owner.options.BarYOffset)
	else
		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
	end
	local newX = self.frame:GetRight() - self.frame:GetWidth()/2
	local newY = self.frame:GetTop()
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", newAnchor, "BOTTOM", -(newX - oldX), -(newY - oldY))
	self.moving = "enlarge"
	self.movePoint = "TOP"
	self.moveRelPoint = "BOTTOM"
	self.moveAnchor = newAnchor
	self.moveOffsetX = -(newX - oldX)
	self.moveOffsetY = -(newY - oldY)
	self.moveElapsed = 0
end


---------------------------
--  Bar Special Effects  --
---------------------------
function barPrototype:AnimateEnlarge(elapsed)
	self.moveElapsed = self.moveElapsed + elapsed
	local newX = self.moveOffsetX + (self.owner.options.BarXOffset - self.moveOffsetX) * (self.moveElapsed / 1)
	local newY
	if self.owner.options.ExpandUpwards then
		newY = self.moveOffsetY + 50 + (self.owner.options.BarYOffset - self.moveOffsetY) * (self.moveElapsed / 1)
	else
		newY = self.moveOffsetY + (self.owner.options.BarYOffset - self.moveOffsetY) * (self.moveElapsed / 1)
	end
	local newWidth = self.owner.options.Width + (self.owner.options.HugeWidth - self.owner.options.Width ) * (self.moveElapsed / 1)
	local newScale = self.owner.options.Scale + (self.owner.options.HugeScale - self.owner.options.Scale) * (self.moveElapsed / 1)
	if (self.moveOffsetY > 0 and newY > self.owner.options.BarYOffset) or (self.moveOffsetY < 0 and newY < self.owner.options.BarYOffset) then
		self.frame:ClearAllPoints()
		self.frame:SetPoint(self.movePoint, self.moveAnchor, self.moveRelPoint, newX, newY)
		self.frame:SetScale(newScale)
		self.frame:SetWidth(newWidth)
		_G[self.frame:GetName().."Bar"]:SetWidth(newWidth)
	else
		self.moving = nil
		self.enlarged = true
		self.owner.hugeBars:Append(self)
		self:ApplyStyle()
		self:SetPosition()
	end
end

--[[
do
	local breakFrames = {}
	function barPrototype:Break() -- coming soon
		local frame = table.remove(breakTextures, #breakTextures) or CreateFrame("Frame", nil, self.owner.mainAnchor)
		frame:SetParent(self.owner.mainAnchor)
		frame.tex1 = frame.tex1 or frame:CreateTexture(nil, "OVERLAY")
		frame.tex2 = frame.tex2 or frame:CreateTexture(nil, "OVERLAY")
		local tex1 = frame.tex1
		local tex2 = frame.tex2
		tex1:SetTexture(self.owner.options.Texture)
		tex2:SetTexture(self.owner.options.Texture)
		-- tex1:SetTexCoordModifiesRect(true)  
		tex1:SetHorizTile(true)
		tex1:SetVertTile(true)
		tex1:SetTexCoord(0, 0.5, 0, 1)
	end
end
]]--

----------------------------------------
-- Functions used by the XML Template --
----------------------------------------
function DBT_Bar_OnLoad(self)
	self:SetMinMaxValues(0, 1)
	self:SetValue(1)
end

function DBT_Bar_OnUpdate(self, elapsed)
	self.obj:Update(elapsed)
end

function DBT_Bar_OnMouseDown(self, btn)
	if self.obj.owner.movable and btn == "LeftButton" then
		if self.obj.enlarged then
			self.obj.owner.secAnchor:StartMoving()
		else
			self.obj.owner.mainAnchor:StartMoving()
		end
	end
end

function DBT_Bar_OnMouseUp(self, btn)
	self.obj.owner.mainAnchor:StopMovingOrSizing()
	self.obj.owner.secAnchor:StopMovingOrSizing()
	self.obj.owner:SavePosition()
	if btn == "RightButton" then
		self.obj:Cancel()
	elseif btn == "LeftButton" and IsShiftKeyDown() then
		self.obj:Announce()
	end
end

function DBT_Bar_OnHide(self)
	if self.obj then
		self.obj.owner.mainAnchor:StopMovingOrSizing()
		self.obj.owner.secAnchor:StopMovingOrSizing()
	end
end
