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

local isPlayerRemix = PlayerIsTimerunning and PlayerIsTimerunning()

local playerSpecs = {}
do
	local function UpdateSpec(specID, _, _, playerName)
		playerSpecs[playerName] = specID
	end
	LibSpec.RegisterGroup(playerSpecs, UpdateSpec)
	LibSpec.RegisterGuild(playerSpecs, UpdateSpec)
end

-- [ChallengeModeID] = {MapID, TeleportID, bgImage}
local teleports
local function updateTeleports()
	isPlayerRemix = PlayerIsTimerunning and PlayerIsTimerunning()
	if isPlayerRemix then
		teleports = {
			--[197] = {1456, nil, 1498157}, -- Eye of Azshara
			[198] = {1466, 424163, 1411855}, -- Darkheart Thicket
			[199] = {1501, 424153, 1411853}, -- Black Rook Hold
			[200] = {1477, 393764, 1498158}, -- Halls of Valor
			[206] = {1458, 410078, 1450574}, -- Neltharion's Lair
			--[207] = {1493, nil, 1411858}, -- Vault of the Wardens
			--[208] = {1492, nil, 1411856}, -- Maw of Souls
			--[209] = {1516, nil, 1411857}, -- The Arcway
			[210] = {1571, 393766, 1498156}, -- Court of Stars
			[227] = {1651, 373262, 1537283}, -- Return to Karazhan: Lower
			--[233] = {1677, nil, 1616922}, -- Cathedral of Eternal Night
			[234] = {1651, 373262, 1537283}, -- Return to Karazhan: Upper
			--[239] = {1753, nil, 1718213}, -- Seat of the Triumvirate
		}
	else
		teleports = {
			[378] = {2287, 354465, 3759908}, -- Halls of Atonement
			[391] = {2441, 367416, 4182022}, -- Tazavesh: Streets of Wonder
			[392] = {2441, 367416, 4182022}, -- Tazavesh: So'leah's Gambit
			[499] = {2649, 445444, 5912551}, -- Priority of the Sacred Flame
			[503] = {2660, 445417, 5912546}, -- Ara-Kara, City of Echoes
			[505] = {2662, 445414, 5912552}, -- The Dawnbreaker
			[525] = {2773, 1216786, 6422412}, -- Operation Floodgate
			[542] = {2830, 1237215,7074042} -- Eco-Dome Al'dani
		}
	end
end
updateTeleports()

local partyKeystones, guildKeystones = {}, {}

