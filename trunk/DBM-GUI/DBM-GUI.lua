

local DBM_GUI_Language = {}
DBM_GUI_Language.MainFrame = "Deadly Boss Mods"
DBM_GUI_Language.General = "General Options"
DBM_GUI_Language.Enable = "enable"
DBM_GUI_Language.Disable = "disable"

local framecount = 0
local PanelPrototype = {}
DBM_GUI = {}
DBM_GUI.panels = {}

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

	table.insert(self.panels, {frame = panel, parent = self, framename = "DBM_GUI_Option_"..framecount})
	local obj = self.panels[#self.panels]
	return setmetatable(obj, {__index = PanelPrototype})
end
function DBM_GUI:GetNewID() 
	framecount = framecount + 1
	return framecount
end
function DBM_GUI:GetCurrentID()
	return framecount
end

-- BEGIN - Basic GUI Items
PanelPrototype.panels = {}
PanelPrototype.areas = {}
PanelPrototype.CreateNewPanel 	= DBM_GUI.CreateNewPanel
PanelPrototype.GetNewID 	= DBM_GUI.GetNewID
function PanelPrototype:CreateArea(name, width, height)
	local panel = CreateFrame('Frame', "DBM_GUI_Option_"..self:GetNewID(), self.parent.frame, 'OptionFrameBoxTemplate')
	panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	panel:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(panel:GetName() .. 'Title'):SetText(name)
	panel:SetWidth(width)
	panel:SetHeight(height)

	table.insert(self.areas, {frame = panel, parent = self, framename = "DBM_GUI_Option_"..framecount})
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




