local L = DBM_GUI_L
local CL = DBM_COMMON_L
local DBT = DBT

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_Appearance, "option")

local BarSetup = BarSetupPanel:CreateArea(L.AreaTitle_BarSetup)
local movemebutton = BarSetup:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", BarSetup.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function()
	DBT:ShowMovableBar()
end)

local testmebutton = BarSetup:CreateButton(L.Button_TestBars, 100, 16)
testmebutton:SetPoint("BOTTOMRIGHT", BarSetup.frame, "BOTTOMRIGHT", -2, 4)
testmebutton:SetNormalFontObject(GameFontNormalSmall)
testmebutton:SetHighlightFontObject(GameFontNormalSmall)
testmebutton:SetScript("OnClick", function()
	DBM:DemoMode()
end)

local color1 = BarSetup:CreateColorSelect(L.BarStartColor, function(_, r, g, b)
	DBT:SetOption("StartColorR", r)
	DBT:SetOption("StartColorG", g)
	DBT:SetOption("StartColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorR, DBT.DefaultOptions.StartColorG, DBT.DefaultOptions.StartColorB, true)
end)
local color2 = BarSetup:CreateColorSelect(L.BarEndColor, function(_, r, g, b)
	DBT:SetOption("EndColorR", r)
	DBT:SetOption("EndColorG", g)
	DBT:SetOption("EndColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorR, DBT.DefaultOptions.EndColorG, DBT.DefaultOptions.EndColorB, true)
end)
color1:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -80)
color2:SetPoint("TOPLEFT", color1, "TOPRIGHT", 20, 0)
color1.myheight = 130
color2.myheight = 0

color1:SetColorRGB(DBT.Options.StartColorR, DBT.Options.StartColorG, DBT.Options.StartColorB)
color2:SetColorRGB(DBT.Options.EndColorR, DBT.Options.EndColorG, DBT.Options.EndColorB)

---@class MainDummyBar: DBTBar
local maindummybar = DBT:CreateDummyBar(nil, nil, SMALL)
maindummybar.frame:SetParent(BarSetup.frame)
maindummybar.frame:SetPoint("BOTTOMLEFT", color1, "TOPLEFT", 20, 40)
maindummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	maindummybar:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = maindummybar.ApplyStyle
	function maindummybar:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
maindummybar:ApplyStyle()

---@class MainDummyBarHuge: DBTBar
local maindummybarHuge = DBT:CreateDummyBar(nil, nil, LARGE)
maindummybarHuge.frame:SetParent(BarSetup.frame)
maindummybarHuge.frame:SetPoint("BOTTOMLEFT", color1, "TOPLEFT", 20, 15)
maindummybarHuge.frame:SetScript("OnUpdate", function(_, elapsed)
	maindummybarHuge:Update(elapsed)
end)
maindummybarHuge.enlarged = true
maindummybarHuge.dummyEnlarge = true
do
	-- Little hook to prevent this bar from changing size/scale
	local old = maindummybarHuge.ApplyStyle
	function maindummybarHuge:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
maindummybarHuge:ApplyStyle()

local Styles = {
	{
		text	= L.BarDBM,
		value	= "DBM"
	},
	{
		text	= L.BarSimple,
		value	= "NoAnim"
	}
}

local StyleDropDown = BarSetup:CreateDropdown(L.BarStyle, Styles, "DBT", "BarStyle", function(value)
	DBT:SetOption("BarStyle", value)
end, 210)
local isNewDropdown = StyleDropDown.mytype == "dropdown2"
StyleDropDown:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 230, -25)
StyleDropDown.myheight = 0

local Textures = DBM_GUI:MixinSharedMedia3("statusbar", {
	{
		text	= DEFAULT,
		value	= "Interface\\AddOns\\DBM-StatusBarTimers\\textures\\default.blp"
	},
	{
		text	= "Blizzard",
		value	= "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar" -- 136570
	},
	{
		text	= "Glaze",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\glaze.blp"
	},
	{
		text	= "Otravi",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\otravi.blp"
	},
	{
		text	= "Smooth",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\smooth.blp"
	}
})

