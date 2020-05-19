local L = DBM_GUI_Translations

local tabFrame1 = CreateFrame("Frame", "DBM_GUI_DropDown", DBM_GUI_OptionsFrame, DBM:IsAlpha() and "BackdropTemplateMixin,OptionsFrameListTemplate" or "OptionsFrameListTemplate")
tabFrame1:Hide()
tabFrame1:SetFrameStrata("TOOLTIP")
tabFrame1.offset = 0
tabFrame1.backdropInfo = {
	bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
	edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
	tile		= 1,
	tileSize	= 32,
	edgeSize	= 32,
	insets		= { left = 11, right = 12, top = 12, bottom = 11 }
}
if not DBM:IsAlpha() then
	tabFrame1:SetBackdrop(tabFrame1.backdropInfo)
else
	tabFrame1:ApplyBackdrop()
end

local tabFrame1List = _G[tabFrame1:GetName() .. "List"]
tabFrame1List:SetScript("OnVerticalScroll", function(self, offset)
	_G[self:GetName() .. "ScrollBar"]:SetValue(offset)
	tabFrame1.offset = math.floor((offset / 16) + 0.5)
	tabFrame1:Refresh()
end)
tabFrame1List:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)

_G[tabFrame1List:GetName() .. "ScrollBarScrollUpButton"]:Disable()
_G[tabFrame1List:GetName() .. "ScrollBarScrollDownButton"]:Enable()

local tabFrame1ScrollBar = _G[tabFrame1List:GetName() .. "ScrollBar"]
tabFrame1ScrollBar:SetMinMaxValues(0, 11)
tabFrame1ScrollBar:SetValueStep(16)
tabFrame1ScrollBar:SetValue(0)
tabFrame1ScrollBar:SetScript("OnValueChanged", function(self, value)
	self:GetParent():SetVerticalScroll(value)
	local min, max = self:GetMinMaxValues()
	if value == min then
		_G[self:GetName() .. "ScrollUpButton"]:Disable()
	else
		_G[self:GetName() .. "ScrollUpButton"]:Enable()
	end
	if value == max then
		_G[self:GetName() .. "ScrollDownButton"]:Disable()
	else
		_G[self:GetName() .. "ScrollDownButton"]:Enable()
	end
end)

tabFrame1List:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then
		tabFrame1ScrollBar:SetValue(tabFrame1ScrollBar:GetValue() - (tabFrame1ScrollBar:GetHeight() / 2))
	else
		tabFrame1ScrollBar:SetValue(tabFrame1ScrollBar:GetValue() + (tabFrame1ScrollBar:GetHeight() / 2))
	end
	tabFrame1:Refresh()
end)

local ClickFrame = CreateFrame("Button", nil, UIParent)
ClickFrame:SetAllPoints(DBM_GUI_OptionsFrame)
ClickFrame:SetFrameStrata("TOOLTIP")
ClickFrame:RegisterForClicks("AnyDown")
ClickFrame:Hide()
ClickFrame:SetScript("OnClick", function()
	tabFrame1:HideMenu()
end)

tabFrame1.buttons = {}
for i = 1, 10 do
	local button = CreateFrame("Button", tabFrame1:GetName() .. "Button" .. i, tabFrame1, "UIDropDownMenuButtonTemplate")
	button:SetSize(100, 16)
	if i == 1 then
		button:SetPoint("TOPLEFT", tabFrame1, "TOPLEFT", 11, -13)
	else
		button:SetPoint("TOPLEFT", tabFrame1.buttons[i - 1]:GetName(), "BOTTOMLEFT")
	end
	button:SetScript("OnEnter", function(self)
		_G[self:GetName() .. "Highlight"]:Show()
	end)
	button:SetScript("OnLeave", function(self)
		_G[self:GetName() .. "Highlight"]:Hide()
	end)
	button:SetScript("OnClick", function(self)
		self:GetParent():HideMenu()
		self:GetParent().dropdown.value = self.entry.value
		self:GetParent().dropdown.text = self.entry.text
		if self.entry.sound then
			DBM:PlaySoundFile(self.entry.value)
		end
		if self.entry.func then
			self.entry.func(self.entry.value)
		end
		if self:GetParent().dropdown.callfunc then
			self:GetParent().dropdown.callfunc(self.entry.value)
		end
		_G[self:GetParent().dropdown:GetName() .. "Text"]:SetText(self.entry.text)
	end)
	tabFrame1.buttons[i] = button
