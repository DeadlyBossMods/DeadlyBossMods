local L		= DBM_GUI_L

DBM_GUI.Cat_Alerts = DBM_GUI:CreateNewPanel(L.TabCategory_Alerts, "option")

local AlertsArea1		= DBM_GUI.Cat_Alerts:CreateArea(L.Area_BasicSetup)
AlertsArea1:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips|r", nil, true, nil, "LEFT")
AlertsArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BasicSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips")
end)

local AlertsArea2		= DBM_GUI.Cat_Alerts:CreateArea(L.Area_SpecAnnounceConfig)
AlertsArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Special-Announce-Sound-Config|r", nil, true, nil, "LEFT")
AlertsArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_SpecAnnounceConfig, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Special-Announce-Sound-Config")
end)

local AlertsArea3		= DBM_GUI.Cat_Alerts:CreateArea(L.Area_SpecAnnounceNotes)
AlertsArea3:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Notes|r", nil, true, nil, "LEFT")
AlertsArea3.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_SpecAnnounceNotes, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-Notes")
end)

local AlertsArea4		= DBM_GUI.Cat_Alerts:CreateArea(L.Area_VoicePackInfo)
AlertsArea4:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-&-Voicepacks|r", nil, true, nil, "LEFT")
AlertsArea4.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_VoicePackInfo, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-&-Voicepacks")
end)
