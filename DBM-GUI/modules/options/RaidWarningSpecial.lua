local L = DBM_GUI_L

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont = STANDARD_TEXT_FONT
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

local specPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_SpecWarnFrame, "option")
local specArea = specPanel:CreateArea(L.Area_SpecWarn, 300)

local check1 = specArea:CreateCheckButton(L.SpecWarn_ClassColor, true, nil, "SWarnClassColor")
local check2 = specArea:CreateCheckButton(L.WarningAlphabetical, true, nil, "SWarningAlphabetical")
local check3 = specArea:CreateCheckButton(L.ShowSWarningsInChat, true, nil, "ShowSWarningsInChat")
local check4 = specArea:CreateCheckButton(L.SWarnNameInNote, true, nil, "SWarnNameInNote")
local check5 = specArea:CreateCheckButton(L.SpecialWarningIcon, true, nil, "SpecialWarningIcon")
local check6 = specArea:CreateCheckButton(L.ShortTextSpellname, true, nil, "SpecialWarningShortText")

local movemebutton = specArea:CreateButton(L.SpecWarn_MoveMe, 120, 16)
movemebutton:SetPoint("TOPRIGHT", specArea.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function() DBM:MoveSpecialWarning() end)

local color0 = specArea:CreateColorSelect(64)
color0:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 20, -200)
local color0text = specArea:CreateText(L.SpecWarn_FontColor, 80)
color0text:SetPoint("BOTTOM", color0, "TOP", 5, 4)
local color0reset = specArea:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color0reset:SetPoint("TOP", color0, "BOTTOM", 5, -10)
color0reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFontCol[1] = DBM.DefaultOptions.SpecialWarningFontCol[1]
	DBM.Options.SpecialWarningFontCol[2] = DBM.DefaultOptions.SpecialWarningFontCol[2]
	DBM.Options.SpecialWarningFontCol[3] = DBM.DefaultOptions.SpecialWarningFontCol[3]
	color0:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
	DBM:UpdateSpecialWarningOptions()
end)
color0:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
color0:SetScript("OnColorSelect", function(self)
	DBM.Options.SpecialWarningFontCol[1] = select(1, self:GetColorRGB())
	DBM.Options.SpecialWarningFontCol[2] = select(2, self:GetColorRGB())
	DBM.Options.SpecialWarningFontCol[3] = select(3, self:GetColorRGB())
	color0text:SetTextColor(self:GetColorRGB())
	DBM:UpdateSpecialWarningOptions()
end)

local Fonts = DBM_GUI:MixinSharedMedia3("font", {
	{
		text	= "Default",
		value	= standardFont
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

local FontDropDown = specArea:CreateDropdown(L.SpecWarn_FontType, Fonts, "DBM", "SpecialWarningFont", function(value)
	DBM.Options.SpecialWarningFont = value
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 1)
end)
FontDropDown:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 95, -198)

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

local FontStyleDropDown = specArea:CreateDropdown(L.Warn_FontStyle, FontStyles, "DBM", "SpecialWarningFontStyle", function(value)
	DBM.Options.SpecialWarningFontStyle = value
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 1)
end)
FontStyleDropDown:SetPoint("LEFT", FontDropDown, "RIGHT", 25, 0)

local FontShadow = specArea:CreateCheckButton(L.Warn_FontShadow, nil, nil, "SpecialWarningFontShadow")
FontShadow:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFontShadow = not DBM.Options.SpecialWarningFontShadow
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 1)
end)
FontShadow:SetPoint("LEFT", FontStyleDropDown, "RIGHT", -35, 25)

local fontSizeSlider = specArea:CreateSlider(L.SpecWarn_FontSize, 8, 60, 1, 150)
fontSizeSlider:SetPoint("TOPLEFT", FontDropDown, "TOPLEFT", 20, -45)
fontSizeSlider:SetValue(DBM.Options.SpecialWarningFontSize2)
fontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFontSize2 = self:GetValue()
	DBM:UpdateSpecialWarningOptions()
end)

local durationSlider = specArea:CreateSlider(L.Warn_Duration, 1, 10, 0.5, 150)
durationSlider:SetPoint("LEFT", fontSizeSlider, "RIGHT", 20, 0)
durationSlider:SetValue(DBM.Options.SpecialWarningDuration2)
durationSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningDuration2 = self:GetValue()
	DBM:UpdateSpecialWarningOptions()
