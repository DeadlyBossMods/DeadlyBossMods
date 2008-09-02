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



function DBM_GUI:ShowHide(forceshow)
	if not DBM_GUI_Frame then DBM_GUI:CreateOptionsMenu() end

	if forceshow == true then
		self:UpdateModList()
		DBM_GUI_OptionsFrame:Show()

	elseif forceshow == false then
		DBM_GUI_OptionsFrame:Hide()

	else 
		if DBM_GUI_OptionsFrame:IsShown() then 
			DBM_GUI_OptionsFrame:Hide() 
		else 
			self:UpdateModList()
			DBM_GUI_OptionsFrame:Show() 
		end
	end
end


-- This Function Creates a new entry to the Menu
--
--  arg1 = Text for the UI Button
--  arg2 = nil or ("option" or 2)  ... nil will place as a BossMod, otherwise as a Option Tab
--
function DBM_GUI:CreateNewPanel(FrameName, FrameTyp) 
	local panel = CreateFrame('Frame', FrameTitle..self:GetNewID())
	panel.name = FrameName
	if self == DBM_GUI then
		-- no panel.parent is need
	elseif self.parent == DBM_GUI then
		panel.parent = self.frame.name
	else
		panel.parentparent = self.frame.name
	end
	
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
function PanelPrototype:CreateCheckButton(name, autoplace, textleft)
	local button = CreateFrame('CheckButton', FrameTitle..self:GetNewID(), self.frame, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)

	if textleft then
		getglobal(button:GetName() .. 'Text'):ClearAllPoints()
		getglobal(button:GetName() .. 'Text'):SetPoint("RIGHT", button, "LEFT", 3, 0)
	end

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

-- Function in the Prototype to create an ColorPicker
-- usefull for easy color change
--
--  arg1 = width of the colorcircle (128 default)
--  arg2 = true if you want an alpha selector
--  arg3 = width of the alpha selector (32 default)

function PanelPrototype:CreateColorSelect(dimension, withalpha, alphawidth)
	--- Color select texture with wheel and value
	local colorselect = CreateFrame("ColorSelect", FrameTitle..self:GetNewID(), self.frame)
	colorselect:SetParent(self.frame)
	if withalpha then
		colorselect:SetWidth((dimension or 128)+37)
	else
		colorselect:SetWidth((dimension or 128))
	end
	colorselect:SetHeight(dimension or 128)
	colorselect:Show()
	
	-- create a color wheel
	local colorwheel = colorselect:CreateTexture()
	colorwheel:SetWidth(dimension or 128)
	colorwheel:SetHeight(dimension or 128)
	colorwheel:SetPoint("TOPLEFT", colorselect, "TOPLEFT", 5, 0)
	colorwheel:Show()
	colorselect:SetColorWheelTexture(colorwheel)
	
	-- create the colorpicker
	local colorwheelthumbtexture = colorselect:CreateTexture()
	colorwheelthumbtexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
	colorwheelthumbtexture:SetWidth(10)
	colorwheelthumbtexture:SetHeight(10)
	colorwheelthumbtexture:SetTexCoord(0,0.15625, 0, 0.625)
	colorwheelthumbtexture:Show()
	colorselect:SetColorWheelThumbTexture(colorwheelthumbtexture)
	
	if withalpha then
		-- create the alpha bar
		local colorvalue = colorselect:CreateTexture()
		colorvalue:SetWidth(alphawidth or 32)
		colorvalue:SetHeight(dimension or 128)
		colorvalue:SetPoint("LEFT", colorwheel, "RIGHT", 10, -3)
		colorvalue:Show()
		colorselect:SetColorValueTexture(colorvalue)
	
		-- create the alpha arrows
		local colorvaluethumbtexture = colorselect:CreateTexture()
		colorvaluethumbtexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
		colorvaluethumbtexture:SetWidth( (alphawidth/32  or 1) * 48)
		colorvaluethumbtexture:SetHeight( (alphawidth/32 or 1) * 14)
		colorvaluethumbtexture:SetTexCoord(0.25, 1, 0.875, 0)
		colorvaluethumbtexture:Show()
		colorselect:SetColorValueThumbTexture(colorvaluethumbtexture)
	end
	
	self:SetLastObj(colorselect)
	return colorselect
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


