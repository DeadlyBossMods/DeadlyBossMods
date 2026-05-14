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

---@class DBMGearCheckFrame: DefaultPanelTemplate
local frame = CreateFrame("Frame", "DBMGearCheckFrame", UIParent, "DefaultPanelTemplate") --[[@as DefaultPanelTemplate]]
tinsert(_G["UISpecialFrames"], frame:GetName())
frame:Hide()
frame:SetSize(380, 300)
frame:SetClampedToScreen(true)
frame:SetPoint("LEFT")
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetTitle(L.GEAR_HEADER)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.GearPosition = {point, x, y}
end)

frame.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
frame.Bg:SetColorTexture(0, 0, 0, 0.8)

CreateFrame("Button", nil, frame, "UIPanelCloseButtonDefaultAnchors")

local spareTextFrames, usedTextFrames = {}, {}
local pendingInspects = {}
local pendingCommReplies = {}
local guildGearData = {}
local inspectRetryCounts = {}
local inspectRetryDeadlines = {}
local knownRosterMembers = {}
local activeInspect = {}
local inspectToken = 0
local commRequestToken = 0
local guildSyncToken = 0
local guildGearQuerySent = false
local guildUpdatePending = false
local inspectUpdateElapsed = 0
local pendingRosterRefresh = false
local sortGear = {}
local commReplyTimeoutSeconds = 3
local inspectTimeoutSeconds = 4
local inspectMaxRetries = 6
local guildGearQuerySpamSeconds = 60
local maxReasonableItemLevel = 10000
local guildUpdateDebounceSeconds = 0.2
local inspectRetryWindowSeconds = 30
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

local tabs, tabsBtn, selectedTab = {}, {}, 1

local WipeTextFrames, Refresh, SendGuildGearSyncRequest, ShouldUseCommScan, RequestNextInspect, HandleRosterUpdate, ScanGear

function frame:CreateTab(title, OnShowFn)
	local i = #tabs + 1
	tabs[i] = OnShowFn
	---@class DBMGearTabButton: Button
	---@field Text FontString
	local _tab = CreateFrame("Button", nil, frame, "PanelTabButtonTemplate")
	tabsBtn[i] = _tab
	PanelTemplates_SetNumTabs(self, i)
	if i == 1 then
		_tab:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 11, 2)
	else
		_tab:SetPoint("TOPLEFT", tabsBtn[i - 1], "TOPRIGHT", 1, 0)
	end
	_tab.Text:SetText(title)
	_tab:SetScript("OnClick", function()
		self:ShowTab(i)
	end)
end

function frame:ShowTab(tab)
	PanelTemplates_SetTab(self, tab)
	WipeTextFrames()
	selectedTab = tab
	tabs[tab]()
end

local scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -50)
scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 30)

local child = CreateFrame("Frame", nil, scroll)
scroll:SetScrollChild(child)
child:SetSize(scroll:GetWidth(), scroll:GetHeight())
child:SetPoint("LEFT")

local refresh = CreateFrame("Button", nil, frame)
refresh:SetSize(20, 20)
refresh:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 8, 6)
refresh:SetText("REFRESH")
refresh:Show()
refresh:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton-Down")
refresh:SetHighlightTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetScript("OnClick", function()
	if selectedTab == 1 then
		Refresh()
	elseif selectedTab == 2 then
		if ShouldUseCommScan() and IsInGuild() then
			SendGuildGearSyncRequest()
		end
	end
end)

function WipeTextFrames()
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
local playerWidth = 120
titlePlayer:SetWidth(playerWidth)

local titleItemLevel = GetTextFrame()
titleItemLevel.Keep = true
titleItemLevel:SetFontObject(GameFontNormalLarge)
titleItemLevel:SetText(_G["ITEM_LEVEL_ABBR"] or "iLvl")
titleItemLevel:SetPoint("LEFT", titlePlayer, "RIGHT", 0, 0)

local itemLevelWidth = mmax(75, titleItemLevel:GetStringWidth() + 20)
titleItemLevel:SetWidth(itemLevelWidth)

local titleMissingGems = GetTextFrame()
titleMissingGems.Keep = true
titleMissingGems:SetFontObject(GameFontNormalLarge)
titleMissingGems:SetText(L.GEAR_MISSING_GEMS)
titleMissingGems:SetPoint("LEFT", titleItemLevel, "RIGHT", 0, 0)

local missingGemsWidth = mmax(55, titleMissingGems:GetStringWidth() + 20)
titleMissingGems:SetWidth(missingGemsWidth)