end)

local Sounds = DBM_GUI:MixinSharedMedia3("sound", {
	{ text = L.NoSound, value = "" },
	{ text = "Algalon: Beware!", value = 15391 },
	{ text = "BB Wolf: Run Away", value = 9278 },
	{ text = "Blizzard Raid Emote", value = 37666 },
	{ text = "C'Thun: You Will Die!", value = 8585 },
	{ text = "Headless Horseman: Laugh", value = 12506 },
	{ text = "Illidan: Not Prepared", value = 68563 },
	{ text = "Illidan: Not Prepared2", value = 12506 },
	{ text = "Kaz'rogal: Marked", value = 11052 },
	{ text = "Kil'Jaeden: Destruction", value = 12506 },
	{ text = "Loatheb: I see you", value = 128466 },
	{ text = "Lady Malande: Flee", value = 11482 },
	{ text = "Milhouse: Light You Up", value = 49764 },
	{ text = "Night Elf Bell", value = 11742 },
	{ text = "PvP Flag", value = 8174 },
	{ text = "Void Reaver: Marked", value = 11213 },
	{ text = "Yogg Saron: Laugh", value = 15757 },
})

local specWarnOne = specPanel:CreateArea(L.SpecialWarnHeader1, 160)

local showbuttonOne = specWarnOne:CreateButton(L.SpecWarn_DemoButton, 120, 16)
showbuttonOne:SetPoint("BOTTOMRIGHT", specWarnOne.frame, "BOTTOMRIGHT", -2, 4)
showbuttonOne:SetNormalFontObject(GameFontNormalSmall)
showbuttonOne:SetHighlightFontObject(GameFontNormalSmall)
showbuttonOne:SetScript("OnClick", function()
	DBM:ShowTestSpecialWarning(nil, 1)
end)

local color1 = specWarnOne:CreateColorSelect(64)
color1:SetPoint("TOPLEFT", specWarnOne.frame, "TOPLEFT", 20, -30)
local color1text = specWarnOne:CreateText(L.SpecWarn_FlashColor:format(1), 85)
color1text:SetPoint("BOTTOM", color1, "TOP", 5, 4)
local color1reset = specWarnOne:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1reset:SetPoint("TOP", color1, "BOTTOM", 5, -10)
color1reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFlashCol1[1] = DBM.DefaultOptions.SpecialWarningFlashCol1[1]
	DBM.Options.SpecialWarningFlashCol1[2] = DBM.DefaultOptions.SpecialWarningFlashCol1[2]
	DBM.Options.SpecialWarningFlashCol1[3] = DBM.DefaultOptions.SpecialWarningFlashCol1[3]
	color1:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
	DBM:UpdateSpecialWarningOptions()
end)
color1:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
color1:SetScript("OnColorSelect", function(self)
	DBM.Options.SpecialWarningFlashCol1[1] = select(1, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol1[2] = select(2, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol1[3] = select(3, self:GetColorRGB())
	color1text:SetTextColor(self:GetColorRGB())
	DBM:UpdateSpecialWarningOptions()
end)

local SpecialWarnSoundDropDown = specWarnOne:CreateDropdown(L.SpecialWarnSoundOption, Sounds, "DBM", "SpecialWarningSound", function(value)
	DBM.Options.SpecialWarningSound = value
end)
SpecialWarnSoundDropDown:SetPoint("TOPLEFT", specWarnOne.frame, "TOPLEFT", 95, -28)
local flashCheck1 = specWarnOne:CreateCheckButton(L.SpecWarn_Flash, nil, nil, "SpecialWarningFlash1")
flashCheck1:SetPoint("BOTTOMLEFT", SpecialWarnSoundDropDown, "BOTTOMLEFT", 220, 4)

local flashdurSlider = specWarnOne:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)
flashdurSlider:SetPoint("TOPLEFT", SpecialWarnSoundDropDown, "TOPLEFT", 20, -45)
flashdurSlider:SetValue(DBM.Options.SpecialWarningFlashDura1)
do
	flashdurSlider:HookScript("OnValueChanged", function(self)
		DBM.Options.SpecialWarningFlashDura1 = self:GetValue()
	end)
end

local flashdalphaSlider = specWarnOne:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)
flashdalphaSlider:SetPoint("BOTTOMLEFT", flashdurSlider, "BOTTOMLEFT", 180, 0)
flashdalphaSlider:SetValue(DBM.Options.SpecialWarningFlashAlph1)
flashdalphaSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashAlph1 = self:GetValue()
end)