function PanelPrototype:CreateCreatureModelFrame(width, hight, creatureid)
	local ModelFrame = CreateFrame('PlayerModel', FrameTitle..self:GetNewID(), self.frame)
	ModelFrame:SetWidth(width or 100)
	ModelFrame:SetHeight(height or 200)
	ModelFrame:SetCreature(tonumber(creatureid) or 448)	-- Hogger!!! hey kills all of you
	
	self:SetLastObj(ModelFrame)
	return ModelFrame	
end





local ListFrameButtonsPrototype = {}
-- Prototyp for ListFrame Options Buttons
ListFrameButtonsPrototype.Buttons = {}

function ListFrameButtonsPrototype:CreateCategory(frame, parent)
	if not type(frame) == "table" or not frame.name then
		return false;
	end
	frame.parent = self:GetParent(parent) or nil
	frame.showsub = frame.showsub or false

	table.insert(ListFrameButtonsPrototype.Buttons, {
		frame = frame,
		parent = parent or nil
	})
end

function ListFrameButtonsPrototype:GetParent(parent)
	for k,v in ipairs(self.Buttons) do
		if v.parent == parent then
			return ListFrameButtonsPrototype.Buttons[k]
		end
	end
	return nil
end

function ListFrameButtonsPrototype:GetVisibleTabs()
	local table = {}
	for k,v in ipairs(self.Buttons) do
		if v.parent == nil then 
			table.insert(table, v)
		elseif v.showsub then
			for k2,v2 in ipairs(self:GetVisibleSubTabs(v.parent)) do
				table.insert(table, v2)
			end
		end
	end
	return table
end

function ListFrameButtonsPrototype:GetVisibleSubTabs(parent)
	local subtable = {}
	for k,v in ipairs(self.Buttons) do
		if v.parent == parent then
			table.insert(table, v)
			if v.showsub then
				for k2,v2 in ipairs(self:GetVisibleSubTabs(v.parent)) do
					table.insert(table, v2)
				end
			end
		end
	end
	return table
end
	
do
	local mt = {__index = ListFrameButtonsPrototype}
	function CreateNewFauxScrollFrameList()
		return setmetatable({}, mt)
	end
end

DBM_GUI_Bosses = CreateNewFauxScrollFrameList()
DBM_GUI_Options = CreateNewFauxScrollFrameList()




do
	-- the functions in this block are only used to 
	-- create/update/manage the Fauxscrollframe for Boss/Options Selection
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


		--todo this sucks!
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
		
		if element.parentparent then
			button:SetNormalFontObject(GameFontHighlightSmall);
			button:SetHighlightFontObject(GameFontHighlightSmall);
			button.text:SetPoint("LEFT", 24, 2);

		elseif element.parent then
			button:SetNormalFontObject(GameFontNormalSmall);
			button:SetHighlightFontObject(GameFontNormalSmall);
			button.text:SetPoint("LEFT", 16, 2);
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


