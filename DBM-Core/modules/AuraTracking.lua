---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS

---@class DBMAuraButton: Frame
---@field SetIcon fun(self: DBMAuraButton, icon: Texture)
---@field AddDispelTypeTexture fun(self: DBMAuraButton, region: Texture, options: table): integer
---@field ClearDispelTypeTextures fun(self: DBMAuraButton)
---@field SetDispelTypeText fun(self: DBMAuraButton, region: FontString, options: table)
---@field ClearDispelTypeText fun(self: DBMAuraButton)
---@field SetDurationText fun(self: DBMAuraButton, region: FontString, options: table?)
---@field SetApplicationCount fun(self: DBMAuraButton, region: FontString, options: table)
---@field ClearApplicationCount fun(self: DBMAuraButton)

---@class DBMAuraContainer: Frame
---@field SetEnabled fun(self: DBMAuraContainer, enabled: boolean)
---@field SetUnit fun(self: DBMAuraContainer, unit: playerUUIDs)
---@field SetFlowLayoutAxis fun(self: DBMAuraContainer, layoutAxis: number)
---@field SetFlowLayoutAnchorPoint fun(self: DBMAuraContainer, anchor: string)
---@field SetFlowLayoutGrowthDirection fun(self: DBMAuraContainer, horizontal: number, vertical: number)
---@field SetFlowLayoutMaximumLineSize fun(self: DBMAuraContainer, maximumLineSize: number?)
---@field HasAuraGroup fun(self: DBMAuraContainer, groupKey: string): boolean
---@field SetAuraGroupMaxFrameCount fun(self: DBMAuraContainer, groupKey: string, maxFrameCount: number)
---@field SetAuraGroupCandidateFilters fun(self: DBMAuraContainer, groupKey: string, filters: table)
---@field SetAuraGroupLayout fun(self: DBMAuraContainer, groupKey: string, layout: table)
---@field SetAuraGroupSortMethod fun(self: DBMAuraContainer, groupKey: string, sortMethod: number, sortDirection: number)
---@field AddAuraGroup fun(self: DBMAuraContainer, groupKey: string, filters: string, options: table)

---@class DBMAuraContainerState
---@field container DBMAuraContainer?
---@field anchor Frame?
---@field groupKey string?
---@field key string?
---@field buttonRegions table<Frame, table>?
---@field initialized boolean?
---@field unit playerUUIDs?
---@field settings DBMAuraSettings?
---@field nameLabel FontString?
---@field width number?
---@field height number?

---@class DBMAuraSettings
---@field optionPrefix string
---@field HideBorder boolean
---@field HideTooltip boolean
---@field Spacing number
---@field Limit number
---@field GrowDirection string
---@field SortMode string
---@field enabled boolean
---@field Width number
---@field Height number
---@field Anchor string
---@field relativeTo string
---@field xOffset number
---@field yOffset number
---@field TextFont string
---@field TextFontStyle string
---@field DurationFontSize number
---@field ShowDecimalSeconds boolean
---@field DecimalThreshold number
---@field StackFontSize number
---@field StackColor { r: number, g: number, b: number }
---@field StackXOffset number
---@field StackYOffset number
---@field ShowStacks boolean
---@field ShowDispelBorder boolean
---@field NameFontSize number
---@field NameXOffset number
---@field NameYOffset number

---@class DBMAuraTracking
---@field AuraTrackingState table<string, DBMAuraContainerState>?
local AuraTracking = {}
DBM.Auras = AuraTracking

---@class DBMAuraPreviewFrame: Frame
---@field Textures table<integer, Texture>
---@field BorderTextures table<integer, Texture>
---@field Symbols table<integer, FontString>
---@field DurationTexts table<integer, FontString>
---@field StackTexts table<integer, FontString>
---@field Border Frame?
---@field NameLabel FontString?

local AuraTrackingFilters = {
	"HARMFUL",
}

local AuraSortMethod = rawget(_G, "AuraContainerSortMethod") or { Default = 1, ExpirationOnly = 2 }
local AuraSortDirection = rawget(_G, "AuraContainerSortDirection") or { Normal = 1, Reverse = 2 }
local ShouldAurasBeSecret = C_Secrets.ShouldAurasBeSecret
local AuraSortModes = {
	Default = { method = AuraSortMethod.Default, direction = AuraSortDirection.Normal },
	ShortDurationFirst = { method = AuraSortMethod.ExpirationOnly, direction = AuraSortDirection.Normal },
	LongDurationFirst = { method = AuraSortMethod.ExpirationOnly, direction = AuraSortDirection.Reverse },
}
local AuraTrackingPreviewDispelTypes = {
	"Magic",
	"Curse",
	"Disease",
	"Poison",
	"Bleed",
}
local AuraTrackingPreviewDurations = {
	34,
	8,
	60,
	15,
	42,
	10,
	55,
	20,
	30,
	2.7,
}
local AuraTrackingDurationFormatterCache = {}

local auraAnchorsRegistered = false
local auraTextFontResetNotified = false

