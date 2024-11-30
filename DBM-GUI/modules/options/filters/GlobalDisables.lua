local L = DBM_GUI_L

--Centralized space to disable any feature from any other panel. Many options are duplicated here, but that's fine
--It's a one stop shop for disabling any DBM core feature
local spamPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_SpamFilter, "option")

local spamSpecAnnounceFeat = spamPanel:CreateArea(L.Area_SpamFilter_SpecFeatures)
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoShowAnnounce, true, nil, "DontShowBossAnnounces")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnText, true, nil, "DontShowSpecialWarningText")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnFlash, true, nil, "DontShowSpecialWarningFlash")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnVibrate, true, nil, "DontDoSpecialWarningVibrate")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnSound, true, nil, "DontPlaySpecialWarningSound")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoPrivateAuraSound, true, nil, "DontPlayPrivateAuraSound")

local spamTimers = spamPanel:CreateArea(L.Area_SpamFilter_Timers)
spamTimers:CreateCheckButton(L.SpamBlockNoShowBossTimers, true, nil, "DontShowBossTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowTrashTimers, true, nil, "DontShowTrashTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowEventTimers, true, nil, "DontShowEventTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowUTimers, true, nil, "DontShowUserTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoCountdowns, true, nil, "DontPlayCountdowns")

local spamNameplates = spamPanel:CreateArea(L.Area_SpamFilter_Nameplates)
local Plater = _G["Plater"]
if Plater then--Plater button disabled for now
	local platerButton = spamNameplates:CreateButton(L.Plater_Config, 100, 25)
	platerButton:SetPoint("CENTER", spamNameplates.frame, "CENTER", 0, 0)
	platerButton:SetNormalFontObject(GameFontNormal)
	platerButton:SetHighlightFontObject(GameFontNormal)
	platerButton:SetScript("OnClick", function()
		Plater.OpenOptionsPanel(28)--Open Plater boss mod options
		local optionsFrame = _G["DBM_GUI_OptionsFrame"]
		optionsFrame:Hide()--Close DBM GUI (cause it has higher strata than plater
	end)
	platerButton.myheight = 25
else
	spamNameplates:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
	spamNameplates:CreateCheckButton(L.SpamBlockNoNameplateCD, true, nil, "DontShowNameplateIconsCD")
	spamNameplates:CreateCheckButton(L.SpamBlockNoNameplateCasts, true, nil, "DontShowNameplateIconsCast")
	spamNameplates:CreateCheckButton(L.SpamBlockNoBossGUIDs, true, nil, "DontSendBossGUIDs")
end

local spamMisc = spamPanel:CreateArea(L.Area_SpamFilter_Misc)
spamMisc:CreateCheckButton(L.SpamBlockNoSetIcon, true, nil, "DontSetIcons")
spamMisc:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoHudMap, true, nil, "DontShowHudMap2")

spamMisc:CreateCheckButton(L.SpamBlockNoYells, true, nil, "DontSendYells")
spamMisc:CreateCheckButton(L.SpamBlockNoNoteSync, true, nil, "BlockNoteShare")
spamMisc:CreateCheckButton(L.SpamBlockAutoGossip, true, nil, "DontAutoGossip")

local spamRestoreArea = spamPanel:CreateArea(L.Area_Restore)
spamRestoreArea:CreateCheckButton(L.SpamBlockNoIconRestore, true, nil, "DontRestoreIcons")
spamRestoreArea:CreateCheckButton(L.SpamBlockNoRangeRestore, true, nil, "DontRestoreRange")

local spamPTArea = spamPanel:CreateArea(L.Area_PullTimer)
spamPTArea:CreateCheckButton(L.DontShowPTNoID, true, nil, "DontShowPTNoID")
spamPTArea:CreateCheckButton(L.DontShowPT, true, nil, "DontShowPT2")
spamPTArea:CreateCheckButton(L.DontShowPTText, true, nil, "DontShowPTText")
local SPTCDA = spamPTArea:CreateCheckButton(L.DontPlayPTCountdown, true, nil, "DontPlayPTCountdown")

local PTSlider = spamPTArea:CreateSlider(L.PT_Threshold, 1, 10, 1, 300)
PTSlider:SetPoint("BOTTOMLEFT", SPTCDA, "BOTTOMLEFT", 80, -40)
PTSlider:SetValue(math.floor(DBM.Options.PTCountThreshold2))
PTSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.PTCountThreshold2 = math.floor(self:GetValue())
end)