end

tabFrame1.text = tabFrame1:CreateFontString("$parentText", "BACKGROUND")
tabFrame1.text:SetPoint("CENTER", tabFrame1, "BOTTOM")
tabFrame1.text:SetFontObject(GameFontNormalSmall)
tabFrame1.text:SetText("Scroll with mouse")
tabFrame1.text:Hide()

function tabFrame1:ShowMenu(values)
	self:Show()
	if self.offset > #values - #self.buttons then
		self.offset = #values - #self.buttons
	end
	if self.offset < 0 then
		self.offset = 0
	end
	if #values > #self.buttons then
		self:SetHeight(#self.buttons * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, (#values - #self.buttons) * 16)
		self.text:Show()
	elseif #values == #self.buttons then
		self:SetHeight(#self.buttons * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, 160)
		self.text:Hide()
	elseif #values < #self.buttons then
		self:SetHeight(#values * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, #values * 16)
		self.text:Hide()
	end
	for i = 1, #self.buttons do
		local button = self.buttons[i]
		local entry = values[i + self.offset]
		if not entry then
			button:SetText("")
			button:Hide()
		else
			_G[button:GetName() .. "NormalText"]:SetFontObject(GameFontHighlightSmall)
			button:SetText((entry.value == self.dropdown.value and "|TInterface\\Buttons\\UI-CheckBox-Check:0|t" or "   ") .. entry.text)
			button.entry = entry
			if entry.texture then
				button.backdropInfo = {
					bgFile	= entry.texture
				}
				if not DBM:IsAlpha() then
					button:SetBackdrop(button.backdropInfo)
				else
					button:ApplyBackdrop()
				end
			end
			button:Show()
		end
	end
	local bwidth = 0
	for _, button in pairs(self.buttons) do
		bwidth = math.max(bwidth, button:GetTextWidth() + 16)
	end
	for _, button in pairs(self.buttons) do
		button:SetWidth(bwidth)
	end
	self:SetWidth(bwidth + 16)
	ClickFrame:Show()
end

function tabFrame1:ShowFontMenu(values)
	self:Show()
	if self.offset > #values - #self.buttons then
		self.offset = #values - #self.buttons
	end
	if self.offset < 0 then
		self.offset = 0
	end
	if #values > #self.buttons then
		self:SetHeight(#self.buttons * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, (#values - #self.buttons) * 16)
		self.text:Show()
	elseif #values == #self.buttons then
		self:SetHeight(#self.buttons * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, 160)
		self.text:Hide()
	elseif #values < #self.buttons then
		self:SetHeight(#values * 16 + 24)
		tabFrame1ScrollBar:SetMinMaxValues(0, #values * 16)
		self.text:Hide()
	end
	for i = 1, #self.buttons do
		local button = self.buttons[i]
		local entry = values[i + self.offset]
		if not entry then
			button:SetText("")
			button:Hide()
		else
			if not DBM:IsAlpha() then
				button:SetBackdrop(nil)
			else
				button:ClearBackdrop()
			end
			_G[button:GetName() .. "NormalText"]:SetFont(type(entry.font) == "string" and entry.font or "GameFontHighlightSmall", entry.fontsize or 14)
			button:SetText((entry.value == self.dropdown.value and "|TInterface\\Buttons\\UI-CheckBox-Check:0|t" or "   ") .. entry.text)
			button.entry = entry
			button:Show()
		end
	end
	local bwidth = 0
	for _, button in pairs(self.buttons) do
		bwidth = math.max(bwidth, button:GetTextWidth() + 16)
	end
	for _, button in pairs(self.buttons) do
		button:SetWidth(bwidth)
	end
	self:SetWidth(bwidth + 16)
	ClickFrame:Show()
end

function tabFrame1:HideMenu()
	self:Hide()
	ClickFrame:Hide()
end

function tabFrame1:Refresh()
	if self.offset < 0 then
		self.offset = 0
	end
	local valuesWOButtons = #self.dropdown.values - #self.buttons
	if self.offset > valuesWOButtons then
		self.offset = valuesWOButtons
	end
	if self.dropdown.values[1].font then
		self:ShowFontMenu(self.dropdown.values)
	else
		self:ShowMenu(self.dropdown.values)
	end
	if #self.dropdown.values > #self.buttons then
		tabFrame1List:Show()
		tabFrame1ScrollBar:SetMinMaxValues(0, valuesWOButtons)
		tabFrame1ScrollBar:SetValueStep(1)
	else
		tabFrame1List:Hide()
		tabFrame1ScrollBar:SetValue(0)
	end
end

local dropdownPrototype = CreateFrame("Frame")

function dropdownPrototype:SetSelectedValue(selected)
	if selected and self.values and type(self.values) == "table" then
		for _, v in next, self.values do
			if v.value ~= nil and v.value == selected or v.text == selected then
				_G[self:GetName() .. "Text"]:SetText(v.text)
				self.value = v.value
				self.text = v.text
			end
		end
	end
end

function DBM_GUI:CreateDropdown(title, values, vartype, var, callfunc, width, height, parent)
	if type(values) == "table" then
		for _, entry in next, values do
			entry.text = entry.text or "Missing entry.text"
			entry.value = entry.value or entry.text
		end
	end
	local dropdown = CreateFrame("Frame", "DBM_GUI_DropDown" .. self:GetNewID(), parent or self.frame, "UIDropDownMenuTemplate")
	dropdown.values = values
	dropdown.callfunc = callfunc
	if not width then
		width = 120
		if title ~= L.Warn_FontType and title ~= L.Warn_FontStyle and title ~= L.Bar_Font then
			for _, v in ipairs(values) do
				_G[dropdown:GetName() .. "Text"]:SetText(v.text)
				width = math.max(width, _G[dropdown:GetName() .. "Text"]:GetStringWidth())
			end
		end
	end
	dropdown:SetSize(width + 30, height or 32)
	dropdown:SetScript("OnHide", nil)
	_G[dropdown:GetName() .. "Text"]:SetWidth(width + 30)
	_G[dropdown:GetName() .. "Text"]:SetJustifyH("LEFT")
	_G[dropdown:GetName() .. "Text"]:SetPoint("LEFT", dropdown:GetName() .. "Left", 30, 2)
	_G[dropdown:GetName() .. "Middle"]:SetWidth(width + 30)
	_G[dropdown:GetName() .. "Button"]:SetScript("OnClick", function(self)
		DBM:PlaySound(856)
		if tabFrame1:IsShown() then
			tabFrame1:HideMenu()
			tabFrame1.dropdown = nil
		else
			tabFrame1:ClearAllPoints()
			tabFrame1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -3)
			tabFrame1.dropdown = self:GetParent()
			tabFrame1:Refresh()
		end
	end)
	if title ~= nil and title ~= "" then
		local titleText = dropdown:CreateFontString(dropdown:GetName() .. "TitleText", "BACKGROUND")
		titleText:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 21, 1)
		titleText:SetFontObject(GameFontNormalSmall)
		titleText:SetText(title)
	end
	if vartype and vartype == "DBM" and DBM.Options[var] ~= nil then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBM.Options[var])
		end)
	elseif vartype and vartype == "DBT" then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBM.Bars:GetOption(var))
		end)
	elseif vartype then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(vartype.Options[var])
		end)
	else -- For external modules like DBM-RaidLeadTools
		for _, v in next, dropdown.values do
			if v.value ~= nil and v.value == var or v.text == var then
				_G[dropdown:GetName() .. "Text"]:SetText(v.text)
				dropdown.value = v.value
				dropdown.text = v.text
			end
		end
	end
	return setmetatable(dropdown, {
		__index = dropdownPrototype
	})
end
