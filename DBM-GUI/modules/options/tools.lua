local L		= DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

DBM_GUI.CAT_TOOLS = DBM_GUI:CreateNewPanel("TOOLS", "tools")

DBM_GUI.tabs[6].buttons[1].hidden = true -- Hide the category

local area		= DBM_GUI.CAT_TOOLS:CreateArea(L.OTabTools)

local latency = area:CreateButton(L.Tools_LatencyCheck, 120, 30)
latency:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10)
latency:SetScript("OnClick", function()
	DBM.Latency:Show()
end)

