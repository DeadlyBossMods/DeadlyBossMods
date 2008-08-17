-- **********************************************************
-- **                Deadly Boss Mods - GUI                **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * deDE: Nitram/Tandanu
--    * enGB: Nitram/Tandanu
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--


local FrameTitle = "DBM_GUI_Option_"	-- all GUI Frames get automatical a name FrameTitle..ID

local PanelPrototype = {}
DBM_GUI = {}
setmetatable(PanelPrototype, {__index = DBM_GUI})

local L = DBM_GUI_Translations


function DBM_GUI:CreateNewPanel(FrameName, OkButton, CancelButton, DefaultButton) 
	local panel = CreateFrame('Frame', FrameTitle..self:GetNewID())
	panel.name = FrameName
	if self == DBM_GUI then
		-- no panel.parent is need
	else
		panel.parent = self.frame.name
	end
	if type(OkButton) == "function" then
		panel.okay = OkButton
	end
	if type(CancelButton) == "function" then
		panel.cancel = CancelButton 
	end
	if type(DefaultButton) == "function" then
		panel.default = DefaultButton
	end
	InterfaceOptions_AddCategory(panel)
	
	self:SetLastObj(nil)
	self.panels = self.panels or {}
	table.insert(self.panels, {frame = panel, parent = self, framename = FrameTitle..self:GetCurrentID()})
	local obj = self.panels[#self.panels]
	return setmetatable(obj, {__index = PanelPrototype})
end

do
	local framecount = 0
	function DBM_GUI:GetNewID() 
		framecount = framecount + 1
		return framecount
	end
	function DBM_GUI:GetCurrentID()
		return framecount
	end

	local lastobject = nil
	function DBM_GUI:GetLastObj() 
		return lastobject
	end
	function DBM_GUI:SetLastObj(obj)
		lastobject = obj
		return lastobject
	end
end

-- BEGIN - Basic GUI Items
function PanelPrototype:CreateArea(name, width, height, autoplace)
	local area = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'OptionFrameBoxTemplate')
	area:SetBackdropBorderColor(0.4, 0.4, 0.4)
	area:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(FrameTitle..self:GetCurrentID()..'Title'):SetText(name)
	area:SetWidth(width)
	area:SetHeight(height)
	
	if autoplace then
		area:SetPoint('TOPLEFT', self.frame, 10, -20)
	end

	self:SetLastObj(nil)
	self.areas = self.areas or {}
	table.insert(self.areas, {frame = area, parent = self, framename = FrameTitle..self:GetCurrentID()})
	local obj = self.areas[#self.areas]
	return setmetatable(obj, {__index = PanelPrototype})
end
function PanelPrototype:CreateCheckButton(name, autoplace)
	local button = CreateFrame('CheckButton', FrameTitle..self:GetNewID(), self.frame, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)

	if autoplace then
		if self:GetLastObj() then
			button:ClearAllPoints()
			button:SetPoint('TOPLEFT', self:GetLastObj(), "BOTTOMLEFT", 0, 7)
		else
			button:ClearAllPoints()
			button:SetPoint('TOPLEFT', 10, -10)
		end
	end

	self:SetLastObj(button)
	return button
end
function PanelPrototype:CreateDropdown(name)
	local dropdown = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(FrameTitle..self:GetCurrentID().."Text", 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', dropdown, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)

	self:SetLastObj(dropdown)
	return dropdown
end
function PanelPrototype:CreateEditBox(text, value, width, height)
	local textbox = CreateFrame('EditBox', FrameTitle..self:GetNewID(), self.frame, 'DBM_GUI_FrameEditBoxTemplate')
	getglobal(FrameTitle..self:GetCurrentID().."Text"):SetText(text)
	textbox:SetWidth(width or 100)
	textbox:SetHeight(height or 20)

	self:SetLastObj(textbox)
	return textbox
end
function PanelPrototype:CreateSlider(text, low, high, step)
	local slider = CreateFrame('Slider', FrameTitle..self:GetNewID(), self.frame, 'OptionsSliderTemplate')
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	getglobal(FrameTitle..self:GetCurrentID()..'Text'):SetText(text)

	self:SetLastObj(slider)
	return slider
end
function PanelPrototype:CreateButton(title, width, height, onclick)
	local button = CreateFrame('Button', FrameTitle..self:GetNewID(), self.frame, 'UIPanelButtonTemplate')
	button:SetText(title)
	button:SetWidth(width or 100)
	button:SetHeight(height or 20)
	if onclick then
		button:SetScript("OnClick", onclick)
	end

	self:SetLastObj(button)
	return button
end
-- END - Basic GUI Items



do
	DBM_GUI_Frame = DBM_GUI:CreateNewPanel(L.TabCategory_Options, false)

	local generaloptions = DBM_GUI_Frame:CreateArea(L.General, 180, 180, true)

	local enabledbm = generaloptions:CreateCheckButton(L.EnableDBM, true)
	enabledbm:SetScript("OnShow",  function() enabledbm:SetChecked(DBM:IsEnabled()) end)
	enabledbm:SetScript("OnClick", function() if DBM:IsEnabled() then DBM:Disable(); else DBM:Enable(); end enabledbm:SetChecked(DBM:IsEnabled()) end)


	local test1 = generaloptions:CreateCheckButton("Enable Test1", true)
	local test2 = generaloptions:CreateCheckButton("Enable Test2", true)

	-- Raidwarning Colors
	local raidwarncolors = DBM_GUI_Frame:CreateArea(L.RaidWarnColors, 365, 118)
	raidwarncolors.frame:SetPoint('TOPLEFT', 10, -213)

	local slider1 = raidwarncolors:CreateSlider("test", 1, 10, 1)
	slider1:SetPoint('TOPLEFT', 20, -20)


	-- Pizza Timer (create your own timer menue)
	local pizzaarea = DBM_GUI_Frame:CreateArea(L.PizzaTimer_Headline, 365, 55)
	pizzaarea.frame:SetPoint('TOPLEFT', 10, -345)

	local textbox = pizzaarea:CreateEditBox(L.PizzaTimer_Title, "Pizza is done", 140)
	local hourbox = pizzaarea:CreateEditBox(L.PizzaTimer_Hours, "0", 25)
	local minbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Mins, "15", 25)
	local secbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Secs, "0", 25)
	local okbttn  = pizzaarea:CreateButton("OK", 53, 30);

	textbox:SetPoint('TOPLEFT', 20, -20)
	hourbox:SetPoint('TOPLEFT', textbox, "TOPRIGHT", 20, 0)
	minbox:SetPoint('TOPLEFT', hourbox, "TOPRIGHT", 20, 0)
	secbox:SetPoint('TOPLEFT', minbox, "TOPRIGHT", 20, 0)
	okbttn:SetPoint('TOPLEFT', secbox, "TOPRIGHT", 7, 6)
	-- END Pizza Timer