local flashRepSlider = specWarnOne:CreateSlider(L.SpecWarn_FlashFrameRepeat, 1, 4, 1, 120)
flashRepSlider:SetPoint("TOPLEFT", flashdurSlider, "TOPLEFT", 95, -45)
flashRepSlider:SetValue(math.floor(DBM.Options.SpecialWarningFlashCount1))
flashRepSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashCount1 = math.floor(self:GetValue())
end)

--Special Warning Area 2
local specWarnTwo = specPanel:CreateArea(L.SpecialWarnHeader2, 160)

local showbuttonTwo = specWarnTwo:CreateButton(L.SpecWarn_DemoButton, 120, 16)
showbuttonTwo:SetPoint("BOTTOMRIGHT", specWarnTwo.frame, "BOTTOMRIGHT", -2, 4)
showbuttonTwo:SetNormalFontObject(GameFontNormalSmall)
showbuttonTwo:SetHighlightFontObject(GameFontNormalSmall)
showbuttonTwo:SetScript("OnClick", function()
	DBM:ShowTestSpecialWarning(nil, 2)
end)

local color2 = specWarnTwo:CreateColorSelect(64)
color2:SetPoint("TOPLEFT", specWarnTwo.frame, "TOPLEFT", 20, -30)
local color2text = specWarnTwo:CreateText(L.SpecWarn_FlashColor:format(2), 85)
color2text:SetPoint("BOTTOM", color2, "TOP", 5, 4)
local color2reset = specWarnTwo:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color2reset:SetPoint("TOP", color2, "BOTTOM", 5, -10)
color2reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFlashCol2[1] = DBM.DefaultOptions.SpecialWarningFlashCol2[1]
	DBM.Options.SpecialWarningFlashCol2[2] = DBM.DefaultOptions.SpecialWarningFlashCol2[2]
	DBM.Options.SpecialWarningFlashCol2[3] = DBM.DefaultOptions.SpecialWarningFlashCol2[3]
	color2:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
end)
color2:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
color2:SetScript("OnColorSelect", function(self)
		DBM.Options.SpecialWarningFlashCol2[1] = select(1, self:GetColorRGB())
		DBM.Options.SpecialWarningFlashCol2[2] = select(2, self:GetColorRGB())
		DBM.Options.SpecialWarningFlashCol2[3] = select(3, self:GetColorRGB())
		color2text:SetTextColor(self:GetColorRGB())
		DBM:UpdateSpecialWarningOptions()
end)

local SpecialWarnSoundDropDown2 = specWarnTwo:CreateDropdown(L.SpecialWarnSoundOption, Sounds, "DBM", "SpecialWarningSound2", function(value)
	DBM.Options.SpecialWarningSound2 = value
end)
SpecialWarnSoundDropDown2:SetPoint("TOPLEFT", specWarnTwo.frame, "TOPLEFT", 95, -28)
local flashCheck2 = specWarnTwo:CreateCheckButton(L.SpecWarn_Flash, nil, nil, "SpecialWarningFlash2")
flashCheck2:SetPoint("BOTTOMLEFT", SpecialWarnSoundDropDown2, "BOTTOMLEFT", 220, 4)

local flashdurSlider2 = specWarnTwo:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)
flashdurSlider2:SetPoint("TOPLEFT", SpecialWarnSoundDropDown2, "TOPLEFT", 20, -45)
flashdurSlider2:SetValue(DBM.Options.SpecialWarningFlashDura2)
flashdurSlider2:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashDura2 = self:GetValue()
end)

local flashdalphaSlider2 = specWarnTwo:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)
flashdalphaSlider2:SetPoint("BOTTOMLEFT", flashdurSlider2, "BOTTOMLEFT", 180, 0)
flashdalphaSlider2:SetValue(DBM.Options.SpecialWarningFlashAlph2)
flashdalphaSlider2:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashAlph2 = self:GetValue()
end)

