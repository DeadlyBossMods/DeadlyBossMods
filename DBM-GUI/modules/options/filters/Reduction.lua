local L = DBM_GUI_L

local reducPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_ReducedInformation, "option")

local spamAnnounces = reducPanel:CreateArea(L.Area_SpamFilter_Anounces)
spamAnnounces:CreateCheckButton(L.SpamBlockNoShowTgtAnnounce, true, nil, "DontShowTargetAnnouncements")
spamAnnounces:CreateCheckButton(L.SpamBlockNoTrivialSpecWarnSound, true, nil, "DontPlayTrivialSpecialWarningSound")

local spamArea = reducPanel:CreateArea(L.Area_SpamFilter)
spamArea:CreateCheckButton(L.DontShowFarWarnings, true, nil, "DontShowFarWarnings")
spamArea:CreateCheckButton(L.StripServerName, true, nil, "StripServerName")
spamArea:CreateCheckButton(L.FilterVoidFormSay2, true, nil, "FilterVoidFormSay2")

local spamSpecArea = reducPanel:CreateArea(L.Area_SpecFilter)
spamSpecArea:CreateCheckButton(L.FilterDispels, true, nil, "FilterDispel")
spamSpecArea:CreateCheckButton(L.FilterTrashWarnings, true, nil, "FilterTrashWarnings2")

local bInterruptSpecArea = reducPanel:CreateArea(L.Area_BInterruptFilter)
bInterruptSpecArea:CreateCheckButton(L.FilterTargetFocus, true, nil, "FilterBTargetFocus")
bInterruptSpecArea:CreateCheckButton(L.FilterInterruptCooldown, true, nil, "FilterBInterruptCooldown")
bInterruptSpecArea:CreateCheckButton(L.FilterInterruptHealer, true, nil, "FilterBInterruptHealer")
bInterruptSpecArea:CreateCheckButton(L.FilterInterruptNoteName, true, nil, "FilterInterruptNoteName")
local infotext1 = bInterruptSpecArea:CreateText(L.Area_BInterruptFilterFooter, nil, false, GameFontNormalSmall)
infotext1:SetPoint("BOTTOMLEFT", bInterruptSpecArea.frame, "BOTTOMLEFT", 10, 10)

local tInterruptSpecArea = reducPanel:CreateArea(L.Area_TInterruptFilter)
tInterruptSpecArea:CreateCheckButton(L.FilterTargetFocus, true, nil, "FilterTTargetFocus")
tInterruptSpecArea:CreateCheckButton(L.FilterInterruptCooldown, true, nil, "FilterTInterruptCooldown")
tInterruptSpecArea:CreateCheckButton(L.FilterInterruptHealer, true, nil, "FilterTInterruptHealer")
local infotext2 = tInterruptSpecArea:CreateText(L.Area_BInterruptFilterFooter, nil, false, GameFontNormalSmall)
infotext2:SetPoint("BOTTOMLEFT", tInterruptSpecArea.frame, "BOTTOMLEFT", 10, 10)
