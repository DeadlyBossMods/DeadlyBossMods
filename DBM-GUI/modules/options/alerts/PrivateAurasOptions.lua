local L = DBM_GUI_L

local privateAurasPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_PrivateAuras, "option")

local growDirections = {
	{
		text	= L.RIGHT,
		value	= "RIGHT"
	},
	{
		text	= L.LEFT,
		value	= "LEFT"
	},
	{
		text	= L.UP,
		value	= "UP"
	},
	{
		text	= L.DOWN,
		value	= "DOWN"
	}
}

-----------------------------------
--  Personal Private Aura Frame  --
-----------------------------------
local personalPAArea 	= privateAurasPanel:CreateArea(L.Area_PersonalPrivateAuras)
--local personalPASound = personalPAArea:CreateCheckButton(L.SpamBlockNoPrivateAuraSound, true, nil, "DontPlayPrivateAuraSound")--Inverse option
local personalPAIcon	= personalPAArea:CreateCheckButton(L.EnablePersonalPrivateAuraIcons, true, nil, "PrivateAurasPlayerEnabled")
personalPAIcon:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerEnabled = not DBM.Options.PrivateAurasPlayerEnabled
	DBM.PrivateAuras:OnSettingsChange(true)
end)
local personalUpscaleDText = personalPAArea:CreateCheckButton(L.UpscaleDurationText, true, nil, "PrivateAurasPlayerUpscaleDuration")
personalUpscaleDText:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerUpscaleDuration = not DBM.Options.PrivateAurasPlayerUpscaleDuration
	DBM.PrivateAuras:OnSettingsChange(true)
end)
local personalPAText	= personalPAArea:CreateCheckButton(L.EnablePersonalPrivateAuraText, true, nil, "PrivateAurasTextAnchorEnabled")
personalPAText:SetScript("OnClick", function()
	DBM.Options.PrivateAurasTextAnchorEnabled = not DBM.Options.PrivateAurasTextAnchorEnabled
	DBM.PrivateAuras:OnSettingsChange(true)
end)
local personalPABorder 	= personalPAArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasPlayerHideBorder")
personalPABorder:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerHideBorder = not DBM.Options.PrivateAurasPlayerHideBorder
	DBM.PrivateAuras:OnSettingsChange(true)
end)
local personalPATooltip = personalPAArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasPlayerHideTooltip")
personalPATooltip:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerHideTooltip = not DBM.Options.PrivateAurasPlayerHideTooltip
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personalPATooltip:SetPoint("TOPLEFT", personalPABorder, "TOPLEFT", 150, 0)
personalPATooltip.myheight = 0

local personalPAGrowDir = personalPAArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasPlayerGrowDirection", function(value)
	DBM.Options.PrivateAurasPlayerGrowDirection = value
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personalPAGrowDir:SetPoint("TOPLEFT", personalPABorder, "BOTTOMLEFT", 0, -20)
personalPAGrowDir.myheight = 30

local personalSpacing = personalPAArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
personalSpacing:SetPoint("TOPLEFT", personalPAGrowDir, "TOPLEFT", 180, 0)
personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing)
personalSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerSpacing = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personalSpacing.myheight = 0

local personaPAIconScale = personalPAArea:CreateSlider(L.SetPAIconScale, 50, 150, 1, 150)
personaPAIconScale:SetPoint("TOPLEFT", personalPAGrowDir, "TOPLEFT", 0, -50)
personaPAIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
personaPAIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerWidth = self:GetValue()
	DBM.Options.PrivateAurasPlayerHeight = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personaPAIconScale.myheight = 50

local personalPAMaxIcons = personalPAArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
personalPAMaxIcons:SetPoint("TOPLEFT", personaPAIconScale, "TOPLEFT", 180, 0)
personalPAMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
personalPAMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerLimit = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personalPAMaxIcons.myheight = 0

