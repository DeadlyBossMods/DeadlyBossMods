local L = DBM_GUI_L

local function OnAuraSettingsChange(player)
	local auraHandler = DBM.Auras
	if auraHandler and auraHandler.OnSettingsChange then
		auraHandler:OnSettingsChange(player)
	end
end

local function ToggleAuraPreview()
	local auraHandler = DBM.Auras
	if auraHandler and auraHandler.PreviewToggle then
		return auraHandler:PreviewToggle()
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

local auraSortModes = {
	{
		text	= L.AuraSortDefault,
		value	= "Default"
	},
	{
		text	= L.AuraSortShortDurationFirst,
		value	= "ShortDurationFirst"
	},
	{
		text	= L.AuraSortLongDurationFirst,
		value	= "LongDurationFirst"
	}
}

local coTankVisibilityModes = {
	{
		text	= L.CoTankVisibilityAuto,
		value	= "Auto"
	},
	{
		text	= L.CoTankVisibilityAlways,
		value	= "Always"
	},
	{
		text	= L.CoTankVisibilityNever,
		value	= "Never"
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

-----------------------------------
--  Personal Aura Frame  --
-----------------------------------
local personalAuraArea 	= auraPanel:CreateArea(L.Area_PersonalPrivateAuras)
local personalAuraIcon	= personalAuraArea:CreateCheckButton(L.EnablePersonalPrivateAuraIcons, true, nil, "PrivateAurasPlayerEnabled2")
personalAuraIcon:SetScript("OnClick", function()
	DBM.Options.PrivateAurasPlayerEnabled2 = not DBM.Options.PrivateAurasPlayerEnabled2
	OnAuraSettingsChange(true)
end)
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

local personalSpacing = personalAuraArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150, DBM.Options.PrivateAurasPlayerSpacing2, function(value)
	DBM.Options.PrivateAurasPlayerSpacing2 = value
	OnAuraSettingsChange(true)
end)
personalSpacing:SetPoint("TOPLEFT", personalAuraGrowDir, "TOPLEFT", 180, 0)
personalSpacing.myheight = 0

local personalAuraIconScale = personalAuraArea:CreateSlider(L.SetPAIconScale, 25, 150, 1, 150, DBM.Options.PrivateAurasPlayerWidth, function(value)
	DBM.Options.PrivateAurasPlayerWidth = value
	DBM.Options.PrivateAurasPlayerHeight = value
	OnAuraSettingsChange(true)
end)
personalAuraIconScale:SetPoint("TOPLEFT", personalAuraGrowDir, "TOPLEFT", 0, -50)
personalAuraIconScale.myheight = 50

local personalAuraMaxIcons = personalAuraArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150, DBM.Options.PrivateAurasPlayerLimit, function(value)
	DBM.Options.PrivateAurasPlayerLimit = value
	OnAuraSettingsChange(true)
end)
personalAuraMaxIcons:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 180, 0)
personalAuraMaxIcons.myheight = 0

local personalAuraFontDropDown
local personalAuraFontStyleDropDown
local personalAuraDurationFontSize
local personalAuraShowDecimalSeconds
local personalAuraDecimalThreshold
local personalAuraStackFontSize
local personalAuraStackColor
local personalAuraStackXOffset
local personalAuraStackYOffset
local personalAuraShowStacks
local personalAuraShowDispelBorder
local personalAuraSort

