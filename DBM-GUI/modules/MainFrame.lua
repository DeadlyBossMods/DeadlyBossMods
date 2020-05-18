local frame = DBM_GUI_OptionsFrame
table.insert(_G["UISpecialFrames"], frame:GetName())
frame:SetSize(800, 600)
frame:SetFrameStrata("DIALOG")
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:SetUserPlaced(true)
frame:RegisterForDrag("LeftButton")
frame:SetFrameLevel(frame:GetFrameLevel() + 4)
frame:Hide()
frame.backdropInfo = {
	bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
	edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
	tile		= true,
	tileSize	= 32,
	edgeSize	= 32,
	insets		= { left = 11, right = 12, top = 12, bottom = 11 }
}
if DBM:IsAlpha() then
	frame:ApplyBackdrop()
else
	frame:SetBackdrop(frame.backdropInfo)
end
frame.firstshow = true
frame:SetScript("OnShow", function(self)
	if self.firstshow then
		self.firstshow = false
		self:ShowTab(1)
		self:UpdateMenuFrame()
	end
end)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame.tabs = {}

local frameHeader = frame:CreateTexture("$parentHeader", "ARTWORK")
frameHeader:SetPoint("TOP", 0, 12)
frameHeader:SetTexture(131080) -- "Interface\\DialogFrame\\UI-DialogBox-Header"
frameHeader:SetSize(300, 68)

local frameHeaderText = frame:CreateFontString("$parentHeaderText", "ARTWORK", "GameFontNormal")
frameHeaderText:SetPoint("TOP", frameHeader:GetName(), 0, -14)
frameHeaderText:SetText("Deadly Boss Mods")

local frameRevision = frame:CreateFontString("$parentRevision", "ARTWORK", "GameFontDisableSmall")
frameRevision:SetPoint("BOTTOMLEFT", frame:GetName(), "BOTTOMLEFT", 20, 18)
if DBM.NewerVersion then
	frameRevision:SetText(DBM_DEADLY_BOSS_MODS.. " " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. "). |cffff0000Version " .. DBM.NewerVersion.. " is available.|r")
else
	frameRevision:SetText(DBM_DEADLY_BOSS_MODS.. " " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. ")")
end

local frameTranslation = frame:CreateFontString("$parentTranslation", "ARTWORK", "GameFontDisableSmall")
frameTranslation:SetPoint("LEFT", frameRevision:GetName(), "RIGHT", 20, 0)
if DBM_GUI_Translations.TranslationBy then
	frameTranslation:SetText(DBM_GUI_Translations.TranslationByPrefix .. DBM_GUI_Translations.TranslationBy)
end

local frameWebsite = frame:CreateFontString("$parentWebsite", "ARTWORK", "GameFontNormal")
frameWebsite:SetPoint("BOTTOMLEFT", frameRevision:GetName(), "TOPLEFT", 0, 15)
frameWebsite:SetText(DBM_GUI_Translations.Website)

local frameWebsiteButtonA = CreateFrame("Frame", nil, frame)
frameWebsiteButtonA:SetAllPoints(frameWebsite)
frameWebsiteButtonA:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, DBM_COPY_URL_DIALOG, "https://discord.gg/deadlybossmods")
end)

local frameOkay = CreateFrame("Button", "$parentOkay", frame, "UIPanelButtonTemplate")
frameOkay:SetSize(96, 22)
frameOkay:SetPoint("BOTTOMRIGHT", -16, 14)
frameOkay:SetText(CLOSE)
frameOkay:SetScript("OnClick", function()
	frame:Hide()
	if DBM.Options.tempMusicSetting then
		SetCVar("Sound_EnableMusic", DBM.Options.tempMusicSetting)
		DBM.Options.tempMusicSetting = nil
	end
	if DBM.Options.musicPlaying then
		StopMusic()
		DBM.Options.musicPlaying = nil
	end
end)

local frameWebsiteButton = CreateFrame("Button", "$parentWebsiteButton", frame, "UIPanelButtonTemplate")
frameWebsiteButton:SetSize(96, 22)
frameWebsiteButton:SetPoint("BOTTOMRIGHT", frameOkay:GetName(), "BOTTOMLEFT", -20, 0)
frameWebsiteButton:SetText(DBM_GUI_Translations.WebsiteButton)
frameWebsiteButton:SetScript("OnClick", function()
	DBM:ShowUpdateReminder(nil, nil, DBM_COPY_URL_DIALOG)
end)

local bossMods = CreateFrame("Frame", "$parentBossMods", frame)
bossMods.name = DBM_GUI_Translations.OTabBosses
frame:CreateTab(bossMods)

local DBMOptions = CreateFrame("Frame", "$parentDBMOptions", frame)
DBMOptions.name = DBM_GUI_Translations.OTabOptions
frame:CreateTab(DBMOptions)

local hack = OptionsList_OnLoad
function OptionsList_OnLoad(self, ...)
	print(self:GetName())
	if self:GetName() ~= frame:GetName() .. "List" then
		hack(self, ...)
	end
