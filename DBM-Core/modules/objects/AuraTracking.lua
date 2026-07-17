if DBM:GetTOC() < 120100 then return end -- 12.1+ aura container implementation
---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBMAuraButton: Frame
---@field SetIcon fun(self: DBMAuraButton, icon: Texture)
---@field SetAuraBorder fun(self: DBMAuraButton, region: Texture, options: table)
---@field SetAuraSymbol fun(self: DBMAuraButton, region: FontString, options: table)
---@field ClearAuraBorder fun(self: DBMAuraButton)
---@field ClearAuraSymbol fun(self: DBMAuraButton)
---@field SetDurationText fun(self: DBMAuraButton, region: FontString, options: table?)
---@field SetApplicationCount fun(self: DBMAuraButton, region: FontString, options: table)
---@field ClearApplicationCount fun(self: DBMAuraButton)

---@class DBMAuraContainer: Frame
---@field SetEnabled fun(self: DBMAuraContainer, enabled: boolean)
---@field SetUnit fun(self: DBMAuraContainer, unit: playerUUIDs)
---@field SetAuraLayoutAnchorPoint fun(self: DBMAuraContainer, anchor: string)
---@field SetAuraLayoutGrowthDirection fun(self: DBMAuraContainer, horizontal: number, vertical: number)
---@field SetAuraLayoutRowWidth fun(self: DBMAuraContainer, width: number)
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
---@field width number?
---@field height number?

---@class DBMAuraSettings
---@field optionPrefix string
---@field HideBorder boolean
---@field HideTooltip boolean
---@field Scale number
---@field Spacing number
---@field Limit number
---@field GrowDirection string
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
---@field StackFontSize number
---@field StackColor { r: number, g: number, b: number }
---@field StackXOffset number
---@field StackYOffset number
---@field ShowStacks boolean
---@field ShowDispelBorder boolean

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

local AuraTrackingFilters = {
	"HARMFUL|!PLAYER",
}

local AuraSortMethod = rawget(_G, "AuraContainerSortMethod") or { Default = 1 }
local AuraSortDirection = rawget(_G, "AuraContainerSortDirection") or { Normal = 1 }
local AuraTrackingPreviewDispelTypes = {
	"Magic",
	"Curse",
	"Disease",
	"Poison",
	"Bleed",
}

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
		Scale = DBM.Options[prefix .. "Scale"],
		Spacing = DBM.Options[prefix .. "Spacing2"],
		Limit = DBM.Options[prefix .. "Limit"],
		GrowDirection = DBM.Options[prefix .. "GrowDirection"],
		enabled = DBM.Options[prefix .. "Enabled"],
		Width = DBM.Options[prefix .. "Width"],
		Height = DBM.Options[prefix .. "Height"],
		Anchor = DBM.Options[prefix .. "Anchor"],
		relativeTo = DBM.Options[prefix .. "RelativeTo"],
		xOffset = DBM.Options[prefix .. "XOffset"],
		yOffset = DBM.Options[prefix .. "YOffset"],
		TextFont = DBM.Options[prefix .. "TextFont"],
		TextFontStyle = DBM.Options[prefix .. "TextFontStyle"],
		DurationFontSize = DBM.Options[prefix .. "DurationFontSize"],
		StackFontSize = DBM.Options[prefix .. "StackFontSize"],
		StackColor = stackColor,
		StackXOffset = DBM.Options[prefix .. "StackXOffset"] or DBM.DefaultOptions[prefix .. "StackXOffset"],
		StackYOffset = DBM.Options[prefix .. "StackYOffset"] or DBM.DefaultOptions[prefix .. "StackYOffset"],
		ShowStacks = DBM.Options[prefix .. "ShowStacks"],
		ShowDispelBorder = DBM.Options[prefix .. "ShowDispelBorder"],
	}
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
local function GetRowWidth(settings)
	local width = settings.Width or 1
	if settings.GrowDirection == "UP" or settings.GrowDirection == "DOWN" then
		return width
	end
	local limit = settings.Limit or 1
	local spacing = settings.Spacing or 0
	return math.max(width, (width * limit) + (spacing * math.max(limit - 1, 0)))
end

