local L = DBM_GUI_L

DBM_GUI = {
	tabs = {}
}

local next, type, pairs, strsplit, tonumber, tostring, ipairs, tinsert, tsort, mfloor = next, type, pairs, strsplit, tonumber, tostring, ipairs, table.insert, table.sort, math.floor
local C_Timer, GetExpansionLevel, IsAddOnLoaded, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall = C_Timer, GetExpansionLevel, IsAddOnLoaded, GameFontNormal, GameFontNormalSmall, GameFontHighlight, GameFontHighlightSmall
local RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, SPECIALIZATION = RAID_DIFFICULTY1, RAID_DIFFICULTY2, RAID_DIFFICULTY3, RAID_DIFFICULTY4, PLAYER_DIFFICULTY1, PLAYER_DIFFICULTY2, PLAYER_DIFFICULTY3, PLAYER_DIFFICULTY6, PLAYER_DIFFICULTY_TIMEWALKER, CHALLENGE_MODE, ALL, SPECIALIZATION
local LibStub, DBM, DBM_GUI, DBM_OPTION_SPACER = _G["LibStub"], DBM, DBM_GUI, DBM_OPTION_SPACER

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
		local keytable = {}
		for k in next, LibStub("LibSharedMedia-3.0", true):HashTable(mediatype) do
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
				local v = LibStub("LibSharedMedia-3.0", true):HashTable(mediatype)[keytable[i]]
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

do
	local frames = {}

	function DBM_GUI:AddFrame(name)
		tinsert(frames, name)
	end

	function DBM_GUI:IsPresent(name)
		for _, v in ipairs(frames) do
			if v == name then
				return true
			end
		end
		return false
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
		end

		if addon.noStatistics then
			return
		end

		local ptext = panel:CreateText(L.BossModLoaded:format(subtab and addon.subTabs[subtab] or addon.name), nil, nil, GameFontNormal)
		ptext:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 10, modProfileArea and -165 or -10)

		local singleLine, doubleLine, noHeaderLine = 0, 0, 0
		local area = panel:CreateArea()
		area.frame.isStats = true
		area.frame:SetPoint("TOPLEFT", 10, modProfileArea and -180 or -25)

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
		[0] = "CLASSIC",
		"BC", "WotLK", "CATA", "MOP", "WOD", "LEG", "BFA", "SHADOWLANDS"
	}

	function DBM_GUI:UpdateModList()
		for _, addon in ipairs(DBM.AddOns) do
			if not category[addon.category] then
				category[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, addon.category:upper() == expansions[GetExpansionLevel()])
			end

			if not addon.panel then
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				addon.panel = category[addon.category]:CreateNewPanel(addon.name or "Error: No-modId")

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
