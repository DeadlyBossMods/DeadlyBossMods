local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = {
	tabs	= {},
	panels	= {}
}
_G.DBM_GUI = DBM_GUI

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local next, type, pairs, strsplit, tonumber, tostring, ipairs, tinsert, tsort, mfloor, slower = next, type, pairs, strsplit, tonumber, tostring, ipairs, table.insert, table.sort, math.floor, string.lower
local CreateFrame, C_Timer, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall, ChatFontNormal, UIParent = CreateFrame, C_Timer, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall, ChatFontNormal, UIParent
local RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, CLOSE, SPECIALIZATION = RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, CLOSE, SPECIALIZATION
local DBM, DBM_OPTION_SPACER = DBM, DBM_OPTION_SPACER
local playerName, realmName, playerLevel = UnitName("player"), GetRealmName(), UnitLevel("player")

StaticPopupDialogs["IMPORTPROFILE_ERROR"] = {
	text = "There are one or more errors importing this profile. Please see the chat for more information. Would you like to continue and reset found errors to default?",
	button1 = "Import and fix",
	button2 = "No",
	OnAccept = function(self)
		self.importFunc()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

local challengeModeIds = {
	[2] = 960, -- Temple of the Jade Serpent
	[56] = 961, -- Stormstout Brewery
	[57] = 962, -- Gate of the Setting Sun
	[58] = 959, -- Shado-Pan Monastery
	[59] = 1011, -- Siege of Niuzao Temple
	[60] = 994, -- Mogu'shan Palace
	[76] = 1007, -- Scholomance
	[77] = 1001, -- Scarlet Halls
	[78] = 1004, -- Scarlet Monastery
	[161] = 1209, -- Skyreach
	[163] = 1175, -- Bloodmaul Slag Mines
	[164] = 1182, -- Auchindoun
	[165] = 1176, -- Shadowmoon Burial Grounds
	[166] = 1208, -- Grimrail Depot
	[167] = 1358, -- Upper Blackrock Spire
	[168] = 1279, -- The Everbloom
	[169] = 1195, -- Iron Docks
	[197] = 1456, -- Eye of Azshara
	[198] = 1466, -- Darkheart Thicket
	[199] = 1501, -- Black Rook Hold
	[200] = 1477, -- Halls of Valor
	[206] = 1458, -- Neltharion's Lair
	[207] = 1493, -- Vault of the Wardens
	[208] = 1492, -- Maw of Souls
	[209] = 1516, -- The Arcway
	[210] = 1571, -- Court of Stars
	[227] = 1651, -- Return to Karazhan: Lower
	[233] = 1677, -- Cathedral of Eternal Night
	[234] = 1651, -- Return to Karazhan: Upper
	[239] = 1753, -- Seat of the Triumvirate
	[244] = 1763, -- Atal'Dazar
	[245] = 1754, -- Freehold
	[246] = 1771, -- Tol Dagor
	[247] = 1594, -- The MOTHERLODE!!
	[248] = 1862, -- Waycrest Manor
	[249] = 1762, -- Kings' Rest
	[250] = 1877, -- Temple of Sethraliss
	[251] = 1841, -- The Underrot
	[252] = 1864, -- Shrine of the Storm
	[353] = 1822, -- Siege of Boralus
	[369] = 2097, -- Operation: Mechagon - Junkyard
	[370] = 2097, -- Operation: Mechagon - Workshop
	[375] = 2290, -- Mists of Tirna Scithe
	[376] = 2286, -- The Necrotic Wake
	[377] = 2291, -- De Other Side
	[378] = 2287, -- Halls of Atonement
	[379] = 2289, -- Plaguefall
	[380] = 2284, -- Sanguine Depths
	[381] = 2285, -- Spires of Ascension
	[382] = 2293, -- Theater of Pain
	[391] = 2441, -- Tazavesh: Streets of Wonder
	[392] = 2441, -- Tazavesh: So'leah's Gambit
	[399] = 2521, -- Ruby Life Pools
	[400] = 2516, -- The Nokhud Offensive
	[401] = 2515, -- The Azure Vault
	[402] = 2526, -- Algeth'ar Academy
	[403] = 2451, -- Uldaman: Legacy of Tyr
	[404] = 2519, -- Neltharus
	[405] = 2520, -- Brackenhide Hollow
	[406] = 2527, -- Halls of Infusion
	[438] = 657, -- The Vortex Pinnacle
	[456] = 643, -- Throne of the Tides
	[463] = 2579, -- Dawn of the Infinite: Galakrond's Fall
	[464] = 2579, -- Dawn of the Infinite: Murozond's Rise
	[499] = 2649, -- Priory of the Sacred Flame
	[500] = 2648, -- The Rookery
	[501] = 2652, -- The Stonevault
	[502] = 2669, -- City of Threads
	[503] = 2660, -- Ara-Kara, City of Echoes
	[504] = 2651, -- Darkflame Cleft
	[505] = 2662, -- The Dawnbreaker
	[506] = 2661, -- Cinderbrew Meadery
	[507] = 670, -- Grim Batol
}

do
	local soundsRegistered = false

	function DBM_GUI:MixinSharedMedia3(mediatype, mediatable)
		if not LibStub or not LibStub("LibSharedMedia-3.0", true) then
			return mediatable
		end
		if not soundsRegistered then
			local LSM = LibStub("LibSharedMedia-3.0")
			soundsRegistered = true
			-- Embedded Sound Clip media
			LSM:Register("sound", "AirHorn (DBM)", [[Interface\AddOns\DBM-Core\sounds\AirHorn.ogg]])
			LSM:Register("sound", "Jaina: Beware", [[Interface\AddOns\DBM-Core\sounds\SoundClips\beware.ogg]])
			LSM:Register("sound", "Jaina: Beware (reverb)", [[Interface\AddOns\DBM-Core\sounds\SoundClips\beware_with_reverb.ogg]])
			LSM:Register("sound", "Thrall: That's Incredible!", [[Interface\AddOns\DBM-Core\sounds\SoundClips\incredible.ogg]])
			LSM:Register("sound", "Saurfang: Don't Die", [[Interface\AddOns\DBM-Core\sounds\SoundClips\dontdie.ogg]])
			-- Blakbyrd
			LSM:Register("sound", "Blakbyrd Alert 1", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert1.ogg]])
			LSM:Register("sound", "Blakbyrd Alert 2", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert2.ogg]])
			LSM:Register("sound", "Blakbyrd Alert 3", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert3.ogg]])
			-- User Media
			if DBM.Options.CustomSounds >= 1 then
				LSM:Register("sound", "DBM: Custom 1", [[Interface\AddOns\DBM-CustomSounds\Custom1.ogg]])
			end
			if DBM.Options.CustomSounds >= 2 then
				LSM:Register("sound", "DBM: Custom 2", [[Interface\AddOns\DBM-CustomSounds\Custom2.ogg]])
			end
			if DBM.Options.CustomSounds >= 3 then
				LSM:Register("sound", "DBM: Custom 3", [[Interface\AddOns\DBM-CustomSounds\Custom3.ogg]])
			end
			if DBM.Options.CustomSounds >= 4 then
				LSM:Register("sound", "DBM: Custom 4", [[Interface\AddOns\DBM-CustomSounds\Custom4.ogg]])
			end
			if DBM.Options.CustomSounds >= 5 then
				LSM:Register("sound", "DBM: Custom 5", [[Interface\AddOns\DBM-CustomSounds\Custom5.ogg]])
			end
			if DBM.Options.CustomSounds >= 6 then
				LSM:Register("sound", "DBM: Custom 6", [[Interface\AddOns\DBM-CustomSounds\Custom6.ogg]])
			end
			if DBM.Options.CustomSounds >= 7 then
				LSM:Register("sound", "DBM: Custom 7", [[Interface\AddOns\DBM-CustomSounds\Custom7.ogg]])
			end
			if DBM.Options.CustomSounds >= 8 then
				LSM:Register("sound", "DBM: Custom 8", [[Interface\AddOns\DBM-CustomSounds\Custom8.ogg]])
			end
			if DBM.Options.CustomSounds >= 9 then
				LSM:Register("sound", "DBM: Custom 9", [[Interface\AddOns\DBM-CustomSounds\Custom9.ogg]])
				if DBM.Options.CustomSounds > 9 then
					DBM.Options.CustomSounds = 9
				end
			end
		end
		-- Sort LibSharedMedia keys alphabetically (case-insensitive)
		local hashtable = LibStub("LibSharedMedia-3.0", true):HashTable(mediatype)
		local keytable = {}
		for k in next, hashtable do
			tinsert(keytable, k)
		end
		tsort(keytable, function(a, b)
			return a:lower() < b:lower()
		end);
		-- DBM values (mediatable) first, LibSharedMedia values (sorted alphabetically) afterwards
		local result = mediatable
		for i = 1, #result do
			if mediatype == "statusbar" then
				result[i].texture = true
			elseif mediatype == "font" then
				result[i].font = true
			elseif mediatype == "sound" then
				result[i].sound = true
			end
		end
		for i = 1, #keytable do
			if mediatype ~= "sound" or (keytable[i] ~= "None" and keytable[i] ~= "NPCScan") then
				local v = hashtable[keytable[i]]
				-- Filter duplicates
				local insertme = true
				for _, v2 in next, result do
					if slower(v2.value) == slower(v) then
						insertme = false
						break
					end
				end
				if insertme then
					local ins = {
						text	= keytable[i],
						value	= v
					}
					if mediatype == "statusbar" then
						ins.texture = true
					elseif mediatype == "font" then
						ins.font = true
					elseif mediatype == "sound" then--and type(v) == "string" and v:lower():find("addons")
						ins.sound = true
					end
					if ins.texture or ins.font or ins.sound then
						tinsert(result, ins)
					end
				end
			end
		end
		return result
	end
