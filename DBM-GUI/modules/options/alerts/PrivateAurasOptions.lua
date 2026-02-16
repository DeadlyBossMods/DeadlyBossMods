local L = DBM_GUI_L

local privateAurasPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_PrivateAuras, "option")

-----------------------------------
--  Personal Private Aura Frame  --
-----------------------------------
local personalPAArea = privateAurasPanel:CreateArea(L.Area_PersonalPrivateAuras)
--local personalPASound = personalPAArea:CreateCheckButton(L.SpamBlockNoPrivateAuraSound, true, nil, "DontPlayPrivateAuraSound")--Inverse option
local personalPAIcon = personalPAArea:CreateCheckButton(L.EnablePersonalPrivateAuraIcons, true, nil, "PrivateAurasPlayerEnabled")
local personalPAText = personalPAArea:CreateCheckButton(L.EnablePersonalPrivateAuraText, true, nil, "PrivateAurasTextAnchorEnabled")

local personalMovemebutton = personalPAArea:CreateButton(L.MoveMe, 100, 16)
personalMovemebutton:SetPoint("TOPRIGHT", personalPAArea.frame, "TOPRIGHT", -2, -4)
personalMovemebutton:SetNormalFontObject(GameFontNormalSmall)
personalMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
personalMovemebutton:SetScript("OnClick", function()
	DBM.PrivateAuras:PreviewToggle()
end)

local personalPAReset = privateAurasPanel:CreateButton(L.SpecWarn_ResetMe, 120, 16)
personalPAReset:SetPoint("BOTTOMRIGHT", privateAurasPanel.frame, "BOTTOMRIGHT", -2, 4)
personalPAReset:SetNormalFontObject(GameFontNormalSmall)
personalPAReset:SetHighlightFontObject(GameFontNormalSmall)
personalPAReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasPlayerEnabled = DBM.DefaultOptions.PrivateAurasPlayerEnabled
	DBM.Options.PrivateAurasTextAnchorEnabled = DBM.DefaultOptions.PrivateAurasTextAnchorEnabled
--	DBM.Options.DontPlayPrivateAuraSound = DBM.DefaultOptions.DontPlayPrivateAuraSound
	-- Set UI visuals
	personalPAIcon:SetChecked(DBM.Options.PrivateAurasPlayerEnabled)
	personalPAText:SetChecked(DBM.Options.PrivateAurasTextAnchorEnabled)
	--personalPASound:SetChecked(DBM.Options.DontPlayPrivateAuraSound)
end)

----------------------------------
--  Co-Tank Private Aura Frame  --
----------------------------------
local coTankPAArea = privateAurasPanel:CreateArea(L.Area_CoTankPrivateAuras)
local coTankPAIcon = coTankPAArea:CreateCheckButton(L.EnableCoTankPrivateAuraIcons, true, nil, "PrivateAurasCoTankEnabled")

local coTankMovemebutton = coTankPAArea:CreateButton(L.MoveMe, 100, 16)
coTankMovemebutton:SetPoint("TOPRIGHT", coTankPAArea.frame, "TOPRIGHT", -2, -4)
coTankMovemebutton:SetNormalFontObject(GameFontNormalSmall)
coTankMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
coTankMovemebutton:SetScript("OnClick", function()
	DBM.PrivateAuras:PreviewToggle()
end)

local coTankPAReset = privateAurasPanel:CreateButton(L.SpecWarn_ResetMe, 120, 16)
coTankPAReset:SetPoint("BOTTOMRIGHT", privateAurasPanel.frame, "BOTTOMRIGHT", -2, 4)
coTankPAReset:SetNormalFontObject(GameFontNormalSmall)
coTankPAReset:SetHighlightFontObject(GameFontNormalSmall)
coTankPAReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasCoTankEnabled = DBM.DefaultOptions.PrivateAurasCoTankEnabled
	-- Set UI visuals
	coTankPAIcon:SetChecked(DBM.Options.PrivateAurasCoTankEnabled)
end)
