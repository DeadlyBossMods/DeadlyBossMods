local L = DBM_GUI_L

local spamPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_SpamFilter, "option")

local spamAnnounces = spamPanel:CreateArea(L.Area_SpamFilter_Anounces)
spamAnnounces:CreateCheckButton(L.SpamBlockNoShowAnnounce, true, nil, "DontShowBossAnnounces")
spamAnnounces:CreateCheckButton(L.SpamBlockNoShowTgtAnnounce, true, nil, "DontShowTargetAnnouncements")
spamAnnounces:CreateCheckButton(L.SpamBlockNoSpecWarnText, true, nil, "DontShowSpecialWarningText")
spamAnnounces:CreateCheckButton(L.SpamBlockNoSpecWarnFlash, true, nil, "DontShowSpecialWarningFlash")
spamAnnounces:CreateCheckButton(L.SpamBlockNoSpecWarnVibrate, true, nil, "DontDoSpecialWarningVibrate")
spamAnnounces:CreateCheckButton(L.SpamBlockNoSpecWarnSound, true, nil, "DontPlaySpecialWarningSound")
spamAnnounces:CreateCheckButton(L.SpamBlockNoTrivialSpecWarnSound, true, nil, "DontPlayTrivialSpecialWarningSound")

local spamTimers = spamPanel:CreateArea(L.Area_SpamFilter_Timers)
spamTimers:CreateCheckButton(L.SpamBlockNoShowTimers, true, nil, "DontShowBossTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowUTimers, true, nil, "DontShowUserTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoCountdowns, true, nil, "DontPlayCountdowns")

local spamMisc = spamPanel:CreateArea(L.Area_SpamFilter_Misc)
spamMisc:CreateCheckButton(L.SpamBlockNoSetIcon, true, nil, "DontSetIcons")
spamMisc:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoHudMap, true, nil, "DontShowHudMap2")
spamMisc:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
spamMisc:CreateCheckButton(L.SpamBlockNoYells, true, nil, "DontSendYells")
spamMisc:CreateCheckButton(L.SpamBlockNoNoteSync, true, nil, "BlockNoteShare")

local spamRestoreArea = spamPanel:CreateArea(L.Area_Restore)
spamRestoreArea:CreateCheckButton(L.SpamBlockNoIconRestore, true, nil, "DontRestoreIcons")
spamRestoreArea:CreateCheckButton(L.SpamBlockNoRangeRestore, true, nil, "DontRestoreRange")

local spamArea = spamPanel:CreateArea(L.Area_SpamFilter)
spamArea:CreateCheckButton(L.DontShowFarWarnings, true, nil, "DontShowFarWarnings")
spamArea:CreateCheckButton(L.StripServerName, true, nil, "StripServerName")
spamArea:CreateCheckButton(L.FilterVoidFormSay, true, nil, "FilterVoidFormSay")

local spamSpecArea = spamPanel:CreateArea(L.Area_SpecFilter)
spamSpecArea:CreateCheckButton(L.FilterTankSpec, true, nil, "FilterTankSpec")
spamSpecArea:CreateCheckButton(L.FilterDispels, true, nil, "FilterDispel")
spamSpecArea:CreateCheckButton(L.FilterTrashWarnings, true, nil, "FilterTrashWarnings2")
local FilterInterruptNote = spamSpecArea:CreateCheckButton(L.FilterInterruptNoteName, true, nil, "FilterInterruptNoteName")

local interruptOptions = {
	{	text	= L.SWFNever,			value	= "None"},
	{	text	= L.FilterInterrupts,	value	= "onlyTandF"},
	{	text	= L.FilterInterrupts2,	value	= "TandFandBossCooldown"},
	{	text	= L.FilterInterrupts3,	value	= "TandFandAllCooldown"},
	{	text	= L.FilterInterrupts4,	value	= "Always"},
}
local interruptDropDown		= spamSpecArea:CreateDropdown(L.FilterInterruptsHeader, interruptOptions, "DBM", "FilterInterrupt2", function(value)
	DBM.Options.FilterInterrupt2 = value
end, 410)
interruptDropDown:SetPoint("TOPLEFT", _G[FilterInterruptNote:GetName() .. "Text"], "BOTTOMLEFT", -26, -5)
interruptDropDown.myheight = 50

local spamPTArea = spamPanel:CreateArea(L.Area_PullTimer)
spamPTArea:CreateCheckButton(L.DontShowPTNoID, true, nil, "DontShowPTNoID")
spamPTArea:CreateCheckButton(L.DontShowPT, true, nil, "DontShowPT2")
spamPTArea:CreateCheckButton(L.DontShowPTText, true, nil, "DontShowPTText")
spamPTArea:CreateCheckButton(L.DontShowPTCountdownText, true, nil, "DontShowPTCountdownText")
local SPTCDA = spamPTArea:CreateCheckButton(L.DontPlayPTCountdown, true, nil, "DontPlayPTCountdown")

local PTSlider = spamPTArea:CreateSlider(L.PT_Threshold, 1, 10, 1, 300)
PTSlider:SetPoint("BOTTOMLEFT", SPTCDA, "BOTTOMLEFT", 80, -40)
PTSlider:SetValue(math.floor(DBM.Options.PTCountThreshold2))
PTSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.PTCountThreshold2 = math.floor(self:GetValue())
end)
