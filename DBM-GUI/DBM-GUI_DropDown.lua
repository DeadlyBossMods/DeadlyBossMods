local L = DBM_GUI_L

local pairs, next, type, ipairs, setmetatable, mfloor, mmax = pairs, next, type, ipairs, setmetatable, math.floor, math.max
local CreateFrame, GameFontNormalSmall = CreateFrame, GameFontNormalSmall
local DBM = DBM

local defaultFont, defaultFontSize = GameFontHighlightSmall:GetFont()

local hack = OptionsList_OnLoad
function OptionsList_OnLoad(self, ...)
	if self:GetName() ~= "DBM_GUI_DropDown" then
		hack(self, ...)
	end
end

local tabFrame1 = CreateFrame("Frame", "DBM_GUI_DropDown", _G["DBM_GUI_OptionsFrame"], DBM:IsShadowlands() and "BackdropTemplate,OptionsFrameListTemplate" or "OptionsFrameListTemplate")
tabFrame1:Hide()
tabFrame1:SetFrameStrata("TOOLTIP")
tabFrame1.offset = 0
tabFrame1.backdropInfo = {
	bgFile		= "Interface\\ChatFrame\\ChatFrameBackground", -- 130937
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 16,
	insets		= { left = 3, right = 3, top = 5, bottom = 3 }
}
if not DBM:IsShadowlands() then
	tabFrame1:SetBackdrop(tabFrame1.backdropInfo)
else
	tabFrame1:ApplyBackdrop()
end
tabFrame1:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
tabFrame1:SetBackdropBorderColor(0.4, 0.4, 0.4)

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
if DBM:IsShadowlands() then
	Mixin(tabFrame1List, BackdropTemplateMixin)
end
tabFrame1List:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)

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
	local button = CreateFrame("Button", tabFrame1:GetName() .. "Button" .. i, tabFrame1, DBM:IsShadowlands() and "BackdropTemplate,UIDropDownMenuButtonTemplate" or "UIDropDownMenuButtonTemplate")
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
		_G[self:GetParent().dropdown:GetName() .. "Text"]:SetText(self.entry.text)
	end)
	function button:Reset()
		_G[self:GetName() .. "NormalText"]:SetFont(defaultFont, defaultFontSize)
		self:SetHeight(0)
		self:SetText("")
		if DBM:IsShadowlands() then
			self:ClearBackdrop()
		else
			self:SetBackdrop(nil)
		end
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
				if DBM:IsShadowlands() then
					button:ApplyBackdrop()
				else
					button:SetBackdrop(button.backdropInfo)
				end
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
	self:SetWidth(bwidth + 16)
	ClickFrame:Show()
end

local dropdownPrototype = CreateFrame("Frame")

function dropdownPrototype:SetSelectedValue(selected)
	if selected and self.values and type(self.values) == "table" then
		local text = _G[self:GetName() .. "Text"]
		for _, v in next, self.values do
			if v.value ~= nil and v.value == selected or v.text == selected then
				text:SetText(v.text)
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
	dropdownButton:SetScript("OnMouseDown", nil)
	dropdownButton:SetScript("OnClick", function(self)
		DBM:PlaySound(856)
		if tabFrame1:IsShown() then
			tabFrame1:Hide()
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
			dropdown:SetSelectedValue(DBT.Options[var])
		end)
	elseif vartype then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(vartype.Options[var])
		end)
	else -- For external modules like DBM-RaidLeadTools
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