---@class DBMKeystonesFrame: DefaultPanelTemplate
---@field CreateTab fun(self: DBMKeystonesFrame, title: string, OnShowFn: function)
---@field ShowTab fun(self: DBMKeystonesFrame, tab: number)
local frame = CreateFrame("Frame", "DBMKeystonesFrame", UIParent, "DefaultPanelTemplate")
tinsert(_G["UISpecialFrames"], frame:GetName())
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
	local x, y = self:GetLeft(), -(GetScreenHeight() - self:GetTop())
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", x, y)
	DBM.Options.KeystonesPosition = {'TOPLEFT', x, y}
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
	_frame:RegisterForClicks("AnyDown", "AnyUp")

	local text = _frame:CreateFontString(nil, nil, "GameFontNormal")
	text:SetAllPoints(_frame)
	text:SetJustifyH("LEFT")
	_frame.Text = text

	local bg = _frame:CreateTexture()
	bg:SetAllPoints(_frame)
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
local function TeleportTooltipOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	if InCombatLockdown() then
		GameTooltip:SetText(ERR_NOT_IN_COMBAT)
	else
		if not DBMExtraGlobal:IsSpellKnown(self:GetAttribute('spell')) then
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
		if v.specID or playerSpecs[name] then
			local _, _, _, _, _, class = GetSpecializationInfoByID(v.specID or playerSpecs[name])
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

		textLevel.Text:SetText(v.keyLevel == 0 and '-' or v.keyLevel or '?')
		textLevel:SetPoint("TOP", titleLevel, "BOTTOM", 0, offset)
		textLevel:SetWidth(titleLevel:GetWidth())

		textDungeon.Text:SetText(L.KEYSTONE_NAMES[v.mapID] or (v.mapID == 0 and '-') or v.mapID or '?')
		textDungeon:SetPoint("TOP", titleDungeon, "BOTTOM", 0, offset)
		textDungeon:SetWidth(titleDungeon:GetWidth())
		if v.mapID and v.mapID ~= 0 and teleports[v.mapID] then
			textDungeon:SetScript('OnEnter', TeleportTooltipOnEnter)
			textDungeon:SetScript('OnLeave', GameTooltip_Hide)
			textDungeon:SetAttribute('type', 'spell')
			textDungeon:SetAttribute('spell', teleports[v.mapID][2])
		end

		textRating.Text:SetText(v.playerRating == 0 and '-' or v.playerRating or '?')
		textRating:SetPoint("TOP", titleRating, "BOTTOM", 0, offset)
		textRating:SetWidth(titleRating:GetWidth())
	end

	-- Update main frame width
	child:SetSize(mmax(300, 120 + titleLevel:GetWidth() + titleDungeon:GetWidth() + titleRating:GetWidth() + 8), mmax(scroll:GetHeight(), 50 + #sortTable * 14))
	frame:SetWidth(child:GetWidth() + 32)
end

local UpdateKeystones

do
	local type, strsplit = type, string.split
	local GetContainerNumSlots, GetContainerItemID, GetContainerItemLink, IsItemKeystoneByID =
		C_Container.GetContainerNumSlots, C_Container.GetContainerItemID, C_Container.GetContainerItemLink, C_Item.IsItemKeystoneByID

	function UpdateKeystones()
		local resetTime = C_DateAndTime.GetWeeklyResetStartTime()
		if not DBM_Keystones.resetTime or resetTime ~= DBM_Keystones.resetTime then
			DBM_Keystones.resetTime = resetTime
			DBM_Keystones.keys = {}
		end

		-- If not max level, don't store this character in the keys system
		-- Unless we're in remix
		if UnitLevel('player') ~= GetMaxPlayerLevel() and not isPlayerRemix then
			return
		end

		local name = UnitName('player')
		local currentRating = C_PlayerInfo.GetPlayerMythicPlusRatingSummary('player')
		local keyLevel = C_MythicPlus.GetOwnedKeystoneLevel() or 0
		local keyMap = C_MythicPlus.GetOwnedKeystoneChallengeMapID() or 0

		-- Legion remix
		if keyLevel == 0 and keyMap == 0 and isPlayerRemix then
			for currentBag = 0, 4 do -- 0=Backpack, 1/2/3/4=Bags
				local slots = GetContainerNumSlots(currentBag)
				for currentSlot = 1, slots do
					local itemID = GetContainerItemID(currentBag, currentSlot)
					if itemID and IsItemKeystoneByID(itemID) then
						local itemLink = GetContainerItemLink(currentBag, currentSlot)
						if type(itemLink) == "string" then
							local _, _, _, strChallengeMapID, strLevel = strsplit(":", itemLink)
							local level = tonumber(strLevel)
							local challengeMapID = tonumber(strChallengeMapID)
							if challengeMapID and level then
								keyLevel = level
								keyMap = challengeMapID
								break
							end
						end
					end
				end
			end
		end

		DBM_Keystones.keys[UnitGUID('player')] = {
			name = name,
			specID = playerSpecs[name] or 0,
			keyLevel = keyLevel or 0,
			mapID = keyMap or 0,
			playerRating = currentRating and currentRating.currentSeasonScore or 0,
		}

		-- Update the character frame
		if selectedTab == 3 then -- Characters tab
			PartyGuildUpdate(DBM_Keystones.keys)
		end
	end
end

frame:CreateTab(PARTY, function()
	refresh:Show()
	partyKeystones = {}
	for _, v in pairs(DBM:GetRaidRoster()) do
		partyKeystones[v.name] = {
			name = v.name,
			keyLevel = 0,
			mapID = 0,
			playerRating = 0,
		}
	end
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
	UpdateKeystones()
	PartyGuildUpdate(DBM_Keystones.keys)
end)

-- Teleport
do
	-- This will never be nil, but falling back just so it shuts up LuaLS
	frame:CreateTab(DBM:GetSpellName(4801) or 'Teleport', function()
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
			if not DBMExtraGlobal:IsSpellKnown(teleport[2]) then
				button.Text:SetTextColor(1, 0, 0)
			end
			-- Scale down text size if it's long single words
			while button.Text:IsTruncated() do
				button.Text:SetTextScale(button.Text:GetTextScale() - 0.01)
			end
			button.Background:SetTexCoord(0, 0.68359375, 0, 0.7421875)
			button.Background:SetTexture(teleport[3])
			button.Background:SetDesaturation(0.75)
			button.Background:SetAlpha(0.75)
			button.Background:Show()
			i = i + 1
		end
		child:SetSize(300, mmax(scroll:GetHeight(), 60 * (#buttons / 2)))
		frame:SetWidth(child:GetWidth() + 32)
	end)
end

function Keystones:Show()
	DBM.Durability:Hide()
	DBM.Latency:Hide()
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

frame:SetScript('OnEvent', function(_, event, arg1, arg2)
	if event == 'UNIT_CONNECTION' then
		if selectedTab == 1 and arg2 then -- isConnected
			LibKeystone.Request("PARTY")
		end
	elseif event == 'PLAYER_ENTERING_WORLD' then
		updateTeleports()
		if not DBM_Keystones then
			DBM_Keystones = {
				keys = {}
			}
		end
		-- Once we're fully logged in, check if nobody has a keystone command, and then inject ours
		-- We can't check SLASH_KEYSTONE3 because BigWigs murders it
		if not SLASH_KEYSTONE1 and not SLASH_KEYSTONE2 then
			SLASH_KEYSTONE1 = '/keystone'
			SLASH_KEYSTONE2 = '/keys'
			SLASH_KEYSTONE3 = '/key'
			SlashCmdList["KEYSTONE"] = function()
				Keystones:Show()
			end
		end
		UpdateKeystones()
	elseif event == 'PLAYER_INTERACTION_MANAGER_FRAME_HIDE' then
		if arg1 == 3 or arg1 == 49 then
			UpdateKeystones()
		end
	end
end)
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE')
frame:RegisterEvent('UNIT_CONNECTION')
