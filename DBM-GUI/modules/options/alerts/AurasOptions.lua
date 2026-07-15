local L = DBM_GUI_L
local isAuraTracking121 = DBM:GetTOC() >= 120100

local function OnAuraSettingsChange(player)
	local auraHandler = DBM.Auras
	if auraHandler and auraHandler.OnSettingsChange then
		auraHandler:OnSettingsChange(player)
	end
end

local function ToggleAuraPreview()
	local auraHandler = DBM.Auras
	if auraHandler and auraHandler.PreviewToggle then
		auraHandler:PreviewToggle()
	end
end

local auraPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Panel_PrivateAuras, "option")

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
--  Personal Aura Frame  --
-----------------------------------
local personalAuraArea 	= auraPanel:CreateArea(L.Area_PersonalPrivateAuras)
--local personalAuraSound = personalAuraArea:CreateCheckButton(L.SpamBlockNoPrivateAuraSound, true, nil, "DontPlayPrivateAuraSound")--Inverse option
local personalAuraIcon	= personalAuraArea:CreateCheckButton(L.EnablePersonalPrivateAuraIcons, true, nil, "PrivateAurasPlayerEnabled")
personalAuraIcon:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerEnabled = not DBM.Options.PrivateAurasPlayerEnabled
	OnAuraSettingsChange(true)
end)
local personalUpscaleDText
local personalAuraText
if not isAuraTracking121 then
	personalUpscaleDText = personalAuraArea:CreateCheckButton(L.UpscaleDurationText, true, nil, "PrivateAurasPlayerUpscaleDuration")
	personalUpscaleDText:SetScript("OnClick", function()
		DBM.Options.PrivateAurasPlayerUpscaleDuration = not DBM.Options.PrivateAurasPlayerUpscaleDuration
		OnAuraSettingsChange(true)
	end)
	personalAuraText = personalAuraArea:CreateCheckButton(L.EnablePersonalPrivateAuraText, true, nil, "PrivateAurasTextAnchorEnabled")
	personalAuraText:SetScript("OnClick", function()
		DBM.Options.PrivateAurasTextAnchorEnabled = not DBM.Options.PrivateAurasTextAnchorEnabled
		OnAuraSettingsChange(true)
	end)
end
local personalAuraBorder 	= personalAuraArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasPlayerHideBorder")
personalAuraBorder:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerHideBorder = not DBM.Options.PrivateAurasPlayerHideBorder
	OnAuraSettingsChange(true)
end)
local personalAuraTooltip = personalAuraArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasPlayerHideTooltip")
personalAuraTooltip:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerHideTooltip = not DBM.Options.PrivateAurasPlayerHideTooltip
	OnAuraSettingsChange(true)
end)
personalAuraTooltip:SetPoint("TOPLEFT", personalAuraBorder, "TOPLEFT", 150, 0)
personalAuraTooltip.myheight = 0

local personalAuraGrowDir = personalAuraArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasPlayerGrowDirection", function(value)
	DBM.Options.PrivateAurasPlayerGrowDirection = value
	OnAuraSettingsChange(true)
end)
personalAuraGrowDir:SetPoint("TOPLEFT", personalAuraBorder, "BOTTOMLEFT", 0, -20)
personalAuraGrowDir.myheight = 30

local personalSpacing = personalAuraArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
personalSpacing:SetPoint("TOPLEFT", personalAuraGrowDir, "TOPLEFT", 180, 0)
personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing)
personalSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerSpacing = self:GetValue()
	OnAuraSettingsChange(true)
end)
personalSpacing.myheight = 0

local personalAuraIconScale = personalAuraArea:CreateSlider(L.SetPAIconScale, 25, 150, 1, 150)
personalAuraIconScale:SetPoint("TOPLEFT", personalAuraGrowDir, "TOPLEFT", 0, -50)
personalAuraIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
personalAuraIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerWidth = self:GetValue()
	DBM.Options.PrivateAurasPlayerHeight = self:GetValue()
	OnAuraSettingsChange(true)
end)
personalAuraIconScale.myheight = 50

local personalAuraMaxIcons = personalAuraArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
personalAuraMaxIcons:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 180, 0)
personalAuraMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
personalAuraMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerLimit = self:GetValue()
	OnAuraSettingsChange(true)
end)
personalAuraMaxIcons.myheight = 0

local personalAuraStackScale = personalAuraArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
personalAuraStackScale:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 0, -50)
personalAuraStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
personalAuraStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerScale = self:GetValue()
	OnAuraSettingsChange(true)
end)
personalAuraStackScale.myheight = 50

