local L = DBM_GUI_L
local panel = DBM_GUI_Frames:CreateNewPanel(L.Panel_Nameplates, "option")

local general = panel:CreateArea(L.Area_General)

general:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
general:CreateCheckButton(L.UseNameplateHandoff, true, nil, "UseNameplateHandoff")

local style = panel:CreateArea(L.Area_Style)

local auraSizeSlider = style:CreateSlider(L.NPAuraSize, 20, 80, 1, 150)
auraSizeSlider:SetPoint("TOPLEFT", style.frame, "TOPLEFT", 0, -20)
auraSizeSlider:SetValue(DBM.Options.NPAuraSize)
auraSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.NPAuraSize = self:GetValue()
end)
