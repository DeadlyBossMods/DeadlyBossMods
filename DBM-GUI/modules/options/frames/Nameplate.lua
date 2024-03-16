local L = DBM_GUI_L
local CL = DBM_COMMON_L
local panel = DBM_GUI.Cat_Frames:CreateNewPanel(L.Panel_Nameplates, "option")

local general = panel:CreateArea(L.Area_General)

general:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
general:CreateCheckButton(L.SpamBlockNoNameplateCD, true, nil, "DontShowNameplateIconsCD")
general:CreateCheckButton(L.SpamBlockNoBossGUIDs, true, nil, "DontSendBossGUIDs")

local style = panel:CreateArea(L.Area_Style)

local auraSizeSlider = style:CreateSlider(L.NPAuraSize, 20, 80, 1, 200)
auraSizeSlider:SetPoint("TOPLEFT", style.frame, "TOPLEFT", 20, -25)
auraSizeSlider:SetValue(DBM.Options.NPIconSize)
auraSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconSize = self:GetValue()
end)

local iconOffsetXSlider = style:CreateSlider(L.NPIcon_BarOffSetX, -50, 50, 1, 200)
iconOffsetXSlider:SetPoint("TOPLEFT", auraSizeSlider, "BOTTOMLEFT", 0, -10)
iconOffsetXSlider:SetValue(DBM.Options.NPIconXOffset)
iconOffsetXSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconXOffset = self:GetValue()
end)
iconOffsetXSlider.myheight = 0

local iconOffsetYSlider = style:CreateSlider(L.NPIcon_BarOffSetY, -50, 50, 1, 200)
iconOffsetYSlider:SetPoint("TOPLEFT", iconOffsetXSlider, "BOTTOMLEFT", 0, -10)
iconOffsetYSlider:SetValue(DBM.Options.NPIconYOffset)
iconOffsetYSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconYOffset = self:GetValue()
end)
iconOffsetYSlider.myheight = 0

local iconSpacingSlider = style:CreateSlider(L.NPIcon_Spacing, -50, 50, 1, 200)
iconSpacingSlider:SetPoint("TOPLEFT", iconOffsetYSlider, "BOTTOMLEFT", 0, -10)
iconSpacingSlider:SetValue(DBM.Options.NPIconSpacing)
iconSpacingSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconSpacing = self:GetValue()
end)
iconSpacingSlider.myheight = 0

local dirs = {
	{
		text	= CL.UP,
		value	= "UP",
	},
	{
		text	= CL.DOWN,
		value	= "DOWN",
	},
	{
		text	= CL.LEFT,
		value	= "LEFT",
	},
	{
		text	= CL.RIGHT,
		value	= "RIGHT",
	},
	{
		text	= CL.CENTER .. " (" .. CL.HORIZONTAL .. ")",
		value	= "CENTER",
	},
	{
		text	= CL.CENTER .. " (" .. CL.VERTICAL .. ")",
		value	= "CENTER_VERTICAL",
	},
}

local iconGrowthDirection = style:CreateDropdown(L.NPIcon_GrowthDirection, dirs, "DBM", "NPIconGrowthDirection", function(value)
	DBM.Options.NPIconGrowthDirection = value
end)
iconGrowthDirection:SetPoint("TOPLEFT", iconSpacingSlider, "BOTTOMLEFT", -20, -35)
iconGrowthDirection.myheight = 0

local anchors = {
	{
		text	= CL.TOP,
		value	= "TOP",
	},
	{
		text	= CL.BOTTOM,
		value	= "BOTTOM",
	},
	{
		text	= CL.LEFT,
		value	= "LEFT",
	},
	{
		text	= CL.RIGHT,
		value	= "RIGHT",
	},
	{
		text	= CL.CENTER,
		value	= "CENTER",
	},
}

local iconAnchorPoint = style:CreateDropdown(L.NPIconAnchorPoint, anchors, "DBM", "NPIconAnchorPoint", function(value)
	DBM.Options.NPIconAnchorPoint = value
end)
iconAnchorPoint:SetPoint("LEFT", iconGrowthDirection, "RIGHT", 115, 0)
iconAnchorPoint.myheight = 0

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

local FontDropDownTimer = style:CreateDropdown(L.FontTypeTimer, Fonts, "DBM", "NPIconTimerFont", function(value)
	DBM.Options.NPIconTimerFont = value
end)
FontDropDownTimer:SetPoint("TOPLEFT", iconGrowthDirection, "TOPLEFT", 0, -70)
FontDropDownTimer.myheight = 0

local FontStyles = {
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

local TimerFontStyleDropDown = style:CreateDropdown(L.FontStyle, FontStyles, "DBM", "NPIconTimerFontStyle", function(value)
	DBM.Options.NPIconTimerFontStyle = value
end)
TimerFontStyleDropDown:SetPoint("LEFT", FontDropDownTimer, "RIGHT", 25, 0)
TimerFontStyleDropDown.myheight = 0

local timerFontSizeSlider = style:CreateSlider(L.FontSize, 8, 60, 1, 150)
timerFontSizeSlider:SetPoint("TOPLEFT", FontDropDownTimer, "TOPLEFT", 20, -40)
timerFontSizeSlider:SetValue(DBM.Options.NPIconTimerFontSize)
timerFontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTimerFontSize = self:GetValue()
end)
timerFontSizeSlider.myheight = 0

local timerEnable = style:CreateCheckButton(L.Enable, true, nil, "NPIconTimerEnabled")
timerEnable:SetPoint("TOPLEFT", TimerFontStyleDropDown, "TOPLEFT", 20, -35)

