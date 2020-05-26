local L = DBM_GUI_L

local spokenAlertsPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_SpokenAlerts, "option")

local spokenGeneralArea = spokenAlertsPanel:CreateArea(L.Area_VoiceSelection, 105)

local CountSoundDropDown = spokenGeneralArea:CreateDropdown(L.CountdownVoice, DBM.Counts, "DBM", "CountdownVoice", function(value)
	DBM.Options.CountdownVoice = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown:SetPoint("TOPLEFT", spokenGeneralArea.frame, "TOPLEFT", 0, -20)

local CountSoundDropDown2 = spokenGeneralArea:CreateDropdown(L.CountdownVoice2, DBM.Counts, "DBM", "CountdownVoice2", function(value)
	DBM.Options.CountdownVoice2 = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice2)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown2:SetPoint("LEFT", CountSoundDropDown, "RIGHT", 45, 0)

local CountSoundDropDown3 = spokenGeneralArea:CreateDropdown(L.CountdownVoice3, DBM.Counts, "DBM", "CountdownVoice3", function(value)
	DBM.Options.CountdownVoice3 = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice3)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown3:SetPoint("TOPLEFT", CountSoundDropDown, "TOPLEFT", 0, -45)

local VoiceDropDown = spokenGeneralArea:CreateDropdown(L.VoicePackChoice, DBM.Voices, "DBM", "ChosenVoicePack", function(value)
	DBM.Options.ChosenVoicePack = value
	DBM:Debug("DBM.Options.ChosenVoicePack is set to " .. DBM.Options.ChosenVoicePack)
	DBM:CheckVoicePackVersion(value)
end, 180)
VoiceDropDown:SetPoint("TOPLEFT", CountSoundDropDown2, "TOPLEFT", 0, -45)

local voiceFilterArea		= spokenAlertsPanel:CreateArea(L.Area_VoicePackOptions, 97)
local VPF1					= voiceFilterArea:CreateCheckButton(L.SpecWarn_AlwaysVoice, true, nil, "AlwaysPlayVoice")
local voiceSWOptions = {
	{
		text	= L.SWFNever,
		value	= "None"
	},
	{
		text	= L.SWFDefaultOnly,
		value	= "DefaultOnly"
	},
	{
		text	= L.SWFAll,
		value	= "All"
	},
}
local SWFilterDropDown		= voiceFilterArea:CreateDropdown(L.SpecWarn_NoSoundsWVoice, voiceSWOptions, "DBM", "VoiceOverSpecW2", function(value)
	DBM.Options.VoiceOverSpecW2 = value
end, 420)
SWFilterDropDown:SetPoint("TOPLEFT", VPF1, "TOPLEFT", 0, -45)

local VPUrlArea1		= spokenAlertsPanel:CreateArea(L.Area_GetVEM, 30)
local VPDownloadUrl1	= VPUrlArea1:CreateText(L.VEMDownload, 405, nil, nil, "LEFT")
VPDownloadUrl1:SetPoint("TOPLEFT", VPUrlArea1.frame, "TOPLEFT", 10, -7)
VPUrlArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_GetVEM, "https://www.curseforge.com/wow/addons/dbm-voicepack-vem")
end)

local VPUrlArea2		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherVP, 40)
local VPDownloadUrl2	= VPUrlArea2:CreateText(L.BrowseOtherVPs, 405, nil, nil, "LEFT")
VPDownloadUrl2:SetPoint("TOPLEFT", VPUrlArea2.frame, "TOPLEFT", 10, -7)
VPUrlArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherVP, "https://www.curseforge.com/wow/addons/search?search=dbm+voice")
end)

local VPUrlArea3		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherCT, 40)
local VPDownloadUrl3	= VPUrlArea3:CreateText(L.BrowseOtherCTs, 405, nil, nil, "LEFT")
VPDownloadUrl3:SetPoint("TOPLEFT", VPUrlArea3.frame, "TOPLEFT", 10, -7)
VPUrlArea3.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherCT, "https://www.curseforge.com/wow/addons/search?search=dbm+count+pack")
end)
