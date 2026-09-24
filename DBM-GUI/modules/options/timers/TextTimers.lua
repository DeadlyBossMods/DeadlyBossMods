local L = DBM_GUI_L
local options = DBM.Options
local display = assert(DBM.TextTimers)

local panel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_TextTimers, "option")
local general = panel:CreateArea(L.Area_TextTimers)

local move = general:CreateButton(L.MoveMe, 100, 16)
move:SetPoint("TOPRIGHT", general.frame, "TOPRIGHT", -2, -4)
move.myheight = 0
move:SetNormalFontObject(GameFontNormalSmall)
move:SetHighlightFontObject(GameFontNormalSmall)
move:SetScript("OnClick", function()
	DBM_GUI:CollapseForPreview(display:TogglePreview(true))
end)

local enabled = general:CreateCheckButton(L.TextTimersEnable, true, nil, "TextTimersEnabled")
enabled:HookScript("OnClick", function(self)
	display:SetEnabled(self:GetChecked())
end)
local icon = general:CreateCheckButton(L.TextTimersIcon, true, nil, "TextTimersIcon")
icon:HookScript("OnClick", function() display:RefreshStyle() end)

local sliders = {}
local function addSlider(label, option, low, high, step)
	local slider = general:CreateSlider(label, low, high, step, 175, options[option], function(value)
		DBM.Options[option] = value
		display:RefreshStyle()
	end)
	slider.textFrame:SetWidth(290)
	sliders[#sliders + 1] = {slider, option}
	return slider
end

local threshold = addSlider(L.TextTimersThreshold, "TextTimersThreshold", 1, 15, 0.5)
threshold:SetPoint("TOPLEFT", general.frame, "TOPLEFT", 50, -105)
threshold.myheight = 60
local maxLines = addSlider(L.TextTimersMaxLines, "TextTimersMaxLines", 1, 10, 1)
maxLines:SetPoint("TOPLEFT", threshold, "TOPLEFT", 250, 0)
maxLines.myheight = 0
local nameLength = addSlider(L.TextTimersMaxNameLength, "TextTimersMaxNameLength", 0, 40, 1)
nameLength:SetPoint("TOPLEFT", threshold, "BOTTOMLEFT", 0, -35)
nameLength.myheight = 50
local fontSize = addSlider(L.TextTimersFontSize, "TextTimersFontSize", 8, 40, 1)
fontSize:SetPoint("TOPLEFT", maxLines, "BOTTOMLEFT", 0, -35)
fontSize.myheight = 0
local urgentThreshold = addSlider(L.TextTimersUrgentThreshold, "TextTimersUrgentThreshold", 0, 15, 0.5)
urgentThreshold:SetPoint("TOPLEFT", nameLength, "BOTTOMLEFT", 0, -35)
urgentThreshold.myheight = 50

local urgent = general:CreateColorSelect(L.TextTimersUrgentColor, function(_, r, g, b)
	DBM.Options.TextTimersUrgentR = r
	DBM.Options.TextTimersUrgentG = g
	DBM.Options.TextTimersUrgentB = b
	display:RefreshStyle()
end)
urgent:SetPoint("TOPLEFT", fontSize, "BOTTOMLEFT", 0, -35)
urgent:SetWidth(250)
urgent.myheight = 0

local iconPosition = general:CreateDropdown(L.TextTimersIconPosition, {
	{text = L.BarIconLeft, value = "LEFT"},
	{text = L.BarIconRight, value = "RIGHT"},
}, "DBM", "TextTimersIconPosition", function(value)
	DBM.Options.TextTimersIconPosition = value
	display:RefreshStyle()
end)
iconPosition:SetPoint("TOPLEFT", urgentThreshold, "BOTTOMLEFT", 0, -40)
iconPosition.myheight = 90

local fonts = DBM_GUI:MixinSharedMedia3("font", {
	{text = DEFAULT, value = "standardFont"},
})
local font = general:CreateDropdown(L.FontType, fonts, "DBM", "TextTimersFont", function(value)
	DBM.Options.TextTimersFont = value
	display:RefreshStyle()
end)
font:SetPoint("TOPLEFT", iconPosition, "TOPLEFT", 250, 0)
font.myheight = 0

local reset = general:CreateButton(L.SpecWarn_ResetMe, 120, 16)
reset:SetPoint("BOTTOMRIGHT", general.frame, "BOTTOMRIGHT", -2, 4)
reset:SetNormalFontObject(GameFontNormalSmall)
reset:SetHighlightFontObject(GameFontNormalSmall)
reset.myheight = 0

local function refreshControls()
	options = DBM.Options
	enabled:SetChecked(options.TextTimersEnabled)
	icon:SetChecked(options.TextTimersIcon)
	urgent:SetColorRGB(options.TextTimersUrgentR, options.TextTimersUrgentG, options.TextTimersUrgentB)
	for _, entry in ipairs(sliders) do
		entry[1]:SetValue(options[entry[2]])
	end
	iconPosition:SetSelectedValue(options.TextTimersIconPosition)
	font:SetSelectedValue(options.TextTimersFont)
end

reset:SetScript("OnClick", function()
	for _, option in ipairs({
		"TextTimersEnabled", "TextTimersThreshold", "TextTimersMaxLines", "TextTimersMaxNameLength",
		"TextTimersFont", "TextTimersFontSize", "TextTimersUrgentThreshold", "TextTimersUrgentR",
		"TextTimersUrgentG", "TextTimersUrgentB", "TextTimersIcon", "TextTimersIconPosition",
	}) do
		DBM.Options[option] = DBM.DefaultOptions[option]
	end
	display:ResetPosition()
	display:SyncOptions()
	refreshControls()
end)
general.frame:HookScript("OnShow", refreshControls)

panel.frame:HookScript("OnHide", function()
	-- Collapsing the GUI also hides this panel; keep the preview running.
	if not _G["DBM_GUI_OptionsFrame"].collapsed then display:HidePreview() end
end)

_G["DBM_GUI_OptionsFrame"]:HookScript("OnHide", function()
	display:HidePreview()
end)
