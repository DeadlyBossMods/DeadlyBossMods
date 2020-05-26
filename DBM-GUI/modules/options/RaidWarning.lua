local L		= DBM_GUI_L
local CL	= DBM_CORE_L

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

local RaidWarningPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_RaidWarning, "option")

local raidwarnoptions = RaidWarningPanel:CreateArea(L.RaidWarning_Header, 375)

raidwarnoptions:CreateCheckButton(L.ShowWarningsInChat, true, nil, "ShowWarningsInChat")
raidwarnoptions:CreateCheckButton(L.WarningIconLeft, true, nil, "WarningIconLeft")
raidwarnoptions:CreateCheckButton(L.WarningIconRight, true, nil, "WarningIconRight")
raidwarnoptions:CreateCheckButton(L.WarningIconChat, true, nil, "WarningIconChat")
raidwarnoptions:CreateCheckButton(L.WarningAlphabetical, true, nil, "WarningAlphabetical")
local WarningShortText		= raidwarnoptions:CreateCheckButton(L.ShortTextSpellname, true, nil, "WarningShortText")

-- RaidWarn Font
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

local FontDropDown = raidwarnoptions:CreateDropdown(L.Warn_FontType, Fonts, "DBM", "WarningFont", function(value)
	DBM.Options.WarningFont = value
	DBM:UpdateWarningOptions()
	DBM:AddWarning(CL.MOVE_WARNING_MESSAGE)
end)
FontDropDown:SetPoint("TOPLEFT", WarningShortText, "BOTTOMLEFT", 0, -10)

-- RaidWarn Font Style
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

local FontStyleDropDown = raidwarnoptions:CreateDropdown(L.Warn_FontStyle, FontStyles, "DBM", "WarningFontStyle", function(value)
	DBM.Options.WarningFontStyle = value
	DBM:UpdateWarningOptions()
	DBM:AddWarning(CL.MOVE_WARNING_MESSAGE)
end)
FontStyleDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, -10)

-- RaidWarn Font Shadow
local FontShadow = raidwarnoptions:CreateCheckButton(L.Warn_FontShadow, nil, nil, "WarningFontShadow")
FontShadow:SetScript("OnClick", function()
	DBM.Options.WarningFontShadow = not DBM.Options.WarningFontShadow
	DBM:UpdateWarningOptions()
	DBM:AddWarning(CL.MOVE_WARNING_MESSAGE)
end)
FontShadow:SetPoint("LEFT", FontStyleDropDown, "RIGHT", 35, 0)

-- RaidWarn Sound
local Sounds = DBM_GUI:MixinSharedMedia3("sound", {
	{
		text	= L.NoSound,
		value	= ""
	},
	{
		text	= "RaidWarning",
		value	= 8959 -- "Sound\\interface\\RaidWarning.ogg"
	},
	{
		text	= "Classic",
		value	= 11742 -- "Sound\\Doodad\\BellTollNightElf.ogg"
	},
	{
		text	= "Ding",
		value	= 12889 -- "Sound\\interface\\AlarmClockWarning3.ogg"
	}
})

local RaidWarnSoundDropDown = raidwarnoptions:CreateDropdown(L.RaidWarnSound, Sounds, "DBM", "RaidWarningSound", function(value)
	DBM.Options.RaidWarningSound = value
end)
RaidWarnSoundDropDown:SetPoint("TOPLEFT", FontStyleDropDown, "BOTTOMLEFT", 0, -10)

-- RaidWarn Font Size
local fontSizeSlider = raidwarnoptions:CreateSlider(L.Warn_FontSize, 8, 60, 1, 200)
fontSizeSlider:SetPoint("TOPLEFT", FontDropDown, "TOPLEFT", 20, -130)
fontSizeSlider:SetValue(DBM.Options.WarningFontSize)
fontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.WarningFontSize = self:GetValue()
	DBM:UpdateWarningOptions()
	DBM:AddWarning(CL.MOVE_WARNING_MESSAGE)
end)

-- RaidWarn Duration
local durationSlider = raidwarnoptions:CreateSlider(L.Warn_Duration, 1, 10, 0.5, 200)
durationSlider:SetPoint("TOPLEFT", FontDropDown, "TOPLEFT", 20, -170)
durationSlider:SetValue(DBM.Options.WarningDuration2)
durationSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.WarningDuration2 = self:GetValue()
	DBM:UpdateWarningOptions()
	DBM:AddWarning(CL.MOVE_WARNING_MESSAGE)
end)

local movemebutton = raidwarnoptions:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", raidwarnoptions.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function() DBM:MoveWarning() end)

--Raid Warning Colors
local raidwarncolors = RaidWarningPanel:CreateArea(L.RaidWarnColors, 150)

local color1 = raidwarncolors:CreateColorSelect(64)
local color2 = raidwarncolors:CreateColorSelect(64)
local color3 = raidwarncolors:CreateColorSelect(64)
local color4 = raidwarncolors:CreateColorSelect(64)
local color1text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64)
local color2text = raidwarncolors:CreateText(L.RaidWarnColor_2, 64)
local color3text = raidwarncolors:CreateText(L.RaidWarnColor_3, 64)
local color4text = raidwarncolors:CreateText(L.RaidWarnColor_4, 64)
local color1reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
local color2reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
local color3reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
local color4reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)

color1:SetPoint("TOPLEFT", 30, -10)
color2:SetPoint("TOPLEFT", color1, "TOPRIGHT", 30, 0)
color3:SetPoint("TOPLEFT", color2, "TOPRIGHT", 30, 0)
color4:SetPoint("TOPLEFT", color3, "TOPRIGHT", 30, 0)

local function UpdateColor(self)
	local r, g, b = self:GetColorRGB()
	self.textid:SetTextColor(r, g, b)
	DBM.Options.WarningColors[self.myid].r = r
	DBM.Options.WarningColors[self.myid].g = g
	DBM.Options.WarningColors[self.myid].b = b
end
local function ResetColor(id, frame)
	return function()
		DBM.Options.WarningColors[id].r = DBM.DefaultOptions.WarningColors[id].r
		DBM.Options.WarningColors[id].g = DBM.DefaultOptions.WarningColors[id].g
		DBM.Options.WarningColors[id].b = DBM.DefaultOptions.WarningColors[id].b
		frame:SetColorRGB(DBM.Options.WarningColors[id].r, DBM.Options.WarningColors[id].g, DBM.Options.WarningColors[id].b)
	end
end
local function UpdateColorFrames(color, text, rset, id)
	color.textid = text
	color.myid = id
	color:SetScript("OnColorSelect", UpdateColor)
	color:SetColorRGB(DBM.Options.WarningColors[id].r, DBM.Options.WarningColors[id].g, DBM.Options.WarningColors[id].b)
	text:SetPoint("TOPLEFT", color, "BOTTOMLEFT", 3, -10)
	text:SetJustifyH("CENTER")
	rset:SetPoint("TOP", text, "BOTTOM", 0, -5)
	rset:SetScript("OnClick", ResetColor(id, color))
end
UpdateColorFrames(color1, color1text, color1reset, 1)
UpdateColorFrames(color2, color2text, color2reset, 2)
UpdateColorFrames(color3, color3text, color3reset, 3)
UpdateColorFrames(color4, color4text, color4reset, 4)

local infotext = raidwarncolors:CreateText(L.InfoRaidWarning, 380, false, GameFontNormalSmall, "LEFT")
infotext:SetPoint("BOTTOMLEFT", raidwarncolors.frame, "BOTTOMLEFT", 10, 10)
