local L = DBM_GUI_L

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_Behavior, "option")

local BarBehaviors = BarSetupPanel:CreateArea(L.AreaTitle_Behavior)

-- Functions for bar setup
local function createDBTOnValueChangedHandler(option)
	return function(self)
		DBM.Bars:SetOption(option, self:GetValue())
		self:SetValue(DBM.Bars:GetOption(option))
	end
end

local DecimalSlider = BarBehaviors:CreateSlider(L.Bar_Decimal, 1, 60, 1)
DecimalSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 20, -25)
DecimalSlider:SetValue(DBM.Bars:GetOption("TDecimal"))
DecimalSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("TDecimal"))

local EnlargeTimeSlider = BarBehaviors:CreateSlider(L.Bar_EnlargeTime, 6, 30, 1)
EnlargeTimeSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 230, -25)
EnlargeTimeSlider:SetValue(DBM.Bars:GetOption("EnlargeBarTime"))
EnlargeTimeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("EnlargeBarTime"))
EnlargeTimeSlider.myheight = 0

local ClickThrough = BarBehaviors:CreateCheckButton(L.ClickThrough, true, nil, nil, "ClickThrough")
ClickThrough:SetPoint("TOPLEFT", DecimalSlider, "BOTTOMLEFT", 0, -15)
ClickThrough.myheight = 25

BarBehaviors:CreateCheckButton(L.BarSort, true, nil, nil, "Sort")
BarBehaviors:CreateCheckButton(L.ShortTimerText, true, nil, "ShortTimerText")
BarBehaviors:CreateCheckButton(L.StripTimerText, true, nil, nil, "StripCDText")
BarBehaviors:CreateCheckButton(L.KeepBar, true, nil, nil, "KeepBars")
BarBehaviors:CreateCheckButton(L.FadeBar, true, nil, nil, "FadeBars")
