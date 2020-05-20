local L = DBM_GUI_Translations
local generalWarningPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_GeneralMessages, "option")

local generalCoreArea = generalWarningPanel:CreateArea(L.CoreMessages, nil, 120)
generalCoreArea:CreateCheckButton(L.ShowPizzaMessage, true, nil, "ShowPizzaMessage")
generalCoreArea:CreateCheckButton(L.ShowAllVersions, true, nil, "ShowAllVersions")

local generalMessagesArea = generalWarningPanel:CreateArea(L.CombatMessages, nil, 135)
generalMessagesArea:CreateCheckButton(L.ShowEngageMessage, true, nil, "ShowEngageMessage")
generalMessagesArea:CreateCheckButton(L.ShowDefeatMessage, true, nil, "ShowDefeatMessage")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessages, true, nil, "ShowGuildMessages")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessagesPlus, true, nil, "ShowGuildMessagesPlus")

local generalWhispersArea = generalWarningPanel:CreateArea(L.WhisperMessages, nil, 135)
generalWhispersArea:CreateCheckButton(L.AutoRespond, true, nil, "AutoRespond")
generalWhispersArea:CreateCheckButton(L.WhisperStats, true, nil, "WhisperStats")
generalWhispersArea:CreateCheckButton(L.DisableStatusWhisper, true, nil, "DisableStatusWhisper")
generalWhispersArea:CreateCheckButton(L.DisableGuildStatus, true, nil, "DisableGuildStatus")
generalCoreArea:AutoSetDimension()
generalMessagesArea:AutoSetDimension()
generalWhispersArea:AutoSetDimension()
generalWarningPanel:SetMyOwnHeight()
