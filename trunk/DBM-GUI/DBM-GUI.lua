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


-- This Function Creates a new entry to the Menu
--
--  arg1 = Text for the UI Button
--  arg2 = nil or ("option" or 2)  ... nil wil place as a BossMod, otherwise as a Option Tab
--
function DBM_GUI:CreateNewPanel(FrameName, FrameTyp) 
	local panel = CreateFrame('Frame', FrameTitle..self:GetNewID())
	panel.name = FrameName
	if self == DBM_GUI then
		-- no panel.parent is need
	elseif self.parent == DBM_GUI then
		panel.parentparent = self.parent.frame.name
		panel.parent = self.frame.name
	else
		panel.parent = self.frame.name
	end


	--InterfaceOptions_AddCategory(panel)
	
	if FrameTyp == "option" or FrameTyp == 2 then
		DBM_GUI_CreateOption(panel)
	else
		DBM_GUI_CreateBossMod(panel)
	end

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

-- Function in the Prototype for a new SubArea, its a Area to group elements 
-- in a panel. Usefull for better usability.
--
--  arg1 = titel of this area
--  arg2 = width ot the area
--  arg3 = hight of the area
--  arg4 = autoplaced, true means that he put it on TopLeft corner
--
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

-- Function in the Prototype to create a CheckButton
-- This Button can placed automatical but only under the last one
--
--  arg1 = text right to the CheckBox
--  arg2 = autoplaced (true or nil/false)
--
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