---@param frame Frame
---@param settings table
---@param index integer
---@param texture number|string
---@param dispelType string?
local function ConfigurePreviewSlot(frame, settings, index, texture, dispelType)
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
	durationText:SetText(index % 2 == 0 and "1m" or tostring(10 + index))
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
		button:SetAuraBorder(regions.dispelBorder, {
			showIcon = true,
			showWhenHarmful = true,
			showWhenHelpful = false,
		})
		if not regions.dispelSymbol then
			regions.dispelSymbol = regions.textOverlay:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
			regions.dispelSymbol:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
			regions.dispelSymbol:SetTextColor(1, 1, 1, 1)
		end
		regions.dispelSymbol:SetFont(fontPath, stackFontSize, fontFlags)
		button:SetAuraSymbol(regions.dispelSymbol, {
			showWhenHarmful = true,
			showWhenHelpful = false,
		})
	else
		if regions.dispelOverlay then regions.dispelOverlay:Hide() end
		if regions.dispelBorder then regions.dispelBorder:Hide() end
		if regions.dispelSymbol then regions.dispelSymbol:Hide() end
		button:ClearAuraBorder()
		button:ClearAuraSymbol()
	end

	button:SetMouseMotionEnabled(not settings.HideTooltip)
	if not regions.durationText then
		regions.durationText = regions.textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	regions.durationText:ClearAllPoints()
	regions.durationText:SetPoint("CENTER", button, "CENTER", 0, 0)
	regions.durationText:SetFont(fontPath, durationFontSize, fontFlags)
	regions.durationText:Show()
	button:SetDurationText(regions.durationText, nil)

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

	container:SetEnabled(false)
	container:Hide()
	container:ClearAllPoints()
	container:SetSize(settings.Width, settings.Height)
	container:SetPoint(layoutAnchorPoint, anchor, layoutAnchorPoint, 0, 0)
	container:SetUnit(unit)
	container:SetAuraLayoutAnchorPoint(layoutAnchorPoint)
	container:SetAuraLayoutGrowthDirection(GetFlowDirections(settings.GrowDirection))
	container:SetAuraLayoutRowWidth(GetRowWidth(settings))

	local options = {
		maxFrameCount = settings.Limit,
		sortMethod = AuraSortMethod.Default,
		sortDirection = AuraSortDirection.Normal,
		initializeFrame = function(button)
			ConfigureButton(state, button, state.settings, state.unit)
		end,
		candidateFilters = {},
		layout = {
			elementWidth = settings.Width,
			elementHeight = settings.Height,
			elementSpacingX = settings.Spacing or 0,
			elementSpacingY = settings.Spacing or 0,
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
	for button in pairs(state.buttonRegions) do
		ConfigureButton(state, button, settings, unit)
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
	state.initialized = false
end

---@param self DBMAuraTracking
---@param key string
---@param unit playerUUIDs
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
local function UpdatePreviewFrame(frame, settings, texture)
	---@cast frame DBMAuraPreviewFrame
	frame.Textures = frame.Textures or {}
	frame.BorderTextures = frame.BorderTextures or {}
	frame.Symbols = frame.Symbols or {}
	frame.DurationTexts = frame.DurationTexts or {}
	frame.StackTexts = frame.StackTexts or {}
	frame:ClearAllPoints()
	frame:SetPoint(settings.Anchor, UIParent, settings.relativeTo, settings.xOffset, settings.yOffset)
	frame:SetSize(settings.Width, settings.Height)
	for i=1, 10 do
		if i <= settings.Limit then
			ConfigurePreviewSlot(frame, settings, i, texture, AuraTrackingPreviewDispelTypes[((i - 1) % #AuraTrackingPreviewDispelTypes) + 1])
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
end

function AuraTracking:IsRegistered()
	return auraAnchorsRegistered
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
	if UnitGroupRolesAssigned("player") ~= "TANK" then return end

	local maxCoTanks = DBM.Options.PrivateAurasCoTankShowSecond and 2 or 1
	local registeredCoTanks = 0
	for unit in DBM:GetGroupMembers() do
		if not UnitIsUnit("player", unit) and DBM:IsTanking(unit) then
			registeredCoTanks = registeredCoTanks + 1
			RegisterAuraContainer(self, "cotank" .. registeredCoTanks, unit, GetCoTankSettings(registeredCoTanks))
			if registeredCoTanks >= maxCoTanks then
				break
			end
		end
	end
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
	local inInstance, instanceType = IsInInstance()
	return inInstance and instanceType ~= "pvp" and instanceType ~= "arena"
end

function AuraTracking:UpdateAuraAnchors()
	if InCombatLockdown() then
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
		UpdatePreviewFrame(self.CoTankPreview, CoTankSettings, 236318)
		if DBM.Options.PrivateAurasCoTankShowSecond then
			self.CoTankPreview2 = self.CoTankPreview2 or CreateFrame("Frame", nil, UIParent)
			UpdatePreviewFrame(self.CoTankPreview2, GetCoTankSettings(2), 236318)
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
	local PlayerSettings = GetAuraSettings("PrivateAurasPlayer")
	local CoTankSettings = GetCoTankSettings(1)
	local CoTankSettings2 = GetCoTankSettings(2)
	if self.IsInPreview then
		DBM:Unschedule(stopMoving)
		stopMoving(self)
		DBT:CancelBar("AuraMove")
	else
		DBM:Schedule(30, stopMoving, self)
		DBT:CreateBar(30, "AuraMove", 136116, true):SetText(DBM_CORE_L.MOVABLE_FRAMES)
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
			UpdatePreviewFrame(self.CoTankPreview, CoTankSettings, 236318)
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
				UpdatePreviewFrame(self.CoTankPreview2, CoTankSettings2, 236318)
				self.CoTankPreview2:Show()
			elseif self.CoTankPreview2 then
				self.CoTankPreview2:Hide()
			end
		end
	end
end
