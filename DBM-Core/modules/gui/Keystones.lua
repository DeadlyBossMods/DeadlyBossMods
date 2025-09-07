---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMKeystones
local Keystones = {}
DBM.Keystones = Keystones

local tinsert, tsort, mmax, mfloor = table.insert, table.sort, math.max, math.floor

local L = DBM_CORE_L
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

local LibStub = _G["LibStub"]
local LibKeystone, LibSpec
local LibKeystoneTable = {}
if LibStub then
	LibKeystone = LibStub("LibKeystone", true)
	LibSpec = LibStub("LibSpecialization", true)
end

if not LibKeystone or not LibSpec then
	DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
	return
end

local playerSpecs = {}
do
	local function UpdateSpec(specID, _, _, playerName)
		playerSpecs[playerName] = specID
	end
	LibSpec.RegisterGroup(playerSpecs, UpdateSpec)
	LibSpec.RegisterGuild(playerSpecs, UpdateSpec)
end

-- [ChallengeModeID] = {MapID, TeleportID}
local teleports = {
	[378] = {2287, 354465}, -- Halls of Atonement
	[391] = {2441, 367416}, -- Tazavesh: Streets of Wonder
	[392] = {2441, 367416}, -- Tazavesh: So'leah's Gambit
	[499] = {2649, 445444}, -- Priority of the Sacred Flame
	[503] = {2660, 445417}, -- Ara-Kara, City of Echoes
	[505] = {2662, 445414}, -- The Dawnbreaker
	[525] = {2773, 1216786}, -- Operation Floodgate
	[542] = {2830, 1237215} -- Eco-Dome Al'dani
}

local partyKeystones, guildKeystones = {}, {}

---@class DBMKeystonesFrame: DefaultPanelTemplate
---@field CreateTab fun(self: DBMKeystonesFrame, title: string, OnShowFn: function)
---@field ShowTab fun(self: DBMKeystonesFrame, tab: number)
local frame = CreateFrame("Frame", nil, UIParent, "DefaultPanelTemplate")
frame:Hide()
frame:SetSize(380, 300)
frame:SetClampedToScreen(true)
frame:SetPoint("LEFT")
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetTitle(L.KEYSTONES_HEADER)
frame:SetScript("OnHide", function()
	LibKeystone.Unregister(LibKeystoneTable)
end)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.KeystonesPosition = {point, x, y}
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