-- Function in the Prototype to create a Dropdown Menu
-- This element likes the HTML <select ....> type
-- 
--  arg1 = Initial Text
--  arg2 = table with entrys
--  arg3 = function called on valuechanged (arg1 will be the new value)
--
function PanelPrototype:CreateDropdown(name, elemets, callfunc)
	local dropdown = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(FrameTitle..self:GetCurrentID().."Text", 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', dropdown, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)

	self:SetLastObj(dropdown)
	return dropdown
end

-- Function in the Prototype to create a EditBox
-- This Element likes the HTML <input type="text" ...>
--
--  arg1 = Title text, placed ontop of the EditBox
--  arg2 = Text placed within the EditBox
--  arg3 = width
--  arg4 = height
--
function PanelPrototype:CreateEditBox(text, value, width, height)
	local textbox = CreateFrame('EditBox', FrameTitle..self:GetNewID(), self.frame, 'DBM_GUI_FrameEditBoxTemplate')
	getglobal(FrameTitle..self:GetCurrentID().."Text"):SetText(text)
	textbox:SetWidth(width or 100)
	textbox:SetHeight(height or 20)

	self:SetLastObj(textbox)
	return textbox
end

-- Function in the Prototype to create an Slider
-- usefull for easy numeric value change
--
--  arg1 = text ontop of the slider, centered
--  arg2 = lowest value
--  arg3 = hightest value
--  arg4 = stepping
--
function PanelPrototype:CreateSlider(text, low, high, step)
	local slider = CreateFrame('Slider', FrameTitle..self:GetNewID(), self.frame, 'OptionsSliderTemplate')
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	getglobal(FrameTitle..self:GetCurrentID()..'Text'):SetText(text)

	self:SetLastObj(slider)
	return slider
end

-- Function in the Prototype to create a Button
-- like the HTML <input type="button"...>
--
--  arg1 = text on the button "OK", "Cancel",...
--  arg2 = widht
--  arg3 = height
--  arg4 = function to call when clicked
--
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

-- Function in the Prototype to create a Textblock
-- Can be used to create Information Text or something like this
--
--  arg1 = text to write
--  arg2 = width to set
function PanelPrototype:CreateText(text, width, autoplaced)
	local textblock = self.frame:CreateFontString(FrameTitle..self:GetNewID(), "ARTWORK", "GameFontNormal")
	textblock:SetText(text)
	if width then
		textblock:SetWidth( width or 100 )
	else
		textblock:SetWidth( self.frame:GetWidth() )
	end

	if autoplaced then
		textblock:SetPoint('TOPLEFT',self.frame, "TOPLEFT", 10, -10);
	end

	self:SetLastObj(textblock)
	return textblock
end




do
	local BossMods = {}
	local Options = {}

	-- This function is for Internal use.
	-- It places a new BossMod Tab in the GUI List
	function DBM_GUI_CreateBossMod(frame)
		if ( type(frame) == "table" and frame.name ) then
			table.insert(BossMods, frame)
		end
	end

	-- This function is for Internal use.
	-- It places a new Option Tab in the GUI List
	function DBM_GUI_CreateOption(frame)
		if ( type(frame) == "table" and frame.name ) then
			table.insert(Options, frame)
		end
	end

	local displayedElements = {}

	-- This function is for Internal use.
	-- Function to Update the Left Scrollframe Buttons with the menu entrys
	function DBM_GUI_OptionsFrame:UpdateMenuFrame(listframe)
		local offset = FauxScrollFrame_GetOffset(getglobal(listframe:GetName().."List"));
		local buttons = listframe.buttons;
		local TABLE

		if not buttons then return false; end

		if listframe:GetParent().tab == 2 then
			TABLE = Options
		else 
			TABLE = BossMods
		end
		local element;
		
		for i, element in ipairs(displayedElements) do
			displayedElements[i] = nil;
		end

		for i, element in ipairs(TABLE) do
			--DEFAULT_CHAT_FRAME:AddMessage(element.name)
			table.insert(displayedElements, element);
		end


		local numAddOnCategories = #displayedElements;
		local numButtons = #buttons;

		if ( numAddOnCategories > numButtons and ( not listframe:IsShown() ) ) then
			InterfaceOptionsList_DisplayScrollBar(listframe);
		elseif ( numAddOnCategories <= numButtons and ( listframe:IsShown() ) ) then
			InterfaceOptionsList_HideScrollBar(listframe);
		end
		
		FauxScrollFrame_Update(getglobal(listframe:GetName().."List"), numAddOnCategories, numButtons, buttons[1]:GetHeight());	


		local selection = DBM_GUI_OptionsFrameBossMods.selection;
		if ( selection ) then
			DBM_GUI_OptionsFrame:ClearSelection(listframe, listframe.buttons);
		end

		for i = 1, #buttons do
			element = displayedElements[i + offset]
			if ( not element ) then
				DBM_GUI_OptionsFrame:HideButton(buttons[i]);
			else
				DBM_GUI_OptionsFrame:DisplayButton(buttons[i], element);
				
				if ( selection ) and ( selection == element ) and ( not listframe.selection ) then
					DBM_GUI_OptionsFrame:SelectButton(listframe, buttons[i]);
				end
			end
		end
	end

	-- This function is for Internal use.
	-- Used to Show a Button from the List
	function DBM_GUI_OptionsFrame:DisplayButton(button, element)
		button:Show();
		button.element = element;
		
		if (element.parent) then
			button:SetNormalFontObject(GameFontNormal);
			button:SetHighlightFontObject(GameFontHighlightSmall);
			button.text:SetPoint("LEFT", 16, 2);
		elseif (element.parentsparent) then
			button:SetNormalFontObject(GameFontHighlightSmall);
			button:SetHighlightFontObject(GameFontHighlightSmall);
			button.text:SetPoint("LEFT", 24, 2);
		else
			button:SetNormalFontObject(GameFontNormal);
			button:SetHighlightFontObject(GameFontHighlight);
			button.text:SetPoint("LEFT", 8, 2);
		end
		button:SetWidth(165)

		button.text:SetText(element.name);
	end

	-- This function is for Internal use.
	-- Used to Hide a Button from the List
	function DBM_GUI_OptionsFrame:HideButton(button)
		button:SetWidth(165)
		button:Hide()
	end

	-- This function is for Internal use.
	-- Called when a new Selection is done
	function DBM_GUI_OptionsFrame:ClearSelection(listFrame, buttons)
		for _, button in ipairs(buttons) do button:UnlockHighlight(); end
		listFrame.selection = nil;
	end
	
	-- This function is for Internal use.
	-- Called when a Button is Selected
	function DBM_GUI_OptionsFrame:SelectButton(listFrame, button)
		button:LockHighlight()
		listFrame.selection = button.element;
	end

	-- This function is for Internal use.
	-- Required to Create a list of Buttons in the Scrollframe
	function DBM_GUI_OptionsFrame:CreateButtons(frame)
		local name = frame:GetName()
	
		frame.scrollBar = getglobal(name.."ListScrollBar")
		frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
		getglobal(name.."Bottom"):SetVertexColor(0.66, 0.66, 0.66)
	
		local buttons = {}
		local button = CreateFrame("BUTTON", name.."Button1", frame, "DBM_GUI_FrameButtonTemplate")
		button:SetPoint("TOPLEFT", frame, 0, -8)
		button:SetWidth(165)
		frame.buttonHeight = button:GetHeight()
		table.insert(buttons, button)
	
		local maxButtons = (frame:GetHeight() - 8) / frame.buttonHeight
		for i = 2, maxButtons do
			button = CreateFrame("BUTTON", name.."Button"..i, frame, "DBM_GUI_FrameButtonTemplate")
			button:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT")
			button:SetWidth(165)
			table.insert(buttons, button)
		end
		frame.buttons = buttons
	end

	-- This function is for Internal use.
	-- Called when someone click on a Button
	function DBM_GUI_OptionsFrame:OnButtonClick(button)
		local parent = button:GetParent();
		local buttons = parent.buttons;
	
		DBM_GUI_OptionsFrame:ClearSelection(DBM_GUI_OptionsFrameBossMods, DBM_GUI_OptionsFrameBossMods.buttons);
		DBM_GUI_OptionsFrame:ClearSelection(DBM_GUI_OptionsFrameDBMOptions, DBM_GUI_OptionsFrameDBMOptions.buttons);
		DBM_GUI_OptionsFrame:SelectButton(parent, button);

		DBM_GUI_OptionsFrame:DisplayFrame(button.element);
	end

	-- This function is for Internal use.
	-- places the selected tab on the containerframe
	function DBM_GUI_OptionsFrame:DisplayFrame(frame)
		if ( DBM_GUI_OptionsFramePanelContainer.displayedFrame ) then
			DBM_GUI_OptionsFramePanelContainer.displayedFrame:Hide();
		end
		
		DBM_GUI_OptionsFramePanelContainer.displayedFrame = frame;
		
		frame:SetParent(DBM_GUI_OptionsFramePanelContainer);
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", DBM_GUI_OptionsFramePanelContainer, "TOPLEFT");
		frame:SetPoint("BOTTOMRIGHT", DBM_GUI_OptionsFramePanelContainer, "BOTTOMRIGHT");
		frame:Show();
	end

end


do
	-- *****************************************************************
	-- 
	--  begin creating the Option Frames, this is mainly hardcoded
	--  because this allows me to place all the options as I want.
	--
	--  This API can be used to Add own Tabs to our Menu
	--
	--  To create a new Tab please use the Global Variable
	--
	--    yourframe = DBM_GUI_Frame:CreateNewPanel("title", "option")
	--  
	--  You can use the widgets delivered to this Frame by calling the
	--  methods like
	--
	--    yourframe:CreateCheckButton("my first checkbox", true)
	--
	--  if you use the second argument as true, the checkboxes will be
	--  placed automatical. Each box is placed a line under the last.
	--
	-- *****************************************************************


	DBM_GUI_Frame = DBM_GUI:CreateNewPanel(L.TabCategory_Options, "option")

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
	-- END MAINPAGE
	

	-- Now we want to create a List of categorys
	-- this list is dynamical created by the installed AddOns
	local DBM_GUI_Categorys = {}
	for _,v in ipairs(DBM.Mods) do
		if not DBM_GUI_Categorys[v.category] then
			local panel = DBM_GUI:CreateNewPanel(getglobal("L.TabCategory_"..string.upper(v.category)) or L.TabCategory_Other, false)
			DBM_GUI_Categorys[v.category] = panel
			local ptext = panel:CreateText(L.TabInfoText_WOTLK)
			ptext:SetPoint('TOPLEFT', panel.frame, "TOPLEFT", 10, -10)
		end
	end
	
	for _,v in ipairs(DBM.Mods) do
		DBM_GUI_Categorys[v.category]:CreateNewPanel(v.name or "Error: X-DBM-Mod-Name")
	end

end