end

do
	local LibSerialize = LibStub("LibSerialize")
	local LibDeflate = LibStub("LibDeflate")

	local canWeWork = LibStub and LibStub("LibDeflate", true) and LibStub("LibSerialize", true)
	local popupFrame

	local function createPopupFrame()
		---@class DBMPopupFrame: Frame, BackdropTemplate
		popupFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
		popupFrame:SetFrameStrata("DIALOG")
		popupFrame:SetFrameLevel(popupFrame:GetFrameLevel() + 10)
		popupFrame:SetSize(512, 512)
		popupFrame:SetPoint("CENTER")
		popupFrame.backdropInfo = {
			bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
			edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
			tile		= true,
			tileSize	= 32,
			edgeSize	= 32,
			insets		= { left = 8, right = 8, top = 8, bottom = 8 }
		}
		popupFrame:ApplyBackdrop()
		popupFrame:SetMovable(true)
		popupFrame:EnableMouse(true)
		popupFrame:RegisterForDrag("LeftButton")
		popupFrame:SetScript("OnDragStart", popupFrame.StartMoving)
		popupFrame:SetScript("OnDragStop", popupFrame.StopMovingOrSizing)
		popupFrame:Hide()
		popupFrame.text = ""

		---@class DBMPopupFrameBackdrop: Frame, BackdropTemplate
		local backdrop = CreateFrame("Frame", nil, popupFrame, "BackdropTemplate")
		backdrop.backdropInfo = {
			bgFile		= "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border",
			tile		= true,
			tileSize	= 16,
			edgeSize	= 16,
			insets		= { left = 3, right = 3, top = 5, bottom = 3 }
		}
		backdrop:ApplyBackdrop()
		backdrop:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
		backdrop:SetBackdropBorderColor(0.4, 0.4, 0.4)
		backdrop:SetPoint("TOPLEFT", 15, -15)
		backdrop:SetPoint("BOTTOMRIGHT", -40, 40)

		---@class DBMPopupFrameScrollFrame: ScrollFrame
		local scrollFrame = CreateFrame("ScrollFrame", nil, popupFrame, "UIPanelScrollFrameTemplate")
		scrollFrame:SetPoint("TOPLEFT", 15, -22)
		scrollFrame:SetPoint("BOTTOMRIGHT", -40, 45)

		local input = CreateFrame("EditBox", nil, scrollFrame)
		input:SetTextInsets(7, 7, 3, 3)
		input:SetFontObject(ChatFontNormal)
		input:SetMultiLine(true)
		input:EnableMouse(true)
		input:SetAutoFocus(false)
		input:SetMaxBytes(0)
		input:SetScript("OnMouseUp", function(self)
			self:HighlightText()
		end)
		input:SetScript("OnEscapePressed", function(self)
			self:ClearFocus()
		end)
		input:HighlightText()
		input:SetFocus()
		scrollFrame:SetScrollChild(input)
		input:ClearAllPoints()
		input:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT")
		input:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT")
		input:SetWidth(452)

		---@class DBMPopupFrameImportButton: Button
		local import = CreateFrame("Button", nil, popupFrame, "UIPanelButtonTemplate")
		import:SetPoint("BOTTOMRIGHT", -120, 13)
		import:SetFrameLevel(import:GetFrameLevel() + 1)
		import:SetSize(100, 20)
		import:SetText(L.Import)
		import:SetScript("OnClick", function()
			if popupFrame:VerifyImport(input:GetText()) then
				input:ClearFocus()
				popupFrame:Hide()
			end
		end)
		popupFrame.import = import

		local close = CreateFrame("Button", nil, popupFrame, "UIPanelButtonTemplate")
		close:SetPoint("LEFT", import, "RIGHT", 5, 0)
		close:SetFrameLevel(close:GetFrameLevel() + 1)
		close:SetSize(100, 20)
		close:SetText(CLOSE)
		close:SetScript("OnClick", function()
			input:ClearFocus()
			popupFrame:Hide()
		end)

		input:SetScript("OnChar", function()
			if not import:IsShown() then
				input:SetText(popupFrame.text)
				input:HighlightText()
			end
		end)

		function popupFrame:SetText(text)
			input:SetText(text)
			self.text = text
		end
	end

	function DBM_GUI:CreateExportProfile(export)
		if not canWeWork then
			DBM:AddMsg("Missing required libraries to export.")
			return
		end
		if not popupFrame then
			createPopupFrame()
		end
		popupFrame.import:Hide()
		popupFrame:SetText(LibDeflate:EncodeForPrint(LibDeflate:CompressDeflate(LibSerialize:Serialize(export), {level = 9})))
		popupFrame:Show()
	end

	function DBM_GUI:CreateImportProfile(importFunc)
		if not canWeWork then
			DBM:AddMsg("Missing required libraries to export.")
			return
		end
		if not popupFrame then
			createPopupFrame()
		end
		function popupFrame:VerifyImport(import)
			local success, deserialized = LibSerialize:Deserialize(LibDeflate:DecompressDeflate(LibDeflate:DecodeForPrint(import)))
			if not success then
				DBM:AddMsg("Failed to deserialize")
				return false
			end
			importFunc(deserialized)
			return true
		end
		popupFrame.import:Show()
		popupFrame:SetText("")
		popupFrame:Show()
	end
