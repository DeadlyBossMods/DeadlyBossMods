local L = DBM_GUI_L
local generalWarningPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_GeneralMessages, "option")

local generalCoreArea = generalWarningPanel:CreateArea(L.CoreMessages)
generalCoreArea:CreateCheckButton(L.ShowPizzaMessage, true, nil, "ShowPizzaMessage")
generalCoreArea:CreateCheckButton(L.ShowAllVersions, true, nil, "ShowAllVersions")

local generalMessagesArea = generalWarningPanel:CreateArea(L.CombatMessages)
generalMessagesArea:CreateCheckButton(L.ShowEngageMessage, true, nil, "ShowEngageMessage")
generalMessagesArea:CreateCheckButton(L.ShowDefeatMessage, true, nil, "ShowDefeatMessage")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessages, true, nil, "ShowGuildMessages")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessagesPlus, true, nil, "ShowGuildMessagesPlus")

local generalWhispersArea = generalWarningPanel:CreateArea(L.WhisperMessages)
generalWhispersArea:CreateCheckButton(L.AutoRespond, true, nil, "AutoRespond")
generalWhispersArea:CreateCheckButton(L.WhisperStats, true, nil, "WhisperStats")
generalWhispersArea:CreateCheckButton(L.DisableStatusWhisper, true, nil, "DisableStatusWhisper")
generalWhispersArea:CreateCheckButton(L.DisableGuildStatus, true, nil, "DisableGuildStatus")
