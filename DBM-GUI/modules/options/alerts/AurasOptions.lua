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

local Fonts = DBM_GUI:MixinSharedMedia3("font", {
	{
		text	= DEFAULT,
		value	= "standardFont"
	},
	{
		text	= "Arial",
		value	= "Fonts\\ARIALN.TTF"
	},
	{
		text	= "Skurri",
		value	= "Fonts\\SKURRI_CYR.ttf"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS_CYR.ttf"
	}
})

local FontStyles = {
	{
		text	= L.None,
		value	= "None"
	},
	{
		text	= L.Outline,
		value	= "OUTLINE",
		flag	= true
	},
	{
		text	= L.ThickOutline,
		value	= "THICKOUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeOutline,
		value	= "MONOCHROME,OUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeThickOutline,
		value	= "MONOCHROME,THICKOUTLINE",
		flag	= true
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
personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing2)
personalSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasPlayerSpacing2 = self:GetValue()
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

local personalAuraStackScale
if not isAuraTracking121 then
	personalAuraStackScale = personalAuraArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
	personalAuraStackScale:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 0, -50)
	personalAuraStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
	personalAuraStackScale:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasPlayerScale = self:GetValue()
		OnAuraSettingsChange(true)
	end)
	personalAuraStackScale.myheight = 50
end