end

do
	local framecount = 0

	function DBM_GUI:GetNewID()
		framecount = framecount + 1
		return framecount
	end

	function DBM_GUI:GetCurrentID()
		return framecount
	end
end

local UpdateCurrentSeason
local firstLoad = true
function DBM_GUI:ShowHide(forceshow)
	if firstLoad then
		UpdateCurrentSeason()
		firstLoad = false
	end
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if forceshow == true then
		self:UpdateModList()
		optionsFrame:Show()
	elseif forceshow == false then
		optionsFrame:Hide()
	else
		if optionsFrame:IsShown() then
			optionsFrame:Hide()
		else
			self:UpdateModList()
			optionsFrame:Show()
		end
	end
end

local catbutton, lastButton, addSpacer
local function addOptions(mod, catpanel, v)
	if v == DBM_OPTION_SPACER then
		addSpacer = true
	else
		lastButton = catbutton
		if v.line then
			catbutton = catpanel:CreateLine(v.text)
		elseif type(mod.Options[v]) == "boolean" then
			if mod.Options[v .. "TColor"] then
				catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true, nil, nil, nil, mod, v, nil, true)
			elseif mod.Options[v .. "SWSound"] then
				catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true, nil, nil, nil, mod, v)
			else
				catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true)
			end
			catbutton:SetScript("OnShow", function(self)
				self:SetChecked(mod.Options[v])
			end)
			catbutton:SetScript("OnClick", function()
				mod.Options[v] = not mod.Options[v]
				if mod.optionFuncs and mod.optionFuncs[v] then
					mod.optionFuncs[v]()
				end
			end)
		elseif mod.dropdowns and mod.dropdowns[v] then
			local dropdownOptions = {}
			for _, val in ipairs(mod.dropdowns[v]) do
				tinsert(dropdownOptions, {
					text	= mod.localization.options[val],
					value	= val
				})
			end
			catbutton = catpanel:CreateDropdown(mod.localization.options[v], dropdownOptions, mod, v, function(value)
				mod.Options[v] = value
				if mod.optionFuncs and mod.optionFuncs[v] then
					mod.optionFuncs[v]()
				end
			end, nil, 32)
			if not addSpacer then
				if lastButton then
					catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -12)
				else
					catbutton:SetPoint("TOPLEFT", catpanel:GetLastObj(), "BOTTOMLEFT", -14, -18)
				end
			end
		end
		if addSpacer then
			catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -6)
			addSpacer = false
		end
	end
