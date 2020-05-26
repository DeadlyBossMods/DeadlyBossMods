local L		= DBM_GUI_L
local CL	= DBM_CORE_L

local PanelPrototype = {}
setmetatable(PanelPrototype, {
	__index = DBM_GUI
})

function PanelPrototype:GetLastObj()
	return self.lastobject
end

function PanelPrototype:SetLastObj(obj)
	self.lastobject = obj
end

function PanelPrototype:AutoSetDimension(additionalHeight)
	if not self.frame.mytype == "area" then
		return
	end
	local need_height = 25 + (additionalHeight or 0)

	for _, child in pairs({ self.frame:GetChildren() }) do
		if child.myheight and type(child.myheight) == "number" then
			need_height = need_height + child.myheight
		else
			need_height = need_height + child:GetHeight()
		end
	end
	self.frame.myheight = need_height + 20
	self.frame:SetHeight(need_height)
end

function PanelPrototype:CreateCreatureModelFrame(width, height, creatureid)
	local model = CreateFrame("PlayerModel", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	model.mytype = "modelframe"
	model:SetSize(width or 100, height or 200)
	model:SetCreature(tonumber(creatureid) or 448) -- Hogger!!! he kills all of you
	self:SetLastObj(model)
	return model
end

function PanelPrototype:CreateText(text, width, autoplaced, style, justify)
	local textblock = self.frame:CreateFontString("DBM_GUI_Option_" .. self:GetNewID(), "ARTWORK")
	textblock.mytype = "textblock"
	textblock:SetFontObject(style or GameFontNormal)
	textblock:SetText(text)
	textblock:SetJustifyH(justify or "CENTER")
	textblock:SetWidth(width or self.frame:GetWidth())
	if autoplaced then
		textblock:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 10, -10)
	end
	self:SetLastObj(textblock)
	return textblock
end

function PanelPrototype:CreateButton(title, width, height, onclick, font)
	local button = CreateFrame("Button", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "UIPanelButtonTemplate")
	button.mytype = "button"
	button:SetSize(width or 100, height or 20)
	button:SetText(title)
	if onclick then
		button:SetScript("OnClick", onclick)
	end
	if font then
		button:SetNormalFontObject(font)
		button:SetHighlightFontObject(font)
	end
	if _G[button:GetName() .. "Text"]:GetStringWidth() > button:GetWidth() then
		button:SetWidth(_G[button:GetName() .. "Text"]:GetStringWidth() + 25)
	end
	self:SetLastObj(button)
	return button
end

