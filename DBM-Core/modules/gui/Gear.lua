---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMGearCheck
local GearCheck = {}
DBM.GearCheck = GearCheck

local tinsert, tremove, tsort, mmax, mfloor = table.insert, table.remove, table.sort, math.max, math.floor

local L = DBM_CORE_L
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

---@class DBMGearFrame: DefaultPanelTemplate
local frame = CreateFrame("Frame", "DBMGearFrame", UIParent, "DefaultPanelTemplate") --[[@as DefaultPanelTemplate]]
tinsert(_G["UISpecialFrames"], frame:GetName())
frame:Hide()
frame:SetSize(330, 300)
frame:SetClampedToScreen(true)
frame:SetPoint("LEFT")
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetTitle(L.GEAR_HEADER or (L.DBM .. " - Gear Results"))
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.GearPosition = {point, x, y}
end)

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

local spareTextFrames, usedTextFrames = {}, {}
local pendingInspects = {}
local activeInspect = {}
local inspectToken = 0
local inspectUpdateElapsed = 0
local pendingRosterRefresh = false
local sortGear = {}
local validAnchorPoints = {
	TOP = true,
	BOTTOM = true,
	LEFT = true,
	RIGHT = true,
	CENTER = true,
	TOPLEFT = true,
	TOPRIGHT = true,
	BOTTOMLEFT = true,
	BOTTOMRIGHT = true
}

