

local DBM_GUI_Language = {}
DBM_GUI_Language.MainFrame = "Deadly Boss Mods"
DBM_GUI_Language.General = "General Options"
DBM_GUI_Language.Enable = "enable"
DBM_GUI_Language.Disable = "disable"

local PanelPrototype = {}
DBM_GUI = {}
setmetatable(PanelPrototype, {__index = DBM_GUI})

function DBM_GUI:CreateNewPanel(FrameName, OkButton, CancelButton, DefaultButton) 
	local panel = CreateFrame('Frame', "DBM_GUI_Option_"..self:GetNewID())
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
	table.insert(self.panels, {frame = panel, parent = self, framename = "DBM_GUI_Option_"..self:GetCurrentID()})
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
	local panel = CreateFrame('Frame', "DBM_GUI_Option_"..self:GetNewID(), self.frame, 'OptionFrameBoxTemplate')
	panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	panel:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(panel:GetName() .. 'Title'):SetText(name)
	panel:SetWidth(width)
	panel:SetHeight(height)
	panel:Show()
	
	self.areas = self.areas or {}
	table.insert(self.areas, {frame = panel, parent = self, framename = "DBM_GUI_Option_"..self:GetCurrentID()})
	local obj = self.areas[#self.areas]
	return setmetatable(obj, {__index = panelPrototype})
end
function PanelPrototype:CreateCheckButton(name)
	local button = CreateFrame('CheckButton', "DBM_GUI_Option_"..self:GetNewID(), self.parent.frame, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)
	return button
end
function PanelPrototype:CreateDropdown(name)
	local frame = CreateFrame('Frame', "DBM_GUI_Option_"..self:GetNewID(), self.parent.frame, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(nil, 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)
	return frame
end
-- END - Basic GUI Items

mainpanel = DBM_GUI:CreateNewPanel("Deadly Boss Mods", false)
mainpanel:CreateArea(DBM_GUI_Language.General, 180, 200)
subpanel = mainpanel:CreateNewPanel("Aggro Alert")




