DBM_GUI_Frame = DBM_GUI:CreateNewPanel(DBM_GUI_L.TabCategory_Options, "option")

if DBM.Options.EnableModels then
	local mobstyle = CreateFrame("PlayerModel", "DBM_BossPreview", _G["DBM_GUI_OptionsFramePanelContainer"])
	mobstyle:SetPoint("BOTTOMRIGHT", "DBM_GUI_OptionsFramePanelContainer", "BOTTOMRIGHT", -5, 5)
	mobstyle:SetSize(300, 230)
	mobstyle:SetPortraitZoom(0.4)
	mobstyle:SetRotation(0)
	mobstyle:SetClampRectInsets(0, 0, 24, 0)
end
