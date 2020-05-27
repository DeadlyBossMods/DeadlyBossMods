local L = DBM_GUI_L
local generaloptions = DBM_GUI_Frame:CreateArea(L.General, 180)

local MiniMapIcon = generaloptions:CreateCheckButton(L.EnableMiniMapIcon, true)
MiniMapIcon:SetScript("OnClick", function(self)
	DBM:ToggleMinimapButton()
	self:SetChecked(not DBM_MinimapIcon.hide)
end)
MiniMapIcon:SetChecked(not DBM_MinimapIcon.hide)

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
SoundChannelDropdown:SetPoint("TOPLEFT", generaloptions.frame, "TOPLEFT", 0, -55)

local bmrange = generaloptions:CreateButton(L.Button_RangeFrame, 120, 30)
bmrange:SetPoint("TOPLEFT", SoundChannelDropdown, "BOTTOMLEFT", 15, -5)
bmrange:SetScript("OnClick", function()
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide(true)
	else
		DBM.RangeCheck:Show(nil, nil, true)
	end
end)

local bminfo = generaloptions:CreateButton(L.Button_InfoFrame, 120, 30)
bminfo:SetPoint("LEFT", bmrange, "RIGHT", 2, 0)
bminfo:SetScript("OnClick", function()
	if DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:Hide()
	else
		DBM.InfoFrame:Show(5, "test")
	end
end)

local bmtestmode = generaloptions:CreateButton(L.Button_TestBars, 150, 30)
bmtestmode:SetPoint("LEFT", bminfo, "RIGHT", 2, 0)
bmtestmode:SetScript("OnClick", function()
	DBM:DemoMode()
end)

local latencySlider = generaloptions:CreateSlider(L.Latency_Text, 50, 750, 5, 210)
latencySlider:SetPoint("BOTTOMLEFT", bmrange, "BOTTOMLEFT", 10, -40)
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

local modelarea = DBM_GUI_Frame:CreateArea(L.ModelOptions, 90)

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
ModelSoundDropDown:SetPoint("TOPLEFT", modelarea.frame, "TOPLEFT", 0, -50)

local resizeOptions = DBM_GUI_Frame:CreateArea(L.ResizeOptions, 120)

--TODO, add EDIT field lines for user manually entering pixel size of window should they choose. Some users are real OCD about pixel perfection
--This would also need a hook for ondrag to update pixel sizes in the edit boxes when window is resized

local resetbutton2 = generaloptions:CreateButton(L.Button_ResetWindowSize, 120, 16)
resetbutton2:SetPoint("BOTTOMRIGHT", resizeOptions.frame, "BOTTOMRIGHT", -5, 5)
resetbutton2:SetNormalFontObject(GameFontNormalSmall)
resetbutton2:SetHighlightFontObject(GameFontNormalSmall)
resetbutton2:SetScript("OnClick", function()
	DBM.Options.GUIWidth = DBM.DefaultOptions.GUIWidth
	DBM.Options.GUIHeight = DBM.DefaultOptions.GUIHeight
	DBM_GUI_OptionsFrame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
end)
