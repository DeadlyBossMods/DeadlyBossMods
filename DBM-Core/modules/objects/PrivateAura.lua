---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBMPrivateAuras
---@field PATextFrame Frame?
---@field PATextWarning Frame?
---@field AuraContainerState table?
---@field UseAuraContainerSystemAvailable boolean?
---@field AuraContainerProbe Frame?
---@field AuraButtonProbe Frame?
local PrivateAuras = {}
DBM.PrivateAuras = PrivateAuras

local PAAnchorsRegistered = false
local wowToC = DBM:GetTOC()
local AURA_CONTAINER_FILTERS = {
    "RAID",
    "RAID_IN_COMBAT",
    "RAID_PLAYER_DISPELLABLE",
}
local PrivateAuraDurationFormatter

local function GetPrivateAuraDurationFormatter()
    if PrivateAuraDurationFormatter then
        return PrivateAuraDurationFormatter
    end
    if not C_StringUtil or not C_StringUtil.CreateNumericRuleFormatter then
        return nil
    end
    PrivateAuraDurationFormatter = C_StringUtil.CreateNumericRuleFormatter()
    PrivateAuraDurationFormatter:SetBreakpoints({
        {
            threshold = 0,
            step = 1,
            rounding = Enum.NumericRuleFormatRounding.Up,
            format = "%d",
        },
    })
    return PrivateAuraDurationFormatter
end

---@param privateAnchorArgs table
---@param showFrame boolean
local function SetPrivateAnchorFrameVisibilityArgs(privateAnchorArgs, showFrame)
    if wowToC >= 120100 then
        privateAnchorArgs.showCooldownFrame = showFrame
        privateAnchorArgs.showCooldownEdge = showFrame
    else
        privateAnchorArgs.showCountdownFrame = showFrame
    end
end

---Helper function to build a settings table from flattened option keys
---@param prefix string The prefix for the option keys (e.g., "PrivateAurasPlayer")
---@return table Settings table with all configuration properties
local function GetPrivateAuraSettings(prefix)
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
        UpscaleDuration = DBM.Options[prefix .. "UpscaleDuration"],
    }
end

---@param self DBMPrivateAuras
local function SetupPrivateWarningTextAnchor(self)
    local TextSettings = GetPrivateAuraSettings("PrivateAurasTextAnchor")
    if not TextSettings.enabled then return end
    if not self.PATextFrame then self.PATextFrame = CreateFrame("Frame", nil, UIParent) end
    self.PATextFrame:ClearAllPoints()
    self.PATextFrame:SetPoint(TextSettings.Anchor, UIParent, TextSettings.relativeTo, TextSettings.xOffset, TextSettings.yOffset)
    self.PATextFrame:SetSize(TextSettings.Scale * 20, TextSettings.Scale * 30)
    if not self.PATextWarning then self.PATextWarning = CreateFrame("Frame", nil, UIParent) end

    -- I have absolutely no clue why this math works out but it does
    self.PATextWarning:SetPoint("TOPLEFT", self.PATextFrame, "TOPLEFT", 0, -24)
    self.PATextWarning:SetPoint("BOTTOMRIGHT", self.PATextFrame, "BOTTOMRIGHT", 0, -24)
    self.PATextWarning:SetScale(TextSettings.Scale)
    local textanchor =
    {
        point = "CENTER",
        relativeTo = self.PATextWarning,
        relativePoint = "CENTER",
        offsetX = 0,
        offsetY = 0,
    }
    C_UnitAuras.SetPrivateWarningTextAnchor(self.PATextWarning, textanchor)
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
    local settings = GetPrivateAuraSettings("PrivateAurasCoTank")
    if index and index > 1 then
        settings.yOffset = settings.yOffset - GetCoTankRowYOffset(settings) * (index - 1)
    end
    return settings
end

---@class DBMPrivateAuraPreviewFrame: Frame
---@field Textures Texture[]

---@param frame Frame
---@param settings table
local function UpdateCoTankPreviewFrame(frame, settings)
    ---@cast frame DBMPrivateAuraPreviewFrame
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

function PrivateAuras:IsRegistered()
	return PAAnchorsRegistered
