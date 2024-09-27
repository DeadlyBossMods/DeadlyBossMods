local _, private = ...

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)

local L		= DBM_GUI_L
local CL	= DBM_COMMON_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

local setmetatable, select, type, tonumber, strsplit, mmax, tinsert = setmetatable, select, type, tonumber, strsplit, math.max, table.insert
local CreateFrame, GetCursorPosition, UIParent, GameTooltip, NORMAL_FONT_COLOR, GameFontNormal = CreateFrame, GetCursorPosition, UIParent, GameTooltip, NORMAL_FONT_COLOR, GameFontNormal
local DBM = DBM
local CreateTextureMarkup = CreateTextureMarkup

local GetSpellDescription = C_Spell.GetSpellDescription or GetSpellDescription

--TODO, not 100% sure which ones use html and which don't so some might need true added or removed for 2nd arg
local function parseDescription(name, usesHTML)
	if not name then
		return
	end
	local spellName = name
	if name:find("%$spell:ej") then -- It is journal link :-)
		name = name:gsub("%$spell:ej(%d+)", "$journal:%1")
	end
	if name:find("%$spell:") then
		name = name:gsub("%$spell:(%-?%d+)", function(id)
			local spellId = tonumber(id)
			if spellId then
				if spellId < 0 then
				    return "$journal:" .. -spellId
				end
				spellName = DBM:GetSpellName(spellId)
			end
			if not spellName then
				spellName = CL.UNKNOWN
				DBM:Debug("Spell ID does not exist: " .. spellId)
			end
			--The HTML parser breaks if spell name has & in it if it's not encoded to html formating
			if usesHTML and spellName:find("&") then
				spellName = spellName:gsub("&", "&amp;")
			end
			return ("|cff71d5ff|Hspell:%d|h%s|h|r"):format(spellId, spellName)
		end)
	end
	if name:find("%$journal:") then
		name = name:gsub("%$journal:(%d+)", function(id)
			spellName = DBM:EJ_GetSectionInfo(tonumber(id))
			if not spellName then
				DBM:Debug("Journal ID does not exist: " .. id)
			end
			local link = select(9, DBM:EJ_GetSectionInfo(tonumber(id))) or CL.UNKNOWN
			return link:gsub("|h%[(.*)%]|h", "|h%1|h")
		end)
	end
	return name, spellName
end
private.parseDescription = parseDescription

---@class DBMPanel: DBMGUI
---@field frame Frame
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

function PanelPrototype:CreateCreatureModelFrame(width, height, creatureid, scale)
	---@class DBMPanelCreatureModel: PlayerModel
	local model = CreateFrame("PlayerModel", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	model.mytype = "modelframe"
	model:SetSize(width or 100, height or 200)
	model:SetCreature(tonumber(creatureid) or 448) -- Hogger!!! he kills all of you
	if scale then
		model:SetModelScale(scale)
	end
	self:SetLastObj(model)
	return model
end

function PanelPrototype:CreateSpellDesc(text)
	---@class DBMPanelSpellDesc: Frame
	local test = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	local textblock = self.frame:CreateFontString(test:GetName() .. "Text", "ARTWORK")
	textblock:SetFontObject(GameFontWhite)
	textblock:SetJustifyH("LEFT")
	textblock:SetPoint("TOPLEFT", test)
	test:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 15, -10)
	test:SetSize(self.frame:GetWidth(), textblock:GetStringHeight())
	test.mytype = "spelldesc"
	test.autowidth = true
	test.hasDesc = false
	-- Description logic
	if type(text) == "number" then
		local spell = Spell:CreateFromSpellID(text)
		textblock:SetText("Loading...")
		spell:ContinueOnSpellLoad(function()
			text = GetSpellDescription(spell:GetSpellID())
			if not text or text == "" then
				text = L.NoDescription
			else
				test.hasDesc = true
			end
			textblock:SetText(text:gsub('|cffffffff', '|cff71d5ff'))
			if DBM_GUI.currentViewing then
				_G["DBM_GUI_OptionsFrame"]:DisplayFrame(DBM_GUI.currentViewing)
			end
		end)
	else
		if text == "" then
			text = L.NoDescription
		else
			test.hasDesc = true
		end
		textblock:SetText(text)
	end
    --
	self:SetLastObj(test)
	return test
end

