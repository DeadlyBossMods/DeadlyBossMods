CreateFrame("Frame", "DBM_GUI_OptionsFrame", UIParent, DBM:IsAlpha() and "BackdropTemplate")

function DBM_GUI_OptionsFrame:UpdateMenuFrame()
	local listFrame = _G["DBM_GUI_OptionsFrameList"]
	if not listFrame.buttons then
		return
	end
	local displayedElements = {}
	self:ClearSelection()
	if self.tab then
		for _, element in ipairs(DBM_GUI.frameTypes[self.tab]:GetVisibleTabs()) do
			table.insert(displayedElements, element.frame)
		end
		if self.tabs[self.tab].selection then
			self.tabs[self.tab].selection:LockHighlight()
		end
	end
	local bigList = math.floor((listFrame:GetHeight() - 8) / 18)
	if #displayedElements > bigList then
		_G[listFrame:GetName() .. "List"]:Show()
		_G[listFrame:GetName() .. "ListScrollBar"]:SetMinMaxValues(0, (#displayedElements - bigList) * 18)
	else
		_G[listFrame:GetName() .. "List"]:Hide()
		_G[listFrame:GetName() .. "ListScrollBar"]:SetValue(0)
	end
	for _, button in ipairs(listFrame.buttons) do
		button:SetWidth(bigList and 185 or 209)
	end
	local offset = listFrame.offset or 0
	for i = 1, #listFrame.buttons do
		local element = displayedElements[i + offset]
		if not element or i > bigList then
			listFrame.buttons[i]:Hide()
		else
			self:DisplayButton(listFrame.buttons[i], element)
		end
	end
end

function DBM_GUI_OptionsFrame:DisplayButton(button, element)
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

function DBM_GUI_OptionsFrame:ClearSelection()
	for _, button in ipairs(_G["DBM_GUI_OptionsFrameList"].buttons) do
		button:UnlockHighlight()
	end
end

function DBM_GUI_OptionsFrame:DisplayFrame(frame, forceChange)
	if select("#", frame:GetChildren()) == 0 then
		return
	end
	local frameHeight = frame.initheight or 20
	for _, child in pairs({ frame:GetChildren() }) do
		if child.mytype == "area" and child.myheight then
			frameHeight = frameHeight + child.myheight
		elseif child.mytype == "area" then
			frameHeight = frameHeight + child:GetHeight() + 20
		elseif child.myheight then
			frameHeight = frameHeight + child.myheight
		end
	end
	local container = _G[self:GetName() .. "PanelContainer"]
	local changed = forceChange or container.displayedFrame ~= frame
	if container.displayedFrame then
		container.displayedFrame:Hide()
	end
	container.displayedFrame = frame
	DBM_GUI_OptionsFramePanelContainerHeaderText:SetText(frame.displayName)
	DBM_GUI_DropDown:Hide()
	local mymax = frameHeight - container:GetHeight()
	if mymax <= 0 then
		mymax = 0
	end
	local FOV = _G[container:GetName() .. "FOV"]
	FOV:SetScrollChild(frame)
	FOV:Show()
	frame:Show()
	local scrollBar = _G[FOV:GetName() .. "ScrollBar"]
	if mymax > 0 then
		scrollBar:Show()
		scrollBar:SetMinMaxValues(0, mymax)
		if changed then
			scrollBar:SetValue(0)
		end
		for _, child in pairs({ frame:GetChildren() }) do
			if child.mytype == "area" then
				child:SetPoint("TOPRIGHT", scrollBar, "TOPLEFT", -5, 0)
			end
		end
	else
		scrollBar:Hide()
		scrollBar:SetValue(0)
		scrollBar:SetMinMaxValues(0, 0)
		for _, child in pairs({ frame:GetChildren() }) do
			if child.mytype == "area" then
				child:SetPoint("TOPRIGHT", DBM_GUI_OptionsFramePanelContainerFOV, "TOPRIGHT", -5, 0)
			end
		end
	end
	if DBM.Options.EnableModels then
		if not DBM_BossPreview then
			local mobstyle = CreateFrame("PlayerModel", "DBM_BossPreview", DBM_GUI_OptionsFramePanelContainer)
			mobstyle:SetPoint("BOTTOMRIGHT", DBM_GUI_OptionsFramePanelContainer, "BOTTOMRIGHT", -5, 5)
			mobstyle:SetSize(300, 230)
			mobstyle:SetPortraitZoom(0.4)
			mobstyle:SetRotation(0)
			mobstyle:SetClampRectInsets(0, 0, 24, 0)
		end
		DBM_BossPreview.enabled = false
		DBM_BossPreview:Hide()
		for _, mod in ipairs(DBM.Mods) do
			if mod.panel and mod.panel.frame and mod.panel.frame == frame then
				DBM_BossPreview.currentMod = mod
				DBM_BossPreview:Show()
				DBM_BossPreview:ClearModel()
				DBM_BossPreview:SetDisplayInfo(mod.modelId or 0)
				DBM_BossPreview:SetSequence(4)
				if mod.modelSoundShort and DBM.Options.ModelSoundValue == "Short" then
					DBM:PlaySoundFile(mod.modelSoundShort)
				elseif mod.modelSoundLong and DBM.Options.ModelSoundValue == "Long" then
					DBM:PlaySoundFile(mod.modelSoundLong)
				end
			end
		end
	end
end

function DBM_GUI_OptionsFrame:DeselectTab(i)
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Left"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Middle"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Right"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "LeftDisabled"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "MiddleDisabled"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "RightDisabled"]:Hide();
	self.tabs[i]:Hide()
end

function DBM_GUI_OptionsFrame:SelectTab(i)
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Left"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Middle"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "Right"]:Hide();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "LeftDisabled"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "MiddleDisabled"]:Show();
	_G["DBM_GUI_OptionsFrameTab" .. i .. "RightDisabled"]:Show();
	self.tabs[i]:Show()
end

function DBM_GUI_OptionsFrame:CreateTab(tab)
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

function DBM_GUI_OptionsFrame:ShowTab(tab)
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
