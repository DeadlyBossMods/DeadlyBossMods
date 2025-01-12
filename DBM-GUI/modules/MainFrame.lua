local L		= DBM_GUI_L
local CL	= DBM_CORE_L

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

---@class DBMGUI
local DBM_GUI = DBM_GUI

local DBM = DBM
local CreateFrame = CreateFrame
local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded or IsAddOnLoaded
local frame = _G["DBM_GUI_OptionsFrame"]
table.insert(_G["UISpecialFrames"], frame:GetName())
frame:SetFrameStrata("DIALOG")
frame:ClearAllPoints()
if DBM.Options.GUIPoint then
	frame:SetPoint(DBM.Options.GUIPoint, UIParent, DBM.Options.GUIPoint, DBM.Options.GUIX, DBM.Options.GUIY)
else
	frame:SetPoint("CENTER")
end
if DBM.Options.GUIWidth then
	frame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
else
	frame:SetSize(850, 600)
end
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetResizable(true)
frame:SetClampedToScreen(true)
frame:SetUserPlaced(true)
frame:RegisterForDrag("LeftButton")
frame:SetFrameLevel(frame:GetFrameLevel() + 4)
frame:SetResizeBounds(800, 400, UIParent:GetWidth(), UIParent:GetHeight())
frame:Hide()
NineSliceUtil.ApplyLayoutByName(frame, "ButtonFrameTemplateNoPortrait");
frame.firstshow = true
frame:SetScript("OnShow", function(self)
	if self.firstshow then
		self.firstshow = false
		self:ShowTab(1)
	end
	if DBM_GUI.currentViewing then
		self:DisplayFrame(DBM_GUI.currentViewing)
	end
end)
frame:SetScript("OnHide", function()
	if _G["DBM_GUI_DropDown"] then
		_G["DBM_GUI_DropDown"]:Hide()
	end
end)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.GUIPoint = point
	DBM.Options.GUIX = x
	DBM.Options.GUIY = y
end)
frame:SetScript("OnSizeChanged", function(self)
	self:UpdateMenuFrame()
	if DBM_GUI.currentViewing then
		self:DisplayFrame(DBM_GUI.currentViewing, false)
	end
end)
frame.tabs = {}

if not isRetail then
	CreateFrame("Button", "$parentClosePanelButton", frame, "UIPanelCloseButtonDefaultAnchors")
	local titleBg = frame:CreateTexture("$parentTitleBga", "BACKGROUND", "_UI-Frame-TitleTileBg")
	titleBg:ClearAllPoints()
	titleBg:SetPoint("TOPLEFT", 8, -3)
	titleBg:SetPoint("TOPRIGHT", -24, -3)
end

local frameBg = frame:CreateTexture("$parentBg", "BACKGROUND")
frameBg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
frameBg:SetColorTexture(0, 0, 0, 0.8)
frameBg:SetPoint("TOPLEFT", 5, -21)
frameBg:SetPoint("BOTTOMRIGHT", -2, isRetail and 2 or 8)

local frameResize = CreateFrame("Button", nil, frame)
frameResize:SetSize(16, 16)
frameResize:EnableMouse(true)
frameResize:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 1, 1)
frameResize:SetScript("OnMouseDown", function()
	frame:StartSizing("BOTTOMRIGHT")
end)
frameResize:SetScript("OnMouseUp", function()
	frame:StopMovingOrSizing()
	DBM.Options.GUIWidth = frame:GetWidth()
	DBM.Options.GUIHeight = frame:GetHeight()
end)
local resizeNormal = frameResize:CreateTexture(nil, "OVERLAY")
resizeNormal:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeNormal:SetTexCoord(0, 1, 0, 1)
resizeNormal:SetPoint("BOTTOMLEFT", frameResize, 0, 1)
resizeNormal:SetPoint("TOPRIGHT", frameResize, -1, 0)
frameResize:SetNormalTexture(resizeNormal)
local resizePushed = frameResize:CreateTexture(nil, "OVERLAY")
resizePushed:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
resizePushed:SetTexCoord(0, 1, 0, 1)
resizePushed:SetPoint("BOTTOMLEFT", frameResize, 0, 1)
resizePushed:SetPoint("TOPRIGHT", frameResize, -1, 0)
frameResize:SetPushedTexture(resizePushed)
local resizeHighlight = frameResize:CreateTexture(nil, "OVERLAY")
resizeHighlight:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeHighlight:SetTexCoord(0, 1, 0, 1)
resizeHighlight:SetPoint("BOTTOMLEFT", frameResize, 0, 1)
resizeHighlight:SetPoint("TOPRIGHT", frameResize, -1, 0)
frameResize:SetHighlightTexture(resizeHighlight)