local TextureDropDown = BarSetup:CreateDropdown(L.BarTexture, Textures, "DBT", "Texture", function(value)
	DBT:SetOption("Texture", value)
end)
TextureDropDown:SetPoint("TOPLEFT", StyleDropDown, "BOTTOMLEFT", 0, isNewDropdown and -15 or -10)
TextureDropDown.myheight = 0

local Fonts = DBM_GUI:MixinSharedMedia3("font", {
	{
		text	= DEFAULT,
		value	= "standardFont"
	},
	{
		text	= "Arial",
		value	= "Fonts\\ARIALN.TTF"
	},
	{
		text	= "Skurri",
		value	= "Fonts\\SKURRI_CYR.ttf"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS_CYR.ttf"
	}
})

local FontDropDown = BarSetup:CreateDropdown(L.FontType, Fonts, "DBT", "Font", function(value)
	DBT:SetOption("Font", value)
end)
FontDropDown:SetPoint("TOPLEFT", TextureDropDown, "BOTTOMLEFT", 0, isNewDropdown and -15 or -10)
FontDropDown.myheight = 0

local FontFlags = {
	{
		text	= L.None,
		value	= "None"
	},
	{
		text	= L.Outline,
		value	= "OUTLINE",
		flag	= true
	},
	{
		text	= L.ThickOutline,
		value	= "THICKOUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeOutline,
		value	= "MONOCHROME,OUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeThickOutline,
		value	= "MONOCHROME,THICKOUTLINE",
		flag	= true
	}
}

-- Functions for bar setup
local function createDBTOnValueChangedHandler(option)
	return function(self)
		local newValue = self:GetValue()
		if newValue == DBT.Options[option] then return end
		DBT:SetOption(option, newValue)
		self:SetValue(DBT.Options[option])
	end
end

local function resetDBTValueToDefault(slider, option, noUpdate)
	DBT:SetOption(option, DBT.DefaultOptions[option], noUpdate)
	slider:SetValue(DBT.Options[option])
end

local FontSizeSlider = BarSetup:CreateSlider(L.FontSize, 7, 18, 1)
FontSizeSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -140)
FontSizeSlider:SetValue(DBT.Options.FontSize)
FontSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("FontSize"))

local FontFlagDropDown = BarSetup:CreateDropdown(L.FontStyle, FontFlags, "DBT", "FontFlag", function(value)
	DBT:SetOption("FontFlag", value)
end)
FontFlagDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, isNewDropdown and -15 or -10)
FontFlagDropDown.myheight = 0

local FontShadow = BarSetup:CreateCheckButton(L.FontShadow, false, nil, nil, "FontShadow")
FontShadow:SetPoint("LEFT", FontFlagDropDown, "RIGHT", 35, 0)

local function onIconDropdownSelected(value)
	if value == 'LEFT' then
		DBT.Options.IconLeft = not DBT.Options.IconLeft
	elseif value == 'RIGHT' then
		DBT.Options.IconRight = not DBT.Options.IconRight
	end
end
local iconPositions = {
	{ text = CL.LEFT, value = 'LEFT' },
	{ text = CL.RIGHT, value = 'RIGHT' }
}
local iconDropdown = BarSetup:CreateDropdown(L.BarIconPosition, iconPositions, nil, nil, onIconDropdownSelected, nil, nil, nil, nil, 'checkbox')
iconDropdown:IsSelectedCallback(function(_, v)
	if v.value == 'LEFT' then
		return DBT.Options.IconLeft
	elseif v.value == 'RIGHT' then
		return DBT.Options.IconRight
	end
	return false
end)
iconDropdown:SetPoint("TOPLEFT", FontFlagDropDown, "BOTTOMLEFT", 0, isNewDropdown and -15 or -10)
iconDropdown.myheight = 0
---@diagnostic disable-next-line: undefined-field
iconDropdown:GenerateMenu()

local inlineIconOptions = {
	{ text = NONE, value = 0 },
	{ text = L.SingleLargeIcon, value = 1 },
	{ text = L.DoubleLargeIcons, value = 2 },
	{ text = L.DoubleInlineIcons, value = 3 },
	{ text = L.StackedMiniIcons, value = 4 },
}
local inlineIconsDropdown = BarSetup:CreateDropdown(L.InlineIconsDropdown, inlineIconOptions, "DBT", "JournalIcons", function(value)
	DBT:SetOption("JournalIcons", value)
end)
inlineIconsDropdown:SetPoint("TOPLEFT", iconDropdown, "BOTTOMLEFT", 0, isNewDropdown and -15 or -10)
inlineIconsDropdown.myheight = 0

