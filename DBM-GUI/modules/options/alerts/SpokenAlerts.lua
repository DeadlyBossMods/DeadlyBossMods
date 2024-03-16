local L = DBM_GUI_L

local spokenAlertsPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_SpokenAlerts, "option")

local spokenGeneralArea = spokenAlertsPanel:CreateArea(L.Area_VoiceSelection)

local CountSoundDropDown = spokenGeneralArea:CreateDropdown(L.CountdownVoice, DBM:GetCountSounds(), "DBM", "CountdownVoice", function(value)
	DBM.Options.CountdownVoice = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown:SetPoint("TOPLEFT", spokenGeneralArea.frame, "TOPLEFT", 0, -20)
CountSoundDropDown.myheight = 20

local CountSoundDropDown2 = spokenGeneralArea:CreateDropdown(L.CountdownVoice2, DBM:GetCountSounds(), "DBM", "CountdownVoice2", function(value)
	DBM.Options.CountdownVoice2 = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice2)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown2:SetPoint("LEFT", CountSoundDropDown, "RIGHT", 45, 0)

local CountSoundDropDown3 = spokenGeneralArea:CreateDropdown(L.CountdownVoice3, DBM:GetCountSounds(), "DBM", "CountdownVoice3", function(value)
	DBM.Options.CountdownVoice3 = value
	DBM:PlayCountSound(1, DBM.Options.CountdownVoice3)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown3:SetPoint("TOPLEFT", CountSoundDropDown, "TOPLEFT", 0, -45)
CountSoundDropDown3.myheight = 20

local CountSoundDropDown4 = spokenGeneralArea:CreateDropdown(L.PullVoice, DBM:GetCountSounds(), "DBM", "PullVoice", function(value)
	DBM.Options.PullVoice = value
	DBM:PlayCountSound(1, DBM.Options.PullVoice)
	DBM:BuildVoiceCountdownCache()
end, 180)
CountSoundDropDown4:SetPoint("TOPLEFT", CountSoundDropDown2, "TOPLEFT", 0, -45)

local voices = DBM.Voices
if DBM.Options.ChosenVoicePack2 ~= "None" and not DBM.VoiceVersions[DBM.Options.ChosenVoicePack2] then -- Sound pack is missing, add a custom entry of "missing"
	table.insert(voices, { text = L.MissingVoicePack:format(DBM.Options.ChosenVoicePack2), value = DBM.Options.ChosenVoicePack2 })
end
local VoiceDropDown = spokenGeneralArea:CreateDropdown(L.VoicePackChoice, voices, "DBM", "ChosenVoicePack2", function(value)
	DBM.Options.ChosenVoicePack2 = value
	DBM:CheckVoicePackVersion(value)
end, 180)
VoiceDropDown:SetPoint("TOPLEFT", CountSoundDropDown3, "TOPLEFT", 0, -45)
VoiceDropDown.myheight = 20 -- TODO: +10 padding per dropdown text

local voiceReplaceArea		= spokenAlertsPanel:CreateArea(L.Area_VoicePackReplace)
local VPReplaceAnnounce		= voiceReplaceArea:CreateCheckButton(L.ReplacesAnnounce, true, nil, "VPReplacesAnnounce")
local VPReplaceSA1			= voiceReplaceArea:CreateCheckButton(L.ReplacesSA1, true, nil, "VPReplacesSA1")
local VPReplaceSA2			= voiceReplaceArea:CreateCheckButton(L.ReplacesSA2, true, nil, "VPReplacesSA2")
local VPReplaceSA3			= voiceReplaceArea:CreateCheckButton(L.ReplacesSA3, true, nil, "VPReplacesSA3")
local VPReplaceSA4			= voiceReplaceArea:CreateCheckButton(L.ReplacesSA4, true, nil, "VPReplacesSA4")
local VPReplacesGTFO		= voiceReplaceArea:CreateCheckButton(L.ReplacesGTFO, true, nil, "VPReplacesGTFO")
local VPReplaceCustom		= voiceReplaceArea:CreateCheckButton(L.ReplacesCustom, true, nil, "VPReplacesCustom")

local resetbutton = voiceReplaceArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", voiceReplaceArea.frame, "BOTTOMRIGHT", -2, 4)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.VPReplacesAnnounce = DBM.DefaultOptions.VPReplacesAnnounce
	DBM.Options.VPReplacesSA1 = DBM.DefaultOptions.VPReplacesSA1
	DBM.Options.VPReplacesSA2 = DBM.DefaultOptions.VPReplacesSA2
	DBM.Options.VPReplacesSA3 = DBM.DefaultOptions.VPReplacesSA3
	DBM.Options.VPReplacesSA4 = DBM.DefaultOptions.VPReplacesSA4
	DBM.Options.VPReplacesGTFO = DBM.DefaultOptions.VPReplacesGTFO
	DBM.Options.VPReplacesCustom = DBM.DefaultOptions.VPReplacesCustom
	-- Set UI visuals
	VPReplaceAnnounce:SetChecked(DBM.Options.VPReplacesAnnounce)
	VPReplaceSA1:SetChecked(DBM.Options.VPReplacesSA1)
	VPReplaceSA2:SetChecked(DBM.Options.VPReplacesSA2)
	VPReplaceSA3:SetChecked(DBM.Options.VPReplacesSA3)
	VPReplaceSA4:SetChecked(DBM.Options.VPReplacesSA4)
	VPReplacesGTFO:SetChecked(DBM.Options.VPReplacesGTFO)
	VPReplaceCustom:SetChecked(DBM.Options.VPReplacesCustom)
end)

--TODO, add note (L.VPReplaceNote) either above or below the replace checkboxes and within voiceReplaceArea

local voiceAdvancedArea		= spokenAlertsPanel:CreateArea(L.Area_VoicePackAdvOptions)
voiceAdvancedArea:CreateCheckButton(L.SpecWarn_AlwaysVoice, true, nil, "AlwaysPlayVoice")
voiceAdvancedArea:CreateCheckButton(L.VPDontMuteSounds, true, nil, "VPDontMuteSounds")

local VPUrlArea1		= spokenAlertsPanel:CreateArea(L.Area_VPLearnMore)
VPUrlArea1:CreateText(L.VPLearnMore, nil, true)
VPUrlArea1.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_VPLearnMore, "https://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update")
end)

local VPUrlArea2		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherVP)
VPUrlArea2:CreateText(L.BrowseOtherVPs, nil, true)
VPUrlArea2.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherVP, "https://www.curseforge.com/wow/addons/search?search=dbm+voice")
end)

local VPUrlArea3		= spokenAlertsPanel:CreateArea(L.Area_BrowseOtherCT)
VPUrlArea3:CreateText(L.BrowseOtherCTs, nil, true)
VPUrlArea3.frame:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, L.Area_BrowseOtherCT, "https://www.curseforge.com/wow/addons/search?search=dbm+count+pack")
end)