personalAuraFontDropDown = personalAuraArea:CreateDropdown(L.FontType, Fonts, "DBM", "PrivateAurasPlayerTextFont", function(value)
		DBM.Options.PrivateAurasPlayerTextFont = value
		OnAuraSettingsChange(true)
	end)
	personalAuraFontDropDown:SetPoint("TOPLEFT", personalAuraIconScale, "TOPLEFT", 0, -50)

	personalAuraFontStyleDropDown = personalAuraArea:CreateFontDropdown(L.FontStyle, "DBM", "PrivateAurasPlayerTextFontStyle", function(value)
		DBM.Options.PrivateAurasPlayerTextFontStyle = value
		OnAuraSettingsChange(true)
	end)
	personalAuraFontStyleDropDown:SetPoint("LEFT", personalAuraFontDropDown, "RIGHT", 25, 0)
	personalAuraFontStyleDropDown.myheight = 0

	personalAuraSort = personalAuraArea:CreateDropdown(L.AuraSortOrder, auraSortModes, "DBM", "PrivateAurasPlayerSortMode", function(value)
		DBM.Options.PrivateAurasPlayerSortMode = value
		OnAuraSettingsChange(true)
	end)
	personalAuraSort:SetPoint("TOPLEFT", personalAuraFontDropDown, "TOPLEFT", 0, -50)
	personalAuraSort.myheight = 50

	personalAuraDurationFontSize = personalAuraArea:CreateSlider(L.AuraDurationFontSize, 8, 60, 1, 150, DBM.Options.PrivateAurasPlayerDurationFontSize, function(value)
		DBM.Options.PrivateAurasPlayerDurationFontSize = value
		OnAuraSettingsChange(true)
	end)
	personalAuraDurationFontSize:SetPoint("TOPLEFT", personalAuraSort, "TOPLEFT", 20, -50)

	personalAuraShowDecimalSeconds = personalAuraArea:CreateCheckButton(L.AuraShowDecimalSeconds, true, nil, "PrivateAurasPlayerShowDecimalSeconds")
	personalAuraShowDecimalSeconds:SetScript("OnClick", function()
		DBM.Options.PrivateAurasPlayerShowDecimalSeconds = not DBM.Options.PrivateAurasPlayerShowDecimalSeconds
		OnAuraSettingsChange(true)
	end)
	personalAuraShowDecimalSeconds:SetPoint("TOPLEFT", personalAuraDurationFontSize, "TOPLEFT", -20, -40)
	personalAuraShowDecimalSeconds.myheight = 20

	personalAuraDecimalThreshold = personalAuraArea:CreateSlider(L.AuraDecimalThreshold, 0.1, 10, 0.1, 150, DBM.Options.PrivateAurasPlayerDecimalThreshold, function(value)
		DBM.Options.PrivateAurasPlayerDecimalThreshold = value
		OnAuraSettingsChange(true)
	end)
	personalAuraDecimalThreshold.myheight = 0

	personalAuraStackFontSize = personalAuraArea:CreateSlider(L.AuraStackFontSize, 8, 60, 1, 150, DBM.Options.PrivateAurasPlayerStackFontSize, function(value)
		DBM.Options.PrivateAurasPlayerStackFontSize = value
		OnAuraSettingsChange(true)
	end)
	personalAuraStackFontSize:SetPoint("TOPLEFT", personalAuraDurationFontSize, "TOPLEFT", 180, 0)
	personalAuraStackFontSize.myheight = 0
	personalAuraDecimalThreshold:SetPoint("TOPLEFT", personalAuraStackFontSize, "TOPLEFT", 0, -45)

	personalAuraShowStacks = personalAuraArea:CreateCheckButton(L.AuraShowStacks, true, nil, "PrivateAurasPlayerShowStacks")
	personalAuraShowStacks:SetScript("OnClick", function()
		DBM.Options.PrivateAurasPlayerShowStacks = not DBM.Options.PrivateAurasPlayerShowStacks
		OnAuraSettingsChange(true)
	end)
	personalAuraShowStacks:SetPoint("TOPLEFT", personalAuraShowDecimalSeconds, "TOPLEFT", 0, -40)

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

	personalAuraStackXOffset = personalAuraArea:CreateSlider(L.Slider_TextOffSetX, -20, 20, 1, 150, DBM.Options.PrivateAurasPlayerStackXOffset, function(value)
		DBM.Options.PrivateAurasPlayerStackXOffset = value
		OnAuraSettingsChange(true)
	end)
	personalAuraStackXOffset:SetPoint("TOPLEFT", personalAuraStackColor, "TOPLEFT", 130, 0)

	personalAuraStackYOffset = personalAuraArea:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 150, DBM.Options.PrivateAurasPlayerStackYOffset, function(value)
		DBM.Options.PrivateAurasPlayerStackYOffset = value
		OnAuraSettingsChange(true)
	end)
	personalAuraStackYOffset:SetPoint("TOPLEFT", personalAuraStackXOffset, "TOPLEFT", 180, 0)
	personalAuraStackYOffset.myheight = 0
	personalAuraStackColor.myheight = 50

local personalMovemebutton = personalAuraArea:CreateButton(L.MoveMe, 100, 16)
personalMovemebutton:SetPoint("TOPRIGHT", personalAuraArea.frame, "TOPRIGHT", -2, -4)
personalMovemebutton:SetNormalFontObject(GameFontNormalSmall)
personalMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
personalMovemebutton:SetScript("OnClick", function()
	DBM_GUI:CollapseForPreview(ToggleAuraPreview())
end)