local personalAuraFontDropDown
local personalAuraFontStyleDropDown
local personalAuraDurationFontSize
local personalAuraStackFontSize
local personalAuraStackColor
local personalAuraStackXOffset
local personalAuraStackYOffset
local personalAuraShowStacks
local personalAuraShowDispelBorder
if isAuraTracking121 then
	personalAuraFontDropDown = personalAuraArea:CreateDropdown(L.FontType, Fonts, "DBM", "PrivateAurasPlayerTextFont", function(value)
		DBM.Options.PrivateAurasPlayerTextFont = value
		OnAuraSettingsChange(true)
	end)
	personalAuraFontDropDown:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 0, -50)

	personalAuraFontStyleDropDown = personalAuraArea:CreateDropdown(L.FontStyle, FontStyles, "DBM", "PrivateAurasPlayerTextFontStyle", function(value)
		DBM.Options.PrivateAurasPlayerTextFontStyle = value
		OnAuraSettingsChange(true)
	end)
	personalAuraFontStyleDropDown:SetPoint("LEFT", personalAuraFontDropDown, "RIGHT", 25, 0)
	personalAuraFontStyleDropDown.myheight = 0

	personalAuraDurationFontSize = personalAuraArea:CreateSlider(L.AuraDurationFontSize, 8, 60, 1, 150)
	personalAuraDurationFontSize:SetPoint("TOPLEFT", personalAuraFontDropDown, "TOPLEFT", 20, -50)
	personalAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasPlayerDurationFontSize)
	personalAuraDurationFontSize:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasPlayerDurationFontSize = self:GetValue()
		OnAuraSettingsChange(true)
	end)

	personalAuraStackFontSize = personalAuraArea:CreateSlider(L.AuraStackFontSize, 8, 60, 1, 150)
	personalAuraStackFontSize:SetPoint("TOPLEFT", personalAuraDurationFontSize, "TOPLEFT", 180, 0)
	personalAuraStackFontSize:SetValue(DBM.Options.PrivateAurasPlayerStackFontSize)
	personalAuraStackFontSize:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasPlayerStackFontSize = self:GetValue()
		OnAuraSettingsChange(true)
	end)
	personalAuraStackFontSize.myheight = 0

	personalAuraShowStacks = personalAuraArea:CreateCheckButton(L.AuraShowStacks, true, nil, "PrivateAurasPlayerShowStacks")
	personalAuraShowStacks:SetScript("OnClick", function()
		DBM.Options.PrivateAurasPlayerShowStacks = not DBM.Options.PrivateAurasPlayerShowStacks
		OnAuraSettingsChange(true)
	end)
	personalAuraShowStacks:SetPoint("TOPLEFT", personalAuraDurationFontSize, "TOPLEFT", 0, -40)

	personalAuraShowDispelBorder = personalAuraArea:CreateCheckButton(L.AuraShowDispelBorder, true, nil, "PrivateAurasPlayerShowDispelBorder")
	personalAuraShowDispelBorder:SetScript("OnClick", function()
		DBM.Options.PrivateAurasPlayerShowDispelBorder = not DBM.Options.PrivateAurasPlayerShowDispelBorder
		OnAuraSettingsChange(true)
	end)
	personalAuraShowDispelBorder:SetPoint("TOPLEFT", personalAuraShowStacks, "TOPLEFT", 200, 0)
	personalAuraShowDispelBorder.myheight = 0

	personalAuraStackColor = personalAuraArea:CreateColorSelect(L.FontColor, function(_, r, g, b)
		DBM.Options.PrivateAurasPlayerStackColor.r = r
		DBM.Options.PrivateAurasPlayerStackColor.g = g
		DBM.Options.PrivateAurasPlayerStackColor.b = b
		OnAuraSettingsChange(true)
	end, function(self)
		local color = DBM.DefaultOptions.PrivateAurasPlayerStackColor
		self:SetColorRGB(color.r, color.g, color.b, true)
	end)
	personalAuraStackColor:SetPoint("TOPLEFT", personalAuraShowStacks, "TOPLEFT", 0, -45)
	personalAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasPlayerStackColor.r, DBM.Options.PrivateAurasPlayerStackColor.g, DBM.Options.PrivateAurasPlayerStackColor.b)

	personalAuraStackXOffset = personalAuraArea:CreateSlider(L.Slider_TextOffSetX, -20, 20, 1, 150)
	personalAuraStackXOffset:SetPoint("TOPLEFT", personalAuraStackColor, "TOPLEFT", 130, 0)
	personalAuraStackXOffset:SetValue(DBM.Options.PrivateAurasPlayerStackXOffset)
	personalAuraStackXOffset:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasPlayerStackXOffset = self:GetValue()
		OnAuraSettingsChange(true)
	end)

	personalAuraStackYOffset = personalAuraArea:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 150)
	personalAuraStackYOffset:SetPoint("TOPLEFT", personalAuraStackXOffset, "TOPLEFT", 180, 0)
	personalAuraStackYOffset:SetValue(DBM.Options.PrivateAurasPlayerStackYOffset)
	personalAuraStackYOffset:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasPlayerStackYOffset = self:GetValue()
		OnAuraSettingsChange(true)
	end)
	personalAuraStackYOffset.myheight = 0
	personalAuraStackColor.myheight = 135