local personPAStackScale = personalPAArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
personPAStackScale:SetPoint("TOPLEFT", personaPAIconScale, "TOPLEFT", 0, -50)
personPAStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
personPAStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerScale = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personPAStackScale.myheight = 50

local personaPATextMesssageScale = personalPAArea:CreateSlider(L.SetPATextScale, 0.5, 5, 0.1, 150)
personaPATextMesssageScale:SetPoint("TOPLEFT", personPAStackScale, "TOPLEFT", 180, 0)
personaPATextMesssageScale:SetValue(DBM.Options.PrivateAurasTextAnchorScale)
personaPATextMesssageScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasTextAnchorScale = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(true)
end)
personaPATextMesssageScale.myheight = 0

local personalMovemebutton = personalPAArea:CreateButton(L.MoveMe, 100, 16)
personalMovemebutton:SetPoint("TOPRIGHT", personalPAArea.frame, "TOPRIGHT", -2, -4)
personalMovemebutton:SetNormalFontObject(GameFontNormalSmall)
personalMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
personalMovemebutton:SetScript("OnClick", function()
	DBM.PrivateAuras:PreviewToggle()
end)

local personalPAReset = personalPAArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
personalPAReset:SetPoint("BOTTOMRIGHT", personalPAArea.frame, "BOTTOMRIGHT", -2, 4)
personalPAReset:SetNormalFontObject(GameFontNormalSmall)
personalPAReset:SetHighlightFontObject(GameFontNormalSmall)
personalPAReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasPlayerEnabled = DBM.DefaultOptions.PrivateAurasPlayerEnabled
	DBM.Options.PrivateAurasPlayerHideBorder = DBM.DefaultOptions.PrivateAurasPlayerHideBorder
	DBM.Options.PrivateAurasPlayerHideTooltip = DBM.DefaultOptions.PrivateAurasPlayerHideTooltip
	DBM.Options.PrivateAurasPlayerGrowDirection = DBM.DefaultOptions.PrivateAurasPlayerGrowDirection
	DBM.Options.PrivateAurasPlayerSpacing = DBM.DefaultOptions.PrivateAurasPlayerSpacing
	DBM.Options.PrivateAurasPlayerWidth = DBM.DefaultOptions.PrivateAurasPlayerWidth
	DBM.Options.PrivateAurasPlayerHeight = DBM.DefaultOptions.PrivateAurasPlayerHeight
	DBM.Options.PrivateAurasPlayerScale = DBM.DefaultOptions.PrivateAurasPlayerScale
	DBM.Options.PrivateAurasPlayerLimit = DBM.DefaultOptions.PrivateAurasPlayerLimit
	DBM.Options.PrivateAurasPlayerXOffset = DBM.DefaultOptions.PrivateAurasPlayerXOffset
	DBM.Options.PrivateAurasPlayerYOffset = DBM.DefaultOptions.PrivateAurasPlayerYOffset
	DBM.Options.PrivateAurasPlayerAnchor = DBM.DefaultOptions.PrivateAurasPlayerAnchor
	DBM.Options.PrivateAurasPlayerRelativeTo = DBM.DefaultOptions.PrivateAurasPlayerRelativeTo
	DBM.Options.PrivateAurasPlayerUpscaleDuration = DBM.DefaultOptions.PrivateAurasPlayerUpscaleDuration

	DBM.Options.PrivateAurasTextAnchorScale = DBM.DefaultOptions.PrivateAurasTextAnchorScale
	DBM.Options.PrivateAurasTextAnchorEnabled = DBM.DefaultOptions.PrivateAurasTextAnchorEnabled
	DBM.Options.PrivateAurasTextAnchorXOffset = DBM.DefaultOptions.PrivateAurasTextAnchorXOffset
	DBM.Options.PrivateAurasTextAnchorYOffset = DBM.DefaultOptions.PrivateAurasTextAnchorYOffset
	DBM.Options.PrivateAurasTextAnchorRelativeTo = DBM.DefaultOptions.PrivateAurasTextAnchorRelativeTo
	DBM.Options.PrivateAurasTextAnchor = DBM.DefaultOptions.PrivateAurasTextAnchor
