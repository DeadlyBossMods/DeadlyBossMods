


local DBM_GUI = CreateFrame('Frame', 'DBM_Options_GUI', UIParent)

function DBM_GUI:Load()
    self.name = 'Deadly Boss Mods'

    local display = self:AddDisplayPanel()
    display:SetPoint('TOPLEFT', 10, -24)
    
    InterfaceOptions_AddCategory(self)


    local panel = CreateFrame("Frame", "DBM_Options_GUI_AggroAlert");
    panel.name = "Aggro Alert";
    panel.parent = "Deadly Boss Mods"; 
    InterfaceOptions_AddCategory(panel)

    local panel2 = CreateFrame("Frame", "DBM_Options_GUI_BossOptions");
    panel2.name = "Boss Options";
    panel2.parent = "Aggro Alert"; 
    InterfaceOptions_AddCategory(panel2)



end

function DBM_GUI:AddDisplayPanel()
    local panel = self:CreatePanel("General Options")
    panel:SetWidth(180); 
    panel:SetHeight(200)

    --show models
    local TestMe = self:CreateCheckButton("CheckMe", panel)
    TestMe:SetScript('OnShow', function(self) self:SetChecked(true) end)
    TestMe:SetScript('OnClick', function(self) DEFAULT_CHAT_FRAME:AddMessage("TEST") end)
    TestMe:SetPoint('TOPLEFT', 10, -8)

   return panel
end


-- BEGIN - Basic GUI Items
function DBM_GUI:CreatePanel(name)
	local panel = CreateFrame('Frame', self:GetName() .. name, self, 'OptionFrameBoxTemplate')
	panel:SetBackdropBorderColor(0.4, 0.4, 0.4)
	panel:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	getglobal(panel:GetName() .. 'Title'):SetText(name)
	return panel
end
function DBM_GUI:CreateCheckButton(name, parent)
	local button = CreateFrame('CheckButton', parent:GetName() .. name, parent, 'OptionsCheckButtonTemplate')
	getglobal(button:GetName() .. 'Text'):SetText(name)
	return button
end
function DBM_GUI:CreateDropdown(name, parent)
	local frame = CreateFrame('Frame', parent:GetName() .. name, parent, 'UIDropDownMenuTemplate')
	local text = frame:CreateFontString(nil, 'BACKGROUND')
	text:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 21, 0)
	text:SetFontObject('GameFontNormalSmall')
	text:SetText(name)
	return frame
end
-- END - Basic GUI Items


DBM_GUI:Load()



