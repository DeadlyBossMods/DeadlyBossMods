DBM_GUI.Cat_General = DBM_GUI:CreateNewPanel(DBM_GUI_L.TabCategory_Options, "option")

--This is still needed in first options panel to load to avoid model viewer errors
if DBM.Options.EnableModels then
	local mobstyle = CreateFrame("PlayerModel", "DBM_BossPreview", _G["DBM_GUI_OptionsFramePanelContainer"])
	mobstyle:SetPoint("BOTTOMRIGHT", "DBM_GUI_OptionsFramePanelContainer", "BOTTOMRIGHT", -5, 5)
	mobstyle:SetSize(300, 230)
	mobstyle:SetPortraitZoom(0.4)
	mobstyle:SetRotation(0)
	mobstyle:SetClampRectInsets(0, 0, 24, 0)
end

--if an area doesn't exist on a catagory, then clicking category continues showing previous panel.
--This creates an empty area for time being to at least empty panel out when clicking cat headrers
--TODO, maybe Add Text blocks to each cat explaining how to get most out of each area, maybe add links to github wiki to each
local emptyArea = DBM_GUI.Cat_General:CreateArea("")
