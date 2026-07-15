if DBM:GetTOC() < 120100 then return end -- 12.1+ aura container implementation
---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBMAuraTracking
local AuraTracking = {}
DBM.Auras = AuraTracking

local AuraTrackingFilters = {
	"HARMFUL|!PLAYER",
}

local AuraSortMethod = _G.AuraContainerSortMethod or { Default = 1 }
local AuraSortDirection = _G.AuraContainerSortDirection or { Normal = 1 }
local ButtonRegions = setmetatable({}, { __mode = "k" })

local auraAnchorsRegistered = false

---@param prefix string The prefix for the option keys (e.g., "PrivateAurasPlayer")
---@return table Settings table with all configuration properties
local function GetAuraSettings(prefix)
	return {
		HideBorder = DBM.Options[prefix .. "HideBorder"],
		HideTooltip = DBM.Options[prefix .. "HideTooltip"],
		Scale = DBM.Options[prefix .. "Scale"],
		Spacing = DBM.Options[prefix .. "Spacing"],
		Limit = DBM.Options[prefix .. "Limit"],
		GrowDirection = DBM.Options[prefix .. "GrowDirection"],
		enabled = DBM.Options[prefix .. "Enabled"],
		Width = DBM.Options[prefix .. "Width"],
		Height = DBM.Options[prefix .. "Height"],
		Anchor = DBM.Options[prefix .. "Anchor"],
		relativeTo = DBM.Options[prefix .. "RelativeTo"],
		xOffset = DBM.Options[prefix .. "XOffset"],
		yOffset = DBM.Options[prefix .. "YOffset"],
	}
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

---@param button Frame
---@param settings table
---@param unit playerUUIDs
local function ConfigureButton(button, settings, unit)
	local regions = ButtonRegions[button]
	if not regions then
		regions = {}
		regions.icon = button:CreateTexture(nil, "ARTWORK")
		regions.icon:SetAllPoints(button)
		button:SetIcon(regions.icon)
		regions.textOverlay = CreateFrame("Frame", nil, button)
		regions.textOverlay:SetAllPoints()
		regions.textOverlay:SetFrameLevel(button:GetFrameLevel() + 3)
		ButtonRegions[button] = regions
	end

	button:SetSize(settings.Width, settings.Height)
	regions.textOverlay:SetFrameLevel(button:GetFrameLevel() + 3)

	if settings.HideBorder then
		button:ClearAuraBorder()
	elseif regions.borderTexture then
		button:SetAuraBorder(regions.borderTexture, {
			showIcon = true,
			showWhenHarmful = true,
			showWhenHelpful = true,
		})
	end

	button:SetMouseMotionEnabled(not settings.HideTooltip)
	if not regions.durationText then
		regions.durationText = regions.textOverlay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	end
	regions.durationText:ClearAllPoints()
	regions.durationText:SetPoint("CENTER", button, "CENTER", 0, 0)
	regions.durationText:SetFont(private.standardFont, 14, "OUTLINE")
	regions.durationText:Show()
	button:SetDurationText(regions.durationText, nil)

end

---@param self DBMAuraTracking
---@param key string
---@return table
local function AcquireContainerState(self, key)
	---@diagnostic disable-next-line: inject-field
	if not self.AuraTrackingState then self.AuraTrackingState = {} end
	if not self.AuraTrackingState[key] then self.AuraTrackingState[key] = {} end
	local state = self.AuraTrackingState[key]
	if not state.container then
		if not C_AddOns.IsAddOnLoaded("Blizzard_AuraContainer") then
			C_AddOns.LoadAddOn("Blizzard_AuraContainer")
		end
		state.container = CreateFrame("AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")
		state.anchor = CreateFrame("Frame", nil, UIParent)
		state.groupKey = "DBM_Aura_" .. key
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
			ConfigureButton(button, settings, unit)
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

	container:Show()
	container:SetEnabled(true)
	state.unit = unit
	state.settings = settings
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
end