end

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
	DBM.Options.PrivateAurasPlayerSpacing2 = DBM.DefaultOptions.PrivateAurasPlayerSpacing2
	DBM.Options.PrivateAurasPlayerWidth = DBM.DefaultOptions.PrivateAurasPlayerWidth
	DBM.Options.PrivateAurasPlayerHeight = DBM.DefaultOptions.PrivateAurasPlayerHeight
	DBM.Options.PrivateAurasPlayerScale = DBM.DefaultOptions.PrivateAurasPlayerScale
	DBM.Options.PrivateAurasPlayerLimit = DBM.DefaultOptions.PrivateAurasPlayerLimit
	if isAuraTracking121 then
		DBM.Options.PrivateAurasPlayerTextFont = DBM.DefaultOptions.PrivateAurasPlayerTextFont
		DBM.Options.PrivateAurasPlayerTextFontStyle = DBM.DefaultOptions.PrivateAurasPlayerTextFontStyle
		DBM.Options.PrivateAurasPlayerDurationFontSize = DBM.DefaultOptions.PrivateAurasPlayerDurationFontSize
		DBM.Options.PrivateAurasPlayerStackFontSize = DBM.DefaultOptions.PrivateAurasPlayerStackFontSize
		DBM.Options.PrivateAurasPlayerStackColor = CopyTable(DBM.DefaultOptions.PrivateAurasPlayerStackColor)
		DBM.Options.PrivateAurasPlayerStackXOffset = DBM.DefaultOptions.PrivateAurasPlayerStackXOffset
		DBM.Options.PrivateAurasPlayerStackYOffset = DBM.DefaultOptions.PrivateAurasPlayerStackYOffset
		DBM.Options.PrivateAurasPlayerShowStacks = DBM.DefaultOptions.PrivateAurasPlayerShowStacks
		DBM.Options.PrivateAurasPlayerShowDispelBorder = DBM.DefaultOptions.PrivateAurasPlayerShowDispelBorder
	end
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
		DBM.Options.PrivateAurasTextAnchorAnchor = DBM.DefaultOptions.PrivateAurasTextAnchorAnchor
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
	personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing2)
	personalAuraIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
	if personalAuraStackScale then
		personalAuraStackScale:SetValue(DBM.Options.PrivateAurasPlayerScale)
	end
	personalAuraMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
	if isAuraTracking121 then
		personalAuraFontDropDown:SetSelectedValue(DBM.Options.PrivateAurasPlayerTextFont)
		personalAuraFontStyleDropDown:SetSelectedValue(DBM.Options.PrivateAurasPlayerTextFontStyle)
		personalAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasPlayerDurationFontSize)
		personalAuraStackFontSize:SetValue(DBM.Options.PrivateAurasPlayerStackFontSize)
		personalAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasPlayerStackColor.r, DBM.Options.PrivateAurasPlayerStackColor.g, DBM.Options.PrivateAurasPlayerStackColor.b)
		personalAuraStackXOffset:SetValue(DBM.Options.PrivateAurasPlayerStackXOffset)
		personalAuraStackYOffset:SetValue(DBM.Options.PrivateAurasPlayerStackYOffset)
		personalAuraShowStacks:SetChecked(DBM.Options.PrivateAurasPlayerShowStacks)
		personalAuraShowDispelBorder:SetChecked(DBM.Options.PrivateAurasPlayerShowDispelBorder)
	end
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
		OnAuraSettingsChange(false)
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
coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing2)
coTankSpacing:HookScript("OnValueChanged", function(self)
	DBM.Options.PrivateAurasCoTankSpacing2 = self:GetValue()
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

local coTankStackScale
if not isAuraTracking121 then
	coTankStackScale = coTankAuraArea:CreateSlider(L.SetPAStackScale, 1, 10, 1, 150)
	coTankStackScale:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)
	coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
	coTankStackScale:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasCoTankScale = self:GetValue()
		OnAuraSettingsChange(false)
	end)
end

