local _, private = ...

local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

local pairs, next, type, ipairs, setmetatable, mfloor, mmax = pairs, next, type, ipairs, setmetatable, math.floor, math.max
local CreateFrame, GameFontNormalSmall = CreateFrame, GameFontNormalSmall
local DBM = DBM

local defaultFont, defaultFontSize = GameFontHighlightSmall:GetFont()

---@class DBM_GUI_DropDownTemplate: ScrollFrame, BackdropTemplate
local tabFrame1 = CreateFrame("ScrollFrame", "DBM_GUI_DropDown", _G["DBM_GUI_OptionsFrame"], "DBM_GUI_DropDownTemplate")
tabFrame1.backdropInfo = {
	bgFile		= "Interface\\ChatFrame\\ChatFrameBackground", -- 130937
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 16,
	insets		= { left = 3, right = 3, top = 5, bottom = 3 }
}

tabFrame1:Hide()
tabFrame1:SetFrameStrata("TOOLTIP")
tabFrame1.offset = 0
tabFrame1:ApplyBackdrop()
tabFrame1:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
tabFrame1:SetBackdropBorderColor(0.4, 0.4, 0.4)

-- Temporary hack, till I get both versions running smoothly on the new system
local tabFrame1List = _G[tabFrame1:GetName() .. "List"]
tabFrame1List:SetScript("OnVerticalScroll", function(self, offset)
	local scrollbar = _G[self:GetName() .. "ScrollBar"]
	local _, max = scrollbar:GetMinMaxValues()
	scrollbar:SetValue(offset)
	_G[self:GetName() .. "ScrollBarScrollUpButton"]:SetEnabled(offset ~= 0)
	_G[self:GetName() .. "ScrollBarScrollDownButton"]:SetEnabled(scrollbar:GetValue() - max ~= 0)
	tabFrame1.offset = mfloor(offset)
	tabFrame1:Refresh()
end)
Mixin(tabFrame1List, BackdropTemplateMixin)
tabFrame1List:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.9)

local tabFrame1ScrollBar = _G[tabFrame1List:GetName() .. "ScrollBar"]
tabFrame1ScrollBar:SetMinMaxValues(0, 11)
tabFrame1ScrollBar:SetValueStep(1)
tabFrame1ScrollBar:SetValue(0)

local scrollUpButton = _G[tabFrame1ScrollBar:GetName() .. "ScrollUpButton"]
scrollUpButton:SetSize(12, 12)
scrollUpButton:Disable()
scrollUpButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() - 1)
end)
local scrollDownButton = _G[tabFrame1ScrollBar:GetName() .. "ScrollDownButton"]
scrollDownButton:SetSize(12, 12)
scrollDownButton:Enable()
scrollDownButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() + 1)
end)

_G[tabFrame1ScrollBar:GetName() .. "ThumbTexture"]:SetSize(12, 16)

tabFrame1:EnableMouseWheel(true)
tabFrame1:SetScript("OnMouseWheel", function(_, delta)
	tabFrame1ScrollBar:SetValue(tabFrame1ScrollBar:GetValue() - delta)
end)

local ClickFrame = CreateFrame("Button", nil, UIParent)
ClickFrame:SetFrameStrata("TOOLTIP")
ClickFrame:RegisterForClicks("AnyDown")
ClickFrame:SetScript("OnClick", function()
	tabFrame1:Hide()
end)
ClickFrame:Hide()
tabFrame1:SetScript("OnHide", function()
	ClickFrame:Hide()
end)

