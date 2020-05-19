local MAX_BUTTONS = 10
local L = DBM_GUI_Translations

local tabFrame1 = CreateFrame("Frame", "DBM_GUI_DropDown", DBM_GUI_OptionsFrame, DBM:IsAlpha() and "BackdropTemplateMixin")
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

local tabFrame1List = CreateFrame("Frame", "$parentList", tabFrame1, DBM:IsAlpha() and "BackdropTemplate")
tabFrame1List:SetSize(24, 0)
tabFrame1List:SetPoint("TOPRIGHT", -11, -11)
tabFrame1List:SetPoint("BOTTOMRIGHT", -11, 11)
tabFrame1List:SetScript("OnVerticalScroll", function(self, offset)
	_G[self:GetName() .. "ScrollBar"]:SetValue(offset)
	tabFrame1.offset = math.floor(offset)
	tabFrame1:Refresh()
end)
tabFrame1List:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)

local tabFrame1ScrollBar = CreateFrame("Slider", "$parentScrollBar", tabFrame1)
tabFrame1ScrollBar:SetSize(16, 0)
tabFrame1ScrollBar:SetPoint("TOPRIGHT", 0, -17)
tabFrame1ScrollBar:SetPoint("BOTTOMRIGHT", 0, 17)
tabFrame1ScrollBar:SetMinMaxValues(0, 11)
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

local tabFrame1ScrollBarUp = CreateFrame("Button", "$parentScrollUpButton", tabFrame1ScrollBar, "UIPanelScrollUpButtonTemplate")
tabFrame1ScrollBarUp:SetPoint("TOP", 0, 15)
tabFrame1ScrollBarUp:Disable()
tabFrame1ScrollBarUp:SetScript("OnClick", function(self)
	tabFrame1ScrollBar:SetValue(tabFrame1ScrollBar:GetValue() - 1)
	tabFrame1.offset = tabFrame1ScrollBar:GetValue()
	tabFrame1:Refresh()
	PlaySound(1115)
end)

local tabFrame1ScrollBarDown = CreateFrame("Button", "$parentScrollDownButton", tabFrame1ScrollBar, "UIPanelScrollDownButtonTemplate")
tabFrame1ScrollBarDown:SetPoint("BOTTOM", 0, -15)
tabFrame1ScrollBarDown:SetScript("OnClick", function(self)
	tabFrame1ScrollBar:SetValue(tabFrame1ScrollBar:GetValue() + 1)
	self.offset = tabFrame1ScrollBar:GetValue()
	self:Refresh()
	PlaySound(1115)
end)

local tabFrame1ScrollBarThumb = tabFrame1ScrollBar:CreateTexture("$parentThumbTexture")
tabFrame1ScrollBarThumb:SetSize(18, 24)
tabFrame1ScrollBarThumb:SetTexCoord(0.2, 0.8, 0.125, 0.875)
tabFrame1ScrollBarThumb:SetTexture(130849) -- "Interface\\Buttons\\UI-ScrollBar-Knob"

local ClickFrame = CreateFrame("Button", nil, UIParent)
ClickFrame:SetAllPoints(DBM_GUI_OptionsFrame)
ClickFrame:SetFrameStrata("TOOLTIP")
ClickFrame:RegisterForClicks("AnyDown")
ClickFrame:Hide()
ClickFrame:SetScript("OnClick", function()
	tabFrame1:HideMenu()
end)

tabFrame1.buttons = {}
tabFrame1.fontbuttons = {}
local buttonTable = { "buttons", "fontbuttons" }
for i = 1, MAX_BUTTONS do
	for _, buttonName in ipairs(buttonTable) do
		local button = CreateFrame("Button", tabFrame1:GetName() .. "Button" .. buttonName .. i, tabFrame1, "GlueContextMenuButtonTemplate")
		button:SetSize(100, 16)
		if i == 1 then
			button:SetPoint("TOPLEFT", tabFrame1, "TOPLEFT", 11, -13)
		else
			button:SetPoint("TOPLEFT", tabFrame1[buttonName][i - 1], "BOTTOMLEFT")
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
		local buttonNormalText = CreateFrame("Frame", "$parentNormalText", button)
		buttonNormalText:SetPoint("LEFT", 5, 0)
		tabFrame1[buttonName][i] = button
	end
end

local default_button_width = tabFrame1.buttons[1]:GetWidth() + 16
tabFrame1:SetWidth(default_button_width + 22)
tabFrame1:SetHeight(MAX_BUTTONS * tabFrame1.buttons[1]:GetHeight() + 24)

tabFrame1.text = tabFrame1:CreateFontString("$parentText", "BACKGROUND")
tabFrame1.text:SetPoint("CENTER", tabFrame1, "BOTTOM")
tabFrame1.text:SetFontObject(GameFontNormalSmall)
tabFrame1.text:SetText("Scroll with mouse")
tabFrame1.text:Hide()