function DBM_GUI:CreateOptionsMenu()
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

	do -- we sepearte the tabs for performance/memory improofments
		local generaloptions = DBM_GUI_Frame:CreateArea(L.General, 365, 140, true)
	
		local enabledbm = generaloptions:CreateCheckButton(L.EnableDBM, true)
		enabledbm:SetScript("OnShow",  function() enabledbm:SetChecked(DBM:IsEnabled()) end)
		enabledbm:SetScript("OnClick", function() if DBM:IsEnabled() then DBM:Disable(); else DBM:Enable(); end enabledbm:SetChecked(DBM:IsEnabled()) end)
	
		local test1 = generaloptions:CreateCheckButton("Enable Test1", true)
		local test2 = generaloptions:CreateCheckButton("Enable Test2", true)
	
		-- Raidwarning Colors
		local raidwarncolors = DBM_GUI_Frame:CreateArea(L.RaidWarnColors, 365, 155)
		raidwarncolors.frame:SetPoint('TOPLEFT', 10, -176)
	
		local color1 = raidwarncolors:CreateColorSelect(64)
		local color2 = raidwarncolors:CreateColorSelect(64)
		local color3 = raidwarncolors:CreateColorSelect(64)
		local color4 = raidwarncolors:CreateColorSelect(64)
		local color1text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64); 	color1.textid = color1text; color1.myid = 1
		local color2text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64); 	color2.textid = color2text; color2.myid = 2
		local color3text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64); 	color3.textid = color3text; color3.myid = 3
		local color4text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64); 	color4.textid = color4text; color4.myid = 4
	
		color1:SetPoint('TOPLEFT', 20, -20)
		color2:SetPoint('TOPLEFT', color1, "TOPRIGHT", 20, 0)
		color3:SetPoint('TOPLEFT', color2, "TOPRIGHT", 20, 0)
		color4:SetPoint('TOPLEFT', color3, "TOPRIGHT", 20, 0)
	
		local function UpdateColor(self)
			local r, g, b = self:GetColorRGB()
			self.textid:SetTextColor(r, g, b)
			DBM.Options.WarningColors[self.myid].r = r
			DBM.Options.WarningColors[self.myid].g = g
			DBM.Options.WarningColors[self.myid].b = b 
		end
	
		color1:SetScript("OnColorSelect", UpdateColor)
		color2:SetScript("OnColorSelect", UpdateColor)
		color3:SetScript("OnColorSelect", UpdateColor)
		color4:SetScript("OnColorSelect", UpdateColor)
	
		color1:SetColorRGB(DBM.Options.WarningColors[1].r, DBM.Options.WarningColors[1].g, DBM.Options.WarningColors[1].b)
		color2:SetColorRGB(DBM.Options.WarningColors[2].r, DBM.Options.WarningColors[2].g, DBM.Options.WarningColors[2].b)
		color3:SetColorRGB(DBM.Options.WarningColors[3].r, DBM.Options.WarningColors[3].g, DBM.Options.WarningColors[3].b)
		color4:SetColorRGB(DBM.Options.WarningColors[4].r, DBM.Options.WarningColors[4].g, DBM.Options.WarningColors[4].b)
		
		-- Text Position
		color1text:SetPoint('TOPLEFT', color1, "BOTTOMLEFT", 3, -10)
		color2text:SetPoint('TOPLEFT', color2, "BOTTOMLEFT", 3, -10)
		color3text:SetPoint('TOPLEFT', color3, "BOTTOMLEFT", 3, -10)
		color4text:SetPoint('TOPLEFT', color4, "BOTTOMLEFT", 3, -10)
	
		color1text:SetJustifyH("CENTER")
		color2text:SetJustifyH("CENTER")
		color3text:SetJustifyH("CENTER")
		color4text:SetJustifyH("CENTER")
	
	
		local infotext = raidwarncolors:CreateText(L.InfoRaidWarning, 330, false)
		infotext:SetPoint('TOPLEFT', 15, -120)
		infotext:SetJustifyH("LEFT")
		infotext:SetFontObject(GameFontNormalSmall);
	
	
		local movemebutton = raidwarncolors:CreateButton(L.MoveMe, 100, 16)
		movemebutton:SetPoint('BOTTOMRIGHT', raidwarncolors.frame, "TOPRIGHT", 0, -1)
		movemebutton:SetNormalFontObject(GameFontNormalSmall);
		movemebutton:SetHighlightFontObject(GameFontNormalSmall);
	
		-- Pizza Timer (create your own timer menue)
		local pizzaarea = DBM_GUI_Frame:CreateArea(L.PizzaTimer_Headline, 365, 55)
		pizzaarea.frame:SetPoint('TOPLEFT', 10, -345)
	
		local textbox = pizzaarea:CreateEditBox(L.PizzaTimer_Title, "Pizza is done", 140)
		local hourbox = pizzaarea:CreateEditBox(L.PizzaTimer_Hours, "0", 25)
		local minbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Mins, "15", 25)
		local secbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Secs, "0", 25)
		local okbttn  = pizzaarea:CreateButton(L.Button_OK, 53, 30);
	
		textbox:SetPoint('TOPLEFT', 20, -20)
		hourbox:SetPoint('TOPLEFT', textbox, "TOPRIGHT", 20, 0)
		minbox:SetPoint('TOPLEFT', hourbox, "TOPRIGHT", 20, 0)
		secbox:SetPoint('TOPLEFT', minbox, "TOPRIGHT", 20, 0)
		okbttn:SetPoint('TOPLEFT', secbox, "TOPRIGHT", 7, 6)
		-- END Pizza Timer
		-- END MAINPAGE
	end
	do
		local TestMenu = DBM_GUI_Frame:CreateNewPanel("Model Test", "option")
		local bossmodelzone = TestMenu:CreateArea("ModelFrame", 140, 240, true)
		
		GUI_model = bossmodelzone:CreateCreatureModelFrame()
		GUI_model:SetPoint('TOPLEFT', 20, -20)
	end	
	do
		local BarSetup = DBM_GUI_Frame:CreateNewPanel(L.BarSetup, "option")
		
		local dummybar = DBM.Bars:CreateDummyBar()
		dummybar.frame:SetPoint('TOP', BarSetup.frame, "TOP", 0, -50)
		dummybar.frame:SetFrameStrata("TOOLTIP")
		dummybar.frame:SetParent(BarSetup.frame)
		dummybar:SetTimer(100)
		dummybar:SetElapsed(20)

		local iconleft = BarSetup:CreateCheckButton("Icon left")
		local iconright = BarSetup:CreateCheckButton("Icon right", false, true)
		iconleft:SetPoint('BOTTOMRIGHT', dummybar.frame, "TOPLEFT", -5, 5)
		iconright:SetPoint('BOTTOMLEFT', dummybar.frame, "TOPRIGHT", 5, 5)

		

	end

