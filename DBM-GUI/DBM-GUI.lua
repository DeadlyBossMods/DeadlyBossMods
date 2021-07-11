local L = DBM_GUI_L

DBM_GUI = {
	tabs	= {},
	panels	= {}
}

local next, type, pairs, strsplit, tonumber, tostring, ipairs, tinsert, tsort, mfloor = next, type, pairs, strsplit, tonumber, tostring, ipairs, table.insert, table.sort, math.floor
local CreateFrame, C_Timer, GetExpansionLevel, IsAddOnLoaded, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall, ChatFontNormal, UIParent = CreateFrame, C_Timer, GetExpansionLevel, IsAddOnLoaded, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall, ChatFontNormal, UIParent
local RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, CLOSE, SPECIALIZATION = RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, CLOSE, SPECIALIZATION
local LibStub, DBM, DBM_GUI, DBM_OPTION_SPACER = _G["LibStub"], DBM, DBM_GUI, DBM_OPTION_SPACER
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
					if v2.value == v then
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
					-- Only insert paths from addons folder, ignore file data ID, since there is no clean way to handle supporitng both FDID and soundkit at same time
					elseif mediatype == "sound" and type(v) == "string" and v:lower():find("addons") then
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
		popupFrame = CreateFrame("Frame", nil, UIParent, DBM:IsShadowlands() and "BackdropTemplate")
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
		if DBM:IsShadowlands() then
			popupFrame:ApplyBackdrop()
		else
			popupFrame:SetBackdrop(popupFrame.backdropInfo)
		end
		popupFrame:SetMovable(true)
		popupFrame:EnableMouse(true)
		popupFrame:RegisterForDrag("LeftButton")
		popupFrame:SetScript("OnDragStart", popupFrame.StartMoving)
		popupFrame:SetScript("OnDragStop", popupFrame.StopMovingOrSizing)
		popupFrame:Hide()
		popupFrame.text = ""

		local backdrop = CreateFrame("Frame", nil, popupFrame, DBM:IsShadowlands() and "BackdropTemplate")
		backdrop.backdropInfo = {
			bgFile		= "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border",
			tile		= true,
			tileSize	= 16,
			edgeSize	= 16,
			insets		= { left = 3, right = 3, top = 5, bottom = 3 }
		}
		if DBM:IsShadowlands() then
			backdrop:ApplyBackdrop()
		else
			backdrop:SetBackdrop(backdrop.backdropInfo)
		end
		backdrop:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
		backdrop:SetBackdropBorderColor(0.4, 0.4, 0.4)
		backdrop:SetPoint("TOPLEFT", 15, -15)
		backdrop:SetPoint("BOTTOMRIGHT", -40, 40)

		local scrollFrame = CreateFrame("ScrollFrame", "TestScrollFrame", popupFrame, "UIPanelScrollFrameTemplate")
		scrollFrame:SetPoint("TOPLEFT", 15, -22)
		scrollFrame:SetPoint("BOTTOMRIGHT", -40, 45)

		local input = CreateFrame("EditBox", "TestEditBox", scrollFrame)
		input:SetTextInsets(7, 7, 3, 3)
		input:SetFontObject(ChatFontNormal)
		input:SetMultiLine(true)
		input:EnableMouse(true)
		input:SetAutoFocus(false)
		input:SetMaxBytes(nil)
		input:SetScript("OnMouseUp", input.HighlightText)
		input:SetScript("OnEscapePressed", input.ClearFocus)
		input:HighlightText()
		input:SetFocus()
		scrollFrame:SetScrollChild(input)
		input:ClearAllPoints()
		input:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT")
		input:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT")
		input:SetWidth(452)

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