end

function PrivateAuras:UseAuraContainerSystem()
    if wowToC < 120100 then
        return false
    end
    if self.UseAuraContainerSystemAvailable ~= nil then
        return self.UseAuraContainerSystemAvailable
    end
    if C_AddOns and C_AddOns.LoadAddOn and C_AddOns.IsAddOnLoaded then
        if not C_AddOns.IsAddOnLoaded("Blizzard_AuraContainer") then
            local loaded = C_AddOns.LoadAddOn("Blizzard_AuraContainer")
            if not loaded then
                self.UseAuraContainerSystemAvailable = false
                return false
            end
        end
    else
        local loadAddOn = _G.LoadAddOn
        local isAddOnLoaded = _G.IsAddOnLoaded
        if loadAddOn and isAddOnLoaded and not isAddOnLoaded("Blizzard_AuraContainer") then
            local loaded = loadAddOn("Blizzard_AuraContainer")
            if not loaded then
                self.UseAuraContainerSystemAvailable = false
                return false
            end
        end
    end
    local containerOk, container = pcall(CreateFrame, "AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")
    if not containerOk or not container then
        self.UseAuraContainerSystemAvailable = false
        return false
    end
    local buttonOk, button = pcall(CreateFrame, "AuraButton", nil, container, "CustomAuraButtonTemplate")
    if not buttonOk or not button then
        self.UseAuraContainerSystemAvailable = false
        return false
    end
    self.AuraContainerProbe = container
    self.AuraButtonProbe = button
    self.UseAuraContainerSystemAvailable = true
    return true
end

---@param container Frame
---@param limit number
local function AddAuraContainerFilters(container, limit)
    container:ClearAuraFilters()
    for _, filter in ipairs(AURA_CONTAINER_FILTERS) do
        container:AddAuraFilter(filter, { maxFrameCount = limit })
    end
end

---@param self DBMPrivateAuras
---@param unit string
---@return table
local function AcquireAuraContainerState(self, unit)
    if not self.AuraContainerState then self.AuraContainerState = {} end
    if not self.AuraContainerState[unit] then self.AuraContainerState[unit] = {} end
    local state = self.AuraContainerState[unit]
    if not state.container then
        state.container = CreateFrame("AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")
        state.container:SetFrameStrata("HIGH")
        state.buttons = {}
        state.buttonRegions = {}
    end
    return state
end

