local L = DBM_CORE_L

---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)

---@type DBMAnnoyingPopup
local frame

local callback

local function createEditBox()
	local editBox = CreateFrame("EditBox", nil, frame)
	local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
	editBoxLeft:SetTexture(130959)--"Interface\\ChatFrame\\UI-ChatInputBorder-Left"
	editBoxLeft:SetHeight(32)
	editBoxLeft:SetWidth(32)
	editBoxLeft:SetPoint("LEFT", -14, 0)
	editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
	local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
	editBoxRight:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
	editBoxRight:SetHeight(32)
	editBoxRight:SetWidth(32)
	editBoxRight:SetPoint("RIGHT", 6, 0)
	editBoxRight:SetTexCoord(0.875, 1, 0, 1)
	local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
	editBoxMiddle:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
	editBoxMiddle:SetHeight(32)
	editBoxMiddle:SetWidth(1)
	editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
	editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
	editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
	editBox:SetHeight(32)
	editBox:SetWidth(375)
	editBox:SetFontObject(GameFontHighlight)
	editBox:SetTextInsets(0, 0, 0, 1)
	editBox:SetFocus()
	editBox:SetScript("OnTextChanged", function(self)
		self:SetText(self.text)
		self:HighlightText()
	end)
	local function highlight(self)
		self:HighlightText()
	end
	editBox:SetScript("OnEnter", highlight)
	editBox:SetScript("OnMouseUp", highlight)
	editBox:SetScript("OnCursorChanged", highlight)
	return editBox
end

local function createFrame()
	if frame then return end
	---@class DBMAnnoyingPopup: Frame, BackdropTemplate
	frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	frame:SetFrameStrata("FULLSCREEN_DIALOG") -- In front of other frames including DBM-GUI
	frame:SetWidth(600)
	frame:SetHeight(1)
	frame:SetPoint("TOP", 0, -230)
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 11, right = 12, top = 12, bottom = 11 },
	}
	frame:ApplyBackdrop()
	frame.header1 = frame:CreateFontString(nil, nil, "GameFontRedLarge")
	frame.header1:SetWidth(550)
	frame.header1:SetHeight(0)
	frame.header1:SetPoint("TOP", 0, -16)
	frame.header2 = frame:CreateFontString(nil, nil, "GameFontNormal")
	frame.header2:SetWidth(550)
	frame.header2:SetHeight(0)
	frame.header2:SetPoint("TOP", frame.header1, "BOTTOM", 0, -2)
	frame.editBox1 = createEditBox()
	frame.editBox1:SetPoint("TOP", frame.header2, "BOTTOM", 0, -20)
	frame.editBox1Header = frame:CreateFontString(nil, nil, "GameFontNormal")
	frame.editBox1Header:SetPoint("BOTTOMLEFT", frame.editBox1, "TOPLEFT", -4, 0)
	frame.editBox2 = createEditBox()
	frame.editBox2:SetPoint("TOP", frame.editBox1, "BOTTOM", 0, -18)
	frame.editBox2Header = frame:CreateFontString(nil, nil, "GameFontNormal")
	frame.editBox2Header:SetPoint("BOTTOMLEFT", frame.editBox2, "TOPLEFT", -4, 0)
	frame.checkboxText = frame:CreateFontString(nil, nil, "GameFontNormal")
	frame.checkbox = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate")
	frame.checkbox:SetPoint("RIGHT", frame.checkboxText, "LEFT")
	frame.checkboxText:SetPoint("TOP", frame.editBox2, "BOTTOM", frame.checkbox:GetWidth() / 2, -8)
	frame.button = CreateFrame("Button", nil, frame)
	frame.button:SetHeight(24)
	frame.button:SetWidth(75)
	frame.button:SetPoint("TOP", frame.checkboxText, "BOTTOM", -frame.checkbox:GetWidth() / 2, -8)
	frame.button:SetNormalFontObject(GameFontNormal)
	frame.button:SetHighlightFontObject(GameFontHighlight)
	frame.button:SetNormalTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	frame.button:SetPushedTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	frame.button:SetHighlightTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	frame.button:SetText(CLOSE)
	frame.button:SetScript("OnClick", function()
		if callback then callback() end
		frame:Hide()
	end)