local frameHeader = CreateFrame("Frame", nil, frame)
frameHeader:SetSize(0, 20)
frameHeader:SetPoint("TOPLEFT", 8, -1)
frameHeader:SetPoint("TOPRIGHT", -24, -1)

local frameHeaderText = frameHeader:CreateFontString("$parentHeaderText", "ARTWORK", "GameFontNormal")
frameHeaderText:SetPoint("TOP", frameHeader, 0, -5)
frameHeaderText:SetPoint("LEFT")
frameHeaderText:SetPoint("RIGHT")
if DBM.NewerVersion then
	frameHeaderText:SetText(CL.DEADLY_BOSS_MODS.. " - " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. "). |cffff0000Version " .. DBM.NewerVersion .. " is available.|r")
else
	frameHeaderText:SetText(CL.DEADLY_BOSS_MODS.. " - " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. ")")
end

---@class DBMMainFrameOkButton: Button
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
frameWebsiteButton:SetPoint("BOTTOMRIGHT", frameOkay, "BOTTOMLEFT", -20, 0)
frameWebsiteButton:SetText(L.WebsiteButton)
frameWebsiteButton:SetScript("OnClick", function()
	DBM:ShowUpdateReminder(nil, nil, CL.COPY_URL_DIALOG)
end)

local frameWebsite = frame:CreateFontString("$parentWebsite", "ARTWORK", "GameFontNormal")
frameWebsite:SetPoint("BOTTOMLEFT", 15, 14)
frameWebsite:SetPoint("RIGHT", frameWebsiteButton, "LEFT")
frameWebsite:SetJustifyH("LEFT")
frameWebsite:SetText(L.Website)

local frameWebsiteButtonA = CreateFrame("Frame", nil, frame)
frameWebsiteButtonA:SetAllPoints(frameWebsite)
frameWebsiteButtonA:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, CL.COPY_URL_DIALOG, "https://discord.gg/deadlybossmods")
end)

---@class DBM_GUI_OptionsFrameDBMOptions: Frame
local DBMOptions = CreateFrame("Frame", "$parentDBMOptions", frame)
DBMOptions.name = L.OTabOptions
frame:CreateTab(DBMOptions)

---@class DBM_GUI_OptionsFrameRaidOptions: Frame
local raidOptions = CreateFrame("Frame", "$parentRaidOptions", frame)
raidOptions.name = L.OTabRaids
frame:CreateTab(raidOptions)

---@class DBM_GUI_OptionsFrameDungeonOptions: Frame
local dungeonOptions = CreateFrame("Frame", "$parentDungeonOptions", frame)
dungeonOptions.name = L.OTabDungeons
frame:CreateTab(dungeonOptions)

---@class DBM_GUI_OptionsFrameWorldBossOptions: Frame
local worldBossOptions = CreateFrame("Frame", "$parentWorldBossOptions", frame)
worldBossOptions.name = L.OTabWorld
frame:CreateTab(worldBossOptions)

---@class DBM_GUI_OptionsFrameOtherOptions: Frame
local otherTab = CreateFrame("Frame", "$parentOtherOptions", frame)
otherTab.name = L.OTabPlugins
frame:CreateTab(otherTab)

