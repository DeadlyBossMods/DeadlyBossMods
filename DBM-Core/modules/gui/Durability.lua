---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMDurability
local Durability = {}
DBM.Durability = Durability

local tinsert, tsort, mmax = table.insert, table.sort, math.max

local L = DBM_CORE_L

local LibStub = _G["LibStub"]
local LibDurability
if LibStub then
	LibDurability = LibStub("LibDurability", true)
end

if not LibDurability then
	DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
	return
end

local frame = CreateFrame("Frame", nil, UIParent, "DefaultPanelTemplate") --[[@as DefaultPanelTemplate]]
frame:Hide()
frame:SetSize(380, 300)
frame:SetPoint("RIGHT", -150, 0)
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetTitle(L.DUR_HEADER)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

frame.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
frame.Bg:SetColorTexture(0, 0, 0, 0.8)

CreateFrame("Button", nil, frame, "UIPanelCloseButtonDefaultAnchors")

local scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 5)

local child = CreateFrame("Frame", nil, scroll)
scroll:SetScrollChild(child)
child:SetSize(scroll:GetWidth(), scroll:GetHeight())
child:SetPoint("LEFT")

local refresh = CreateFrame("Button", nil, child)
refresh:SetSize(20, 20)
refresh:SetPoint("BOTTOMLEFT", child)
refresh:SetText("REFRESH")
refresh:Show()
refresh:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton-Down")
refresh:SetHighlightTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetScript("OnClick", function()
	LibDurability:RequestDurability()
end)

-- Frames handler
local spareTextFrames, usedTextFrames = {}, {}
local function WipeTextFrames()
	for _frame in next, usedTextFrames do
		if not _frame.Keep then
			_frame:Hide()
			_frame:SetText("")
			_frame:SetFontObject(GameFontNormal)
			_frame:ClearAllPoints()
			spareTextFrames[#spareTextFrames + 1] = _frame
		end
	end
end
local function GetTextFrame()
	---@class DBMDurabilityTextFrame: FontString
	---@field Keep boolean?
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame:Show()
		return _frame
	end
	---@class DBMDurabilityTextFrame
	_frame = child:CreateFontString(nil, nil, "GameFontNormal")
	_frame:SetJustifyH("LEFT")
	usedTextFrames[_frame] = true
	return _frame
end

local titlePlayer = GetTextFrame()
titlePlayer.Keep = true
titlePlayer:SetFontObject(GameFontNormalLarge)
titlePlayer:SetText(PLAYER)
titlePlayer:SetPoint("TOPLEFT", child, 7, 0)
titlePlayer:SetWidth(200)

local titlePercent = GetTextFrame()
titlePercent.Keep = true
titlePercent:SetFontObject(GameFontNormalLarge)
titlePercent:SetText("%")
titlePercent:SetPoint("LEFT", titlePlayer, "RIGHT", 0, 0)

local titleBroken = GetTextFrame()
titleBroken.Keep = true
titleBroken:SetFontObject(GameFontNormalLarge)
titleBroken:SetText(TUTORIAL_TITLE37)
titleBroken:SetPoint("LEFT", titlePercent, "RIGHT")

local percentWidth, brokenWidth = mmax(75, titlePercent:GetStringWidth() + 10), mmax(75, titleBroken:GetStringWidth() + 10)
titlePercent:SetWidth(percentWidth)
titleBroken:SetWidth(brokenWidth)

-- Update main frame width
frame:SetWidth(200 + percentWidth + brokenWidth + 40)
child:SetWidth(200 + percentWidth + brokenWidth + 8)

local function SortDurability(v1, v2)
	return (v1.durpercent or 9999) < (v2.durpercent or 9999)
end

local function Update()
	local sortDur = {}
	for _, v in pairs(DBM:GetRaidRoster()) do
		tinsert(sortDur, v)
	end
	tsort(sortDur, SortDurability)

	WipeTextFrames()

	for i, v in ipairs(sortDur) do
		local name = v.name
		local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textPercent, textBroken = GetTextFrame(), GetTextFrame(), GetTextFrame()

		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(200)

		textPercent:SetText(v.durpercent or '?')
		textPercent:SetPoint("TOP", titlePercent, "BOTTOM", 0, offset)
		textPercent:SetWidth(percentWidth)

		textBroken:SetText(v.durbroken or '?')
		textBroken:SetPoint("TOP", titleBroken, "BOTTOM", 0, offset)
		textBroken:SetWidth(brokenWidth)
	end

	child:SetHeight(mmax(child:GetHeight(), 20 + #sortDur * 20))
end

LibDurability:Register("DBM", function(percent, broken, sender)
	if not sender then
		return
	end
	local player = DBM:GetRaidRoster()[sender]
	if player then
		player.durpercent = math.floor(percent)
		player.durbroken = broken
	end

	Update()
end)

function Durability:Show()
	DBM.Latency:Hide()
	LibDurability:RequestDurability()
	if _G["DBM_GUI_OptionsFrame"] then
		frame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	frame:Show()
end

function Durability:Hide()
	frame:Hide()
end
