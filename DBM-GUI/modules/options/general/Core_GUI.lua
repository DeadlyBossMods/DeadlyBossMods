local L = DBM_GUI_L

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local coreoptions = DBM_GUI.Cat_General:CreateNewPanel(L.Core_GUI, "option")

local generaloptions = coreoptions:CreateArea(L.General)

local miniMapIcon = generaloptions:CreateCheckButton(L.EnableMiniMapIcon, true)
miniMapIcon:SetScript("OnClick", function(self)
	DBM:ToggleMinimapButton()
	self:SetChecked(not DBM_MinimapIcon.hide)
end)
miniMapIcon:SetChecked(not DBM_MinimapIcon.hide)

if isRetail then
	local compartmentIcon = generaloptions:CreateCheckButton(L.EnableCompartmentIcon)
	compartmentIcon:SetScript("OnClick", function(self)
		DBM:ToggleCompartmentButton()
		self:SetChecked(DBM_MinimapIcon.showInCompartment)
	end)
	compartmentIcon:SetChecked(DBM_MinimapIcon.showInCompartment)
	compartmentIcon:SetPoint("LEFT", miniMapIcon, "RIGHT", 200, 0)
end

local soundChannelsList = {
	{
		text	= L.UseMasterChannel,
		value	= "Master"
	},
	{
		text	= L.UseDialogChannel,
		value	= "Dialog"
	},
	{
		text	= L.UseSFXChannel,
		value	= "SFX"
	}
}
local SoundChannelDropdown = generaloptions:CreateDropdown(L.UseSoundChannel, soundChannelsList, "DBM", "UseSoundChannel", function(value)
	DBM.Options.UseSoundChannel = value
end)
local isNewDropdowns = SoundChannelDropdown.mytype == "dropdown2"
SoundChannelDropdown:SetPoint("TOPLEFT", generaloptions.frame, "TOPLEFT", isNewDropdowns and 15 or 0, -55)

local bmrange = generaloptions:CreateButton(L.Button_RangeFrame, 120, 30)
bmrange:SetPoint("TOPLEFT", SoundChannelDropdown, "BOTTOMLEFT", isNewDropdowns and 0 or 15, -5)
bmrange:SetScript("OnClick", function()
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide(true)
	else
		DBM.RangeCheck:Show(nil, nil, true)
	end
end)

local bminfo = generaloptions:CreateButton(L.Button_InfoFrame, 120, 30)
bminfo.myheight = 0
bminfo:SetPoint("TOPLEFT", bmrange, "BOTTOMLEFT", 0, -2)
bminfo:SetScript("OnClick", function()
	if DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:Hide()
	else
		DBM.InfoFrame:Show(5, "test")
	end
end)

local bmtestmode = generaloptions:CreateButton(L.Button_TestBars, 120, 30)
bmtestmode.myheight = 0
bmtestmode:SetPoint("LEFT", bmrange, "RIGHT", 6, 0)
bmtestmode:SetScript("OnClick", function()
	DBM:DemoMode()
end)

local moveme = generaloptions:CreateButton(L.Button_MoveBars, 120, 30)
moveme:SetPoint("TOPLEFT", bmtestmode, "BOTTOMLEFT", 0, -2)
moveme:SetScript("OnClick", function()
	DBT:ShowMovableBar()
end)

local latencySlider = generaloptions:CreateSlider(L.Latency_Text, 50, 750, 5, 210)
latencySlider:SetPoint("TOPLEFT", bminfo, "BOTTOMLEFT", 4, -20)
latencySlider:SetValue(DBM.Options.LatencyThreshold)
latencySlider:HookScript("OnValueChanged", function(self)
	DBM.Options.LatencyThreshold = self:GetValue()
end)

local resetbutton = generaloptions:CreateButton(L.Button_ResetInfoRange, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", generaloptions.frame, "BOTTOMRIGHT", -5, 5)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	DBM.Options.InfoFrameX = DBM.DefaultOptions.InfoFrameX
	DBM.Options.InfoFrameY = DBM.DefaultOptions.InfoFrameY
	DBM.Options.InfoFramePoint = DBM.DefaultOptions.InfoFramePoint
	DBM.Options.RangeFrameX = DBM.DefaultOptions.RangeFrameX
	DBM.Options.RangeFrameY = DBM.DefaultOptions.RangeFrameY
	DBM.Options.RangeFramePoint = DBM.DefaultOptions.RangeFramePoint
	DBM.Options.RangeFrameRadarX = DBM.DefaultOptions.RangeFrameRadarX
	DBM.Options.RangeFrameRadarY = DBM.DefaultOptions.RangeFrameRadarY
	DBM.Options.RangeFrameRadarPoint = DBM.DefaultOptions.RangeFrameRadarPoint
	DBM:RepositionFrames()
end)