local personalAuraReset = personalAuraArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
personalAuraReset:SetPoint("BOTTOMRIGHT", personalAuraArea.frame, "BOTTOMRIGHT", -2, 4)
personalAuraReset:SetNormalFontObject(GameFontNormalSmall)
personalAuraReset:SetHighlightFontObject(GameFontNormalSmall)
personalAuraReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasPlayerEnabled2 = DBM.DefaultOptions.PrivateAurasPlayerEnabled2
	DBM.Options.PrivateAurasPlayerHideBorder = DBM.DefaultOptions.PrivateAurasPlayerHideBorder
	DBM.Options.PrivateAurasPlayerHideTooltip = DBM.DefaultOptions.PrivateAurasPlayerHideTooltip
	DBM.Options.PrivateAurasPlayerGrowDirection = DBM.DefaultOptions.PrivateAurasPlayerGrowDirection
	DBM.Options.PrivateAurasPlayerSortMode = DBM.DefaultOptions.PrivateAurasPlayerSortMode
	DBM.Options.PrivateAurasPlayerSpacing2 = DBM.DefaultOptions.PrivateAurasPlayerSpacing2
	DBM.Options.PrivateAurasPlayerWidth = DBM.DefaultOptions.PrivateAurasPlayerWidth
	DBM.Options.PrivateAurasPlayerHeight = DBM.DefaultOptions.PrivateAurasPlayerHeight
	DBM.Options.PrivateAurasPlayerLimit = DBM.DefaultOptions.PrivateAurasPlayerLimit
	DBM.Options.PrivateAurasPlayerTextFont = DBM.DefaultOptions.PrivateAurasPlayerTextFont
	DBM.Options.PrivateAurasPlayerTextFontStyle = DBM.DefaultOptions.PrivateAurasPlayerTextFontStyle
	DBM.Options.PrivateAurasPlayerDurationFontSize = DBM.DefaultOptions.PrivateAurasPlayerDurationFontSize
	DBM.Options.PrivateAurasPlayerShowDecimalSeconds = DBM.DefaultOptions.PrivateAurasPlayerShowDecimalSeconds
	DBM.Options.PrivateAurasPlayerDecimalThreshold = DBM.DefaultOptions.PrivateAurasPlayerDecimalThreshold
	DBM.Options.PrivateAurasPlayerStackFontSize = DBM.DefaultOptions.PrivateAurasPlayerStackFontSize
	DBM.Options.PrivateAurasPlayerStackColor = CopyTable(DBM.DefaultOptions.PrivateAurasPlayerStackColor)
	DBM.Options.PrivateAurasPlayerStackXOffset = DBM.DefaultOptions.PrivateAurasPlayerStackXOffset
	DBM.Options.PrivateAurasPlayerStackYOffset = DBM.DefaultOptions.PrivateAurasPlayerStackYOffset
	DBM.Options.PrivateAurasPlayerShowStacks = DBM.DefaultOptions.PrivateAurasPlayerShowStacks
	DBM.Options.PrivateAurasPlayerShowDispelBorder = DBM.DefaultOptions.PrivateAurasPlayerShowDispelBorder
	DBM.Options.PrivateAurasPlayerXOffset = DBM.DefaultOptions.PrivateAurasPlayerXOffset
	DBM.Options.PrivateAurasPlayerYOffset = DBM.DefaultOptions.PrivateAurasPlayerYOffset
	DBM.Options.PrivateAurasPlayerAnchor = DBM.DefaultOptions.PrivateAurasPlayerAnchor
	DBM.Options.PrivateAurasPlayerRelativeTo = DBM.DefaultOptions.PrivateAurasPlayerRelativeTo
	-- Set UI visuals
	personalAuraIcon:SetChecked(DBM.Options.PrivateAurasPlayerEnabled2)
	personalAuraBorder:SetChecked(DBM.Options.PrivateAurasPlayerHideBorder)
	personalAuraTooltip:SetChecked(DBM.Options.PrivateAurasPlayerHideTooltip)
	personalAuraGrowDir:SetSelectedValue(DBM.Options.PrivateAurasPlayerGrowDirection)
	personalAuraSort:SetSelectedValue(DBM.Options.PrivateAurasPlayerSortMode)
	personalSpacing:SetValue(DBM.Options.PrivateAurasPlayerSpacing2)
	personalAuraIconScale:SetValue(DBM.Options.PrivateAurasPlayerWidth)
	personalAuraMaxIcons:SetValue(DBM.Options.PrivateAurasPlayerLimit)
	personalAuraFontDropDown:SetSelectedValue(DBM.Options.PrivateAurasPlayerTextFont)
	personalAuraFontStyleDropDown:SetSelectedValue(DBM.Options.PrivateAurasPlayerTextFontStyle)
	personalAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasPlayerDurationFontSize)
	personalAuraShowDecimalSeconds:SetChecked(DBM.Options.PrivateAurasPlayerShowDecimalSeconds)
	personalAuraDecimalThreshold:SetValue(DBM.Options.PrivateAurasPlayerDecimalThreshold)
	personalAuraStackFontSize:SetValue(DBM.Options.PrivateAurasPlayerStackFontSize)
	personalAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasPlayerStackColor.r, DBM.Options.PrivateAurasPlayerStackColor.g, DBM.Options.PrivateAurasPlayerStackColor.b)
	personalAuraStackXOffset:SetValue(DBM.Options.PrivateAurasPlayerStackXOffset)
	personalAuraStackYOffset:SetValue(DBM.Options.PrivateAurasPlayerStackYOffset)
	personalAuraShowStacks:SetChecked(DBM.Options.PrivateAurasPlayerShowStacks)
	personalAuraShowDispelBorder:SetChecked(DBM.Options.PrivateAurasPlayerShowDispelBorder)
	OnAuraSettingsChange(true)