---@param prefix string The prefix for the option keys (e.g., "PrivateAurasPlayer")
---@return DBMAuraSettings Settings table with all configuration properties
local function GetAuraSettings(prefix)
	local stackColor = DBM.Options[prefix .. "StackColor"] or DBM.DefaultOptions[prefix .. "StackColor"]
	return {
		optionPrefix = prefix,
		HideBorder = DBM.Options[prefix .. "HideBorder"],
		HideTooltip = DBM.Options[prefix .. "HideTooltip"],
		Spacing = DBM.Options[prefix .. "Spacing2"],
		Limit = DBM.Options[prefix .. "Limit"],
		GrowDirection = DBM.Options[prefix .. "GrowDirection"],
		SortMode = DBM.Options[prefix .. "SortMode"] or DBM.DefaultOptions[prefix .. "SortMode"],
		enabled = DBM.Options[prefix .. "Enabled2"],
		Width = DBM.Options[prefix .. "Width"],
		Height = DBM.Options[prefix .. "Height"],
		Anchor = DBM.Options[prefix .. "Anchor"],
		relativeTo = DBM.Options[prefix .. "RelativeTo"],
		xOffset = DBM.Options[prefix .. "XOffset"],
		yOffset = DBM.Options[prefix .. "YOffset"],
		TextFont = DBM.Options[prefix .. "TextFont"],
		TextFontStyle = DBM.Options[prefix .. "TextFontStyle"],
		DurationFontSize = DBM.Options[prefix .. "DurationFontSize"],
		ShowDecimalSeconds = DBM.Options[prefix .. "ShowDecimalSeconds"],
		DecimalThreshold = DBM.Options[prefix .. "DecimalThreshold"] or DBM.DefaultOptions[prefix .. "DecimalThreshold"],
		StackFontSize = DBM.Options[prefix .. "StackFontSize"],
		StackColor = stackColor,
		StackXOffset = DBM.Options[prefix .. "StackXOffset"] or DBM.DefaultOptions[prefix .. "StackXOffset"],
		StackYOffset = DBM.Options[prefix .. "StackYOffset"] or DBM.DefaultOptions[prefix .. "StackYOffset"],
		ShowStacks = DBM.Options[prefix .. "ShowStacks"],
		ShowDispelBorder = DBM.Options[prefix .. "ShowDispelBorder"],
		NameFontSize = DBM.Options[prefix .. "NameFontSize"] or DBM.DefaultOptions[prefix .. "NameFontSize"],
		NameXOffset = DBM.Options[prefix .. "NameXOffset"] or DBM.DefaultOptions[prefix .. "NameXOffset"],
		NameYOffset = DBM.Options[prefix .. "NameYOffset"] or DBM.DefaultOptions[prefix .. "NameYOffset"],
	}
end

---@param settings DBMAuraSettings
---@return table
local function GetAuraSortMode(settings)
	return AuraSortModes[settings.SortMode] or AuraSortModes.Default
end

local function GetAuraTextFontSettings(settings)
	local prefix = settings and settings.optionPrefix
	if not prefix then return private.standardFont, "" end
	local fontOption = DBM.Options[prefix .. "TextFont"] or DBM.DefaultOptions[prefix .. "TextFont"]
	local font = fontOption == "standardFont" and private.standardFont or fontOption
	local fontStyle = (DBM.Options[prefix .. "TextFontStyle"] and not DBM:IsNoneValue(DBM.Options[prefix .. "TextFontStyle"])) and DBM.Options[prefix .. "TextFontStyle"] or ""
	local size = DBM.Options[prefix .. "DurationFontSize"] or DBM.DefaultOptions[prefix .. "DurationFontSize"]
	if not DBM:IsFontValid(font, private.standardFont, size, fontStyle) then
		DBM.Options[prefix .. "TextFont"] = DBM.DefaultOptions[prefix .. "TextFont"]
		DBM.Options[prefix .. "TextFontStyle"] = DBM.DefaultOptions[prefix .. "TextFontStyle"]
		if not auraTextFontResetNotified then
			DBM:AddMsg(DBM_CORE_L.AURA_FONT_RESET)
			auraTextFontResetNotified = true
		end
		font = private.standardFont
		fontStyle = ""
	end
	return font, fontStyle
end

---@param settings DBMAuraSettings
local function GetAuraDurationFormatter(settings)
	local decimalEnabled = settings.ShowDecimalSeconds == true
	local decimalThreshold = decimalEnabled and math.min(math.max(tonumber(settings.DecimalThreshold) or 3, 0.1), 59.9) or 0
	local cache = AuraTrackingDurationFormatterCache[settings.optionPrefix]
	if cache and cache.decimalEnabled == decimalEnabled and cache.decimalThreshold == decimalThreshold then
		return cache.formatter
	end
	local formatter = C_StringUtil.CreateNumericRuleFormatter()
	if decimalEnabled then
		formatter:SetBreakpoints({
			{
				threshold = 60,
				rounding = Enum.NumericRuleFormatRounding.Down,
				format = "%dm",
				components = {
					{
						div = 60,
						step = 1,
						rounding = Enum.NumericRuleFormatRounding.Down,
					},
				},
			},
			{
				threshold = decimalThreshold,
				step = 1,
				rounding = Enum.NumericRuleFormatRounding.Up,
				format = "%d",
			},
			{
				threshold = 0,
				step = 0.1,
				rounding = Enum.NumericRuleFormatRounding.Up,
				format = "%.1f",
			},
		})
	else
		formatter:SetBreakpoints({
			{
				threshold = 60,
				rounding = Enum.NumericRuleFormatRounding.Down,
				format = "%dm",
				components = {
					{
						div = 60,
						step = 1,
						rounding = Enum.NumericRuleFormatRounding.Down,
					},
				},
			},
			{
				threshold = 0,
				step = 1,
				rounding = Enum.NumericRuleFormatRounding.Up,
				format = "%d",
			},
		})
	end
	AuraTrackingDurationFormatterCache[settings.optionPrefix] = {
		decimalEnabled = decimalEnabled,
		decimalThreshold = decimalThreshold,
		formatter = formatter,
	}
	return formatter
