

local DBM_GUI_Language = {}
DBM_GUI_Language.MainFrame = "Deadly Boss Mods"
DBM_GUI_Language.General = "General Options"
DBM_GUI_Language.Enable = "enable"
DBM_GUI_Language.Disable = "disable"


DBM_GUI = {}
DBM_GUI.panels = {}
DBM_GUI.areas = {}

function DBM_GUI:CreateNewPanel(FrameName, ParentFrame, OkButton, CancelButton, DefaultButton) 
	local panel = CreateFrame('Frame')
	panel.name = FrameName
	if ParentFrame then 
		panel.parent = ParentFrame 
	elseif ParentFrame == false then
		-- do nothing, this is the first declaration
	else
		panel.parent = DBM_GUI_Language.MainFrame
	end
	if type(OkButton) == "function" then
		panel.okay = OkButton
	end
	if type(CancelButton) == "function" then
		panel.cancel = OkButton
	end
	if type(DefaultButton) == "function" then
		panel.default = OkButton
	end
	InterfaceOptions_AddCategory(panel)

	table.insert(self.panels, {frame = panel})
	local obj = self.panels[#self.panels]
	return setmetatable(obj, {__index = panelPrototype})
end

-- BEGIN - Basic GUI Items
local PanelPrototype = {}
function PanelPrototype:CreateArea(name, width, height)
	local panel = CreateFrame('Frame', self:GetName() .. name, self, 'OptionFrameBoxTemplate')
	panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	panel:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(panel:GetName() .. 'Title'):SetText(name)
	panel:SetWidth(width)
	panel:SetHeight(height)

	table.insert(self.areas, {frame = panel})
	local obj = self.areas[#self.areas]
	return setmetatable(obj, {__index = panelPrototype})
end
function PanelPrototype:CreateCheckButton(name)
	local button = CreateFrame('CheckButton', parent:GetName() .. name, self, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)
	return button
end
function PanelPrototype:CreateDropdown(name)
	local frame = CreateFrame('Frame', parent:GetName() .. name, self, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(nil, 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)
	return frame
end


-- END - Basic GUI Items

mainpanel = DBM_GUI:CreateNewPanel("Deadly Boss Mods", false)
--mainpanel.frame:CreateArea(DBM_GUI_Language.General, 180, 200)