local flashRepSlider2 = specWarnOne:CreateSlider(L.SpecWarn_FlashFrameRepeat, 1, 4, 1, 120)
flashRepSlider2:SetPoint("TOPLEFT", flashdurSlider2, "TOPLEFT", 95, -45)
flashRepSlider2:SetValue(math.floor(DBM.Options.SpecialWarningFlashCount2))
flashRepSlider2:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashCount2 = math.floor(self:GetValue())
	DBM:UpdateSpecialWarningOptions()
end)

--Special Warning Area 3
local specWarnThree = specPanel:CreateArea(L.SpecialWarnHeader3, 160)

local showbuttonThree = specWarnThree:CreateButton(L.SpecWarn_DemoButton, 120, 16)
showbuttonThree:SetPoint("BOTTOMRIGHT", specWarnThree.frame, "BOTTOMRIGHT", -2, 4)
showbuttonThree:SetNormalFontObject(GameFontNormalSmall)
showbuttonThree:SetHighlightFontObject(GameFontNormalSmall)
showbuttonThree:SetScript("OnClick", function()
	DBM:ShowTestSpecialWarning(nil, 3)
end)

local color3 = specWarnThree:CreateColorSelect(64)
color3:SetPoint("TOPLEFT", specWarnThree.frame, "TOPLEFT", 20, -30)
local color3text = specWarnThree:CreateText(L.SpecWarn_FlashColor:format(3), 85)
color3text:SetPoint("BOTTOM", color3, "TOP", 5, 4)
local color3reset = specWarnThree:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color3reset:SetPoint("TOP", color3, "BOTTOM", 5, -10)
color3reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFlashCol3[1] = DBM.DefaultOptions.SpecialWarningFlashCol3[1]
	DBM.Options.SpecialWarningFlashCol3[2] = DBM.DefaultOptions.SpecialWarningFlashCol3[2]
	DBM.Options.SpecialWarningFlashCol3[3] = DBM.DefaultOptions.SpecialWarningFlashCol3[3]
	color3:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 3)
end)
color3:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
color3:SetScript("OnColorSelect", function(self)
	DBM.Options.SpecialWarningFlashCol3[1] = select(1, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol3[2] = select(2, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol3[3] = select(3, self:GetColorRGB())
	color3text:SetTextColor(self:GetColorRGB())
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 3)
end)

local SpecialWarnSoundDropDown3 = specWarnThree:CreateDropdown(L.SpecialWarnSoundOption, Sounds, "DBM", "SpecialWarningSound3", function(value)
	DBM.Options.SpecialWarningSound3 = value
end)
SpecialWarnSoundDropDown3:SetPoint("TOPLEFT", specWarnThree.frame, "TOPLEFT", 95, -28)
local flashCheck3 = specWarnThree:CreateCheckButton(L.SpecWarn_Flash, nil, nil, "SpecialWarningFlash3")
flashCheck3:SetPoint("BOTTOMLEFT", SpecialWarnSoundDropDown3, "BOTTOMLEFT", 220, 4)

local flashdurSlider3 = specWarnThree:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)
flashdurSlider3:SetPoint("TOPLEFT", SpecialWarnSoundDropDown3, "TOPLEFT", 20, -45)
flashdurSlider3:SetValue(DBM.Options.SpecialWarningFlashDura3)
flashdurSlider3:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashDura3 = self:GetValue()
end)

local flashdalphaSlider3 = specWarnThree:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)
flashdalphaSlider3:SetPoint("BOTTOMLEFT", flashdurSlider3, "BOTTOMLEFT", 180, 0)
flashdalphaSlider3:SetValue(DBM.Options.SpecialWarningFlashAlph3)
flashdalphaSlider3:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashAlph3 = self:GetValue()
end)

local flashRepSlider3 = specWarnOne:CreateSlider(L.SpecWarn_FlashFrameRepeat, 1, 4, 1, 120)
flashRepSlider3:SetPoint("TOPLEFT", flashdurSlider3, "TOPLEFT", 95, -45)
flashRepSlider3:SetValue(math.floor(DBM.Options.SpecialWarningFlashCount3))
flashRepSlider3:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashCount3 = math.floor(self:GetValue())
	DBM:UpdateSpecialWarningOptions()
end)

local specWarnFour = specPanel:CreateArea(L.SpecialWarnHeader4, 160)

