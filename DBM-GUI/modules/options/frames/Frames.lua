local L		= DBM_GUI_L

DBM_GUI.Cat_Frames = DBM_GUI:CreateNewPanel(L.TabCategory_Frames, "option")

local FramesArea1		= DBM_GUI.Cat_Frames:CreateArea(L.Area_BasicSetup)
FramesArea1:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips|r", nil, true, nil, "LEFT")
FramesArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BasicSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips")
end)

local FramesArea2		= DBM_GUI.Cat_Frames:CreateArea(L.Area_NamelateInfo)
FramesArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Nameplate-Auras|r", nil, true, nil, "LEFT")
FramesArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_NamelateInfo, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Nameplate-Auras")
end)