--	DBM.Options.DontPlayPrivateAuraSound = DBM.DefaultOptions.DontPlayPrivateAuraSound
	-- Set UI visuals
	personalPAIcon:SetChecked(DBM.Options.PrivateAurasPlayerEnabled)
	personalPAText:SetChecked(DBM.Options.PrivateAurasTextAnchorEnabled)
	personalPABorder:SetChecked(DBM.Options.PrivateAurasPlayerHideBorder)
	personalPATooltip:SetChecked(DBM.Options.PrivateAurasPlayerHideTooltip)
	personalPAGrowDir:SetSelectedValue(DBM.Options.PrivateAurasPlayerGrowDirection)
	personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing)
	personaPAIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
	personPAStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
	personalPAMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
	personaPATextMesssageScale:SetValue(DBM.Options.PrivateAurasTextAnchorScale)
	personalUpscaleDText:SetChecked(DBM.Options.PrivateAurasPlayerUpscaleDuration)
	--personalPASound:SetChecked(DBM.Options.DontPlayPrivateAuraSound)
	--TODO, PrivateAurasPlayerXOffset and PrivateAurasPlayerYOffset are not yet implemented, need to add those to the UI and then set them here as well
	DBM.PrivateAuras:OnSettingsChange(true)
end)

----------------------------------
--  Co-Tank Private Aura Frame  --
----------------------------------
local coTankPAArea		= privateAurasPanel:CreateArea(L.Area_TankPrivateAuras)
local coTankPAIcon		= coTankPAArea:CreateCheckButton(L.EnableTankPrivateAuraIcons, true, nil, "PrivateAurasCoTankEnabled")
coTankPAIcon:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankEnabled = not DBM.Options.PrivateAurasCoTankEnabled
	DBM.PrivateAuras:OnSettingsChange(false)
end)
local coTankUpscaleDText = coTankPAArea:CreateCheckButton(L.UpscaleDurationText, true, nil, "PrivateAurasCoTankUpscaleDuration")
coTankUpscaleDText:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankUpscaleDuration = not DBM.Options.PrivateAurasCoTankUpscaleDuration
	DBM.PrivateAuras:OnSettingsChange(true)
end)
local coTankPABorder 	= coTankPAArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasCoTankHideBorder")
coTankPABorder:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankHideBorder = not DBM.Options.PrivateAurasCoTankHideBorder
	DBM.PrivateAuras:OnSettingsChange(false)
end)
local coTankPATooltip	= coTankPAArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasCoTankHideTooltip")
coTankPATooltip:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankHideTooltip = not DBM.Options.PrivateAurasCoTankHideTooltip
	DBM.PrivateAuras:OnSettingsChange(false)
end)
coTankPATooltip:SetPoint("TOPLEFT", coTankPABorder, "TOPLEFT", 150, 0)
coTankPATooltip.myheight = 0

local coTankGrowDir = coTankPAArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasCoTankGrowDirection", function(value)
	DBM.Options.PrivateAurasCoTankGrowDirection = value
	DBM.PrivateAuras:OnSettingsChange(false)
end)
coTankGrowDir:SetPoint("TOPLEFT", coTankPABorder, "BOTTOMLEFT", 0, -20)
coTankGrowDir.myheight = 30

local coTankSpacing = coTankPAArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
coTankSpacing:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 180, 0)
coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
coTankSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankSpacing = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(false)
end)
coTankSpacing.myheight = 0

local coTankIconScale = coTankPAArea:CreateSlider(L.SetPAIconScale, 50, 150, 1, 150)
coTankIconScale:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 0, -50)
coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
coTankIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankWidth = self:GetValue()
	DBM.Options.PrivateAurasCoTankHeight = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(false)
end)
coTankIconScale.myheight = 50