end)

----------------------------------
--  Co-Tank Aura Frame  --
----------------------------------
local coTankAuraArea		= auraPanel:CreateArea(L.Area_TankPrivateAuras)

local coTankAuraVisibility = coTankAuraArea:CreateDropdown(L.CoTankVisibility, coTankVisibilityModes, "DBM", "PrivateAurasCoTankEnabled3", function(value)
	DBM.Options.PrivateAurasCoTankEnabled3 = value
	OnAuraSettingsChange(false)
end)
coTankAuraVisibility:SetPoint("TOPLEFT", coTankAuraArea.frame, "TOPLEFT", 15, -35)
coTankAuraVisibility.myheight = 90
local coTankAuraSecond	= coTankAuraArea:CreateCheckButton(L.ShowSecondCoTank, true, nil, "PrivateAurasCoTankShowSecond")
coTankAuraSecond:SetScript("OnClick", function()
	DBM.Options.PrivateAurasCoTankShowSecond = not DBM.Options.PrivateAurasCoTankShowSecond
	OnAuraSettingsChange(false)
end)
coTankAuraSecond:SetPoint("TOPLEFT", coTankAuraVisibility, "BOTTOMLEFT", 0, -5)
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

local coTankSpacing = coTankAuraArea:CreateSlider(L.SetPAIconSpacing, -2, 5, 1, 150, DBM.Options.PrivateAurasCoTankSpacing2, function(value)
	DBM.Options.PrivateAurasCoTankSpacing2 = value
	OnAuraSettingsChange(false)
end)
coTankSpacing:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 180, 0)
coTankSpacing.myheight = 0

local coTankIconScale = coTankAuraArea:CreateSlider(L.SetPAIconScale, 25, 150, 1, 150, DBM.Options.PrivateAurasCoTankWidth, function(value)
	DBM.Options.PrivateAurasCoTankWidth = value
	DBM.Options.PrivateAurasCoTankHeight = value
	OnAuraSettingsChange(false)
end)
coTankIconScale:SetPoint("TOPLEFT", coTankGrowDir, "TOPLEFT", 0, -50)
coTankIconScale.myheight = 50

local coTankAuraMaxIcons = coTankAuraArea:CreateSlider(L.SetPAMaxIcons, 1, 10, 1, 150, DBM.Options.PrivateAurasCoTankLimit, function(value)
	DBM.Options.PrivateAurasCoTankLimit = value
	OnAuraSettingsChange(false)
end)
coTankAuraMaxIcons:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 180, 0)
coTankAuraMaxIcons.myheight = 0

local coTankAuraFontDropDown
local coTankAuraFontStyleDropDown
local coTankAuraDurationFontSize
local coTankAuraShowDecimalSeconds
local coTankAuraDecimalThreshold
local coTankAuraStackFontSize
local coTankAuraStackColor
local coTankAuraStackXOffset
local coTankAuraStackYOffset
local coTankAuraShowStacks
local coTankAuraShowDispelBorder
local coTankAuraSort
local coTankShowName
local coTankNameFontSize
local coTankNameXOffset
local coTankNameYOffset