local SparkBars = BarSetup:CreateCheckButton(L.BarSpark, false, nil, nil, "Spark")
SparkBars:SetPoint("TOPLEFT", FontSizeSlider, "BOTTOMLEFT", isNewDropdown and 0 or 10, isNewDropdown and -20 or -15)

local FlashBars = BarSetup:CreateCheckButton(L.BarFlash, false, nil, nil, "FlashBar")
FlashBars:SetPoint("TOPLEFT", SparkBars, "BOTTOMLEFT")

local ColorBars = BarSetup:CreateCheckButton(L.BarColorByType, false, nil, nil, "ColorByType")
ColorBars:SetPoint("TOPLEFT", FlashBars, "BOTTOMLEFT")


local DisableBarFade = BarSetup:CreateCheckButton(L.NoBarFade, false, nil, nil, "NoBarFade")
DisableBarFade:SetPoint("TOPLEFT", ColorBars, "BOTTOMLEFT")
DisableBarFade.myheight = 35

local skins = {}
for id, skin in pairs(DBT:GetSkins()) do
	table.insert(skins, {
		text	= skin.name,
		value	= id
	})
end
if #skins > 1 then
	local BarSkin = BarSetup:CreateDropdown(L.BarSkin, skins, "DBT", "Skin", function(value)
		DBT:SetSkin(value)
	end, 210)
	BarSkin:SetPoint("TOPLEFT", DisableBarFade, "BOTTOMLEFT", isNewDropdown and 0 or -20, -10)
	BarSkin.myheight = 45
end

local Sorts = {
	{
		text	= L.None,
		value	= "None"
	},
	{
		text	= L.Highest,
		value	= "Sort"
	},
	{
		text	= L.Lowest,
		value	= "Invert"
	}
}

local BarSetupVariance = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupVariance)

local VarianceEnableCheckbox = BarSetupVariance:CreateCheckButton(L.EnableVarianceBar, true, nil, nil, "VarianceEnabled2")

local varcolor1 = BarSetup:CreateColorSelect(L.VarianceColor, function(_, r, g, b)
	DBT:SetOption("VarColorR", r)
	DBT:SetOption("VarColorG", g)
	DBT:SetOption("VarColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.VarColorR, DBT.DefaultOptions.VarColorG, DBT.DefaultOptions.VarColorB, true)
end)
varcolor1:SetWidth(150)
varcolor1:SetPoint("TOPLEFT", VarianceEnableCheckbox, "TOPLEFT", 200, -22)
varcolor1.myheight = 0

varcolor1:SetColorRGB(DBT.Options.VarColorR, DBT.Options.VarColorG, DBT.Options.VarColorB)

local VarianceTextureDropDown = BarSetup:CreateDropdown(L.BarTexture, Textures, "DBT", "VarianceTexture", function(value)
	DBT:SetOption("VarianceTexture", value)
end)
VarianceTextureDropDown:SetPoint("TOPLEFT", varcolor1, "BOTTOMLEFT", 0, isNewDropdown and -35 or -30)
VarianceTextureDropDown.myheight = 0

local VarianceAlphaSlider = BarSetupVariance:CreateSlider(L.VarianceTransparency, 0, 1, 0.1, 150)
VarianceAlphaSlider:SetPoint("TOPLEFT", VarianceEnableCheckbox, "BOTTOMLEFT", 5, -15)
VarianceAlphaSlider:SetValue(DBT.Options.VarianceAlpha)
VarianceAlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("VarianceAlpha"))

local VarianceBehaviors = {
	{
		text	= L.ZeroatWindowEnds,
		value	= "ZeroAtMaxTimer"
	},
	{
		text	= L.ZeroatWindowStartNeg,
		value	= "ZeroAtMinTimerAndNeg",
	},
}

