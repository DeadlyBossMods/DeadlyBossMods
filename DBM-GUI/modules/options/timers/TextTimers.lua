local L = DBM_GUI_L
local options = DBM.Options
local display = assert(DBM.TextTimers)

local panel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_TextTimers, "option")
local general = panel:CreateArea(L.Area_TextTimers)

local enabled = general:CreateCheckButton(L.TextTimersEnable, true, nil, "TextTimersEnabled")
enabled:HookScript("OnClick", function(self)
	display:SetEnabled(self:GetChecked())
end)

local sliders = {}
local function addSlider(label, option, low, high, step, x, y)
	local slider = general:CreateSlider(label, low, high, step, 175, options[option], function(value)
		DBM.Options[option] = value
		display:RefreshStyle()
	end)
	slider:SetPoint("TOPLEFT", general.frame, "TOPLEFT", x, y)
	sliders[#sliders + 1] = {slider, option}
	return slider
end

addSlider(L.TextTimersThreshold, "TextTimersThreshold", 1, 15, 0.5, 25, -85)
addSlider(L.TextTimersMaxLines, "TextTimersMaxLines", 1, 10, 1, 260, -85)
addSlider(L.TextTimersMaxNameLength, "TextTimersMaxNameLength", 0, 40, 1, 25, -150)
addSlider(L.TextTimersFontSize, "TextTimersFontSize", 8, 40, 1, 260, -150)
addSlider(L.TextTimersUrgentThreshold, "TextTimersUrgentThreshold", 0, 15, 0.5, 25, -215)

local urgent = general:CreateColorSelect(L.TextTimersUrgentColor, function(_, r, g, b)
	DBM.Options.TextTimersUrgentR = r
	DBM.Options.TextTimersUrgentG = g
	DBM.Options.TextTimersUrgentB = b
	display:RefreshStyle()
end)
urgent:SetPoint("TOPLEFT", general.frame, "TOPLEFT", 260, -215)
general:SetLastObj(urgent)
urgent.myheight = 70

local icon = general:CreateCheckButton(L.TextTimersIcon, true, nil, "TextTimersIcon")
icon:HookScript("OnClick", function() display:RefreshStyle() end)
local locked = general:CreateCheckButton(L.TextTimersLock, true, nil, "TextTimersLocked")
locked:HookScript("OnClick", function() display:RefreshStyle() end)

local iconPosition = general:CreateDropdown(L.TextTimersIconPosition, {
	{text = L.BarIconLeft, value = "LEFT"},
	{text = L.BarIconRight, value = "RIGHT"},
}, "DBM", "TextTimersIconPosition", function(value)
	DBM.Options.TextTimersIconPosition = value
	display:RefreshStyle()
end)
iconPosition:SetPoint("TOPLEFT", locked, "BOTTOMLEFT", 10, -20)
iconPosition.myheight = 55

local fonts = DBM_GUI:MixinSharedMedia3("font", {
	{text = DEFAULT, value = "standardFont"},
})
local font = general:CreateDropdown(L.FontType, fonts, "DBM", "TextTimersFont", function(value)
	DBM.Options.TextTimersFont = value
	display:RefreshStyle()
end)
font:SetPoint("TOPLEFT", iconPosition, "BOTTOMLEFT", 0, -20)
font.myheight = 65

local preview = general:CreateButton(L.TextTimersTest, 130, 20, function()
	DBM_GUI:CollapseForPreview(display:TogglePreview())
end)
preview:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 10, -20)
preview.myheight = 35
local reset = general:CreateButton(L.TextTimersReset, 130, 20, function()
	display:ResetPosition()
end)
reset:SetPoint("LEFT", preview, "RIGHT", 15, 0)
reset.myheight = 0

general.frame:HookScript("OnShow", function()
	options = DBM.Options
	enabled:SetChecked(options.TextTimersEnabled)
	icon:SetChecked(options.TextTimersIcon)
	locked:SetChecked(options.TextTimersLocked)
	urgent:SetColorRGB(options.TextTimersUrgentR, options.TextTimersUrgentG, options.TextTimersUrgentB)
	for _, entry in ipairs(sliders) do
		entry[1]:SetValue(options[entry[2]])
	end
	iconPosition:SetSelectedValue(options.TextTimersIconPosition)
	font:SetSelectedValue(options.TextTimersFont)
end)

panel.frame:HookScript("OnHide", function()
	-- Collapsing the GUI also hides this panel; keep the preview running.
	if not _G["DBM_GUI_OptionsFrame"].collapsed then display:HidePreview() end
end)

_G["DBM_GUI_OptionsFrame"]:HookScript("OnHide", function()
	display:HidePreview()
end)