end

---@param duration number
---@param settings DBMAuraSettings
---@return string
local function FormatAuraPreviewDuration(duration, settings)
	if duration >= 60 then
		return math.floor(duration / 60) .. "m"
	end
	if settings.ShowDecimalSeconds and duration < (tonumber(settings.DecimalThreshold) or 3) then
		return string.format("%.1f", math.ceil(duration * 10) / 10)
	end
	return tostring(math.ceil(duration))
end

---@param settings table
---@return number
local function GetCoTankRowYOffset(settings)
	local step = settings.Height + settings.Spacing
	if settings.GrowDirection == "UP" or settings.GrowDirection == "DOWN" then
		step = settings.Height + (settings.Limit - 1) * (settings.Height + settings.Spacing) + settings.Spacing
	end
	return step
end

---@param index integer
---@return table
local function GetCoTankSettings(index)
	local settings = GetAuraSettings("PrivateAurasCoTank")
	local visibility = DBM.Options.PrivateAurasCoTankEnabled3
	---@diagnostic disable-next-line: undefined-field
	settings.enabled = visibility == "Always" or (visibility == "Auto" and DBM:IsTank())
	if index and index > 1 then
		settings.yOffset = settings.yOffset - GetCoTankRowYOffset(settings) * (index - 1)
	end
	return settings
end

---@param growDirection string
local function GetFlowDirections(growDirection)
	local horizontal = AnchorUtil.FlowDirection.Right
	local vertical = AnchorUtil.FlowDirection.Down
	if growDirection == "LEFT" then
		horizontal = AnchorUtil.FlowDirection.Left
	elseif growDirection == "UP" then
		vertical = AnchorUtil.FlowDirection.Up
	end
	return horizontal, vertical
end

---@param settings table
---@return string
local function GetLayoutAnchorPoint(settings)
	local growDirection = settings and settings.GrowDirection or "RIGHT"
	if growDirection == "LEFT" then
		return "TOPRIGHT"
	elseif growDirection == "UP" then
		return "BOTTOMLEFT"
	end
	return "TOPLEFT"
end

---@param settings table
---@return number
local function GetFlowLayoutAxis(settings)
	if settings.GrowDirection == "UP" or settings.GrowDirection == "DOWN" then
		return AnchorUtil.FlowLayoutAxis.Vertical
	end
	return AnchorUtil.FlowLayoutAxis.Horizontal
end

---@param settings table
---@return number
local function GetRowWidth(settings)
	local width = settings.Width or 1
	if settings.GrowDirection == "UP" or settings.GrowDirection == "DOWN" then
		return width
	end
	local limit = settings.Limit or 1
	local spacing = settings.Spacing or 0
	return math.max(width, (width * limit) + (spacing * math.max(limit - 1, 0)))
end

---@param settings DBMAuraSettings
---@return number, number
local function GetNameLabelOffsets(settings)
	local xOffset = settings.NameXOffset
	if settings.GrowDirection == "RIGHT" then
		xOffset = xOffset + GetRowWidth(settings) - settings.Width
	end
	return xOffset, settings.NameYOffset
end

---@param frame Frame
---@param settings table
---@param index integer
---@param texture number|string
---@param dispelType string?
---@param durationIndex integer
local function ConfigurePreviewSlot(frame, settings, index, texture, dispelType, durationIndex)
	---@cast frame DBMAuraPreviewFrame
	frame.Textures = frame.Textures or {}
	frame.BorderTextures = frame.BorderTextures or {}
	frame.Symbols = frame.Symbols or {}
	frame.DurationTexts = frame.DurationTexts or {}
	frame.StackTexts = frame.StackTexts or {}

	local xOffset = (settings.GrowDirection == "RIGHT" and (index - 1) * (settings.Width + settings.Spacing)) or (settings.GrowDirection == "LEFT" and -(index - 1) * (settings.Width + settings.Spacing)) or 0
	local yOffset = (settings.GrowDirection == "UP" and (index - 1) * (settings.Height + settings.Spacing)) or (settings.GrowDirection == "DOWN" and -(index - 1) * (settings.Height + settings.Spacing)) or 0

	if not frame.Textures[index] then
		frame.Textures[index] = frame:CreateTexture(nil, "ARTWORK")
	end
	local icon = frame.Textures[index]
	icon:SetTexture(texture)
	icon:SetSize(settings.Width, settings.Height)
	icon:ClearAllPoints()
	icon:SetPoint("CENTER", frame, "CENTER", xOffset, yOffset)
	icon:Show()

	if settings.ShowDispelBorder and not settings.HideBorder then
		if not frame.BorderTextures[index] then
			frame.BorderTextures[index] = frame:CreateTexture(nil, "OVERLAY")
		end
		local border = frame.BorderTextures[index]
		border:ClearAllPoints()
		border:SetPoint("CENTER", icon, "CENTER", 0, 0)
		border:SetSize(settings.Width * 1.25, settings.Height * 1.25)
		AuraUtil.SetAuraBorderAtlas(border, dispelType, true)
		border:Show()

		if not frame.Symbols[index] then
			frame.Symbols[index] = frame:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
		end
		local symbol = frame.Symbols[index]
		symbol:ClearAllPoints()
		symbol:SetPoint("TOPLEFT", icon, "TOPLEFT", 2, -2)
		AuraUtil.SetAuraSymbol(symbol, dispelType)
		symbol:Show()
	else
		if frame.BorderTextures[index] then
			frame.BorderTextures[index]:Hide()
		end
		if frame.Symbols[index] then
			frame.Symbols[index]:Hide()
		end
	end

	local fontPath, fontFlags = GetAuraTextFontSettings(settings)
	if not frame.DurationTexts[index] then
		frame.DurationTexts[index] = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	local durationText = frame.DurationTexts[index]
	durationText:ClearAllPoints()
	durationText:SetPoint("CENTER", icon, "CENTER", 0, 0)
	durationText:SetFont(fontPath, settings.DurationFontSize, fontFlags)
	local duration = AuraTrackingPreviewDurations[durationIndex]
	durationText:SetText(FormatAuraPreviewDuration(duration, settings))
	durationText:Show()

	if not frame.StackTexts[index] then
		frame.StackTexts[index] = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	local stackText = frame.StackTexts[index]
	if settings.ShowStacks then
		stackText:ClearAllPoints()
		stackText:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", settings.StackXOffset, settings.StackYOffset)
		stackText:SetFont(fontPath, settings.StackFontSize, fontFlags)
		stackText:SetTextColor(settings.StackColor.r, settings.StackColor.g, settings.StackColor.b)
		---@diagnostic disable-next-line: param-type-mismatch
		stackText:SetText(index + 1)
		stackText:Show()
	else
		stackText:SetText("")
		stackText:Hide()
	end