end

function DBM_GUI:CreateBossModPanel(mod)
	if not mod.panel then
		DBM:AddMsg("Couldn't create boss mod panel for " .. mod.localization.general.name)
		return false
	end
	local panel = mod.panel
	local category

	local iconstat = panel.frame:CreateFontString("DBM_GUI_Mod_Icons" .. mod.localization.general.name, "ARTWORK")
	iconstat:SetPoint("TOP", panel.frame, 0, -10)
	iconstat:SetFontObject(GameFontNormal)
	iconstat:SetText(L.IconsInUse)
	for i = 1, 8 do
		local icon = panel.frame:CreateTexture()
		icon:SetTexture(137009) -- "Interface\\TargetingFrame\\UI-RaidTargetingIcons.blp"
		icon:SetPoint("TOP", panel.frame, 81 - (i * 18), -26)
		icon:SetSize(16, 16)
		if not mod.usedIcons or not mod.usedIcons[i] then
			icon:SetAlpha(0.25)
			icon:SetDesaturated(true)
		end
		if		i == 1 then		icon:SetTexCoord(0,		0.25,	0,		0.25)
		elseif	i == 2 then		icon:SetTexCoord(0.25,	0.5,	0,		0.25)
		elseif	i == 3 then		icon:SetTexCoord(0.5,	0.75,	0,		0.25)
		elseif	i == 4 then		icon:SetTexCoord(0.75,	1,		0,		0.25)
		elseif	i == 5 then		icon:SetTexCoord(0,		0.25,	0.25,	0.5)
		elseif	i == 6 then		icon:SetTexCoord(0.25,	0.5,	0.25,	0.5)
		elseif	i == 7 then		icon:SetTexCoord(0.5,	0.75,	0.25,	0.5)
		elseif	i == 8 then		icon:SetTexCoord(0.75,	1,		0.25,	0.5)
--		elseif	i == 9 then		icon:SetTexCoord(0,		0.25,	0.5,	0.75)
--		elseif	i == 10 then	icon:SetTexCoord(0.25,	0.5,	0.5,	0.75)
--		elseif	i == 11 then	icon:SetTexCoord(0.5,	0.75,	0.5,	0.75)
--		elseif	i == 12 then	icon:SetTexCoord(0.75,	1,		0.5,	0.75)
--		elseif	i == 13 then	icon:SetTexCoord(0,		0.25,	0.75,	1)
--		elseif	i == 14 then	icon:SetTexCoord(0.25,	0.5,	0.75,	1)
--		elseif	i == 15 then	icon:SetTexCoord(0.5,	0.75,	0.75,	1)
--		elseif	i == 16 then	icon:SetTexCoord(0.75,	1,		0.75,	1)
		end
	end

	local reset = panel:CreateButton(L.Mod_Reset, 155, 30, nil, GameFontNormalSmall)
	reset.myheight = 40
	reset:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", -24, -4)
	reset:SetScript("OnClick", function()
		DBM:LoadModDefaultOption(mod)
	end)
	local button = panel:CreateCheckButton(L.Mod_Enabled:format("|n|cFFFFFFFF" .. mod.localization.general.name), true)
	button:SetChecked(mod.Options.Enabled)
	button:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 8, -14)
	button:SetScript("OnClick", function()
		mod:Toggle()
	end)
	button.textObj:ClearAllPoints()
	button.textObj:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 2)

	if mod.addon then
		for spellID, options in getmetatable(mod.groupOptions).__pairs(mod.groupOptions) do
			if spellID:find("^line") then
				panel:CreateLine(options)
			else
				local title, desc, _, icon
				local usedSpellID, hasPrivate
				if mod.groupOptions[spellID] and mod.groupOptions[spellID].customKeys then
					usedSpellID = mod.groupOptions[spellID].customKeys--Color coding would be done in customKeys, not here
				end
				if mod.groupOptions[spellID] and mod.groupOptions[spellID].hasPrivate then
					hasPrivate = true
				end
				if mod.groupOptions[spellID].title then--Custom title, it's a bogus spellId, so we completely ignore it and bundle with localized custom title
					title, desc, icon = mod.groupOptions[spellID].title, L.CustomOptions, 136116
				elseif tonumber(spellID) then
					spellID = tonumber(spellID)
					if spellID then--Because LuaLS doesn't understand tonumber(spellID) as a nil check
						if spellID < 0 then
							title, desc, _, icon = DBM:EJ_GetSectionInfo(-spellID)
						else
							local _title = DBM:GetSpellName(spellID)
							if _title then
								title, desc, icon = _title, tonumber(spellID), DBM:GetSpellTexture(spellID or 0)
							end
						end
					end
				elseif spellID:find("^ej") then
					title, desc, _, icon = DBM:EJ_GetSectionInfo(spellID:gsub("ej", ""))
				elseif spellID:find("^at") then
					_, title, _, _, _, _, _, desc, _, icon = GetAchievementInfo(spellID:gsub("at", ""))
					if not title then--Core has debug for spell and EJ, but this calls WoW API directly
						DBM:Debug("|cffff0000Invalid call to GetAchievementInfo for achievementID: |r"..spellID:gsub("at", ""))
					end
				end
				if not title then--Spell/EJ section/achievement not found - typo/removed/ptr or beta mod on live
					title, desc, icon = spellID, L.NoDescription, 136116
				end
				if not usedSpellID then
					usedSpellID = "|Hgarrmission:DBM:wacopy:"..spellID.."|h|cff69ccf0"..spellID.."|r|h"
				end
				local catpanel = panel:CreateAbility(title, icon, usedSpellID, hasPrivate)
				if desc then
					catpanel:CreateSpellDesc(desc)
				end
				catbutton, lastButton, addSpacer = nil, nil, nil
				for _, v in ipairs(options) do
					addOptions(mod, catpanel, v)
				end
			end
		end
	end

	local scannedCategories = {}
	for _, catident in pairs(mod.categorySort) do
		category = mod.optionCategories[catident]
		if not scannedCategories[catident] and category then
			scannedCategories[catident] = true
			local catpanel = panel:CreateArea(mod.localization.cats[catident])
			catbutton, lastButton, addSpacer = nil, nil, nil
			for _, v in ipairs(category) do
				addOptions(mod, catpanel, v)
			end
		end
	end
