local L = DBM_GUI_L

local spokenAlertsPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_SpokenAlerts, "option")

local spokenGeneralArea = spokenAlertsPanel:CreateArea(L.Area_VoiceSelection)

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
CountSoundDropDown2.myheight = 0

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
VoiceDropDown.myheight = 20 -- TODO: +10 padding per dropdown text

local voiceFilterArea		= spokenAlertsPanel:CreateArea(L.Area_VoicePackOptions)
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
SWFilterDropDown:SetPoint("TOPLEFT", _G[VPF1:GetName() .. "Text"], "BOTTOMLEFT", -26, -5)

local VPUrlArea1		= spokenAlertsPanel:CreateArea(L.Area_GetVEM)
VPUrlArea1:CreateText(L.VEMDownload, nil, true, nil, "LEFT")
VPUrlArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_GetVEM, "https://www.curseforge.com/wow/addons/dbm-voicepack-vem")
end)

local VPUrlArea2		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherVP)
VPUrlArea2:CreateText(L.BrowseOtherVPs, nil, true, nil, "LEFT")
VPUrlArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherVP, "https://www.curseforge.com/wow/addons/search?search=dbm+voice")
end)

local VPUrlArea3		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherCT)
VPUrlArea3:CreateText(L.BrowseOtherCTs, nil, true, nil, "LEFT")
VPUrlArea3.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherCT, "https://www.curseforge.com/wow/addons/search?search=dbm+count+pack")
end)