local VarianceBehaviourDropDown = BarSetupVariance:CreateDropdown(L.VarianceTimerTextBehavior, VarianceBehaviors, "DBT", "VarianceBehavior", function(value)
	DBT:SetOption("VarianceBehavior", value)
end)
VarianceBehaviourDropDown:SetPoint("TOPLEFT", VarianceAlphaSlider, "BOTTOMLEFT", 0, isNewDropdown and -25 or -10)

local BarSetupSmall = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupSmall)

local smalldummybar = DBT:CreateDummyBar(nil, nil, SMALL)
smalldummybar.frame:SetParent(BarSetupSmall.frame)
smalldummybar.frame:SetPoint("BOTTOM", BarSetupSmall.frame, "TOP", 0, -35)
smalldummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	smalldummybar:Update(elapsed)
end)

local ExpandUpwards = BarSetupSmall:CreateCheckButton(L.ExpandUpwards, false, nil, nil, "ExpandUpwards")
ExpandUpwards:SetPoint("TOPLEFT", smalldummybar.frame, "BOTTOMLEFT", -50, -15)

local FillUpBars = BarSetupSmall:CreateCheckButton(L.FillUpBars, false, nil, nil, "FillUpBars")
FillUpBars:SetPoint("TOPLEFT", smalldummybar.frame, "BOTTOMLEFT", 100, -15)

local BarWidthSlider = BarSetupSmall:CreateSlider(L.Slider_BarWidth, 100, 400, 1, 310)
BarWidthSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 20, -90)
BarWidthSlider:SetValue(DBT.Options.Width)
BarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Width"))

local BarHeightSlider = BarSetupSmall:CreateSlider(L.Bar_Height, 10, 35, 1, 310)
BarHeightSlider:SetPoint("TOPLEFT", BarWidthSlider, "BOTTOMLEFT", 0, -10)
BarHeightSlider:SetValue(DBT.Options.Height)
BarHeightSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Height"))

local BarScaleSlider = BarSetupSmall:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05, 310)
BarScaleSlider:SetPoint("TOPLEFT", BarHeightSlider, "BOTTOMLEFT", 0, -10)
BarScaleSlider:SetValue(DBT.Options.Scale)
BarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Scale"))

local saturateSlider = BarSetup:CreateSlider(L.BarSaturation, 0, 1, 0.05, 455)
saturateSlider:SetPoint("TOPLEFT", BarScaleSlider, "BOTTOMLEFT", 0, -20)
saturateSlider:SetValue(DBT.Options.DesaturateValue)
saturateSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("DesaturateValue"))
saturateSlider.myheight = 55