end

local function GetSpecializationGroup()
	if isRetail then
		return GetSpecialization() or 1
	else
		local numTabs = GetNumTalentTabs()
		local highestPointsSpent, currentSpecGroup = 0, 1
		if MAX_TALENT_TABS then
			for i=1, MAX_TALENT_TABS do
				if ( i <= numTabs ) then
					local _, _, pointsSpent = GetTalentTabInfo(i)
					if pointsSpent > highestPointsSpent then
						highestPointsSpent = pointsSpent
						currentSpecGroup = i
					end
				end
			end
		end
		return currentSpecGroup
	end
end

function DBM_GUI:CreateBossModTab(addon, panel, subtab)
	if not panel then
		error("Panel is nil", 2)
	end

	if panel.loadButton then
		panel.loadButton:Hide()
		panel.loadButton.headline:Hide()
	end

	local modProfileArea
	if not subtab then
		local modProfileDropdown = {}
		modProfileArea = panel:CreateArea(L.Area_ModProfile)
		modProfileArea.frame:SetPoint("TOPLEFT", 10, -25)
		local resetButton = modProfileArea:CreateButton(L.ModAllReset, 200, 20)
		resetButton:SetPoint("TOPLEFT", 10, -14)
		resetButton:SetScript("OnClick", function()
			DBM:LoadAllModDefaultOption(addon.modId)
		end)
		for charname, charTable in pairs(_G[addon.modId:gsub("-", "") .. "_AllSavedVars"] or {}) do
			for _, optionTable in pairs(charTable) do
				if type(optionTable) == "table" then
					for i = 0, 4 do
						if optionTable[i] then
							tinsert(modProfileDropdown, {
								text	= (i == 0 and charname .. " (" .. ALL.. ")") or charname .. " (" .. SPECIALIZATION .. i .. "-" .. (charTable["talent" .. i] or "") .. ")",
								value	= charname .. "|" .. tostring(i)
							})
						end
					end
					break
				end
			end
		end

		local resetStatButton = modProfileArea:CreateButton(L.ModAllStatReset, 200, 20)
		resetStatButton.myheight = 0
		resetStatButton:SetPoint("LEFT", resetButton, "RIGHT", 40, 0)
		resetStatButton:SetScript("OnClick", function()
			DBM:ClearAllStats(addon.modId)
		end)

		local refresh

		local copyModProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopy, modProfileDropdown, nil, nil, function(value)
			local name, profile = strsplit("|", value)
			DBM:CopyAllModOption(addon.modId, name, tonumber(profile))
			C_Timer.After(0.05, refresh)
		end, 100)
		copyModProfile:SetPoint("TOPLEFT", -7, -54)
		copyModProfile:SetScript("OnShow", function()
			copyModProfile.value = nil
			copyModProfile.text = nil
			_G[copyModProfile:GetName() .. "Text"]:SetText("")
		end)

		local copyModSoundProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopySound, modProfileDropdown, nil, nil, function(value)
			local name, profile = strsplit("|", value)
			DBM:CopyAllModTypeOption(addon.modId, name, tonumber(profile), "SWSound")
			C_Timer.After(0.05, refresh)
		end, 100)
		copyModSoundProfile.myheight = 0
		copyModSoundProfile:SetPoint("LEFT", copyModProfile, "RIGHT", 27, 0)
		copyModSoundProfile:SetScript("OnShow", function()
			copyModSoundProfile.value = nil
			copyModSoundProfile.text = nil
			_G[copyModSoundProfile:GetName() .. "Text"]:SetText("")
		end)

		local copyModNoteProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopyNote, modProfileDropdown, nil, nil, function(value)
			local name, profile = strsplit("|", value)
			DBM:CopyAllModTypeOption(addon.modId, name, tonumber(profile), "SWNote")
			C_Timer.After(0.05, refresh)
		end, 100)
		copyModNoteProfile.myheight = 0
		copyModNoteProfile:SetPoint("LEFT", copyModSoundProfile, "RIGHT", 27, 0)
		copyModNoteProfile:SetScript("OnShow", function()
			copyModNoteProfile.value = nil
			copyModNoteProfile.text = nil
			_G[copyModNoteProfile:GetName() .. "Text"]:SetText("")
		end)

		local deleteModProfile = modProfileArea:CreateDropdown(L.SelectModProfileDelete, modProfileDropdown, nil, nil, function(value)
			local name, profile = strsplit("|", value)
			DBM:DeleteAllModOption(addon.modId, name, tonumber(profile))
			C_Timer.After(0.05, refresh)
		end, 100)
		deleteModProfile.myheight = 60
		deleteModProfile:SetPoint("TOPLEFT", copyModSoundProfile, "BOTTOMLEFT", 0, -10)
		deleteModProfile:SetScript("OnShow", function()
			deleteModProfile.value = nil
			deleteModProfile.text = nil
			_G[deleteModProfile:GetName() .. "Text"]:SetText("")
		end)

		function refresh()
			copyModProfile:GetScript("OnShow")()
			copyModSoundProfile:GetScript("OnShow")()
			copyModNoteProfile:GetScript("OnShow")()
			deleteModProfile:GetScript("OnShow")()
		end

		-- Start import/export
		local function actuallyImport(importTable)
			local profileID = playerLevel > 9 and DBM_UseDualProfile and GetSpecializationGroup() or 0
			for _, id in ipairs(DBM.ModLists[addon.modId]) do
				_G[addon.modId:gsub("-", "") .. "_AllSavedVars"][playerName .. "-" .. realmName][id][profileID] = importTable[id]
				---@diagnostic disable-next-line: inject-field
				DBM:GetModByName(id).Options = importTable[id]
			end
			DBM:AddMsg("Profile imported.")
		end

		local importExportProfilesArea = panel:CreateArea(L.Area_ImportExportProfile)
		local importExportText = importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true)
		local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
			local exportProfile = {}
			local profileID = playerLevel > 9 and DBM_UseDualProfile and GetSpecializationGroup() or 0
			for _, id in ipairs(DBM.ModLists[addon.modId]) do
				exportProfile[id] = _G[addon.modId:gsub("-", "") .. "_AllSavedVars"][playerName .. "-" .. realmName][id][profileID]
			end
			DBM_GUI:CreateExportProfile(exportProfile)
		end)
		exportProfile:SetPoint("TOPLEFT", importExportText, "BOTTOMLEFT", 0, -12)
		local importProfile = importExportProfilesArea:CreateButton(L.ButtonImportProfile, 120, 20, function()
			DBM_GUI:CreateImportProfile(function(importTable)
				local errors = {}
				for id, table in pairs(importTable) do
					-- Check if sound packs are missing
					for settingName, settingValue in pairs(table) do
						local ending = settingName:sub(-6):lower()
						if ending == "cvoice" or ending == "wsound" then -- CVoice or SWSound (s is ignored so we only have to sub once)
							if type(settingValue) == "string" and settingValue:lower() ~= "none" and not DBM:ValidateSound(settingValue, true, true) then
								tinsert(errors, id .. "-" .. settingName)
							end
						end
					end
				end
				-- Create popup confirming if they wish to continue (and therefor resetting to default)
				if #errors > 0 then
					local popup = StaticPopup_Show("IMPORTPROFILE_ERROR")
					if popup then
						popup.importFunc = function()
							local modOptions = {}
							for _, soundSetting in ipairs(errors) do
								local modID, settingName = soundSetting:match("([^-]+)-([^-]+)")
								if not modOptions[modID] then
									modOptions[modID] = DBM:GetModByName(modID).DefaultOptions
								end
								importTable[modID][settingName] = modOptions[modID][settingName]
							end
							actuallyImport(importTable)
						end
					end
				else
					actuallyImport(importTable)
				end
			end)
		end)
		importProfile.myheight = 12
		importProfile:SetPoint("LEFT", exportProfile, "RIGHT", 2, 0)
	end

	if addon.noStatistics then
		return
	end

	local ptext = panel:CreateText(L.BossModLoaded:format(subtab and addon.subTabs[subtab] or addon.name), nil, nil, nil, "CENTER")
	ptext:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 10, modProfileArea and -255 or -10)

	local singleLine, doubleLine, noHeaderLine = 0, 0, 0
	local area = panel:CreateArea()
	area.frame.isStats = true
	area.frame:SetPoint("TOPLEFT", 10, modProfileArea and -270 or -25)

	local statOrder = {
		"follower", "story", "lfr", "normal", "normal25", "heroic", "heroic25", "mythic", "challenge", "timewalker"
	}

	for _, mod in ipairs(DBM.Mods) do
		if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) and not mod.isTrashMod and not mod.noStatistics then
			if not mod.stats then
				mod.stats = {}
			end

			--Create Frames
			local statSplit, statCount = {}, 0
			for stat in (mod.statTypes or mod.addon.statTypes):gmatch("%s?([^%s,]+)%s?,?") do
				statSplit[stat] = true
				statCount = statCount + 1
			end

			if statCount == 0 then
				DBM:AddMsg("No statTypes available for " .. mod.modId)
				return -- No stats available for this? Possibly a bug
			end

			local Title			= area:CreateText(mod.localization.general.name, nil, nil, GameFontHighlight)

			local function CreateText(text, header)
				local frame = area:CreateText(text or "", nil, nil, header and GameFontHighlightSmall or GameFontNormalSmall)
				frame:Hide()
				return frame
			end

			local sections = {}
			for i = 1, 6 do
				local section = {}
				section.header	= CreateText(nil, true)
				section.text1	= CreateText(L.Statistic_Kills)
				section.text2	= CreateText(L.Statistic_Wipes)
				section.text3	= CreateText(L.Statistic_BestKill)
				section.value1	= CreateText()
				section.value2	= CreateText()
				section.value3	= CreateText()
				if i == 1 then
					section.header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
				elseif i == 4 then
					section.header:SetPoint("TOPLEFT", sections[1].text3, "BOTTOMLEFT", -20, -5)
				else
					section.header:SetPoint("LEFT", sections[i - 1].header, "LEFT", 150, 0)
				end
				section.text1:SetPoint("TOPLEFT", section.header, "BOTTOMLEFT", 20, -5)
				section.text2:SetPoint("TOPLEFT", section.text1, "BOTTOMLEFT", 0, -5)
				section.text3:SetPoint("TOPLEFT", section.text2, "BOTTOMLEFT", 0, -5)
				section.value1:SetPoint("TOPLEFT", section.text1, "TOPLEFT", 80, 0)
				section.value2:SetPoint("TOPLEFT", section.text2, "TOPLEFT", 80, 0)
				section.value3:SetPoint("TOPLEFT", section.text3, "TOPLEFT", 80, 0)
				section.header.OldSetText = section.header.SetText
				section.header.SetText = function(self, text)
					self:OldSetText(text)
					self:Show()
					section.text1:Show()
					section.text2:Show()
					section.text3:Show()
					section.value1:Show()
					section.value2:Show()
					section.value3:Show()
				end
				sections[i] = section
			end

			local statTypes = {
				follower	= L.FOLLOWER,--no PLAYER_DIFFICULTY entry yet
				story		= L.STORY,--no PLAYER_DIFFICULTY entry yet
				lfr25		= PLAYER_DIFFICULTY3,
				normal		= mod.addon.minExpansion < 5 and RAID_DIFFICULTY1 or PLAYER_DIFFICULTY1,
				normal25	= RAID_DIFFICULTY2,
				heroic		= mod.addon.minExpansion < 5 and RAID_DIFFICULTY3 or PLAYER_DIFFICULTY2,
				heroic25	= RAID_DIFFICULTY4,
				mythic		= PLAYER_DIFFICULTY6,
				challenge	= (mod.addon.minExpansion < 6 and not mod.upgradedMPlus) and CHALLENGE_MODE or PLAYER_DIFFICULTY6 .. "+",
				timewalker	= PLAYER_DIFFICULTY_TIMEWALKER
			}
			if (mod.addon.type == "PARTY" or mod.addon.type == "SCENARIO") or -- Fixes dungeons being labled incorrectly
				(mod.addon.type == "RAID" and statSplit["timewalker"]) or -- Fixes raids with timewalker being labled incorrectly
				(mod.instanceId == 369) then -- Fixes SoO being labled incorrectly
				statTypes.normal = PLAYER_DIFFICULTY1
				statTypes.heroic = PLAYER_DIFFICULTY2
			end

			local lastArea = 0

			for _, statType in ipairs(statOrder) do
				if statSplit[statType] then
					if statType == "lfr" then
						statType = "lfr25" -- Because Myst stores stats weird
					end
					if lastArea == 2 and statCount == 4 then -- Use top1, top2, bottom1, bottom2
						lastArea = 3
					end
					lastArea = lastArea + 1
					local section = sections[lastArea]
					section.header:SetText(statTypes[statType])
					local kills, pulls, bestRank, bestTime = mod.stats[statType .. "Kills"] or 0, mod.stats[statType .. "Pulls"] or 0, mod.stats[statType .. "BestRank"] or 0, mod.stats[statType .. "BestTime"]
					section.value1:SetText(kills)
					section.value2:SetText(pulls - kills)
					if bestRank > 0 then--Used by "challenge" and "normal" for M+, Delves, and SoD raids
						section.value3:SetText(bestTime and ("%d:%02d (%d)"):format(mfloor(bestTime / 60), bestTime % 60, bestRank) or "-")
					else
						section.value3:SetText(bestTime and ("%d:%02d"):format(mfloor(bestTime / 60), bestTime % 60) or "-")
					end
				end
			end
			Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 5 * noHeaderLine) - (L.FontHeight * 6 * singleLine) - (L.FontHeight * 10 * doubleLine))
			if statCount == 1 then
				sections[1].header:Hide()
				sections[1].text1:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
				noHeaderLine = noHeaderLine + 1
				area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 5)
			elseif statCount < 4 then
				singleLine = singleLine + 1
				area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
			else
				doubleLine = doubleLine + 1
				area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
			end
		end
	end