end

---@param state DBMAuraContainerState
---@param button DBMAuraButton
---@param settings DBMAuraSettings
---@param unit playerUUIDs
local function ConfigureButton(state, button, settings, unit)
	local prefix = settings and settings.optionPrefix or ""
	state.buttonRegions = state.buttonRegions or setmetatable({}, {__mode = "k"})
	local regions = state.buttonRegions[button]
	if not regions then
		regions = {}
		regions.icon = button:CreateTexture(nil, "ARTWORK")
		regions.icon:SetAllPoints(button)
		button:SetIcon(regions.icon)
		regions.textOverlay = CreateFrame("Frame", nil, button)
		regions.textOverlay:SetAllPoints()
		regions.textOverlay:SetFrameLevel(button:GetFrameLevel() + 3)
		state.buttonRegions[button] = regions
	end

	button:SetSize(settings.Width, settings.Height)
	regions.textOverlay:SetFrameLevel(button:GetFrameLevel() + 3)
	local fontPath, fontFlags = GetAuraTextFontSettings(settings)
	local durationFontSize = tonumber(settings.DurationFontSize) or tonumber(DBM.DefaultOptions[prefix .. "DurationFontSize"]) or 12
	local stackFontSize = tonumber(settings.StackFontSize) or tonumber(DBM.DefaultOptions[prefix .. "StackFontSize"]) or 12
	if settings.ShowDispelBorder and not settings.HideBorder then
		if not regions.dispelOverlay then
			regions.dispelOverlay = CreateFrame("Frame", nil, button)
			regions.dispelOverlay:SetFrameLevel(button:GetFrameLevel() + 2)
		end
		regions.dispelOverlay:ClearAllPoints()
		regions.dispelOverlay:SetAllPoints(regions.icon)
		regions.dispelOverlay:Show()
		if not regions.dispelBorder then
			regions.dispelBorder = regions.dispelOverlay:CreateTexture(nil, "OVERLAY")
		end
		regions.dispelBorder:ClearAllPoints()
		regions.dispelBorder:SetPoint("CENTER", regions.icon, "CENTER", 0, 0)
		regions.dispelBorder:SetSize(settings.Width * 1.25, settings.Height * 1.25)
		button:ClearDispelTypeTextures()
		button:AddDispelTypeTexture(regions.dispelBorder, {
			showWhenHarmful = true,
			showWhenHelpful = false,
		})
		if not regions.dispelSymbol then
			regions.dispelSymbol = regions.textOverlay:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
			regions.dispelSymbol:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
			regions.dispelSymbol:SetTextColor(1, 1, 1, 1)
		end
		regions.dispelSymbol:SetFont(fontPath, stackFontSize, fontFlags)
		button:SetDispelTypeText(regions.dispelSymbol, {
			showWhenHarmful = true,
			showWhenHelpful = false,
		})
	else
		if regions.dispelOverlay then regions.dispelOverlay:Hide() end
		if regions.dispelBorder then regions.dispelBorder:Hide() end
		if regions.dispelSymbol then regions.dispelSymbol:Hide() end
		button:ClearDispelTypeTextures()
		button:ClearDispelTypeText()
	end

	button:SetMouseMotionEnabled(not settings.HideTooltip)
	if not regions.durationText then
		regions.durationText = regions.textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	regions.durationText:ClearAllPoints()
	regions.durationText:SetPoint("CENTER", button, "CENTER", 0, 0)
	regions.durationText:SetFont(fontPath, durationFontSize, fontFlags)
	regions.durationText:Show()
	button:SetDurationText(regions.durationText, {
		textFormatter = GetAuraDurationFormatter(settings),
	})

	if not regions.countText then
		regions.countText = regions.textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	if settings.ShowStacks then
		regions.countText:ClearAllPoints()
		regions.countText:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", settings.StackXOffset, settings.StackYOffset)
		regions.countText:SetFont(fontPath, stackFontSize, fontFlags)
		regions.countText:SetTextColor(settings.StackColor.r, settings.StackColor.g, settings.StackColor.b)
		regions.countText:Show()
		button:SetApplicationCount(regions.countText, {})
	else
		button:ClearApplicationCount()
		regions.countText:SetText("")
		regions.countText:Hide()
	end