local BackgroundColorSmall = BarSetupSmall:CreateColorSelect(L.BarBackgroundColor, function(_, r, g, b)
	DBT:SetOption("BackgroundColorR", r, true)
	DBT:SetOption("BackgroundColorG", g, true)
	DBT:SetOption("BackgroundColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.BackgroundColorR, DBT.DefaultOptions.BackgroundColorG, DBT.DefaultOptions.BackgroundColorB, true)
end)
BackgroundColorSmall:SetPoint("TOPLEFT", saturateSlider, "BOTTOMLEFT", isNewDropdown and 0 or 20, -25)
BackgroundColorSmall:SetColorRGB(DBT.Options.BackgroundColorR, DBT.Options.BackgroundColorG, DBT.Options.BackgroundColorB)
BackgroundColorSmall.myheight = 60

local BackgroundAlphaSlider = BarSetupSmall:CreateSlider(L.BarBackgroundOpacity, 0, 1, 0.05, 170)
BackgroundAlphaSlider:SetPoint("TOPLEFT", BackgroundColorSmall, "TOPRIGHT", 40, -15)
BackgroundAlphaSlider:SetValue(DBT.Options.BackgroundAlpha)
BackgroundAlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BackgroundAlpha"))
BackgroundAlphaSlider.myheight = 0

local BorderEnabledCheckbox = BarSetupSmall:CreateCheckButton(L.EnableBarBorder, false, nil, nil, "BorderEnabled")
BorderEnabledCheckbox:SetPoint("TOPLEFT", BackgroundColorSmall, "BOTTOMLEFT", 0, -30)
BorderEnabledCheckbox.myheight = 30

local BorderColorSmall = BarSetupSmall:CreateColorSelect(L.BarBorderColor, function(_, r, g, b)
	DBT:SetOption("BorderColorR", r, true)
	DBT:SetOption("BorderColorG", g, true)
	DBT:SetOption("BorderColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.BorderColorR, DBT.DefaultOptions.BorderColorG, DBT.DefaultOptions.BorderColorB, true)
end)
BorderColorSmall:SetPoint("TOPLEFT", BorderEnabledCheckbox, "BOTTOMLEFT", 0, 0)
BorderColorSmall:SetColorRGB(DBT.Options.BorderColorR, DBT.Options.BorderColorG, DBT.Options.BorderColorB)
BorderColorSmall.myheight = 60

local BorderSizeSlider = BarSetupSmall:CreateSlider(L.BarBorderSize, 0.1, 3, 0.1, 170)
BorderSizeSlider:SetPoint("TOPLEFT", BorderColorSmall, "TOPRIGHT", 40, -15)
--color2Type1:SetPoint("TOPLEFT", color1Type1, "TOPRIGHT", 10, 0)
BorderSizeSlider:SetValue(DBT.Options.BorderSize)
BorderSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BorderSize"))
BorderSizeSlider.myheight = 0

local TextOffsetXSlider = BarSetupSmall:CreateSlider(L.Slider_TextOffSetX, -50, 50, 1, 120)
TextOffsetXSlider:SetPoint("TOPLEFT", BorderColorSmall, "BOTTOMLEFT", 0, -50)
TextOffsetXSlider:SetValue(DBT.Options.TextXOffset)
TextOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("TextXOffset"))
TextOffsetXSlider.myheight = 50

local TextOffsetYSlider = BarSetupSmall:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 120)
TextOffsetYSlider:SetPoint("TOPLEFT", TextOffsetXSlider, "TOPRIGHT", 40, 0)
TextOffsetYSlider:SetValue(DBT.Options.TextYOffset)
TextOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("TextYOffset"))
TextOffsetYSlider.myheight = 0

local SortDropDown = BarSetupSmall:CreateDropdown(L.BarSort, Sorts, "DBT", "Sort", function(value)
	DBT:SetOption("Sort", value)
end)
SortDropDown:SetPoint("TOPLEFT", TextOffsetXSlider, "BOTTOMLEFT", 0, -40)
SortDropDown.myheight = 85

local BarOffsetXSlider = BarSetupSmall:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1, 120)
BarOffsetXSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 350, -90)
BarOffsetXSlider:SetValue(DBT.Options.BarXOffset)
BarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarXOffset"))
BarOffsetXSlider.myheight = 0

local BarOffsetYSlider = BarSetupSmall:CreateSlider(L.Slider_BarOffSetY, -5, 35, 1, 120)
BarOffsetYSlider:SetPoint("TOPLEFT", BarOffsetXSlider, "BOTTOMLEFT", 0, -10)
BarOffsetYSlider:SetValue(DBT.Options.BarYOffset)
BarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarYOffset"))
BarOffsetYSlider.myheight = 0

local AlphaSlider = BarSetupSmall:CreateSlider(L.Bar_Alpha, 0, 1, 0.1, 120)
AlphaSlider:SetPoint("TOPLEFT", BarOffsetYSlider, "BOTTOMLEFT", 0, -10)
AlphaSlider:SetValue(DBT.Options.Alpha)
AlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Alpha"))
AlphaSlider.myheight = 0