function tabFrame1:ShowMenu(values)
	self:Show()
	if self.offset > #values - MAX_BUTTONS then self.offset = #values - MAX_BUTTONS end
	if self.offset < 0 then self.offset = 0 end
	if #values > MAX_BUTTONS then
		self:SetHeight(MAX_BUTTONS * self.buttons[1]:GetHeight() + 24)
		self.text:Show()
	elseif #values == MAX_BUTTONS then
		self:SetHeight(MAX_BUTTONS * self.buttons[1]:GetHeight() + 24)
		self.text:Hide()
	elseif #values < MAX_BUTTONS then
		self:SetHeight(#values * self.buttons[1]:GetHeight() + 24)
		self.text:Hide()
	end
	for i = 1, MAX_BUTTONS do
		if i + self.offset <= #values then
			local ind = "   "
			if values[i + self.offset].value == self.dropdown.value then
				ind = "|TInterface\\Buttons\\UI-CheckBox-Check:0|t"
			end
			_G[self.buttons[i]:GetName() .. "NormalText"]:SetFontObject(GameFontHighlightSmall)
			self.buttons[i]:SetText(ind .. values[i + self.offset].text)
			self.buttons[i].entry = values[i + self.offset]
			if values[i + self.offset].texture then
				self.buttons[i].backdropInfo = {
					bgFile	= values[i + self.offset].texture
				}
				if not DBM:IsAlpha() then
					self.buttons[i]:SetBackdrop(self.buttons[i].backdropInfo)
				else
					self.buttons[i]:ApplyBackdrop()
				end
			end
			self.buttons[i]:Show()
		else
			self.buttons[i]:Hide()
		end
	end
	local width = self.buttons[1]:GetWidth()
	local bwidth = 0
	for k, button in pairs(self.buttons) do
		bwidth = button:GetTextWidth() + 16
		if bwidth > width then
			tabFrame1:SetWidth(bwidth + 32)
			width = bwidth
		end
	end
	for k, button in pairs(self.buttons) do
		button:SetWidth(width)
	end
	ClickFrame:Show()
end

function tabFrame1:ShowFontMenu(values)
	self:Show()
	if self.offset > #values - MAX_BUTTONS then
		self.offset = #values - MAX_BUTTONS
	end
	if self.offset < 0 then
		self.offset = 0
	end
	if #values > MAX_BUTTONS then
		self:SetHeight(MAX_BUTTONS * self.fontbuttons[1]:GetHeight() + 24)
		self.text:Show()
	elseif #values == MAX_BUTTONS then
		self:SetHeight(MAX_BUTTONS * self.fontbuttons[1]:GetHeight() + 24)
		self.text:Hide()
	elseif #values < MAX_BUTTONS then
		self:SetHeight(#values * self.fontbuttons[1]:GetHeight() + 24)
		self.text:Hide()
	end
	for i = 1, MAX_BUTTONS do
		if i + self.offset <= #values then
			local ind = "   "
			if values[i + self.offset].value == self.dropdown.value then
				ind = "|TInterface\\Buttons\\UI-CheckBox-Check:0|t"
			end
			_G[self.fontbuttons[i]:GetName() .. "NormalText"]:SetFont(values[i + self.offset].font, values[i + self.offset].fontsize or 14)
			self.fontbuttons[i]:SetText(ind .. values[i + self.offset].text)
			self.fontbuttons[i].entry = values[i + self.offset]
			self.fontbuttons[i]:Show()
		else
			self.fontbuttons[i]:Hide()
		end
	end
	local width = self.fontbuttons[1]:GetWidth()
	local bwidth = 0
	for _, button in pairs(self.fontbuttons) do
		bwidth = button:GetTextWidth() + 16
		if bwidth > width then
			self:SetWidth(bwidth + 32)
			width = bwidth
		end
	end
	for _, button in pairs(self.fontbuttons) do
		button:SetWidth(width)
	end
	ClickFrame:Show()
end

function tabFrame1:HideMenu()
	for i = 1, MAX_BUTTONS do
		self.buttons[i]:Hide()
		if not DBM:IsAlpha() then
			self.buttons[i]:SetBackdrop(nil)
		else
			self.buttons[i]:ClearBackdrop()
		end
		self.buttons[i]:SetWidth(default_button_width)
		_G[self.buttons[i]:GetName() .. "NormalText"]:SetFontObject(GameFontHighlightSmall)
		self.fontbuttons[i]:Hide()
		self.fontbuttons[i]:SetWidth(default_button_width)
	end
	self:SetWidth(default_button_width + 22)
	self:Hide()
	self.text:Hide()
	ClickFrame:Hide()
end

function tabFrame1:Refresh()
	if self.offset < 0 then
		self.offset = 0
	end
	local valuesWOButtons = #self.dropdown.values - MAX_BUTTONS
	if self.offset > valuesWOButtons then
		self.offset = valuesWOButtons
	end
	if self.dropdown.values[1].font then
		self:ShowFontMenu(self.dropdown.values)
	else
		self:ShowMenu(self.dropdown.values)
	end
	if #self.dropdown.values > MAX_BUTTONS then
		_tabFrame1List:Show()
		tabFrame1ScrollBar:SetMinMaxValues(0, valuesWOButtons)
		tabFrame1ScrollBar:SetValueStep(1)
	else
		tabFrame1List:Hide()
		tabFrame1ScrollBar:SetValue(0)
	end
end

local dropdownPrototype = {}

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
		titletext:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 21, 1)
		titletext:SetFontObject(GameFontNormalSmall)
		titletext:SetText(title)
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