---@param frame Frame
---@param settings table
local function UpdateCoTankPreviewFrame(frame, settings)
	---@diagnostic disable-next-line: inject-field
	frame.Textures = frame.Textures or {}
	frame:ClearAllPoints()
	frame:SetPoint(settings.Anchor, UIParent, settings.relativeTo, settings.xOffset, settings.yOffset)
	frame:SetSize(settings.Width, settings.Height)
	for i=1, 10 do
		if i <= settings.Limit then
			frame.Textures[i] = frame.Textures[i] or frame:CreateTexture(nil, "ARTWORK")
			frame.Textures[i]:SetTexture(236318)
			frame.Textures[i]:SetSize(settings.Width, settings.Height)
			local xOffset = (settings.GrowDirection == "RIGHT" and (i-1)*(settings.Width+settings.Spacing)) or (settings.GrowDirection == "LEFT" and -(i-1)*(settings.Width+settings.Spacing)) or 0
			local yOffset = (settings.GrowDirection == "UP" and (i-1)*(settings.Height+settings.Spacing)) or (settings.GrowDirection == "DOWN" and -(i-1)*(settings.Height+settings.Spacing)) or 0
			frame.Textures[i]:SetPoint("CENTER", frame, "CENTER", xOffset, yOffset)
			frame.Textures[i]:Show()
		elseif frame.Textures[i] then
			frame.Textures[i]:Hide()
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
		self:UpdateAuraAnchors()
		return
	end
	if player then
		if self.PlayerPreview then
			local PlayerSettings = GetAuraSettings("PrivateAurasPlayer")
			self.PlayerPreview:ClearAllPoints()
			self.PlayerPreview:SetPoint(PlayerSettings.Anchor, UIParent, PlayerSettings.relativeTo, PlayerSettings.xOffset, PlayerSettings.yOffset)
			self.PlayerPreview:SetSize(PlayerSettings.Width, PlayerSettings.Height)
			for i=1, 10 do
				if i <= PlayerSettings.Limit then
					self.PlayerPreview.Textures[i] = self.PlayerPreview.Textures[i] or self.PlayerPreview:CreateTexture(nil, "ARTWORK")
					self.PlayerPreview.Textures[i]:SetTexture(237555)
					self.PlayerPreview.Textures[i]:SetSize(PlayerSettings.Width, PlayerSettings.Height)
					local xOffset = (PlayerSettings.GrowDirection == "RIGHT" and (i-1)*(PlayerSettings.Width+PlayerSettings.Spacing)) or (PlayerSettings.GrowDirection == "LEFT" and -(i-1)*(PlayerSettings.Width+PlayerSettings.Spacing)) or 0
					local yOffset = (PlayerSettings.GrowDirection == "UP" and (i-1)*(PlayerSettings.Height+PlayerSettings.Spacing)) or (PlayerSettings.GrowDirection == "DOWN" and -(i-1)*(PlayerSettings.Height+PlayerSettings.Spacing)) or 0
					self.PlayerPreview.Textures[i]:SetPoint("CENTER", self.PlayerPreview, "CENTER", xOffset, yOffset)
					self.PlayerPreview.Textures[i]:Show()
				elseif self.PlayerPreview.Textures[i] then
					self.PlayerPreview.Textures[i]:Hide()
				end
			end
		end
	elseif self.CoTankPreview then
		local CoTankSettings = GetCoTankSettings(1)
		UpdateCoTankPreviewFrame(self.CoTankPreview, CoTankSettings)
		if DBM.Options.PrivateAurasCoTankShowSecond then
			self.CoTankPreview2 = self.CoTankPreview2 or CreateFrame("Frame", nil, UIParent)
			self.CoTankPreview2.Textures = self.CoTankPreview2.Textures or {}
			UpdateCoTankPreviewFrame(self.CoTankPreview2, GetCoTankSettings(2))
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
		self:UpdateAuraAnchors()
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
			self.PlayerPreview:ClearAllPoints()
			self.PlayerPreview:SetPoint(PlayerSettings.Anchor, UIParent, PlayerSettings.relativeTo, PlayerSettings.xOffset, PlayerSettings.yOffset)
			self.PlayerPreview:SetSize(PlayerSettings.Width, PlayerSettings.Height)
			for i=1, 10 do
				if i <= PlayerSettings.Limit then
					self.PlayerPreview.Textures[i] = self.PlayerPreview.Textures[i] or self.PlayerPreview:CreateTexture(nil, "ARTWORK")
					self.PlayerPreview.Textures[i]:SetTexture(237555)
					self.PlayerPreview.Textures[i]:SetSize(PlayerSettings.Width, PlayerSettings.Height)
					local xOffset = (PlayerSettings.GrowDirection == "RIGHT" and (i-1)*(PlayerSettings.Width+PlayerSettings.Spacing)) or (PlayerSettings.GrowDirection == "LEFT" and -(i-1)*(PlayerSettings.Width+PlayerSettings.Spacing)) or 0
					local yOffset = (PlayerSettings.GrowDirection == "UP" and (i-1)*(PlayerSettings.Height+PlayerSettings.Spacing)) or (PlayerSettings.GrowDirection == "DOWN" and -(i-1)*(PlayerSettings.Height+PlayerSettings.Spacing)) or 0
					self.PlayerPreview.Textures[i]:SetPoint("CENTER", self.PlayerPreview, "CENTER", xOffset, yOffset)
					self.PlayerPreview.Textures[i]:Show()
				elseif self.PlayerPreview.Textures[i] then
					self.PlayerPreview.Textures[i]:Hide()
				end
			end
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
			UpdateCoTankPreviewFrame(self.CoTankPreview, CoTankSettings)
			self.CoTankPreview:Show()
			self.CoTankPreview:SetMovable(true)
			self.CoTankPreview:EnableMouse(true)
			if DBM.Options.PrivateAurasCoTankShowSecond then
				if not self.CoTankPreview2 then
					self.CoTankPreview2 = CreateFrame("Frame", nil, UIParent)
					self.CoTankPreview2.Textures = {}
				end
				UpdateCoTankPreviewFrame(self.CoTankPreview2, CoTankSettings2)
				self.CoTankPreview2:Show()
			elseif self.CoTankPreview2 then
				self.CoTankPreview2:Hide()
			end
		end
	end
end