function DBM_GUI:ShowHide(forceshow)
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
		end
		if		i == 1 then		icon:SetTexCoord(0,		0.25,	0,		0.25)
		elseif	i == 2 then		icon:SetTexCoord(0.25,	0.5,	0,		0.25)
		elseif	i == 3 then		icon:SetTexCoord(0.5,	0.75,	0,		0.25)
		elseif	i == 4 then		icon:SetTexCoord(0.75,	1,		0,		0.25)
		elseif	i == 5 then		icon:SetTexCoord(0,		0.25,	0.25,	0.5)
		elseif	i == 6 then		icon:SetTexCoord(0.25,	0.5,	0.25,	0.5)
		elseif	i == 7 then		icon:SetTexCoord(0.5,	0.75,	0.25,	0.5)
		elseif	i == 8 then		icon:SetTexCoord(0.75,	1,		0.25,	0.5)
		end
	end

	local reset = panel:CreateButton(L.Mod_Reset, 155, 30, nil, GameFontNormalSmall)
	reset.myheight = 40
	reset:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", -24, -4)
	reset:SetScript("OnClick", function(self)
		DBM:LoadModDefaultOption(mod)
	end)
	local button = panel:CreateCheckButton(L.Mod_Enabled, true)
	button:SetChecked(mod.Options.Enabled)
	button:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 8, -14)
	button:SetScript("OnClick", function(self)
		mod:Toggle()
	end)

	local scannedCategories = {}
	for _, catident in pairs(mod.categorySort) do
		category = mod.optionCategories[catident]
		if not scannedCategories[catident] and category then
			scannedCategories[catident] = true
			local catpanel = panel:CreateArea(mod.localization.cats[catident])
			local catbutton, lastButton, addSpacer
			for _, v in ipairs(category) do
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
						catbutton:SetScript("OnClick", function(self)
							mod.Options[v] = not mod.Options[v]
							if mod.optionFuncs and mod.optionFuncs[v] then
								mod.optionFuncs[v]()
							end
						end)
					elseif mod.buttons and mod.buttons[v] then
						local but = mod.buttons[v]
						catbutton = catpanel:CreateButton(v, but.width, but.height, but.onClick, but.fontObject)
					elseif mod.editboxes and mod.editboxes[v] then
						local editBox = mod.editboxes[v]
						catbutton = catpanel:CreateEditBox(mod.localization.options[v], "", editBox.width, editBox.height)
						catbutton:SetScript("OnShow", function(self)
							catbutton:SetText(mod.Options[v])
						end)
						catbutton:SetScript("OnEnterPressed", function(self)
							if mod.optionFuncs and mod.optionFuncs[v] then
								mod.optionFuncs[v]()
							end
						end)
					elseif mod.sliders and mod.sliders[v] then
						local slider = mod.sliders[v]
						catbutton = catpanel:CreateSlider(mod.localization.options[v], slider.minValue, slider.maxValue, slider.valueStep)
						catbutton:SetScript("OnShow", function(self)
							self:SetValue(mod.Options[v])
						end)
						catbutton:HookScript("OnValueChanged", function(self)
							if mod.optionFuncs and mod.optionFuncs[v] then
								mod.optionFuncs[v]()
							end
						end)
					elseif mod.dropdowns and mod.dropdowns[v] then
						local dropdownOptions = {}
						for _, val in ipairs(mod.dropdowns[v]) do
							dropdownOptions[#dropdownOptions + 1] = {
								text	= mod.localization.options[val],
								value	= val
							}
						end
						catbutton = catpanel:CreateDropdown(mod.localization.options[v], dropdownOptions, mod, v, function(value)
							mod.Options[v] = value
							if mod.optionFuncs and mod.optionFuncs[v] then
								mod.optionFuncs[v]()
							end
						end, nil, 32)
						if not addSpacer then
							catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -10)
						end
					end
					if addSpacer then
						catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -6)
						addSpacer = false
					end
				end
			end
		end
	end
end

