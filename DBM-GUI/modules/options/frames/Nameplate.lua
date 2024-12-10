local L = DBM_GUI_L
local CL = DBM_COMMON_L
local panel = DBM_GUI.Cat_Frames:CreateNewPanel(L.Panel_Nameplates, "option")

local general = panel:CreateArea(L.Area_General)

local testbutton = general:CreateButton(L.NPDemo, 100, 16)
testbutton:SetPoint("TOPRIGHT", general.frame, "TOPRIGHT", -2, 14)
testbutton:SetNormalFontObject(GameFontNormalSmall)
testbutton:SetHighlightFontObject(GameFontNormalSmall)
testbutton:SetScript("OnClick", function()
	DBM:DemoMode()
end)
testbutton.myheight = 0

--When using plater, most options are configured in plater
--so we generate a button to open plater options instead of showing a bunch of options that are ignored
local Plater = _G["Plater"]
if Plater then--Plater button disabled for now
	general:CreateCheckButton(L.SpamBlockNoBossGUIDs, true, nil, "DontSendBossGUIDs")--Only option we control that plater doesn't
	general:CreateCheckButton(L.AlwaysKeepNPs, true, nil, "AlwaysKeepNPs")

	local platerButton = general:CreateButton(L.Plater_Config, 100, 25)
	platerButton:SetPoint("CENTER", general.frame, "CENTER", 0, -20)
	platerButton:SetNormalFontObject(GameFontNormal)
	platerButton:SetHighlightFontObject(GameFontNormal)
	platerButton:SetScript("OnClick", function()
		Plater.OpenOptionsPanel(28)--Open Plater boss mod options
		local optionsFrame = _G["DBM_GUI_OptionsFrame"]
		optionsFrame:Hide()--Close DBM GUI (cause it has higher strata than plater
	end)
	platerButton.myheight = 25
	return--we return here, so no other categories are generated either
else
	general:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
	general:CreateCheckButton(L.SpamBlockNoNameplateCD, true, nil, "DontShowNameplateIconsCD")
	general:CreateCheckButton(L.SpamBlockNoNameplateCasts, true, nil, "DontShowNameplateIconsCast")
	general:CreateCheckButton(L.SpamBlockNoBossGUIDs, true, nil, "DontSendBossGUIDs")
	general:CreateCheckButton(L.AlwaysKeepNPs, true, nil, "AlwaysKeepNPs")
end



local style = panel:CreateArea(L.Area_NPStyle)

local auraSizeSlider = style:CreateSlider(L.NPAuraSize, 20, 80, 1, 200)
auraSizeSlider:SetPoint("TOPLEFT", style.frame, "TOPLEFT", 20, -25)
auraSizeSlider:SetValue(DBM.Options.NPIconSize)
auraSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconSize = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local iconOffsetXSlider = style:CreateSlider(L.NPIcon_BarOffSetX, -50, 50, 1, 200)
iconOffsetXSlider:SetPoint("TOPLEFT", auraSizeSlider, "BOTTOMLEFT", 0, -20)
iconOffsetXSlider:SetValue(DBM.Options.NPIconOffsetX)
iconOffsetXSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconOffsetX = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local iconOffsetYSlider = style:CreateSlider(L.NPIcon_BarOffSetY, -50, 50, 1, 200)
iconOffsetYSlider:SetPoint("TOPLEFT", iconOffsetXSlider, "BOTTOMLEFT", 0, -20)
iconOffsetYSlider:SetValue(DBM.Options.NPIconOffsetY)
iconOffsetYSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconOffsetY = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local iconSpacingSlider = style:CreateSlider(L.NPIcon_Spacing, -50, 50, 1, 200)
iconSpacingSlider:SetPoint("TOPLEFT", iconOffsetYSlider, "BOTTOMLEFT", 0, -20)
iconSpacingSlider:SetValue(DBM.Options.NPIconSpacing)
iconSpacingSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconSpacing = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

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
	DBM.Nameplate:UpdateIconOptions()
end)
iconGrowthDirection:SetPoint("TOPLEFT", iconSpacingSlider, "BOTTOMLEFT", -20, -35)

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
	DBM.Nameplate:UpdateIconOptions()
