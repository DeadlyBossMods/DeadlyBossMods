---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMLatency
local Latency = {}
DBM.Latency = Latency

local tinsert, tsort, mmax = table.insert, table.sort, math.max

local L = DBM_CORE_L

local LibStub = _G["LibStub"]
local LibLatency
if LibStub then
	LibLatency = LibStub("LibLatency", true)
end

if not LibLatency then
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
frame:SetTitle(L.LAG_HEADER)
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
	LibLatency:RequestLatency()
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
	---@class DBMLatencyTextFrame: FontString
	---@field Keep boolean?
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame:Show()
		return _frame
	end
	---@class DBMLatencyTextFrame
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

local titleWorld = GetTextFrame()
titleWorld.Keep = true
titleWorld:SetFontObject(GameFontNormalLarge)
titleWorld:SetText(WORLD)
titleWorld:SetPoint("LEFT", titlePlayer, "RIGHT", 0, 0)
titleWorld:SetWidth(75)

local titleHome = GetTextFrame()
titleHome.Keep = true
titleHome:SetFontObject(GameFontNormalLarge)
titleHome:SetText(HOME)
titleHome:SetPoint("LEFT", titleWorld, "RIGHT")
titleHome:SetWidth(75)

local worldWidth, homeWidth = mmax(75, titleWorld:GetStringWidth() + 10), mmax(75, titleHome:GetStringWidth() + 10)
titleWorld:SetWidth(worldWidth)
titleHome:SetWidth(homeWidth)

-- Update main frame width
frame:SetWidth(200 + worldWidth + homeWidth + 40)
child:SetWidth(200 + worldWidth + homeWidth + 8)

local function SortLag(v1, v2)
	return (v1.worldlag or 9999) < (v2.worldlag or 9999)
end

local function Update()
	local sortLag = {}
	for _, v in pairs(DBM:GetRaidRoster()) do
		tinsert(sortLag, v)
	end
	tsort(sortLag, SortLag)

	WipeTextFrames()

	for i, v in ipairs(sortLag) do
		local name = v.name
		local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textWorld, textHome = GetTextFrame(), GetTextFrame(), GetTextFrame()

		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(200)

		textWorld:SetText(v.worldlag or '?')
		textWorld:SetPoint("TOP", titleWorld, "BOTTOM", 0, offset)
		textWorld:SetWidth(worldWidth)

		textHome:SetText(v.homelag or '?')
		textHome:SetPoint("TOP", titleHome, "BOTTOM", 0, offset)
		textHome:SetWidth(homeWidth)
	end

	child:SetHeight(mmax(child:GetHeight(), 20 + #sortLag * 20))
end

LibLatency:Register("DBM", function(homelag, worldlag, sender)
	if not sender then
		return
	end
	local player = DBM:GetRaidRoster()[sender]
	if player then
		player.homelag = homelag
		player.worldlag = worldlag
	end

	Update()
end)

function Latency:Show()
	DBM.Durability:Hide()
	LibLatency:RequestLatency()
	if _G["DBM_GUI_OptionsFrame"] then
		frame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	frame:Show()
end

function Latency:Hide()
	frame:Hide()
end
