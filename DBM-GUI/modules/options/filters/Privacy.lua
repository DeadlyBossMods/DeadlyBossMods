
local L = DBM_GUI_L
local privacyPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Tab_Privacy, "option")

--Can't send whispers in combat in midnight
if not DBM:IsPostMidnight() then
	local privacyWhispersArea = privacyPanel:CreateArea(L.Area_WhisperMessages)
	privacyWhispersArea:CreateCheckButton(L.AutoRespond, true, nil, "AutoRespond")
	privacyWhispersArea:CreateCheckButton(L.WhisperStats, true, nil, "WhisperStats")
	privacyWhispersArea:CreateCheckButton(L.DisableStatusWhisper, true, nil, "DisableStatusWhisper")
end

local privacySyncArea = privacyPanel:CreateArea(L.Area_SyncMessages)
privacySyncArea:CreateCheckButton(L.EnableWBSharing, true, nil, "EnableWBSharing")
privacySyncArea:CreateCheckButton(L.DisableGuildStatus, true, nil, "DisableGuildStatus")