---@class DBMGUIFrameWrapper: Frame, BackdropTemplate
local frameWrapper = CreateFrame("Frame", nil, frame, "BackdropTemplate")
frameWrapper:SetPoint("TOPLEFT", 15, -59)
frameWrapper:SetPoint("BOTTOMRIGHT", -15, 40)
frameWrapper.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	edgeSize	= 16,
	tileEdge	= true
}
frameWrapper:ApplyBackdrop()
frameWrapper:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

local hack = OptionsList_OnLoad
function OptionsList_OnLoad(self, ...)
	if self:GetName() ~= frame:GetName() .. "List" then
		hack(self, ...)
	end
end
---@class DBMFrameList: ScrollFrame, BackdropTemplate
local frameList = CreateFrame("ScrollFrame", "$parentList", frameWrapper, "UIPanelScrollFrameTemplate")
frameList:SetScript("OnVerticalScroll", function(self, offset)
	local scrollbar = _G[self:GetName() .. "ScrollBar"]
	local _, max = scrollbar:GetMinMaxValues()
	scrollbar:SetValue(offset)
	_G[self:GetName() .. "ScrollBarScrollUpButton"]:SetEnabled(offset ~= 0)
	_G[self:GetName() .. "ScrollBarScrollDownButton"]:SetEnabled(scrollbar:GetValue() - max ~= 0)
	frameList.offset = math.floor((offset / 18) + 0.5)
	frame:UpdateMenuFrame()
end)
frameList:SetWidth(205)
frameList:SetPoint("TOPLEFT", 2, -2)
frameList:SetPoint("BOTTOMLEFT", 2, 2)
frameList:SetScript("OnShow", function()
	frame:UpdateMenuFrame()
end)
frameList.offset = 0
frameList.buttons = {}

function frame:LoadAndShowFrame(subFrame)
	self:ClearSelection()
	self.tabs[self.tab].selection = subFrame
	if not subFrame.isLoaded then
		if subFrame.isSeason then
			---@diagnostic disable-next-line: deprecated
			if not IsAddOnLoaded(subFrame.addonId) then
				for _, addon in ipairs(DBM.AddOns) do
					if addon.modId == subFrame.addonId then
						DBM:LoadMod(addon, true)
						break
					end
				end
			end
			subFrame.isLoaded = true
		end
		if subFrame.tab ~= 1 then
			for _, mod in ipairs(DBM.Mods) do
				if mod.id == subFrame.modId then
					DBM_GUI:CreateBossModPanel(mod, subFrame.isTest)
					subFrame.isLoaded = true
					break
				end
			end
		end
	end
	if subFrame.selectButton then
		subFrame.selectButton:LockHighlight()
	end
	frame:DisplayFrame(subFrame)
end

for i = 1, math.floor(UIParent:GetHeight() / 18) do
	---@class DBMListFrameButton: Button
	---@field element table
	local button = CreateFrame("Button", "$parentButton" .. i, frameList)
	button:SetSize(220, 18)
	button.text = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
	button:RegisterForClicks("LeftButtonUp")
	button:SetScript("OnClick", function(self)
		frame:LoadAndShowFrame(self.element)
	end)
	if i == 1 then
		button:SetPoint("TOPLEFT", frameList, 0, -8)
	else
		button:SetPoint("TOPLEFT", frameList.buttons[i - 1], "BOTTOMLEFT")
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
	buttonToggle:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -1)
	buttonToggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	buttonToggle:SetScript("OnClick", function()
		if not button.element.isLoaded and button.element.addonId then
			---@diagnostic disable-next-line: deprecated
			if not IsAddOnLoaded(button.element.addonId) then
				for _, addon in ipairs(DBM.AddOns) do
					if addon.modId == button.element.addonId then
						DBM:LoadMod(addon, true)
					end
				end
			end
			button.element.isLoaded = true
		end
		button.element.showSub = not button.element.showSub
		frame:UpdateMenuFrame()
	end)