end

---@param self DBMAuraTracking
---@param key string
---@return DBMAuraContainerState
local function AcquireContainerState(self, key)
	if not self.AuraTrackingState then self.AuraTrackingState = {} end
	if not self.AuraTrackingState[key] then self.AuraTrackingState[key] = {} end
	local state = self.AuraTrackingState[key]
	if not state.container then
		if not C_AddOns.IsAddOnLoaded("Blizzard_AuraContainer") then
			C_AddOns.LoadAddOn("Blizzard_AuraContainer")
		end
		local container = CreateFrame("AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")
		---@cast container DBMAuraContainer
		state.container = container
		state.anchor = CreateFrame("Frame", nil, UIParent)
		state.groupKey = "DBM_Aura_" .. key
		state.key = key
		state.buttonRegions = setmetatable({}, {__mode = "k"})
		state.initialized = false
	end
	return state
end

---@param state DBMAuraContainerState
---@param settings DBMAuraSettings
---@param unit playerUUIDs
local function UpdateContainerNameLabel(state, settings, unit)
	if state.key == "player" or not DBM.Options.PrivateAurasCoTankShowName then
		if state.nameLabel then state.nameLabel:Hide() end
		return
	end
	local name = DBM:GetUnitFullName(unit)
	if not name then
		if state.nameLabel then state.nameLabel:Hide() end
		return
	end
	if not state.nameLabel then
		state.nameLabel = state.anchor:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	local fontPath, fontFlags = GetAuraTextFontSettings(settings)
	local xOffset, yOffset = GetNameLabelOffsets(settings)
	state.nameLabel:ClearAllPoints()
	state.nameLabel:SetPoint("LEFT", state.anchor, "RIGHT", xOffset, yOffset)
	state.nameLabel:SetFont(fontPath, settings.NameFontSize, fontFlags)
	state.nameLabel:SetText(DBM:GetShortServerName(name))
	local _, class = UnitClass(unit)
	local classColor = class and RAID_CLASS_COLORS[class]
	if classColor then
		state.nameLabel:SetTextColor(classColor.r, classColor.g, classColor.b)
	else
		state.nameLabel:SetTextColor(1, 1, 1)
	end
	state.nameLabel:Show()
end

---@param state table
---@param settings table
---@param unit playerUUIDs
local function InitContainerState(state, settings, unit)
	local container = state.container
	local anchor = state.anchor
	local groupKey = state.groupKey
	state.unit = unit
	state.settings = settings
	state.width = settings.Width
	state.height = settings.Height

	local layoutAnchorPoint = GetLayoutAnchorPoint(settings)

	anchor:ClearAllPoints()
	anchor:SetPoint(settings.Anchor, UIParent, settings.relativeTo, settings.xOffset, settings.yOffset)
	anchor:SetSize(settings.Width, settings.Height)
	anchor:Show()
	UpdateContainerNameLabel(state, settings, unit)

	container:SetEnabled(false)
	container:Hide()
	container:ClearAllPoints()
	container:SetSize(settings.Width, settings.Height)
	container:SetPoint(layoutAnchorPoint, anchor, layoutAnchorPoint, 0, 0)
	container:SetUnit(unit)
	container:SetFlowLayoutAxis(GetFlowLayoutAxis(settings))
	container:SetFlowLayoutAnchorPoint(layoutAnchorPoint)
	container:SetFlowLayoutGrowthDirection(GetFlowDirections(settings.GrowDirection))
	container:SetFlowLayoutMaximumLineSize(GetRowWidth(settings))

	local options = {
		maxFrameCount = settings.Limit,
		sortMethod = GetAuraSortMode(settings).method,
		sortDirection = GetAuraSortMode(settings).direction,
		initializeFrame = function(button)
			ConfigureButton(state, button, state.settings, state.unit)
		end,
		candidateFilters = {
			isFromPlayerOrPlayerPet = false,
			maxDuration = DBM.Options.AurasMaxDuration,
			excludeSpellIDs = {
				[57723] = true,--Exhaustion
				[80354] = true,--Temporal Displacement
				[57724] = true,--Sated
				[390435] = true,--Exhaustion
				[264689] = true,--Fatigued
				[160455] = true,--Fatigued
				[95809] = true,--Insanity
				[124255] = true,--Stagger
				[71041] = true,--Dungeon Deserter
				[206151] = true,--Challenger's Burden
			}
		},
		layout = {
			elementWidth = settings.Width,
			elementHeight = settings.Height,
			elementSpacing = settings.Spacing or 0,
			lineSpacing = settings.Spacing or 0,
		},
	}

	if container:HasAuraGroup(groupKey) then
		container:SetAuraGroupMaxFrameCount(groupKey, options.maxFrameCount)
		container:SetAuraGroupCandidateFilters(groupKey, options.candidateFilters)
		container:SetAuraGroupLayout(groupKey, options.layout)
		container:SetAuraGroupSortMethod(groupKey, options.sortMethod, options.sortDirection)
	else
		container:AddAuraGroup(groupKey, AuraTrackingFilters[1], options)
	end
	if not ShouldAurasBeSecret() then
		for button in pairs(state.buttonRegions) do
			ConfigureButton(state, button, settings, unit)
		end
	end

	container:Show()
	container:SetEnabled(true)
	state.initialized = true
end