local coTankAuraFontDropDown
local coTankAuraFontStyleDropDown
local coTankAuraDurationFontSize
local coTankAuraStackFontSize
local coTankAuraStackColor
local coTankAuraStackXOffset
local coTankAuraStackYOffset
local coTankAuraShowStacks
local coTankAuraShowDispelBorder
if isAuraTracking121 then
	coTankAuraFontDropDown = coTankAuraArea:CreateDropdown(L.FontType, Fonts, "DBM", "PrivateAurasCoTankTextFont", function(value)
		DBM.Options.PrivateAurasCoTankTextFont = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraFontDropDown:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)

	coTankAuraFontStyleDropDown = coTankAuraArea:CreateDropdown(L.FontStyle, FontStyles, "DBM", "PrivateAurasCoTankTextFontStyle", function(value)
		DBM.Options.PrivateAurasCoTankTextFontStyle = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraFontStyleDropDown:SetPoint("LEFT", coTankAuraFontDropDown, "RIGHT", 25, 0)
	coTankAuraFontStyleDropDown.myheight = 0

	coTankAuraDurationFontSize = coTankAuraArea:CreateSlider(L.AuraDurationFontSize, 8, 60, 1, 150)
	coTankAuraDurationFontSize:SetPoint("TOPLEFT", coTankAuraFontDropDown, "TOPLEFT", 20, -50)
	coTankAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasCoTankDurationFontSize)
	coTankAuraDurationFontSize:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasCoTankDurationFontSize = self:GetValue()
		OnAuraSettingsChange(false)
	end)

	coTankAuraStackFontSize = coTankAuraArea:CreateSlider(L.AuraStackFontSize, 8, 60, 1, 150)
	coTankAuraStackFontSize:SetPoint("TOPLEFT", coTankAuraDurationFontSize, "TOPLEFT", 180, 0)
	coTankAuraStackFontSize:SetValue(DBM.Options.PrivateAurasCoTankStackFontSize)
	coTankAuraStackFontSize:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasCoTankStackFontSize = self:GetValue()
		OnAuraSettingsChange(false)
	end)
	coTankAuraStackFontSize.myheight = 0

	coTankAuraShowStacks = coTankAuraArea:CreateCheckButton(L.AuraShowStacks, true, nil, "PrivateAurasCoTankShowStacks")
	coTankAuraShowStacks:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankShowStacks = not DBM.Options.PrivateAurasCoTankShowStacks
		OnAuraSettingsChange(false)
	end)
	coTankAuraShowStacks:SetPoint("TOPLEFT", coTankAuraDurationFontSize, "TOPLEFT", 0, -40)

	coTankAuraShowDispelBorder = coTankAuraArea:CreateCheckButton(L.AuraShowDispelBorder, true, nil, "PrivateAurasCoTankShowDispelBorder")
	coTankAuraShowDispelBorder:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankShowDispelBorder = not DBM.Options.PrivateAurasCoTankShowDispelBorder
		OnAuraSettingsChange(false)
	end)
	coTankAuraShowDispelBorder:SetPoint("TOPLEFT", coTankAuraShowStacks, "TOPLEFT", 200, 0)
	coTankAuraShowDispelBorder.myheight = 0

	coTankAuraStackColor = coTankAuraArea:CreateColorSelect(L.FontColor, function(_, r, g, b)
		DBM.Options.PrivateAurasCoTankStackColor.r = r
		DBM.Options.PrivateAurasCoTankStackColor.g = g
		DBM.Options.PrivateAurasCoTankStackColor.b = b
		OnAuraSettingsChange(false)
	end, function(self)
		local color = DBM.DefaultOptions.PrivateAurasCoTankStackColor
		self:SetColorRGB(color.r, color.g, color.b, true)
	end)
	coTankAuraStackColor:SetPoint("TOPLEFT", coTankAuraShowStacks, "TOPLEFT", 0, -45)
	coTankAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasCoTankStackColor.r, DBM.Options.PrivateAurasCoTankStackColor.g, DBM.Options.PrivateAurasCoTankStackColor.b)

	coTankAuraStackXOffset = coTankAuraArea:CreateSlider(L.Slider_TextOffSetX, -20, 20, 1, 150)
	coTankAuraStackXOffset:SetPoint("TOPLEFT", coTankAuraStackColor, "TOPLEFT", 130, 0)
	coTankAuraStackXOffset:SetValue(DBM.Options.PrivateAurasCoTankStackXOffset)
	coTankAuraStackXOffset:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasCoTankStackXOffset = self:GetValue()
		OnAuraSettingsChange(false)
	end)

	coTankAuraStackYOffset = coTankAuraArea:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 150)
	coTankAuraStackYOffset:SetPoint("TOPLEFT", coTankAuraStackXOffset, "TOPLEFT", 180, 0)
	coTankAuraStackYOffset:SetValue(DBM.Options.PrivateAurasCoTankStackYOffset)
	coTankAuraStackYOffset:HookScript("OnValueChanged", function(self)
		DBM.Options.PrivateAurasCoTankStackYOffset = self:GetValue()
		OnAuraSettingsChange(false)
	end)
	coTankAuraStackYOffset.myheight = 0
	coTankAuraStackColor.myheight = 135