end
local frameListScrollBar = _G[frameList:GetName() .. "ScrollBar"]
frameListScrollBar:ClearAllPoints()
frameListScrollBar:SetPoint("TOPLEFT", frameList, "TOPRIGHT", 6, -20)
frameListScrollBar:SetPoint("BOTTOMLEFT", frameList, "BOTTOMRIGHT", 6, 18)
frameListScrollBar:SetMinMaxValues(0, 11)
frameListScrollBar:SetValueStep(18)
frameListScrollBar:SetValue(0)
frameList:SetScript("OnMouseWheel", function(_, delta)
	frameListScrollBar:SetValue(frameListScrollBar:GetValue() - (delta * 18))
end)
local scrollUpButton = _G[frameListScrollBar:GetName() .. "ScrollUpButton"]
scrollUpButton:Disable()
scrollUpButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() - 18)
end)
local scrollDownButton = _G[frameListScrollBar:GetName() .. "ScrollDownButton"]
scrollDownButton:Enable()
scrollDownButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() + 18)
end)

local frameBreak = frameWrapper:CreateTexture()
frameBreak:SetPoint("TOPLEFT", frameList, "TOPRIGHT", 12, -1)
frameBreak:SetPoint("BOTTOMLEFT", frameList, "BOTTOMRIGHT", 12, 1)
frameBreak:SetWidth(16)
frameBreak:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border", "REPEAT", "REPEAT") -- 137057
local edgeRepeatY = math.max(0, (frameBreak:GetHeight() / 16) * frameBreak:GetEffectiveScale() - 2 - 0.0625);
frameBreak:SetTexCoord(0.1328125, 0.0625,
	0.1328125, edgeRepeatY,
	0.2421875, 0.0625,
	0.2421875, edgeRepeatY);
frameBreak:SetVertexColor(0.6, 0.6, 0.6, 1)

---@class DBMPanelContainer: ScrollFrame, BackdropTemplate
local frameContainer = CreateFrame("ScrollFrame", "$parentPanelContainer", frameWrapper, "BackdropTemplate")
frameContainer:SetPoint("TOPLEFT", frameList, "TOPRIGHT", 24, 0)
frameContainer:SetPoint("BOTTOMRIGHT", frameWrapper, "BOTTOMRIGHT", 0, 2)

local frameContainerFOV = CreateFrame("ScrollFrame", "$parentFOV", frameContainer, "FauxScrollFrameTemplate")
frameContainerFOV:Hide()
frameContainerFOV:SetPoint("TOPLEFT", frameContainer, "TOPLEFT", 0, -5)
frameContainerFOV:SetPoint("BOTTOMRIGHT", frameContainer, "BOTTOMRIGHT", 0, 5)

_G[frameContainerFOV:GetName() .. "ScrollBarScrollUpButton"]:Disable()
_G[frameContainerFOV:GetName() .. "ScrollBarScrollDownButton"]:Enable()

local frameContainerScrollBar = _G[frameContainerFOV:GetName() .. "ScrollBar"]
frameContainerScrollBar:ClearAllPoints()
frameContainerScrollBar:SetPoint("TOPRIGHT", -4, -15)
frameContainerScrollBar:SetPoint("BOTTOMRIGHT", 0, 15)

---@class DBMPanelContainerScrollbarBackdrop: Frame, BackdropTemplate
local frameContainerScrollBarBackdrop = CreateFrame("Frame", nil, frameContainerScrollBar, "BackdropTemplate")
frameContainerScrollBarBackdrop:SetPoint("TOPLEFT", -4, 20)
frameContainerScrollBarBackdrop:SetPoint("BOTTOMRIGHT", 4, -20)
frameContainerScrollBarBackdrop.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 16,
	insets		= { left = 0, right = 0, top = 5, bottom = 5 }
}
frameContainerScrollBarBackdrop:ApplyBackdrop()
frameContainerScrollBarBackdrop:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)