function PanelPrototype:CreateText(text, width, autoplaced, style, justify, myheight)
	---@class DBMPanelText: Frame
	local textFrame = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	---@class DBMPanelTextblock: FontString
	---@field myheight number
	local textblock = self.frame:CreateFontString(textFrame:GetName() .. "Text", "ARTWORK")
	textblock:SetFontObject(style or GameFontNormal)
	textblock:SetText(parseDescription(text))
	textblock:SetJustifyH(justify or "LEFT")
	textblock:SetPoint("TOPLEFT", textFrame)
	textblock:SetWidth(width or self.frame:GetWidth())
	if autoplaced then
		if select("#", self.frame:GetChildren()) == 2 then
			textFrame:SetPoint("TOPLEFT", self.frame, 15, -12)
		else
			textFrame:SetPoint("TOPLEFT", select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -12)
		end
	end
	textFrame:SetSize(width or self.frame:GetWidth(), textblock:GetStringHeight())
	textFrame.mytype = "textblock"
	textFrame.autowidth = not width
	textFrame.myheight = myheight
	self:SetLastObj(textblock)
	return textblock
end

function PanelPrototype:CreateButton(title, width, height, onclick, font, highlightFont)
	---@class DBMPanelButton: Button
	---@field myheight number
	---@field addon table
	---@field headline DBMPanelTextblock
	local button = CreateFrame("Button", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "UIPanelButtonTemplate")
	button.mytype = "button"
	button:SetSize(width or 100, height or 20)
	button:SetText(parseDescription(title, true))
	if onclick then
		button:SetScript("OnClick", onclick)
	end
	if font or highlightFont then
		button:SetNormalFontObject(font or highlightFont)
		button:SetHighlightFontObject(highlightFont or font)
	end
	if _G[button:GetName() .. "Text"]:GetStringWidth() > button:GetWidth() then
		button:SetWidth(_G[button:GetName() .. "Text"]:GetStringWidth() + 25)
	end
	self:SetLastObj(button)
	return button
end

function PanelPrototype:CreateColorSelect(dimension, useAlpha, alphaWidth)
	---@class DBMPanelColorSelect: ColorSelect
	---@field myheight number
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
	---@class DBMPanelSlider: Slider
	local slider = CreateFrame("Slider", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "DBMPolyfill_OptionsSliderTemplate")
	slider.mytype = "slider"
	slider.myheight = 50
	slider:SetMinMaxValues(low, high)
	slider:SetValueStep(step)
	slider:SetWidth(width or 180)
	local sliderText = _G[slider:GetName() .. "Text"]
	sliderText:SetText(parseDescription(text, true))
	slider:SetScript("OnValueChanged", function(_, value)
		sliderText:SetFormattedText(text, value)
	end)
	slider.textFrame = sliderText
	self:SetLastObj(slider)
	return slider
end

function PanelPrototype:CreateScrollingMessageFrame(width, height, _, fading, fontobject)
	---@class DBMScrollingMessageFrame: ScrollFrame, MessageFrame, FontString
	---@diagnostic disable-next-line:assign-type-mismatch
	local scroll = CreateFrame("ScrollingMessageFrame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	scroll.mytype = "scroll"
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
	---@class DBMEditBox: EditBox
	---@field myheight number
	local textbox = CreateFrame("EditBox", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "BackdropTemplate,InputBoxTemplate")
	textbox.mytype = "textbox"
	textbox:SetSize(width or 100, height or 20)
	textbox:SetAutoFocus(false)
	textbox:SetScript("OnEscapePressed", function(self)
		self:ClearFocus()
	end)
	textbox:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
	end)
	textbox:SetText(value)
	local textboxText = textbox:CreateFontString("$parentText", "BACKGROUND", "GameFontNormalSmall")
	textboxText:SetPoint("TOPLEFT", textbox, "TOPLEFT", -4, 14)
	textboxText:SetText(text)
	self:SetLastObj(textbox)
	return textbox
end

function PanelPrototype:CreateLine(text, extraWidth)
	---@class DBMPanelLine: Frame
	local line = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame)
	line:SetSize(self.frame:GetWidth() - 20, 20)
	if select("#", self.frame:GetChildren()) == 2 then
		line:SetPoint("TOPLEFT", self.frame, 10, -12)
	else
		line:SetPoint("TOPLEFT", select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -12)
	end
	line.myheight = 20
	line.mytype = "line"
	line.extraWidth = extraWidth
	local linetext = line:CreateFontString("$parentText", "ARTWORK", "GameFontNormal")
	linetext:SetPoint("TOPLEFT", line, "TOPLEFT")
	linetext:SetJustifyH("LEFT")
	linetext:SetHeight(18)
	linetext:SetTextColor(0.67, 0.83, 0.48)
	linetext:SetText(text and parseDescription(text) or "")
	local linebg = line:CreateTexture("$parentBG")
	linebg:SetTexture(137056) -- "Interface\\Tooltips\\UI-Tooltip-Background"
	linebg:SetSize(self.frame:GetWidth() - linetext:GetWidth() - 25, 2)
	linebg:SetPoint("RIGHT", line, "RIGHT", 0, 0)
	self:SetLastObj(line)
	return line