coTankAuraFontDropDown = coTankAuraArea:CreateDropdown(L.FontType, Fonts, "DBM", "PrivateAurasCoTankTextFont", function(value)
		DBM.Options.PrivateAurasCoTankTextFont = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraFontDropDown:SetPoint("TOPLEFT", coTankIconScale, "TOPLEFT", 0, -50)

	coTankAuraFontStyleDropDown = coTankAuraArea:CreateFontDropdown(L.FontStyle, "DBM", "PrivateAurasCoTankTextFontStyle", function(value)
		DBM.Options.PrivateAurasCoTankTextFontStyle = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraFontStyleDropDown:SetPoint("LEFT", coTankAuraFontDropDown, "RIGHT", 25, 0)
	coTankAuraFontStyleDropDown.myheight = 0

	coTankAuraSort = coTankAuraArea:CreateDropdown(L.AuraSortOrder, auraSortModes, "DBM", "PrivateAurasCoTankSortMode", function(value)
		DBM.Options.PrivateAurasCoTankSortMode = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraSort:SetPoint("TOPLEFT", coTankAuraFontDropDown, "TOPLEFT", 0, -50)
	coTankAuraSort.myheight = 50

	coTankAuraDurationFontSize = coTankAuraArea:CreateSlider(L.AuraDurationFontSize, 8, 60, 1, 150, DBM.Options.PrivateAurasCoTankDurationFontSize, function(value)
		DBM.Options.PrivateAurasCoTankDurationFontSize = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraDurationFontSize:SetPoint("TOPLEFT", coTankAuraSort, "TOPLEFT", 20, -50)

	coTankAuraShowDecimalSeconds = coTankAuraArea:CreateCheckButton(L.AuraShowDecimalSeconds, true, nil, "PrivateAurasCoTankShowDecimalSeconds")
	coTankAuraShowDecimalSeconds:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankShowDecimalSeconds = not DBM.Options.PrivateAurasCoTankShowDecimalSeconds
		OnAuraSettingsChange(false)
	end)
	coTankAuraShowDecimalSeconds:SetPoint("TOPLEFT", coTankAuraDurationFontSize, "TOPLEFT", -20, -40)
	coTankAuraShowDecimalSeconds.myheight = 20

	coTankAuraDecimalThreshold = coTankAuraArea:CreateSlider(L.AuraDecimalThreshold, 0.1, 10, 0.1, 150, DBM.Options.PrivateAurasCoTankDecimalThreshold, function(value)
		DBM.Options.PrivateAurasCoTankDecimalThreshold = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraDecimalThreshold.myheight = 0

	coTankAuraStackFontSize = coTankAuraArea:CreateSlider(L.AuraStackFontSize, 8, 60, 1, 150, DBM.Options.PrivateAurasCoTankStackFontSize, function(value)
		DBM.Options.PrivateAurasCoTankStackFontSize = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraStackFontSize:SetPoint("TOPLEFT", coTankAuraDurationFontSize, "TOPLEFT", 180, 0)
	coTankAuraStackFontSize.myheight = 0
	coTankAuraDecimalThreshold:SetPoint("TOPLEFT", coTankAuraStackFontSize, "TOPLEFT", 0, -45)

	coTankAuraShowStacks = coTankAuraArea:CreateCheckButton(L.AuraShowStacks, true, nil, "PrivateAurasCoTankShowStacks")
	coTankAuraShowStacks:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankShowStacks = not DBM.Options.PrivateAurasCoTankShowStacks
		OnAuraSettingsChange(false)
	end)
	coTankAuraShowStacks:SetPoint("TOPLEFT", coTankAuraShowDecimalSeconds, "TOPLEFT", 0, -40)

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

	coTankAuraStackXOffset = coTankAuraArea:CreateSlider(L.Slider_TextOffSetX, -20, 20, 1, 150, DBM.Options.PrivateAurasCoTankStackXOffset, function(value)
		DBM.Options.PrivateAurasCoTankStackXOffset = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraStackXOffset:SetPoint("TOPLEFT", coTankAuraStackColor, "TOPLEFT", 130, 0)

	coTankAuraStackYOffset = coTankAuraArea:CreateSlider(L.Slider_TextOffSetY, -20, 20, 1, 150, DBM.Options.PrivateAurasCoTankStackYOffset, function(value)
		DBM.Options.PrivateAurasCoTankStackYOffset = value
		OnAuraSettingsChange(false)
	end)
	coTankAuraStackYOffset:SetPoint("TOPLEFT", coTankAuraStackXOffset, "TOPLEFT", 180, 0)
	coTankAuraStackYOffset.myheight = 0
	coTankAuraStackColor.myheight = 50

local coTankMovemebutton = coTankAuraArea:CreateButton(L.MoveMe, 100, 16)
coTankMovemebutton:SetPoint("TOPRIGHT", coTankAuraArea.frame, "TOPRIGHT", -2, -4)
coTankMovemebutton:SetNormalFontObject(GameFontNormalSmall)
coTankMovemebutton:SetHighlightFontObject(GameFontNormalSmall)
coTankMovemebutton:SetScript("OnClick", function()
	DBM_GUI:CollapseForPreview(ToggleAuraPreview())
end)

local coTankAuraReset = coTankAuraArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
coTankAuraReset:SetPoint("BOTTOMRIGHT", coTankAuraArea.frame, "BOTTOMRIGHT", -2, 4)
coTankAuraReset:SetNormalFontObject(GameFontNormalSmall)
coTankAuraReset:SetHighlightFontObject(GameFontNormalSmall)
coTankAuraReset:SetScript("OnClick", function()
	-- Set Default Options
	DBM.Options.PrivateAurasCoTankEnabled3 = DBM.DefaultOptions.PrivateAurasCoTankEnabled3
	DBM.Options.PrivateAurasCoTankHideBorder = DBM.DefaultOptions.PrivateAurasCoTankHideBorder
	DBM.Options.PrivateAurasCoTankHideTooltip = DBM.DefaultOptions.PrivateAurasCoTankHideTooltip
	DBM.Options.PrivateAurasCoTankGrowDirection = DBM.DefaultOptions.PrivateAurasCoTankGrowDirection
	DBM.Options.PrivateAurasCoTankSortMode = DBM.DefaultOptions.PrivateAurasCoTankSortMode
	DBM.Options.PrivateAurasCoTankSpacing2 = DBM.DefaultOptions.PrivateAurasCoTankSpacing2
	DBM.Options.PrivateAurasCoTankWidth = DBM.DefaultOptions.PrivateAurasCoTankWidth
	DBM.Options.PrivateAurasCoTankHeight = DBM.DefaultOptions.PrivateAurasCoTankHeight
	DBM.Options.PrivateAurasCoTankLimit = DBM.DefaultOptions.PrivateAurasCoTankLimit
	DBM.Options.PrivateAurasCoTankTextFont = DBM.DefaultOptions.PrivateAurasCoTankTextFont
	DBM.Options.PrivateAurasCoTankTextFontStyle = DBM.DefaultOptions.PrivateAurasCoTankTextFontStyle
	DBM.Options.PrivateAurasCoTankDurationFontSize = DBM.DefaultOptions.PrivateAurasCoTankDurationFontSize
	DBM.Options.PrivateAurasCoTankShowDecimalSeconds = DBM.DefaultOptions.PrivateAurasCoTankShowDecimalSeconds
	DBM.Options.PrivateAurasCoTankDecimalThreshold = DBM.DefaultOptions.PrivateAurasCoTankDecimalThreshold
	DBM.Options.PrivateAurasCoTankStackFontSize = DBM.DefaultOptions.PrivateAurasCoTankStackFontSize
	DBM.Options.PrivateAurasCoTankStackColor = CopyTable(DBM.DefaultOptions.PrivateAurasCoTankStackColor)
	DBM.Options.PrivateAurasCoTankStackXOffset = DBM.DefaultOptions.PrivateAurasCoTankStackXOffset
	DBM.Options.PrivateAurasCoTankStackYOffset = DBM.DefaultOptions.PrivateAurasCoTankStackYOffset
	DBM.Options.PrivateAurasCoTankShowStacks = DBM.DefaultOptions.PrivateAurasCoTankShowStacks
	DBM.Options.PrivateAurasCoTankShowDispelBorder = DBM.DefaultOptions.PrivateAurasCoTankShowDispelBorder
	DBM.Options.PrivateAurasCoTankXOffset = DBM.DefaultOptions.PrivateAurasCoTankXOffset
	DBM.Options.PrivateAurasCoTankYOffset = DBM.DefaultOptions.PrivateAurasCoTankYOffset
	DBM.Options.PrivateAurasCoTankAnchor = DBM.DefaultOptions.PrivateAurasCoTankAnchor
	DBM.Options.PrivateAurasCoTankRelativeTo = DBM.DefaultOptions.PrivateAurasCoTankRelativeTo
	DBM.Options.PrivateAurasCoTankShowSecond = DBM.DefaultOptions.PrivateAurasCoTankShowSecond
	-- Advanced options are reset via the Advanced reset button below
	-- Set UI visuals
	coTankAuraVisibility:SetSelectedValue(DBM.Options.PrivateAurasCoTankEnabled3)
	coTankAuraSecond:SetChecked(DBM.Options.PrivateAurasCoTankShowSecond)
	coTankAuraBorder:SetChecked(DBM.Options.PrivateAurasCoTankHideBorder)
	coTankAuraTooltip:SetChecked(DBM.Options.PrivateAurasCoTankHideTooltip)
	coTankGrowDir:SetSelectedValue(DBM.Options.PrivateAurasCoTankGrowDirection)
	coTankAuraSort:SetSelectedValue(DBM.Options.PrivateAurasCoTankSortMode)
	coTankSpacing:SetValue(DBM.Options.PrivateAurasCoTankSpacing2)
	coTankIconScale:SetValue(DBM.Options.PrivateAurasCoTankWidth)
	coTankAuraMaxIcons:SetValue(DBM.Options.PrivateAurasCoTankLimit)
	coTankAuraFontDropDown:SetSelectedValue(DBM.Options.PrivateAurasCoTankTextFont)
	coTankAuraFontStyleDropDown:SetSelectedValue(DBM.Options.PrivateAurasCoTankTextFontStyle)
	coTankAuraDurationFontSize:SetValue(DBM.Options.PrivateAurasCoTankDurationFontSize)
	coTankAuraShowDecimalSeconds:SetChecked(DBM.Options.PrivateAurasCoTankShowDecimalSeconds)
	coTankAuraDecimalThreshold:SetValue(DBM.Options.PrivateAurasCoTankDecimalThreshold)
	coTankAuraStackFontSize:SetValue(DBM.Options.PrivateAurasCoTankStackFontSize)
	coTankAuraStackColor:SetColorRGB(DBM.Options.PrivateAurasCoTankStackColor.r, DBM.Options.PrivateAurasCoTankStackColor.g, DBM.Options.PrivateAurasCoTankStackColor.b)
	coTankAuraStackXOffset:SetValue(DBM.Options.PrivateAurasCoTankStackXOffset)
	coTankAuraStackYOffset:SetValue(DBM.Options.PrivateAurasCoTankStackYOffset)
	coTankAuraShowStacks:SetChecked(DBM.Options.PrivateAurasCoTankShowStacks)
	coTankAuraShowDispelBorder:SetChecked(DBM.Options.PrivateAurasCoTankShowDispelBorder)
	OnAuraSettingsChange(false)
end)

local function GetCoTankRosterValues(excludedName)
		local values = {
			{
				text = L.CoTankAutomatic,
				value = "",
			},
		}
		local allowSelf = IsAltKeyDown()
		for unit in DBM:GetGroupMembers() do
			if allowSelf or not UnitIsUnit("player", unit) then
				local name = DBM:GetUnitFullName(unit)
				if name and name ~= excludedName then
					table.insert(values, {
						text = name,
						value = name,
					})
				end
			end
		end
		return values
	end


----------------------------------
--  Co-Tank Advanced Options  --
----------------------------------
local coTankAdvancedArea = auraPanel:CreateArea(L.Area_Advanced)
local alwaysShowPlayerAuras = coTankAdvancedArea:CreateCheckButton(L.AlwaysShowPlayerAuras, true, nil, "AlwaysShowPlayerAuras")
alwaysShowPlayerAuras:SetScript("OnClick", function()
	DBM.Options.AlwaysShowPlayerAuras = not DBM.Options.AlwaysShowPlayerAuras
	OnAuraSettingsChange(true)
end)
local coTankUseHealerInFiveMan = coTankAdvancedArea:CreateCheckButton(L.CoTankUseHealerInFiveMan, true, nil, "PrivateAurasCoTankUseHealerInFiveMan")

coTankUseHealerInFiveMan:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankUseHealerInFiveMan = not DBM.Options.PrivateAurasCoTankUseHealerInFiveMan
		OnAuraSettingsChange(false)
	end)

coTankShowName = coTankAdvancedArea:CreateCheckButton(L.CoTankShowPlayerName, true, nil, "PrivateAurasCoTankShowName")

coTankShowName:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankShowName = not DBM.Options.PrivateAurasCoTankShowName
		OnAuraSettingsChange(false)
	end)

coTankShowName:SetPoint("TOPLEFT", coTankUseHealerInFiveMan, "BOTTOMLEFT", 0, -5)
coTankShowName.myheight = 0
coTankNameFontSize = coTankAdvancedArea:CreateSlider(L.CoTankNameFontSize, 8, 60, 1, 150, DBM.Options.PrivateAurasCoTankNameFontSize, function(value)
		DBM.Options.PrivateAurasCoTankNameFontSize = value
		OnAuraSettingsChange(false)
	end)

coTankNameFontSize:SetPoint("TOPLEFT", coTankShowName, "BOTTOMLEFT", 20, -20)
coTankNameFontSize.myheight = 50


coTankNameXOffset = coTankAdvancedArea:CreateSlider(L.CoTankNameXOffset, -100, 100, 1, 150, DBM.Options.PrivateAurasCoTankNameXOffset, function(value)
		DBM.Options.PrivateAurasCoTankNameXOffset = value
		OnAuraSettingsChange(false)
	end)

coTankNameXOffset:SetPoint("TOPLEFT", coTankNameFontSize, "TOPLEFT", 195, 0)
coTankNameXOffset.myheight = 0


coTankNameYOffset = coTankAdvancedArea:CreateSlider(L.CoTankNameYOffset, -100, 100, 1, 150, DBM.Options.PrivateAurasCoTankNameYOffset, function(value)
		DBM.Options.PrivateAurasCoTankNameYOffset = value
		OnAuraSettingsChange(false)
	end)

coTankNameYOffset:SetPoint("TOPLEFT", coTankNameFontSize, "TOPLEFT", 0, -50)
coTankNameYOffset.myheight = 50

local auraMaxDuration = coTankAdvancedArea:CreateSlider(L.AuraMaxDuration, 30, 600, 1, 150, DBM.Options.AurasMaxDuration, function(value)
	DBM.Options.AurasMaxDuration = value
	OnAuraSettingsChange()
end)

auraMaxDuration:SetPoint("TOPLEFT", coTankNameYOffset, "TOPRIGHT", 45, 0)


local coTankSlot1Player = coTankAdvancedArea:CreateDropdown(L.CoTankSlot1Player, function()
		return GetCoTankRosterValues()
	end, "DBM", "PrivateAurasCoTankSlot1Player", function(value)
		DBM.Options.PrivateAurasCoTankSlot1Player = value
		OnAuraSettingsChange(false)
	end)

coTankSlot1Player:IsSelectedCallback(function(_, value)
		return value.value == DBM.Options.PrivateAurasCoTankSlot1Player
	end)

coTankSlot1Player:SetPoint("TOPLEFT", coTankNameYOffset, "BOTTOMLEFT", 0, -35)
coTankSlot1Player.myheight = 45


local coTankSlot2Player = coTankAdvancedArea:CreateDropdown(L.CoTankSlot2Player, function()
		return GetCoTankRosterValues(DBM.Options.PrivateAurasCoTankSlot1Player)
	end, "DBM", "PrivateAurasCoTankSlot2Player", function(value)
		DBM.Options.PrivateAurasCoTankSlot2Player = value
		OnAuraSettingsChange(false)
	end)

coTankSlot2Player:IsSelectedCallback(function(_, value)
		return value.value == DBM.Options.PrivateAurasCoTankSlot2Player
	end)

coTankSlot2Player:SetPoint("TOPLEFT", coTankSlot1Player, "TOPLEFT", 195, 0)
coTankSlot2Player.myheight = 0
coTankSlot1Player:RefreshLazyValues()
coTankSlot1Player:SetSelectedValue(DBM.Options.PrivateAurasCoTankSlot1Player)
coTankSlot2Player:RefreshLazyValues()
coTankSlot2Player:SetSelectedValue(DBM.Options.PrivateAurasCoTankSlot2Player)


local coTankAdvancedReset = coTankAdvancedArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)

coTankAdvancedReset:SetPoint("BOTTOMRIGHT", coTankAdvancedArea.frame, "BOTTOMRIGHT", -2, 4)
coTankAdvancedReset:SetNormalFontObject(GameFontNormalSmall)
coTankAdvancedReset:SetHighlightFontObject(GameFontNormalSmall)
coTankAdvancedReset:SetScript("OnClick", function()
		DBM.Options.PrivateAurasCoTankUseHealerInFiveMan = DBM.DefaultOptions.PrivateAurasCoTankUseHealerInFiveMan
		DBM.Options.PrivateAurasCoTankShowName = DBM.DefaultOptions.PrivateAurasCoTankShowName
		DBM.Options.PrivateAurasCoTankNameFontSize = DBM.DefaultOptions.PrivateAurasCoTankNameFontSize
		DBM.Options.PrivateAurasCoTankNameXOffset = DBM.DefaultOptions.PrivateAurasCoTankNameXOffset
		DBM.Options.PrivateAurasCoTankNameYOffset = DBM.DefaultOptions.PrivateAurasCoTankNameYOffset
		DBM.Options.PrivateAurasCoTankSlot1Player = DBM.DefaultOptions.PrivateAurasCoTankSlot1Player
		DBM.Options.PrivateAurasCoTankSlot2Player = DBM.DefaultOptions.PrivateAurasCoTankSlot2Player
		DBM.Options.AurasMaxDuration = DBM.DefaultOptions.AurasMaxDuration
		DBM.Options.AlwaysShowPlayerAuras = DBM.DefaultOptions.AlwaysShowPlayerAuras
		alwaysShowPlayerAuras:SetChecked(DBM.Options.AlwaysShowPlayerAuras)
		auraMaxDuration:SetValue(DBM.Options.AurasMaxDuration)
		coTankUseHealerInFiveMan:SetChecked(DBM.Options.PrivateAurasCoTankUseHealerInFiveMan)
		coTankShowName:SetChecked(DBM.Options.PrivateAurasCoTankShowName)
		coTankNameFontSize:SetValue(DBM.Options.PrivateAurasCoTankNameFontSize)
		coTankNameXOffset:SetValue(DBM.Options.PrivateAurasCoTankNameXOffset)
		coTankNameYOffset:SetValue(DBM.Options.PrivateAurasCoTankNameYOffset)
		coTankSlot1Player:RefreshLazyValues()
		coTankSlot1Player:SetSelectedValue(DBM.Options.PrivateAurasCoTankSlot1Player)
		coTankSlot2Player:RefreshLazyValues()
		coTankSlot2Player:SetSelectedValue(DBM.Options.PrivateAurasCoTankSlot2Player)
	OnAuraSettingsChange(false)
end)