local showbuttonFour = specWarnFour:CreateButton(L.SpecWarn_DemoButton, 120, 16)
showbuttonFour:SetPoint("BOTTOMRIGHT", specWarnFour.frame, "BOTTOMRIGHT", -2, 4)
showbuttonFour:SetNormalFontObject(GameFontNormalSmall)
showbuttonFour:SetHighlightFontObject(GameFontNormalSmall)
showbuttonFour:SetScript("OnClick", function()
	DBM:ShowTestSpecialWarning(nil, 4)
end)

local color4 = specWarnFour:CreateColorSelect(64)
color4:SetPoint("TOPLEFT", specWarnFour.frame, "TOPLEFT", 20, -30)
local color4text = specWarnFour:CreateText(L.SpecWarn_FlashColor:format(4), 85)
color4text:SetPoint("BOTTOM", color4, "TOP", 5, 4)
local color4reset = specWarnFour:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color4reset:SetPoint("TOP", color4, "BOTTOM", 5, -10)
color4reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFlashCol4[1] = DBM.DefaultOptions.SpecialWarningFlashCol4[1]
	DBM.Options.SpecialWarningFlashCol4[2] = DBM.DefaultOptions.SpecialWarningFlashCol4[2]
	DBM.Options.SpecialWarningFlashCol4[3] = DBM.DefaultOptions.SpecialWarningFlashCol4[3]
	color4:SetColorRGB(DBM.Options.SpecialWarningFlashCol4[1], DBM.Options.SpecialWarningFlashCol4[2], DBM.Options.SpecialWarningFlashCol4[3])
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 4)
end)
color4:SetColorRGB(DBM.Options.SpecialWarningFlashCol4[1], DBM.Options.SpecialWarningFlashCol4[2], DBM.Options.SpecialWarningFlashCol4[3])
color4:SetScript("OnColorSelect", function(self)
	DBM.Options.SpecialWarningFlashCol4[1] = select(1, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol4[2] = select(2, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol4[3] = select(3, self:GetColorRGB())
	color4text:SetTextColor(self:GetColorRGB())
	DBM:UpdateSpecialWarningOptions()
	DBM:ShowTestSpecialWarning(nil, 4)
end)

local SpecialWarnSoundDropDown4 = specWarnFour:CreateDropdown(L.SpecialWarnSoundOption, Sounds, "DBM", "SpecialWarningSound4", function(value)
	DBM.Options.SpecialWarningSound4 = value
end)
SpecialWarnSoundDropDown4:SetPoint("TOPLEFT", specWarnFour.frame, "TOPLEFT", 95, -28)
local flashCheck4 = specWarnFour:CreateCheckButton(L.SpecWarn_Flash, nil, nil, "SpecialWarningFlash4")
flashCheck4:SetPoint("BOTTOMLEFT", SpecialWarnSoundDropDown4, "BOTTOMLEFT", 220, 4)

local flashdurSlider4 = specWarnFour:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)
flashdurSlider4:SetPoint("TOPLEFT", SpecialWarnSoundDropDown4, "TOPLEFT", 20, -45)
flashdurSlider4:SetValue(DBM.Options.SpecialWarningFlashDura4)
flashdurSlider4:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashDura4 = self:GetValue()
end)

local flashdalphaSlider4 = specWarnFour:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)
flashdalphaSlider4:SetPoint("BOTTOMLEFT", flashdurSlider4, "BOTTOMLEFT", 180, 0)
flashdalphaSlider4:SetValue(DBM.Options.SpecialWarningFlashAlph4)
flashdalphaSlider4:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashAlph4 = self:GetValue()
end)

local flashRepSlider4 = specWarnOne:CreateSlider(L.SpecWarn_FlashFrameRepeat, 1, 4, 1, 120)
flashRepSlider4:SetPoint("TOPLEFT", flashdurSlider4, "TOPLEFT", 95, -45)
flashRepSlider4:SetValue(math.floor(DBM.Options.SpecialWarningFlashCount4))
flashRepSlider4:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashCount4 = math.floor(self:GetValue())
	DBM:UpdateSpecialWarningOptions()
end)

local specWarnFive = specPanel:CreateArea(L.SpecialWarnHeader5, 160)