end

do
	local currActiveButton
	local updateFrame = CreateFrame("Frame")

	local function MixinCountTable(baseTable)
		local result = baseTable
		for _, count in pairs(DBM:GetCountSounds()) do
			tinsert(result, {
				text	= count.text,
				value	= count.path
			})
		end
		return result
	end

	local sounds = DBM_GUI:MixinSharedMedia3("sound", {
		-- Inject basically dummy values for ordering special warnings to just use default SW sound assignments
		{ text = L.None, value = "None" },
		{ text = L.SAOne, value = 1 },
		{ text = L.SATwo, value = 2 },
		{ text = L.SAThree, value = 3 },
		{ text = L.SAFour, value = 4 },
		-- Inject DBMs custom media that's not available to LibSharedMedia because I haven't added it yet
		--{ text = "AirHorn (DBM)", value = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg" },
		{ text = "Algalon: Beware!", value = isRetail and 543587 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\UR_Algalon_BHole01.ogg" },
		{ text = "BB Wolf: Run Away", value = not isClassic and 552035 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\HoodWolfTransformPlayer01.ogg" },
		{ text = "Illidan: Not Prepared", value = not isClassic and 552503 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\BLACK_Illidan_04.ogg" },
		{ text = "Illidan: Not Prepared2", value = isRetail and 1412178 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\VO_703_Illidan_Stormrage_03.ogg" },
		{ text = "Kil'Jaeden: Destruction", value = not isClassic and 553193 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\KILJAEDEN02.ogg" },
		{ text = "Loatheb: I see you", value = 554236 },
		{ text = "Night Elf Bell", value = 566558 },
		{ text = "PvP Flag", value = 569200 },
	})
	if isRetail then
		tinsert(sounds, { text = "Blizzard Raid Emote", value = 876098 })
		tinsert(sounds, { text = "C'Thun: You Will Die!", value = 546633 })
		tinsert(sounds, { text = "Headless Horseman: Laugh", value = 551703 })
		tinsert(sounds, { text = "Kaz'rogal: Marked", value = 553050 })
		tinsert(sounds, { text = "Lady Malande: Flee", value = 553566 })
		tinsert(sounds, { text = "Milhouse: Light You Up", value = 555337 })
		tinsert(sounds, { text = "Void Reaver: Marked", value = 563787 })
		tinsert(sounds, { text = "Yogg Saron: Laugh", value = 564859 })
	end

	local function RGBPercToHex(r, g, b)
		r = r <= 1 and r >= 0 and r or 0
		g = g <= 1 and g >= 0 and g or 0
		b = b <= 1 and b >= 0 and b or 0
		return string.format("%02x%02x%02x", r*255, g*255, b*255)
	end

	local tcolors = {
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorR or 1, DBT.Options.StartColorG or 1, DBT.Options.StartColorB or 1)..L.ColorDropGeneric.."|r", value = 0 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorAR or 1, DBT.Options.EndColorAG or 1, DBT.Options.EndColorAB or 1)..L.ColorDrop1.."|r", value = 1 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorAER or 1, DBT.Options.EndColorAEG or 1, DBT.Options.StartColorAEB or 1)..L.ColorDrop2.."|r", value = 2 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorDR or 1, DBT.Options.EndColorDG or 1, DBT.Options.EndColorDB or 1)..L.ColorDrop3.."|r", value = 3 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorIR or 1, DBT.Options.EndColorIG or 1, DBT.Options.EndColorIB or 1)..L.ColorDrop4.."|r", value = 4 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorRR or 1, DBT.Options.EndColorRG or 1, DBT.Options.EndColorRB or 1)..L.ColorDrop5.."|r", value = 5 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorPR or 1, DBT.Options.EndColorPG or 1, DBT.Options.EndColorPB or 1)..L.ColorDrop6.."|r", value = 6 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorUIR or 1, DBT.Options.EndColorUIG or 1, DBT.Options.EndColorUIB or 1)..L.CDDImportant1.."|r", value = 7 },
		{ text = "|cff"..RGBPercToHex(DBT.Options.EndColorI2R or 1, DBT.Options.EndColorI2G or 1, DBT.Options.EndColorI2B or 1)..L.CDDImportant2.."|r", value = 8 }
	}
	local cvoice = MixinCountTable({
		{ text = L.None, value = 0 },
		{ text = L.CVoiceOne, value = 1 },
		{ text = L.CVoiceTwo, value = 2 },
		{ text = L.CVoiceThree, value = 3 }
	})

	function PanelPrototype:CreateCheckButton(name, autoplace, textLeft, dbmvar, dbtvar, mod, modvar, globalvar, isTimer)
		if not name then
			error("CreateCheckButton: name must not be nil")
		end
		if type(name) == "number" then
			error("CreateCheckButton: error: expected string, received number. You probably called mod:NewTimer(optionId) with a spell id." .. name)
		end
		---@class DBMCheckButton: CheckButton
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
		button.SetPointOld = button.SetPoint
		button.SetPoint = function(...)
			button.customPoint = true
			button.myheight = 0
			button.SetPointOld(...)
		end
		local desc, noteSpellName = parseDescription(name, true)
		local frame, frame2, textPad
		if modvar then -- Special warning, has modvar for sound and note
			if isTimer then
				frame = self:CreateDropdown(nil, tcolors, mod, modvar .. "TColor", function(value)
					mod.Options[modvar .. "TColor"] = value
				end, 22, 25, button)
				frame2 = self:CreateDropdown(nil, cvoice, mod, modvar .. "CVoice", function(value)
					mod.Options[modvar.."CVoice"] = value
					if type(value) == "string" then
						DBM:PlayCountSound(1, nil, value)
					elseif value > 0 then
						DBM:PlayCountSound(1, value == 3 and DBM.Options.CountdownVoice3 or value == 2 and DBM.Options.CountdownVoice2 or DBM.Options.CountdownVoice)
					end
				end, 22, 25, button)
				frame:SetPoint("LEFT", button, "RIGHT", -20, 2)
				frame2:SetPoint("LEFT", frame, "RIGHT", 18, 0)
				textPad = 37
			else
				frame = self:CreateDropdown(nil, sounds, mod, modvar .. "SWSound", function(value)
					mod.Options[modvar .. "SWSound"] = value
					DBM:PlaySpecialWarningSound(value, true)
				end, 22, 25, button)
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", button, "RIGHT", -20, 2)
				if mod.Options[modvar .. "SWNote"] then -- Mod has note, insert note hack
					---@class DBMPanelButtonWithNote: Button
					frame2 = CreateFrame("Button", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "UIPanelButtonTemplate")
					frame2:SetPoint("LEFT", frame, "RIGHT", 35, 0)
					frame2:SetSize(25, 25)
					frame2:SetText("|TInterface/FriendsFrame/UI-FriendsFrame-Note.blp:14:0:2:-1|t")
					frame2.mytype = "button"
					frame2:SetScript("OnClick", function()
						DBM:ShowNoteEditor(mod, modvar, noteSpellName)
					end)
					textPad = 2
				end
			end
			frame.myheight = 0
			if frame2 then
				frame2.myheight = 0
			else
				textPad = 37
			end
		end
		local buttonText
		if desc then -- Switch all checkbutton frame to SimpleHTML frame (auto wrap)
			buttonText = CreateFrame("SimpleHTML", "$parentText", button)
			buttonText:SetFontObject("p", GameFontNormal)
			buttonText:SetHyperlinksEnabled(true)
			buttonText:SetScript("OnHyperlinkEnter", function(self, data)
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
						local spellName, spellDesc = DBM:EJ_GetSectionInfo(tonumber(contentID))
						GameTooltip:AddLine(spellName or CL.UNKNOWN, 255, 255, 255, 0)
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(spellDesc or CL.UNKNOWN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
					end
				end
				GameTooltip:Show()
				currActiveButton = self:GetParent()
				updateFrame:SetScript("OnUpdate", function()
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
					GameTooltip:ClearAllPoints()
					GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", (x / scale) + 5, (y / scale) + 2)
				end)
				if GetCursorPosition() - self:GetParent():GetCenter() < -100 then
					self:GetParent().fakeHighlight = true
					self:GetParent():LockHighlight()
				end
			end)
			buttonText:SetScript("OnHyperlinkLeave", function(self)
				GameTooltip:Hide()
				updateFrame:SetScript("OnUpdate", nil)
				if self:GetParent().fakeHighlight then
					self:GetParent().fakeHighlight = nil
					self:GetParent():UnlockHighlight()
				end
			end)
			buttonText:SetHeight(25)
			desc = "<html><body><p>" .. desc .. "</p></body></html>"
		else
			buttonText = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormal")
			buttonText:SetPoint("LEFT", button, "RIGHT", 0, 1)
		end
		button.textObj = buttonText
		button.text = desc or CL.UNKNOWN
		if frame2 then
			button.widthPad = frame and frame:GetWidth() + frame2:GetWidth() or 0
		else
			button.widthPad = frame and frame:GetWidth() or 0
		end
		buttonText:SetWidth(self.frame:GetWidth() - button.widthPad)
		if textLeft then
			buttonText:ClearAllPoints()
			buttonText:SetPoint("RIGHT", frame2 or frame or button, "LEFT")
			buttonText:SetJustifyH("p", "RIGHT")
		else
			buttonText:SetJustifyH("p", "LEFT")
			buttonText:SetPoint("TOPLEFT", frame2 or frame or button, "TOPRIGHT", textPad or 0, -5)
		end
		buttonText:SetText(button.text)
		button.myheight = mmax(buttonText:GetContentHeight() + 12, 25)
		if dbmvar and DBM.Options[dbmvar] ~= nil then
			button:SetScript("OnShow", function(self)
				self:SetChecked(DBM.Options[dbmvar])
			end)
			button:SetScript("OnClick", function()
				DBM.Options[dbmvar] = not DBM.Options[dbmvar]
			end)
		end
		if dbtvar then
			button:SetScript("OnShow", function(self)
				self:SetChecked(DBT.Options[dbtvar])
			end)
			button:SetScript("OnClick", function()
				DBT:SetOption(dbtvar, not DBT.Options[dbtvar])
			end)
		end
		if globalvar and _G[globalvar] ~= nil then
			button:SetScript("OnShow", function(self)
				self:SetChecked(_G[globalvar])
			end)
			button:SetScript("OnClick", function()
				_G[globalvar] = not _G[globalvar]
			end)
		end
		self:SetLastObj(button)
		return button
	end
end

function PanelPrototype:CreateArea(name)
	---@class DBMPanelArea: Frame, BackdropTemplate
	local area = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "TooltipBorderBackdropTemplate")
	area.mytype = "area"
	area:SetBackdropColor(0.15, 0.15, 0.15, 0.2)
	area:SetBackdropBorderColor(0.4, 0.4, 0.4)
	local title = area:CreateFontString("$parentTitle", "BACKGROUND", "GameFontHighlightSmall")
	title:SetPoint("BOTTOMLEFT", area, "TOPLEFT", 5, 0)
	title:SetText(parseDescription(name))
	if select("#", self.frame:GetChildren()) == 1 then
		area:SetPoint("TOPLEFT", self.frame, 5, -20)
	else
		area:SetPoint("TOPLEFT", select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -20)
	end
	self:SetLastObj(area)
	return setmetatable({
		frame	= area,
		parent	= self
	}, {
		__index = PanelPrototype
	})
