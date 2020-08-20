local select, ipairs, mfloor, mmax = select, pairs, math.floor, math.max
local CreateFrame, GameFontHighlightSmall, GameFontNormalSmall, GameFontNormal = CreateFrame, GameFontHighlightSmall, GameFontNormalSmall, GameFontNormal
local DBM, DBM_GUI = DBM, DBM_GUI

local frame = CreateFrame("Frame", "DBM_GUI_OptionsFrame", UIParent, DBM:IsAlpha() and "BackdropTemplate")

function frame:UpdateMenuFrame()
	local listFrame = _G["DBM_GUI_OptionsFrameList"]
	if not listFrame.buttons then
		return
	end
	local displayedElements = self.tab and DBM_GUI.frameTypes[self.tab]:GetVisibleTabs() or {}
	local bigList = mfloor((listFrame:GetHeight() - 8) / 18)
	if #displayedElements > bigList then
		_G[listFrame:GetName() .. "List"]:Show()
		_G[listFrame:GetName() .. "ListScrollBar"]:SetMinMaxValues(0, (#displayedElements - bigList) * 18)
	else
		_G[listFrame:GetName() .. "List"]:Hide()
		_G[listFrame:GetName() .. "ListScrollBar"]:SetValue(0)
	end
	for i = 1, #listFrame.buttons do
		local button = listFrame.buttons[i]
		button:SetWidth(bigList and 185 or 209)
		button:UnlockHighlight()
		local element = displayedElements[i + (listFrame.offset or 0)]
		if not element or i > bigList then
			button:Hide()
		else
			self:DisplayButton(button, element.frame)
			if (self.tab and self.tabs[self.tab].selection) == element.frame then
				button:LockHighlight()
			end
		end
	end
end

function frame:DisplayButton(button, element)
	button:Show()
	button.element = element
	button.text:ClearAllPoints()
	button.text:SetPoint("LEFT", 12 + 8 * element.depth, 2)
	button.toggle:ClearAllPoints()
	button.toggle:SetPoint("LEFT", 8 * element.depth - 2, 1)
	button:SetNormalFontObject(element.depth > 2 and GameFontHighlightSmall or element.depth == 2 and GameFontNormalSmall or GameFontNormal)
	button:SetHighlightFontObject(element.depth > 2 and GameFontHighlightSmall or element.depth == 2 and GameFontNormalSmall or GameFontNormal)
	if element.haschilds then
		button.toggle:SetNormalTexture(element.showSub and 130821 or 130838) -- "Interface\\Buttons\\UI-MinusButton-UP", "Interface\\Buttons\\UI-PlusButton-UP"
		button.toggle:SetPushedTexture(element.showSub and 130820 or 130836) -- "Interface\\Buttons\\UI-MinusButton-DOWN", "Interface\\Buttons\\UI-PlusButton-DOWN"
		button.toggle:Show()
	else
		button.toggle:Hide()
	end
	button.text:SetText(element.displayName)
	button.text:Show()
end

function frame:ClearSelection()
	for _, button in ipairs(_G["DBM_GUI_OptionsFrameList"].buttons) do
		button:UnlockHighlight()
	end
end

local function resize(frame, first)
	local frameHeight = 20
	for _, child in ipairs({ frame:GetChildren() }) do
		if child.mytype == "area" then
			if first then
				child:SetPoint("TOPRIGHT", "DBM_GUI_OptionsFramePanelContainerFOVScrollBar", "TOPLEFT", -5, 0)
			else
				child:SetPoint("TOPRIGHT", "DBM_GUI_OptionsFramePanelContainerFOV", "TOPRIGHT", -5, 0)
			end
			local width = frame:GetWidth() - 30
			if not child.isStats then
				local neededHeight, lastObject = 25, nil
				for _, child2 in ipairs({ child:GetChildren() }) do
					if child2.mytype == "textblock" then
						if child2.autowidth then
							child2:SetWidth(width)
						end
						neededHeight = neededHeight + (child2.myheight or child2:GetStringHeight())
					elseif child2.mytype == "checkbutton" then
						local buttonText = _G[child2:GetName() .. "Text"]
						buttonText:SetWidth(width - buttonText.widthPad - 57)
						buttonText:SetText(buttonText.text)
						if not child2.customPoint then
							if lastObject and lastObject.myheight then
								child2:SetPointOld("TOPLEFT", lastObject, "TOPLEFT", 0, -lastObject.myheight)
							else
								child2:SetPointOld("TOPLEFT", 10, -12)
							end
							child2.myheight = mmax(buttonText:GetContentHeight() + 12, 25)
							buttonText:SetHeight(child2.myheight)
						end
						lastObject = child2
					elseif child2.mytype == "line" then
						child2:SetWidth(width - 20)
						if lastObject and lastObject.myheight then
							child2:ClearAllPoints()
							child2:SetPoint("TOPLEFT", lastObject, "TOPLEFT", 0, -lastObject.myheight)
							_G[child2:GetName() .. "BG"]:SetWidth(width - _G[child2:GetName() .. "Text"]:GetWidth() - 25)
						end
						lastObject = child2
					end
					neededHeight = neededHeight + (child2.myheight or child2:GetHeight())
				end
				child:SetHeight(neededHeight)
			end
			frameHeight = frameHeight + child:GetHeight() + 20
		elseif child.myheight then
			frameHeight = frameHeight + child.myheight
		end
	end
	return frameHeight
end

function frame:DisplayFrame(frame)
	if select("#", frame:GetChildren()) == 0 then
		return
	end
	local scrollBar = _G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"]
	scrollBar:Show()
	local changed = DBM_GUI.currentViewing ~= frame
	if DBM_GUI.currentViewing then
		DBM_GUI.currentViewing:Hide()
	end
	DBM_GUI.currentViewing = frame
	_G["DBM_GUI_OptionsFramePanelContainerHeaderText"]:SetText(frame.displayName)
	_G["DBM_GUI_DropDown"]:Hide()
	local FOV = _G["DBM_GUI_OptionsFramePanelContainerFOV"]
	FOV:SetScrollChild(frame)
	FOV:Show()
	frame:Show()
	frame:SetSize(FOV:GetWidth(), FOV:GetHeight())
	local mymax = resize(frame, true) - _G["DBM_GUI_OptionsFramePanelContainer"]:GetHeight()
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
		resize(frame)
	end
	if DBM.Options.EnableModels then
		local bossPreview = _G["DBM_BossPreview"]
		if not bossPreview then
			local mobstyle = CreateFrame("PlayerModel", "DBM_BossPreview", _G["DBM_GUI_OptionsFramePanelContainer"])
			mobstyle:SetPoint("BOTTOMRIGHT", "DBM_GUI_OptionsFramePanelContainer", "BOTTOMRIGHT", -5, 5)
			mobstyle:SetSize(300, 230)
			mobstyle:SetPortraitZoom(0.4)
			mobstyle:SetRotation(0)
			mobstyle:SetClampRectInsets(0, 0, 24, 0)
		end
		bossPreview.enabled = false
		bossPreview:Hide()
		for _, mod in ipairs(DBM.Mods) do
			if mod.panel and mod.panel.frame and mod.panel.frame == frame then
				bossPreview.currentMod = mod
				bossPreview:Show()
				bossPreview:ClearModel()
				bossPreview:SetDisplayInfo(mod.modelId or 0)
				bossPreview:SetSequence(4)
				if mod.modelSoundShort and DBM.Options.ModelSoundValue == "Short" then
					DBM:PlaySoundFile(mod.modelSoundShort)
				elseif mod.modelSoundLong and DBM.Options.ModelSoundValue == "Long" then
					DBM:PlaySoundFile(mod.modelSoundLong)
				end
			end
		end
	end
end

function frame:DeselectTab(i)
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Left"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Middle"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Right"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "LeftDisabled"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "MiddleDisabled"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "RightDisabled"]:Hide();
	self.tabs[i]:Hide()
end

function frame:SelectTab(i)
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Left"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Middle"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Right"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "LeftDisabled"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "MiddleDisabled"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "RightDisabled"]:Show();
	self.tabs[i]:Show()
end

function frame:CreateTab(tab)
	tab:Hide()
	local i = #self.tabs + 1
	self.tabs[i] = tab
	local button = CreateFrame("Button", "DBM_GUI_OptionsFrameTab" .. i, self, "OptionsFrameTabButtonTemplate")
	local buttonText = _G[button:GetName() .. "Text"]
	buttonText:SetText(tab.name)
	buttonText:SetPoint("LEFT", 22, -2)
	buttonText:Show()
	button:Show()
	if i == 1 then
		button:SetPoint("TOPLEFT", self:GetName(), 20, -18)
	else
		button:SetPoint("TOPLEFT", "DBM_GUI_OptionsFrameTab" .. (i - 1), "TOPRIGHT", -15, 0)
	end
	button:SetScript("OnClick", function()
		self:ShowTab(i)
	end)
end

function frame:ShowTab(tab)
	self.tab = tab
	self:UpdateMenuFrame()
	for i = 1, #self.tabs do
		if i == tab then
			self:SelectTab(i)
		else
			self:DeselectTab(i)
		end
	end
end
