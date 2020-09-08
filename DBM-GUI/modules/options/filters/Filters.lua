local L		= DBM_GUI_L

DBM_GUI.Cat_Filters = DBM_GUI:CreateNewPanel(L.TabCategory_Filters, "option")

local FiltersArea1		= DBM_GUI.Cat_Filters:CreateArea(L.Area_BasicSetup)
FiltersArea1:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips|r", nil, true, nil, "LEFT")
FiltersArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BasicSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNew-User-Guide%5D-Initial-Setup-Tips")
end)

local FiltersArea2		= DBM_GUI.Cat_Filters:CreateArea(L.Area_DBMFiltersSetup)
FiltersArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Global-Filter-Options|r", nil, true, nil, "LEFT")
FiltersArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_DBMFiltersSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Global-Filter-Options")
end)

--[[
--Article doesn't exist yet
local FiltersArea3		= DBM_GUI.Cat_Filters:CreateArea(L.Area_BlizzFiltersSetup)
FiltersArea2:CreateText("|cFF73C2FBhttps://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Global-Filter-Options|r", nil, true, nil, "LEFT")
FiltersArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BlizzFiltersSetup, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BGuide%5D-DBM-Global-Filter-Options")
end)
--]]