local modelarea = coreoptions:CreateArea(L.ModelOptions)

modelarea:CreateCheckButton(L.EnableModels, true, nil, "EnableModels")

local modelSounds = {
	{
		text	= L.NoSound,
		value	= ""
	},
	{
		text	= L.ModelSoundShort,
		value	= "Short"
	},
	{
		text	= L.ModelSoundLong,
		value	= "Long"
	}
}
local ModelSoundDropDown = modelarea:CreateDropdown(L.ModelSoundOptions, modelSounds, "DBM", "ModelSoundValue", function(value)
	DBM.Options.ModelSoundValue = value
end)
ModelSoundDropDown.myheight = 40
ModelSoundDropDown:SetPoint("TOPLEFT", modelarea.frame, "TOPLEFT", isNewDropdowns and 15 or 0, -50)

local resizeOptions = coreoptions:CreateArea(L.ResizeOptions)

resizeOptions:CreateText(L.ResizeInfo, nil, true)

local optionsFrame = _G["DBM_GUI_OptionsFrame"]

local resetbutton2 = resizeOptions:CreateButton(L.Button_ResetWindowSize, 120, 16)
resetbutton2:SetPoint("BOTTOMRIGHT", resizeOptions.frame, "BOTTOMRIGHT", -5, 5)
resetbutton2:SetNormalFontObject(GameFontNormalSmall)
resetbutton2:SetHighlightFontObject(GameFontNormalSmall)
resetbutton2:SetScript("OnClick", function()
	DBM.Options.GUIWidth = DBM.DefaultOptions.GUIWidth
	DBM.Options.GUIHeight = DBM.DefaultOptions.GUIHeight
	optionsFrame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
end)

local minWidth, minHeight, maxWidth, maxHeight = optionsFrame:GetResizeBounds()

local resizeWidth = resizeOptions:CreateEditBox(L.Editbox_WindowWidth, math.floor(DBM.Options.GUIWidth * 10 ^ 2 + 0.5) / 10 ^ 2)
resizeWidth:SetPoint("TOPLEFT", 20, -40)
resizeWidth:SetScript("OnChar", function(self)
	self:SetText(self:GetText():gsub("[^%.%d]", ""))
end)
resizeWidth:SetScript("OnEnterPressed", function(self)
	local value = tonumber(self:GetText()) or 0
	if value < minWidth then
		self:SetText(minWidth)
		return
	end
	if value > maxWidth then
		self:SetText(maxWidth)
	end
	DBM.Options.GUIWidth = value
	optionsFrame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
end)

local resizeHeight = resizeOptions:CreateEditBox(L.Editbox_WindowHeight, math.floor(DBM.Options.GUIHeight * 10 ^ 2 + 0.5) / 10 ^ 2)
resizeHeight.myheight = 10
resizeHeight:SetPoint("LEFT", resizeWidth, "RIGHT", 40, 0)
resizeHeight:SetScript("OnChar", function(self)
	self:SetText(self:GetText():gsub("[^%.%d]", ""))
end)
resizeHeight:SetScript("OnEnterPressed", function(self)
	local value = tonumber(self:GetText()) or 0
	if value < minHeight then
		self:SetText(minHeight)
		return
	end
	if value > maxHeight then
		self:SetText(maxHeight)
	end
	DBM.Options.GUIHeight = value
	optionsFrame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
end)

optionsFrame:HookScript("OnSizeChanged", function(self)
	resizeWidth:SetText(tostring(math.floor(self:GetWidth() * 10 ^ 2 + 0.5) / 10 ^ 2))
	resizeHeight:SetText(tostring(math.floor(self:GetHeight() * 10 ^ 2 + 0.5) / 10 ^ 2))
end)

local UIGroupingOptions = coreoptions:CreateArea(L.UIGroupingOptions)
UIGroupingOptions:CreateCheckButton(L.GroupOptionsExcludeIcon, true, nil, "GroupOptionsExcludeIcon")
UIGroupingOptions:CreateCheckButton(L.GroupOptionsExcludePrivateAura, true, nil, "GroupOptionsExcludePA")
UIGroupingOptions:CreateCheckButton(L.AutoExpandSpellGroups, true, nil, "AutoExpandSpellGroups")
UIGroupingOptions:CreateCheckButton(L.ShowWAKeys, true, nil, "ShowWAKeys")
--UIGroupingOptions:CreateCheckButton(L.ShowSpellDescWhenExpanded, true, nil, "ShowSpellDescWhenExpanded")