local personalAuraTextMesssageScale
if not isAuraTracking121 then
	personalAuraTextMesssageScale = personalAuraArea:CreateSlider(L.SetPATextScale, 0.5, 5, 0.1, 150)
	personalAuraTextMesssageScale:SetPoint("TOPLEFT", personalAuraStackScale, "TOPLEFT", 180, 0)
	personalAuraTextMesssageScale:SetValue(DBM.Options.PrivateAurasTextAnchorScale)
	personalAuraTextMesssageScale:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasTextAnchorScale = self:GetValue()
		OnAuraSettingsChange(true)
	end)
	personalAuraTextMesssageScale.myheight = 0
end

local personalMovemebutton = personalAuraArea:CreateButton(L.MoveMe, 100, 16)
personalMovemebutton:SetPoint("TOPRIGHT", personalAuraArea.frame, "TOPRIGHT", -2, -4)
personalMovemebutton:SetNormalFontObject(GameFontNormalSmall)
personalMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
personalMovemebutton:SetScript("OnClick", function()
	ToggleAuraPreview()
end)

local personalAuraReset = personalAuraArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
personalAuraReset:SetPoint("BOTTOMRIGHT", personalAuraArea.frame, "BOTTOMRIGHT", -2, 4)
personalAuraReset:SetNormalFontObject(GameFontNormalSmall)
personalAuraReset:SetHighlightFontObject(GameFontNormalSmall)
personalAuraReset:SetScript("OnClick", function()
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
	if not isAuraTracking121 then
		DBM.Options.PrivateAurasPlayerUpscaleDuration = DBM.DefaultOptions.PrivateAurasPlayerUpscaleDuration

		DBM.Options.PrivateAurasTextAnchorScale = DBM.DefaultOptions.PrivateAurasTextAnchorScale
		DBM.Options.PrivateAurasTextAnchorEnabled = DBM.DefaultOptions.PrivateAurasTextAnchorEnabled
		DBM.Options.PrivateAurasTextAnchorXOffset = DBM.DefaultOptions.PrivateAurasTextAnchorXOffset
		DBM.Options.PrivateAurasTextAnchorYOffset = DBM.DefaultOptions.PrivateAurasTextAnchorYOffset
		DBM.Options.PrivateAurasTextAnchorRelativeTo = DBM.DefaultOptions.PrivateAurasTextAnchorRelativeTo
		DBM.Options.PrivateAurasTextAnchor = DBM.DefaultOptions.PrivateAurasTextAnchor
	end
--	DBM.Options.DontPlayPrivateAuraSound = DBM.DefaultOptions.DontPlayPrivateAuraSound
	-- Set UI visuals
	personalAuraIcon:SetChecked(DBM.Options.PrivateAurasPlayerEnabled)
	if personalAuraText then
		personalAuraText:SetChecked(DBM.Options.PrivateAurasTextAnchorEnabled)
	end
	personalAuraBorder:SetChecked(DBM.Options.PrivateAurasPlayerHideBorder)
	personalAuraTooltip:SetChecked(DBM.Options.PrivateAurasPlayerHideTooltip)
	personalAuraGrowDir:SetSelectedValue(DBM.Options.PrivateAurasPlayerGrowDirection)
	personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing)
	personalAuraIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
	personalAuraStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
	personalAuraMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
	if personalAuraTextMesssageScale then
		personalAuraTextMesssageScale:SetValue(DBM.Options.PrivateAurasTextAnchorScale)
	end
	if personalUpscaleDText then
		personalUpscaleDText:SetChecked(DBM.Options.PrivateAurasPlayerUpscaleDuration)
	end
	--personalPASound:SetChecked(DBM.Options.DontPlayPrivateAuraSound)
	--TODO, PrivateAurasPlayerXOffset and PrivateAurasPlayerYOffset are not yet implemented, need to add those to the UI and then set them here as well
	OnAuraSettingsChange(true)
end)

----------------------------------
--  Co-Tank Aura Frame  --
----------------------------------
local coTankAuraArea		= auraPanel:CreateArea(L.Area_TankPrivateAuras)
local coTankAuraIcon		= coTankAuraArea:CreateCheckButton(L.EnableTankPrivateAuraIcons, true, nil, "PrivateAurasCoTankEnabled")
coTankAuraIcon:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankEnabled = not DBM.Options.PrivateAurasCoTankEnabled
	OnAuraSettingsChange(false)
end)
local coTankAuraSecond	= coTankAuraArea:CreateCheckButton(L.ShowSecondCoTank, true, nil, "PrivateAurasCoTankShowSecond")
coTankAuraSecond:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankShowSecond = not DBM.Options.PrivateAurasCoTankShowSecond
	OnAuraSettingsChange(false)
end)
local coTankUpscaleDText
if not isAuraTracking121 then
	coTankUpscaleDText = coTankAuraArea:CreateCheckButton(L.UpscaleDurationText, true, nil, "PrivateAurasCoTankUpscaleDuration")
	coTankUpscaleDText:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankUpscaleDuration = not DBM.Options.PrivateAurasCoTankUpscaleDuration
		OnAuraSettingsChange(true)
	end)
