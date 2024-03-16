local L, CL = DBM_GUI_L, DBM_CORE_L
local DBM = DBM

local GameFontNormalSmall = GameFontNormalSmall

local panel = DBM_GUI.Cat_Frames:CreateNewPanel(L.Panel_InfoFrame, "option")

local general = panel:CreateArea(L.Area_General)

local dontShow = general:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
local locked = general:CreateCheckButton(LOCK_FRAME, true, nil, "InfoFrameLocked")
local showSelf = general:CreateCheckButton(CL.INFOFRAME_SHOW_SELF, false, nil, "InfoFrameShowSelf")

local lines = {
	{
		text	= CL.INFOFRAME_LINESDEFAULT,
		value	= 0
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(3),
		value	= 3
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(5),
		value	= 5
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(8),
		value	= 8
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(10),
		value	= 10
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(15),
		value	= 15
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(20),
		value	= 20
	},
	{
		text	= CL.INFOFRAME_LINES_TO:format(30),
		value	= 30
	}
}

local linesDropdown = general:CreateDropdown(CL.INFOFRAME_SETLINES, lines, "DBM", "InfoFrameLines", function(value)
	DBM.Options.InfoFrameLines = value
	DBM.InfoFrame:UpdateStyle()
end)
linesDropdown:SetPoint("TOPLEFT", showSelf, "BOTTOMLEFT", 0, -10)

local columns = {
	{
		text	= CL.INFOFRAME_LINESDEFAULT,
		value	= 0
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(1),
		value	= 1
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(2),
		value	= 2
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(3),
		value	= 3
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(4),
		value	= 4
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(5),
		value	= 5
	},
	{
		text	= CL.INFOFRAME_COLS_TO:format(6),
		value	= 6
	}
}

local columnsDropdown = general:CreateDropdown(CL.INFOFRAME_SETCOLS, columns, "DBM", "InfoFrameLines", function(value)
	DBM.Options.InfoFrameCols = value
	DBM.InfoFrame:UpdateStyle()
end)
columnsDropdown:SetPoint("TOPLEFT", linesDropdown, "BOTTOMLEFT", 0, -10)

--local position = panel:CreateArea(L.Area_Position)

local style = panel:CreateArea(L.Area_Style)

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

local FontDropDown = style:CreateDropdown(L.FontType, Fonts, "DBM", "InfoFrameFont", function(value)
	DBM.Options.InfoFrameFont = value
	DBM.InfoFrame:UpdateStyle()
end)
FontDropDown:SetPoint("TOPLEFT", style.frame, "TOPLEFT", 0, -20)

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

local FontStyleDropDown = style:CreateDropdown(L.FontStyle, FontStyles, "DBM", "InfoFrameFontStyle", function(value)
	DBM.Options.InfoFrameFontStyle = value
	DBM.InfoFrame:UpdateStyle()
end)
FontStyleDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, -10)

local fontSizeSlider = style:CreateSlider(L.FontSize, 8, 60, 1, 150)
fontSizeSlider:SetPoint("TOPLEFT", FontStyleDropDown, "TOPLEFT", 20, -45)
fontSizeSlider:SetValue(DBM.Options.InfoFrameFontSize)
fontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.InfoFrameFontSize = self:GetValue()
	DBM.InfoFrame:UpdateStyle()
end)

local movemebutton = general:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", general.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function()
	if DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:Hide()
	else
		DBM.InfoFrame:Show(5, "test")
	end
end)

local resetbutton = general:CreateButton(L.SpecWarn_ResetMe, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", general.frame, "BOTTOMRIGHT", -2, 4)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.DontShowInfoFrame = DBM.DefaultOptions.DontShowInfoFrame
	DBM.Options.InfoFrameLocked = true
	DBM.Options.InfoFrameShowSelf = DBM.DefaultOptions.InfoFrameShowSelf
	DBM.Options.InfoFrameFont = DBM.DefaultOptions.InfoFrameFont
	DBM.Options.InfoFrameFontStyle = DBM.DefaultOptions.InfoFrameFontStyle
	DBM.Options.InfoFrameFontSize = DBM.DefaultOptions.InfoFrameFontSize
	-- Set UI visuals
	dontShow:SetChecked(DBM.Options.DontShowInfoFrame)
	locked:SetChecked(true)
	showSelf:SetChecked(DBM.Options.InfoFrameShowSelf)
	FontDropDown:SetSelectedValue(DBM.Options.WarningFont)
	FontStyleDropDown:SetSelectedValue(DBM.Options.FontStyles)
	fontSizeSlider:SetValue(DBM.DefaultOptions.WarningFontSize)
	DBM.InfoFrame:UpdateStyle()
end)