local coTankPAMaxIcons = coTankPAArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
coTankPAMaxIcons:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 180, 0)
coTankPAMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
coTankPAMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankLimit = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(false)
end)
coTankPAMaxIcons.myheight = 0

local coTankStackScale = coTankPAArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
coTankStackScale:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)
coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
coTankStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankScale = self:GetValue()
	DBM.PrivateAuras:OnSettingsChange(false)
end)

local coTankMovemebutton = coTankPAArea:CreateButton(L.MoveMe, 100, 16)
coTankMovemebutton:SetPoint("TOPRIGHT", coTankPAArea.frame, "TOPRIGHT", -2, -4)
coTankMovemebutton:SetNormalFontObject(GameFontNormalSmall)
coTankMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
coTankMovemebutton:SetScript("OnClick", function()
	DBM.PrivateAuras:PreviewToggle()
end)

local coTankPAReset = coTankPAArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
coTankPAReset:SetPoint("BOTTOMRIGHT", coTankPAArea.frame, "BOTTOMRIGHT", -2, 4)
coTankPAReset:SetNormalFontObject(GameFontNormalSmall)
coTankPAReset:SetHighlightFontObject(GameFontNormalSmall)
coTankPAReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasCoTankEnabled = DBM.DefaultOptions.PrivateAurasCoTankEnabled
	DBM.Options.PrivateAurasCoTankHideBorder = DBM.DefaultOptions.PrivateAurasCoTankHideBorder
	DBM.Options.PrivateAurasCoTankHideTooltip = DBM.DefaultOptions.PrivateAurasCoTankHideTooltip
	DBM.Options.PrivateAurasCoTankGrowDirection = DBM.DefaultOptions.PrivateAurasCoTankGrowDirection
	DBM.Options.PrivateAurasCoTankSpacing = DBM.DefaultOptions.PrivateAurasCoTankSpacing
	DBM.Options.PrivateAurasCoTankWidth = DBM.DefaultOptions.PrivateAurasCoTankWidth
	DBM.Options.PrivateAurasCoTankHeight = DBM.DefaultOptions.PrivateAurasCoTankHeight
	DBM.Options.PrivateAurasCoTankScale = DBM.DefaultOptions.PrivateAurasCoTankScale
	DBM.Options.PrivateAurasCoTankLimit = DBM.DefaultOptions.PrivateAurasCoTankLimit
	DBM.Options.PrivateAurasCoTankXOffset = DBM.DefaultOptions.PrivateAurasCoTankXOffset
	DBM.Options.PrivateAurasCoTankYOffset = DBM.DefaultOptions.PrivateAurasCoTankYOffset
	DBM.Options.PrivateAurasCoTankAnchor = DBM.DefaultOptions.PrivateAurasCoTankAnchor
	DBM.Options.PrivateAurasCoTankRelativeTo = DBM.DefaultOptions.PrivateAurasCoTankRelativeTo
	DBM.Options.PrivateAurasCoTankUpscaleDuration = DBM.DefaultOptions.PrivateAurasCoTankUpscaleDuration
	-- Set UI visuals
	coTankPAIcon:SetChecked(DBM.Options.PrivateAurasCoTankEnabled)
	coTankPABorder:SetChecked(DBM.Options.PrivateAurasCoTankHideBorder)
	coTankPATooltip:SetChecked(DBM.Options.PrivateAurasCoTankHideTooltip)
	coTankGrowDir:SetSelectedValue(DBM.Options.PrivateAurasCoTankGrowDirection)
	coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
	coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
	coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
	coTankPAMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
	--TODO, PrivateAurasCoTankXOffset and PrivateAurasCoTankYOffset are not yet implemented, need to add those to the UI and then set them here as well
	coTankUpscaleDText:SetChecked(DBM.Options.PrivateAurasCoTankUpscaleDuration)
	DBM.PrivateAuras:OnSettingsChange(false)
end)
