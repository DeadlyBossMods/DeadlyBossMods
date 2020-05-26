local L = DBM_GUI_L

local spamPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_SpamFilter, "option")
local spamOutArea = spamPanel:CreateArea(L.Area_SpamFilter_Outgoing, 250)

spamOutArea:CreateCheckButton(L.SpamBlockNoShowAnnounce, true, nil, "DontShowBossAnnounces")
spamOutArea:CreateCheckButton(L.SpamBlockNoShowTgtAnnounce, true, nil, "DontShowTargetAnnouncements")
spamOutArea:CreateCheckButton(L.SpamBlockNoSpecWarn, true, nil, "DontShowSpecialWarnings")
spamOutArea:CreateCheckButton(L.SpamBlockNoSpecWarnText, true, nil, "DontShowSpecialWarningText")
spamOutArea:CreateCheckButton(L.SpamBlockNoShowTimers, true, nil, "DontShowBossTimers")
spamOutArea:CreateCheckButton(L.SpamBlockNoShowUTimers, true, nil, "DontShowUserTimers")
spamOutArea:CreateCheckButton(L.SpamBlockNoSetIcon, true, nil, "DontSetIcons")
spamOutArea:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
spamOutArea:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
spamOutArea:CreateCheckButton(L.SpamBlockNoHudMap, true, nil, "DontShowHudMap2")
spamOutArea:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
spamOutArea:CreateCheckButton(L.SpamBlockNoNameplateLines, true, nil, "DontShowNameplateLines")
spamOutArea:CreateCheckButton(L.SpamBlockNoCountdowns, true, nil, "DontPlayCountdowns")
spamOutArea:CreateCheckButton(L.SpamBlockNoYells, true, nil, "DontSendYells")
spamOutArea:CreateCheckButton(L.SpamBlockNoNoteSync, true, nil, "BlockNoteShare")
spamOutArea:CreateCheckButton(L.SpamBlockNoReminders, true, nil, "DontShowReminders")

local spamRestoreArea = spamPanel:CreateArea(L.Area_Restore, 170)
spamRestoreArea:CreateCheckButton(L.SpamBlockNoIconRestore, true, nil, "DontRestoreIcons")
spamRestoreArea:CreateCheckButton(L.SpamBlockNoRangeRestore, true, nil, "DontRestoreRange")

local spamArea = spamPanel:CreateArea(L.Area_SpamFilter, 170)
spamArea:CreateCheckButton(L.DontShowFarWarnings, true, nil, "DontShowFarWarnings")
spamArea:CreateCheckButton(L.StripServerName, true, nil, "StripServerName")
spamArea:CreateCheckButton(L.FilterVoidFormSay, true, nil, "FilterVoidFormSay")

local spamSpecArea = spamPanel:CreateArea(L.Area_SpecFilter, 140)
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
interruptDropDown:SetPoint("TOPLEFT", FilterInterruptNote, "TOPLEFT", 0, -45)

local spamPTArea = spamPanel:CreateArea(L.Area_PullTimer, 180)
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

spamPTArea:AutoSetDimension()
spamRestoreArea:AutoSetDimension()
spamArea:AutoSetDimension()
spamSpecArea:AutoSetDimension()
spamOutArea:AutoSetDimension()
