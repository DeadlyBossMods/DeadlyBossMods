

local DBM_GUI_Language = {}
DBM_GUI_Language.MainFrame = "Deadly Boss Mods"
DBM_GUI_Language.General = "General Options"
DBM_GUI_Language.Enable = "enable"
DBM_GUI_Language.Disable = "disable"



local FrameTitle = "DBM_GUI_Option_"	-- all GUI Frames get automatical a name FrameTitle..ID

local PanelPrototype = {}
DBM_GUI = {}
setmetatable(PanelPrototype, {__index = DBM_GUI})

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
end

-- BEGIN - Basic GUI Items
function PanelPrototype:CreateArea(name, width, height)
	local area = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'OptionFrameBoxTemplate')
	area:SetBackdropBorderColor(0.4, 0.4, 0.4)
	area:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(area:GetName() .. 'Title'):SetText(name)
	area:SetWidth(width)
	area:SetHeight(height)
		
	self.areas = self.areas or {}
	table.insert(self.areas, {frame = area, parent = self, framename = FrameTitle..self:GetCurrentID()})
	local obj = self.areas[#self.areas]
	return setmetatable(obj, {__index = PanelPrototype})
end
function PanelPrototype:CreateCheckButton(name)
	local button = CreateFrame('CheckButton', FrameTitle..self:GetNewID(), self.frame, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)
	return button
end
function PanelPrototype:CreateDropdown(name)
	local dropdown = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(FrameTitle..self:GetCurrentID().."Text", 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', dropdown, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)
	return dropdown
end
function PanelPrototype:CreateEditBox(text)
	local textbox = CreateFrame('EditBox', FrameTitle..self:GetNewID(), self.frame, 'DBM_GUI_FrameEditBoxTemplate')
	getglobal(FrameTitle..self:GetCurrentID().."Text"):SetText(text)

	return textbox
end
function PanelPrototype:CreateSlider(text, low, high, step)
	local slider = CreateFrame('Slider', FrameTitle..self:GetNewID(), self.frame, 'OptionsSliderTemplate')
	--slider:SetScript('OnMouseWheel', Slider_OnMouseWheel)
	--slider:EnableMouseWheel(true)
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)

	getglobal(FrameTitle..self:GetCurrentID()..'Text'):SetText(text)
	getglobal(FrameTitle..self:GetCurrentID()..'Low'):SetText()
	getglobal(FrameTitle..self:GetCurrentID()..'High'):SetText()

	--local text = slider:CreateFontString(nil, 'BACKGROUND')
	--text:SetFontObject('GameFontHighlightSmall')
	--text:SetPoint('LEFT', slider, 'RIGHT', 7, 0)
	--slider.valText = text 
	return slider
end

-- END - Basic GUI Items


do 
	DBM_GUI_Language.PizzaTimer = 'Create "Pizza" Timer'


	DBM_GUI_Frame = DBM_GUI:CreateNewPanel("Deadly Boss Mods", false)

	part1 = DBM_GUI_Frame:CreateArea(DBM_GUI_Language.General, 180, 180)
	part1.frame:SetPoint('TOPLEFT', 10, -20)

	part2 = DBM_GUI_Frame:CreateArea(DBM_GUI_Language.General, 180, 180)
	part2.frame:SetPoint('TOPLEFT', 195, -20)

	pizzaarea = DBM_GUI_Frame:CreateArea(DBM_GUI_Language.PizzaTimer, 180, 180)
	pizzaarea.frame:SetPoint('TOPLEFT', 10, -215)

	textbox = pizzaarea:CreateEditBox("lol")
	textbox:SetPoint('TOPLEFT', 10, -10)


	--part4 = DBM_GUI_Frame:CreateArea(DBM_GUI_Language.General, 180, 180)
	--part4.frame:SetPoint('TOPLEFT', 195, -215)

--	DBM_GUI_Frame:CreateSlider

	DBM_GUI_Aggro = DBM_GUI_Frame:CreateNewPanel("Aggro Alert")

end