end
do
	local subTabId = 0

	local cachedAddOns = {}
	local C_AddOns = {
		DoesAddOnExist = C_AddOns.DoesAddOnExist or function(addon)
			if not cachedAddOns then
				for i = 1, GetNumAddOns() do ---@diagnostic disable-line:deprecated
				cachedAddOns[GetAddOnInfo(i)] = true ---@diagnostic disable-line:deprecated
				end
			end
			return cachedAddOns[addon]
		end,
	}

	local currentSeasons = {}
	function UpdateCurrentSeason()
		if not C_ChallengeMode or not C_ChallengeMode.GetMapTable then
			return
		end
		local seasonCategory = DBM_GUI:CreateNewPanel(L.TabCategory_CURRENT_SEASON, "PARTY")
		local seasonCategoryTab = DBM_GUI.tabs[3].buttons[#DBM_GUI.tabs[3].buttons]
		local hasAnyMod = false
		for _, challengeMap in ipairs(C_ChallengeMode.GetMapTable()) do
			local challengeMode = challengeModeIds[challengeMap]
			local id = challengeMode
			--For handling zones like Warfront: Arathi - Alliance
			local mapName = GetRealZoneText(id):trim() or id
			for w in string.gmatch(mapName, " - ") do
				if w:trim() ~= "" then
					mapName = w
					break
				end
			end
			if not currentSeasons[mapName] then
				local modId
				for _, addon in ipairs(DBM.AddOns) do
					if addon.modId ~= "DBM-Affixes" and addon.type == "PARTY" then
						for _, mapId in ipairs(addon.mapId) do
							if mapId == id then
								modId = addon.modId
								break
							end
						end
					end
				end
				if modId then
					currentSeasons[mapName] = seasonCategory:CreateNewPanel(mapName, "PARTY", false, nil, true, modId, true)
					hasAnyMod = true
				end
			end
		end
		if C_AddOns.DoesAddOnExist("DBM-Affixes") then
			local affixAddon
			for _, addon in ipairs(DBM.AddOns) do
				if addon.modId == "DBM-Affixes" then
					affixAddon = addon
					break
				end
			end
			if affixAddon then
				currentSeasons["MPlusAffixes"] = seasonCategory:CreateNewPanel("MPlusAffixes", "PARTY", false, affixAddon.name, false, "DBM-Affixes", true)
				hasAnyMod = true
			end
		end
		if not hasAnyMod then
			seasonCategoryTab.hidden = true
		end
	end

    local expansions = {"CLASSIC", "BC", "WOTLK", "CATA", "MOP", "WOD", "LEG", "BFA", "SHADOWLANDS", "DRAGONFLIGHT", "WARWITHIN"}

	-- WotLK compat, search for "local C_AddOns" in DBM-Core.lua for more details
	local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded or IsAddOnLoaded ---@diagnostic disable-line:deprecated
	function DBM_GUI:UpdateModList()
		for _, addon in ipairs(DBM.AddOns) do
			if not addon.panel then
				local customName
				--Auto truncate Raid, Dungeon, and World boss mods to only display expansion name in list
				if addon.type == "RAID" or addon.type == "PARTY" or addon.type == "WORLDBOSS" then
					customName = _G["EXPANSION_NAME" .. (tIndexOf(expansions, addon.category:upper()) or 99) - 1]
				end
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				addon.panel = DBM_GUI:CreateNewPanel(addon.name or "Error: No-modId", addon.type, false, customName, true, addon.modId)
				if addon.modId == "DBM-Affixes" then -- If affixes, hide second general entry (as it's under Current Season)
					DBM_GUI.tabs[3].buttons[#DBM_GUI.tabs[3].buttons].hidden = true
				end

				if not IsAddOnLoaded(addon.modId) then
					local button = addon.panel:CreateButton(L.Button_LoadMod, 200, 30)
					button.addon = addon
					button.headline = addon.panel:CreateText(L.BossModLoad_now, 350, nil, nil, "CENTER")
					button.headline:SetHeight(50)
					button.headline:SetPoint("CENTER", button, "CENTER", 0, 80)

					button:SetScript("OnClick", function(self)
						DBM:LoadMod(self.addon, true)
					end)
					button:SetPoint("CENTER", 0, -20)
					addon.panel.loadButton = button
				else
					DBM_GUI:CreateBossModTab(addon, addon.panel)
				end
			end

			if addon.panel and addon.subTabs and IsAddOnLoaded(addon.modId) then
				if not addon.subPanels then
					addon.subPanels = {}
				end

				for k, v in pairs(addon.subTabs) do
					if not addon.subPanels[k] then
						subTabId = subTabId + 1
						addon.subPanels[k] = currentSeasons[v] or addon.panel:CreateNewPanel("SubTab" .. subTabId, addon.type, false, v, addon.modId)
						DBM_GUI:CreateBossModTab(addon, addon.subPanels[k], k)
					end
				end
			end

			for _, v in ipairs(DBM.Mods) do
				---@class DBMMod
				local mod = v
				if mod.modId == addon.modId then
					if not mod.panel and (not addon.subTabs or (addon.subPanels and (addon.subPanels[mod.subTab] or mod.subTab == 0))) then
						if addon.subTabs and addon.subPanels[mod.subTab] then
							mod.panel = addon.subPanels[mod.subTab]:CreateNewPanel(mod.id or "Error: DBM.Mods", addon.type, nil, mod.localization.general.name)
						else
							mod.panel = currentSeasons[mod.id] or addon.panel:CreateNewPanel(mod.id or "Error: DBM.Mods", addon.type, nil, mod.localization.general.name)
						end
					end
				end
			end
		end
		local optionsFrame = _G["DBM_GUI_OptionsFrame"]
		if optionsFrame:IsShown() then
			optionsFrame:Hide()
			optionsFrame:Show()
		end
	end
end