function PanelPrototype:CreateColorSelect(dimension, useAlpha, alphaWidth)
	local colorSelect = CreateFrame("ColorSelect", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	colorSelect.mytype = "colorselect"
	colorSelect:SetSize((dimension or 128) + (useAlpha and 38 or 0), dimension or 128)
	local colorWheel = colorSelect:CreateTexture()
	colorWheel:SetSize(dimension or 128, dimension or 128)
	colorWheel:SetPoint("TOPLEFT", colorSelect, "TOPLEFT", 5, 0)
	colorSelect:SetColorWheelTexture(colorWheel)
	local colorTexture = colorSelect:CreateTexture()
	colorTexture:SetTexture(130756) -- "Interface\\Buttons\\UI-ColorPicker-Buttons"
	colorTexture:SetSize(10, 10)
	colorTexture:SetTexCoord(0, 0.15625, 0, 0.625)
	colorSelect:SetColorWheelThumbTexture(colorTexture)
	if useAlpha then
		local colorValue = colorSelect:CreateTexture()
		colorValue:SetWidth(alphaWidth or 32)
		colorValue:SetHeight(dimension or 128)
		colorValue:SetPoint("LEFT", colorWheel, "RIGHT", 10, -3)
		colorSelect:SetColorValueTexture(colorValue)
		local colorTexture2 = colorSelect:CreateTexture()
		colorTexture2:SetTexture(130756) -- "Interface\\Buttons\\UI-ColorPicker-Buttons"
		colorTexture2:SetSize(alphaWidth / 32 * 48, alphaWidth / 32 * 14)
		colorTexture2:SetTexCoord(0.25, 1, 0.875, 0)
		colorSelect:SetColorValueThumbTexture(colorTexture2)
	end
	self:SetLastObj(colorSelect)
	return colorSelect
end

function PanelPrototype:CreateSlider(text, low, high, step, width)
	local slider = CreateFrame("Slider", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "OptionsSliderTemplate")
	slider.mytype = "slider"
	slider.myheight = 50
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	slider:SetWidth(width or 180)
	local sliderText = _G[slider:GetName() .. "Text"]
	sliderText:SetText(text)
	slider:SetScript("OnValueChanged", function(_, value)
		sliderText:SetFormattedText(text, value)
	end)
	self:SetLastObj(slider)
	return slider
end

function PanelPrototype:CreateScrollingMessageFrame(width, height, insertmode, fading, fontobject)
	local scroll = CreateFrame("ScrollingMessageFrame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	scroll:SetSize(width or 200, height or 150)
	scroll:SetJustifyH("LEFT")
	scroll:SetFading(fading or false)
	scroll:SetFontObject(fontobject or "GameFontNormal")
	scroll:SetMaxLines(2000)
	scroll:EnableMouse(true)
	scroll:EnableMouseWheel(true)
	scroll:SetScript("OnMouseWheel", function(self, delta)
		if delta == 1 then
			self:ScrollUp()
		elseif delta == -1 then
			self:ScrollDown()
		end
	end)
	self:SetLastObj(scroll)
	return scroll
end

function PanelPrototype:CreateEditBox(text, value, width, height)
	local textbox = CreateFrame("EditBox", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "InputBoxTemplate")
	textbox.mytype = "textbox"
	textbox:SetSize(width or 100, height or 20)
	textbox:SetScript("OnEscapePressed", function(self)
		self:ClearFocus()
	end)
	textbox:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
	end)
	if type(value) == "string" then
		textbox:SetText(value)
	end
	self:SetLastObj(textbox)
	local textboxLeft = textbox:CreateTexture("$parentLeft", "BACKGROUND")
	textboxLeft:SetTexture(130959) -- "Interface\ChatFrame\UI-ChatInputBorder-Left"
	textboxLeft:SetSize(32, 32)
	textboxLeft:SetPoint("LEFT", -14, 0)
	textboxLeft:SetTexCoord(0, 0.125, 0, 1)
	local textboxRight = textbox:CreateTexture("$parentRight", "BACKGROUND")
	textboxRight:SetTexture(130960) -- "Interface\ChatFrame\UI-ChatInputBorder-Right"
	textboxRight:SetSize(32, 32)
	textboxRight:SetPoint("RIGHT", 6, 0)
	textboxRight:SetTexCoord(0.875, 1, 0, 1)
	local textboxMiddle = textbox:CreateTexture("$parentMiddle", "BACKGROUND")
	textboxMiddle:SetTexture(130960) -- "Interface\ChatFrame\UI-ChatInputBorder-Right"
	textboxMiddle:SetSize(1, 32)
	textboxMiddle:SetPoint("LEFT", textboxLeft, "RIGHT")
	textboxMiddle:SetPoint("RIGHT", textboxRight, "LEFT")
	textboxMiddle:SetTexCoord(0, 0.9375, 0, 1)
	local textboxText = textbox:CreateFontString("$parentText", "BACKGROUND", "GameFontNormalSmall")
	textboxText:SetPoint("TOPLEFT", textbox, "TOPLEFT", -4, 14)
	textboxText:SetText(text)
	return textbox
end

function PanelPrototype:CreateLine(text)
	local line = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	line:SetSize(self.frame:GetWidth() - 20, 20)
	line:SetPoint("TOPLEFT", 10, -12)
	line.myheight = 20
	line.mytype = "line"
	local linetext = line:CreateFontString(line:GetName() .. "Text", "ARTWORK", "GameFontNormal")
	linetext:SetPoint("TOPLEFT", line, "TOPLEFT")
	linetext:SetJustifyH("LEFT")
	linetext:SetHeight(18)
	linetext:SetTextColor(0.67, 0.83, 0.48)
	linetext:SetText(text or "")
	local linebg = line:CreateTexture()
	linebg:SetTexture(137056) -- "Interface\\Tooltips\\UI-Tooltip-Background"
	linebg:SetSize(self.frame:GetWidth() - linetext:GetWidth() - 25, 2)
	linebg:SetPoint("RIGHT", line, "RIGHT", 0, 0)
	local x = self:GetLastObj()
	if x.mytype == "checkbutton" or x.mytype == "line" then
		line:ClearAllPoints()
		line:SetPoint("TOPLEFT", x, "TOPLEFT", 0, -x.myheight)
	else
		line:ClearAllPoints()
		line:SetPoint("TOPLEFT", 10, -12)
	end
	self:SetLastObj(line)
	return line
end

do
	local currActiveButton
	local updateFrame = CreateFrame("Frame")

	local function MixinCountTable(baseTable)
		local result = baseTable
		for i = 1, #DBM.Counts do
			tinsert(result, {
				text	= DBM.Counts[i].text,
				value	= DBM.Counts[i].path
			})
		end
		return result
	end

	local sounds = DBM_GUI:MixinSharedMedia3("sound", {
		-- Inject basically dummy values for ordering special warnings to just use default SW sound assignments
		{ text = L.None, value = "None" },
		{ text = "SW 1", value = 1 },
		{ text = "SW 2", value = 2 },
		{ text = "SW 3", value = 3 },
		{ text = "SW 4", value = 4 },
		-- Inject DBMs custom media that's not available to LibSharedMedia because it uses SoundKit Id (which LSM doesn't support)
		--{ text = "AirHorn (DBM)", value = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg" },
		{ text = "Algalon: Beware!", value = 15391 },
		{ text = "BB Wolf: Run Away", value = 9278 },
		{ text = "Blizzard Raid Emote", value = 37666 },
		{ text = "C'Thun: You Will Die!", value = 8585 },
		{ text = "Headless Horseman: Laugh", value = 11965 },
		{ text = "Illidan: Not Prepared", value = 11466 },
		{ text = "Illidan: Not Prepared2", value = 68563 },
		{ text = "Kaz'rogal: Marked", value = 11052 },
		{ text = "Kil'Jaeden: Destruction", value = 12506 },
		{ text = "Loatheb: I see you", value = 128466 },
		{ text = "Lady Malande: Flee", value = 11482 },
		{ text = "Milhouse: Light You Up", value = 49764 },
		{ text = "Night Elf Bell", value = 11742 },
		{ text = "PvP Flag", value = 8174 },
		{ text = "Void Reaver: Marked", value = 11213 },
		{ text = "Yogg Saron: Laugh", value = 15757 }
	})
	local tcolors = {
		{ text = L.CBTGeneric, value = 0 },
		{ text = L.CBTAdd, value = 1 },
		{ text = L.CBTAOE, value = 2 },
		{ text = L.CBTTargeted, value = 3 },
		{ text = L.CBTInterrupt, value = 4 },
		{ text = L.CBTRole, value = 5 },
		{ text = L.CBTPhase, value = 6 },
		{ text = L.CBTImportant, value = 7 }
	}
	local cvoice = MixinCountTable({
		{ text = L.None, value = 0 },
		{ text = L.CVoiceOne, value = 1 },
		{ text = L.CVoiceTwo, value = 2 },
		{ text = L.CVoiceThree, value = 3 }
	})

	function PanelPrototype:CreateCheckButton(name, autoplace, textLeft, dbmvar, dbtvar, mod, modvar, globalvar, isTimer)
		if not name then
			return
		end
		if type(name) == "number" then
			return DBM:AddMsg("CreateCheckButton: error: expected string, received number. You probably called mod:NewTimer(optionId) with a spell id." .. name)
		end
		local button = CreateFrame("CheckButton", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "OptionsBaseCheckButtonTemplate")
		button:SetHitRectInsets(0, 0, 0, 0)
		button.myheight = 25
		button.mytype = "checkbutton"
		if autoplace then
			local x = self:GetLastObj()
			if x.myheight then
				button:SetPoint("TOPLEFT", x, "TOPLEFT", 0, -x.myheight)
			else
				button:SetPoint("TOPLEFT", 10, -12)
			end
		end
		local noteSpellName = name
		if name:find("%$spell:ej") then -- It is journal link :-)
			name = name:gsub("%$spell:ej(%d+)", "$journal:%1")
		end
		if name:find("%$spell:") then
			if not isTimer and modvar then
				noteSpellName = DBM:GetSpellInfo(string.match(name, "spell:(%d+)"))
			end
			name = name:gsub("%$spell:(%d+)", function(id)
				local spellId = tonumber(id)
				local spellName = DBM:GetSpellInfo(spellId)
				if not spellName then
					spellName = CL.UNKNOWN
					DBM:Debug("Spell ID does not exist: " .. spellId)
				end
				return ("|cff71d5ff|Hspell:%d|h%s|h|r"):format(spellId, spellName)
			end)
		end
		if name:find("%$journal:") then
			if not isTimer and modvar then
				noteSpellName = DBM:EJ_GetSectionInfo(string.match(name, "journal:(%d+)"))
			end
			name = name:gsub("%$journal:(%d+)", function(id)
				local check = DBM:EJ_GetSectionInfo(tonumber(id))
				if not check then
					DBM:Debug("Journal ID does not exist: " .. id)
				end
				local link = select(9, DBM:EJ_GetSectionInfo(tonumber(id))) or CL.UNKNOWN
				return link:gsub("|h%[(.*)%]|h", "|h%1|h")
			end)
		end
		local frame, frame2, textPad
		if modvar then -- Special warning, has modvar for sound and note
			if isTimer then
				frame = self:CreateDropdown(nil, tcolors, mod, modvar .. "TColor", nil, 20, 25, button)
				frame2 = self:CreateDropdown(nil, cvoice, mod, modvar .. "CVoice", function(value)
					mod.Options[modvar.."CVoice"] = value
					if type(value) == "string" then
						DBM:PlayCountSound(1, nil, value)
					elseif value > 0 then
						DBM:PlayCountSound(1, value == 3 and DBM.Options.CountdownVoice3 or value == 2 and DBM.Options.CountdownVoice2 or DBM.Options.CountdownVoice)
					end
				end, 20, 25, button)
				frame:SetPoint("LEFT", button, "RIGHT", -20, 2)
				frame2:SetPoint("LEFT", frame, "RIGHT", 18, 0)
				textPad = 35
			else
				frame = self:CreateDropdown(nil, sounds, mod, modvar .. "SWSound", function(value)
					mod.Options[modvar.."SWSound"] = value
					DBM:PlaySpecialWarningSound(value)
				end, 20, 25, button)
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", button, "RIGHT", -20, 2)
				if mod.Options[modvar .. "SWNote"] then -- Mod has note, insert note hack
					frame2 = CreateFrame("Button", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "UIPanelButtonTemplate")
					frame2:SetPoint("LEFT", frame, "RIGHT", 35, 0)
					frame2:SetSize(25, 25)
					frame2.myheight = 0 -- Tells SetAutoDims that this button needs no additional space
					frame2:SetText("|TInterface/FriendsFrame/UI-FriendsFrame-Note.blp:14:0:2:-1|t")
					frame2.mytype = "button"
					frame2:SetScript("OnClick", function(self)
						DBM:ShowNoteEditor(mod, modvar, noteSpellName)
					end)
					textPad = 2
				end
			end
		end
		local buttonText = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormal")
		buttonText:SetPoint("LEFT", button, "RIGHT", 0, 1)
		if name then -- Switch all checkbutton frame to SimpleHTML frame (auto wrap)
			buttonText = CreateFrame("SimpleHTML", buttonText:GetName(), button)
			buttonText:SetFontObject("GameFontNormal")
			buttonText:SetHyperlinksEnabled(true)
			buttonText:SetScript("OnHyperlinkEnter", function(self, data, link)
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				local linkType = strsplit(":", data)
				if linkType == "http" then
					return
				end
				if linkType ~= "journal" then
					GameTooltip:SetHyperlink(data)
				else -- "journal:contentType:contentID:difficulty"
					local _, contentType, contentID = strsplit(":", data)
					if contentType == "2" then
						local name, description = DBM:EJ_GetSectionInfo(tonumber(contentID))
						GameTooltip:AddLine(name or CL.UNKNOWN, 255, 255, 255, 0)
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(description or CL.UNKNOWN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
					end
				end
				GameTooltip:Show()
				currActiveButton = self:GetParent()
				updateFrame:SetScript("OnUpdate", function(self, elapsed)
					local inHitBox = GetCursorPosition() - currActiveButton:GetCenter() < -100
					if currActiveButton.fakeHighlight and not inHitBox then
						currActiveButton:UnlockHighlight()
						currActiveButton.fakeHighlight = nil
					elseif not currActiveButton.fakeHighlight and inHitBox then
						currActiveButton:LockHighlight()
						currActiveButton.fakeHighlight = true
					end
					local x, y = GetCursorPosition()
					local scale = UIParent:GetEffectiveScale()
					GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", (x / scale) + 5, (y / scale) + 2)
				end)
				if GetCursorPosition() - self:GetParent():GetCenter() < -100 then
					self:GetParent().fakeHighlight = true
					self:GetParent():LockHighlight()
				end
			end)
			buttonText:SetScript("OnHyperlinkLeave", function(self, data, link)
				GameTooltip:Hide()
				updateFrame:SetScript("OnUpdate", nil)
				if self:GetParent().fakeHighlight then
					self:GetParent().fakeHighlight = nil
					self:GetParent():UnlockHighlight()
				end
			end)
			buttonText:SetHeight(25)
			name = "<html><body><p>" .. name .. "</p></body></html>"
		end
		buttonText:SetWidth(self.frame:GetWidth() - 57 - (frame and frame:GetWidth() + frame2:GetWidth() or 0))
		buttonText:SetText(name or CL.UNKNOWN)
		if textLeft then
			buttonText:ClearAllPoints()
			buttonText:SetPoint("RIGHT", frame2 or frame or button, "LEFT")
			buttonText:SetJustifyH("RIGHT")
		else
			buttonText:SetJustifyH("LEFT")
			buttonText:SetPoint("TOPLEFT", frame2 or frame or button, "TOPRIGHT", textPad or 0, -4)
			button.myheight = math.max(buttonText:GetContentHeight() + 12, button.myheight)
		end
		if dbmvar and DBM.Options[dbmvar] ~= nil then
			button:SetScript("OnShow", function(self)
				button:SetChecked(DBM.Options[dbmvar])
			end)
			button:SetScript("OnClick", function(self)
				DBM.Options[dbmvar] = not DBM.Options[dbmvar]
			end)
		end
		if dbtvar then
			button:SetScript("OnShow", function(self)
				button:SetChecked(DBM.Bars:GetOption(dbtvar))
			end)
			button:SetScript("OnClick", function(self)
				DBM.Bars:SetOption(dbtvar, not DBM.Bars:GetOption(dbtvar))
			end)
		end
		if globalvar and _G[globalvar] ~= nil then
			button:SetScript("OnShow", function(self)
				button:SetChecked(_G[globalvar])
			end)
			button:SetScript("OnClick", function(self)
				_G[globalvar] = not _G[globalvar]
			end)
		end
		self:SetLastObj(button)
		return button
	end
end

function PanelPrototype:CreateArea(name, height)
	local area = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, DBM:IsAlpha() and "BackdropTemplate,OptionsBoxTemplate" or "OptionsBoxTemplate")
	area.mytype = "area"
	area:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	area:SetBackdropBorderColor(0.4, 0.4, 0.4)
	_G[area:GetName() .. "Title"]:SetText(name)
	area:SetSize(self.frame:GetWidth() - 12, height or self.frame:GetHeight() - 10)
	if select("#", self.frame:GetChildren()) == 1 then
		area:SetPoint("TOPLEFT", self.frame, 5, -20)
	else
		area:SetPoint("TOPLEFT", select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -20)
	end
	self:SetLastObj(area)
	self.areas = self.areas or {}
	table.insert(self.areas, {
		frame	= area,
		parent	= self
	})
	return setmetatable(self.areas[#self.areas], {
		__index = PanelPrototype
	})