end	

do
	local DBM_GUI_Categories = {}
	function DBM_GUI:UpdateModList()
		-- Now we want to create a List of categorys
		-- this list is dynamical created by the installed AddOns
		for _,v in ipairs(DBM.AddOns) do
			if not DBM_GUI_Categories[v.category] then
				DBM_GUI_Categories[v.category] = DBM_GUI:CreateNewPanel(L["TabCategory_"..string.upper(v.category)] or L.TabCategory_Other, false)
	
				if L["TabCategory_"..string.upper(v.category)] then
					local ptext = DBM_GUI_Categories[v.category]:CreateText(L["TabCategory_"..string.upper(v.category)])
					ptext:SetPoint('TOPLEFT', DBM_GUI_Categories[v.category].frame, "TOPLEFT", 10, -10)
				end
			end
		end
		
		for _,v in ipairs(DBM.AddOns) do
			if not DBM_GUI_Categories[v.category][v.modId] then
				DBM_GUI_Categories[v.category][v.modId] = DBM_GUI_Categories[v.category]:CreateNewPanel(v.name or "Error: X-DBM-Mod-Name")

				local button = DBM_GUI_Categories[v.category][v.modId]:CreateButton("Load AddOn", 200, 30)
				button:SetScript("OnClick", function(self) 
					if DBM:LoadMod(v) then 
						self:Hide(); 
						DBM_GUI_OptionsFrameBossMods:Hide()
						DBM_GUI_OptionsFrameBossMods:Show()

						local ptext = DBM_GUI_Categories[v.category][v.modId]:CreateText(L.BossModLoaded)
						ptext:SetPoint('TOPLEFT', DBM_GUI_Categories[v.category][v.modId].frame, "TOPLEFT", 10, -10)

					end  
				end)
				button:SetPoint('CENTER', 0, -20)
				
			end
	
			for _, v2 in ipairs(DBM.Mods) do
				if v2.modId == v.modId then
					if not DBM_GUI_Categories[v.category][v.modId][v2.localization.general.name] then
						DBM_GUI_Categories[v.category][v.modId][v2.localization.general.name] = DBM_GUI_Categories[v.category][v.modId]:CreateNewPanel(v2.localization.general.name or "Error: DBM.Mods")
					end
				end
			end
		end
	end
end