end)
iconAnchorPoint:SetPoint("LEFT", iconGrowthDirection, "RIGHT", 110, 0)
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
	DBM.Nameplate:UpdateIconOptions()
end)
FontDropDownTimer:SetPoint("TOPLEFT", iconGrowthDirection, "TOPLEFT", 0, -50)

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
	DBM.Nameplate:UpdateIconOptions()
end)
TimerFontStyleDropDown:SetPoint("LEFT", FontDropDownTimer, "RIGHT", 25, 0)
TimerFontStyleDropDown.myheight = 0

local timerFontSizeSlider = style:CreateSlider(L.FontSize, 8, 60, 1, 150)
timerFontSizeSlider:SetPoint("TOPLEFT", FontDropDownTimer, "TOPLEFT", 20, -50)
timerFontSizeSlider:SetValue(DBM.Options.NPIconTimerFontSize)
timerFontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTimerFontSize = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local timerEnable = style:CreateCheckButton(L.Enable, true, nil, "NPIconTimerEnabled")
timerEnable:SetPoint("TOPLEFT", TimerFontStyleDropDown, "TOPLEFT", 20, -35)

local FontDropDownText = style:CreateDropdown(L.FontTypeText, Fonts, "DBM", "NPIconTextFont", function(value)
	DBM.Options.NPIconTextFont = value
	DBM.Nameplate:UpdateIconOptions()
end)
FontDropDownText:SetPoint("TOPLEFT", timerFontSizeSlider, "TOPLEFT", -20, -50)

local TextFontStyleDropDown = style:CreateDropdown(L.FontStyle, FontStyles, "DBM", "NPIconTextFontStyle", function(value)
	DBM.Options.NPIconTextFontStyle = value
	DBM.Nameplate:UpdateIconOptions()
end)
TextFontStyleDropDown:SetPoint("LEFT", FontDropDownText, "RIGHT", 25, 0)
TextFontStyleDropDown.myheight = 0

local textFontSizeSlider = style:CreateSlider(L.FontSize, 8, 60, 1, 150)
textFontSizeSlider:SetPoint("TOPLEFT", FontDropDownText, "TOPLEFT", 20, -40)
textFontSizeSlider:SetValue(DBM.Options.NPIconTextFontSize)
textFontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTextFontSize = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local textEnable = style:CreateCheckButton(L.Enable, true, nil, "NPIconTextEnabled")
textEnable:SetPoint("TOPLEFT", TextFontStyleDropDown, "TOPLEFT", 20, -35)

local iconTextMaxLenSlider = style:CreateSlider(L.NPIcon_MaxTextLen, 3, 40, 1, 150)
iconTextMaxLenSlider:SetPoint("TOPLEFT", textFontSizeSlider, "BOTTOMLEFT", 0, -30)
iconTextMaxLenSlider:SetValue(DBM.Options.NPIconTextMaxLen)
iconTextMaxLenSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPIconTextMaxLen = self:GetValue()
	DBM.Nameplate:UpdateIconOptions()
end)

local styleResetbutton = style:CreateButton(L.SpecWarn_ResetMe, 120, 16)
styleResetbutton:SetPoint("BOTTOMRIGHT", style.frame, "BOTTOMRIGHT", -2, 4)
styleResetbutton:SetNormalFontObject(GameFontNormalSmall)
styleResetbutton:SetHighlightFontObject(GameFontNormalSmall)
styleResetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.NPIconSize = DBM.DefaultOptions.NPIconSize
	DBM.Options.NPIconOffsetX = DBM.DefaultOptions.NPIconOffsetX
	DBM.Options.NPIconOffsetY = DBM.DefaultOptions.NPIconOffsetY
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
	iconOffsetXSlider:SetValue(DBM.DefaultOptions.NPIconOffsetX)
	iconOffsetYSlider:SetValue(DBM.DefaultOptions.NPIconOffsetY)
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

	DBM.Nameplate:UpdateIconOptions()