end

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
	DBM.Options.PrivateAurasCoTankSpacing2 = DBM.DefaultOptions.PrivateAurasCoTankSpacing2
	DBM.Options.PrivateAurasCoTankWidth = DBM.DefaultOptions.PrivateAurasCoTankWidth
	DBM.Options.PrivateAurasCoTankHeight = DBM.DefaultOptions.PrivateAurasCoTankHeight
	DBM.Options.PrivateAurasCoTankScale = DBM.DefaultOptions.PrivateAurasCoTankScale
	DBM.Options.PrivateAurasCoTankLimit = DBM.DefaultOptions.PrivateAurasCoTankLimit
	if isAuraTracking121 then
		DBM.Options.PrivateAurasCoTankTextFont = DBM.DefaultOptions.PrivateAurasCoTankTextFont
		DBM.Options.PrivateAurasCoTankTextFontStyle = DBM.DefaultOptions.PrivateAurasCoTankTextFontStyle
		DBM.Options.PrivateAurasCoTankDurationFontSize = DBM.DefaultOptions.PrivateAurasCoTankDurationFontSize
		DBM.Options.PrivateAurasCoTankStackFontSize = DBM.DefaultOptions.PrivateAurasCoTankStackFontSize
		DBM.Options.PrivateAurasCoTankStackColor = CopyTable(DBM.DefaultOptions.PrivateAurasCoTankStackColor)
		DBM.Options.PrivateAurasCoTankStackXOffset = DBM.DefaultOptions.PrivateAurasCoTankStackXOffset
		DBM.Options.PrivateAurasCoTankStackYOffset = DBM.DefaultOptions.PrivateAurasCoTankStackYOffset
		DBM.Options.PrivateAurasCoTankShowStacks = DBM.DefaultOptions.PrivateAurasCoTankShowStacks
		DBM.Options.PrivateAurasCoTankShowDispelBorder = DBM.DefaultOptions.PrivateAurasCoTankShowDispelBorder
	end
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
	coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing2)
	coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
	if coTankStackScale then
		coTankStackScale:SetValue(DBM.Options.PrivateAurasCoTankScale)
	end
	coTankAuraMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
	if isAuraTracking121 then
		coTankAuraFontDropDown:SetSelectedValue(DBM.Options.PrivateAurasCoTankTextFont)
		coTankAuraFontStyleDropDown:SetSelectedValue(DBM.Options.PrivateAurasCoTankTextFontStyle)
		coTankAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasCoTankDurationFontSize)
		coTankAuraStackFontSize:SetValue(DBM.Options.PrivateAurasCoTankStackFontSize)
		coTankAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasCoTankStackColor.r, DBM.Options.PrivateAurasCoTankStackColor.g, DBM.Options.PrivateAurasCoTankStackColor.b)
		coTankAuraStackXOffset:SetValue(DBM.Options.PrivateAurasCoTankStackXOffset)
		coTankAuraStackYOffset:SetValue(DBM.Options.PrivateAurasCoTankStackYOffset)
		coTankAuraShowStacks:SetChecked(DBM.Options.PrivateAurasCoTankShowStacks)
		coTankAuraShowDispelBorder:SetChecked(DBM.Options.PrivateAurasCoTankShowDispelBorder)
	end
	--TODO, PrivateAurasCoTankXOffset and PrivateAurasCoTankYOffset are not yet implemented, need to add those to the UI and then set them here as well
	if coTankUpscaleDText then
		coTankUpscaleDText:SetChecked(DBM.Options.PrivateAurasCoTankUpscaleDuration)
	end
	OnAuraSettingsChange(false)
end)