local barResetbutton = BarSetupSmall:CreateButton(L.SpecWarn_ResetMe, 120, 16)
barResetbutton:SetPoint("BOTTOMRIGHT", BarSetupSmall.frame, "BOTTOMRIGHT", -2, 4)
barResetbutton:SetNormalFontObject(GameFontNormalSmall)
barResetbutton:SetHighlightFontObject(GameFontNormalSmall)
barResetbutton:SetScript("OnClick", function()
	resetDBTValueToDefault(BarWidthSlider, "Width", true)
	resetDBTValueToDefault(BarHeightSlider, "Height", true)
	resetDBTValueToDefault(BarScaleSlider, "Scale", true)
	resetDBTValueToDefault(BarOffsetXSlider, "BarXOffset", true)
	resetDBTValueToDefault(BarOffsetYSlider, "BarYOffset", true)
	resetDBTValueToDefault(TextOffsetXSlider, "TextXOffset", true)
	resetDBTValueToDefault(TextOffsetYSlider, "TextYOffset", true)
	resetDBTValueToDefault(AlphaSlider, "Alpha", true)
	resetDBTValueToDefault(BackgroundAlphaSlider, "BackgroundAlpha", true)
	resetDBTValueToDefault(BorderSizeSlider, "BorderSize", true)
	DBT:SetOption("BackgroundColorR", DBT.DefaultOptions.BackgroundColorR, true)
	DBT:SetOption("BackgroundColorG", DBT.DefaultOptions.BackgroundColorG, true)
	DBT:SetOption("BackgroundColorB", DBT.DefaultOptions.BackgroundColorB, true)
	BackgroundColorSmall:SetColorRGB(DBT.Options.BackgroundColorR, DBT.Options.BackgroundColorG, DBT.Options.BackgroundColorB)
	DBT:SetOption("BorderColorR", DBT.DefaultOptions.BorderColorR, true)
	DBT:SetOption("BorderColorG", DBT.DefaultOptions.BorderColorG, true)
	DBT:SetOption("BorderColorB", DBT.DefaultOptions.BorderColorB, true)
	BorderColorSmall:SetColorRGB(DBT.Options.BorderColorR, DBT.Options.BorderColorG, DBT.Options.BorderColorB)
	DBT:SetOption("BorderEnabled", DBT.DefaultOptions.BorderEnabled, true)
	BorderEnabledCheckbox:SetChecked(DBT.Options.BorderEnabled)
	DBT:UpdateBars(true)
	DBT:ApplyStyle()
end)

local BarSetupHuge = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupHuge)

BarSetupHuge:CreateCheckButton(L.EnableHugeBar, true, nil, nil, "HugeBarsEnabled")

local hugedummybar = DBT:CreateDummyBar(nil, nil, LARGE)
hugedummybar.frame:SetParent(BarSetupHuge.frame)
hugedummybar.frame:SetPoint("BOTTOM", BarSetupHuge.frame, "TOP", 0, -50)
hugedummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	hugedummybar:Update(elapsed)
end)
hugedummybar.enlarged = true
hugedummybar.dummyEnlarge = true
hugedummybar:ApplyStyle()

local ExpandUpwardsLarge = BarSetupHuge:CreateCheckButton(L.ExpandUpwards, false, nil, nil, "ExpandUpwardsLarge")
ExpandUpwardsLarge:SetPoint("TOPLEFT", hugedummybar.frame, "BOTTOMLEFT", -50, -15)

local FillUpBarsLarge = BarSetupHuge:CreateCheckButton(L.FillUpBars, false, nil, nil, "FillUpLargeBars")
FillUpBarsLarge:SetPoint("TOPLEFT", hugedummybar.frame, "BOTTOMLEFT", 100, -15)

local HugeBarWidthSlider = BarSetupHuge:CreateSlider(L.Slider_BarWidth, 100, 400, 1, 310)
HugeBarWidthSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 20, -105)
HugeBarWidthSlider:SetValue(DBT.Options.HugeWidth)
HugeBarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeWidth"))

local HugeBarHeightSlider = BarSetupHuge:CreateSlider(L.Bar_Height, 10, 35, 1, 310)
HugeBarHeightSlider:SetPoint("TOPLEFT", HugeBarWidthSlider, "BOTTOMLEFT", 0, -10)
HugeBarHeightSlider:SetValue(DBT.Options.HugeHeight)
HugeBarHeightSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeHeight"))

local HugeBarScaleSlider = BarSetupHuge:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05, 310)
HugeBarScaleSlider:SetPoint("TOPLEFT", HugeBarHeightSlider, "BOTTOMLEFT", 0, -10)
HugeBarScaleSlider:SetValue(DBT.Options.HugeScale)
HugeBarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeScale"))

