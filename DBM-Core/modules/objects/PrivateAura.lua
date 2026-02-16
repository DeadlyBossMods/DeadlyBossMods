---@class DBM
local DBM = DBM

---@class DBMPrivateAuras
local PrivateAuras = {}
DBM.PrivateAuras = PrivateAuras
local LSM = LibStub("LibSharedMedia-3.0")

-- /run DBM.PrivateAuras:RegisterPrivateAuras("player")
function PrivateAuras:RegisterPrivateAuras(unit, settingsOverwrite)
    if not self.PAFrames then self.PAFrames = {} end
    if not self.PAStackFrames then self.PAStackFrames = {} end
    if not self.PAAnchorFrames then self.PAAnchorFrames = {} end
    if not self.PAFrames[unit] then self.PAFrames[unit] = {} end
    if not self.PAStackFrames[unit] then self.PAStackFrames[unit] = {} end
    if not self.PAAnchorFrames[unit] then self.PAAnchorFrames[unit] = {} end
    local settings = settingsOverwrite or (unit == "player" and DBM.Options.PrivateAuras["player"] or DBM.Options.PrivateAuras["CoTank"])
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
    if unit == "player" then
        local TextSettings = DBM.Options.PrivateAuras["TextAnchor"]
        if TextSettings.enabled then
            if not self.PATextFrame then self.PATextFrame = CreateFrame("Frame", nil, UIParent) end
            self.PATextFrame:ClearAllPoints()
            self.PATextFrame:SetPoint(TextSettings.Anchor, UIParent, TextSettings.relativeTo, TextSettings.xOffset, TextSettings.yOffset)
            self.PATextFrame:SetSize(TextSettings.Scale*20, TextSettings.Scale*30)
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
            showCountdownFrame = true,
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
        self.PAFrames[unit].Anchors[auraIndex] = C_UnitAuras.AddPrivateAuraAnchor(privateAnchorArgs)
        if scale ~= 1 then
            local durationArgs = {
                unitToken = unit,
                auraIndex = auraIndex,
                parent = self.PAStackFrames[unit][auraIndex],
                showCountdownFrame = false,
                showCountdownNumbers = false,
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

-- /run DBM.PrivateAuras:UnregisterPrivateAuras("player")
function PrivateAuras:UnregisterPrivateAuras(unit, all)
    if not self.PAFrames then return end
    if all then
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

-- /run DBM.PrivateAuras:PreviewToggle()
function PrivateAuras:PreviewToggle()
    local PlayerSettings = DBM.Options.PrivateAuras["player"]
    local TextAnchorSettings = DBM.Options.PrivateAuras["TextAnchor"]
    local CoTankSettings = DBM.Options.PrivateAuras["CoTank"]
    if self.IsInPreview then
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
        if self.TextWarningPreview then
            self.TextWarningPreview:Hide()
        end
    else
        self.IsInPreview = true
        if PlayerSettings.enabled then
            if not self.PlayerPreview then
                self.PlayerPreview = CreateFrame("Frame", nil, UIParent)
                self.PlayerPreview:SetPoint(PlayerSettings.Anchor, UIParent, PlayerSettings.relativeTo, PlayerSettings.xOffset, PlayerSettings.yOffset)
                self.PlayerPreview:SetSize(PlayerSettings.Width, PlayerSettings.Height)
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
                    DBM.Options.PrivateAuras["player"].xOffset = xOffset
                    DBM.Options.PrivateAuras["player"].yOffset = yOffset
                    DBM.Options.PrivateAuras["player"].Anchor = Anchor
                    DBM.Options.PrivateAuras["player"].relativeTo = relativeTo
                end)
            end
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
                self.TextWarningPreview.Text:SetText("<secret value> targets you with the spell <secret value>")
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
                    DBM.Options.PrivateAuras["TextAnchor"].xOffset = xOffset
                    DBM.Options.PrivateAuras["TextAnchor"].yOffset = yOffset
                    DBM.Options.PrivateAuras["TextAnchor"].Anchor = Anchor
                    DBM.Options.PrivateAuras["TextAnchor"].relativeTo = relativeTo
                end)
                self.TextWarningPreview:SetMovable(true)
                self.TextWarningPreview:EnableMouse(true)
                self.TextWarningPreview:RegisterForDrag("LeftButton")
                self.TextWarningPreview:SetClampedToScreen(true)
            end
            self.TextWarningPreview:Show()
            local font = LSM:Fetch("font", "Friz Quadrata TT") or "Friz Quadrata TT"--Satisfy LuaLS
            self.TextWarningPreview.Text:SetFont(font, TextAnchorSettings.Scale*20, "OUTLINE")
            self.TextWarningPreview:SetSize(self.TextWarningPreview.Text:GetStringWidth(), self.TextWarningPreview.Text:GetStringHeight()*1.5)
            self.TextWarningPreview:SetPoint(TextAnchorSettings.Anchor, UIParent, TextAnchorSettings.relativeTo, TextAnchorSettings.xOffset, TextAnchorSettings.yOffset)
        end
        if CoTankSettings.enabled then
            if not self.CoTankPreview then
                self.CoTankPreview = CreateFrame("Frame", nil, UIParent)
                self.CoTankPreview:SetPoint(CoTankSettings.Anchor, UIParent, CoTankSettings.relativeTo, CoTankSettings.xOffset, CoTankSettings.yOffset)
                self.CoTankPreview:SetSize(CoTankSettings.Width, CoTankSettings.Height)
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
                    DBM.Options.PrivateAuras["CoTank"].xOffset = xOffset
                    DBM.Options.PrivateAuras["CoTank"].yOffset = yOffset
                    DBM.Options.PrivateAuras["CoTank"].Anchor = Anchor
                    DBM.Options.PrivateAuras["CoTank"].relativeTo = relativeTo
                end)
            end
            for i=1, 10 do
                if i <= CoTankSettings.Limit then
                    self.CoTankPreview.Textures[i] = self.CoTankPreview.Textures[i] or self.CoTankPreview:CreateTexture(nil, "ARTWORK")
                    self.CoTankPreview.Textures[i]:SetTexture(236318)
                    self.CoTankPreview.Textures[i]:SetSize(CoTankSettings.Width, CoTankSettings.Height)
                    local xOffset = (CoTankSettings.GrowDirection == "RIGHT" and (i-1)*(CoTankSettings.Width+CoTankSettings.Spacing)) or (CoTankSettings.GrowDirection == "LEFT" and -(i-1)*(CoTankSettings.Width+CoTankSettings.Spacing)) or 0
                    local yOffset = (CoTankSettings.GrowDirection == "UP" and (i-1)*(CoTankSettings.Height+CoTankSettings.Spacing)) or (CoTankSettings.GrowDirection == "DOWN" and -(i-1)*(CoTankSettings.Height+CoTankSettings.Spacing)) or 0
                    self.CoTankPreview.Textures[i]:SetPoint("CENTER", self.CoTankPreview, "CENTER", xOffset, yOffset)
                elseif self.CoTankPreview.Textures[i] then
                    self.CoTankPreview.Textures[i]:Hide()
                end
            end
            self.CoTankPreview:Show()
            self.CoTankPreview:SetMovable(true)
            self.CoTankPreview:EnableMouse(true)
        end
    end
end

-- /run DBM.PrivateAuras:RegisterAllUnits()
function PrivateAuras:RegisterAllUnits() -- register private auras for player and the first co-tank found in raid
    self:RegisterPrivateAuras("player")
    if not IsInGroup() then return end
    if UnitGroupRolesAssigned("player") ~= "TANK" then return end
    for unit in DBM:GetGroupMembers() do
        if UnitExists(unit) and UnitGroupRolesAssigned(unit) == "TANK" and not UnitIsUnit(unit, "player") then
            self:RegisterPrivateAuras(unit)
            break
        end
    end
end