local titleMissingEnchants = GetTextFrame()
titleMissingEnchants.Keep = true
titleMissingEnchants:SetFontObject(GameFontNormalLarge)
titleMissingEnchants:SetText(L.GEAR_MISSING_ENCHANTS)
titleMissingEnchants:SetPoint("LEFT", titleMissingGems, "RIGHT", 0, 0)

local missingEnchantsWidth = mmax(55, titleMissingEnchants:GetStringWidth() + 20)
titleMissingEnchants:SetWidth(missingEnchantsWidth)

child:SetWidth(playerWidth + itemLevelWidth + missingGemsWidth + missingEnchantsWidth + 8)
frame:SetWidth(child:GetWidth() + 32)

local function SetPlayerGearState(name, itemLevel, missingGems, missingEnchants, pending, unavailable)
	local player = DBM:GetRaidRoster()[name]
	if not player then
		return
	end
	player.gearilvl = itemLevel
	player.gearmissinggems = missingGems
	player.gearmissingenchants = missingEnchants
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

local function GetGearCountText(player, key)
	if type(player[key]) == "number" then
		return tostring(player[key])
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

local function UpdateRaidTab()
	wipe(sortGear)
	for _, v in pairs(DBM:GetRaidRoster()) do
		tinsert(sortGear, v)
	end
	tsort(sortGear, SortGear)

	WipeTextFrames()

	for i, v in ipairs(sortGear) do
		local fullName = v.name
		local name = DBM:GetShortServerName(fullName) or fullName
		local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(fullName)]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textItemLevel, textMissingGems, textMissingEnchants = GetTextFrame(), GetTextFrame(), GetTextFrame(), GetTextFrame()

		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(playerWidth)

		textItemLevel:SetText(GetGearText(v))
		textItemLevel:SetPoint("TOP", titleItemLevel, "BOTTOM", 0, offset)
		textItemLevel:SetWidth(itemLevelWidth)

		textMissingGems:SetText(GetGearCountText(v, "gearmissinggems"))
		textMissingGems:SetPoint("TOP", titleMissingGems, "BOTTOM", 0, offset)
		textMissingGems:SetWidth(missingGemsWidth)

		textMissingEnchants:SetText(GetGearCountText(v, "gearmissingenchants"))
		textMissingEnchants:SetPoint("TOP", titleMissingEnchants, "BOTTOM", 0, offset)
		textMissingEnchants:SetWidth(missingEnchantsWidth)
	end

	local scrollHeight = scroll:GetHeight()
	child:SetHeight(mmax(scrollHeight, 50 + #sortGear * 14))
	scroll:UpdateScrollChildRect()
end

local function UpdateGuildTab()
	WipeTextFrames()

	local guildPlayers = {}
	for name in pairs(guildGearData) do
		tinsert(guildPlayers, {name = name, class = guildGearData[name].class, gearilvl = guildGearData[name].itemLevel, gearmissinggems = guildGearData[name].missingGems, gearmissingenchants = guildGearData[name].missingEnchants})
	end
	tsort(guildPlayers, SortGear)

	for i, v in ipairs(guildPlayers) do
		local fullName = v.name
		local name = DBM:GetShortServerName(fullName) or fullName
		local playerClass = v.class
		local playerColor = RAID_CLASS_COLORS[playerClass]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textItemLevel, textMissingGems, textMissingEnchants = GetTextFrame(), GetTextFrame(), GetTextFrame(), GetTextFrame()

		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(playerWidth)

		textItemLevel:SetText(GetGearText(v))
		textItemLevel:SetPoint("TOP", titleItemLevel, "BOTTOM", 0, offset)
		textItemLevel:SetWidth(itemLevelWidth)

		textMissingGems:SetText(tostring(v.gearmissinggems or 0))
		textMissingGems:SetPoint("TOP", titleMissingGems, "BOTTOM", 0, offset)
		textMissingGems:SetWidth(missingGemsWidth)

		textMissingEnchants:SetText(tostring(v.gearmissingenchants or 0))
		textMissingEnchants:SetPoint("TOP", titleMissingEnchants, "BOTTOM", 0, offset)
		textMissingEnchants:SetWidth(missingEnchantsWidth)
	end

	local scrollHeight = scroll:GetHeight()
	child:SetHeight(mmax(scrollHeight, 50 + #guildPlayers * 14))
	scroll:UpdateScrollChildRect()
end

local function Update()
	if selectedTab == 1 then
		UpdateRaidTab()
	elseif selectedTab == 2 then
		UpdateGuildTab()
	end
end

local function ClearInspectQueue()
	inspectToken = inspectToken + 1
	commRequestToken = commRequestToken + 1
	ClearInspectPlayer()
	wipe(pendingInspects)
	wipe(pendingCommReplies)
	wipe(inspectRetryCounts)
	wipe(inspectRetryDeadlines)
	wipe(knownRosterMembers)
	wipe(activeInspect)
end

local function MarkInspectUnavailable(name)
	pendingCommReplies[name] = nil
	inspectRetryCounts[name] = nil
	inspectRetryDeadlines[name] = nil
	SetPlayerGearState(name, nil, nil, nil, false, true)
end

local function QueueInspectRetry(name)
	local now = GetTime()
	local deadline = inspectRetryDeadlines[name]
	if not deadline then
		deadline = now + inspectRetryWindowSeconds
		inspectRetryDeadlines[name] = deadline
	end
	local retryCount = (inspectRetryCounts[name] or 0) + 1
	if retryCount <= inspectMaxRetries and now <= deadline then
		inspectRetryCounts[name] = retryCount
		SetPlayerGearState(name, nil, nil, nil, true, false)
		tinsert(pendingInspects, name)
		return true
	end
	inspectRetryCounts[name] = nil
	inspectRetryDeadlines[name] = nil
	SetPlayerGearState(name, nil, nil, nil, false, true)
	return false
end

function ShouldUseCommScan()
	if not (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown) then
		return false
	end
	return not C_ChatInfo.InChatMessagingLockdown()
end

local function ShouldAwaitCommReply(name)
	return DBM:CheckDBM(name) and true or false
end

local function RemovePendingInspect(name)
	for i = #pendingInspects, 1, -1 do
		if pendingInspects[i] == name then
			tremove(pendingInspects, i)
		end
	end
end

local function SendGearSyncRequest()
	if not frame:IsShown() or not private.sendSync or not ShouldUseCommScan() or not next(pendingCommReplies) then
		return
	end
	commRequestToken = commRequestToken + 1
	local requestToken = commRequestToken
	private.sendSync(private.DBMSyncProtocol or 1, "GIQ", nil, "NORMAL")
	C_Timer.After(commReplyTimeoutSeconds, function()
		if not frame:IsShown() or requestToken ~= commRequestToken then
			return
		end
		local queuedInspect = false
		for name in pairs(pendingCommReplies) do
			pendingCommReplies[name] = nil
			if knownRosterMembers[name] then
				tinsert(pendingInspects, name)
				queuedInspect = true
			end
		end
		if queuedInspect then
			Update()
			RequestNextInspect()
		end
	end)
end

function SendGuildGearSyncRequest()
	if not frame:IsShown() or not private.sendGuildSync or not ShouldUseCommScan() or not IsInGuild() then
		return
	end
	wipe(guildGearData)
	guildGearQuerySent = true
	-- Seed our own data since self-sent GGR messages are filtered out in AddonComms.
	-- UnitName("player") has no realm suffix, matching the key format GetCorrectSender produces
	-- for same-realm WHISPER senders. Cross-realm peers arrive as "Name-Realm" via GetCorrectSender,
	-- so there is no collision between the local player and any same-name cross-realm guild member.
	local selfName = UnitName("player")
	local selfItemLevel, selfMissingGems, selfMissingEnchants = ScanGear("player")
	if type(selfItemLevel) == "number" then
		local selfClass = select(2, UnitClass("player"))
		guildGearData[selfName] = {class = selfClass, itemLevel = selfItemLevel, missingGems = selfMissingGems or 0, missingEnchants = selfMissingEnchants or 0}
	end
	guildSyncToken = guildSyncToken + 1
	local requestToken = guildSyncToken
	private.sendGuildSync(private.DBMSyncProtocol or 1, "GGQ", nil)
	C_Timer.After(commReplyTimeoutSeconds + 2, function()
		-- Guard staleness first: a rapid re-request increments guildSyncToken, making this timer stale.
		-- Resetting guildGearQuerySent here would close the active query window and silently drop replies.
		if requestToken ~= guildSyncToken then
			return
		end
		guildGearQuerySent = false
		if not frame:IsShown() or selectedTab ~= 2 then
			return
		end
		Update()
	end)
end

--Only valid for midnight. No classic flavors supported since I don't play those
local enchantableSlots = {
	[1] = true,--Helm
--	[2] = true,--Neck
	[3] = true,--Shoulder
--	[4] = true,--Shirt
	[5] = true,--Chest
--	[6] = true,--Waist
	[7] = true,--Legs
	[8] = true,--Feet
--	[9] = true,--Wrist
--	[10] = true,--Hands
	[11] = true,--Finger1
	[12] = true,--Finger2
--	[15] = true,--Back
	[16] = true,--MainHand
--	[17] = true,--OffHand
}

--TODO, collect list of enchant Ids and show a () next to count showing number of cheap enchants in use
function ScanGear(unit)
	if not unit then
		return
	end
	if DBM:issecretunit(unit) then
		return
	end
	local averageItemLevel
	local missingGems, missingEnchants = 0, 0
	for i = 1, 17 do
		local itemLink = GetInventoryItemLink(unit, i)
		if itemLink then
			--[1]="|cn|Q4:|Hitem:49812:8025:240894::::::90:73::16:5:12795:13440:6652:13668:12699:1:28:1279:::::|h[Purloined Wedding Ring]|h|r"
			local enchant, gem1, gem2, gem3, gem4 = itemLink:match("item:%d+:(%d*):(%d*):(%d*):(%d*):(%d*):")
			local expectedGems, filledSockets = 0, 0

			--https://warcraft.wiki.gg/wiki/API_C_Item.GetItemStats
			local statTable = C_Item.GetItemStats(itemLink)
			if statTable then
				for mod, count in next, statTable do
					--https://www.townlong-yak.com/framexml/10.2.0/GlobalStrings.lua#6196
					if mod:find("EMPTY_SOCKET_", nil, true) then
						expectedGems = expectedGems + count
					end
				end
			end
			if gem1 and gem1 ~= "" then
				filledSockets = filledSockets + 1
			end
			if gem2 and gem2 ~= "" then
				filledSockets = filledSockets + 1
			end
			if gem3 and gem3 ~= "" then
				filledSockets = filledSockets + 1
			end
			if gem4 and gem4 ~= "" then
				filledSockets = filledSockets + 1
			end
			local newMissing = expectedGems - filledSockets
			if newMissing > 0 then
				missingGems = missingGems + newMissing
			end

			if enchantableSlots[i] and enchant == "" then
				missingEnchants = missingEnchants + 1
			end
		end
	end
	if UnitIsUnit(unit, "player") then
		local _, equipped = GetAverageItemLevel()
		--Player returns decimal precision
		averageItemLevel = RoundItemLevel(equipped)
	else
		if not (C_PaperDollInfo and C_PaperDollInfo.GetInspectItemLevel) then
			return
		end
		averageItemLevel = C_PaperDollInfo.GetInspectItemLevel(unit)
		--Unfortunately, this api does NOT return decimal precision
--		averageItemLevel = RoundItemLevel(averageItemLevel)
	end
	return averageItemLevel, missingGems, missingEnchants
end

local function FinishInspect(token, itemLevel, missingGems, missingEnchants)
	if not activeInspect.name then
		return
	end
	if activeInspect.token ~= token then
		wipe(activeInspect)
		ClearInspectPlayer()
		if pendingRosterRefresh and frame:IsShown() then
			pendingRosterRefresh = false
			HandleRosterUpdate()
		end
		return
	end
	if type(itemLevel) ~= "number" then
		QueueInspectRetry(activeInspect.name)
	else
		pendingCommReplies[activeInspect.name] = nil
		inspectRetryCounts[activeInspect.name] = nil
		inspectRetryDeadlines[activeInspect.name] = nil
		SetPlayerGearState(activeInspect.name, itemLevel, missingGems, missingEnchants, false, false)
	end
	wipe(activeInspect)
	ClearInspectPlayer()
	Update()
	if pendingRosterRefresh and frame:IsShown() then
		pendingRosterRefresh = false
		HandleRosterUpdate()
		return
	end
	if frame:IsShown() and #pendingInspects > 0 then
		C_Timer.After(0.1, function()
			if frame:IsShown() and not activeInspect.name then
				RequestNextInspect()
			end
		end)
	end
end

function RequestNextInspect()
	if not frame:IsShown() or activeInspect.name then
		return
	end
	if InCombatLockdown() or UnitAffectingCombat("player") or (InspectFrame and InspectFrame:IsShown()) then
		return
	end
	local inspectAttemptsThisPass = #pendingInspects
	for _ = 1, inspectAttemptsThisPass do
		if #pendingInspects == 0 then
			break
		end
		local name = tremove(pendingInspects, 1)
		local unit = DBM:GetRaidUnitId(name, true)
		if unit and DBM:issecretunit(unit) then
			MarkInspectUnavailable(name)
		else
			local canInspect = unit and UnitExists(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit, "player") and CheckInteractDistance(unit, 1) and CanInspect(unit)
			if canInspect then
				local guid = UnitGUID(unit)
				if guid then
					activeInspect.name = name
					activeInspect.guid = guid
					activeInspect.token = inspectToken
					NotifyInspect(unit)
					local token = inspectToken
					C_Timer.After(inspectTimeoutSeconds, function()
						if activeInspect.name == name and activeInspect.guid == guid and activeInspect.token == token then
							FinishInspect(token)
						end
					end)
					return
				end
			end
			MarkInspectUnavailable(name)
		end
	end
	Update()
end

local function SeedRaid()
	local playerName = DBM:GetUnitFullName("player")
	local useComms = private.sendSync and ShouldUseCommScan()
	wipe(knownRosterMembers)
	wipe(pendingCommReplies)
	for name in pairs(DBM:GetRaidRoster()) do
		knownRosterMembers[name] = true
		if name == playerName then
			SetPlayerGearState(name, ScanGear("player"))
		else
			local unit = DBM:GetRaidUnitId(name, true)
			if unit and DBM:issecretunit(unit) then
				MarkInspectUnavailable(name)
			else
				SetPlayerGearState(name, nil, nil, nil, true, false)
				if useComms and ShouldAwaitCommReply(name) then
					pendingCommReplies[name] = true
				else
					tinsert(pendingInspects, name)
				end
			end
		end
	end
	if useComms then
		SendGearSyncRequest()
	end
end

function HandleRosterUpdate()
	local roster = DBM:GetRaidRoster()
	local playerName = DBM:GetUnitFullName("player")
	local useComms = private.sendSync and ShouldUseCommScan()
	local needsCommRequest = false
	local currentMembers = {}

	for i = #pendingInspects, 1, -1 do
		if not roster[pendingInspects[i]] then
			tremove(pendingInspects, i)
		end
	end

	for name in next, inspectRetryCounts do
		if not roster[name] then
			inspectRetryCounts[name] = nil
			inspectRetryDeadlines[name] = nil
		end
	end
	for name in next, inspectRetryDeadlines do
		if not roster[name] then
			inspectRetryDeadlines[name] = nil
		end
	end
	for name in next, pendingCommReplies do
		if not roster[name] then
			pendingCommReplies[name] = nil
		end
	end

	if activeInspect.name and not roster[activeInspect.name] then
		wipe(activeInspect)
		ClearInspectPlayer()
	end

	for name in pairs(roster) do
		currentMembers[name] = true
		if not knownRosterMembers[name] then
			if name == playerName then
				SetPlayerGearState(name, ScanGear("player"))
			else
				local unit = DBM:GetRaidUnitId(name, true)
				if unit and DBM:issecretunit(unit) then
					MarkInspectUnavailable(name)
				else
					SetPlayerGearState(name, nil, nil, nil, true, false)
					if useComms and ShouldAwaitCommReply(name) then
						pendingCommReplies[name] = true
						needsCommRequest = true
					else
						tinsert(pendingInspects, name)
					end
				end
			end
		end
	end

	if not useComms and next(pendingCommReplies) then
		for name in pairs(pendingCommReplies) do
			pendingCommReplies[name] = nil
			tinsert(pendingInspects, name)
		end
	end

	wipe(knownRosterMembers)
	for name in pairs(currentMembers) do
		knownRosterMembers[name] = true
	end

	if useComms and needsCommRequest then
		SendGearSyncRequest()
	end

	Update()
	RequestNextInspect()
end

function Refresh()
	ClearInspectQueue()
	SeedRaid()
	Update()
	RequestNextInspect()
end

local function OnEvent(_, event, arg1)
	if event == "GROUP_ROSTER_UPDATE" then
		if frame:IsShown() then
			if activeInspect.name then
				pendingRosterRefresh = true
			else
				HandleRosterUpdate()
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if frame:IsShown() and #pendingInspects > 0 and not activeInspect.name then
			RequestNextInspect()
		end
	elseif event == "INSPECT_READY" then
		if type(arg1) == "string" and arg1 == activeInspect.guid then
			local unit = DBM:GetRaidUnitId(activeInspect.name, true)
			local itemLevel, missingGems, missingEnchants
			if unit and not DBM:issecretunit(unit) and UnitExists(unit) and UnitGUID(unit) == arg1 then
				itemLevel, missingGems, missingEnchants = ScanGear(unit)
			end
			FinishInspect(activeInspect.token, itemLevel, missingGems, missingEnchants)
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
		RequestNextInspect()
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
end)

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
	if #tabs == 0 then
		frame:CreateTab(GROUP, function()
			if frame:IsShown() then
				Refresh()
			end
		end)
		frame:CreateTab(GUILD, function()
			if ShouldUseCommScan() and IsInGuild() then
				SendGuildGearSyncRequest()
			end
		end)
	end
	frame:Show()
	frame:ShowTab(1)
end

function GearCheck:Hide()
	frame:Hide()
end

function GearCheck:OnSync(event, sender, itemLevel, missingGems, missingEnchants, classToken)
	if event == "GIQ" then
		if not private.sendSync or sender == UnitName("player") or not DBM:GetRaidRoster(sender) then
			return
		end
		local selfItemLevel, selfMissingGems, selfMissingEnchants = ScanGear("player")
		if type(selfItemLevel) == "number" then
			private.sendSync(private.DBMSyncProtocol or 1, "GIR", ("%s\t%d\t%d"):format(selfItemLevel, selfMissingGems or 0, selfMissingEnchants or 0), "NORMAL")
		end
	elseif event == "GIR" then
		if sender == DBM:GetUnitFullName("player") then
			return
		end
		if not DBM:GetRaidRoster(sender) then
			return
		end
		pendingCommReplies[sender] = nil
		RemovePendingInspect(sender)
		if activeInspect.name == sender then
			wipe(activeInspect)
			ClearInspectPlayer()
		end
		itemLevel = tonumber(itemLevel)
		missingGems = tonumber(missingGems)
		missingEnchants = tonumber(missingEnchants)
		if type(itemLevel) == "number" then
			inspectRetryCounts[sender] = nil
			inspectRetryDeadlines[sender] = nil
			SetPlayerGearState(sender, RoundItemLevel(itemLevel), missingGems or 0, missingEnchants or 0, false, false)
		else
			SetPlayerGearState(sender, nil, nil, nil, true, false)
			tinsert(pendingInspects, sender)
		end
		if frame:IsShown() then
			Update()
			if #pendingInspects > 0 and not activeInspect.name then
				RequestNextInspect()
			end
		end
	elseif event == "GGQ" then
		-- Use UnitName (no realm) to match the ambiguated sender format from GetCorrectSender.
		-- GetUnitFullName returns "Name-Realm" which never equals an ambiguated same-realm sender.
		if not private.sendWhisperSync or sender == UnitName("player") or not IsInGuild() then
			return
		end
		if C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() then
			return
		end
		if not DBM:AntiSpam(guildGearQuerySpamSeconds, "GGQ:" .. sender) then
			return
		end
		local selfItemLevel, selfMissingGems, selfMissingEnchants = ScanGear("player")
		if type(selfItemLevel) == "number" then
			local selfClass = select(2, UnitClass("player")) or ""
			private.sendWhisperSync(private.DBMSyncProtocol or 1, "GGR", ("%s\t%d\t%d\t%s"):format(selfItemLevel, selfMissingGems or 0, selfMissingEnchants or 0, selfClass), sender, "NORMAL")
		end
	elseif event == "GGR" then
		if sender == UnitName("player") then
			return
		end
		if not guildGearQuerySent or not IsInGuild() then
			return
		end
		itemLevel = tonumber(itemLevel)
		missingGems = tonumber(missingGems)
		missingEnchants = tonumber(missingEnchants)
		if type(classToken) ~= "string" or classToken == "" then
			classToken = nil
		end
		if type(itemLevel) ~= "number" or itemLevel < 0 or itemLevel > maxReasonableItemLevel then
			return
		end
		missingGems = mmax(0, mfloor(missingGems or 0))
		missingEnchants = mmax(0, mfloor(missingEnchants or 0))
		guildGearData[sender] = {class = classToken, itemLevel = itemLevel, missingGems = missingGems, missingEnchants = missingEnchants}
		if frame:IsShown() and selectedTab == 2 and not guildUpdatePending then
			guildUpdatePending = true
			C_Timer.After(guildUpdateDebounceSeconds, function()
				guildUpdatePending = false
				if frame:IsShown() and selectedTab == 2 then
					Update()
				end
			end)
		end
	end
end