---@param self DBMPrivateAuras
---@param state table
---@param index number
---@param settings table
---@return Frame
local function AcquireAuraContainerButton(self, state, index, settings)
    if not state.buttons[index] or not state.buttonRegions[index] then
        local button = CreateFrame("AuraButton", nil, state.container, "CustomAuraButtonTemplate")
        local regions = {}
        regions.icon = button:CreateTexture(nil, "ARTWORK")
        regions.icon:SetAllPoints(button)
        button:SetIcon(regions.icon)

        regions.count = button:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
        button:SetApplicationCount(regions.count, {})

        regions.duration = button:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
        local formatter = GetPrivateAuraDurationFormatter()
        if formatter then
            button:SetDurationText(regions.duration, { formatter = formatter })
        else
            button:SetDurationText(regions.duration, {})
        end

        if button.SetDurationCooldown then
            regions.cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
            regions.cooldown:SetAllPoints(regions.icon)
            regions.cooldown:SetFrameLevel(button:GetFrameLevel() + 1)
            regions.cooldown:SetReverse(true)
            regions.cooldown:SetDrawEdge(false)
            regions.cooldown:SetHideCountdownNumbers(settings.UpscaleDuration)
            button:SetDurationCooldown(regions.cooldown)
        end

        state.buttons[index] = button
        state.buttonRegions[index] = regions
    end
    local button = state.buttons[index]
    local regions = state.buttonRegions[index]

    button:SetSize(settings.Width, settings.Height)
    regions.icon:SetAllPoints(button)

    local fontScale = settings.Scale or 1
    local durationFontSize = math.max(8, math.floor((settings.UpscaleDuration and 18 or 12) * fontScale))
    local countFontSize = math.max(8, math.floor(11 * fontScale))

    regions.count:ClearAllPoints()
    regions.count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
    regions.count:SetFont(private.standardFont, countFontSize, "OUTLINE")
    button:SetApplicationCount(regions.count, {})

    regions.duration:ClearAllPoints()
    regions.duration:SetPoint("CENTER", button, "CENTER", 0, 0)
    regions.duration:SetFont(private.standardFont, durationFontSize, "OUTLINE")
    if settings.UpscaleDuration then
        local formatter = GetPrivateAuraDurationFormatter()
        if formatter then
            button:SetDurationText(regions.duration, { formatter = formatter })
        else
            button:SetDurationText(regions.duration, {})
        end
    elseif button.ClearDurationText and regions.cooldown then
        button:ClearDurationText()
    elseif button.SetDurationText then
        local formatter = GetPrivateAuraDurationFormatter()
        if formatter then
            button:SetDurationText(regions.duration, { formatter = formatter })
        else
            button:SetDurationText(regions.duration, {})
        end
    end

    if button.SetMouseMotionEnabled then
        button:SetMouseMotionEnabled(not settings.HideTooltip)
    end
    if button.EnableMouse then
        button:EnableMouse(not settings.HideTooltip)
    end

    if settings.HideBorder then
        if button.ClearAuraBorder then
            button:ClearAuraBorder()
        end
    else
        if not regions.border then
            regions.border = button:CreateTexture(nil, "OVERLAY")
            regions.border:SetAllPoints(button)
        end
        if button.SetAuraBorder then
            button:SetAuraBorder(regions.border, {
                showIcon = true,
                showWhenHarmful = true,
                showWhenHelpful = true,
            })
        end
    end

    if regions.cooldown then
        regions.cooldown:SetHideCountdownNumbers(settings.UpscaleDuration)
        regions.cooldown:SetScale(settings.Scale or 1)
    end

    return button
end

---@param unit playerUUIDs
---@param settingsOverwrite table?
function PrivateAuras:RegisterAuraContainerAuras(unit, settingsOverwrite)
    local settings = settingsOverwrite or (unit == "player" and GetPrivateAuraSettings("PrivateAurasPlayer") or GetPrivateAuraSettings("PrivateAurasCoTank"))
    local state = AcquireAuraContainerState(self, unit)
    local container = state.container

    container:SetEnabled(false)
    container:RemoveAllAuraFrames()
    container:ClearAuraFilters()

    if DBM.Options.DontShowPrivateAuraFrame then return end

    if unit == "player" then
        SetupPrivateWarningTextAnchor(self)
    end

    if not settings.enabled then return end

    local xDirection = (settings.GrowDirection == "RIGHT" and 1) or (settings.GrowDirection == "LEFT" and -1) or 0
    local yDirection = (settings.GrowDirection == "DOWN" and -1) or (settings.GrowDirection == "UP" and 1) or 0

    container:ClearAllPoints()
    container:SetSize(settings.Width, settings.Height)
    container:SetPoint(settings.Anchor, UIParent, settings.relativeTo, settings.xOffset, settings.yOffset)
    container:SetUnit(unit)
    AddAuraContainerFilters(container, settings.Limit)

    for auraIndex = 1, settings.Limit do
        local button = AcquireAuraContainerButton(self, state, auraIndex, settings)
        local xOffset = (auraIndex - 1) * (settings.Width + settings.Spacing) * xDirection
        local yOffset = (auraIndex - 1) * (settings.Height + settings.Spacing) * yDirection
        button:ClearAllPoints()
        button:SetPoint("CENTER", container, "CENTER", xOffset, yOffset)
        container:AddAuraFrame(button)
    end

    container:SetEnabled(true)
end