local HugeBackgroundColorLarge = BarSetupHuge:CreateColorSelect(L.BarBackgroundColor, function(_, r, g, b)
	DBT:SetOption("HugeBackgroundColorR", r, true)
	DBT:SetOption("HugeBackgroundColorG", g, true)
	DBT:SetOption("HugeBackgroundColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.HugeBackgroundColorR, DBT.DefaultOptions.HugeBackgroundColorG, DBT.DefaultOptions.HugeBackgroundColorB, true)
end)
HugeBackgroundColorLarge:SetPoint("TOPLEFT", HugeBarScaleSlider, "BOTTOMLEFT", isNewDropdown and 0 or 20, -25)
HugeBackgroundColorLarge:SetColorRGB(DBT.Options.HugeBackgroundColorR, DBT.Options.HugeBackgroundColorG, DBT.Options.HugeBackgroundColorB)
HugeBackgroundColorLarge.myheight = 60

local HugeBackgroundAlphaSlider = BarSetupHuge:CreateSlider(L.BarBackgroundOpacity, 0, 1, 0.05, 170)
HugeBackgroundAlphaSlider:SetPoint("TOPLEFT", HugeBackgroundColorLarge, "TOPRIGHT", 40, -15)
HugeBackgroundAlphaSlider:SetValue(DBT.Options.HugeBackgroundAlpha)
HugeBackgroundAlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBackgroundAlpha"))
HugeBackgroundAlphaSlider.myheight = 0

local HugeBorderEnabledCheckbox = BarSetupHuge:CreateCheckButton(L.EnableBarBorder, false, nil, nil, "HugeBorderEnabled")
HugeBorderEnabledCheckbox:SetPoint("TOPLEFT", HugeBackgroundColorLarge, "BOTTOMLEFT", 0, -30)
HugeBorderEnabledCheckbox.myheight = 30

local HugeBorderColorLarge = BarSetupHuge:CreateColorSelect(L.BarBorderColor, function(_, r, g, b)
	DBT:SetOption("HugeBorderColorR", r, true)
	DBT:SetOption("HugeBorderColorG", g, true)
	DBT:SetOption("HugeBorderColorB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.HugeBorderColorR, DBT.DefaultOptions.HugeBorderColorG, DBT.DefaultOptions.HugeBorderColorB, true)
end)
HugeBorderColorLarge:SetPoint("TOPLEFT", HugeBorderEnabledCheckbox, "BOTTOMLEFT", 0, 0)
HugeBorderColorLarge:SetColorRGB(DBT.Options.HugeBorderColorR, DBT.Options.HugeBorderColorG, DBT.Options.HugeBorderColorB)
HugeBorderColorLarge.myheight = 60

local HugeBorderSizeSlider = BarSetupHuge:CreateSlider(L.BarBorderSize, 0.1, 3, 0.1, 170)
HugeBorderSizeSlider:SetPoint("TOPLEFT", HugeBorderColorLarge, "TOPRIGHT", 40, -15)
HugeBorderSizeSlider:SetValue(DBT.Options.HugeBorderSize)
HugeBorderSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBorderSize"))
HugeBorderSizeSlider.myheight = 0

local HugeTextOffsetXSlider = BarSetupHuge:CreateSlider(L.Slider_TextOffSetX, -50, 50, 1, 120)
HugeTextOffsetXSlider:SetPoint("TOPLEFT", HugeBorderColorLarge, "BOTTOMLEFT", 0, -50)
HugeTextOffsetXSlider:SetValue(DBT.Options.HugeTextXOffset)
HugeTextOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeTextXOffset"))
HugeTextOffsetXSlider.myheight = 50

local HugeTextOffsetYSlider = BarSetupHuge:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 120)
HugeTextOffsetYSlider:SetPoint("TOPLEFT", HugeTextOffsetXSlider, "TOPRIGHT", 40, 0)
HugeTextOffsetYSlider:SetValue(DBT.Options.HugeTextYOffset)
HugeTextOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeTextYOffset"))
HugeTextOffsetYSlider.myheight = 0

local SortDropDownLarge = BarSetupHuge:CreateDropdown(L.BarSort, Sorts, "DBT", "HugeSort", function(value)
	DBT:SetOption("HugeSort", value)
end)
SortDropDownLarge:SetPoint("TOPLEFT", HugeTextOffsetXSlider, "BOTTOMLEFT", 0, -40)
SortDropDownLarge.myheight = 30

local HugeBarOffsetXSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1, 120)
HugeBarOffsetXSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 350, -105)
HugeBarOffsetXSlider:SetValue(DBT.Options.HugeBarXOffset)
HugeBarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarXOffset"))
HugeBarOffsetXSlider.myheight = 0

local HugeBarOffsetYSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetY, -5, 35, 1, 120)
HugeBarOffsetYSlider:SetPoint("TOPLEFT", HugeBarOffsetXSlider, "BOTTOMLEFT", 0, -10)
HugeBarOffsetYSlider:SetValue(DBT.Options.HugeBarYOffset)
HugeBarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarYOffset"))
HugeBarOffsetYSlider.myheight = 0

local HugeAlphaSlider = BarSetupHuge:CreateSlider(L.Bar_Alpha, 0.1, 1, 0.1, 120)
HugeAlphaSlider:SetPoint("TOPLEFT", HugeBarOffsetYSlider, "BOTTOMLEFT", 0, -10)
HugeAlphaSlider:SetValue(DBT.Options.HugeAlpha)
HugeAlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeAlpha"))
HugeAlphaSlider.myheight = 0

local hugeBarResetbutton = BarSetupHuge:CreateButton(L.SpecWarn_ResetMe, 120, 16)
hugeBarResetbutton:SetPoint("BOTTOMRIGHT", BarSetupHuge.frame, "BOTTOMRIGHT", -2, 4)
hugeBarResetbutton:SetNormalFontObject(GameFontNormalSmall)
hugeBarResetbutton:SetHighlightFontObject(GameFontNormalSmall)
hugeBarResetbutton:SetScript("OnClick", function()
	resetDBTValueToDefault(HugeBarWidthSlider, "HugeWidth", true)
	resetDBTValueToDefault(HugeBarHeightSlider, "HugeHeight", true)
	resetDBTValueToDefault(HugeBarScaleSlider, "HugeScale", true)
	resetDBTValueToDefault(HugeBarOffsetXSlider, "HugeBarXOffset", true)
	resetDBTValueToDefault(HugeBarOffsetYSlider, "HugeBarYOffset", true)
	resetDBTValueToDefault(HugeTextOffsetXSlider, "HugeTextXOffset", true)
	resetDBTValueToDefault(HugeTextOffsetYSlider, "HugeTextYOffset", true)
	resetDBTValueToDefault(HugeAlphaSlider, "HugeAlpha", true)
	resetDBTValueToDefault(HugeBackgroundAlphaSlider, "HugeBackgroundAlpha", true)
	resetDBTValueToDefault(HugeBorderSizeSlider, "HugeBorderSize", true)
	DBT:SetOption("HugeBackgroundColorR", DBT.DefaultOptions.HugeBackgroundColorR, true)
	DBT:SetOption("HugeBackgroundColorG", DBT.DefaultOptions.HugeBackgroundColorG, true)
	DBT:SetOption("HugeBackgroundColorB", DBT.DefaultOptions.HugeBackgroundColorB, true)
	HugeBackgroundColorLarge:SetColorRGB(DBT.Options.HugeBackgroundColorR, DBT.Options.HugeBackgroundColorG, DBT.Options.HugeBackgroundColorB)
	DBT:SetOption("HugeBorderColorR", DBT.DefaultOptions.HugeBorderColorR, true)
	DBT:SetOption("HugeBorderColorG", DBT.DefaultOptions.HugeBorderColorG, true)
	DBT:SetOption("HugeBorderColorB", DBT.DefaultOptions.HugeBorderColorB, true)
	HugeBorderColorLarge:SetColorRGB(DBT.Options.HugeBorderColorR, DBT.Options.HugeBorderColorG, DBT.Options.HugeBorderColorB)
	DBT:SetOption("HugeBorderEnabled", DBT.DefaultOptions.HugeBorderEnabled, true)
	HugeBorderEnabledCheckbox:SetChecked(DBT.Options.HugeBorderEnabled)
	DBT:UpdateBars(true)
	DBT:ApplyStyle()
end)
