local L = DBM_GUI_L
local privacyPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_GeneralMessages, "option")

local privacyWhispersArea = privacyPanel:CreateArea(L.WhisperMessages)
privacyWhispersArea:CreateCheckButton(L.AutoRespond, true, nil, "AutoRespond")
privacyWhispersArea:CreateCheckButton(L.WhisperStats, true, nil, "WhisperStats")
privacyWhispersArea:CreateCheckButton(L.DisableStatusWhisper, true, nil, "DisableStatusWhisper")

local privacySyncArea = privacyPanel:CreateArea(L.WhisperMessages)
privacySyncArea:CreateCheckButton(L.DisableGuildStatus, true, nil, "DisableGuildStatus")
privacySyncArea:CreateCheckButton(L.EnableWBSharing, true, nil, "EnableWBSharing")