end

function PanelPrototype:Rename(newname)
	self.frame.name = newname
end

function PanelPrototype:Destroy()
	table.remove(DBM_GUI.frameTypes[self.frame.frameType], self.frame.categoryid)
	table.remove(self.parent.panels, self.frame.panelid)
	self.frame:Hide()
end

do
	local myid = 100

	function DBM_GUI:CreateNewPanel(frameName, frameType, showSub, sortID, displayName)
		local panel = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), DBM_GUI_OptionsFramePanelContainer)
		panel.mytype = "panel"
		panel.sortID = self:GetCurrentID()
		panel:SetSize(DBM_GUI_OptionsFramePanelContainer:GetWidth(), DBM_GUI_OptionsFramePanelContainer:GetHeight())
		panel:SetPoint("TOPLEFT", DBM_GUI_OptionsFramePanelContainer, "TOPLEFT")
		panel.name = frameName
		panel.displayName = displayName or frameName
		panel.showSub = showSub or showSub == nil
		if sortID or 0 > 0 then
			panel.sortid = sortID
		else
			myid = myid + 1
			panel.sortid = myid
		end
		panel:Hide()
		if frameType == "option" then
			frameType = 2
		end
		panel.categoryid = DBM_GUI.frameTypes[frameType or 1]:CreateCategory(panel, self and self.frame and self.frame.name)
		panel.frameType = frameType
		PanelPrototype:SetLastObj(panel)
		self.panels = self.panels or {}
		table.insert(self.panels, {
			frame	= panel,
			parent	= self
		})
		panel.panelid = #self.panels
		return setmetatable(self.panels[#self.panels], {
			__index = PanelPrototype
		})
	end
end
