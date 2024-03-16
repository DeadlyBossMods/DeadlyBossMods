local L = DBM_GUI_L

local handPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_HandFilter, "option")

local spamSpecAnnouncesFilters = handPanel:CreateArea(L.Area_SpamFilter_SpecRoleFilters)
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecInformationalOnly, true, nil, "SpamSpecInformationalOnly")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleDispel, true, nil, "SpamSpecRoledispel")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleInterrupt, true, nil, "SpamSpecRoleinterrupt")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleDefensive, true, nil, "SpamSpecRoledefensive")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleTaunt, true, nil, "SpamSpecRoletaunt")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleSoak, true, nil, "SpamSpecRolesoak")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleStack, true, nil, "SpamSpecRolestack")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleSwitch, true, nil, "SpamSpecRoleswitch")
spamSpecAnnouncesFilters:CreateCheckButton(L.SpamSpecRoleGTFO, true, nil, "SpamSpecRolegtfo")