local showbuttonFive = specWarnFive:CreateButton(L.SpecWarn_DemoButton, 120, 16)
showbuttonFive:SetPoint("BOTTOMRIGHT", specWarnFive.frame, "BOTTOMRIGHT", -2, 4)
showbuttonFive:SetNormalFontObject(GameFontNormalSmall)
showbuttonFive:SetHighlightFontObject(GameFontNormalSmall)
showbuttonFive:SetScript("OnClick", function()
	DBM:ShowTestSpecialWarning(nil, 5)
end)

local color5 = specWarnFive:CreateColorSelect(64)
color5:SetPoint("TOPLEFT", specWarnFive.frame, "TOPLEFT", 20, -30)
local color5text = specWarnFive:CreateText(L.SpecWarn_FlashColor:format(5), 85)
color5text:SetPoint("BOTTOM", color5, "TOP", 5, 4)
local color5reset = specWarnFive:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color5reset:SetPoint("TOP", color5, "BOTTOM", 5, -10)
color5reset:SetScript("OnClick", function()
	DBM.Options.SpecialWarningFlashCol5[1] = DBM.DefaultOptions.SpecialWarningFlashCol5[1]
	DBM.Options.SpecialWarningFlashCol5[2] = DBM.DefaultOptions.SpecialWarningFlashCol5[2]
	DBM.Options.SpecialWarningFlashCol5[3] = DBM.DefaultOptions.SpecialWarningFlashCol5[3]
	color5:SetColorRGB(DBM.Options.SpecialWarningFlashCol5[1], DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3])
	DBM:UpdateSpecialWarningOptions()
end)
color5:SetColorRGB(DBM.Options.SpecialWarningFlashCol5[1], DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3])
color5:SetScript("OnColorSelect", function(self)
	DBM.Options.SpecialWarningFlashCol5[1] = select(1, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol5[2] = select(2, self:GetColorRGB())
	DBM.Options.SpecialWarningFlashCol5[3] = select(3, self:GetColorRGB())
	color5text:SetTextColor(self:GetColorRGB())
	DBM:UpdateSpecialWarningOptions()
end)

local SpecialWarnSoundDropDown5 = specWarnFive:CreateDropdown(L.SpecialWarnSoundOption, Sounds, "DBM", "SpecialWarningSound5", function(value)
	DBM.Options.SpecialWarningSound5 = value
end)
SpecialWarnSoundDropDown5:SetPoint("TOPLEFT", specWarnFive.frame, "TOPLEFT", 95, -28)
local flashCheck5 = specWarnFive:CreateCheckButton(L.SpecWarn_Flash, nil, nil, "SpecialWarningFlash5")
flashCheck5:SetPoint("BOTTOMLEFT", SpecialWarnSoundDropDown5, "BOTTOMLEFT", 220, 4)

local flashdurSlider5 = specWarnFive:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)
flashdurSlider5:SetPoint("TOPLEFT", SpecialWarnSoundDropDown5, "TOPLEFT", 20, -45)
flashdurSlider5:SetValue(DBM.Options.SpecialWarningFlashDura5)
flashdurSlider5:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashDura5 = self:GetValue()
end)

local flashdalphaSlider5 = specWarnFive:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)
flashdalphaSlider5:SetPoint("BOTTOMLEFT", flashdurSlider5, "BOTTOMLEFT", 180, 0)
flashdalphaSlider5:SetValue(DBM.Options.SpecialWarningFlashAlph5)
flashdalphaSlider5:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashAlph5 = self:GetValue()
end)

local flashRepSlider5 = specWarnOne:CreateSlider(L.SpecWarn_FlashFrameRepeat, 1, 4, 1, 120)
flashRepSlider5:SetPoint("TOPLEFT", flashdurSlider5, "TOPLEFT", 95, -45)
flashRepSlider5:SetValue(math.floor(DBM.Options.SpecialWarningFlashCount5))
flashRepSlider5:HookScript("OnValueChanged", function(self)
	DBM.Options.SpecialWarningFlashCount5 = math.floor(self:GetValue())
	DBM:UpdateSpecialWarningOptions()
end)