-- Frames handler
local spareTextFrames, usedTextFrames = {}, {}
local function WipeTextFrames()
	for _frame in next, usedTextFrames do
		if not _frame.IsSpare then
			_frame.IsSpare = true
			_frame:Hide()
			_frame:ClearAttributes()
			_frame:SetSize(20, 20)
			_frame:SetScript('OnEnter', nil)
			_frame.Text:SetText("")
			_frame.Text:SetJustifyH("LEFT")
			_frame.Text:SetFontObject(GameFontNormal)
			_frame.Text:SetTextScale(1)
			_frame.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGB())
			_frame.Background:Hide()
			_frame:ClearAllPoints()
			spareTextFrames[#spareTextFrames + 1] = _frame
		end
	end
end
local function GetTextFrame()
	---@class DBMKeystonesTextFrame: Button
	---@field IsSpare boolean
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame.IsSpare = false
		_frame:Show()
		return _frame
	end
	---@class DBMKeystonesTextFrame
	_frame = CreateFrame("Button", nil, child, "InsecureActionButtonTemplate")
	_frame.IsSpare = false
	_frame:SetSize(20, 20)
	_frame:RegisterForClicks("AnyDown")

	local text = _frame:CreateFontString(nil, nil, "GameFontNormal")
	text:SetAllPoints(_frame)
	text:SetJustifyH("LEFT")
	_frame.Text = text

	local bg = _frame:CreateTexture()
	bg:SetAllPoints(_frame)
	bg:SetColorTexture(1, 1, 1, 0.1)
	bg:Hide()
	_frame.Background = bg

	usedTextFrames[_frame] = true
	return _frame
end

local tabs, tabsBtn, selectedTab = {}, {}, 1
function frame:CreateTab(title, OnShowFn)
	local i = #tabs + 1
	tabs[i] = OnShowFn
	---@class DBMKeystonesTabButton: Button
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

local refresh = CreateFrame("Button", nil, child)
refresh:SetSize(20, 20)
refresh:SetPoint("BOTTOMLEFT", child)
refresh:SetText("REFRESH")
refresh:Show()
refresh:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton-Down")
refresh:SetHighlightTexture("Interface\\Buttons\\UI-RefreshButton")
refresh:SetScript("OnClick", function()
	if selectedTab == 1 then
		LibKeystone.Request("PARTY")
	elseif selectedTab == 2 then
		LibSpec.RequestGuildSpecialization()
		C_Timer.After(0.1, function()
			LibKeystone.Request("GUILD")
		end)
	end
end)

local function SortKeystones(v1, v2)
	if v1.keyLevel ~= v2.keyLevel then
		return v1.keyLevel > v2.keyLevel
	end
	if v1.playerRating ~= v2.playerRating then
		return v1.playerRating > v2.playerRating
	end
	return v1.name > v2.name
end

local PartyGuildUpdate
local function RegisterLibKeystone()
	LibKeystone.Register(LibKeystoneTable, function(keyLevel, mapID, playerRating, sender, channel)
		if channel == 'PARTY' then
			-- We already have this entry, don't bother updating
			if partyKeystones[sender] and partyKeystones[sender].keyLevel == keyLevel and partyKeystones[sender].mapID == mapID and partyKeystones[sender].playerRating == playerRating then
				return
			end
			partyKeystones[sender] = {
				name = sender,
				keyLevel = keyLevel,
				mapID = mapID,
				playerRating = playerRating
			}
			if selectedTab == 1 then
				PartyGuildUpdate(partyKeystones)
			end
		elseif channel == 'GUILD' then
			-- We already have this entry, don't bother updating
			if guildKeystones[sender] and guildKeystones[sender].keyLevel == keyLevel and guildKeystones[sender].mapID == mapID and guildKeystones[sender].playerRating == playerRating then
				return
			end
			guildKeystones[sender] = {
				name = sender,
				keyLevel = keyLevel,
				mapID = mapID,
				playerRating = playerRating
			}
			if selectedTab == 2 then
				PartyGuildUpdate(guildKeystones)
			end
		end
	end)
end

function PartyGuildUpdate(table)
	local sortTable = {}
	for _, v in pairs(table) do
		tinsert(sortTable, v)
	end
	tsort(sortTable, SortKeystones)

	WipeTextFrames()

	local titlePlayer = GetTextFrame()
	titlePlayer.Text:SetFontObject(GameFontNormalLarge)
	titlePlayer.Text:SetText(PLAYER)
	titlePlayer:SetPoint("TOPLEFT", child, 7, 0)
	titlePlayer:SetWidth(120)

	local titleLevel = GetTextFrame()
	titleLevel.Text:SetFontObject(GameFontNormalLarge)
	titleLevel.Text:SetText(LEVEL)
	titleLevel:SetPoint("LEFT", titlePlayer, "RIGHT")
	titleLevel:SetWidth(mmax(75, titleLevel.Text:GetStringWidth() + 20))

	local titleDungeon = GetTextFrame()
	titleDungeon.Text:SetFontObject(GameFontNormalLarge)
	titleDungeon.Text:SetText(LFG_TYPE_DUNGEON)
	titleDungeon:SetPoint("LEFT", titleLevel, "RIGHT")
	titleDungeon:SetWidth(mmax(75, titleDungeon.Text:GetStringWidth() + 20))

	local titleRating = GetTextFrame()
	titleRating.Text:SetFontObject(GameFontNormalLarge)
	titleRating.Text:SetText(RATING)
	titleRating:SetPoint("LEFT", titleDungeon, "RIGHT")
	titleRating:SetWidth(mmax(75, titleRating.Text:GetStringWidth() + 20))

	for i, v in ipairs(sortTable) do
		local name = v.name
		if playerSpecs[name] then
			local _, _, _, _, _, class = GetSpecializationInfoByID(playerSpecs[name])
			local playerColor = RAID_CLASS_COLORS[class]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer, textLevel, textDungeon, textRating = GetTextFrame(), GetTextFrame(), GetTextFrame(), GetTextFrame()

		textPlayer.Text:SetText(name:gsub("%-.*$", "*"))
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(120)
		textPlayer:SetAttribute("type", "macro")
		textPlayer:SetAttribute("macrotext", "/run ChatFrame_SendTell(\"" .. v.name .. "\")")

		textLevel.Text:SetText(v.keyLevel or '?')
		textLevel:SetPoint("TOP", titleLevel, "BOTTOM", 0, offset)
		textLevel:SetWidth(titleLevel:GetWidth())

		textDungeon.Text:SetText(L.KEYSTONE_NAMES[v.mapID] or v.mapID or '?')
		textDungeon:SetPoint("TOP", titleDungeon, "BOTTOM", 0, offset)
		textDungeon:SetWidth(titleDungeon:GetWidth())

		textRating.Text:SetText(v.playerRating or '?')
		textRating:SetPoint("TOP", titleRating, "BOTTOM", 0, offset)
		textRating:SetWidth(titleRating:GetWidth())
	end

	-- Update main frame width
	child:SetSize(mmax(300, 120 + titleLevel:GetWidth() + titleDungeon:GetWidth() + titleRating:GetWidth() + 8), mmax(scroll:GetHeight(), 50 + #sortTable * 14))
	frame:SetWidth(child:GetWidth() + 32)
end

frame:CreateTab(PARTY, function()
	refresh:Show()
	partyKeystones = {}
	PartyGuildUpdate(partyKeystones)
	RegisterLibKeystone()
	LibKeystone.Request("PARTY")
end)

frame:CreateTab(GUILD, function()
	refresh:Show()
	guildKeystones = {}
	PartyGuildUpdate(guildKeystones)
	RegisterLibKeystone()
	LibSpec.RequestGuildSpecialization()
	C_Timer.After(0.1, function()
		LibKeystone.Request("GUILD")
	end)
end)

frame:CreateTab(CHARACTER, function()
	refresh:Hide()
	local title = GetTextFrame()
	title.Text:SetFontObject(GameFont_Gigantic)
	title.Text:SetText("Coming Soon")
	title:SetPoint("TOPLEFT", child, 7, -20)
	title:SetWidth(title.Text:GetStringWidth())
end)

-- Teleport
do
	local function TeleportTooltipOnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		if InCombatLockdown() then
			GameTooltip:SetText(ERR_NOT_IN_COMBAT)
		else
			if not self:GetAttribute('spell-learned') then
				GameTooltip:SetText(SPELL_FAILED_NOT_KNOWN)
			else
				local start, duration = DBM:GetSpellCooldown(self:GetAttribute('spell'))
				if start > 0 and duration > 0 then
					local remainingSec = (start + duration) - GetTime()
					local hours, minutes = mfloor(remainingSec / 3600), mfloor(remainingSec / 60)
					if hours > 0 then
						GameTooltip:SetText(ITEM_COOLDOWN_TIME_HOURS:format(hours))
					else
						GameTooltip:SetText(ITEM_COOLDOWN_TIME_MIN:format(minutes))
					end
				else
					GameTooltip:SetText(LFG_READY_CHECK_PLAYER_IS_READY:format(DBM:GetSpellName(self:GetAttribute('spell'))))
				end
			end
		end
		GameTooltip:Show()
	end

	frame:CreateTab(DBM:GetSpellName(4801), function()
		refresh:Hide()
		WipeTextFrames()

		local i, buttons = 1, {}
		for _, teleport in pairs(teleports) do
			local button = GetTextFrame()
			buttons[#buttons + 1] = button
			button:SetScript('OnEnter', TeleportTooltipOnEnter)
			button:SetScript('OnLeave', GameTooltip_Hide)
			button:SetAttribute('type', 'spell')
			button:SetAttribute('spell', teleport[2])
			button:SetSize(100, 50)
			if i == 1 then
				button:SetPoint("TOPLEFT", child, "TOPLEFT",40, -10)
			elseif i % 2 == 0 then
				button:SetPoint("LEFT", buttons[i - 1], "RIGHT", 25, 0)
			else
				button:SetPoint("TOP", buttons[i - 2], "BOTTOM", 0, -10)
			end
			button.Text:SetJustifyH("CENTER")
			button.Text:SetText(GetRealZoneText(teleport[1]))
			local isLearned = DBMExtraGlobal:IsSpellKnown(teleport[2])
			button:SetAttribute('spell-learned', isLearned)
			if not isLearned then
				button.Text:SetTextColor(1, 0, 0)
			end
			-- Scale down text size if it's long single words
			while button.Text:IsTruncated() do
				button.Text:SetTextScale(button.Text:GetTextScale() - 0.01)
			end
			button.Background:Show()
			i = i + 1
		end
		child:SetSize(300, mmax(scroll:GetHeight(), 60 * (#buttons / 2)))
		frame:SetWidth(child:GetWidth() + 32)
	end)
end

function Keystones:Show()
	if _G["DBM_GUI_OptionsFrame"] then
		frame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	frame:ClearAllPoints()
	frame:SetPoint(DBM.Options.KeystonesPosition[1], DBM.Options.KeystonesPosition[2], DBM.Options.KeystonesPosition[3])
	frame:Show()
	frame:ShowTab(selectedTab)
end

function Keystones:Hide()
	frame:Hide()
end

--[[
-- DEBUG
frame:Show()
frame:ShowTab(1)
]]--
