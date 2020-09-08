local L		= DBM_GUI_L

DBM_GUI.Cat_General = DBM_GUI:CreateNewPanel(L.TabCategory_Options, "option")

--This is still needed in first options panel to load to avoid model viewer errors
if DBM.Options.EnableModels then
	local mobstyle = CreateFrame("PlayerModel", "DBM_BossPreview", _G["DBM_GUI_OptionsFramePanelContainer"])
	mobstyle:SetPoint("BOTTOMRIGHT", "DBM_GUI_OptionsFramePanelContainer", "BOTTOMRIGHT", -5, 5)
	mobstyle:SetSize(300, 230)
	mobstyle:SetPortraitZoom(0.4)
	mobstyle:SetRotation(0)
	mobstyle:SetClampRectInsets(0, 0, 24, 0)
end

local GeneralArea1		= DBM_GUI.Cat_General:CreateArea(L.Area_BasicSetup)
GeneralArea1:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips|r", nil, true, nil, "LEFT")
GeneralArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BasicSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips")
end)

local GeneralArea2		= DBM_GUI.Cat_General:CreateArea(L.Area_ModulesForYou)
GeneralArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-What-Modules-are-for-you|r", nil, true, nil, "LEFT")
GeneralArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_ModulesForYou, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-What-Modules-are-for-you")
end)

local GeneralArea3		= DBM_GUI.Cat_General:CreateArea(L.Area_ProfilesSetup)
GeneralArea3:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Profiles|r", nil, true, nil, "LEFT")
GeneralArea3.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_ProfilesSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Profiles")
end)