end

local function resize()
	if not frame then createFrame() end
	local buttonY = frame.button:GetBottom()
	local frameY = frame:GetTop()
	frame:SetHeight(frameY - buttonY + 15)
end

-- It's kinda sad that this is needed, but I see way too many people running around in SoD without classic mods installed while at the same time complaining that DBM doesn't work.
-- No one seems to be reading messages in ChatFrame :(
local function show(headerLarge, headerSmall, checkbox, url1Info, url1, url2Info, url2)
	createFrame()
	frame.header1:SetText(headerLarge)
	frame.header2:SetText(headerSmall)
	frame.editBox1Header:SetText(url1Info)
	frame.editBox2Header:SetText(url2Info)
	frame.editBox1.text = url1
	frame.editBox2.text = url2
	frame.checkboxText:SetText(checkbox)
	frame:Show()
	resize()
end

local popupData = {
	Vanilla = {
		package = L.DBM_INSTALL_PACKAGE_VANILLA,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-bc-vanilla-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/dbm-vanilla",
	},
	BCC = {
		package = L.DBM_INSTALL_PACKAGE_BCC,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-burning-crusade-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/deadly-boss-mods-tbc",
	},
	WoTLK = {
		package = L.DBM_INSTALL_PACKAGE_WRATH,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-wrath-of-the-lich-king-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/deadly-boss-mods-wotlk",
	},
	Cata = {
		package = L.DBM_INSTALL_PACKAGE_CATA,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-cataclysm-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/deadly-boss-mods-cataclysm-mods",
	},
	MoP = {
		package = L.DBM_INSTALL_PACKAGE_MOP,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-mists-of-pandaria-mop-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/deadly-boss-mods-mop",
	},
	Dungeons = {
		package = L.DBM_INSTALL_PACKAGE_DUNGEON,
		wagoUrl = "https://addons.wago.io/addons/deadly-boss-mods-dbm-old-dungeon-mods",
		curseUrl = "https://www.curseforge.com/wow/addons/deadly-boss-mods-dbm-dungeons",
		useFriendlyMessage = true
	}
}

--Basically no naxx
local annoyingPopupZonesVanillaRetail = {
	[409]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Molten Core
	[469]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Blackwing Lair
	[509]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Ruins of Ahn'Qiraj
	[531]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Temple of Ahn'Qiraj
	[2217] = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- BRD Raid
}

--Filtering should be handled by core (ie the level up raids won't be triggered if not SoD or too high of level)
local annoyingPopupZonesVanillaClassic = {
	[40]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Blackfathom Deeps Level Up Raid
	[90]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Gnomeragon Level up Raid
	[109]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Sunken Temple Level up Raid
	[249]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Onyxia
	[409]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Molten Core
	[469]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Blackwing Lair
	[509]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Ruins of Ahn'Qiraj
	[531]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla"},  -- Temple of Ahn'Qiraj
	[533]  = {addon = "DBM-Raids-Vanilla", package = "Vanilla", trackPerInstance = true},  -- Naxxramas, tracking separetely as we may have returning players that clicked the warning away not really understanding it
	[2791] = {addon = "DBM-Azeroth",       package = "Vanilla"},  -- Azuregos (instanced in SoD), we literally wiped there to spell reflect because people didn't have this installed in my guild
	[2784] = {addon = "DBM-Party-Vanilla", package = "Dungeons"}, -- Demon Fall Canyon in SoD, it's a bit harder than usual dungeons, so let's show a warning. Remove if too many people complain.
	[2832] = {addon = "DBM-Azeroth",       package = "Vanilla"},  -- Nightmare Grove (instanced outdoor dragons)
	[2856] = {addon = "DBM-Raids-Vanilla", package = "Vanilla", useFriendlyMessage = false, trackPerInstance = true},  -- Scarlet Enclave
	[2875] = {addon = "DBM-Party-Vanilla", package = "Dungeons", useFriendlyMessage = false, trackPerInstance = true}, -- SoD Karazhan Cryptos, much harder than the usual classic dungeon
}

local annoyingPopupZonesBCC = {
	[532]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[534]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[544]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[548]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[550]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[564]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[565]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
	[580]  = {addon = "DBM-Raids-BC", package = "BCC"},  -- ???
}

--No hard dungeons in wrath, so just popup for raids
local annoyingPopupZonesWrath = {
	[249]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- Onyxia (wrath version)
	[724]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
	[649]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
	[616]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
	[631]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
	[533]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- Naxxramas (Wrath)
	[603]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
	[624]  = {addon = "DBM-Raids-WoTLK", package = "WoTLK"},  -- ???
}

--Iffy on hard cata dungeons, but it's not complained about much so omited for now
local annoyingPopupZonesCata = {
	[757]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[671]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[669]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[967]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[720]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[951]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
	[754]  = {addon = "DBM-Raids-Cata", package = "Cata"},  -- ???
}

local annoyingPopupZonesRetail = {
	--TWW Season 1 M+ Dungeons
	[2652]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[2662]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[2660]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[2669]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[670]   = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[1822]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[2286]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
	[2290]  = {addon = "DBM-Party-Dragonflight", package = "Dungeons"},  -- ???
}

function DBM:ShowAnnoyingPopup(zoneInfo, zone)
	local trackId = zoneInfo.trackPerInstance and zoneInfo.package .. tostring(zone) or zoneInfo.package
	if DBM_AnnoyingPopupDisables and DBM_AnnoyingPopupDisables[trackId] then
		return
	end
	local data = popupData[zoneInfo.package]
	if not data or not zone then
		if DBM.Options.DebugMode then error("bad arguments") end
		return
	end
	local useFriendlyMessage = data.useFriendlyMessage
	if zoneInfo.useFriendlyMessage ~= nil then
		useFriendlyMessage = zoneInfo.useFriendlyMessage
	end
	show(
		L.DBM_INSTALL_REMINDER_HEADER,
		L.DBM_INSTALL_REMINDER_EXPLAIN:format(zone, data.package, data.package),
		useFriendlyMessage and L.DBM_INSTALL_REMINDER_DISABLE2 or L.DBM_INSTALL_REMINDER_DISABLE,
		L.DBM_INSTALL_REMINDER_DL_WAGO,
		data.wagoUrl,
		L.DBM_INSTALL_REMINDER_DL_CURSE,
		data.curseUrl
	)
	callback = function()
		if frame.checkbox:GetChecked() then
			DBM_AnnoyingPopupDisables = DBM_AnnoyingPopupDisables or {}
			DBM_AnnoyingPopupDisables[trackId] = GetServerTime()
		end
	end
end

function DBM:AnnoyingPopupCheckZone(mapId, zoneLookup)
	local zoneInfo
	if zoneLookup == "Vanilla" then
		zoneInfo = private.isRetail and annoyingPopupZonesVanillaRetail[mapId] or annoyingPopupZonesVanillaClassic[mapId]
	elseif zoneLookup == "BCC" then
		zoneInfo = annoyingPopupZonesBCC[mapId]
	elseif zoneLookup == "WoTLK" then
		zoneInfo = annoyingPopupZonesWrath[mapId]
	elseif zoneLookup == "Cata" then
		zoneInfo = annoyingPopupZonesCata[mapId]
	elseif zoneLookup == "Retail" then
		zoneInfo = annoyingPopupZonesRetail[mapId]
	end
	if zoneInfo and not DBM:DoesAddOnExist(zoneInfo.addon) then
		self:ShowAnnoyingPopup(zoneInfo, (GetInstanceInfo()))
	end
end