end

local function handleWAKeyHyperlink(_, link)
	local _, linkType, arg1, arg2 = strsplit(":", link)
	if linkType == "DBM" and arg1 == "wacopy" then
		DBM:ShowUpdateReminder(nil, nil, DBM_CORE_L.COPY_WA_DIALOG, arg2)
	end
end

function PanelPrototype:CreateAbility(titleText, icon, spellID, isPrivate)
	---@class DBMPanelAbility: Frame, BackdropTemplate
	local area = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), self.frame, "TooltipBorderBackdropTemplate")
	area.mytype = "ability"
	area.hidden = not DBM.Options.AutoExpandSpellGroups
	area:SetBackdropColor(0.15, 0.15, 0.15, 0.2)
	area:SetBackdropBorderColor(0.4, 0.4, 0.4)
	area:SetHyperlinksEnabled(true)
	area:SetScript("OnHyperlinkClick", handleWAKeyHyperlink)
	if select("#", self.frame:GetChildren()) == 1 then
		area:SetPoint("TOPLEFT", self.frame, 5, -20)
	else
		area:SetPoint("TOPLEFT", select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -20)
	end
	local title = area:CreateFontString("$parentTitle", "BACKGROUND", "GameFontHighlightSmall")
	local key = ""
	if DBM.Options.ShowWAKeys and spellID then
		key = DBM_CORE_L.WEAKAURA_KEY:format(spellID)
	end
	if icon then
		local markup = CreateTextureMarkup(icon, 0, 0, 16, 16, 0, 0, 0, 0, 0, 0)
		if isPrivate then--Second icon for private aura
			local markuptwo = CreateTextureMarkup(132320, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0)
			title:SetText(markup .. ' ' .. titleText .. key .. " " .. markuptwo)
		else
			title:SetText(markup .. ' ' .. titleText .. key)
		end
	else
		if isPrivate then--Still add icon for private aura even if no spell icon
			local markuptwo = CreateTextureMarkup(132320, 0, 0, 18, 18, 0, 0, 0, 0, 0, 0)
			title:SetText(titleText .. key .. " " .. markuptwo)
		else
			title:SetText(titleText .. key)
		end
	end
	title:ClearAllPoints()
	title:SetPoint("BOTTOMLEFT", area, "TOPLEFT", 20, 0)
	title:SetFontObject(GameFontNormal)
	-- Button
	---@class DBMPanelAbilityButton: Button
	---@field toggle Button
	---@field highlight Frame
	local button = CreateFrame("Button", area:GetName() .. "Button", area, "OptionsListButtonTemplate")
	button:ClearAllPoints()
	button:SetPoint("LEFT", title, -15, 0)
	button:Show()
	button:SetSize(18, 18)
	button:SetScript('OnClick', function () end)
	button.toggle:SetNormalTexture(area.hidden and 130838 or 130821) -- "Interface\\Buttons\\UI-PlusButton-UP", "Interface\\Buttons\\UI-MinusButton-UP"
	button.toggle:SetPushedTexture(area.hidden and 130836 or 130820) -- "Interface\\Buttons\\UI-PlusButton-DOWN", "Interface\\Buttons\\UI-MinusButton-DOWN"
	button.toggle:Show()
	button.highlight:Hide()
	button.toggleFunc = function()
		area.hidden = not area.hidden
		button.toggle:SetNormalTexture(area.hidden and 130838 or 130821) -- "Interface\\Buttons\\UI-PlusButton-UP", "Interface\\Buttons\\UI-MinusButton-UP"
		button.toggle:SetPushedTexture(area.hidden and 130836 or 130820) -- "Interface\\Buttons\\UI-PlusButton-DOWN", "Interface\\Buttons\\UI-MinusButton-DOWN"
		_G["DBM_GUI_OptionsFrame"]:DisplayFrame(DBM_GUI.currentViewing)
	end
	--
	self:SetLastObj(area)
	return setmetatable({
		frame	= area,
		parent	= self
	}, {
		__index = PanelPrototype
	})