local resetbutton = specArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", specArea.frame, "BOTTOMRIGHT", -2, 4)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.SWarnNameInNote = DBM.DefaultOptions.SWarnNameInNote
	DBM.Options.SpecialWarningFont = DBM.DefaultOptions.SpecialWarningFont
	DBM.Options.SpecialWarningSound = DBM.DefaultOptions.SpecialWarningSound
	DBM.Options.SpecialWarningSound2 = DBM.DefaultOptions.SpecialWarningSound2
	DBM.Options.SpecialWarningSound3 = DBM.DefaultOptions.SpecialWarningSound3
	DBM.Options.SpecialWarningSound4 = DBM.DefaultOptions.SpecialWarningSound4
	DBM.Options.SpecialWarningSound5 = DBM.DefaultOptions.SpecialWarningSound5
	DBM.Options.SpecialWarningFlash1 = DBM.DefaultOptions.SpecialWarningFlash1
	DBM.Options.SpecialWarningFlash2 = DBM.DefaultOptions.SpecialWarningFlash2
	DBM.Options.SpecialWarningFlash3 = DBM.DefaultOptions.SpecialWarningFlash3
	DBM.Options.SpecialWarningFlash4 = DBM.DefaultOptions.SpecialWarningFlash4
	DBM.Options.SpecialWarningFlash5 = DBM.DefaultOptions.SpecialWarningFlash5
	DBM.Options.SpecialWarningFlashCount1 = DBM.DefaultOptions.SpecialWarningFlashCount1
	DBM.Options.SpecialWarningFlashCount2 = DBM.DefaultOptions.SpecialWarningFlashCount2
	DBM.Options.SpecialWarningFlashCount3 = DBM.DefaultOptions.SpecialWarningFlashCount3
	DBM.Options.SpecialWarningFlashCount4 = DBM.DefaultOptions.SpecialWarningFlashCount4
	DBM.Options.SpecialWarningFlashCount5 = DBM.DefaultOptions.SpecialWarningFlashCount5
	DBM.Options.SpecialWarningFontSize2 = DBM.DefaultOptions.SpecialWarningFontSize2
	DBM.Options.SpecialWarningFlashCol1[1] = DBM.DefaultOptions.SpecialWarningFlashCol1[1]
	DBM.Options.SpecialWarningFlashCol1[2] = DBM.DefaultOptions.SpecialWarningFlashCol1[2]
	DBM.Options.SpecialWarningFlashCol1[3] = DBM.DefaultOptions.SpecialWarningFlashCol1[3]
	DBM.Options.SpecialWarningFlashCol2[1] = DBM.DefaultOptions.SpecialWarningFlashCol2[1]
	DBM.Options.SpecialWarningFlashCol2[2] = DBM.DefaultOptions.SpecialWarningFlashCol2[2]
	DBM.Options.SpecialWarningFlashCol2[3] = DBM.DefaultOptions.SpecialWarningFlashCol2[3]
	DBM.Options.SpecialWarningFlashCol3[1] = DBM.DefaultOptions.SpecialWarningFlashCol3[1]
	DBM.Options.SpecialWarningFlashCol3[2] = DBM.DefaultOptions.SpecialWarningFlashCol3[2]
	DBM.Options.SpecialWarningFlashCol3[3] = DBM.DefaultOptions.SpecialWarningFlashCol3[3]
	DBM.Options.SpecialWarningFlashCol4[1] = DBM.DefaultOptions.SpecialWarningFlashCol4[1]
	DBM.Options.SpecialWarningFlashCol4[2] = DBM.DefaultOptions.SpecialWarningFlashCol4[2]
	DBM.Options.SpecialWarningFlashCol4[3] = DBM.DefaultOptions.SpecialWarningFlashCol4[3]
	DBM.Options.SpecialWarningFlashCol5[1] = DBM.DefaultOptions.SpecialWarningFlashCol5[1]
	DBM.Options.SpecialWarningFlashCol5[2] = DBM.DefaultOptions.SpecialWarningFlashCol5[2]
	DBM.Options.SpecialWarningFlashCol5[3] = DBM.DefaultOptions.SpecialWarningFlashCol5[3]
	DBM.Options.SpecialWarningFlashDura1 = DBM.DefaultOptions.SpecialWarningFlashDura1
	DBM.Options.SpecialWarningFlashDura2 = DBM.DefaultOptions.SpecialWarningFlashDura2
	DBM.Options.SpecialWarningFlashDura3 = DBM.DefaultOptions.SpecialWarningFlashDura3
	DBM.Options.SpecialWarningFlashDura4 = DBM.DefaultOptions.SpecialWarningFlashDura4
	DBM.Options.SpecialWarningFlashDura5 = DBM.DefaultOptions.SpecialWarningFlashDura5
	DBM.Options.SpecialWarningFlashAlph1 = DBM.DefaultOptions.SpecialWarningFlashAlph1
	DBM.Options.SpecialWarningFlashAlph2 = DBM.DefaultOptions.SpecialWarningFlashAlph2
	DBM.Options.SpecialWarningFlashAlph3 = DBM.DefaultOptions.SpecialWarningFlashAlph3
	DBM.Options.SpecialWarningFlashAlph4 = DBM.DefaultOptions.SpecialWarningFlashAlph4
	DBM.Options.SpecialWarningFlashAlph5 = DBM.DefaultOptions.SpecialWarningFlashAlph5
	DBM.Options.SpecialWarningPoint = DBM.DefaultOptions.SpecialWarningPoint
	DBM.Options.SpecialWarningX = DBM.DefaultOptions.SpecialWarningX
	DBM.Options.SpecialWarningY = DBM.DefaultOptions.SpecialWarningY
	-- Set UI visuals
	check1:SetChecked(DBM.Options.SWarnClassColor)
	check2:SetChecked(DBM.Options.SWarningAlphabetical)
	check3:SetChecked(DBM.Options.ShowSWarningsInChat)
	check4:SetChecked(DBM.Options.SWarnNameInNote)
	check5:SetChecked(DBM.Options.SpecialWarningIcon)
	check6:SetChecked(DBM.Options.SpecialWarningShortText)
	FontDropDown:SetSelectedValue(DBM.Options.SpecialWarningFont)
	SpecialWarnSoundDropDown:SetSelectedValue(DBM.Options.SpecialWarningSound)
	SpecialWarnSoundDropDown2:SetSelectedValue(DBM.Options.SpecialWarningSound2)
	SpecialWarnSoundDropDown3:SetSelectedValue(DBM.Options.SpecialWarningSound3)
	SpecialWarnSoundDropDown4:SetSelectedValue(DBM.Options.SpecialWarningSound4)
	SpecialWarnSoundDropDown5:SetSelectedValue(DBM.Options.SpecialWarningSound5)
	fontSizeSlider:SetValue(DBM.DefaultOptions.SpecialWarningFontSize2)
	color0:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
	color1:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
	color2:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
	color3:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
	color4:SetColorRGB(DBM.Options.SpecialWarningFlashCol4[1], DBM.Options.SpecialWarningFlashCol4[2], DBM.Options.SpecialWarningFlashCol4[3])
	color5:SetColorRGB(DBM.Options.SpecialWarningFlashCol5[1], DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3])
	flashCheck1:SetChecked(DBM.Options.SpecialWarningFlash1)
	flashCheck2:SetChecked(DBM.Options.SpecialWarningFlash2)
	flashCheck3:SetChecked(DBM.Options.SpecialWarningFlash3)
	flashCheck4:SetChecked(DBM.Options.SpecialWarningFlash4)
	flashCheck5:SetChecked(DBM.Options.SpecialWarningFlash5)
	flashdurSlider:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura1)
	flashdurSlider2:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura2)
	flashdurSlider3:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura3)
	flashdurSlider4:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura4)
	flashdurSlider5:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura5)
	flashdalphaSlider:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph1)
	flashdalphaSlider2:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph2)
	flashdalphaSlider3:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph3)
	flashdalphaSlider4:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph4)
	flashdalphaSlider5:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph5)
	flashRepSlider:SetValue(DBM.DefaultOptions.SpecialWarningFlashCount1)
	flashRepSlider2:SetValue(DBM.DefaultOptions.SpecialWarningFlashCount2)
	flashRepSlider3:SetValue(DBM.DefaultOptions.SpecialWarningFlashCount3)
	flashRepSlider4:SetValue(DBM.DefaultOptions.SpecialWarningFlashCount4)
	flashRepSlider5:SetValue(DBM.DefaultOptions.SpecialWarningFlashCount5)
	DBM:UpdateSpecialWarningOptions()
end)