do
	local function CreateBossModTab(addon, panel, subtab)
		if not panel then
			error("Panel is nil", 2)
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
				local profileID = playerLevel > 9 and DBM_UseDualProfile and (GetSpecialization() or 1) or 0
				for _, id in ipairs(DBM.ModLists[addon.modId]) do
					_G[addon.modId:gsub("-", "") .. "_AllSavedVars"][playerName .. "-" .. realmName][id][profileID] = importTable[id]
					DBM:GetModByName(id).Options = importTable[id]
				end
				DBM:AddMsg("Profile imported.")
			end

			local importExportProfilesArea = panel:CreateArea(L.Area_ImportExportProfile)
			importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true)
			local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
				local exportProfile = {}
				local profileID = playerLevel > 9 and DBM_UseDualProfile and (GetSpecialization() or 1) or 0
				for _, id in ipairs(DBM.ModLists[addon.modId]) do
					exportProfile[id] = _G[addon.modId:gsub("-", "") .. "_AllSavedVars"][playerName .. "-" .. realmName][id][profileID]
				end
				DBM_GUI:CreateExportProfile(exportProfile)
			end)
			exportProfile:SetPoint("TOPLEFT", 12, -20)
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
			importProfile.myheight = 0
			importProfile:SetPoint("LEFT", exportProfile, "RIGHT", 2, 0)
		end

		if addon.noStatistics then
			return
		end

		local ptext = panel:CreateText(L.BossModLoaded:format(subtab and addon.subTabs[subtab] or addon.name), nil, nil, GameFontNormal)
		ptext:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 10, modProfileArea and -235 or -10)

		local singleLine, doubleLine, noHeaderLine = 0, 0, 0
		local area = panel:CreateArea()
		area.frame.isStats = true
		area.frame:SetPoint("TOPLEFT", 10, modProfileArea and -250 or -25)

		local statOrder = {
			"lfr", "normal", "normal25", "heroic", "heroic25", "mythic", "challenge", "timewalker"
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

				local Title			= area:CreateText(mod.localization.general.name, nil, nil, GameFontHighlight, "LEFT")

				local function CreateText(text, header)
					local frame = area:CreateText(text or "", nil, nil, header and GameFontHighlightSmall or GameFontNormalSmall, "LEFT")
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
					lfr25		= PLAYER_DIFFICULTY3,
					normal		= mod.addon.minExpansion < 5 and RAID_DIFFICULTY1 or PLAYER_DIFFICULTY1,
					normal25	= RAID_DIFFICULTY2,
					heroic		= mod.addon.minExpansion < 5 and RAID_DIFFICULTY3 or PLAYER_DIFFICULTY2,
					heroic25	= RAID_DIFFICULTY4,
					mythic		= PLAYER_DIFFICULTY6,
					challenge	= mod.addon.minExpansion < 6 and CHALLENGE_MODE or (PLAYER_DIFFICULTY6 .. "+"),
					timewalker	= PLAYER_DIFFICULTY_TIMEWALKER
				}
				if (mod.addon.type == "PARTY" or mod.addon.type == "SCENARIO") or -- Fixes dungeons being labled incorrectly
					(mod.addon.type == "RAID" and statSplit["timewalker"]) or -- Fixes raids with timewalker being labled incorrectly
					(mod.addon.modId == "DBM-SiegeOfOrgrimmarV2") then -- Fixes SoO being labled incorrectly
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
						area.frame:HookScript("OnShow", function()
							local kills, pulls, bestRank, bestTime = mod.stats[statType .. "Kills"] or 0, mod.stats[statType .. "Pulls"] or 0, mod.stats[statType .. "BestRank"] or 0, mod.stats[statType .. "BestTime"]
							section.value1:SetText(kills)
							section.value2:SetText(pulls - kills)
							if statType == "challenge" and bestRank > 0 then
								section.value3:SetText(bestTime and ("%d:%02d (%d)"):format(mfloor(bestTime / 60), bestTime % 60) or "-", bestRank)
							else
								section.value3:SetText(bestTime and ("%d:%02d"):format(mfloor(bestTime / 60), bestTime % 60) or "-")
							end
						end)
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
		_G["DBM_GUI_OptionsFrame"]:DisplayFrame(panel.frame)
	end

	local category = {}
	local subTabId = 0
	local expansions = {
		"CLASSIC", "BC", "WOTLK", "CATA", "MOP", "WOD", "LEG", "BFA", "SHADOWLANDS"
	}

	function DBM_GUI:UpdateModList()
		for _, addon in ipairs(DBM.AddOns) do
			local cat = addon.category:upper()
			if not category[cat] then
				category[cat] = DBM_GUI:CreateNewPanel(_G["EXPANSION_NAME" .. (tIndexOf(expansions, cat) or 99) - 1] or L.TabCategory_OTHER, nil, cat == expansions[GetExpansionLevel() + 1])
			end

			if not addon.panel then
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				addon.panel = category[cat]:CreateNewPanel(addon.name or "Error: No-modId")

				if not IsAddOnLoaded(addon.modId) then
					local button = addon.panel:CreateButton(L.Button_LoadMod, 200, 30)
					button.modid = addon
					button.headline = addon.panel:CreateText(L.BossModLoad_now, 350)
					button.headline:SetHeight(50)
					button.headline:SetPoint("CENTER", button, "CENTER", 0, 80)

					button:SetScript("OnClick", function(self)
						if DBM:LoadMod(self.modid, true) then
							self:Hide()
							self.headline:Hide()
							CreateBossModTab(self.modid, self.modid.panel)
						end
					end)
					button:SetPoint("CENTER", 0, -20)
				else
					CreateBossModTab(addon, addon.panel)
				end
			end

			if addon.panel and addon.subTabs and IsAddOnLoaded(addon.modId) then
				-- Create a Panel for "Arachnid Quarter" "Plague Quarter" ...
				if not addon.subPanels then
					addon.subPanels = {}
				end

				for k, v in pairs(addon.subTabs) do
					if not addon.subPanels[k] then
						subTabId = subTabId + 1
						addon.subPanels[k] = addon.panel:CreateNewPanel("SubTab" .. subTabId, nil, false, nil, v)
						CreateBossModTab(addon, addon.subPanels[k], k)
					end
				end
			end

			for _, mod in ipairs(DBM.Mods) do
				if mod.modId == addon.modId then
					if not mod.panel and (not addon.subTabs or (addon.subPanels and addon.subPanels[mod.subTab])) then
						if addon.subTabs and addon.subPanels[mod.subTab] then
							mod.panel = addon.subPanels[mod.subTab]:CreateNewPanel(mod.id or "Error: DBM.Mods", addon.optionsTab, nil, nil, mod.localization.general.name)
						else
							mod.panel = addon.panel:CreateNewPanel(mod.id or "Error: DBM.Mods", addon.optionsTab, nil, nil, mod.localization.general.name)
						end
						DBM_GUI:CreateBossModPanel(mod)
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