---Register Private Aura Display frame/text for a unit. Will unregister existing anchors for the unit before registering new ones
---@param unit playerUUIDs
---@param settingsOverwrite table? Optional settings table to use instead of DBM.Options.PrivateAurasPlayer/PrivateAurasCoTank (used for preview)
function PrivateAuras:RegisterPrivateAuras(unit, settingsOverwrite)
    if self:UseAuraContainerSystem() then
        return self:RegisterAuraContainerAuras(unit, settingsOverwrite)
    end
    if not self.PAFrames then self.PAFrames = {} end
    if not self.PAStackFrames then self.PAStackFrames = {} end
    if not self.PAAnchorFrames then self.PAAnchorFrames = {} end
    if not self.PAFrames[unit] then self.PAFrames[unit] = {} end
    if not self.PAStackFrames[unit] then self.PAStackFrames[unit] = {} end
    if not self.PAAnchorFrames[unit] then self.PAAnchorFrames[unit] = {} end
    local settings = settingsOverwrite or (unit == "player" and GetPrivateAuraSettings("PrivateAurasPlayer") or GetPrivateAuraSettings("PrivateAurasCoTank"))
    if self.PAFrames[unit] and self.PAFrames[unit].Anchors then -- unregister all existing anchors for the unit
        for i=1, 10 do
            if self.PAFrames[unit].Anchors[i] then
                C_UnitAuras.RemovePrivateAuraAnchor(self.PAFrames[unit].Anchors[i])
            end
        end
        self.PAFrames[unit].Anchors = {}
    end
    if self.PAFrames[unit] and self.PAFrames[unit].StackAnchors then -- unregister all existing stack anchors for the unit
        for i=1, 10 do
            if self.PAFrames[unit].StackAnchors[i] then
                C_UnitAuras.RemovePrivateAuraAnchor(self.PAFrames[unit].StackAnchors[i])
            end
        end
        self.PAFrames[unit].StackAnchors = {}
    end
	if DBM.Options.DontShowPrivateAuraFrame then return end -- Hard global disable
    if unit == "player" then
        SetupPrivateWarningTextAnchor(self)
    end
    if not settings.enabled then return end -- end after unregistering if not enabled
    if not self.PAFrames[unit].Anchors then self.PAFrames[unit].Anchors = {} end
    if not self.PAFrames[unit].StackAnchors then self.PAFrames[unit].StackAnchors = {} end
    local scale = settings.Scale
    local borderSize = settings.HideBorder and -100 or settings.Width/16
    local xDirection = (settings.GrowDirection == "RIGHT" and 1) or (settings.GrowDirection == "LEFT" and -1) or 0
    local yDirection = (settings.GrowDirection == "DOWN" and -1) or (settings.GrowDirection == "UP" and 1) or 0
    for auraIndex=1, settings.Limit do
        if not self.PAFrames[unit][auraIndex] then
            self.PAFrames[unit][auraIndex] = CreateFrame("Frame", nil, UIParent)
            self.PAFrames[unit][auraIndex]:SetFrameStrata("HIGH")
            self.PAFrames[unit][auraIndex]:Show()
        end
        if not self.PAStackFrames[unit][auraIndex] then
            self.PAStackFrames[unit][auraIndex] = CreateFrame("Frame", nil, UIParent)
            self.PAStackFrames[unit][auraIndex]:SetSize(0.001, 0.001)
            self.PAStackFrames[unit][auraIndex]:SetFrameStrata("DIALOG")
            self.PAStackFrames[unit][auraIndex]:SetPoint("CENTER", self.PAFrames[unit][auraIndex], "CENTER", 0, 0)
        end
        if not self.PAAnchorFrames[unit][auraIndex] then
            self.PAAnchorFrames[unit][auraIndex] = CreateFrame("Frame", nil, UIParent)
        end
        if settings.HideTooltip then
            self.PAFrames[unit][auraIndex]:SetSize(0.001, 0.001)
        else
            self.PAFrames[unit][auraIndex]:SetSize(settings.Width, settings.Height)
        end
        self.PAAnchorFrames[unit][auraIndex]:SetSize(settings.Width, settings.Height)
        self.PAStackFrames[unit][auraIndex]:SetScale(scale)
        self.PAFrames[unit][auraIndex]:ClearAllPoints()
        self.PAAnchorFrames[unit][auraIndex]:ClearAllPoints()
        self.PAAnchorFrames[unit][auraIndex]:SetPoint(settings.Anchor, UIParent, settings.relativeTo,
        settings.xOffset+(auraIndex-1) * (settings.Width+settings.Spacing) * xDirection,
        settings.yOffset+(auraIndex-1) * (settings.Height+settings.Spacing) * yDirection)
        self.PAFrames[unit][auraIndex]:SetPoint(settings.Anchor, UIParent, settings.relativeTo,
        settings.xOffset+(auraIndex-1) * (settings.Width+settings.Spacing) * xDirection,
        settings.yOffset+(auraIndex-1) * (settings.Height+settings.Spacing) * yDirection)
        local frame = self.PAFrames[unit][auraIndex]
        local privateAnchorArgs = {
            unitToken = unit,
            auraIndex = auraIndex,
            parent = frame,
			isContainer = false,
            showCountdownNumbers = not settings.UpscaleDuration,
            iconInfo = {
                iconAnchor = {
                    point = "CENTER",
                    relativeTo = frame,
                    relativePoint = "CENTER",
                    offsetX = 0,
                    offsetY = 0,
                },
                borderScale = borderSize,
                iconWidth = settings.Width,
                iconHeight = settings.Height,
            },
        }
        SetPrivateAnchorFrameVisibilityArgs(privateAnchorArgs, true)
        self.PAFrames[unit].Anchors[auraIndex] = C_UnitAuras.AddPrivateAuraAnchor(privateAnchorArgs)
        if scale ~= 1 then
            local durationArgs = {
                unitToken = unit,
                auraIndex = auraIndex,
                parent = self.PAStackFrames[unit][auraIndex],
                showCountdownNumbers = false,
				isContainer = false,
                iconInfo = {
                    iconAnchor = {
                        point = "BOTTOMRIGHT",
                        relativeTo = self.PAAnchorFrames[unit][auraIndex],
                        relativePoint = "BOTTOMRIGHT",
                        offsetX = 2,
                        offsetY = -4,
                    },
                    borderScale = -100,
                    iconWidth = 0.001,
                    iconHeight = 0.001,
                },
            }
            SetPrivateAnchorFrameVisibilityArgs(durationArgs, false)
            if settings.UpscaleDuration then
                durationArgs.durationAnchor = {
                    point = "CENTER",
                    relativeTo = self.PAFrames[unit][auraIndex],
                    relativePoint = "CENTER",
                    offsetX = 0,
                    offsetY = 0,
                }
            end
            self.PAFrames[unit].StackAnchors[auraIndex] = C_UnitAuras.AddPrivateAuraAnchor(durationArgs)
        end
    end