tabFrame1.buttons = {}
for i = 1, 10 do
	---@class DBMFrameButton: Button, BackdropTemplate
	local button = CreateFrame("Button", tabFrame1:GetName() .. "Button" .. i, tabFrame1, "BackdropTemplate,UIDropDownMenuButtonTemplate")
	_G[button:GetName() .. "Check"]:Hide()
	_G[button:GetName() .. "UnCheck"]:Hide()
	button:SetFrameLevel(tabFrame1ScrollBar:GetFrameLevel() - 1)
	if i == 1 then
		button:SetPoint("TOPLEFT", tabFrame1, 11, -4)
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
		self:GetParent():Hide()
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
		if self:GetParent().dropdown.onSelectionChangedCallback then
			self:GetParent().dropdown:onSelectionChangedCallback(self.entry.value)
		end
		_G[self:GetParent().dropdown:GetName() .. "Text"]:SetText(self.entry.text)
	end)
	function button:Reset()
		_G[self:GetName() .. "NormalText"]:SetFont(defaultFont, defaultFontSize)
		self:SetHeight(0)
		self:SetText("")
		self:ClearBackdrop()
	end
	tabFrame1.buttons[i] = button
end

function tabFrame1:ShowMenu()
	for i = 1, #self.buttons do
		local button, entry = self.buttons[i], self.dropdown.values[i + self.offset]
		button:Reset()
		if entry then
			button:SetHeight(16)
			button:SetText((entry.value == self.dropdown.value and "|TInterface\\Buttons\\UI-CheckBox-Check:0|t" or "   ") .. entry.text)
			button.entry = entry
			if entry.texture then
				button.backdropInfo = {
					bgFile	= entry.value
				}
				button:ApplyBackdrop()
			end
		end
	end
end

function tabFrame1:ShowFontMenu()
	for i = 1, #self.buttons do
		local button, entry = self.buttons[i], self.dropdown.values[i + self.offset]
		button:Reset()
		if entry then
			button:SetHeight(16)
			_G[button:GetName() .. "NormalText"]:SetFont(entry.font and entry.value or defaultFont, entry.fontsize or defaultFontSize, entry.flag and entry.value)
			button:SetText((entry.value == self.dropdown.value and "|TInterface\\Buttons\\UI-CheckBox-Check:0|t" or "   ") .. entry.text)
			button.entry = entry
		end
	end
end