--	DBM_GUI_Frame:CreateSlider

	DBM_GUI_Aggro = DBM_GUI_Frame:CreateNewPanel("Bar Setup")


	DBM_GUI_Cat_Wotlk = DBM_GUI:CreateNewPanel(L.TabCategory_WOTLK, false)
		local nexxus = DBM_GUI_Cat_Wotlk:CreateNewPanel("The Nexxus")
		local utgarde = DBM_GUI_Cat_Wotlk:CreateNewPanel("Utgarde Keep")
		local anerub = DBM_GUI_Cat_Wotlk:CreateNewPanel("Azjol Nerub")
		local draktharon = DBM_GUI_Cat_Wotlk:CreateNewPanel("Drak'Tharon")

	DBM_GUI_Cat_BC = DBM_GUI:CreateNewPanel(L.TabCategory_BC, false)
		local sunwell = DBM_GUI_Cat_BC:CreateNewPanel("Sunwell")
		local bt = DBM_GUI_Cat_BC:CreateNewPanel("Black Temple")
		local mh = DBM_GUI_Cat_BC:CreateNewPanel("Mount Hyjal")
		local ssc = DBM_GUI_Cat_BC:CreateNewPanel("Serpentine Cavern")
		local tk = DBM_GUI_Cat_BC:CreateNewPanel("Tempest Keep")
		local kara = DBM_GUI_Cat_BC:CreateNewPanel("Karazhan")


	DBM_GUI_Cat_Classic = DBM_GUI:CreateNewPanel(L.TabCategory_Classic, false)
		local naxx = DBM_GUI_Cat_Classic:CreateNewPanel("Naxxramas")
		local aq40 = DBM_GUI_Cat_Classic:CreateNewPanel("AQ40")
		local aq20 = DBM_GUI_Cat_Classic:CreateNewPanel("AQ20")
		local bwl = DBM_GUI_Cat_Classic:CreateNewPanel("Black Wing Lair")
		local mc = DBM_GUI_Cat_Classic:CreateNewPanel("Molten Core")


end