end

---@return DBMPanel
function DBM_GUI:CreateNewPanel(frameName, frameType, showSub, displayName, forceChildren, addonId, isSeason, isTest)
	---@class DBMPanelFrame: Frame
	local panel = CreateFrame("Frame", "DBM_GUI_Option_" .. self:GetNewID(), _G["DBM_GUI_OptionsFramePanelContainer"])
	panel.mytype = "panel"
	panel.ID = self:GetCurrentID()
	local container = _G["DBM_GUI_OptionsFramePanelContainer"]
	panel:SetSize(container:GetWidth(), container:GetHeight())
	panel:SetPoint("TOPLEFT", "DBM_GUI_OptionsFramePanelContainer", "TOPLEFT")
	panel.displayName = displayName or frameName
	panel.showSub = showSub or showSub == nil
	panel.modId = frameName
	panel.addonId = addonId
	panel.isTest = isTest
	panel.isSeason = isSeason
	panel:Hide()
	if frameType == "option" then
		frameType = 1
	elseif frameType == "RAID" then
		frameType = 2
	elseif frameType == "PARTY" then
		frameType = 3
	elseif frameType == "WORLDBOSS" then
		frameType = 4
	else
		frameType = 5
	end
	---@diagnostic disable-next-line: undefined-field
	self.tabs[frameType]:CreateCategory(panel, self and self.frame and self.frame.ID, forceChildren)
	PanelPrototype:SetLastObj(panel)
	tinsert(self.panels, {
		frame	= panel,
		parent	= self
	})
	panel.panelid = #self.panels
	return setmetatable(self.panels[#self.panels], {
		__index = PanelPrototype
	})
end
