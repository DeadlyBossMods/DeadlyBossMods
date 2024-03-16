local L		= DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

DBM_GUI.Cat_Timers = DBM_GUI:CreateNewPanel(L.TabCategory_Timers, "option")

local TimersArea1		= DBM_GUI.Cat_Timers:CreateArea(L.Area_BasicSetup)
TimersArea1:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips|r", nil, true)
TimersArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BasicSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips")
end)

local TimersArea2		= DBM_GUI.Cat_Timers:CreateArea(L.Area_ColorBytype)
TimersArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Color-bars-by-type|r", nil, true)
TimersArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_ColorBytype, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Color-bars-by-type")
end)