local function WipeTextFrames()
	for _frame in next, usedTextFrames do
		if not _frame.Keep and not _frame.IsSpare then
			_frame.IsSpare = true
			_frame:Hide()
			_frame:SetText("")
			_frame:SetFontObject(GameFontNormal)
			_frame:ClearAllPoints()
			spareTextFrames[#spareTextFrames + 1] = _frame
		end
	end
end

local function GetTextFrame()
	---@class DBMGearTextFrame: FontString
	---@field Keep boolean?
	---@field IsSpare boolean
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame.IsSpare = false
		_frame:Show()
		return _frame
	end
	---@class DBMGearTextFrame
	_frame = child:CreateFontString(nil, nil, "GameFontNormal")
	_frame.IsSpare = false
	_frame:SetJustifyH("LEFT")
	usedTextFrames[_frame] = true
	return _frame
end

local titlePlayer = GetTextFrame()
titlePlayer.Keep = true
titlePlayer:SetFontObject(GameFontNormalLarge)
titlePlayer:SetText(PLAYER)
titlePlayer:SetPoint("TOPLEFT", child, 7, 0)
titlePlayer:SetWidth(220)

local titleItemLevel = GetTextFrame()
titleItemLevel.Keep = true
titleItemLevel:SetFontObject(GameFontNormalLarge)
titleItemLevel:SetText(_G["ITEM_LEVEL_ABBR"] or _G["ITEM_LEVEL"] or "iLvl")
titleItemLevel:SetPoint("LEFT", titlePlayer, "RIGHT", 0, 0)

local itemLevelWidth = mmax(75, titleItemLevel:GetStringWidth() + 20)
titleItemLevel:SetWidth(itemLevelWidth)

child:SetWidth(220 + itemLevelWidth + 8)
frame:SetWidth(child:GetWidth() + 32)

local function SetPlayerGearState(name, itemLevel, pending, unavailable)
	local player = DBM:GetRaidRoster()[name]
	if not player then
		return
	end
	player.gearilvl = itemLevel
	player.gearpending = pending or false
	player.gearunavailable = unavailable or false
end

local function RoundItemLevel(itemLevel)
	if type(itemLevel) ~= "number" then
		return
	end
	return mfloor((itemLevel * 10) + 0.5) / 10
end

local function GetGearText(player)
	if type(player.gearilvl) == "number" then
		return ("%.1f"):format(player.gearilvl)
	end
	if player.gearpending then
		return "..."
	end
	if player.gearunavailable then
		return "?"
	end
	return "-"
end

local function SortGear(v1, v2)
	local v1State = type(v1.gearilvl) == "number" and 3 or v1.gearpending and 2 or v1.gearunavailable and 1 or 0
	local v2State = type(v2.gearilvl) == "number" and 3 or v2.gearpending and 2 or v2.gearunavailable and 1 or 0
	if v1State ~= v2State then
		return v1State > v2State
	end
	if v1.gearilvl ~= v2.gearilvl then
		return (v1.gearilvl or -1) > (v2.gearilvl or -1)
	end
	return v1.name < v2.name
end

local function Update()
	wipe(sortGear)
	for _, v in pairs(DBM:GetRaidRoster()) do
		tinsert(sortGear, v)
	end
	tsort(sortGear, SortGear)

	WipeTextFrames()

	for i, v in ipairs(sortGear) do
		local name = v.name
		local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textItemLevel = GetTextFrame(), GetTextFrame()

		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(220)

		textItemLevel:SetText(GetGearText(v))
		textItemLevel:SetPoint("TOP", titleItemLevel, "BOTTOM", 0, offset)
		textItemLevel:SetWidth(itemLevelWidth)
	end

	child:SetHeight(mmax(300, 50 + #sortGear * 14))
end

local function ClearInspectQueue()
	inspectToken = inspectToken + 1
	wipe(pendingInspects)
	wipe(activeInspect)
end

local function FinishInspect(token, itemLevel)
	if not activeInspect.name then
		return
	end
	if activeInspect.token ~= token then
		wipe(activeInspect)
		ClearInspectPlayer()
		if pendingRosterRefresh and frame:IsShown() then
			pendingRosterRefresh = false
			GearCheck:Refresh()
		end
		return
	end
	SetPlayerGearState(activeInspect.name, itemLevel, false, type(itemLevel) ~= "number")
	wipe(activeInspect)
	ClearInspectPlayer()
	Update()
	if pendingRosterRefresh and frame:IsShown() then
		pendingRosterRefresh = false
		GearCheck:Refresh()
		return
	end
	if frame:IsShown() and #pendingInspects > 0 then
		C_Timer.After(0.1, function()
			if frame:IsShown() and not activeInspect.name then
				GearCheck:RequestNextInspect()
			end
		end)
	end
end

function GearCheck:RequestNextInspect()
	if not frame:IsShown() or activeInspect.name then
		return
	end
	if InCombatLockdown() or UnitAffectingCombat("player") or (InspectFrame and InspectFrame:IsShown()) then
		return
	end
	while #pendingInspects > 0 do
		local name = tremove(pendingInspects, 1)
		local unit = DBM:GetRaidUnitId(name, true)
		if unit and not DBM:issecretunit(unit) and UnitExists(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit, "player") and CheckInteractDistance(unit, 1) and CanInspect(unit) then
			local guid = UnitGUID(unit)
			if guid then
				activeInspect.name = name
				activeInspect.guid = guid
				activeInspect.token = inspectToken
				NotifyInspect(unit)
				local token = inspectToken
				C_Timer.After(2, function()
					if activeInspect.name == name and activeInspect.guid == guid and activeInspect.token == token then
						FinishInspect(token)
					end
				end)
				return
			end
		end
		SetPlayerGearState(name, nil, false, true)
	end
	Update()
end

local function SeedRaid()
	local playerName = DBM:GetUnitFullName("player")
	for name in pairs(DBM:GetRaidRoster()) do
		if name == playerName then
			SetPlayerGearState(name, GearCheck:ScanGear("player"), false, false)
		else
			local unit = DBM:GetRaidUnitId(name, true)
			if unit and DBM:issecretunit(unit) then
				SetPlayerGearState(name, nil, false, true)
			else
				SetPlayerGearState(name, nil, true, false)
				tinsert(pendingInspects, name)
			end
		end
	end
end

function GearCheck:Refresh()
	ClearInspectQueue()
	SeedRaid()
	Update()
	self:RequestNextInspect()
end

refresh:SetScript("OnClick", function()
	GearCheck:Refresh()
end)

local function OnEvent(_, event, arg1)
	if event == "GROUP_ROSTER_UPDATE" then
		if frame:IsShown() then
			if activeInspect.name then
				pendingRosterRefresh = true
			else
				GearCheck:Refresh()
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if frame:IsShown() and #pendingInspects > 0 and not activeInspect.name then
			GearCheck:RequestNextInspect()
		end
	elseif event == "INSPECT_READY" then
		if type(arg1) == "string" and arg1 == activeInspect.guid then
			local unit = DBM:GetRaidUnitId(activeInspect.name, true)
			local itemLevel
			if unit and not DBM:issecretunit(unit) and UnitExists(unit) and UnitGUID(unit) == arg1 then
				itemLevel = GearCheck:ScanGear(unit)
			end
			FinishInspect(activeInspect.token, itemLevel)
		end
	end
end

local function OnUpdate(_, elapsed)
	inspectUpdateElapsed = inspectUpdateElapsed + elapsed
	if inspectUpdateElapsed < 0.5 then
		return
	end
	inspectUpdateElapsed = 0
	if frame:IsShown() and #pendingInspects > 0 and not activeInspect.name then
		GearCheck:RequestNextInspect()
	end
end

frame:SetScript("OnHide", function()
	frame:UnregisterEvent("GROUP_ROSTER_UPDATE")
	frame:UnregisterEvent("INSPECT_READY")
	frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
	frame:SetScript("OnEvent", nil)
	frame:SetScript("OnUpdate", nil)
	pendingRosterRefresh = false
	inspectUpdateElapsed = 0
	ClearInspectQueue()
	ClearInspectPlayer()
end)

--SUPER generic ilvl check for now.
--Will be expanded in future with socket and enchant checks and cooperation with other addons via libraries.
function GearCheck:ScanGear(unit)
	if not unit then
		return
	end
	if DBM:issecretunit(unit) then
		return
	end
	local averageItemLevel
	if UnitIsUnit(unit, "player") then
		local _, equipped = GetAverageItemLevel()
		averageItemLevel = RoundItemLevel(equipped)
	else
		if not (C_PaperDollInfo and C_PaperDollInfo.GetInspectItemLevel) then
			return
		end
		averageItemLevel = C_PaperDollInfo.GetInspectItemLevel(unit)
		averageItemLevel = RoundItemLevel(averageItemLevel)
	end
	return averageItemLevel
end

function GearCheck:Show()
	if DBM.Keystones then
		DBM.Keystones:Hide()
	end
	DBM.Durability:Hide()
	DBM.Latency:Hide()
	if _G["DBM_GUI_OptionsFrame"] then
		frame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	frame:ClearAllPoints()
	local position = DBM.Options.GearPosition
	if type(position) ~= "table" or not validAnchorPoints[position[1]] or type(position[2]) ~= "number" or type(position[3]) ~= "number" then
		position = {"RIGHT", -150, 0}
	end
	frame:SetPoint(position[1], position[2], position[3])
	frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	frame:RegisterEvent("INSPECT_READY")
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:SetScript("OnEvent", OnEvent)
	frame:SetScript("OnUpdate", OnUpdate)
	frame:Show()
	self:Refresh()
end

function GearCheck:Hide()
	frame:Hide()
end