end
local coTankAuraBorder 	= coTankAuraArea:CreateCheckButton(L.HidePABorder, true, nil, "PrivateAurasCoTankHideBorder")
coTankAuraBorder:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankHideBorder = not DBM.Options.PrivateAurasCoTankHideBorder
	OnAuraSettingsChange(false)
end)
local coTankAuraTooltip	= coTankAuraArea:CreateCheckButton(L.HidePATooltip, true, nil, "PrivateAurasCoTankHideTooltip")
coTankAuraTooltip:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankHideTooltip = not DBM.Options.PrivateAurasCoTankHideTooltip
	OnAuraSettingsChange(false)
end)
coTankAuraTooltip:SetPoint("TOPLEFT", coTankAuraBorder, "TOPLEFT", 150, 0)
coTankAuraTooltip.myheight = 0

local coTankGrowDir = coTankAuraArea:CreateDropdown(L.SetPAGrowDirection, growDirections, "DBM", "PrivateAurasCoTankGrowDirection", function(value)
	DBM.Options.PrivateAurasCoTankGrowDirection = value
	OnAuraSettingsChange(false)
end)
coTankGrowDir:SetPoint("TOPLEFT", coTankAuraBorder, "BOTTOMLEFT", 0, -20)
coTankGrowDir.myheight = 30

local coTankSpacing = coTankAuraArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150)
coTankSpacing:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 180, 0)
coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
coTankSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankSpacing = self:GetValue()
	OnAuraSettingsChange(false)
end)
coTankSpacing.myheight = 0

local coTankIconScale = coTankAuraArea:CreateSlider(L.SetPAIconScale, 50, 150, 1, 150)
coTankIconScale:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 0, -50)
coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
coTankIconScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankWidth = self:GetValue()
	DBM.Options.PrivateAurasCoTankHeight = self:GetValue()
	OnAuraSettingsChange(false)
end)
coTankIconScale.myheight = 50

local coTankAuraMaxIcons = coTankAuraArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150)
coTankAuraMaxIcons:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 180, 0)
coTankAuraMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
coTankAuraMaxIcons:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankLimit = self:GetValue()
	OnAuraSettingsChange(false)
end)
coTankAuraMaxIcons.myheight = 0

local coTankStackScale = coTankAuraArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
coTankStackScale:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)
coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
coTankStackScale:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankScale = self:GetValue()
	OnAuraSettingsChange(false)
end)

local coTankMovemebutton = coTankAuraArea:CreateButton(L.MoveMe, 100, 16)
coTankMovemebutton:SetPoint("TOPRIGHT", coTankAuraArea.frame, "TOPRIGHT", -2, -4)
coTankMovemebutton:SetNormalFontObject(GameFontNormalSmall)
coTankMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
coTankMovemebutton:SetScript("OnClick", function()
	ToggleAuraPreview()
end)

local coTankAuraReset = coTankAuraArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
coTankAuraReset:SetPoint("BOTTOMRIGHT", coTankAuraArea.frame, "BOTTOMRIGHT", -2, 4)
coTankAuraReset:SetNormalFontObject(GameFontNormalSmall)
coTankAuraReset:SetHighlightFontObject(GameFontNormalSmall)
coTankAuraReset:SetScript("OnClick", function()
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
	if not isAuraTracking121 then
		DBM.Options.PrivateAurasCoTankUpscaleDuration = DBM.DefaultOptions.PrivateAurasCoTankUpscaleDuration
	end
	DBM.Options.PrivateAurasCoTankShowSecond = DBM.DefaultOptions.PrivateAurasCoTankShowSecond
	-- Set UI visuals
	coTankAuraIcon:SetChecked(DBM.Options.PrivateAurasCoTankEnabled)
	coTankAuraSecond:SetChecked(DBM.Options.PrivateAurasCoTankShowSecond)
	coTankAuraBorder:SetChecked(DBM.Options.PrivateAurasCoTankHideBorder)
	coTankAuraTooltip:SetChecked(DBM.Options.PrivateAurasCoTankHideTooltip)
	coTankGrowDir:SetSelectedValue(DBM.Options.PrivateAurasCoTankGrowDirection)
	coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing)
	coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
	coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
	coTankAuraMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
	--TODO, PrivateAurasCoTankXOffset and PrivateAurasCoTankYOffset are not yet implemented, need to add those to the UI and then set them here as well
	if coTankUpscaleDText then
		coTankUpscaleDText:SetChecked(DBM.Options.PrivateAurasCoTankUpscaleDuration)
	end
	OnAuraSettingsChange(false)
end)