local FontDropDownText = style:CreateDropdown(L.FontTypeText, Fonts, "DBM", "NPIconTextFont", function(value)
	DBM.Options.NPIconTextFont = value
end)
FontDropDownText:SetPoint("TOPLEFT", timerFontSizeSlider, "TOPLEFT", -20, -70)
FontDropDownText.myheight = 0

local TextFontStyleDropDown = style:CreateDropdown(L.FontStyle, FontStyles, "DBM", "NPIconTextFontStyle", function(value)
	DBM.Options.NPIconTextFontStyle = value
end)
TextFontStyleDropDown:SetPoint("LEFT", FontDropDownText, "RIGHT", 25, 0)
TextFontStyleDropDown.myheight = 0

local textFontSizeSlider = style:CreateSlider(L.FontSize, 8, 60, 1, 150)
textFontSizeSlider:SetPoint("TOPLEFT", FontDropDownText, "TOPLEFT", 20, -40)
textFontSizeSlider:SetValue(DBM.Options.NPIconTextFontSize)
textFontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTextFontSize = self:GetValue()
end)
textFontSizeSlider.myheight = 0

local textEnable = style:CreateCheckButton(L.Enable, true, nil, "NPIconTextEnabled")
textEnable:SetPoint("TOPLEFT", TextFontStyleDropDown, "TOPLEFT", 20, -35)
textEnable.myheight = 380

local iconTextMaxLenSlider = style:CreateSlider(L.NPIcon_MaxTextLen, 3, 25, 1, 150)
iconTextMaxLenSlider:SetPoint("TOPLEFT", textFontSizeSlider, "BOTTOMLEFT", 0, -20)
iconTextMaxLenSlider:SetValue(DBM.Options.NPIconTextMaxLen)
iconTextMaxLenSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTextMaxLen = self:GetValue()
end)
iconTextMaxLenSlider.myheight = 0

local testbutton = style:CreateButton(L.NPDemo, 100, 16)
testbutton:SetPoint("TOPRIGHT", style.frame, "TOPRIGHT", -2, -4)
testbutton:SetNormalFontObject(GameFontNormalSmall)
testbutton:SetHighlightFontObject(GameFontNormalSmall)
testbutton:SetScript("OnClick", function()
	DBM:DemoMode()
end)
testbutton.myheight = 0

local resetbutton = style:CreateButton(L.SpecWarn_ResetMe, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", style.frame, "BOTTOMRIGHT", -2, 4)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.NPIconSize = DBM.DefaultOptions.NPIconSize
	DBM.Options.NPIconXOffset = DBM.DefaultOptions.NPIconXOffset
	DBM.Options.NPIconYOffset = DBM.DefaultOptions.NPIconYOffset
	DBM.Options.NPIconSpacing = DBM.DefaultOptions.NPIconSpacing
	DBM.Options.NPIconGrowthDirection = DBM.DefaultOptions.NPIconGrowthDirection
	DBM.Options.NPIconAnchorPoint = DBM.DefaultOptions.NPIconAnchorPoint
	DBM.Options.NPIconTimerFont = DBM.DefaultOptions.NPIconTimerFont
	DBM.Options.NPIconTimerFontStyle = DBM.DefaultOptions.NPIconTimerFontStyle
	DBM.Options.NPIconTimerFontSize = DBM.DefaultOptions.NPIconTimerFontSize
	DBM.Options.NPIconTimerEnabled = DBM.DefaultOptions.NPIconTimerEnabled
	DBM.Options.NPIconTextFont = DBM.DefaultOptions.NPIconTextFont
	DBM.Options.NPIconTextFontStyle = DBM.DefaultOptions.NPIconTextFontStyle
	DBM.Options.NPIconTextFontSize = DBM.DefaultOptions.NPIconTextFontSize
	DBM.Options.NPIconTextEnabled = DBM.DefaultOptions.NPIconTextEnabled
	DBM.Options.NPIconTextMaxLen = DBM.DefaultOptions.NPIconTextMaxLen
	-- Set UI visuals
	auraSizeSlider:SetValue(DBM.DefaultOptions.NPIconSize)
	iconOffsetXSlider:SetValue(DBM.DefaultOptions.NPIconXOffset)
	iconOffsetYSlider:SetValue(DBM.DefaultOptions.NPIconYOffset)
	iconSpacingSlider:SetValue(DBM.DefaultOptions.NPIconSpacing)
	iconGrowthDirection:SetSelectedValue(DBM.DefaultOptions.NPIconGrowthDirection)
	iconAnchorPoint:SetSelectedValue(DBM.DefaultOptions.NPIconAnchorPoint)
	FontDropDownTimer:SetSelectedValue(DBM.DefaultOptions.NPIconTimerFont)
	TimerFontStyleDropDown:SetSelectedValue(DBM.DefaultOptions.NPIconTimerFontStyle)
	timerFontSizeSlider:SetValue(DBM.DefaultOptions.NPIconTimerFontSize)
	timerEnable:SetChecked(DBM.DefaultOptions.NPIconTimerEnabled)
	FontDropDownText:SetSelectedValue(DBM.DefaultOptions.NPIconTextFont)
	TextFontStyleDropDown:SetSelectedValue(DBM.DefaultOptions.NPIconTextFontStyle)
	textFontSizeSlider:SetValue(DBM.DefaultOptions.NPIconTextFontSize)
	textEnable:SetChecked(DBM.DefaultOptions.NPIconTextEnabled)
	iconTextMaxLenSlider:SetValue(DBM.DefaultOptions.NPIconTextMaxLen)
end)
resetbutton.myheight = 0
