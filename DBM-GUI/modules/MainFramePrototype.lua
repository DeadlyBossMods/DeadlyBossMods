local L = DBM_GUI_L

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

---@class DBMGUI
local DBM_GUI = DBM_GUI

local DDM = LibStub:GetLibrary("LibDropDownMenu")

local select, ipairs, mfloor, mmax, mmin = select, pairs, math.floor, math.max, math.min
local CreateFrame, GameFontNormal = CreateFrame, GameFontNormal
local DBM = DBM

---@class DBMOptionsFrame: Frame
---@field tabs table
local frame = CreateFrame("Frame", "DBM_GUI_OptionsFrame", UIParent, "NineSlicePanelTemplate")

local selectedPagePerTab = {}

function frame:UpdateMenuFrame()
	local listFrame = _G[frame:GetName() .. "List"]
	if not listFrame or not listFrame.buttons then
		return
	end
	local displayedElements = self.tab and DBM_GUI.tabs[self.tab]:GetVisibleTabs() or {}
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
			self:DisplayButton(button, element.frame)
			if (self.tab and self.tabs[self.tab].selection) == element.frame then
				button:LockHighlight()
			end
		end
	end
end

function frame:DisplayButton(button, element)
	button:Show()
	button:SetHeight(18)
	button.element = element
	button.text:ClearAllPoints()
	button.text:SetPoint("LEFT", (element.haschilds and 14 or 6) + 8 * element.depth, 2)
	button.toggle:ClearAllPoints()
	button.toggle:SetPoint("LEFT", 8 * element.depth - 2, 1)
	button.text:SetFontObject(element.haschilds and GameFontNormal or GameFontWhite)
	button.text:SetTextScale(0.9)
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

local function resize(targetFrame, first)
	local frameHeight = 20
	for _, child in ipairs({ targetFrame:GetChildren() }) do
		if child.mytype == "area" or child.mytype == "ability" then
			if first then
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
							_G[child:GetName() .. "Title"]:Show()
							_G[child2:GetName() .. "Text"]:SetShown(child2.hasDesc and true or child.hidden)
						end
					end
					if child2.mytype and child2:IsVisible() then
						if child2.mytype == "textblock" or child2.mytype == "spelldesc" then
							local text = _G[child2:GetName() .. "Text"]
							if child2.autowidth then
								_G[child2:GetName() .. "Text"]:SetWidth(width - 30)
								child2:SetSize(width, text:GetStringHeight())
							end
							lastObject = child2
						elseif child2.mytype == "checkbutton" then
							local buttonText = child2.textObj
							buttonText:SetWidth(width - child2.widthPad - 57)
							buttonText:SetText(child2.text)
							if not child2.customPoint then
								local height = buttonText:GetContentHeight()
								if not isRetail then
									-- Classic fix: SimpleHTML needs its height reset
									local oldPoint1, oldPoint2, oldPoint3, oldPoint4, oldPoint5 = buttonText:GetPoint()
									buttonText:SetHeight(1)
									buttonText:SetPoint("TOPLEFT", UIParent)
									height = buttonText:GetContentHeight()
									buttonText:SetPoint(oldPoint1, oldPoint2, oldPoint3, oldPoint4, oldPoint5)
									-- End classic fix
								end
								if lastObject then
									child2:SetPointOld("TOPLEFT", lastObject, "BOTTOMLEFT", 0, -mmax((lastObject.textObj and lastObject.textObj:GetContentHeight() or 0) - lastObject:GetHeight() + 6, 0))
								else
									child2:SetPointOld("TOPLEFT", 10, -12)
								end
								child2.myheight = mmax(height + 12, 25)
								buttonText:SetHeight(child2.myheight)
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
			local width = targetFrame:GetWidth() - 30
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
function frame:DisplayFrame(targetFrame)
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
	_G["DBM_GUI_DropDown"]:Hide()
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
		resize(targetFrame)
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

function frame:ShowTab(tab)
	self.tab = tab
	self:UpdateMenuFrame()
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
end