function tabFrame1:Refresh()
	if #self.dropdown.values == 0 then -- Quirky case where there may be no elements in the dropdown???
		return
	end
	self:Show()
	if self.offset < 0 then
		self.offset = 0
	end
	local valuesWOButtons = (#self.dropdown.values - #self.buttons)
	if #self.dropdown.values > #self.buttons and self.offset > valuesWOButtons then
		self.offset = valuesWOButtons
	end
	if self.dropdown.values[1].font or (#self.dropdown.values > 1 and self.dropdown.values[2].flag) then
		self:ShowFontMenu()
	else
		self:ShowMenu()
	end
	self:SetHeight(#self.buttons * 16 + 8)
	if #self.dropdown.values > #self.buttons then
		tabFrame1List:Show()
		tabFrame1ScrollBar:SetMinMaxValues(0, valuesWOButtons)
	else
		if #self.dropdown.values < #self.buttons then
			tabFrame1List:Hide()
			self:SetHeight(#self.dropdown.values * 16 + 8)
		end
		tabFrame1ScrollBar:SetValue(0)
	end
	local bwidth = 0
	for _, button in pairs(self.buttons) do
		bwidth = mmax(bwidth, button:GetTextWidth() + 16)
	end
	for _, button in pairs(self.buttons) do
		button:SetWidth(bwidth)
	end
	bwidth = math.max(bwidth, tabFrame1.largestWidth or 0)
	tabFrame1.largestWidth = bwidth
	self:SetWidth(bwidth + 16)
	ClickFrame:Show()
end

---@class DBMDropDown: Frame
local dropdownPrototype = CreateFrame("Frame")

-- For lazily loaded dropdowns: pass a single dropdown entry, for normal dropdowns pass a single value or name
function dropdownPrototype:SetSelectedValue(selected)
	local text = _G[self:GetName() .. "Text"]
	if selected and self.values and type(self.values) == "table" then
		for _, v in next, self.values do
			if v.value ~= nil and v.value == selected or v.text == selected then
				text:SetText(v.text)
				self.value = v.value
				self.text = v.text
				if self.onSelectionChangedCallback then
					self:onSelectionChangedCallback(v)
				end
			end
		end
	elseif type(self.values) ~= "table" then -- lazily loaded dropdown, set to whatever was given no matter if it exists
		text:SetText(selected.text)
		self.value = selected.value
		self.text = selected.text
		if self.onSelectionChangedCallback then
			self:onSelectionChangedCallback(selected)
		end
	end
end

-- Called if the selection changes by either the user or by calling SetSelectedValue
function dropdownPrototype:OnSelectionChanged(callback)
	self.onSelectionChangedCallback = callback
end

function dropdownPrototype:RefreshLazyValues()
	if not self.valueGetter then
		error("called RefreshLazyValues() on a static dropdown", 2)
	end
	self.values = self:valueGetter()
end

-- values can either be a table or a function, if it's a function it gets called every time the dropdown is opened to populate the values
---@diagnostic disable-next-line: duplicate-set-field
function DBM_GUI:CreateDropdown(title, values, vartype, var, callfunc, width, height, parent)
	if type(values) == "table" then
		for _, entry in next, values do
			entry.text = entry.text or "Missing entry.text"
			entry.value = entry.value or entry.text
		end
	end
	---@class DBMDropDown
	---@diagnostic disable-next-line: undefined-field -- frame comes from a subclass of DBM_GUI
	local dropdown = CreateFrame("Frame", "DBM_GUI_DropDown" .. self:GetNewID(), parent or self.frame, "UIDropDownMenuTemplate")
	dropdown.mytype = "dropdown"
	dropdown.width = width
	dropdown.myheight = nil
	if type(values) == "function" then
		dropdown.valueGetter = values
	else
		dropdown.values = values
	end
	dropdown.callfunc = callfunc
	local dropdownText = _G[dropdown:GetName() .. "Text"]
	if not width then
		width = 120
		if title ~= L.FontType and title ~= L.FontStyle and title ~= L.FontShadow then
			for _, v in ipairs(values) do
				dropdownText:SetText(v.text)
				width = mmax(width, dropdownText:GetStringWidth())
			end
		end
	end
	dropdown:SetSize(width + 30, height or 32)
	dropdown:SetScript("OnHide", nil)
	dropdownText:SetWidth(width + 30)
	dropdownText:SetJustifyH("LEFT")
	dropdownText:SetPoint("LEFT", dropdown:GetName() .. "Left", 30, 2)
	_G[dropdown:GetName() .. "Middle"]:SetWidth(width + 30)
	local dropdownButton = _G[dropdown:GetName() .. "Button"]
	dropdownButton:SetScript("OnMouseDown", function() DBM:PlaySoundFile(567407) end)
	dropdownButton:SetScript("OnClick", function(self)
		if tabFrame1:IsShown() then
			tabFrame1:Hide()
			tabFrame1.dropdown = nil
		else
			if dropdown.valueGetter then
				dropdown:RefreshLazyValues()
			end
			tabFrame1.largestWidth = 0
			tabFrame1:ClearAllPoints()
			tabFrame1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -3)
			tabFrame1.dropdown = dropdown
			tabFrame1:Refresh()
		end
	end)
	if title ~= nil and title ~= "" then
		local titleText = dropdown:CreateFontString(dropdown:GetName() .. "TitleText", "BACKGROUND")
		titleText:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 21, 1)
		titleText:SetFontObject(GameFontNormalSmall)
		titleText:SetText(private.parseDescription(title))
	end
	if vartype and vartype == "DBM" and DBM.Options[var] ~= nil then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBM.Options[var])
		end)
	elseif vartype and vartype == "DBT" then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBT.Options[var])
		end)
	elseif vartype then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(vartype.Options[var])
		end)
	elseif type(dropdown.values) == "table" then
		for _, v in next, dropdown.values do
			if v.value ~= nil and v.value == var or v.text == var then
				dropdownText:SetText(v.text)
				dropdown.value = v.value
				dropdown.text = v.text
			end
		end
	end
	return setmetatable(dropdown, {
		__index = dropdownPrototype
	})
end