end

---@param unit playerUUIDs? if nil, will unregister all units. If string, will unregister that unit
function PrivateAuras:UnregisterPrivateAuras(unit)
	PAAnchorsRegistered = false
    if self.AuraContainerState then
        if not unit then
            for _u, state in pairs(self.AuraContainerState) do
                if state and state.container then
                    state.container:SetEnabled(false)
                    state.container:RemoveAllAuraFrames()
                    state.container:ClearAuraFilters()
                end
            end
        else
            local state = self.AuraContainerState[unit]
            if state and state.container then
                state.container:SetEnabled(false)
                state.container:RemoveAllAuraFrames()
                state.container:ClearAuraFilters()
            end
        end
    end
    if not self.PAFrames then return end
    if not unit then
        for u, _ in pairs(self.PAFrames) do
            self:UnregisterPrivateAuras(u)
        end
    elseif unit then
        if self.PAFrames[unit] then
            if self.PAFrames[unit].Anchors then
                for i=1, 10 do
                    if self.PAFrames[unit].Anchors[i] then
                        C_UnitAuras.RemovePrivateAuraAnchor(self.PAFrames[unit].Anchors[i])
                    end
                end
                self.PAFrames[unit].Anchors = {}
            end
            if self.PAFrames[unit].StackAnchors then
                for i=1, 10 do
                    if self.PAFrames[unit].StackAnchors[i] then
                        C_UnitAuras.RemovePrivateAuraAnchor(self.PAFrames[unit].StackAnchors[i])
                    end
                end
                self.PAFrames[unit].StackAnchors = {}
            end
        end
    end
