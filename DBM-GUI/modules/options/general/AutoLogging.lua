local L = DBM_GUI_L
local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local autoLogPanel	= DBM_GUI.Cat_General:CreateNewPanel(L.Panel_AutoLogging, "option")

local bossLoggingArea		= autoLogPanel:CreateArea(L.Area_AutoLogging)
bossLoggingArea:CreateCheckButton(L.AutologBosses, true, nil, "AutologBosses")
if _G["Transcriptor"] then
	bossLoggingArea:CreateCheckButton(L.AdvancedAutologBosses, true, nil, "AdvancedAutologBosses")
end

local bossLoggingFilters		= autoLogPanel:CreateArea(L.Area_AutoLoggingFilters)
bossLoggingFilters:CreateCheckButton(L.RecordOnlyBosses, true, nil, "RecordOnlyBosses")
bossLoggingFilters:CreateCheckButton(L.DoNotLogLFG, true, nil, "DoNotLogLFG")

local bossLoggingContent		= autoLogPanel:CreateArea(L.Area_AutoLoggingContent)
if isRetail then
	bossLoggingContent:CreateCheckButton(L.LogCurrentMythicRaids, true, nil, "LogCurrentMythicRaids")
end
bossLoggingContent:CreateCheckButton(L.LogCurrentRaids, true, nil, "LogCurrentRaids")
if isRetail then
	bossLoggingContent:CreateCheckButton(L.LogTWRaids, true, nil, "LogTWRaids")
end
bossLoggingContent:CreateCheckButton(L.LogTrivialRaids, true, nil, "LogTrivialRaids")
if isRetail then
	bossLoggingContent:CreateCheckButton(L.LogCurrentMPlus, true, nil, "LogCurrentMPlus")
	bossLoggingContent:CreateCheckButton(L.LogCurrentMythicZero, true, nil, "LogCurrentMythicZero")
	bossLoggingContent:CreateCheckButton(L.LogTWDungeons, true, nil, "LogTWDungeons")
end
bossLoggingContent:CreateCheckButton(L.LogCurrentHeroic, true, nil, "LogCurrentHeroic")
