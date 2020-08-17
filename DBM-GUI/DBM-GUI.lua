local L = DBM_GUI_L

DBM_GUI = {
	frameTypes = {}
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
	local function OnShowGetStats(bossid, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, top3value1, top3value2, top3value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3, bottom3value1, bottom3value2, bottom3value3)
		return function(self)
			local mod = DBM:GetModByName(bossid)
			local stats = mod.stats
			if statsType == 1 then -- Party: normal, heroic, challenge)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top3value1:SetText(stats.challengeKills)
				top3value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					top3value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					top3value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
			elseif statsType == 2 and stats.normal25Pulls and stats.normal25Pulls > 0 and stats.normal25Pulls > stats.normalPulls then -- Fix for BC instance
				top1value1:SetText(stats.normal25Kills)
				top1value2:SetText(stats.normal25Pulls - stats.normal25Kills)
				top1value3:SetText(stats.normal25BestTime and ("%d:%02d"):format(mfloor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-")
			elseif statsType == 3 then -- WoD RAID difficulty stats, TOP: Normal, LFR. BOTTOM. Heroic, Mythic
				top1value1:SetText(stats.lfr25Kills)
				top1value2:SetText(stats.lfr25Pulls - stats.lfr25Kills)
				top1value3:SetText(stats.lfr25BestTime and ("%d:%02d"):format(mfloor(stats.lfr25BestTime / 60), stats.lfr25BestTime % 60) or "-")
				top2value1:SetText(stats.normalKills)
				top2value2:SetText(stats.normalPulls - stats.normalKills)
				top2value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				bottom1value1:SetText(stats.heroicKills)
				bottom1value2:SetText(stats.heroicPulls - stats.heroicKills)
				bottom1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				bottom2value1:SetText(stats.mythicKills)
				bottom2value2:SetText(stats.mythicPulls - stats.mythicKills)
				bottom2value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
			elseif statsType == 4 then -- Party: Normal, heroic, mythic, mythic+ (Ie standard dungeons 6.2/7.x/8.x)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				bottom1value1:SetText(stats.mythicKills)
				bottom1value2:SetText(stats.mythicPulls - stats.mythicKills)
				bottom1value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
				bottom2value1:SetText(stats.challengeKills)
				bottom2value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					bottom2value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					bottom2value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
			elseif statsType == 5 then -- Party/TW Raid: Normal, TimeWalker (some normal only dungeons with timewalker such as classic)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.timewalkerKills)
				top2value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				top2value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 6 then -- Party: Heroic, TimeWalker instance (some heroic only dungeons with timewalker)
				top1value1:SetText(stats.heroicKills)
				top1value2:SetText(stats.heroicPulls-stats.heroicKills)
				top1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top2value1:SetText(stats.timewalkerKills)
				top2value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				top2value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 7 then -- Party: Normal, Heroic, TimeWalker instance (most wrath and cata dungeons). Raid: Firelands and likely Throne of Thunder when blizz adds it
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top3value1:SetText(stats.timewalkerKills)
				top3value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				top3value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 8 then -- Party: Normal, Heroic, Challenge, TimeWalker instance (Mop Dungeons. I realize CM is technically gone, but we still retain stats for users)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				bottom1value1:SetText(stats.challengeKills)
				bottom1value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					bottom1value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					bottom1value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
				bottom2value1:SetText(stats.timewalkerKills)
				bottom2value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				bottom2value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 9 then -- Party: Heroic, Challenge, TimeWalker instance (Special heroic only Mop or WoD bosses)
				top1value1:SetText(stats.heroicKills)
				top1value2:SetText(stats.heroicPulls - stats.heroicKills)
				top1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top2value1:SetText(stats.challengeKills)
				top2value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					top2value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					top2value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
				top3value1:SetText(stats.timewalkerKills)
				top3value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				top3value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 10 then -- Party: Normal, Heroic, Mythic, Mythic+, TimeWalker instance (Wod timewalking Dungeon)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top3value1:SetText(stats.mythicKills)
				top3value2:SetText(stats.mythicPulls - stats.mythicKills)
				top3value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
				bottom1value1:SetText(stats.challengeKills)
				bottom1value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					bottom1value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					bottom1value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
				bottom2value1:SetText(stats.timewalkerKills)
				bottom2value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				bottom2value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
			elseif statsType == 11 then -- Party: Mythic, Mythic+ (7.0/8.0 mythic only dungeons)
				top1value1:SetText(stats.mythicKills)
				top1value2:SetText(stats.mythicPulls - stats.mythicKills)
				top1value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
				top2value1:SetText(stats.challengeKills)
				top2value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					top2value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					top2value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
			elseif statsType == 12 then -- Party: Normal, Heroic, Mythic instance (Basically a mythic dungeon that has no challenge mode/mythic+ or an isle expedition)
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.heroicKills)
				top2value2:SetText(stats.heroicPulls - stats.heroicKills)
				top2value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top3value1:SetText(stats.mythicKills)
				top3value2:SetText(stats.mythicPulls - stats.mythicKills)
				top3value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
			elseif statsType == 13 then -- Party: Heroic, Mythic, Mythic+ instance (Karazhan, Court of Stars, Arcway 7.1.5/7.2 changes)
				top1value1:SetText(stats.heroicKills)
				top1value2:SetText(stats.heroicPulls - stats.heroicKills)
				top1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				top2value1:SetText(stats.mythicKills)
				top2value2:SetText(stats.mythicPulls - stats.mythicKills)
				top2value3:SetText(stats.mythicBestTime and ("%d:%02d"):format(mfloor(stats.mythicBestTime / 60), stats.mythicBestTime % 60) or "-")
				top3value1:SetText(stats.challengeKills)
				top3value2:SetText(stats.challengePulls - stats.challengeKills)
				if stats.challengeBestRank and stats.challengeBestRank > 0 then
					top3value3:SetText(stats.challengeBestTime and ("%d:%02d (%d)"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-", stats.challengeBestRank)
				else
					top3value3:SetText(stats.challengeBestTime and ("%d:%02d"):format(mfloor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-")
				end
			else -- Legacy 10/25 raids
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.normal25Kills)
				top2value2:SetText(stats.normal25Pulls - stats.normal25Kills)
				top2value3:SetText(stats.normal25BestTime and ("%d:%02d"):format(mfloor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-")
				top3value1:SetText(stats.timewalkerKills)
				top3value2:SetText(stats.timewalkerPulls - stats.timewalkerKills)
				top3value3:SetText(stats.timewalkerBestTime and ("%d:%02d"):format(mfloor(stats.timewalkerBestTime / 60), stats.timewalkerBestTime % 60) or "-")
				bottom1value1:SetText(stats.heroicKills)
				bottom1value2:SetText(stats.heroicPulls - stats.heroicKills)
				bottom1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				bottom2value1:SetText(stats.heroic25Kills)
				bottom2value2:SetText(stats.heroic25Pulls - stats.heroic25Kills)
				bottom2value3:SetText(stats.heroic25BestTime and ("%d:%02d"):format(mfloor(stats.heroic25BestTime / 60), stats.heroic25BestTime % 60) or "-")
			end
		end
	end

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

			local copyModProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopy, modProfileDropdown, nil, nil, function(value)
				local name, profile = strsplit("|", value)
				DBM:CopyAllModOption(addon.modId, name, tonumber(profile))
				C_Timer.After(0.05, DBM_GUI.dbm_modProfilePanel_refresh)
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
				C_Timer.After(0.10, DBM_GUI.dbm_modProfilePanel_refresh)
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
				C_Timer.After(0.10, DBM_GUI.dbm_modProfilePanel_refresh)
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
				C_Timer.After(0.05, DBM_GUI.dbm_modProfilePanel_refresh)
			end, 100)
			deleteModProfile.myheight = 60
			deleteModProfile:SetPoint("TOPLEFT", copyModSoundProfile, "BOTTOMLEFT", 0, -10)
			deleteModProfile:SetScript("OnShow", function()
				deleteModProfile.value = nil
				deleteModProfile.text = nil
				_G[deleteModProfile:GetName() .. "Text"]:SetText("")
			end)

			function DBM_GUI:dbm_modProfilePanel_refresh()
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

		local singleline = 0
		local doubleline = 0
		local area = panel:CreateArea()
		area.frame.isStats = true
		area.frame:SetPoint("TOPLEFT", 10, modProfileArea and -180 or -25)
		area.onshowcall = {}

		for _, mod in ipairs(DBM.Mods) do
			if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) and not mod.isTrashMod and not mod.noStatistics then
				local statsType = 0
				if not mod.stats then
					mod.stats = { }
				end
				local stats = mod.stats
				stats.normalKills = stats.normalKills or 0
				stats.normalPulls = stats.normalPulls or 0
				stats.heroicKills = stats.heroicKills or 0
				stats.heroicPulls = stats.heroicPulls or 0
				stats.challengeKills = stats.challengeKills or 0
				stats.challengePulls = stats.challengePulls or 0
				stats.challengeBestRank = stats.challengeBestRank or 0
				stats.mythicKills = stats.mythicKills or 0
				stats.mythicPulls = stats.mythicPulls or 0
				stats.timewalkerKills = stats.timewalkerKills or 0
				stats.timewalkerPulls = stats.timewalkerPulls or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Pulls = stats.normal25Pulls or 0
				stats.heroic25Kills = stats.heroic25Kills or 0
				stats.heroic25Pulls = stats.heroic25Pulls or 0
				stats.lfr25Kills = stats.lfr25Kills or 0
				stats.lfr25Pulls = stats.lfr25Pulls or 0

				--Create Frames
				local Title			= area:CreateText(mod.localization.general.name, nil, nil, GameFontHighlight, "LEFT")

				local top1header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 1, 1st column
				local top1text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 1, 2nd column
				local top2text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 1, 3rd column
				local top3text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top3text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top3text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top3value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				local bottom1header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 2, 1st column
				local bottom1text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 2, 2nd column
				local bottom2text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT") -- Row 2, 3rd column
				local bottom3text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				-- Set enable or disable per mods.
				if mod.addon.oneFormat then -- Classic/BC Raids, Classic dungeons that don't have heroic mode
					if mod.addon.hasTimeWalker then -- Time walking classic/BC raid (ie Black Temple)
						statsType = 5
						-- (Normal, Timewalking)
						-- Use top1 and top2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(PLAYER_DIFFICULTY1)
						top2header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
					else
						-- (Normal)
						statsType = 2 -- Fix for BC instance
						-- Do not use top1 header.
						top1text1:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 5 * singleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 5)
					end
					-- Set Dims
					singleline = singleline + 1
				elseif mod.addon.type == "PARTY" or mod.addon.type == "SCENARIO" then -- If party or scenario instance have no heroic, we should use oneFormat.
					statsType = 1
					if mod.addon.hasChallenge then -- Should never have an "Only normal" type
						if mod.onlyHeroic then
							if mod.addon.hasTimeWalker then
								statsType = 9
								-- (Heroic, Challenge, Timewalker)
								-- Use top1 and top2 and top3 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY2)
								top2header:SetText(CHALLENGE_MODE)
								top3header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
								singleline = singleline + 1
							else -- No such dungeon exists. Good thing too cause this shit is broken here
								-- (Heroic, Challenge)
								-- Use top1 and top2 area.
								top2header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top2text1:SetPoint("TOPLEFT", top2header, "BOTTOMLEFT", 20, -5)
								top2text2:SetPoint("TOPLEFT", top2text1, "BOTTOMLEFT", 0, -5)
								top2text3:SetPoint("TOPLEFT", top2text2, "BOTTOMLEFT", 0, -5)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top2header:SetText(PLAYER_DIFFICULTY2)
								top3header:SetText(CHALLENGE_MODE)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
								singleline = singleline + 1
							end
						elseif mod.onlyMythic then
							statsType = 11
							-- (Mythic, Mythic+)
							-- Use top1 and top2 area.
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
							top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
							top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
							top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							--Set header text.
							top1header:SetText(PLAYER_DIFFICULTY6)
							top2header:SetText(PLAYER_DIFFICULTY6 .. "+")
							--Set Dims
							Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
							area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
							singleline = singleline + 1
						elseif mod.addon.hasMythic then -- WoD (and later) dungeons with mythic mode (6.2+)
							if mod.addon.hasTimeWalker then
								statsType = 10
								-- (Normal, Heroic, Mythic, Mythic+, Timewalker)
								-- Use top1, top2, top3, bottom1 and bottom2 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
								bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
								bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
								bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
								bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
								bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
								bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
								bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 150, 0)
								bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 150, 0)
								bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 150, 0)
								bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 150, 0)
								bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
								bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
								bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY1)
								top2header:SetText(PLAYER_DIFFICULTY2)
								top3header:SetText(PLAYER_DIFFICULTY6)
								--Wod dungeons have same format as legion and bfa, but had a different name for the timed dungeon mode
								--This simply sets the text based on expansion assignment of mod
								if mod.addon.minExpansion < 6 then--WoD
									bottom1header:SetText(CHALLENGE_MODE)
								else--Legion and BFA
									bottom1header:SetText(PLAYER_DIFFICULTY6.. "+")
								end
								bottom2header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
								doubleline = doubleline + 1
							elseif mod.imaspecialsnowflake or mod.addon.isExpedition then -- Assault of violet Hold or island expeditions
								statsType = 12
								-- (Normal, heroic, Mythic)
								-- Use top1, top2, top3 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY1)
								top2header:SetText(PLAYER_DIFFICULTY2)
								top3header:SetText(PLAYER_DIFFICULTY6)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
								singleline = singleline + 1
							elseif mod.noNormal then -- Basically any dungeon with everything BUT normal mode (CoS, Kara, Arcway)
								statsType = 13
								-- Heroic, Mythic, Mythic+
								-- Use top1, top2, top3 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY2)
								top2header:SetText(PLAYER_DIFFICULTY6)
								top3header:SetText(PLAYER_DIFFICULTY6.. "+")
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 *singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
								singleline = singleline + 1
							else
								statsType = 4
								-- (Normal, Heroic, Mythic, Mythic+)
								-- Use top1, top2, bottom1, bottom2 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
								bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
								bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
								bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
								bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
								bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
								bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
								bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
								bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
								bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
								bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
								bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
								bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
								bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY1)
								top2header:SetText(PLAYER_DIFFICULTY2)
								bottom1header:SetText(PLAYER_DIFFICULTY6)
								bottom2header:SetText(PLAYER_DIFFICULTY6.. "+")
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
								doubleline = doubleline + 1
							end
						else
							if mod.addon.hasTimeWalker then
								statsType = 8 -- MoP dungeons
								-- (Normal, Heroic, Challenge, TimeWalker)
								-- Use top1, top2, bottom1, bottom2 area.
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
								bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
								bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
								bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
								bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
								bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
								bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
								bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
								bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
								bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
								bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
								bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
								bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
								bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY1)
								top2header:SetText(PLAYER_DIFFICULTY2)
								bottom1header:SetText(CHALLENGE_MODE)
								bottom2header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
								doubleline = doubleline + 1
							else
								-- (Normal, Heroic, Challenge)
								-- Use top1, top2 and top3 area. (Normal, Heroic, Challenge)
								top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
								top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
								top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
								top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
								top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
								top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
								top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
								top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
								top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
								top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
								top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
								top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
								top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
								top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
								top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
								top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
								top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
								top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
								top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
								top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
								top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
								-- Set header text.
								top1header:SetText(PLAYER_DIFFICULTY1)
								top2header:SetText(PLAYER_DIFFICULTY2)
								top3header:SetText(CHALLENGE_MODE)
								-- Set Dims
								Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
								area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
								singleline = singleline + 1
							end
						end
					elseif mod.onlyNormal then -- This identical to mod.addon.oneFormat but used to set certain mods to this that exist in a mod NOT using mod.addon.oneFormat mod (such as world bosses in cataclysm mods)
						if mod.addon.hasTimeWalker then
							-- Normal, Heroic (far as I know no mod is using this over oneFormat with timewalking.
							statsType = 5
							-- (Normal, TimeWalker)
							-- Use top1 and top2 area.
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
							top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
							top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
							top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top1header:SetText(PLAYER_DIFFICULTY1)
							top2header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
							-- Set Dims
							Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
							area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						else
							-- (Normal)
							-- Like one format, but for specific mods within a pack, such as cataclysm world bosses
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top1header:SetText(PLAYER_DIFFICULTY1)
							-- Set Dims
							Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 5 * singleline))
							area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 5)
						end
						singleline = singleline + 1
					elseif mod.onlyHeroic then -- Some special BC, Wrath, Cata bosses
						if mod.addon.hasTimeWalker then
							statsType = 6
							-- (Heroic, TimeWalker)
							-- Use top1 and top2 area.
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
							top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
							top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
							top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top1header:SetText(PLAYER_DIFFICULTY2)
							top2header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
						else
							-- (Heroic)
							-- Like one format
							top2header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top2text1:SetPoint("TOPLEFT", top2header, "BOTTOMLEFT", 20, -5)
							top2text2:SetPoint("TOPLEFT", top2text1, "BOTTOMLEFT", 0, -5)
							top2text3:SetPoint("TOPLEFT", top2text2, "BOTTOMLEFT", 0, -5)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top2header:SetText(PLAYER_DIFFICULTY2)
						end
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					else -- Dungeons that are Normal, Heroic
						if mod.addon.hasTimeWalker then
							statsType = 7
							-- (Normal, Heroic, TimeWalker)
							-- Use top1 and top2 and top 3 area.
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
							top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
							top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
							top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
							top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
							top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
							top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
							top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
							top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
							top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top1header:SetText(PLAYER_DIFFICULTY1)
							top2header:SetText(PLAYER_DIFFICULTY2)
							top3header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
						else
							-- (Normal, Heroic)
							-- Use top1 and top2 area.
							top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
							top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
							top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
							top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
							top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
							top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
							top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
							top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
							top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
							top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
							top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
							top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
							top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
							top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
							-- Set header text.
							top1header:SetText(PLAYER_DIFFICULTY1)
							top2header:SetText(PLAYER_DIFFICULTY2)
						end
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					end
				elseif mod.addon.type == "RAID" and mod.addon.noHeroic and not mod.addon.hasMythic then -- Early wrath
					if mod.addon.hasTimeWalker then -- Timewalking wrath raid like Ulduar
						-- (10 Player, 25 Player, TimeWalker)
						-- Use top1 and top2 and top 3 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
						top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
						top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
						top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
						top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
						top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
						top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						top3header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
					else
						-- (10 Player, 25 Player)
						-- Use top1 and top2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
					end
					-- Set Dims
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
					area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
					singleline = singleline + 1
				elseif mod.addon.type == "RAID" and not mod.addon.hasLFR and not mod.addon.hasMythic then -- Cata(except DS) and some wrath raids (ICC, ToGC)
					if mod.addon.hasTimeWalker then--Firelands
						statsType = 7
						-- (Normal, Heroic, TimeWalker)
						-- Use top1 and top2 and top 3 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
						top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
						top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
						top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
						top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
						top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
						top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(PLAYER_DIFFICULTY1)
						top2header:SetText(PLAYER_DIFFICULTY2)
						top3header:SetText(PLAYER_DIFFICULTY_TIMEWALKER)
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					elseif mod.onlyHeroic then -- Sinestra & Ra-den
						-- Use top1, top2 area
						bottom1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						bottom1header:SetText(RAID_DIFFICULTY3)
						bottom1header:SetFontObject(GameFontHighlightSmall)
						bottom2header:SetText(RAID_DIFFICULTY4)
						bottom2header:SetFontObject(GameFontHighlightSmall)
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					elseif mod.onlyNormal then -- Used?
						-- (10 Player, 25 Player)
						-- Use top1, top2 area
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					else
						-- (10 Player, 25 Player, 10 Player Heroic, 25 Player Heroic)
						-- Use top1, top2, bottom1 and bottom2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						bottom1header:SetText(RAID_DIFFICULTY3)
						bottom2header:SetText(RAID_DIFFICULTY4)
						-- Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
						doubleline = doubleline + 1
					end
				elseif mod.addon.type == "RAID" and not mod.addon.hasMythic then -- DS + All MoP raids(except SoO)
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
					if mod.onlyHeroic then--Ra-den
						-- (Heroic 10, Heroic 25)
						-- Use top1, top2 area
						bottom1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 150, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 150, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 150, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 150, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						bottom1header:SetText(RAID_DIFFICULTY3)
						bottom1header:SetFontObject(GameFontHighlightSmall)
						bottom2header:SetText(RAID_DIFFICULTY4)
						bottom2header:SetFontObject(GameFontHighlightSmall)
						-- Set Dims
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 6)
						singleline = singleline + 1
					else
						-- Normal 10, Normal 25, Heroic 10, Heroic 25, LFR
						-- Use top1, top2, top3, bottom1 and bottom2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 150, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 150, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 150, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 150, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						top3header:SetPoint("LEFT", top2header, "LEFT", 150, 0)
						top3text1:SetPoint("LEFT", top2text1, "LEFT", 150, 0)
						top3text2:SetPoint("LEFT", top2text2, "LEFT", 150, 0)
						top3text3:SetPoint("LEFT", top2text3, "LEFT", 150, 0)
						top3value1:SetPoint("TOPLEFT", top3text1, "TOPLEFT", 80, 0)
						top3value2:SetPoint("TOPLEFT", top3text2, "TOPLEFT", 80, 0)
						top3value3:SetPoint("TOPLEFT", top3text3, "TOPLEFT", 80, 0)
						bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 150, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 150, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 150, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 150, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						top3header:SetText(PLAYER_DIFFICULTY3)
						bottom1header:SetText(RAID_DIFFICULTY3)
						bottom2header:SetText(RAID_DIFFICULTY4)
						-- Set Dims
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
						doubleline = doubleline + 1
					end
				else -- WoD Zone
					statsType = 3
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10 - (L.FontHeight * 6 * singleline) - (L.FontHeight * 10 * doubleline))
					if mod.onlyMythic then -- Future use
						--Mythic Only, unused
						bottom2header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						bottom2text1:SetPoint("TOPLEFT", bottom2header, "BOTTOMLEFT", 20, -5)
						bottom2text2:SetPoint("TOPLEFT", bottom2text1, "BOTTOMLEFT", 0, -5)
						bottom2text3:SetPoint("TOPLEFT", bottom2text2, "BOTTOMLEFT", 0, -5)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						bottom2header:SetText(PLAYER_DIFFICULTY6) -- Mythic
						bottom2header:SetFontObject(GameFontHighlightSmall)
						-- Set Dims
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
						singleline = singleline + 1
					else
						-- Normal, Heroic, Mythic, LFR
						-- Use top1, top2, bottom1 and bottom2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						-- Set header text.
						top1header:SetText(PLAYER_DIFFICULTY3) -- Raid Finder
						top2header:SetText(PLAYER_DIFFICULTY1) -- Normal
						bottom1header:SetText(PLAYER_DIFFICULTY2) -- Heroic
						bottom1header:SetFontObject(GameFontHighlightSmall)
						bottom2header:SetText(PLAYER_DIFFICULTY6) -- Mythic
						bottom2header:SetFontObject(GameFontHighlightSmall)
						-- Set Dims
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight * 10)
						doubleline = doubleline + 1
					end
				end

				table.insert(area.onshowcall, OnShowGetStats(mod.id, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, top3value1, top3value2, top3value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3, bottom3value1, bottom3value2, bottom3value3))
			end
		end
		area.frame:SetScript("OnShow", function(self)
			for _, v in pairs(area.onshowcall) do
				v()
			end
		end)
		_G["DBM_GUI_OptionsFrame"]:DisplayFrame(panel.frame)
	end

	local Categories = {}
	local subTabId = 0

	function DBM_GUI:UpdateModList()
		for _, addon in ipairs(DBM.AddOns) do
			if not Categories[addon.category] then
				-- Create a Panel for "Wrath of the Lich King" "Burning Crusade" ...
				local expLevel = GetExpansionLevel()
				if expLevel == 8 then--Choose default expanded category based on players current expansion is.
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "SHADOWLANDS"))
				elseif expLevel == 7 then--Choose default expanded category based on players current expansion is.
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "BFA"))
				elseif expLevel == 6 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "LEG"))
				elseif expLevel == 5 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "WOD"))
				elseif expLevel == 4 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "MOP"))
				elseif expLevel == 3 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "CATA"))
				elseif expLevel == 2 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "WotLK"))
				elseif expLevel == 1 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "BC"))
				else
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_" .. addon.category:upper()] or L.TabCategory_OTHER, nil, (addon.category:upper() == "CLASSIC"))
				end
				if L["TabCategory_" .. addon.category:upper()] then
					local ptext = Categories[addon.category]:CreateText(L["TabCategory_" .. addon.category:upper()])
					ptext:SetPoint("TOPLEFT", Categories[addon.category].frame, "TOPLEFT", 10, -10)
				end
			end

			if not addon.panel then
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				if addon.optionsTab then
					addon.panel = DBM_GUI:CreateNewPanel(addon.modId or "Error: No-modId", addon.optionsTab, true, nil, addon.name)
				else
					addon.panel = Categories[addon.category]:CreateNewPanel(addon.modId or "Error: No-modId", nil, false, nil, addon.name)
				end

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