end
local frameList = CreateFrame("Frame", "$parentList", frame, "OptionsFrameListTemplate")
frameList:SetSize(205, 499)
frameList:SetPoint("TOPLEFT", 22, -40)
frameList:SetScript("OnShow", function()
	frame:UpdateMenuFrame()
end)
frameList:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
frameList.buttons = {}
for i = 1, (frameList:GetHeight() - 8) / 18 do
	local button = CreateFrame("Button", frameList:GetName() .. "Button" .. i, frameList)
	button:SetHeight(18)
	button.text = button:CreateFontString(button:GetName() .. "Text", "ARTWORK", "GameFontNormalSmall")
	button:RegisterForClicks("LeftButtonUp")
	button:SetScript("OnClick", function(self)
		frame:ClearSelection()
		frame:SelectButton(button)
		DBM_GUI.currentViewing = self.element
		frame:DisplayFrame(self.element)
	end)
	if i == 1 then
		button:SetPoint("TOPLEFT", frameList:GetName(), 0, -8)
	else
		button:SetPoint("TOPLEFT", frameList.buttons[i - 1]:GetName(), "BOTTOMLEFT")
	end
	local buttonHighlight = button:CreateTexture("$parentHighlight")
	buttonHighlight:SetTexture(136809) -- "Interface\\QuestFrame\\UI-QuestLogTitleHighlight"
	buttonHighlight:SetBlendMode("ADD")
	buttonHighlight:SetPoint("TOPLEFT", 0, 1)
	buttonHighlight:SetPoint("BOTTOMRIGHT", 0, 1)
	buttonHighlight:SetVertexColor(0.196, 0.388, 0.8)
	button:SetHighlightTexture(buttonHighlight)
	frameList.buttons[i] = button
	local buttonToggle = CreateFrame("Button", "$parentToggle", button, "UIPanelButtonTemplate")
	button.toggle = buttonToggle
	buttonToggle:SetSize(14, 14)
	buttonToggle:SetPoint("TOPLEFT", button:GetName(), "TOPLEFT", 5, -1)
	buttonToggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	buttonToggle:SetScript("OnClick", function()
		button.element.showSub = not button.element.showSub
		frame:UpdateMenuFrame()
	end)
end
local frameListList = _G[frameList:GetName() .. "List"]
frameListList:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)
frameListList.offset = 0
_G[frameListList:GetName() .. "ScrollBarScrollUpButton"]:Disable()
_G[frameListList:GetName() .. "ScrollBarScrollDownButton"]:Disable()
local frameListScrollBar = _G[frameListList:GetName() .. "ScrollBar"]
frameListScrollBar:SetMinMaxValues(0, 11)
frameListScrollBar:SetValue(0)
frameList.scrollBar = frameListScrollBar
frameListList:SetScript("OnVerticalScroll", function(self, offset)
	frameListScrollBar:SetValue(offset)
	self.offset = math.floor((offset / 18) + 0.5)
	frame:UpdateMenuFrame(self:GetParent())
end)
frameList:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then
		frameListScrollBar:SetValue(frameListScrollBar:GetValue() - (frameListScrollBar:GetHeight() / 2))
	else
		frameListScrollBar:SetValue(frameListScrollBar:GetValue() + (frameListScrollBar:GetHeight() / 2))
	end
	frame:UpdateMenuFrame()
end)

local frameContainer = CreateFrame("Frame", "$parentPanelContainer", frame, DBM:IsAlpha() and "BackdropTemplate")
frameContainer:SetPoint("TOPLEFT", frameList:GetName(), "TOPRIGHT", 16, 0)
frameContainer:SetPoint("BOTTOMLEFT", frameList:GetName(), "BOTTOMRIGHT", 16, 1)
frameContainer:SetPoint("RIGHT", -22, 0)
frameContainer:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
frameContainer.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 16,
	insets		= { left = 5, right = 5, top = 5, bottom = 5 }
}
if DBM:IsAlpha() then
	frameContainer:ApplyBackdrop()
else
	frameContainer:SetBackdrop(frameContainer.backdropInfo)
end

local frameContainerHeaderText = frameContainer:CreateFontString("$parentHeaderText", "BACKGROUND", "GameFontHighlightSmall")
frameContainerHeaderText:SetPoint("BOTTOMLEFT", frame:GetName(), "TOPLEFT", 10, 1);

local frameContainerFOV = CreateFrame("ScrollFrame", "$parentFOV", frameContainer)
frameContainerFOV:SetPoint("TOPLEFT", frameContainer:GetName(), "TOPLEFT", 5, -5)
frameContainerFOV:SetPoint("BOTTOMRIGHT", frameContainer:GetName(), "BOTTOMRIGHT", -20, 7)
frameContainerFOV:SetScript("OnMouseWheel", function(self, delta)
	local scrollBar = _G[self:GetName() .. "ScrollBar"]
	if delta > 0 then
		scrollBar:SetValue(scrollBar:GetValue() - (scrollBar:GetHeight() / 2))
	else
		scrollBar:SetValue(scrollBar:GetValue() + (scrollBar:GetHeight() / 2))
	end
end)

-- TODO: Deprecate XML usage inheritance
local frameContainerFOVScrollBar = CreateFrame("Slider", "$parentScrollBar", frameContainerFOV, "DBM_GUI_PanelScrollBarTemplate")
frameContainerFOVScrollBar:SetPoint("TOPRIGHT", 15, -15)
frameContainerFOVScrollBar:SetPoint("BOTTOMRIGHT", 15, 13)