end)
styleResetbutton.myheight = 0

local glow = panel:CreateArea(L.Area_NPGlow)

local cooldownGlowOptions = {
	{
		text	= L.NPIcon_GlowNone,
		value	= 0,
	},
	{
		text	= L.NPIcon_GlowImportant,
		value	= 1,
	},
	{
		text	= L.NPIcon_GlowAll,
		value	= 2,
	},
}

local castGlowOptions = {
	{
		text	= L.NPIcon_GlowNone,
		value	= 0,
	},
	{
		text	= L.NPIcon_GlowImportant,
		value	= 1,
	},
}

local cooldownGlowType = {
	{
		text	= L.NPIcon_Pixel,
		value	= 1,
	},
--	{
--		text	= L.NPIcon_Proc,
--		value	= 2,
--	},
	{
		text	= L.NPIcon_AutoCast,
		value	= 3,
	},
	{
		text	= L.NPIcon_Button,
		value	= 4,
	},
}

local cooldownIconGlowBehavior = glow:CreateDropdown(L.NPIcon_GlowBehavior, cooldownGlowOptions, "DBM", "NPIconGlowBehavior", function(value)
	DBM.Options.NPIconGlowBehavior = value
end, 200)
cooldownIconGlowBehavior:SetPoint("TOPLEFT", glow.frame, "TOPLEFT", 20, -25)
cooldownIconGlowBehavior.myheight = 50

local cooldownIconGlowType = glow:CreateDropdown(L.NPIcon_GlowTypeCD, cooldownGlowType, "DBM", "CDNPIconGlowType", function(value)
	DBM.Options.CDNPIconGlowType = value
end, 100)
cooldownIconGlowType:SetPoint("LEFT", cooldownIconGlowBehavior, "RIGHT", 45, 0)
cooldownIconGlowType.myheight = 0

local castIconGlowBehavior = glow:CreateDropdown(L.NPIcon_CastGlowBehavior, castGlowOptions, "DBM", "CastNPIconGlowBehavior", function(value)
	DBM.Options.CastNPIconGlowBehavior = value
end, 200)
castIconGlowBehavior:SetPoint("TOPLEFT", cooldownIconGlowBehavior, "BOTTOMLEFT", 0, -20)
castIconGlowBehavior.myheight = 50

local castIconGlowType = glow:CreateDropdown(L.NPIcon_GlowTypeCast, cooldownGlowType, "DBM", "CastNPIconGlowType2", function(value)
	DBM.Options.CastNPIconGlowType2 = value
end, 100)
castIconGlowType:SetPoint("LEFT", castIconGlowBehavior, "RIGHT", 45, 0)
castIconGlowType.myheight = 0

local glowResetbutton = glow:CreateButton(L.SpecWarn_ResetMe, 120, 16)
glowResetbutton:SetPoint("BOTTOMRIGHT", glow.frame, "BOTTOMRIGHT", -2, 4)
glowResetbutton:SetNormalFontObject(GameFontNormalSmall)
glowResetbutton:SetHighlightFontObject(GameFontNormalSmall)
glowResetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.NPIconGlowBehavior = DBM.DefaultOptions.NPIconGlowBehavior
	DBM.Options.CDNPIconGlowType = DBM.DefaultOptions.CDNPIconGlowType
	DBM.Options.CastNPIconGlowBehavior = DBM.DefaultOptions.CastNPIconGlowBehavior
	DBM.Options.CastNPIconGlowType2 = DBM.DefaultOptions.CastNPIconGlowType2
	-- Set UI visuals
	cooldownIconGlowBehavior:SetSelectedValue(DBM.DefaultOptions.NPIconGlowBehavior)
	cooldownIconGlowType:SetSelectedValue(DBM.DefaultOptions.CDNPIconGlowType)
	castIconGlowType:SetSelectedValue(DBM.DefaultOptions.CastNPIconGlowBehavior)
	castIconGlowType:SetSelectedValue(DBM.DefaultOptions.CastNPIconGlowType2)

	DBM.Nameplate:UpdateIconOptions()
end)
glowResetbutton.myheight = 0