end

do
	---@param self DBMPrivateAuras
	local function stopMoving(self)
		self.IsInPreview = false
		if self.PlayerPreview then
		    self.PlayerPreview:Hide()
		    self.PlayerPreview:SetMovable(false)
		    self.PlayerPreview:EnableMouse(false)
		end
		if self.CoTankPreview then
		    self.CoTankPreview:Hide()
		    self.CoTankPreview:SetMovable(false)
		    self.CoTankPreview:EnableMouse(false)
		end
        if self.CoTankPreview2 then
            self.CoTankPreview2:Hide()
        end
		if self.TextWarningPreview then
		    self.TextWarningPreview:Hide()
		end
	end

	function PrivateAuras:PreviewToggle()
		if DBM.Options.DontShowPrivateAuraFrame then
			DBM:AddMsg(DBM_CORE_L.MOVE_PRIVATE_AURA_DISABLED)
			return
		end
	    local PlayerSettings = GetPrivateAuraSettings("PrivateAurasPlayer")
	    local TextAnchorSettings = GetPrivateAuraSettings("PrivateAurasTextAnchor")
        local CoTankSettings = GetCoTankSettings(1)
        local CoTankSettings2 = GetCoTankSettings(2)
	    if self.IsInPreview then
			DBM:Unschedule(stopMoving)
	        stopMoving(self)
			DBT:CancelBar("PAMove")
	    else
			DBM:Schedule(30, stopMoving, self)
			DBT:CreateBar(30, "PAMove", 136116, true):SetText(DBM_CORE_L.MOVABLE_FRAMES)
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
	                self.PlayerPreview.Border:SetBackdrop({
	                    edgeFile = "Interface\\Buttons\\WHITE8x8",
	                    edgeSize = 2,
	                })
	                self.PlayerPreview.Border:SetBackdropBorderColor(1, 1, 1, 1)
	                self.PlayerPreview:SetScript("OnDragStart", function(Frame)
	                    Frame:StartMoving()
	                end)
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
	                elseif self.PlayerPreview.Textures[i] then
	                    self.PlayerPreview.Textures[i]:Hide()
	                end
	            end
	            self.PlayerPreview:Show()
	            self.PlayerPreview:SetMovable(true)
	            self.PlayerPreview:EnableMouse(true)
	        end
	        if TextAnchorSettings.enabled then
	            if not self.TextWarningPreview then
	                self.TextWarningPreview = CreateFrame("Frame", nil, UIParent)
	                self.TextWarningPreview.Text = self.TextWarningPreview:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	                self.TextWarningPreview.Text:SetPoint("CENTER", self.TextWarningPreview, "CENTER", 0, 0)
	                self.TextWarningPreview.Text:SetText(DBM_CORE_L.MOVE_PRIVATE_AURA_TEXT)
	                self.TextWarningPreview.Border = CreateFrame("Frame", nil, self.TextWarningPreview, "BackdropTemplate")
	                self.TextWarningPreview.Border:SetPoint("TOPLEFT", self.TextWarningPreview, "TOPLEFT", -6, 6)
	                self.TextWarningPreview.Border:SetPoint("BOTTOMRIGHT", self.TextWarningPreview, "BOTTOMRIGHT", 6, -6)
	                self.TextWarningPreview.Border:SetBackdrop({
	                        edgeFile = "Interface\\Buttons\\WHITE8x8",
	                        edgeSize = 2,
	                    })
	                self.TextWarningPreview.Border:SetBackdropBorderColor(1, 1, 1, 1)
	                self.TextWarningPreview:SetScript("OnDragStart", function(self)
	                    self:StartMoving()
	                end)
	                self.TextWarningPreview:SetScript("OnDragStop", function(Frame)
	                    Frame:StopMovingOrSizing()
	                    local Anchor, _, relativeTo, xOffset, yOffset = Frame:GetPoint()
	                    xOffset = Round(xOffset)
	                    yOffset = Round(yOffset)
	                    DBM.Options.PrivateAurasTextAnchorXOffset = xOffset
	                    DBM.Options.PrivateAurasTextAnchorYOffset = yOffset
	                    DBM.Options.PrivateAurasTextAnchorAnchor = Anchor
	                    DBM.Options.PrivateAurasTextAnchorRelativeTo = relativeTo
	                end)
	                self.TextWarningPreview:SetMovable(true)
	                self.TextWarningPreview:EnableMouse(true)
	                self.TextWarningPreview:RegisterForDrag("LeftButton")
	                self.TextWarningPreview:SetClampedToScreen(true)
	            end
	            self.TextWarningPreview:Show()
	            self.TextWarningPreview.Text:SetFont(private.standardFont, TextAnchorSettings.Scale*20, "OUTLINE")
	            self.TextWarningPreview:SetSize(self.TextWarningPreview.Text:GetStringWidth(), self.TextWarningPreview.Text:GetStringHeight()*1.5)
                self.TextWarningPreview:ClearAllPoints()
	            self.TextWarningPreview:SetPoint(TextAnchorSettings.Anchor, UIParent, TextAnchorSettings.relativeTo, TextAnchorSettings.xOffset, TextAnchorSettings.yOffset)
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
	                self.CoTankPreview.Border:SetBackdrop({
	                    edgeFile = "Interface\\Buttons\\WHITE8x8",
	                    edgeSize = 2,
	                })
	                self.CoTankPreview.Border:SetBackdropBorderColor(1, 1, 1, 1)
	                self.CoTankPreview:SetScript("OnDragStart", function(Frame)
	                    Frame:StartMoving()
	                end)
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
                else
                    if self.CoTankPreview2 then
                        self.CoTankPreview2:Hide()
                    end
                end
	        end
	    end
	end