---@param self DBMAuraTracking
---@param key string
local function HideContainerState(self, key)
	if not self.AuraTrackingState then return end
	local state = self.AuraTrackingState[key]
	if not state then return end
	if state.container then
		state.container:SetEnabled(false)
		state.container:Hide()
	end
	if state.anchor then
		state.anchor:Hide()
	end
	if state.nameLabel then
		state.nameLabel:Hide()
	end
	state.initialized = false
end

---@param self DBMAuraTracking
---@param key string
---@param unit playerUUIDs?
---@param settings table
local function RegisterAuraContainer(self, key, unit, settings)
	if not unit or not settings or not settings.enabled then
		HideContainerState(self, key)
		return
	end
	local state = AcquireContainerState(self, key)
	InitContainerState(state, settings, unit)
end

---@param self DBMAuraTracking
---@param player boolean?
local function stopMoving(self, player)
	self.IsInPreview = false
	if player == nil or player then
		if self.PlayerPreview then
			self.PlayerPreview:Hide()
			self.PlayerPreview:SetMovable(false)
			self.PlayerPreview:EnableMouse(false)
		end
	end
	if player == nil or not player then
		if self.CoTankPreview then
			self.CoTankPreview:Hide()
			self.CoTankPreview:SetMovable(false)
			self.CoTankPreview:EnableMouse(false)
		end
		if self.CoTankPreview2 then
			self.CoTankPreview2:Hide()
		end
	end
	if not self:UpdateAuraAnchors() then
		DBM:QueueAuraAnchorUpdate()
	end
end

