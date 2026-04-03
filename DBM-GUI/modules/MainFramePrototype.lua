local L = DBM_GUI_L

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
local isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)

---@class DBMGUI
local DBM_GUI = DBM_GUI

local DDM
if isWrath then
	DDM = LibStub:GetLibrary("LibDropDownMenu")
end

local select, ipairs, mfloor, mmax, mmin = select, ipairs, math.floor, math.max, math.min
local strlower, strgsub, tsort, tconcat = string.lower, string.gsub, table.sort, table.concat
local CreateFrame, GameFontNormal, C_Timer = CreateFrame, GameFontNormal, C_Timer
local DBM = DBM

---@class DBMOptionsFrame: Frame
---@field tabs table
---@field searchClearButton Button
---@field searchCountText FontString
---@field LoadAndShowFrame fun(self: DBMOptionsFrame, subFrame: Frame)
local frame = CreateFrame("Frame", "DBM_GUI_OptionsFrame", UIParent, "NineSlicePanelTemplate")

local selectedPagePerTab = {}
local searchTextCache = {}

local function truncateTextWithEllipsis(fontString, text, maxWidth)
	text = text or ""
	fontString:SetText(text)
	if fontString:GetStringWidth() <= maxWidth then
		return text
	end

	local chars = {}
	for ch in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		chars[#chars + 1] = ch
	end
	if #chars == 0 then
		return text
	end

	local ellipsis = "..."
	fontString:SetText(ellipsis)
	if fontString:GetStringWidth() > maxWidth then
		return ""
	end

	local best = ellipsis
	local low, high = 1, #chars
	while low <= high do
		local mid = math.floor((low + high) / 2)
		local candidate = table.concat(chars, "", 1, mid) .. ellipsis
		fontString:SetText(candidate)
		if fontString:GetStringWidth() <= maxWidth then
			best = candidate
			low = mid + 1
		else
			high = mid - 1
		end
	end

	return best
end

local function normalizeSearchText(text)
	if not text then
		return ""
	end
	if DBM:issecretvalue(text) then
		return ""
	end
	local ok, normalized = pcall(function(value)
		value = tostring(value)
		value = strgsub(value, "|c%x%x%x%x%x%x%x%x", "")
		value = strgsub(value, "|r", "")
		value = strgsub(value, "|T.-|t", " ")
		value = strgsub(value, "|H.-|h(.-)|h", "%1")
		value = strgsub(value, "<.->", " ")
		value = strgsub(value, "%s+", " ")
		return strlower(value:match("^%s*(.-)%s*$") or "")
	end, text)
	if ok and normalized then
		return normalized
	end
	return ""
end

local function safeGetText(control)
	if not control or not control.GetText then
		return nil
	end
	local ok, text = pcall(control.GetText, control)
	if ok and not DBM:issecretvalue(text) then
		return text
	end
	return nil
end


local function appendSearchText(parts, text)
	local normalized = normalizeSearchText(text)
	if normalized ~= "" then
		parts[#parts + 1] = normalized
	end
end

local function appendControlSearchText(parts, control)
	appendSearchText(parts, control.text)
	appendSearchText(parts, safeGetText(control.textObj))
	appendSearchText(parts, safeGetText(control))
	if control.GetName then
		local name = control:GetName()
		if name then
			local textRegion = _G[name .. "Text"]
			appendSearchText(parts, safeGetText(textRegion))
			local titleRegion = _G[name .. "Title"]
			appendSearchText(parts, safeGetText(titleRegion))
			local titleTextRegion = _G[name .. "TitleText"]
			appendSearchText(parts, safeGetText(titleTextRegion))
		end
	end
	for _, region in ipairs({ control:GetRegions() }) do
		if region.GetObjectType and region:GetObjectType() == "FontString" then
			appendSearchText(parts, safeGetText(region))
		end
	end
end

local function collectFrameSearchText(targetFrame, parts, visited, entries)
	if not targetFrame or visited[targetFrame] then
		return
	end
	visited[targetFrame] = true
	appendSearchText(parts, targetFrame.displayName)
	appendSearchText(parts, targetFrame.modId)

	appendControlSearchText(parts, targetFrame)

	for _, child in ipairs({ targetFrame:GetChildren() }) do
		local childParts = {}
		appendControlSearchText(childParts, child)
		if #childParts > 0 then
			local childText = tconcat(childParts, "\n")
			parts[#parts + 1] = childText
			entries[#entries + 1] = {
				control = child,
				text = childText
			}
		end
		collectFrameSearchText(child, parts, visited, entries)
	end
end

local function getFrameSearchData(targetFrame)
	if searchTextCache[targetFrame] then
		return searchTextCache[targetFrame]
	end
	local parts, entries = {}, {}
	collectFrameSearchText(targetFrame, parts, {}, entries)
	searchTextCache[targetFrame] = {
		fullText = tconcat(parts, "\n"),
		entries = entries
	}
	return searchTextCache[targetFrame]
end

function frame:InvalidateSearchCache(targetFrame)
	searchTextCache[targetFrame] = nil
end

local function updateAbilityToggleTexture(abilityFrame)
	local toggleButton = _G[abilityFrame:GetName() .. "Button"]
	if toggleButton and toggleButton.toggle then
		toggleButton.toggle:SetNormalTexture(abilityFrame.hidden and 130838 or 130821) -- "Interface\\Buttons\\UI-PlusButton-UP", "Interface\\Buttons\\UI-MinusButton-UP"
		toggleButton.toggle:SetPushedTexture(abilityFrame.hidden and 130836 or 130820) -- "Interface\\Buttons\\UI-PlusButton-DOWN", "Interface\\Buttons\\UI-MinusButton-DOWN"
	end
end

local function expandParentsForControl(targetFrame, control)
	local parent = control and control:GetParent()
	local changed = false
	while parent and parent ~= targetFrame do
		if parent.mytype == "ability" and parent.hidden then
			parent.hidden = false
			updateAbilityToggleTexture(parent)
			changed = true
		end
		parent = parent:GetParent()
	end
	return changed
end

function frame:SetSearchQuery(query)
	query = normalizeSearchText(query)
	if self.searchQuery == query then
		return
	end
	self.searchQuery = query
	local listFrame = _G[self:GetName() .. "List"]
	if listFrame then
		listFrame.offset = 0
		local scrollBar = _G[listFrame:GetName() .. "ScrollBar"]
		if scrollBar and scrollBar.SetValue then
			scrollBar:SetValue(0)
		end
	end
	self:UpdateMenuFrame()
end

function frame:SetSearchStatus(searching, count)
	if self.searchClearButton then
		self.searchClearButton:SetShown(searching)
	end
	if self.searchCountText then
		if searching then
			count = count or 0
			if count == 1 then
				self.searchCountText:SetText(L.SearchMatch:format(count))
			else
				self.searchCountText:SetText(L.SearchMatches:format(count))
			end
		else
			self.searchCountText:SetText("")
		end
	end
end

function frame:IsFrameSearchable(targetFrame, tabId)
	if tabId == DBM_GUI.Enums.Tabs.CORE or tabId == DBM_GUI.Enums.Tabs.TOOLS then
		return true
	end
	-- Only index frames once their UI has actually been built to avoid caching empty results
	if targetFrame.isLoaded then
		return true
	end
	if targetFrame.addonId and C_AddOns and C_AddOns.IsAddOnLoaded then
		-- Addon is loaded but only index the frame once it has child controls
		return C_AddOns.IsAddOnLoaded(targetFrame.addonId) and select("#", targetFrame:GetChildren()) > 0
	end
	return select("#", targetFrame:GetChildren()) > 0
end

function frame:GetSearchResults()
	local query = self.searchQuery
	if not query or query == "" then
		return nil
	end
	local results, seen = {}, {}
	for tabId, tabData in ipairs(DBM_GUI.tabs) do
		for _, node in ipairs(tabData.buttons) do
			local targetFrame = node.frame
			if targetFrame and not seen[targetFrame] and not node.hidden and self:IsFrameSearchable(targetFrame, tabId) then
				seen[targetFrame] = true
				local data = getFrameSearchData(targetFrame)
				if data.fullText:find(query, 1, true) then
					local matchedControl
					for _, entry in ipairs(data.entries) do
						if entry.text:find(query, 1, true) then
							matchedControl = entry.control
							break
						end
					end
					results[#results + 1] = {
						frame = targetFrame,
						displayName = ("[%s] %s"):format((self.tabs[tabId] and self.tabs[tabId].name) or "?", targetFrame.displayName or "?"),
						tab = tabId,
						sortName = strlower(targetFrame.displayName or ""),
						matchControl = matchedControl
					}
				end
			end
		end
	end
	tsort(results, function(a, b)
		if a.tab == b.tab then
			return a.sortName < b.sortName
		end
		return a.tab < b.tab
	end)
	return results
end

function frame:UpdateMenuFrame()
	local listFrame = _G[frame:GetName() .. "List"]
	if not listFrame or not listFrame.buttons then
		return
	end
	local searching = self.searchQuery and self.searchQuery ~= ""
	local displayedElements = searching and self:GetSearchResults() or (self.tab and DBM_GUI.tabs[self.tab]:GetVisibleTabs() or {})
	self:SetSearchStatus(searching, #displayedElements)
	local bigList = mfloor((listFrame:GetHeight() - 8) / 18)
	local scrollBar = _G[listFrame:GetName() .. "ScrollBar"]
	if #displayedElements > bigList then
		scrollBar:Show()
		scrollBar:SetMinMaxValues(0, (#displayedElements - bigList) * 18)
	else
		scrollBar:Hide()
		scrollBar:SetValue(0)
	end
	for i = 1, #listFrame.buttons do
		local button = listFrame.buttons[i]
		button:UnlockHighlight()
		local element = displayedElements[i + (listFrame.offset or 0)]
		if not element or i > bigList then
			button:Hide()
			button:SetHeight(-1)
		else
			if searching then
				self:DisplayButton(button, element.frame, element.displayName, true, element.matchControl)
			else
				self:DisplayButton(button, element.frame)
			end
			if (searching and DBM_GUI.currentViewing or (self.tab and self.tabs[self.tab].selection)) == element.frame then
				button:LockHighlight()
			end
		end
	end
end

function frame:DisplayButton(button, element, displayName, hideToggle, matchControl)
	local depth = hideToggle and 1 or element.depth
	local haschilds = not hideToggle and element.haschilds
	local textLeft = (haschilds and 14 or 6) + 8 * depth
	button:Show()
	button:SetHeight(18)
	button.element = element
	button.searchMatchedControl = matchControl
	element.selectButton = button
	button.text:ClearAllPoints()
	button.text:SetPoint("LEFT", textLeft, 2)
	button.text:SetPoint("RIGHT", button, "RIGHT", -6, 2)
	button.text:SetJustifyH("LEFT")
	if button.text.SetWordWrap then
		button.text:SetWordWrap(false)
	end
	if button.text.SetNonSpaceWrap then
		button.text:SetNonSpaceWrap(false)
	end
	button.text:SetWidth(button:GetWidth() - textLeft - 6)
	button.toggle:ClearAllPoints()
	button.toggle:SetPoint("LEFT", 8 * depth - 2, 1)
	button.text:SetFontObject(haschilds and GameFontNormal or GameFontWhite)
	button.text:SetTextScale(0.9)
	if haschilds then
		button.toggle:SetNormalTexture(element.showSub and 130821 or 130838) -- "Interface\\Buttons\\UI-MinusButton-UP", "Interface\\Buttons\\UI-PlusButton-UP"
		button.toggle:SetPushedTexture(element.showSub and 130820 or 130836) -- "Interface\\Buttons\\UI-MinusButton-DOWN", "Interface\\Buttons\\UI-PlusButton-DOWN"
		button.toggle:Show()
	else
		button.toggle:Hide()
	end
	local fullDisplayName = displayName or element.displayName or ""
	button.text:SetText(truncateTextWithEllipsis(button.text, fullDisplayName, button:GetWidth() - textLeft - 6))
	button.text:Show()
end

function frame:HighlightSearchControl(control)
	if not control then
		return
	end
	if not self.searchHighlightFrame then
		---@class DBMOptionsFrameSearchHighlight: Frame, BackdropTemplate
		local highlight = CreateFrame("Frame", nil, _G["DBM_GUI_OptionsFramePanelContainer"], "BackdropTemplate")
		highlight.backdropInfo = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", -- 137056
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
			edgeSize = 16,
			tileEdge = true
		}
		highlight:ApplyBackdrop()
		highlight:SetBackdropColor(1, 0.82, 0, 0.2)
		highlight:SetBackdropBorderColor(1, 0.82, 0, 1)
		highlight:SetFrameStrata("DIALOG")
		highlight:SetFrameLevel(300)
		highlight:Hide()
		self.searchHighlightFrame = highlight
		self.searchHighlightToken = 0
	end
	self.searchHighlightToken = self.searchHighlightToken + 1
	local token = self.searchHighlightToken
	self.searchHighlightFrame:ClearAllPoints()
	self.searchHighlightFrame:SetParent(control:GetParent() or _G["DBM_GUI_OptionsFramePanelContainer"])
	self.searchHighlightFrame:SetPoint("TOPLEFT", control, "TOPLEFT", -5, 5)
	self.searchHighlightFrame:SetPoint("BOTTOMRIGHT", control, "BOTTOMRIGHT", 5, -5)
	self.searchHighlightFrame:Show()
	C_Timer.After(6, function()
		if self.searchHighlightToken == token and self.searchHighlightFrame then
			self.searchHighlightFrame:Hide()
		end
	end)
end

function frame:RevealSearchMatch(targetFrame, control)
	if not targetFrame or not control then
		return
	end
	if expandParentsForControl(targetFrame, control) then
		self:DisplayFrame(targetFrame, true)
	end
	C_Timer.After(0, function()
		local scrollBar = _G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"]
		if scrollBar and scrollBar:IsShown() then
			local panelTop = targetFrame:GetTop()
			local controlTop = control:GetTop()
			if panelTop and controlTop then
				local desired = panelTop - controlTop - 40
				if desired < 0 then
					desired = 0
				end
				local _, max = scrollBar:GetMinMaxValues()
				scrollBar:SetValue(mmin(desired, max))
			end
		end
		self:HighlightSearchControl(control)
	end)
end

function frame:ClearSelection()
	for _, button in ipairs(_G["DBM_GUI_OptionsFrameList"].buttons) do
		button:UnlockHighlight()
	end
end

local function resize(targetFrame, hasScroll)
	local frameHeight = 20
	for _, child in ipairs({ targetFrame:GetChildren() }) do
		if child.mytype == "area" or child.mytype == "ability" then
			if hasScroll then
				child:SetPoint("TOPRIGHT", "DBM_GUI_OptionsFramePanelContainerFOVScrollBar", "TOPLEFT", -5, 0)
			else
				child:SetPoint("TOPRIGHT", "DBM_GUI_OptionsFramePanelContainerFOV", "TOPRIGHT", -5, 0)
			end
			local width = targetFrame:GetWidth() - 30
			if not child.isStats then
				local neededHeight, lastObject = 25, nil
				for _, child2 in ipairs({ child:GetChildren() }) do
					if child.mytype == "ability" and child2.mytype then
						child2:SetShown(not child.hidden)
						if child2.mytype == "spelldesc" then
							child2:SetShown(child2.hasDesc and true or child.hidden)
							child2:SetHeight(_G[child2:GetName() .. "Text"]:GetStringHeight())
						end
					end
					if child2.mytype and child2:IsVisible() then
						if child2.mytype == "textblock" then
							if child2.autowidth then
								local text = _G[child2:GetName() .. "Text"]
								text:SetWidth(width - 30)
								child2:SetSize(width, text:GetStringHeight())
							end
							lastObject = child2
						elseif child2.mytype == "spelldesc" then
							lastObject = child2
						elseif child2.mytype == "checkbutton" then
							local buttonText = child2.textObj
							local height = buttonText:GetContentHeight()
							buttonText:SetSize(buttonText:GetWidth(), height)
							buttonText:SetText(child2.text)
							if not child2.customPoint then
								if lastObject then
									child2:SetPointOld("TOPLEFT", lastObject, "BOTTOMLEFT", 0, -mmax((lastObject.textObj and lastObject.textObj:GetContentHeight() or 0) - lastObject:GetHeight() + 6, 5))
								else
									child2:SetPointOld("TOPLEFT", 10, -12)
								end
								child2.myheight = mmax(height + 12, 30)
							end
							lastObject = child2
						elseif child2.mytype == "line" then
							child2:SetWidth(width - 20)
							_G[child2:GetName() .. "BG"]:SetWidth(width - _G[child2:GetName() .. "Text"]:GetWidth() - 25)
							if lastObject and lastObject.myheight then
								child2:ClearAllPoints()
								child2:SetPoint("TOPLEFT", lastObject, "TOPLEFT", 0, -lastObject.myheight)
							end
							lastObject = child2
						elseif child2.mytype == "dropdown" then
							if not child2.width then
								local ddWidth = 120
								local dropdownText, titleText = _G[child2:GetName() .. "Text"], _G[child2:GetName() .. "TitleText"]:GetText()
								if titleText ~= L.FontType and titleText ~= L.FontStyle and titleText ~= L.FontShadow then
									for _, v in ipairs(child2.values) do
										dropdownText:SetText(v.text)
										ddWidth = mmax(ddWidth, dropdownText:GetStringWidth() + 30)
									end
								end
								dropdownText:SetText(child2.text)
								DDM.UIDropDownMenu_SetWidth(child2, mmin(width - 55, ddWidth))
							end
						end
						neededHeight = neededHeight + (child2.myheight or child2:GetHeight())
					elseif child2.myheight and child2:IsVisible() then
						neededHeight = neededHeight + child2.myheight
					end
				end
				child:SetHeight(neededHeight)
			end
			frameHeight = frameHeight + child:GetHeight() + 20
		elseif child.mytype == "line" then
			local width = targetFrame:GetWidth() - 30 + (child.extraWidth or 0)
			child:SetWidth(width - 20)
			_G[child:GetName() .. "BG"]:SetWidth(width - _G[child:GetName() .. "Text"]:GetWidth() - 25)
			frameHeight = frameHeight + 32
		elseif child.myheight then
			frameHeight = frameHeight + child.myheight
		end
	end
	return frameHeight
end

local bossPreview
function frame:DisplayFrame(targetFrame, secondResize)
	if select("#", targetFrame:GetChildren()) == 0 then
		return
	end
	selectedPagePerTab[self.tab] = targetFrame
	local scrollBar = _G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"]
	scrollBar:Show()
	local changed = DBM_GUI.currentViewing ~= targetFrame
	if DBM_GUI.currentViewing and changed then
		DBM_GUI.currentViewing:Hide()
	end
	DBM_GUI.currentViewing = targetFrame
	if _G["DBM_GUI_DropDown"] then
		_G["DBM_GUI_DropDown"]:Hide()
	end
	local FOV = _G["DBM_GUI_OptionsFramePanelContainerFOV"]
	FOV:SetScrollChild(targetFrame)
	FOV:Show()
	if changed then
		targetFrame:Show()
	end
	targetFrame:SetSize(FOV:GetSize())
	local mymax = resize(targetFrame, true) - _G["DBM_GUI_OptionsFramePanelContainer"]:GetHeight()
	if mymax <= 0 then
		mymax = 0
	end
	if mymax > 0 then
		scrollBar:SetMinMaxValues(0, mymax)
		if changed then
			scrollBar:SetValue(0)
		end
	else
		scrollBar:Hide()
		scrollBar:SetValue(0)
		scrollBar:SetMinMaxValues(0, 0)
		secondResize = true
	end
	if secondResize ~= false then
		resize(targetFrame, scrollBar:IsVisible())
	end
	if targetFrame.searchMatchedControl then
		self:RevealSearchMatch(targetFrame, targetFrame.searchMatchedControl)
		targetFrame.searchMatchedControl = nil
	end
	if DBM.Options.EnableModels then
		if not bossPreview then
			bossPreview = CreateFrame("PlayerModel", "DBM_BossPreview", _G["DBM_GUI_OptionsFramePanelContainer"])
			bossPreview:SetPoint("BOTTOMRIGHT", "DBM_GUI_OptionsFramePanelContainer", "BOTTOMRIGHT", -5, 5)
			bossPreview:SetSize(300, 300)
			bossPreview:SetPortraitZoom(0.4)
			bossPreview:SetRotation(0)
			bossPreview:SetClampRectInsets(0, 0, 24, 0)
		end
		bossPreview:Hide()
		for _, mod in ipairs(DBM.Mods) do
			if mod.panel and mod.panel.frame and mod.panel.frame == targetFrame then
				bossPreview.currentMod = mod
				bossPreview:Show()
				bossPreview:ClearModel()
				bossPreview:SetModelScale(1)
				bossPreview:SetPosition(mod.modelOffsetX or 0, mod.modelOffsetY or 0, mod.modelOffsetZ or 0)
				bossPreview:SetFacing(mod.modelRotation or 0)
				bossPreview:SetSequence(mod.modelSequence or 4)
				bossPreview:SetDisplayInfo(mod.modelId or 0)
				if mod.modelSoundShort and DBM.Options.ModelSoundValue == "Short" then
					DBM:PlaySoundFile(mod.modelSoundShort)
				elseif mod.modelSoundLong and DBM.Options.ModelSoundValue == "Long" then
					DBM:PlaySoundFile(mod.modelSoundLong)
				end
				break
			end
		end
	end
end

if not isRetail then
	frame.tabsGroup = CreateRadioButtonGroup()
end

function frame:CreateTab(tab)
	tab:Hide()
	local i = #self.tabs + 1
	self.tabs[i] = tab
	DBM_GUI:CreateNewFauxScrollFrameList()
	---@class DBMOptionsFrameTabButtonTemplate: Button
	---@field Text FontString -- From MinimalTabTemplate/PanelTopTabButtonTemplate
	local button = CreateFrame("Button", frame:GetName() .. "Tab" .. i, self, isRetail and "PanelTopTabButtonTemplate" or "MinimalTabTemplate")
	button.Text:SetText(tab.name)
	if isRetail then
		PanelTemplates_SetNumTabs(self, i)
	else
		self.tabsGroup:AddButton(button)
		button:SetSize(button.Text:GetStringWidth() + 18, 33)
	end
	if i == 1 then
		button:SetPoint("TOPLEFT", self:GetName(), 20, -29)
	else
		button:SetPoint("TOPLEFT", "DBM_GUI_OptionsFrameTab" .. (i - 1), "TOPRIGHT", 5, 0)
	end
	button:SetScript("OnClick", function()
		self:ShowTab(i)
	end)
end

local _count = 0
function frame:ShowTab(tab)
	self.tab = tab
	self:UpdateMenuFrame()
	local hasSearch = self.searchQuery and self.searchQuery ~= ""
	if (tab == 1 and _count % 2 == 0) or (tab == 2 and _count % 2 == 1) then
		_count = _count + 1
		if _count == 5 then
			_count = 0
			DBM:PlaySoundFile(1304911, true)
		end
	else
		_count = 0
	end
	if isRetail then
		PanelTemplates_SetTab(self, tab)
	else
		self.tabsGroup:SelectAtIndex(tab)
	end
	if bossPreview then
		bossPreview:Hide()
	end
	if selectedPagePerTab[tab] then
		self:DisplayFrame(selectedPagePerTab[tab])
	elseif DBM_GUI.currentViewing then
		DBM_GUI.currentViewing:Hide()
		DBM_GUI.currentViewing = nil
	end
	if not hasSearch and not selectedPagePerTab[tab] and tab == DBM_GUI.Enums.Tabs.CORE then -- Core Options, default show "Core & GUI" frame
		self:LoadAndShowFrame(DBM_GUI.tabs[self.tab].buttons[2].frame)
	elseif not hasSearch and not selectedPagePerTab[tab] and tab == DBM_GUI.Enums.Tabs.TOOLS then -- Tools
		self:LoadAndShowFrame(DBM_GUI.tabs[self.tab].buttons[1].frame)
	end
end