end

---Register private auras for player and up to two co-tanks found in raid
function PrivateAuras:RegisterAllUnits()
	PAAnchorsRegistered = true
	--Options toggles are checked in actual fuctions. Don't option check here.
	--We still want to unregister events if a user toggles feature off after using it
    self:RegisterPrivateAuras("player")
    if not IsInGroup() then return end
    if UnitGroupRolesAssigned("player") ~= "TANK" then return end
    local maxCoTanks = DBM.Options.PrivateAurasCoTankShowSecond and 2 or 1
    local registeredCoTanks = 0
    for unit in DBM:GetGroupMembers() do
        if not UnitIsUnit("player", unit) and DBM:IsTanking(unit) then
            registeredCoTanks = registeredCoTanks + 1
            self:RegisterPrivateAuras(unit, GetCoTankSettings(registeredCoTanks))
            if registeredCoTanks >= maxCoTanks then
                break
            end
        end
    end
end

do
	local function IsInValidInstance()
		local inInstance, instanceType = IsInInstance()
		return inInstance and instanceType ~= "pvp" and instanceType ~= "arena"
	end

	function PrivateAuras:UpdatePrivateAuraAnchors()
		if PAAnchorsRegistered then
			PAAnchorsRegistered = false
			PrivateAuras:UnregisterPrivateAuras()
		end
		if IsInValidInstance() then
			--No need to call unregister first, RegisterAllUnits already clears existing units first
			PrivateAuras:RegisterAllUnits()
		end
		return true
	end
end

---@param player boolean?
function PrivateAuras:OnSettingsChange(player)
    if not self.IsInPreview then return end
    if player then
        if self.PlayerPreview then
	        local PlayerSettings = GetPrivateAuraSettings("PrivateAurasPlayer")
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
        if self.TextWarningPreview then
            local TextAnchorSettings = GetPrivateAuraSettings("PrivateAurasTextAnchor")
            self.TextWarningPreview.Text:SetFont(private.standardFont, TextAnchorSettings.Scale*20, "OUTLINE")
            self.TextWarningPreview:SetSize(self.TextWarningPreview.Text:GetStringWidth(), self.TextWarningPreview.Text:GetStringHeight()*1.5)
            self.TextWarningPreview:ClearAllPoints()
            self.TextWarningPreview:SetPoint(TextAnchorSettings.Anchor, UIParent, TextAnchorSettings.relativeTo, TextAnchorSettings.xOffset, TextAnchorSettings.yOffset)
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
