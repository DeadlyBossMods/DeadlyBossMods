local L = DBM_GUI_L
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

local color1 = BarSetup:CreateColorSelect(64)
local color2 = BarSetup:CreateColorSelect(64)
color1:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 30, -80)
color2:SetPoint("TOPLEFT", color1, "TOPRIGHT", 20, 0)
color1.myheight = 84
color2.myheight = 0

local color1reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1reset:SetPoint("TOP", color1, "BOTTOM", 5, -10)
color2reset:SetPoint("TOP", color2, "BOTTOM", 5, -10)
color1reset:SetScript("OnClick", function()
	color1:SetColorRGB(DBT.DefaultOptions.StartColorR, DBT.DefaultOptions.StartColorG, DBT.DefaultOptions.StartColorB)
end)
color2reset:SetScript("OnClick", function()
	color2:SetColorRGB(DBT.DefaultOptions.EndColorR, DBT.DefaultOptions.EndColorG, DBT.DefaultOptions.EndColorB)
end)

local color1text = BarSetup:CreateText(L.BarStartColor, 80)
local color2text = BarSetup:CreateText(L.BarEndColor, 80)
color1text:SetPoint("BOTTOM", color1, "TOP", 0, 4)
color2text:SetPoint("BOTTOM", color2, "TOP", 0, 4)
color1text.myheight = 0
color2text.myheight = 0
color1:SetColorRGB(DBT.Options.StartColorR, DBT.Options.StartColorG, DBT.Options.StartColorB)
color1text:SetTextColor(DBT.Options.StartColorR, DBT.Options.StartColorG, DBT.Options.StartColorB)
color2:SetColorRGB(DBT.Options.EndColorR, DBT.Options.EndColorG, DBT.Options.EndColorB)
color2text:SetTextColor(DBT.Options.EndColorR, DBT.Options.EndColorG, DBT.Options.EndColorB)
color1:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorB", select(3, self:GetColorRGB()))
	color1text:SetTextColor(self:GetColorRGB())
end)
color2:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorB", select(3, self:GetColorRGB()))
	color2text:SetTextColor(self:GetColorRGB())
end)

local maindummybar = DBT:CreateDummyBar(nil, nil, SMALL)
maindummybar.frame:SetParent(BarSetup.frame)
maindummybar.frame:SetPoint("TOP", color2text, "LEFT", 10, 60)
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

local maindummybarHuge = DBT:CreateDummyBar(nil, nil, LARGE)
maindummybarHuge.frame:SetParent(BarSetup.frame)
maindummybarHuge.frame:SetPoint("TOP", color2text, "LEFT", 10, 35)
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
StyleDropDown:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 210, -25)
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
TextureDropDown:SetPoint("TOPLEFT", StyleDropDown, "BOTTOMLEFT", 0, -10)
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
		value	= "Fonts\\skurri.ttf"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS.ttf"
	}
})

local FontDropDown = BarSetup:CreateDropdown(L.FontType, Fonts, "DBT", "Font", function(value)
	DBT:SetOption("Font", value)
end)
FontDropDown:SetPoint("TOPLEFT", TextureDropDown, "BOTTOMLEFT", 0, -10)
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

local FontFlagDropDown = BarSetup:CreateDropdown(L.FontStyle, FontFlags, "DBT", "FontFlag", function(value)
	DBT:SetOption("FontFlag", value)
end)
FontFlagDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, -10)
FontFlagDropDown.myheight = 0

local iconleft = BarSetup:CreateCheckButton(L.BarIconLeft, nil, nil, nil, "IconLeft")
iconleft:SetPoint("TOPLEFT", FontFlagDropDown, "BOTTOMLEFT", 10, 0)

local iconright = BarSetup:CreateCheckButton(L.BarIconRight, nil, nil, nil, "IconRight")
iconright:SetPoint("LEFT", iconleft, "LEFT", 130, 0)

local SparkBars = BarSetup:CreateCheckButton(L.BarSpark, false, nil, nil, "Spark")
SparkBars:SetPoint("TOPLEFT", iconleft, "BOTTOMLEFT")

local FlashBars = BarSetup:CreateCheckButton(L.BarFlash, false, nil, nil, "FlashBar")
FlashBars:SetPoint("TOPLEFT", SparkBars, "BOTTOMLEFT")

local ColorBars = BarSetup:CreateCheckButton(L.BarColorByType, false, nil, nil, "ColorByType")
ColorBars:SetPoint("TOPLEFT", FlashBars, "BOTTOMLEFT")

local InlineIcons = BarSetup:CreateCheckButton(L.BarInlineIcons, false, nil, nil, "InlineIcons")
InlineIcons:SetPoint("LEFT", ColorBars, "LEFT", 130, 0)

-- Functions for bar setup
local function createDBTOnValueChangedHandler(option)
	return function(self)
		DBT:SetOption(option, self:GetValue())
		self:SetValue(DBT.Options[option])
	end
end

local function resetDBTValueToDefault(slider, option)
	DBT:SetOption(option, DBT.DefaultOptions[option])
	slider:SetValue(DBT.Options[option])
end

local FontSizeSlider = BarSetup:CreateSlider(L.FontSize, 7, 18, 1)
FontSizeSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -180)
FontSizeSlider:SetValue(DBT.Options.FontSize)
FontSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("FontSize"))

local DisableBarFade = BarSetup:CreateCheckButton(L.NoBarFade, false, nil, nil, "NoBarFade")
DisableBarFade:SetPoint("TOPLEFT", FontSizeSlider, "BOTTOMLEFT", 0, -85)
DisableBarFade.myheight = 75 -- Extra padding because right buttons are offset from sliders

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
	BarSkin:SetPoint("TOPLEFT", DisableBarFade, "BOTTOMLEFT", -20, -10)
	BarSkin.myheight = 45
end

local Sorts = {
	{
		text	= "None",
		value	= "None"
	},
	{
		text	= "Highest at top",
		value	= "Sort"
	},
	{
		text	= "Lowest at top",
		value	= "Invert"
	}
}

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

local SortDropDown = BarSetupSmall:CreateDropdown(L.BarSort, Sorts, "DBT", "Sort", function(value)
	DBT:SetOption("Sort", value)
end)
SortDropDown:SetPoint("TOPLEFT", BarScaleSlider, "BOTTOMLEFT", -20, -25)

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
	resetDBTValueToDefault(BarWidthSlider, "Width")
	resetDBTValueToDefault(BarHeightSlider, "Height")
	resetDBTValueToDefault(BarScaleSlider, "Scale")
	resetDBTValueToDefault(BarOffsetXSlider, "BarXOffset")
	resetDBTValueToDefault(BarOffsetYSlider, "BarYOffset")
	resetDBTValueToDefault(AlphaSlider, "Alpha")
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

local SortDropDownLarge = BarSetupHuge:CreateDropdown(L.BarSort, Sorts, "DBT", "HugeSort", function(value)
	DBT:SetOption("HugeSort", value)
end)
SortDropDownLarge:SetPoint("TOPLEFT", HugeBarScaleSlider, "BOTTOMLEFT", -20, -25)

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
	resetDBTValueToDefault(HugeBarWidthSlider, "HugeWidth")
	resetDBTValueToDefault(HugeBarHeightSlider, "HugeHeight")
	resetDBTValueToDefault(HugeBarScaleSlider, "HugeScale")
	resetDBTValueToDefault(HugeBarOffsetXSlider, "HugeBarXOffset")
	resetDBTValueToDefault(HugeBarOffsetYSlider, "HugeBarYOffset")
	resetDBTValueToDefault(HugeAlphaSlider, "HugeAlpha")
end)
