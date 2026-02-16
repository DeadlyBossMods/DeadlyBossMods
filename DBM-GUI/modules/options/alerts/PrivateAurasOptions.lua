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
local personalPAText	= personalPAArea:CreateCheckButton(L.EnablePersonalPrivateAuraText, true, nil, "PrivateAurasTextAnchorEnabled")
local personalPABorder 	= personalPAArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasPlayerHideBorder")
local personalPATooltip = personalPAArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasPlayerHideTooltip")
personalPATooltip:SetPoint("TOPLEFT", personalPABorder, "TOPLEFT", 150, 0)
personalPATooltip.myheight = 0

local personalPAGrowDir = personalPAArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasPlayerGrowDirection", function(value)
	DBM.Options.PrivateAurasPlayerGrowDirection = value
end)
personalPAGrowDir:SetPoint("TOPLEFT", personalPABorder, "BOTTOMLEFT", 0, -20)
personalPAGrowDir.myheight = 30

local personalSpacing = personalPAArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
personalSpacing:SetPoint("TOPLEFT", personalPAGrowDir, "TOPLEFT", 180, 0)
personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing)
personalSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerSpacing = self:GetValue()
end)
personalSpacing.myheight = 0

local personaPAIconScale = personalPAArea:CreateSlider(L.SetPAIconScale, 50, 150, 1, 150)
personaPAIconScale:SetPoint("TOPLEFT", personalPAGrowDir, "TOPLEFT", 0, -50)
personaPAIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
personaPAIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerWidth = self:GetValue()
	DBM.Options.PrivateAurasPlayerHeight = self:GetValue()
end)
personaPAIconScale.myheight = 50

local personalPAMaxIcons = personalPAArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
personalPAMaxIcons:SetPoint("TOPLEFT", personaPAIconScale, "TOPLEFT", 180, 0)
personalPAMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
personalPAMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerLimit = self:GetValue()
end)
personalPAMaxIcons.myheight = 0

local personPAStackScale = personalPAArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
personPAStackScale:SetPoint("TOPLEFT", personaPAIconScale, "TOPLEFT", 0, -50)
personPAStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
personPAStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerScale = self:GetValue()
end)
personPAStackScale.myheight = 50

local personaPATextMesssageScale = personalPAArea:CreateSlider(L.SetPATextScale, 0.5, 5, 0.1, 150)
personaPATextMesssageScale:SetPoint("TOPLEFT", personPAStackScale, "TOPLEFT", 180, 0)
personaPATextMesssageScale:SetValue(DBM.Options.PrivateAurasTextAnchorScale)
personaPATextMesssageScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasTextAnchorScale = self:GetValue()
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
	DBM.Options.PrivateAurasTextAnchorEnabled = DBM.DefaultOptions.PrivateAurasTextAnchorEnabled
	DBM.Options.PrivateAurasPlayerHideBorder = DBM.DefaultOptions.PrivateAurasPlayerHideBorder
	DBM.Options.PrivateAurasPlayerHideTooltip = DBM.DefaultOptions.PrivateAurasPlayerHideTooltip
	DBM.Options.PrivateAurasPlayerGrowDirection = DBM.DefaultOptions.PrivateAurasPlayerGrowDirection
	DBM.Options.PrivateAurasPlayerSpacing = DBM.DefaultOptions.PrivateAurasPlayerSpacing
	DBM.Options.PrivateAurasPlayerWidth = DBM.DefaultOptions.PrivateAurasPlayerWidth
	DBM.Options.PrivateAurasPlayerHeight = DBM.DefaultOptions.PrivateAurasPlayerHeight
	DBM.Options.PrivateAurasPlayerScale = DBM.DefaultOptions.PrivateAurasPlayerScale
	DBM.Options.PrivateAurasPlayerLimit = DBM.DefaultOptions.PrivateAurasPlayerLimit
	DBM.Options.PrivateAurasTextAnchorScale = DBM.DefaultOptions.PrivateAurasTextAnchorScale
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
	--personalPASound:SetChecked(DBM.Options.DontPlayPrivateAuraSound)
end)

----------------------------------
--  Co-Tank Private Aura Frame  --
----------------------------------
local coTankPAArea		= privateAurasPanel:CreateArea(L.Area_TankPrivateAuras)
local coTankPAIcon		= coTankPAArea:CreateCheckButton(L.EnableTankPrivateAuraIcons, true, nil, "PrivateAurasCoTankEnabled")
local coTankPABorder 	= coTankPAArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasCoTankHideBorder")
local coTankPATooltip	= coTankPAArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasCoTankHideTooltip")
coTankPATooltip:SetPoint("TOPLEFT", coTankPABorder, "TOPLEFT", 150, 0)
coTankPATooltip.myheight = 0

local coTankGrowDir = coTankPAArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasCoTankGrowDirection", function(value)
	DBM.Options.PrivateAurasCoTankGrowDirection = value
end)
coTankGrowDir:SetPoint("TOPLEFT", coTankPABorder, "BOTTOMLEFT", 0, -20)
coTankGrowDir.myheight = 30

local coTankSpacing = coTankPAArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
coTankSpacing:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 180, 0)
coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
coTankSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankSpacing = self:GetValue()
end)
coTankSpacing.myheight = 0

local coTankIconScale = coTankPAArea:CreateSlider(L.SetPAIconScale, 50, 150, 1, 150)
coTankIconScale:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 0, -50)
coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
coTankIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankWidth = self:GetValue()
	DBM.Options.PrivateAurasCoTankHeight = self:GetValue()
end)
coTankIconScale.myheight = 50

local coTankPAMaxIcons = coTankPAArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
coTankPAMaxIcons:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 180, 0)
coTankPAMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
coTankPAMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankLimit = self:GetValue()
end)
coTankPAMaxIcons.myheight = 0

local coTankStackScale = coTankPAArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
coTankStackScale:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)
coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
coTankStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankScale = self:GetValue()
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
	-- Set UI visuals
	coTankPAIcon:SetChecked(DBM.Options.PrivateAurasCoTankEnabled)
	coTankPABorder:SetChecked(DBM.Options.PrivateAurasCoTankHideBorder)
	coTankPATooltip:SetChecked(DBM.Options.PrivateAurasCoTankHideTooltip)
	coTankGrowDir:SetSelectedValue(DBM.Options.PrivateAurasCoTankGrowDirection)
	coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
	coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
	coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
	coTankPAMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
end)
