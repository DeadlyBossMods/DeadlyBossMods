local L = DBM_GUI_L
local panel = DBM_GUI_Frames:CreateNewPanel(L.Panel_Range, "option")

local general = panel:CreateArea(L.Area_General)

general:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