---@param frame Frame
---@param settings table
---@param texture number|string
---@param name string?
local function UpdatePreviewFrame(frame, settings, texture, name)
	---@cast frame DBMAuraPreviewFrame
	frame.Textures = frame.Textures or {}
	frame.BorderTextures = frame.BorderTextures or {}
	frame.Symbols = frame.Symbols or {}
	frame.DurationTexts = frame.DurationTexts or {}
	frame.StackTexts = frame.StackTexts or {}
	frame:ClearAllPoints()
	frame:SetPoint(settings.Anchor, UIParent, settings.relativeTo, settings.xOffset, settings.yOffset)
	frame:SetSize(settings.Width, settings.Height)
	local previewOrder = {}
	for i = 1, #AuraTrackingPreviewDurations do
		previewOrder[i] = i
	end
	if settings.SortMode == "ShortDurationFirst" or settings.SortMode == "LongDurationFirst" then
		local ascending = settings.SortMode == "ShortDurationFirst"
		table.sort(previewOrder, function(a, b)
			if AuraTrackingPreviewDurations[a] == AuraTrackingPreviewDurations[b] then
				return a < b
			end
			if ascending then
				return AuraTrackingPreviewDurations[a] < AuraTrackingPreviewDurations[b]
			end
			return AuraTrackingPreviewDurations[a] > AuraTrackingPreviewDurations[b]
		end)
	end
	for i=1, 10 do
		if i <= settings.Limit then
			ConfigurePreviewSlot(frame, settings, i, texture, AuraTrackingPreviewDispelTypes[((i - 1) % #AuraTrackingPreviewDispelTypes) + 1], previewOrder[i])
		elseif frame.Textures[i] then
			frame.Textures[i]:Hide()
			if frame.BorderTextures[i] then
				frame.BorderTextures[i]:Hide()
			end
			if frame.Symbols[i] then
				frame.Symbols[i]:Hide()
			end
			if frame.DurationTexts[i] then frame.DurationTexts[i]:Hide() end
			if frame.StackTexts[i] then frame.StackTexts[i]:Hide() end
		end
	end
	if name and DBM.Options.PrivateAurasCoTankShowName then
		if not frame.NameLabel then
			frame.NameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		end
		local fontPath, fontFlags = GetAuraTextFontSettings(settings)
		local xOffset, yOffset = GetNameLabelOffsets(settings)
		frame.NameLabel:ClearAllPoints()
		frame.NameLabel:SetPoint("LEFT", frame, "RIGHT", xOffset, yOffset)
		frame.NameLabel:SetFont(fontPath, settings.NameFontSize, fontFlags)
		frame.NameLabel:SetText(name)
		frame.NameLabel:Show()
	elseif frame.NameLabel then
		frame.NameLabel:Hide()
	end
end

function AuraTracking:IsRegistered()
	return auraAnchorsRegistered
end

local fiveManDifficulties = {
	normal5 = true,
	heroic5 = true,
	mythic5 = true,
	challenge5 = true,
	follower = true,
	delves = true,
	normalscenario = true,
	heroicscenario = true,
}

---@param unit playerUUIDs
---@param selectedUnits playerUUIDs[]
---@param allowSelf boolean?
---@return boolean
local function IsAvailableCoTankUnit(unit, selectedUnits, allowSelf)
	if not unit or (not allowSelf and UnitIsUnit("player", unit)) then
		return false
	end
	for _, selectedUnit in ipairs(selectedUnits) do
		if UnitIsUnit(unit, selectedUnit) then
			return false
		end
	end
	return true
end

---@param name string
---@param selectedUnits playerUUIDs[]
---@return playerUUIDs?
local function GetConfiguredCoTankUnit(name, selectedUnits)
	if type(name) ~= "string" or name == "" then return end
	for groupUnit in DBM:GetGroupMembers() do
		-- The player can only be selected through the Alt-gated developer test menu option.
		if DBM:GetUnitFullName(groupUnit) == name and IsAvailableCoTankUnit(groupUnit, selectedUnits, UnitIsUnit("player", groupUnit)) then
			return groupUnit
		end
	end
end

---@param predicate fun(unit: playerUUIDs): boolean
---@param selectedUnits playerUUIDs[]
---@return playerUUIDs?
local function GetAutomaticCoTankUnit(predicate, selectedUnits)
	for unit in DBM:GetGroupMembers() do
		if IsAvailableCoTankUnit(unit, selectedUnits) and predicate(unit) then
			return unit
		end
	end
end

---@param slot integer
---@param selectedUnits playerUUIDs[]
---@return playerUUIDs?
local function GetAutomaticCoTankSlot(slot, selectedUnits)
	local difficulty = DBM:GetCurrentInstanceDifficulty()
	local _, instanceType = IsInInstance()
	local isFiveMan = fiveManDifficulties[difficulty] or (difficulty == "timewalker" and instanceType == "party")
	if DBM.Options.PrivateAurasCoTankUseHealerInFiveMan and isFiveMan then
		if DBM:GetRoleFlagValue("Tank") then
			if slot == 1 then
				return GetAutomaticCoTankUnit(function(unit)
					return DBM:IsHealer(unit)
				end, selectedUnits)
			end
			return
		elseif slot == 2 then
			return GetAutomaticCoTankUnit(function(unit)
				return DBM:IsHealer(unit)
			end, selectedUnits)
		end
	end
	return GetAutomaticCoTankUnit(function(unit)
		return DBM:IsTanking(unit)
	end, selectedUnits)
end

---@return playerUUIDs?, playerUUIDs?
local function ResolveCoTankUnits()
	local selectedUnits = {}
	local slot1 = GetConfiguredCoTankUnit(DBM.Options.PrivateAurasCoTankSlot1Player, selectedUnits)
		or GetAutomaticCoTankSlot(1, selectedUnits)
	if slot1 then
		table.insert(selectedUnits, slot1)
	end
	if not DBM.Options.PrivateAurasCoTankShowSecond then
		return slot1
	end
	local slot2 = GetConfiguredCoTankUnit(DBM.Options.PrivateAurasCoTankSlot2Player, selectedUnits)
		or GetAutomaticCoTankSlot(2, selectedUnits)
	return slot1, slot2
end

---Register auras for player and up to two co-tanks found in raid
function AuraTracking:RegisterAllUnits()
	auraAnchorsRegistered = true
	if DBM.Options.DontShowPrivateAuraFrame then
		self:UnregisterAuras()
		return
	end

	RegisterAuraContainer(self, "player", "player", GetAuraSettings("PrivateAurasPlayer"))

	HideContainerState(self, "cotank1")
	HideContainerState(self, "cotank2")
	if not IsInGroup() then return end

	local slot1, slot2 = ResolveCoTankUnits()
	RegisterAuraContainer(self, "cotank1", slot1, GetCoTankSettings(1))
	RegisterAuraContainer(self, "cotank2", slot2, GetCoTankSettings(2))
end

---@param unit string? if nil, will unregister all units.
function AuraTracking:UnregisterAuras(unit)
	auraAnchorsRegistered = false
	if unit == nil then
		HideContainerState(self, "player")
		HideContainerState(self, "cotank1")
		HideContainerState(self, "cotank2")
		return
	end
	if unit == "player" then
		HideContainerState(self, "player")
	else
		if self.AuraTrackingState then
			for key, state in pairs(self.AuraTrackingState) do
				if key ~= "player" and state.unit == unit then
					HideContainerState(self, key)
				end
			end
		end
	end
end

local function IsInValidInstance()
	if DBM.Options.AlwaysShowPlayerAuras then
		return true
	end
	local inInstance, instanceType = IsInInstance()
	return inInstance and instanceType ~= "pvp" and instanceType ~= "arena"
end

function AuraTracking:UpdateAuraAnchors()
	if ShouldAurasBeSecret() then
		return false
	end
	if auraAnchorsRegistered then
		auraAnchorsRegistered = false
		AuraTracking:UnregisterAuras()
	end
	if IsInValidInstance() then
		AuraTracking:RegisterAllUnits()
	end
	return true
end

---@param player boolean?
function AuraTracking:OnSettingsChange(player)
	if not self.IsInPreview then
		if not self:UpdateAuraAnchors() then
			DBM:QueueAuraAnchorUpdate()
		end
		return
	end
	if player then
		if self.PlayerPreview then
			local PlayerSettings = GetAuraSettings("PrivateAurasPlayer")
			UpdatePreviewFrame(self.PlayerPreview, PlayerSettings, 237555)
		end
	elseif self.CoTankPreview then
		local CoTankSettings = GetCoTankSettings(1)
		UpdatePreviewFrame(self.CoTankPreview, CoTankSettings, 236318, "Co-Tank")
		if DBM.Options.PrivateAurasCoTankShowSecond then
			self.CoTankPreview2 = self.CoTankPreview2 or CreateFrame("Frame", nil, UIParent)
			UpdatePreviewFrame(self.CoTankPreview2, GetCoTankSettings(2), 236318, "Co-Tank 2")
			self.CoTankPreview2:Show()
		elseif self.CoTankPreview2 then
			self.CoTankPreview2:Hide()
		end
	end
end

function AuraTracking:PreviewToggle()
	if DBM.Options.DontShowPrivateAuraFrame then
		DBM:AddMsg(DBM_CORE_L.MOVE_PRIVATE_AURA_DISABLED)
		return
	end
	local previewDuration = 30
	local PlayerSettings = GetAuraSettings("PrivateAurasPlayer")
	local CoTankSettings = GetCoTankSettings(1)
	local CoTankSettings2 = GetCoTankSettings(2)
	if self.IsInPreview then
		DBM:Unschedule(stopMoving)
		stopMoving(self)
		DBT:CancelBar("AuraMove")
	else
		DBM:Schedule(previewDuration, stopMoving, self)
		DBT:CreateBar(previewDuration, "AuraMove", 136116, true):SetText(DBM_CORE_L.MOVABLE_FRAMES)
		self.IsInPreview = true
		if PlayerSettings.enabled then
			if not self.PlayerPreview then
				self.PlayerPreview = CreateFrame("Frame", nil, UIParent)
				self.PlayerPreview:RegisterForDrag("LeftButton")
				self.PlayerPreview:SetClampedToScreen(true)
				self.PlayerPreview.Textures = {}
				self.PlayerPreview.BorderTextures = {}
				self.PlayerPreview.Symbols = {}
				self.PlayerPreview.DurationTexts = {}
				self.PlayerPreview.StackTexts = {}
				self.PlayerPreview.Border = CreateFrame("Frame", nil, self.PlayerPreview, "BackdropTemplate")
				self.PlayerPreview.Border:SetPoint("TOPLEFT", self.PlayerPreview, "TOPLEFT", -6, 6)
				self.PlayerPreview.Border:SetPoint("BOTTOMRIGHT", self.PlayerPreview, "BOTTOMRIGHT", 6, -6)
				self.PlayerPreview.Border:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2, })
				self.PlayerPreview.Border:SetBackdropBorderColor(1, 1, 1, 1)
				self.PlayerPreview:SetScript("OnDragStart", function(Frame) Frame:StartMoving() end)
				self.PlayerPreview:SetScript("OnDragStop", function(Frame)
					Frame:StopMovingOrSizing()
					local Anchor, _, relativeTo, xOffset, yOffset = Frame:GetPoint()
					xOffset = Round(xOffset)
					yOffset = Round(yOffset)
					DBM.Options.PrivateAurasPlayerXOffset = xOffset
					DBM.Options.PrivateAurasPlayerYOffset = yOffset
					DBM.Options.PrivateAurasPlayerAnchor = Anchor
					DBM.Options.PrivateAurasPlayerRelativeTo = relativeTo
				end)
			end
			UpdatePreviewFrame(self.PlayerPreview, PlayerSettings, 237555)
			self.PlayerPreview:Show()
			self.PlayerPreview:SetMovable(true)
			self.PlayerPreview:EnableMouse(true)
		end
		if CoTankSettings.enabled then
			if not self.CoTankPreview then
				self.CoTankPreview = CreateFrame("Frame", nil, UIParent)
				self.CoTankPreview:RegisterForDrag("LeftButton")
				self.CoTankPreview:SetClampedToScreen(true)
				self.CoTankPreview.Textures = {}
				self.CoTankPreview.BorderTextures = {}
				self.CoTankPreview.Symbols = {}
				self.CoTankPreview.DurationTexts = {}
				self.CoTankPreview.StackTexts = {}
				self.CoTankPreview.Border = CreateFrame("Frame", nil, self.CoTankPreview, "BackdropTemplate")
				self.CoTankPreview.Border:SetPoint("TOPLEFT", self.CoTankPreview, "TOPLEFT", -6, 6)
				self.CoTankPreview.Border:SetPoint("BOTTOMRIGHT", self.CoTankPreview, "BOTTOMRIGHT", 6, -6)
				self.CoTankPreview.Border:SetBackdrop({ edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 2, })
				self.CoTankPreview.Border:SetBackdropBorderColor(1, 1, 1, 1)
				self.CoTankPreview:SetScript("OnDragStart", function(Frame) Frame:StartMoving() end)
				self.CoTankPreview:SetScript("OnDragStop", function(Frame)
					Frame:StopMovingOrSizing()
					local Anchor, _, relativeTo, xOffset, yOffset = Frame:GetPoint()
					xOffset = Round(xOffset)
					yOffset = Round(yOffset)
					DBM.Options.PrivateAurasCoTankXOffset = xOffset
					DBM.Options.PrivateAurasCoTankYOffset = yOffset
					DBM.Options.PrivateAurasCoTankAnchor = Anchor
					DBM.Options.PrivateAurasCoTankRelativeTo = relativeTo
				end)
			end
			UpdatePreviewFrame(self.CoTankPreview, CoTankSettings, 236318, "Co-Tank")
			self.CoTankPreview:Show()
			self.CoTankPreview:SetMovable(true)
			self.CoTankPreview:EnableMouse(true)
			if DBM.Options.PrivateAurasCoTankShowSecond then
				if not self.CoTankPreview2 then
					self.CoTankPreview2 = CreateFrame("Frame", nil, UIParent)
					self.CoTankPreview2.Textures = {}
					self.CoTankPreview2.BorderTextures = {}
					self.CoTankPreview2.Symbols = {}
					self.CoTankPreview2.DurationTexts = {}
					self.CoTankPreview2.StackTexts = {}
				end
				UpdatePreviewFrame(self.CoTankPreview2, CoTankSettings2, 236318, "Co-Tank 2")
				self.CoTankPreview2:Show()
			elseif self.CoTankPreview2 then
				self.CoTankPreview2:Hide()
			end
		end
		return previewDuration
	end
end
