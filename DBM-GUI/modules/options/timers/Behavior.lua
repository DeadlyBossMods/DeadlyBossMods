local L = DBM_GUI_L

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_Behavior, "option")

local BarBehaviors = BarSetupPanel:CreateArea(L.AreaTitle_Behavior)
local movemebutton = BarBehaviors:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", BarBehaviors.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function()
	DBT:ShowMovableBar()
end)

local testmebutton = BarBehaviors:CreateButton(L.Button_TestBars, 100, 16)
testmebutton:SetPoint("BOTTOMRIGHT", BarBehaviors.frame, "BOTTOMRIGHT", -2, 4)
testmebutton:SetNormalFontObject(GameFontNormalSmall)
testmebutton:SetHighlightFontObject(GameFontNormalSmall)
testmebutton:SetScript("OnClick", function()
	DBM:DemoMode()
end)

-- Functions for bar setup
local function createDBTOnValueChangedHandler(option)
	return function(self)
		DBT:SetOption(option, self:GetValue())
		self:SetValue(DBT.Options[option])
	end
end

local DecimalSlider = BarBehaviors:CreateSlider(L.Bar_Decimal, 1, 60, 1)
DecimalSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 20, -25)
DecimalSlider:SetValue(DBT.Options.TDecimal)
DecimalSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("TDecimal"))

local EnlargeTimeSlider = BarBehaviors:CreateSlider(L.Bar_EnlargeTime, 6, 30, 1)
EnlargeTimeSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 230, -25)
EnlargeTimeSlider:SetValue(DBT.Options.EnlargeBarTime)
EnlargeTimeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("EnlargeBarTime"))
EnlargeTimeSlider.myheight = 0

local BarsHiddenSlider = BarBehaviors:CreateSlider(L.Bar_AppearTime, 60, 600, 1)
BarsHiddenSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 20, -75)
BarsHiddenSlider:SetValue(DBT.Options.HiddenBarTime)
BarsHiddenSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HiddenBarTime"))

local HiddenBarsToggle = BarBehaviors:CreateCheckButton(L.Bar_HideLongBars, true, nil, nil, "HideLongBars")
HiddenBarsToggle:SetPoint("TOPLEFT", DecimalSlider, "BOTTOMLEFT", 0, -65)

BarBehaviors:CreateCheckButton(L.ClickThrough, true, nil, nil, "ClickThrough")
BarBehaviors:CreateCheckButton(L.DisableRightClickBar, true, nil, nil, "DisableRightClick")
--Can't rename spells in midnight
--Won't keep timers in midnight (they follow timeline)
--Can't distance check in midnight, so can't fade by distance
if not DBM:IsPostMidnight() then
	BarBehaviors:CreateCheckButton(L.ShortTimerText, true, nil, "ShortTimerText")
	BarBehaviors:CreateCheckButton(L.KeepBar, true, nil, nil, "KeepBars")
	BarBehaviors:CreateCheckButton(L.FadeBar, true, nil, nil, "FadeBars")
end
