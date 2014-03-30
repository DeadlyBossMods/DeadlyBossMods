-- *********************************************************
-- **               Deadly Boss Mods - GUI                **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author) Contact: mysticalosx@gmail.com (Twitter: @MysticalOS)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://www.dreamgen.cn | diablohudream@gmail.com
--    * ruRU: Swix						stalker.kgv@gmail.com
--    * ruRU: TOM_RUS
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: nBlueWiz					everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- The ex-translators:
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--



local revision =("$Revision$"):sub(12, -3)
local FrameTitle = "DBM_GUI_Option_"	-- all GUI frames get automatically a name FrameTitle..ID

local PanelPrototype = {}
DBM_GUI = {}
setmetatable(PanelPrototype, {__index = DBM_GUI})

local L = DBM_GUI_Translations

local modelFrameCreated = false
local soundsRegistered = false

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local GetSpellInfo = GetSpellInfo
local EJ_GetSectionInfo = EJ_GetSectionInfo

function DBM_GUI:ShowHide(forceshow)
	if forceshow == true then
		self:UpdateModList()
		DBM_GUI_OptionsFrame:Show()

	elseif forceshow == false then
		DBM_GUI_OptionsFrame:Hide()

	else
		if DBM_GUI_OptionsFrame:IsShown() then
			DBM_GUI_OptionsFrame:Hide()
		else
			self:UpdateModList()
			DBM_GUI_OptionsFrame:Show()
		end
	end
end

do
	DBM_GUI_OptionsFrameTab1:SetText(L.OTabBosses)
	DBM_GUI_OptionsFrameTab2:SetText(L.OTabOptions)

	local myid = 100
	local prottypemetatable = {__index = PanelPrototype}
	-- This function creates a new entry in the menu
	--
	--  arg1 = Text for the UI Button
	--  arg2 = nil or ("option" or 2)  ... nil will place as a Boss Mod, otherwise as a Option Tab
	--
	function DBM_GUI:CreateNewPanel(FrameName, FrameTyp, showsub, sortID, DisplayName)
		local panel = CreateFrame('Frame', FrameTitle..self:GetNewID(), DBM_GUI_OptionsFramePanelContainer)
		panel.mytype = "panel"
		panel.sortID = self:GetCurrentID()
		panel:SetWidth(DBM_GUI_OptionsFramePanelContainerFOV:GetWidth())
		panel:SetHeight(DBM_GUI_OptionsFramePanelContainerFOV:GetHeight())
		panel:SetPoint("TOPLEFT", DBM_GUI_OptionsFramePanelContainer, "TOPLEFT")

		panel.name = FrameName
		panel.displayname = DisplayName or FrameName
		panel.showsub = (showsub or showsub == nil)

		if (sortID or 0) > 0 then
			panel.sortid = sortID
		else
			myid = myid + 1
			panel.sortid = myid
		end
		panel:Hide()

		if FrameTyp == "option" or FrameTyp == 2 then
			panel.categoryid = DBM_GUI_Options:CreateCategory(panel, self and self.frame and self.frame.name)
			panel.FrameTyp = 2
		else
			panel.categoryid = DBM_GUI_Bosses:CreateCategory(panel, self and self.frame and self.frame.name)
			panel.FrameTyp = 1
		end

		self:SetLastObj(panel)
		self.panels = self.panels or {}
		table.insert(self.panels, {frame = panel, parent = self, framename = FrameTitle..self:GetCurrentID()})
		local obj = self.panels[#self.panels]
		panel.panelid = #self.panels
		return setmetatable(obj, prottypemetatable)
	end
	
	function PanelPrototype:Refresh()
		self.frame:Hide()
		self.frame:Show()
	end
	
	-- This function don't realy destroy a window, it just hides it
	function PanelPrototype:Destroy()
		if self.frame.FrameTyp == 2 then
			table.remove(DBM_GUI_Options.Buttons, self.frame.categoryid)
		else
			table.remove(DBM_GUI_Bosses.Buttons, self.frame.categoryid)
		end
		table.remove(self.parent.panels, self.frame.panelid)
		self.frame:Hide()
	end

	-- This function renames the Menu Entry for a Panel
	function PanelPrototype:Rename(newname)
		self.frame.name = newname
	end

	-- This function adds areas to group widgets
	--
	--  arg1 = titel of this area
	--  arg2 = width ot the area
	--  arg3 = hight of the area
	--  arg4 = autoplace
	--
	function PanelPrototype:CreateArea(name, width, height, autoplace)
		local area = CreateFrame('Frame', FrameTitle..self:GetNewID(), self.frame, 'OptionsBoxTemplate')
		area.mytype = "area"
		area:SetBackdropBorderColor(0.4, 0.4, 0.4)
		area:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
		_G[FrameTitle..self:GetCurrentID()..'Title']:SetText(name)
		if width ~= nil and width < 0 then
			area:SetWidth( self.frame:GetWidth() -12 + width)
		else
			area:SetWidth(width or self.frame:GetWidth()-12)
		end
		area:SetHeight(height or self.frame:GetHeight()-10)

		if autoplace then
			if select('#', self.frame:GetChildren()) == 1 then
				area:SetPoint('TOPLEFT', self.frame, 5, -17)
			else
				area:SetPoint('TOPLEFT', select(-2, self.frame:GetChildren()) or self.frame, "BOTTOMLEFT", 0, -17)
			end
		end

		self:SetLastObj(area)
		self.areas = self.areas or {}
		table.insert(self.areas, {frame = area, parent = self, framename = FrameTitle..self:GetCurrentID()})
		return setmetatable(self.areas[#self.areas], prottypemetatable)
	end

	function DBM_GUI:GetLastObj()
		return self.lastobject
	end
	function DBM_GUI:SetLastObj(obj)
		self.lastobject = obj
	end
	function DBM_GUI:GetParentsLastObj()
		if self.frame.mytype == "area" then
			return self.parent:GetLastObj()
		else
			return self:GetLastObj()
		end
	end
end

do
	local FrameNames = {}
	function DBM_GUI:AddFrame(FrameName)
		table.insert(FrameNames, FrameName)
	end
	function DBM_GUI:IsPresent(FrameName)
		for k,v in ipairs(FrameNames) do
			if v == FrameName then
				return true
			end
		end
		return false
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

local function MixinSharedMedia3(mediatype, mediatable)
	if not LibStub then return mediatable end
	if not LibStub("LibSharedMedia-3.0", true) then return mediatable end
	-- register some of our own media
	if not soundsRegistered then
		local LSM = LibStub("LibSharedMedia-3.0")
		soundsRegistered = true
		LSM:Register("sound", "Headless Horseman: Laugh", [[Sound\Creature\HeadlessHorseman\Horseman_Laugh_01.ogg]])
		LSM:Register("sound", "Yogg Saron: Laugh", [[Sound\Creature\YoggSaron\UR_YoggSaron_Slay01.ogg]])
		LSM:Register("sound", "Loatheb: I see you", [[Sound\Creature\Loathstare\Loa_Naxx_Aggro02.ogg]])
		LSM:Register("sound", "Lady Malande: Flee", [[Sound\Creature\LadyMalande\BLCKTMPLE_LadyMal_Aggro01.ogg]])
		LSM:Register("sound", "Milhouse: Light You Up", [[Sound\Creature\MillhouseManastorm\TEMPEST_Millhouse_Pyro01.ogg]])
		LSM:Register("sound", "Void Reaver: Marked", [[Sound\Creature\VoidReaver\TEMPEST_VoidRvr_Aggro01.ogg]])
		LSM:Register("sound", "Kaz'rogal: Marked", [[Sound\Creature\KazRogal\CAV_Kaz_Mark02.ogg]])
		LSM:Register("sound", "C'Thun: You Will Die!", [[Sound\Creature\CThun\CThunYouWillDIe.ogg]])
	end
	-- sort LibSharedMedia keys alphabetically (case-insensitive)
	local keytable = {}
	for k in next, LibStub("LibSharedMedia-3.0", true):HashTable(mediatype) do
		table.insert(keytable, k)
	end
	table.sort(keytable, function (a, b) return a:lower() < b:lower() end);
	-- DBM values (mediatable) first, LibSharedMedia values (sorted alphabetically) afterwards
	local result = mediatable
	for i=1,#keytable do
		local k = keytable[i]
		local v = LibStub("LibSharedMedia-3.0", true):HashTable(mediatype)[k]
		-- lol ace .. playsound accepts empty strings.. quite.mp3 wtf!
		-- NPCScan is a dummy inject of a custom sound in Silverdragon, we don't want that.
		if mediatype ~= "sound" or (k ~= "None" and k ~= "NPCScan") then
			-- filter duplicates
			local insertme = true
			for _, v2 in next, result do
				if v2.value == v then
					insertme = false
					break
				end
			end
			if insertme then
				if mediatype == "sound" then
					table.insert(result, {text=k, value=v, sound=true})
				elseif mediatype == "statusbar" then
					table.insert(result, {text=k, value=v, texture=v})
				elseif mediatype == "font" then
					table.insert(result, {text=k, value=v, font=v})
				end
			end
		end
	end
	return result
end

-- This function creates a check box
-- Autoplaced buttons will be placed under the last widget
--
--  arg1 = text right to the CheckBox
--  arg2 = autoplaced (true or nil/false)
--  arg3 = text on left side
--  arg4 = DBM.Options[arg4]
--  arg5 = DBM.Bars:SetOption(arg5, ...)
--
do
	local function cursorInHitBox(frame)
		local x = GetCursorPosition()
		local fX = frame:GetCenter()
		local hitBoxSize = -100 -- default value from the default UI template
		return x - fX < hitBoxSize
	end

	local currActiveButton
	local updateFrame = CreateFrame("Frame")
	local function onUpdate(self, elapsed)
		local inHitBox = cursorInHitBox(currActiveButton)
		if currActiveButton.fakeHighlight and not inHitBox then
			currActiveButton:UnlockHighlight()
			currActiveButton.fakeHighlight = nil
		elseif not currActiveButton.fakeHighlight and inHitBox then
			currActiveButton:LockHighlight()
			currActiveButton.fakeHighlight = true
		end
		local x, y = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		x, y = x / scale, y / scale
		GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", x + 5, y + 2)
	end

	local function onHyperlinkClick(self, data, link)
		if IsShiftKeyDown() then
			local msg = link:gsub("|h(.*)|h", "|h[%1]|h")
			local chatWindow = ChatEdit_GetActiveWindow()
			if chatWindow then
				chatWindow:Insert(msg)
			end
		elseif not IsShiftKeyDown() then
			local linkType = strsplit(":", data)
			if linkType == "http" then
				local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
				if (not ChatFrameEditBox:IsShown()) then
					ChatEdit_ActivateChat(ChatFrameEditBox)
				end
				ChatFrameEditBox:Insert(data)
				ChatFrameEditBox:HighlightText()
				return
			end
			if cursorInHitBox(self:GetParent()) then
				self:GetParent():Click()
			end
		end
	end

	local function onHyperlinkEnter(self, data, link)
		GameTooltip:SetOwner(self, "ANCHOR_NONE") -- I want to anchor BOTTOMLEFT of the tooltip to the cursor... (not BOTTOM as in ANCHOR_CURSOR)
		local linkType = strsplit(":", data)
		if linkType == "http" then return end
		if linkType ~= "journal" then
			GameTooltip:SetHyperlink(data)
		else -- "journal:contentType:contentID:difficulty"
			local _, contentType, contentID = strsplit(":", data)
			if contentType == "2" then -- EJ section
				local name, description = EJ_GetSectionInfo(tonumber(contentID))
				GameTooltip:AddLine(name or DBM_CORE_UNKNOWN, 255, 255, 255, 0)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(description or DBM_CORE_UNKNOWN, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			end
		end
		GameTooltip:Show()
		currActiveButton = self:GetParent()
		updateFrame:SetScript("OnUpdate", onUpdate)
		if cursorInHitBox(self:GetParent()) then
			self:GetParent().fakeHighlight = true
			self:GetParent():LockHighlight()
		end
	end

	local function onHyperlinkLeave(self, data, link)
		GameTooltip:Hide()
		updateFrame:SetScript("OnUpdate", nil)
		if self:GetParent().fakeHighlight then
			self:GetParent().fakeHighlight = nil
			self:GetParent():UnlockHighlight()
		end
	end

	local function replaceSpellLinks(id)
		local spellId = tonumber(id)
		local spellName = GetSpellInfo(spellId)
		if not spellName then
			spellName = DBM_CORE_UNKNOWN
			if DBM.Options.DebugMode then
				print("Spell ID not exists: "..spellId)
			end
		end
		return ("|cff71d5ff|Hspell:%d|h%s|h|r"):format(spellId, spellName)
	end

	local function replaceJournalLinks(id)
		if DBM.Options.DebugMode then
			local check = EJ_GetSectionInfo(tonumber(id))
			if not check then 
				print("Journal ID not exists: "..id)
			end
		end
		local link = select(9, EJ_GetSectionInfo(tonumber(id))) or DBM_CORE_UNKNOWN
		return link:gsub("|h%[(.*)%]|h", "|h%1|h")
	end

	local sounds = MixinSharedMedia3("sound", {
		{ sound=true, text = "SW 1", value = 1 },
		{ sound=true, text = "SW 2", value = 2 },
		{ sound=true, text = "SW 3", value = 3 },
	})

	function PanelPrototype:CreateCheckButton(name, autoplace, textleft, dbmvar, dbtvar, soundVal, mod)
		if not name then
			return
		end
		if type(name) == "number" then
			return DBM:AddMsg("CreateCheckButton: error: expected string, received number. You probably called mod:NewTimer(optionId) with a spell id.")
		end
		local button = CreateFrame('CheckButton', FrameTitle..self:GetNewID(), self.frame, 'OptionsCheckButtonTemplate')
		local buttonName = button:GetName()
		button.myheight = 25
		button.mytype = "checkbutton"
		-- font strings do not support hyperlinks, so check if we need one...
		if name:find("%$spell:ej") then -- it is in fact a journal link :-)
			name = name:gsub("%$spell:ej(%d+)", "$journal:%1")
		end
		if name:find("%$spell:") then
			name = name:gsub("%$spell:(%d+)", replaceSpellLinks)
		end
		if name:find("%$journal:") then
			name = name:gsub("%$journal:(%d+)", replaceJournalLinks)
		end
		local dropdown
		if soundVal and DBM.Options.ShowAdvSWSound then
			dropdown = self:CreateDropdown(nil,sounds,mod.Options[soundVal], function(value)
				mod.Options[soundVal] = value
				DBM:PlaySpecialWarningSound(value)
			end, 20, button)
			dropdown:SetScript("OnShow", function(self)
				self:SetSelectedValue(mod.Options[soundVal])
			end)
		end
		local textbeside = button
		local textpad = 0
		local html
		if dropdown then
			dropdown:SetPoint("LEFT", button, "RIGHT", -20, 0)
			textbeside = dropdown
			textpad = 35
		end
		if name then -- switch all checkbutton frame to SimpleHTML frame (auto wrap)
			_G[buttonName.."Text"] = CreateFrame("SimpleHTML", buttonName.."Text", button)
			html = _G[buttonName.."Text"]
			html:SetFontObject("GameFontNormal")
			html:SetHyperlinksEnabled(true)
			html:SetScript("OnHyperlinkClick", onHyperlinkClick)
			html:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
			html:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
			html:SetHeight(25)
			-- oscarucb: proper html encoding is required here for hyperlink line wrapping to work correctly
			name = "<html><body><p>"..name.."</p></body></html>"
		end
		_G[buttonName .. 'Text']:SetWidth( self.frame:GetWidth() - 57 - ((dropdown and dropdown:GetWidth()) or 0))
		_G[buttonName .. 'Text']:SetText(name or DBM_CORE_UNKNOWN)

		if textleft then
			_G[buttonName .. 'Text']:ClearAllPoints()
			_G[buttonName .. 'Text']:SetPoint("RIGHT", textbeside, "LEFT", 0, 0)
			_G[buttonName .. 'Text']:SetJustifyH("RIGHT")
		else
			_G[buttonName .. 'Text']:SetJustifyH("LEFT")
		end

		if html and not textleft then
			html:SetHeight(1) -- oscarucb: hack to discover wrapped height, so we can space multi-line options
			html:SetPoint("TOPLEFT",UIParent)
			local ht = select(4,html:GetBoundsRect()) or 25
			html:ClearAllPoints()
			html:SetPoint("TOPLEFT", textbeside, "TOPRIGHT", textpad, -4)
			html:SetHeight(ht)
			button.myheight = math.max(ht+12,button.myheight)
		end

		if dbmvar and DBM.Options[dbmvar] ~= nil then
			button:SetScript("OnShow",  function(self) button:SetChecked(DBM.Options[dbmvar]) end)
			button:SetScript("OnClick", function(self) DBM.Options[dbmvar] = not DBM.Options[dbmvar] end)
		end

		if dbtvar then
			button:SetScript("OnShow",  function(self) button:SetChecked( DBM.Bars:GetOption(dbtvar) ) end)
			button:SetScript("OnClick", function(self) DBM.Bars:SetOption(dbtvar, not DBM.Bars:GetOption(dbtvar)) end)
		end

		if autoplace then
			local x = self:GetLastObj()
			if x.mytype == "checkbutton" then
				button:ClearAllPoints()
				button:SetPoint('TOPLEFT', x, "TOPLEFT", 0, -x.myheight)
			else
				button:ClearAllPoints()
				button:SetPoint('TOPLEFT', 10, -12)
			end
		end

		self:SetLastObj(button)
		return button
	end

end

do
	local function unfocus(self)
		self:ClearFocus()
	end
	-- This function creates an EditBox
	--
	--  arg1 = Title text, placed ontop of the EditBox
	--  arg2 = Text placed within the EditBox
	--  arg3 = width
	--  arg4 = height
	--
	function PanelPrototype:CreateEditBox(text, value, width, height)
		local textbox = CreateFrame('EditBox', FrameTitle..self:GetNewID(), self.frame, 'DBM_GUI_FrameEditBoxTemplate')
		textbox.mytype = "textbox"
		_G[FrameTitle..self:GetCurrentID().."Text"]:SetText(text)
		textbox:SetWidth(width or 100)
		textbox:SetHeight(height or 20)
		textbox:SetScript("OnEscapePressed", unfocus)
		textbox:SetScript("OnTabPressed", unfocus)
		if type(value) == "string" then
			textbox:SetText(value)
		end
		self:SetLastObj(textbox)
		return textbox
	end
end

-- This function creates a ScrollingMessageFrame (usefull for log entrys)
--
--  arg1 = width of the frame
--  arg2 = height
--  arg3 = insertmode (BOTTOM or TOP)
--  arg4 = enable message fading (default disabled)
--  arg5 = fontobject (font for the messages)
--
function PanelPrototype:CreateScrollingMessageFrame(width, height, insertmode, fading, fontobject)
	local scrollframe = CreateFrame("ScrollingMessageFrame",FrameTitle..self:GetNewID(), self.frame)
	scrollframe:SetWidth(width or 200)
	scrollframe:SetHeight(height or 150)
	scrollframe:SetJustifyH("LEFT")
	if not fading then
		scrollframe:SetFading(false)
	end
--	scrollframe:SetInsertMode(insertmode or "BOTTOM")
	scrollframe:SetFontObject(fontobject or "GameFontNormal")
	scrollframe:SetMaxLines(2000)
	scrollframe:EnableMouse(true)
	scrollframe:EnableMouseWheel(1)

	scrollframe:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow)
	scrollframe:SetScript("OnMouseWheel", function(self, delta)
		if delta == 1 then
			self:ScrollUp()
		elseif delta == -1 then
			self:ScrollDown()
		end
	end)

	self:SetLastObj(scrollframe)
	return scrollframe
end


-- This function creates a slider for numeric values
--
--  arg1 = text ontop of the slider, centered
--  arg2 = lowest value
--  arg3 = highest value
--  arg4 = stepping
--  arg5 = framewidth
--
do
	local function onValueChanged(font, text)
		return function(self, value)
			font:SetFormattedText(text, value)
		end
	end
	function PanelPrototype:CreateSlider(text, low, high, step, framewidth)
		local slider = CreateFrame('Slider', FrameTitle..self:GetNewID(), self.frame, 'OptionsSliderTemplate')
		slider.mytype = "slider"
		slider:SetMinMaxValues(low, high)
		slider:SetValueStep(step)
		slider:SetWidth(framewidth or 180)
		_G[FrameTitle..self:GetCurrentID()..'Text']:SetText(text)
		slider:SetScript("OnValueChanged", onValueChanged(_G[FrameTitle..self:GetCurrentID()..'Text'], text))
		self:SetLastObj(slider)
		return slider
	end
end

-- This function creates a color picker
--
--  arg1 = width of the colorcircle (128 default)
--  arg2 = true if you want an alpha selector
--  arg3 = width of the alpha selector (32 default)

function PanelPrototype:CreateColorSelect(dimension, withalpha, alphawidth)
	--- Color select texture with wheel and value
	local colorselect = CreateFrame("ColorSelect", FrameTitle..self:GetNewID(), self.frame)
	colorselect.mytype = "colorselect"
	if withalpha then
		colorselect:SetWidth((dimension or 128)+37)
	else
		colorselect:SetWidth((dimension or 128))
	end
	colorselect:SetHeight(dimension or 128)

	-- create a color wheel
	local colorwheel = colorselect:CreateTexture()
	colorwheel:SetWidth(dimension or 128)
	colorwheel:SetHeight(dimension or 128)
	colorwheel:SetPoint("TOPLEFT", colorselect, "TOPLEFT", 5, 0)
	colorselect:SetColorWheelTexture(colorwheel)

	-- create the colorpicker
	local colorwheelthumbtexture = colorselect:CreateTexture()
	colorwheelthumbtexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
	colorwheelthumbtexture:SetWidth(10)
	colorwheelthumbtexture:SetHeight(10)
	colorwheelthumbtexture:SetTexCoord(0,0.15625, 0, 0.625)
	colorselect:SetColorWheelThumbTexture(colorwheelthumbtexture)

	if withalpha then
		-- create the alpha bar
		local colorvalue = colorselect:CreateTexture()
		colorvalue:SetWidth(alphawidth or 32)
		colorvalue:SetHeight(dimension or 128)
		colorvalue:SetPoint("LEFT", colorwheel, "RIGHT", 10, -3)
		colorselect:SetColorValueTexture(colorvalue)

		-- create the alpha arrows
		local colorvaluethumbtexture = colorselect:CreateTexture()
		colorvaluethumbtexture:SetTexture("Interface\\Buttons\\UI-ColorPicker-Buttons")
		colorvaluethumbtexture:SetWidth( alphawidth/32 * 48)
		colorvaluethumbtexture:SetHeight( alphawidth/32 * 14)
		colorvaluethumbtexture:SetTexCoord(0.25, 1, 0.875, 0)
		colorselect:SetColorValueThumbTexture(colorvaluethumbtexture)
	end

	self:SetLastObj(colorselect)
	return colorselect
end


-- This function creates a button
--
--  arg1 = text on the button "OK", "Cancel",...
--  arg2 = widht
--  arg3 = height
--  arg4 = function to call when clicked
--
function PanelPrototype:CreateButton(title, width, height, onclick, FontObject)
	local button = CreateFrame('Button', FrameTitle..self:GetNewID(), self.frame, 'DBM_GUI_OptionsFramePanelButtonTemplate')
	local buttonName = button:GetName()
	button.mytype = "button"
	button:SetWidth(width or 100)
	button:SetHeight(height or 20)
	button:SetText(title)
	if onclick then
		button:SetScript("OnClick", onclick)
	end
	if FontObject then
		button:SetNormalFontObject(FontObject)
		button:SetHighlightFontObject(FontObject)
	end
	if _G[buttonName.."Text"]:GetStringWidth() > button:GetWidth() then
		button:SetWidth( _G[buttonName.."Text"]:GetStringWidth() + 25 )
	end

	self:SetLastObj(button)
	return button
end

-- This function creates a text block for descriptions
--
--  arg1 = text to write
--  arg2 = width to set
function PanelPrototype:CreateText(text, width, autoplaced, style, justify)
	local textblock = self.frame:CreateFontString(FrameTitle..self:GetNewID(), "ARTWORK")
	textblock.mytype = "textblock"
	if not style then
		textblock:SetFontObject(GameFontNormal)
	else
		textblock:SetFontObject(style)
	end
	textblock:SetText(text)
	if justify then
		textblock:SetJustifyH(justify)
	else
		textblock:SetJustifyH("CENTER")
	end

	if width then
		textblock:SetWidth( width or 100 )
	else
		textblock:SetWidth( self.frame:GetWidth() )
	end

	if autoplaced then
		textblock:SetPoint('TOPLEFT',self.frame, "TOPLEFT", 10, -10)
	end

	self:SetLastObj(textblock)
	return textblock
end


function PanelPrototype:CreateCreatureModelFrame(width, height, creatureid)
	local ModelFrame = CreateFrame('PlayerModel', FrameTitle..self:GetNewID(), self.frame)
	ModelFrame.mytype = "modelframe"
	ModelFrame:SetWidth(width or 100)
	ModelFrame:SetHeight(height or 200)
	ModelFrame:SetCreature(tonumber(creatureid) or 448)	-- Hogger!!! he kills all of you

	self:SetLastObj(ModelFrame)
	return ModelFrame
end

function PanelPrototype:AutoSetDimension()
	if not self.frame.mytype == "area" then return end
	local height = self.frame:GetHeight()

	local need_height = 25

	local kids = { self.frame:GetChildren() }
	for _, child in pairs(kids) do
		if child.myheight and type(child.myheight) == "number" then
			need_height = need_height + child.myheight
		else
			need_height = need_height + child:GetHeight() + 50
		end
	end

	self.frame.myheight = need_height + 25
	self.frame:SetHeight(need_height)
end

function PanelPrototype:SetMyOwnHeight()
	if not self.frame.mytype == "panel" then return end

	local need_height = 30

	local kids = { self.frame:GetChildren() }
	for _, child in pairs(kids) do
		if child.mytype == "area" and child.myheight then
			need_height = need_height + child.myheight
		elseif child.mytype == "area" then
			need_height = need_height + child:GetHeight() + 30
		elseif child.myheight then
			need_height = need_height +  child.myheight
		end
	end
	self.frame.actualHeight = need_height -- HACK: work-around for some strange bug, panels that are overriden (e.g. stats panels when the mod is loaded) are behaving strange since 4.1. GetHeight() will always return the height of the old panel and not of the new...
	self.frame:SetHeight(need_height)
end


local ListFrameButtonsPrototype = {}
-- Prototyp for ListFrame Options Buttons

function ListFrameButtonsPrototype:CreateCategory(frame, parent)
	if not type(frame) == "table" then
		DBM:AddMsg("Failed to create category - frame is not a table")
		DBM:AddMsg(debugstack())
		return false
	elseif not frame.name then
		DBM:AddMsg("Failed to create category - frame.name is missing")
		DBM:AddMsg(debugstack())
		return false
	elseif self:IsPresent(frame.name) then
		DBM:AddMsg("Frame ("..frame.name..") already exists")
		DBM:AddMsg(debugstack())
		return false
	end

	if parent then
		frame.depth = self:GetDepth(parent)
	else
		frame.depth = 1
	end

	self:SetParentHasChilds(parent)

	table.insert(self.Buttons, {
		frame = frame,
		parent = parent
	})
	return #self.Buttons
end

function ListFrameButtonsPrototype:IsPresent(framename)
	for k,v in ipairs(self.Buttons) do
		if v.frame.name == framename then
			return true
		end
	end
	return false
end

function ListFrameButtonsPrototype:GetDepth(framename, depth)
	depth = depth or 1
	for k,v in ipairs(self.Buttons) do
		if v.frame.name == framename then
			if v.parent == nil then
				return depth+1
			else
				depth = depth + self:GetDepth(v.parent, depth)
			end
		end
	end
	return depth
end

function ListFrameButtonsPrototype:SetParentHasChilds(parent)
	if not parent then return end
	for k,v in ipairs(self.Buttons) do
		if v.frame.name == parent then
			v.frame.haschilds = true
		end
	end
end


do
	local mytable = {}
	function ListFrameButtonsPrototype:GetVisibleTabs()
		table.wipe(mytable)
		for k,v in ipairs(self.Buttons) do
			if v.parent == nil then
				table.insert(mytable, v)

				if v.frame.showsub then
					self:GetVisibleSubTabs(v.frame.name, mytable)
				end
			end
		end
		return mytable
	end
end

function ListFrameButtonsPrototype:GetVisibleSubTabs(parent, t)
	for i, v in ipairs(self.Buttons) do
		if v.parent == parent then
			table.insert(t, v)
			if v.frame.showsub then
				self:GetVisibleSubTabs(v.frame.name, t)
			end
		end
	end
end

local CreateNewFauxScrollFrameList
do
	local mt = {__index = ListFrameButtonsPrototype}
	function CreateNewFauxScrollFrameList()
		return setmetatable({ Buttons={} }, mt)
	end
end

DBM_GUI_Bosses = CreateNewFauxScrollFrameList()
DBM_GUI_Options = CreateNewFauxScrollFrameList()


local UpdateAnimationFrame, CreateAnimationFrame
do
	local function HideScrollBar(frame)
		local frameName = frame:GetName()
		local list = _G[frameName .. "List"]
		list:Hide()
		local listWidth = list:GetWidth()
		for _, button in next, frame.buttons do
			button:SetWidth(button:GetWidth() + listWidth)
		end
	end

	local function DisplayScrollBar(frame)
		local list = _G[frame:GetName() .. "List"]
		list:Show()
		local listWidth = list:GetWidth()
		for _, button in next, frame.buttons do
			button:SetWidth(button:GetWidth() - listWidth)
		end
	end

	-- the functions in this block are only used to
	-- create/update/manage the Fauxscrollframe for Boss/Options Selection
	local displayedElements = {}

	-- This function is for internal use.
	-- Function to update the left scrollframe buttons with the menu entries
	function DBM_GUI_OptionsFrame:UpdateMenuFrame(listframe)
		local frameName = listframe:GetName()
		local offset = _G[frameName.."List"].offset
		local buttons = listframe.buttons
		local TABLE

		if not buttons then return false end

		if listframe:GetParent().tab == 2 then
			TABLE = DBM_GUI_Options:GetVisibleTabs()
		else
			TABLE = DBM_GUI_Bosses:GetVisibleTabs()
		end
		local element

		for i, element in ipairs(displayedElements) do
			displayedElements[i] = nil
		end

		for i, element in ipairs(TABLE) do
			table.insert(displayedElements, element.frame)
		end


		local numAddOnCategories = #displayedElements
		local numButtons = #buttons

		if ( numAddOnCategories > numButtons and ( not listframe:IsShown() ) ) then
			DisplayScrollBar(listframe)
		elseif ( numAddOnCategories <= numButtons and ( listframe:IsShown() ) ) then
			HideScrollBar(listframe)
		end

		if ( numAddOnCategories > numButtons ) then
			_G[frameName.."List"]:Show()
			_G[frameName.."ListScrollBar"]:SetMinMaxValues(0, (numAddOnCategories - numButtons) * buttons[1]:GetHeight())
			_G[frameName.."ListScrollBar"]:SetValueStep( buttons[1]:GetHeight() )
		else
			_G[frameName.."ListScrollBar"]:SetValue(0)
			_G[frameName.."List"]:Hide()
		end

		local selection = DBM_GUI_OptionsFrameBossMods.selection
		if ( selection ) then
			DBM_GUI_OptionsFrame:ClearSelection(listframe, listframe.buttons)
		end

		for i = 1, #buttons do
			element = displayedElements[i + offset]
			if ( not element ) then
				DBM_GUI_OptionsFrame:HideButton(buttons[i])
			else
				DBM_GUI_OptionsFrame:DisplayButton(buttons[i], element)

				if ( selection ) and ( selection == element ) and ( not listframe.selection ) then
					DBM_GUI_OptionsFrame:SelectButton(listframe, buttons[i])
				end
			end
		end
	end

	-- This function is for internal use.
	-- Used to show a button from the list
	function DBM_GUI_OptionsFrame:DisplayButton(button, element)
		button:Show()
		button.element = element

		button.text:ClearAllPoints()
		button.text:SetPoint("LEFT", 12 + 8 * element.depth, 2)
		button.text:SetFontObject(GameFontNormalSmall)
		button.toggle:ClearAllPoints()
		button.toggle:SetPoint("LEFT", 8 * element.depth - 2, 1)

		if element.depth > 2 then
			button:SetNormalFontObject(GameFontHighlightSmall)
			button:SetHighlightFontObject(GameFontHighlightSmall)

		elseif element.depth > 1  then
			button:SetNormalFontObject(GameFontNormalSmall)
			button:SetHighlightFontObject(GameFontNormalSmall)
		else
			button:SetNormalFontObject(GameFontNormal)
			button:SetHighlightFontObject(GameFontNormal)
		end
		button:SetWidth(185)

		if element.haschilds then
			if not element.showsub then
				button.toggle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
				button.toggle:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
			else
				button.toggle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
				button.toggle:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
			end
			button.toggle:Show()
		else
			button.toggle:Hide()
		end

		button.text:SetText(element.displayname)
		button.text:Show()
	end

	-- This function is for internal use.
	-- Used to hide a button from the list
	function DBM_GUI_OptionsFrame:HideButton(button)
		button:Hide()
	end

	-- This function is for internal use.
	-- Called when a new entry is selected
	function DBM_GUI_OptionsFrame:ClearSelection(listFrame, buttons)
		for _, button in ipairs(buttons) do button:UnlockHighlight() end
		listFrame.selection = nil
	end

	-- This function is for Internal use.
	-- Called when a button is selected
	function DBM_GUI_OptionsFrame:SelectButton(listFrame, button)
		button:LockHighlight()
		listFrame.selection = button.element
	end

	-- This function is for Internal use.
	-- Required to create a list of buttons in the scrollframe
	function DBM_GUI_OptionsFrame:CreateButtons(frame)
		local name = frame:GetName()

		frame.scrollBar = _G[name.."ListScrollBar"]
		frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
		_G[name.."Bottom"]:SetVertexColor(0.66, 0.66, 0.66)

		local buttons = {}
		local button = CreateFrame("BUTTON", name.."Button1", frame, "DBM_GUI_FrameButtonTemplate")
		button:SetPoint("TOPLEFT", frame, 0, -8)
		frame.buttonHeight = button:GetHeight()
		table.insert(buttons, button)

		local maxButtons = (frame:GetHeight() - 8) / frame.buttonHeight
		for i = 2, maxButtons do
			button = CreateFrame("BUTTON", name.."Button"..i, frame, "DBM_GUI_FrameButtonTemplate")
			button:SetPoint("TOPLEFT", buttons[#buttons], "BOTTOMLEFT")
			table.insert(buttons, button)
		end
		frame.buttons = buttons
	end

	-- This function is for internal use.
	-- Called when someone clicks a Button
	function DBM_GUI_OptionsFrame:OnButtonClick(button)
		local parent = button:GetParent()
		local buttons = parent.buttons
		local buttonName = DBM_GUI_OptionsFrame:GetName()

		self:ClearSelection(_G[buttonName.."BossMods"],   _G[buttonName.."BossMods"].buttons)
		self:ClearSelection(_G[buttonName.."DBMOptions"], _G[buttonName.."DBMOptions"].buttons)
		self:SelectButton(parent, button)

		self:DisplayFrame(button.element)
	end

	function DBM_GUI_OptionsFrame:ToggleSubCategories(button)
		local parent = button:GetParent()
		if parent.element.showsub then
			parent.element.showsub = false
		else
			parent.element.showsub = true
		end
		self:UpdateMenuFrame(parent:GetParent())
	end

	-- This function is for internal use.
	-- places the selected tab on the container frame
	function DBM_GUI_OptionsFrame:DisplayFrame(frame)
		local container = _G[self:GetName().."PanelContainer"]

		if not (type(frame) == "table" and type(frame[0]) == "userdata") or select("#", frame:GetChildren()) == 0 then
--			DBM:AddMsg(debugstack())
			return
		end

		local changed = container.displayedFrame ~= frame
		if ( container.displayedFrame ) then
			container.displayedFrame:Hide()
		end
		container.displayedFrame = frame

		DBM_GUI_OptionsFramePanelContainerHeaderText:SetText( frame.displayname )

		local mymax = (frame.actualHeight or frame:GetHeight()) - container:GetHeight()

		if mymax <= 0 then mymax = 0 end
		local frameName = container:GetName()
		if mymax > 0 then
			_G[frameName.."FOV"]:Show()
			_G[frameName.."FOV"]:SetScrollChild(frame)
			_G[frameName.."FOVScrollBar"]:SetMinMaxValues(0, mymax)
			local val = _G[frameName.."FOVScrollBar"]:GetValue() or 0
			if changed then
			  _G[frameName.."FOVScrollBar"]:SetValue(0) -- scroll to top, and ensure widget appears
			end

			if frame.isfixed then
				frame.isfixed = nil
				local listwidth = _G[frameName.."FOVScrollBar"]:GetWidth()
				for i=1, select("#", frame:GetChildren()), 1 do
					local child = select(i, frame:GetChildren())
					if child.mytype == "area" then
						child:SetWidth( child:GetWidth() - listwidth - 1 )
					end
				end
			end
		else
			_G[frameName.."FOV"]:Hide()
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", container ,"TOPLEFT", 5, 0)
			frame:SetPoint("BOTTOMRIGHT", container ,"BOTTOMRIGHT", 0, 0)

			if not frame.isfixed then
				frame.isfixed = true
				local listwidth = _G[frameName.."FOVScrollBar"]:GetWidth()
				for i=1, select("#", frame:GetChildren()), 1 do
					local child = select(i, frame:GetChildren())
					if child.mytype == "area" then
						child:SetWidth( child:GetWidth() + listwidth )
					end
				end
			end
		end
		frame:Show()

		if DBM.Options.EnableModels then
			if not modelFrameCreated then
				CreateAnimationFrame()
			end
			DBM_BossPreview.enabled = false
			DBM_BossPreview:Hide()
			for _, mod in ipairs(DBM.Mods) do
				if mod.panel and mod.panel.frame and mod.panel.frame == frame then
					UpdateAnimationFrame(mod)
				end
			end
		end
	end

end

function UpdateAnimationFrame(mod)
	DBM_BossPreview.currentMod = mod
	local displayId = nil

--[[ This way will break the Encounter Journal GUI .. needs a "fix" before activating
	if mod.encounterId and mod.instanceId then
		EJ_SetDifficulty(true, true)
		EncounterJournal.instanceID = mod.instanceId
		EncounterJournal_Refresh(EncounterJournal.encounter)
		EncounterJournal.encounterID = mod.encounterId
		EncounterJournal_Refresh(EncounterJournal.encounter)
		displayId = EncounterJournal.encounter["creatureButton1"].displayInfo
	end]]

	DBM_BossPreview:Show()
	DBM_BossPreview:ClearModel()
	DBM_BossPreview:SetDisplayInfo(displayId or mod.modelId or 0)
	DBM_BossPreview:SetSequence(4)
	if DBM.Options.ModelSoundValue == "Short" then
		if DBM.Options.UseMasterVolume then
			PlaySoundFile(mod.modelSoundShort or 0, "Master")
		else
			PlaySoundFile(mod.modelSoundShort or 0)
		end
	elseif DBM.Options.ModelSoundValue == "Long" then
		if DBM.Options.UseMasterVolume then
			PlaySoundFile(mod.modelSoundLong or 0, "Master")
		else
			PlaySoundFile(mod.modelSoundLong or 0)
		end
	end

--[[	** FANCY STUFF WE DO NOT USE FOR NOW **
	DBM_BossPreview:SetModelScale(mod.modelScale or 0.5)

	DBM_BossPreview.atime = 0
	DBM_BossPreview.apos = 0
	DBM_BossPreview.rotation = 0
	DBM_BossPreview.modelRotation = mod.modelRotation or -60
	DBM_BossPreview.modelOffsetX = mod.modelOffsetX or 0
	DBM_BossPreview.modelOffsetY = mod.modelOffsetY or 0
	DBM_BossPreview.modelOffsetZ = mod.modelOffsetZ or 0
	DBM_BossPreview.modelscale = mod.modelScale or 0.5
	DBM_BossPreview.modelMoveSpeed = mod.modelMoveSpeed or 1
	DBM_BossPreview.pos_x = 0.5
	DBM_BossPreview.pos_y = 0.1
	DBM_BossPreview.pos_z = 0
	DBM_BossPreview.alpha = 1
	DBM_BossPreview.scale = 0
	DBM_BossPreview.apos = 0
	DBM_BossPreview:SetAlpha(DBM_BossPreview.alpha)
	DBM_BossPreview:SetFacing( DBM_BossPreview.modelRotation  *math.pi/180)
	DBM_BossPreview:SetPosition(
		DBM_BossPreview.pos_z + DBM_BossPreview.modelOffsetZ,
		DBM_BossPreview.pos_x + DBM_BossPreview.modelOffsetX,
		DBM_BossPreview.pos_y + DBM_BossPreview.modelOffsetY)
	DBM_BossPreview.enabled = true
--]]
end

local function CreateAnimationFrame()
	modelFrameCreated = true
	local mobstyle = CreateFrame('PlayerModel', "DBM_BossPreview", DBM_GUI_OptionsFramePanelContainer)
	mobstyle:SetPoint("BOTTOMRIGHT", DBM_GUI_OptionsFramePanelContainer, "BOTTOMRIGHT", -5, 5)
	mobstyle:SetWidth( 300 )
	mobstyle:SetHeight( 230 )
	mobstyle:SetPortraitZoom(0.4)
	mobstyle:SetRotation(0)
	mobstyle:SetClampRectInsets(0, 0, 24, 0)

--[[    ** FANCY STUFF WE DO NOT USE FOR NOW **

	mobstyle.playlist = { 	-- start animation outside of our fov
				{set_y = 0, set_x = 1.1, set_z = 0, setfacing = -90, setalpha = 1},
				-- wait outside fov befor begining
				{mintime = 1000, maxtime = 7000},	-- randomtime to wait
				-- {time = 10000},  			-- just wait 10 seconds

				-- move in the fov and to waypoint #1
				{animation = 4, time = 1500, move_x = -0.7},
				{animation = 0, time = 10, endfacing = -90 }, -- rotate in an animation

				-- stay on waypoint #1
				{setfacing = -90},
				{animation = 0, time = 10000},
				--{animation = 0, time = 2000, randomanimation = {45,46,47}},	-- play a random emote

				-- move to next waypoint
				{setfacing = -90},
				{animation = 4, time = 5000, move_x = -2.5},

				-- stay on waypoint #2
				{setfacing = 0},
				{animation = 0, time = 10000,},


				-- move to the horizont
				{setfacing = 180},
				{animation = 4, time = 10000, toscale=0.005},

				-- die and despawn
				{animation = 1, time = 5000},
				{animation = 6, time = 2000, toalpha = 0},

				-- we want so sleep a little while on animation end
				{mintime = 1000, maxtime = 3000},
	}

	mobstyle.animationTypes = {1, 4, 5, 14, 40} -- die, walk, run, kneel?, swim/fly
	mobstyle.animation = 3
	mobstyle:SetScript("OnUpdate", function(self, e)
		if not self.enabled then return end

		self.atime = self.atime + e*1000

		if self.atime >= 10000 then
			mobstyle.animation = floor(math.random(1, #mobstyle.animationTypes))
			self.atime = 0
		end
		self:SetSequenceTime(mobstyle.animationTypes[mobstyle.animation], self.atime)
	end)

	mobstyle:SetScript("OnUpdate", function(self, e)
		--if true then return end
		if not self.enabled then return end
		self.atime = self.atime + e * 1000
		if self.apos == 0 or self.atime >= (self.playlist[self.apos].time or 0) then
			self.apos = self.apos + 1
			if self.apos <= #self.playlist and self.playlist[self.apos].setfacing then
				self:SetFacing( (self.playlist[self.apos].setfacing + self.modelRotation) * math.pi/180)
			end
			if self.apos <= #self.playlist and self.playlist[self.apos].setalpha then
				self:SetAlpha(self.playlist[self.apos].setalpha)
			end
			if self.apos <= #self.playlist and (self.playlist[self.apos].set_y or self.playlist[self.apos].set_x or self.playlist[self.apos].set_z) then
				self.pos_y = self.playlist[self.apos].set_y or self.pos_y
				self.pos_x = self.playlist[self.apos].set_x or self.pos_x
				self.pos_z = self.playlist[self.apos].set_z or self.pos_z
				self:SetPosition(
					self.pos_z + self.modelOffsetZ,
					self.pos_x + self.modelOffsetX,
					self.pos_y + self.modelOffsetY
				)
			end
			if self.apos > #self.playlist then

				self:SetAlpha(1)
				self:SetModelScale(1.0)
				self:SetPosition(0, 0, 0)
				self:SetCreature(self.currentMod.modelId or self.currentMod.creatureId or 0)

				self.apos = 0
				self.pos_x = 0
				self.pos_y = 0
				self.pos_z = 0
				self.alpha = 1
				self.scale = self.modelscale

				self:SetAlpha(self.alpha)
				self:SetFacing(self.modelRotation)
				self:SetModelScale(self.modelscale)
				self:SetPosition(
					self.pos_z + self.modelOffsetZ,
					self.pos_x + self.modelOffsetX,
					self.pos_y + self.modelOffsetY
				)
				return
			end
			self.rotation = self:GetFacing()
			if self.playlist[self.apos].randomanimation then
				self.playlist[self.apos].animation = self.playlist[self.apos].randomanimation[math.random(1, #self.playlist[self.apos].randomanimation)]
			end
			if self.playlist[self.apos].mintime and self.playlist[self.apos].maxtime then
				self.playlist[self.apos].time = math.random(self.playlist[self.apos].mintime, self.playlist[self.apos].maxtime)
			end


			self.atime = 0
			self.playlist[self.apos].animation = self.playlist[self.apos].animation or 0
			self:SetSequenceTime(self.playlist[self.apos].animation, self.atime)
		end

		if self.playlist[self.apos].animation > 0 then
			self:SetSequenceTime(self.playlist[self.apos].animation,  self.atime)
		end

		if self.playlist[self.apos].endfacing then -- not self.playlist[self.apos].endfacing == self:GetFacing()
			self.rotation = self.rotation + (e * 2 * math.pi * -- Rotations per second
						((self.playlist[self.apos].endfacing/360)
						/ (self.playlist[self.apos].time/1000))
						)

			self:SetFacing( self.rotation )
		end
		if self.playlist[self.apos].move_x then
			--self.pos_x = self.pos_x + (self.playlist[self.apos].move_x / (self.playlist[self.apos].time/1000) ) * e
			self.pos_x = self.pos_x + (((self.playlist[self.apos].move_x / (self.playlist[self.apos].time/1000) ) * e) * self.modelMoveSpeed)
			self:SetPosition(self.pos_z+self.modelOffsetZ, self.pos_x+self.modelOffsetX, self.pos_y+self.modelOffsetY)
		end
		if self.playlist[self.apos].move_y then
			self.pos_y = self.pos_y + (self.playlist[self.apos].move_y / (self.playlist[self.apos].time/1000) ) * e
			--self:SetPosition(self.pos_y, self.pos_x, self.pos_z)
			self:SetPosition(self.pos_z+self.modelOffsetZ, self.pos_x+self.modelOffsetX, self.pos_y+self.modelOffsetY)
		end
		if self.playlist[self.apos].move_z then
			self.pos_z = self.pos_z + (self.playlist[self.apos].move_z / (self.playlist[self.apos].time/1000) ) * e
			--self:SetPosition(self.pos_y, self.pos_x, self.pos_z)
			self:SetPosition(self.pos_z+self.modelOffsetZ, self.pos_x+self.modelOffsetX, self.pos_y+self.modelOffsetY)
		end
		if self.playlist[self.apos].toalpha then
			self.alpha = self.alpha - ((1 - self.playlist[self.apos].toalpha) / (self.playlist[self.apos].time/1000) ) * e
			self:SetAlpha(self.alpha)
		end
		if self.playlist[self.apos].toscale then
			self.scale = self.scale - ((self.modelscale - self.playlist[self.apos].toscale) / (self.playlist[self.apos].time/1000) ) * e
			if self.scale < 0 then self.scale = 0.0001 end
			self:SetModelScale(self.scale)
		end
	end)--]]
	return mobstyle
end

local function CreateOptionsMenu()
	-- *****************************************************************
	--
	--  begin creating the Option Frames, this is mainly hardcoded
	--  because this allows me to place all the options as I want.
	--
	--  This API can be used to add your own tabs to our menu
	--
	--  To create a new tab please use the following function:
	--
	--    yourframe = DBM_GUI_Frame:CreateNewPanel("title", "option")
	--
	--  You can use the DBM widgets by calling methods like
	--
	--    yourframe:CreateCheckButton("my first checkbox", true)
	--
	--  If you Set the second argument to true, the checkboxes will be
	--  placed automatically.
	--
	-- *****************************************************************


	DBM_GUI_Frame = DBM_GUI:CreateNewPanel(L.TabCategory_Options, "option")
	if DBM.Options.EnableModels then CreateAnimationFrame() end
	do
		----------------------------------------------
		--             General Options              --
		----------------------------------------------
		local generaloptions = DBM_GUI_Frame:CreateArea(L.General, nil, 210, true)

		local enabledbm = generaloptions:CreateCheckButton(L.EnableDBM, true)
		enabledbm:SetScript("OnShow",  function() enabledbm:SetChecked(DBM:IsEnabled()) end)
		enabledbm:SetScript("OnClick", function() if DBM:IsEnabled() then DBM:Disable() else DBM:Enable() end end)

		local MiniMapIcon				= generaloptions:CreateCheckButton(L.EnableMiniMapIcon, true)
		MiniMapIcon:SetScript("OnClick", function(self)
			DBM:ToggleMinimapButton()
			self:SetChecked( DBM.Options.ShowMinimapButton )
		end)
		MiniMapIcon:SetScript("OnShow", function(self)
			self:SetChecked( DBM.Options.ShowMinimapButton )
		end)
		local SetPlayerRole				= generaloptions:CreateCheckButton(L.SetPlayerRole, true, nil, "SetPlayerRole")
		local UseMasterVolume			= generaloptions:CreateCheckButton(L.UseMasterVolume, true, nil, "UseMasterVolume")

		local bmrange  = generaloptions:CreateButton(L.Button_RangeFrame)
		bmrange:SetPoint('TOPLEFT', UseMasterVolume, "BOTTOMLEFT", 0, -5)
		bmrange:SetScript("OnClick", function(self)
			if DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Hide()
			else
				DBM.RangeCheck:Show(nil, nil, true)
			end
		end)

		local bmradar  = generaloptions:CreateButton(L.Button_RangeRadar)
		bmradar:SetPoint('TOPLEFT', bmrange, "TOPRIGHT", 0, 0)
		bmradar:SetScript("OnClick", function(self)
			if DBMRangeCheckRadar and DBMRangeCheckRadar:IsShown() then
				DBMRangeCheckRadar:Hide()
			else
				DBM.RangeCheck:Show(nil, nil, true)
				DBMRangeCheckRadar:Show()
			end
		end)

		local bminfo  = generaloptions:CreateButton(L.Button_InfoFrame)
		bminfo:SetPoint('TOPLEFT', bmrange, "BOTTOMLEFT", 0, 0)
		bminfo:SetScript("OnClick", function(self)
			if DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Hide()
			else
				DBM.InfoFrame:Show(5, "test")
			end
		end)

		local bmtestmode  = generaloptions:CreateButton(L.Button_TestBars)
		bmtestmode:SetPoint('TOPLEFT', bminfo, "TOPRIGHT", 0, 0)
		bmtestmode:SetScript("OnClick", function(self) DBM:DemoMode() end)

		local latencySlider = generaloptions:CreateSlider(L.Latency_Text, 50, 750, 5, 210)   -- (text , min_value , max_value , step , width)
		latencySlider:SetPoint('BOTTOMLEFT', bminfo, "BOTTOMLEFT", 10, -35)
		latencySlider:HookScript("OnShow", function(self) self:SetValue(DBM.Options.LatencyThreshold) end)
		latencySlider:HookScript("OnValueChanged", function(self) DBM.Options.LatencyThreshold = self:GetValue() end)
		----
		local generaltimeroptions = DBM_GUI_Frame:CreateArea(L.TimerGeneral, nil, 85)
		generaltimeroptions.frame:SetPoint('TOPLEFT', generaloptions.frame, "BOTTOMLEFT", 0, -20)

		local SKT_Enabled	= generaltimeroptions:CreateCheckButton(L.SKT_Enabled, true, nil, "AlwaysShowSpeedKillTimer")

		local challengeTimers = {
			{	text	= L.Disable,				value	= "None" },
			{	text	= L.ChallengeTimerPersonal,	value 	= "Personal"},
			{	text	= L.ChallengeTimerGuild,	value 	= "Guild"},
			{	text	= L.ChallengeTimerRealm,	value 	= "Realm"},
		}
		local ChallengeTimerDropDown = generaltimeroptions:CreateDropdown(L.ChallengeTimerOptions, challengeTimers,
		DBM.Options.ChallengeBest, function(value)
			DBM.Options.ChallengeBest = value
		end
		)
		ChallengeTimerDropDown:SetPoint("TOPLEFT", generaltimeroptions.frame, "TOPLEFT", 0, -50)

		--Model viewer options
		local modelarea = DBM_GUI_Frame:CreateArea(L.ModelOptions, nil, 85)
		modelarea.frame:SetPoint('TOPLEFT', generaltimeroptions.frame, "BOTTOMLEFT", 0, -20)

		local enablemodels	= modelarea:CreateCheckButton(L.EnableModels,  true, nil, "EnableModels")--Needs someone smarter then me to hide/disable this option if not 4.0.6+

		local modelSounds = {
			{	text	= L.NoSound,			value	= "" },
			{	text	= L.ModelSoundShort,	value 	= "Short"},
			{	text	= L.ModelSoundLong,		value 	= "Long"},
		}
		local ModelSoundDropDown = generaloptions:CreateDropdown(L.ModelSoundOptions, modelSounds,
		DBM.Options.ModelSoundValue, function(value)
			DBM.Options.ModelSoundValue = value
		end
		)
		ModelSoundDropDown:SetPoint("TOPLEFT", modelarea.frame, "TOPLEFT", 0, -50)

		DBM_GUI_Frame:SetMyOwnHeight()
	end

	do
		-------------------------------------------
		--            General Warnings           --
		-------------------------------------------
		local generalWarningPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_GeneralMessages, "option")
		local generalCoreArea = generalWarningPanel:CreateArea(L.CoreMessages, nil, 120, true)
--		generalCoreArea:CreateCheckButton(L.ShowLoadMessage, true, nil, "ShowLoadMessage")--Only here as a note, this is commented out so inexperienced users don't disable this, but an option for advanced users who want to manually change the value from true to false
		generalCoreArea:CreateCheckButton(L.ShowPizzaMessage, true, nil, "ShowPizzaMessage")
		generalCoreArea:CreateCheckButton(L.ShowCombatLogMessage, true, nil, "ShowCombatLogMessage")
		generalCoreArea:CreateCheckButton(L.ShowTranscriptorMessage, true, nil, "ShowTranscriptorMessage")

		local generalMessagesArea = generalWarningPanel:CreateArea(L.CombatMessages, nil, 135, true)
		generalMessagesArea:CreateCheckButton(L.ShowEngageMessage, true, nil, "ShowEngageMessage")
		generalMessagesArea:CreateCheckButton(L.ShowKillMessage, true, nil, "ShowKillMessage")
		generalMessagesArea:CreateCheckButton(L.ShowWipeMessage, true, nil, "ShowWipeMessage")
		generalMessagesArea:CreateCheckButton(L.ShowRecoveryMessage, true, nil, "ShowRecoveryMessage")
		local generalWhispersArea = generalWarningPanel:CreateArea(L.WhisperMessages, nil, 135, true)
		generalWhispersArea:CreateCheckButton(L.AutoRespond, true, nil, "AutoRespond")
		generalWhispersArea:CreateCheckButton(L.EnableStatus, true, nil, "StatusEnabled")
		generalWhispersArea:CreateCheckButton(L.WhisperStats, true, nil, "WhisperStats")
		generalCoreArea:AutoSetDimension()
		generalMessagesArea:AutoSetDimension()
		generalWhispersArea:AutoSetDimension()
		generalWarningPanel:SetMyOwnHeight()
	end

	do
		-----------------------------------------------
		--            Raid Warning Colors            --
		-----------------------------------------------
		local RaidWarningPanel = DBM_GUI_Frame:CreateNewPanel(L.Tab_RaidWarning, "option")
		local raidwarnoptions = RaidWarningPanel:CreateArea(L.RaidWarning_Header, nil, 280, true)

		local ShowWarningsInChat 	= raidwarnoptions:CreateCheckButton(L.ShowWarningsInChat, true, nil, "ShowWarningsInChat")
		local ShowSWarningsInChat 	= raidwarnoptions:CreateCheckButton(L.ShowSWarningsInChat, true, nil, "ShowSWarningsInChat")
		local ShowFakedRaidWarnings = raidwarnoptions:CreateCheckButton(L.ShowFakedRaidWarnings,  true, nil, "ShowFakedRaidWarnings")
		local WarningIconLeft		= raidwarnoptions:CreateCheckButton(L.WarningIconLeft,  true, nil, "WarningIconLeft")
		local WarningIconRight 		= raidwarnoptions:CreateCheckButton(L.WarningIconRight,  true, nil, "WarningIconRight")
		local WarningIconChat 		= raidwarnoptions:CreateCheckButton(L.WarningIconChat,  true, nil, "WarningIconChat")
		local ShowCountdownText 	= raidwarnoptions:CreateCheckButton(L.ShowCountdownText,  true, nil, "ShowCountdownText")

		-- RaidWarn Sound
		local Sounds = MixinSharedMedia3("sound", {
			{	text	= L.NoSound,	value	= "" },
			{	text	= "Default",	value 	= "Sound\\interface\\RaidWarning.ogg", 		sound=true },
			{	text	= "Classic",	value 	= "Sound\\Doodad\\BellTollNightElf.ogg", 	sound=true },
			{	text	= "Ding",		value 	= "Sound\\interface\\AlarmClockWarning3.ogg", 	sound=true }
		})

		local RaidWarnSoundDropDown = raidwarnoptions:CreateDropdown(L.RaidWarnSound, Sounds,
			DBM.Options.RaidWarningSound, function(value)
				DBM.Options.RaidWarningSound = value
			end
		)
		RaidWarnSoundDropDown:SetPoint("TOPLEFT", ShowCountdownText, "BOTTOMLEFT", 10, -10)

		local countSounds = {
			{	text	= "Moshne (Male)",	value 	= "Mosh"},
			{	text	= "Corsica (Female)",value 	= "Corsica"},
			{	text	= "Koltrane (Male)",value 	= "Kolt"},
			{	text	= "None",value 	= "None"},
		}
		local CountSoundDropDown = raidwarnoptions:CreateDropdown(L.CountdownVoice, countSounds,
		DBM.Options.CountdownVoice, function(value)
			DBM.Options.CountdownVoice = value
			DBM:PlayCountSound(1, DBM.Options.CountdownVoice)
		end
		)
		CountSoundDropDown:SetPoint("TOPLEFT", RaidWarnSoundDropDown, "TOPLEFT", 0, -40)
		
		local countSounds2 = {
			{	text	= "Mosh (Male)",	value 	= "Mosh"},
			{	text	= "Corsica (Female)",value 	= "Corsica"},
			{	text	= "Kolt (Male)",value 	= "Kolt"},
		}
		local CountSoundDropDown2 = raidwarnoptions:CreateDropdown(L.CountdownVoice2, countSounds,
		DBM.Options.CountdownVoice2, function(value)
			DBM.Options.CountdownVoice2 = value
			DBM:PlayCountSound(1, DBM.Options.CountdownVoice2)
		end
		)
		CountSoundDropDown2:SetPoint("LEFT", CountSoundDropDown, "RIGHT", 60, 0)

		--Raid Warning Colors
		local raidwarncolors = RaidWarningPanel:CreateArea(L.RaidWarnColors, nil, 150, true)

		local color1 = raidwarncolors:CreateColorSelect(64)
		local color2 = raidwarncolors:CreateColorSelect(64)
		local color3 = raidwarncolors:CreateColorSelect(64)
		local color4 = raidwarncolors:CreateColorSelect(64)
		local color1text = raidwarncolors:CreateText(L.RaidWarnColor_1, 64)
		local color2text = raidwarncolors:CreateText(L.RaidWarnColor_2, 64)
		local color3text = raidwarncolors:CreateText(L.RaidWarnColor_3, 64)
		local color4text = raidwarncolors:CreateText(L.RaidWarnColor_4, 64)
		local color1reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
		local color2reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
		local color3reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)
		local color4reset = raidwarncolors:CreateButton(L.Reset, 60, 10, nil, GameFontNormalSmall)

		color1:SetPoint('TOPLEFT', 30, -10)
		color2:SetPoint('TOPLEFT', color1, "TOPRIGHT", 30, 0)
		color3:SetPoint('TOPLEFT', color2, "TOPRIGHT", 30, 0)
		color4:SetPoint('TOPLEFT', color3, "TOPRIGHT", 30, 0)

		local function UpdateColor(self)
			local r, g, b = self:GetColorRGB()
			self.textid:SetTextColor(r, g, b)
			DBM.Options.WarningColors[self.myid].r = r
			DBM.Options.WarningColors[self.myid].g = g
			DBM.Options.WarningColors[self.myid].b = b
		end
		local function ResetColor(id, frame)
			return function(self)
				DBM.Options.WarningColors[id].r = DBM.DefaultOptions.WarningColors[id].r
				DBM.Options.WarningColors[id].g = DBM.DefaultOptions.WarningColors[id].g
				DBM.Options.WarningColors[id].b = DBM.DefaultOptions.WarningColors[id].b
				frame:SetColorRGB(DBM.Options.WarningColors[id].r, DBM.Options.WarningColors[id].g, DBM.Options.WarningColors[id].b)
			end
		end
		local function UpdateColorFrames(color, text, rset, id)
			color.textid = text
			color.myid = id
			color:SetScript("OnColorSelect", UpdateColor)
			color:SetColorRGB(DBM.Options.WarningColors[id].r, DBM.Options.WarningColors[id].g, DBM.Options.WarningColors[id].b)
			text:SetPoint('TOPLEFT', color, "BOTTOMLEFT", 3, -10)
			text:SetJustifyH("CENTER")
			rset:SetPoint("TOP", text, "BOTTOM", 0, -5)
			rset:SetScript("OnClick", ResetColor(id, color))
		end
		UpdateColorFrames(color1, color1text, color1reset, 1)
		UpdateColorFrames(color2, color2text, color2reset, 2)
		UpdateColorFrames(color3, color3text, color3reset, 3)
		UpdateColorFrames(color4, color4text, color4reset, 4)

		local infotext = raidwarncolors:CreateText(L.InfoRaidWarning, 380, false, GameFontNormalSmall, "LEFT")
		infotext:SetPoint('BOTTOMLEFT', raidwarncolors.frame, "BOTTOMLEFT", 10, 10)

		local movemebutton = raidwarncolors:CreateButton(L.MoveMe, 100, 16)
		movemebutton:SetPoint('BOTTOMRIGHT', raidwarncolors.frame, "TOPRIGHT", 0, -1)
		movemebutton:SetNormalFontObject(GameFontNormalSmall)
		movemebutton:SetHighlightFontObject(GameFontNormalSmall)
		do
			local anchorFrame
			local function hideme()
				anchorFrame:Hide()
			end
			movemebutton:SetScript("OnClick", function(self)
				DBM:Schedule(20, hideme)
				DBM.Bars:CreateBar(20, L.BarWhileMove)
				if not anchorFrame then
					anchorFrame = CreateFrame("Frame", "DBM_GUI_RaidWarnAnchor", UIParent)
					anchorFrame:SetWidth(32)
					anchorFrame:SetHeight(32)
					anchorFrame:EnableMouse(true)
					anchorFrame:SetPoint("BOTTOM", RaidWarningFrame, "TOP", 0, 1)
					anchorFrame.texture = anchorFrame:CreateTexture()
					anchorFrame.texture:SetTexture("Interface\\Addons\\DBM-GUI\\textures\\dot.blp")
					anchorFrame.texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
					anchorFrame.texture:SetWidth(32)
					anchorFrame.texture:SetHeight(32)
					anchorFrame:SetScript("OnMouseDown", function(self)
						RaidWarningFrame:SetMovable(1)
						RaidWarningFrame:StartMoving()
						DBM:Unschedule(hideme)
						DBM.Bars:CancelBar(L.BarWhileMove)
					end)
					anchorFrame:SetScript("OnMouseUp", function(self)
						RaidWarningFrame:StopMovingOrSizing()
						RaidWarningFrame:SetMovable(0)
						local point, _, _, xOfs, yOfs = RaidWarningFrame:GetPoint(1)
						DBM.Options.RaidWarningPosition.Point = point
						DBM.Options.RaidWarningPosition.X = xOfs
						DBM.Options.RaidWarningPosition.Y = yOfs
						DBM:Schedule(15, hideme)
						DBM.Bars:CreateBar(15, L.BarWhileMove)
					end)
					do
						local elapsed = 10
						anchorFrame:SetScript("OnUpdate", function(self, e)
							elapsed = elapsed + e
							if elapsed > 5 then
								elapsed = 0
								RaidNotice_AddMessage(RaidWarningFrame, L.RaidWarnMessage, ChatTypeInfo["RAID_WARNING"])
							end
						end)
					end

					anchorFrame:Show()
				else
					if anchorFrame:IsShown() then
						anchorFrame:Hide()
					else
						anchorFrame:Show()
					end
				end
			end)
		end
		RaidWarningPanel:SetMyOwnHeight()
	end

	do
		--------------------------------------
		--            Bar Options           --
		--------------------------------------
		local BarSetupPanel = DBM_GUI_Frame:CreateNewPanel(L.BarSetup, "option")

		local BarSetup = BarSetupPanel:CreateArea(L.AreaTitle_BarSetup, nil, 360, true)

		local movemebutton = BarSetup:CreateButton(L.MoveMe, 100, 16)
		movemebutton:SetPoint('BOTTOMRIGHT', BarSetup.frame, "TOPRIGHT", 0, -1)
		movemebutton:SetNormalFontObject(GameFontNormalSmall)
		movemebutton:SetHighlightFontObject(GameFontNormalSmall)
		movemebutton:SetScript("OnClick", function() DBM.Bars:ShowMovableBar() end)

		local maindummybar = DBM.Bars:CreateDummyBar()
		maindummybar.frame:SetParent(BarSetup.frame)
		maindummybar.frame:SetPoint("BOTTOM", BarSetup.frame, "TOP", 0, -35)
		maindummybar.frame:SetScript("OnUpdate", function(self, elapsed) maindummybar:Update(elapsed) end)
		do
			-- little hook to prevent this bar from changing size/scale
			local old = maindummybar.ApplyStyle
			function maindummybar:ApplyStyle(...)
				old(self, ...)
				self.frame:SetWidth(183)
				self.frame:SetScale(0.9)
				_G[self.frame:GetName().."Bar"]:SetWidth(183)
			end
		end

		local color1 = BarSetup:CreateColorSelect(64)
		local color2 = BarSetup:CreateColorSelect(64)
		color1:SetPoint('TOPLEFT', BarSetup.frame, "TOPLEFT", 20, -60)
		color2:SetPoint('TOPLEFT', color1, "TOPRIGHT", 20, 0)

		local color1reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		local color2reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		color1reset:SetPoint('TOP', color1, "BOTTOM", 5, -10)
		color2reset:SetPoint('TOP', color2, "BOTTOM", 5, -10)
		color1reset:SetScript("OnClick", function(self)
			color1:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorR"), DBM.Bars:GetDefaultOption("StartColorG"), DBM.Bars:GetDefaultOption("StartColorB"))
		end)
		color2reset:SetScript("OnClick", function(self)
			color2:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorR"), DBM.Bars:GetDefaultOption("EndColorG"), DBM.Bars:GetDefaultOption("EndColorB"))
		end)

		local color1text = BarSetup:CreateText(L.BarStartColor, 80)
		local color2text = BarSetup:CreateText(L.BarEndColor, 80)
		color1text:SetPoint("BOTTOM", color1, "TOP", 0, 4)
		color2text:SetPoint("BOTTOM", color2, "TOP", 0, 4)
		color1:SetScript("OnShow", function(self) self:SetColorRGB(
								DBM.Bars:GetOption("StartColorR"),
								DBM.Bars:GetOption("StartColorG"),
								DBM.Bars:GetOption("StartColorB"))
								color1text:SetTextColor(
									DBM.Bars:GetOption("StartColorR"),
									DBM.Bars:GetOption("StartColorG"),
									DBM.Bars:GetOption("StartColorB")
								)
							  end)
		color2:SetScript("OnShow", function(self) self:SetColorRGB(
								DBM.Bars:GetOption("EndColorR"),
								DBM.Bars:GetOption("EndColorG"),
								DBM.Bars:GetOption("EndColorB"))
								color2text:SetTextColor(
									DBM.Bars:GetOption("EndColorR"),
									DBM.Bars:GetOption("EndColorG"),
									DBM.Bars:GetOption("EndColorB")
								)
							  end)
		color1:SetScript("OnColorSelect", function(self)
							DBM.Bars:SetOption("StartColorR", select(1, self:GetColorRGB()))
							DBM.Bars:SetOption("StartColorG", select(2, self:GetColorRGB()))
							DBM.Bars:SetOption("StartColorB", select(3, self:GetColorRGB()))
							color1text:SetTextColor(self:GetColorRGB())
						  end)
		color2:SetScript("OnColorSelect", function(self)
							DBM.Bars:SetOption("EndColorR", select(1, self:GetColorRGB()))
							DBM.Bars:SetOption("EndColorG", select(2, self:GetColorRGB()))
							DBM.Bars:SetOption("EndColorB", select(3, self:GetColorRGB()))
							color2text:SetTextColor(self:GetColorRGB())
						  end)

		local Textures = MixinSharedMedia3("statusbar", {
			{	text	= "Default",	value 	= "Interface\\AddOns\\DBM-Core\\textures\\default.tga", 	texture	= "Interface\\AddOns\\DBM-Core\\textures\\default.tga"	},
			{	text	= "Blizzad",	value 	= "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar", 	texture	= "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar"	},
			{	text	= "Glaze",	value 	= "Interface\\AddOns\\DBM-Core\\textures\\glaze.tga", 		texture	= "Interface\\AddOns\\DBM-Core\\textures\\glaze.tga"	},
			{	text	= "Otravi",	value 	= "Interface\\AddOns\\DBM-Core\\textures\\otravi.tga", 		texture	= "Interface\\AddOns\\DBM-Core\\textures\\otravi.tga"	},
			{	text	= "Smooth",	value 	= "Interface\\AddOns\\DBM-Core\\textures\\smooth.tga", 		texture	= "Interface\\AddOns\\DBM-Core\\textures\\smooth.tga"	}
		})

		local TextureDropDown = BarSetup:CreateDropdown(L.BarTexture, Textures,
			DBM.Bars:GetOption("Texture"), function(value)
				DBM.Bars:SetOption("Texture", value)
			end
		)
		TextureDropDown:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 210, -55)

		local Styles = {
			{	text	= L.BarDBM,				value	= "DBM" },
			{	text	= L.BarBigWigs,			value 	= "BigWigs" }
		}

		local StyleDropDown = BarSetup:CreateDropdown(L.BarStyle, Styles,
			DBM.Bars:GetOption("Style"), function(value)
				DBM.Bars:SetOption("Style", value)
			end
		)
		StyleDropDown:SetPoint("TOPLEFT", TextureDropDown, "BOTTOMLEFT", 0, -10)

		local Fonts = MixinSharedMedia3("font", {
			{	text	= "Default",		value 	= STANDARD_TEXT_FONT,			font = STANDARD_TEXT_FONT		},
			{	text	= "Arial",			value 	= "Fonts\\ARIALN.TTF",			font = "Fonts\\ARIALN.TTF"		},
			{	text	= "Skurri",			value 	= "Fonts\\skurri.ttf",			font = "Fonts\\skurri.ttf"		},
			{	text	= "Morpheus",		value 	= "Fonts\\MORPHEUS.ttf",		font = "Fonts\\MORPHEUS.ttf"	}
		})

		local FontDropDown = BarSetup:CreateDropdown(L.Bar_Font, Fonts, DBM.Bars:GetOption("Font"),
			function(value)
				DBM.Bars:SetOption("Font", value)
			end)
		FontDropDown:SetPoint("TOPLEFT", StyleDropDown, "BOTTOMLEFT", 0, -10)

		local iconleft = BarSetup:CreateCheckButton(L.BarIconLeft, nil, nil, nil, "IconLeft")
		iconleft:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 10, 0)

		local iconright = BarSetup:CreateCheckButton(L.BarIconRight, nil, nil, nil, "IconRight")
		iconright:SetPoint("LEFT", iconleft, "LEFT", 130, 0)

		local ExpandUpwards = BarSetup:CreateCheckButton(L.ExpandUpwards, false, nil, nil, "ExpandUpwards")
		ExpandUpwards:SetPoint("TOPLEFT", iconleft, "BOTTOMLEFT", 0, 0)

		local FillUpBars = BarSetup:CreateCheckButton(L.FillUpBars, false, nil, nil, "FillUpBars")
		FillUpBars:SetPoint("TOPLEFT", iconright, "BOTTOMLEFT", 0, 0)

		local ClickThrough = BarSetup:CreateCheckButton(L.ClickThrough, false, nil, nil, "ClickThrough")
		ClickThrough:SetPoint("TOPLEFT", ExpandUpwards, "BOTTOMLEFT", 0, 0)

		-- Functions for bar setup
		local function createDBTOnShowHandler(option)
			return function(self)
				if option == "EnlargeBarsPercent" then
					self:SetValue(DBM.Bars:GetOption(option) * 100)
				else
					self:SetValue(DBM.Bars:GetOption(option))
				end
			end
		end
		local function createDBTOnValueChangedHandler(option)
			return function(self)
				if option == "EnlargeBarsPercent" then
					DBM.Bars:SetOption(option, self:GetValue() / 100)
					self:SetValue(DBM.Bars:GetOption(option) * 100)
				else
					DBM.Bars:SetOption(option, self:GetValue())
					self:SetValue(DBM.Bars:GetOption(option))
				end
				
			end
		end

		local FontSizeSlider = BarSetup:CreateSlider(L.Bar_FontSize, 7, 18, 1)
		FontSizeSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -175)
		FontSizeSlider:SetScript("OnShow", createDBTOnShowHandler("FontSize"))
		FontSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("FontSize"))

		local BarHeightSlider = BarSetup:CreateSlider(L.Bar_Height, 10, 35, 1)
		BarHeightSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -215)
		BarHeightSlider:SetScript("OnShow", createDBTOnShowHandler("Height"))
		BarHeightSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Height"))

		local descriptionText = BarSetup:CreateText(L.Bar_DBMOnly, 400, nil, nil, "LEFT")
		descriptionText:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -252)

		local EnlargeTimeSlider = BarSetup:CreateSlider(L.Bar_EnlargeTime, 6, 30, 1)
		EnlargeTimeSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -285)
		EnlargeTimeSlider:SetScript("OnShow", createDBTOnShowHandler("EnlargeBarsTime"))
		EnlargeTimeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("EnlargeBarsTime"))

		local EnlargePerecntSlider = BarSetup:CreateSlider(L.Bar_EnlargePercent, 0, 50, 0.5)
		EnlargePerecntSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -325)
		EnlargePerecntSlider:SetScript("OnShow", createDBTOnShowHandler("EnlargeBarsPercent"))
		EnlargePerecntSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("EnlargeBarsPercent"))

		local SparkBars = BarSetup:CreateCheckButton(L.BarSpark, false, nil, nil, "Spark")
		SparkBars:SetPoint("TOPLEFT", ClickThrough, "BOTTOMLEFT", 0, -40)

		local FlashBars = BarSetup:CreateCheckButton(L.BarFlash, false, nil, nil, "Flash")
		FlashBars:SetPoint("TOPLEFT", SparkBars, "BOTTOMLEFT", 0, 0)

		-----------------------
		-- Small Bar Options --
		-----------------------
		local BarSetupSmall = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupSmall, nil, 160, true)

		local smalldummybar = DBM.Bars:CreateDummyBar()
		smalldummybar.frame:SetParent(BarSetupSmall.frame)
		smalldummybar.frame:SetPoint('BOTTOM', BarSetupSmall.frame, "TOP", 0, -35)
		smalldummybar.frame:SetScript("OnUpdate", function(self, elapsed) smalldummybar:Update(elapsed) end)

		local BarWidthSlider = BarSetup:CreateSlider(L.Slider_BarWidth, 100, 400, 1)
		BarWidthSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 20, -90)
		BarWidthSlider:SetScript("OnShow", createDBTOnShowHandler("Width"))
		BarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Width"))

		local BarScaleSlider = BarSetup:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05)
		BarScaleSlider:SetPoint("TOPLEFT", BarWidthSlider, "BOTTOMLEFT", 0, -10)
		BarScaleSlider:SetScript("OnShow", createDBTOnShowHandler("Scale"))
		BarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Scale"))

		local BarOffsetXSlider = BarSetup:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1)
		BarOffsetXSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 220, -90)
		BarOffsetXSlider:SetScript("OnShow", createDBTOnShowHandler("BarXOffset"))
		BarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarXOffset"))

		local BarOffsetYSlider = BarSetup:CreateSlider(L.Slider_BarOffSetY, -5, 35, 1)
		BarOffsetYSlider:SetPoint("TOPLEFT", BarOffsetXSlider, "BOTTOMLEFT", 0, -10)
		BarOffsetYSlider:SetScript("OnShow", createDBTOnShowHandler("BarYOffset"))
		BarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarYOffset"))

		-----------------------
		-- Huge Bar Options --
		-----------------------
		local BarSetupHuge = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupHuge, nil, 175, true)

		local enablebar = BarSetupHuge:CreateCheckButton(L.EnableHugeBar, true, nil, nil, "HugeBarsEnabled")

		local hugedummybar = DBM.Bars:CreateDummyBar()
		hugedummybar.frame:SetParent(BarSetupSmall.frame)
		hugedummybar.frame:SetPoint('BOTTOM', BarSetupHuge.frame, "TOP", 0, -50)
		hugedummybar.frame:SetScript("OnUpdate", function(self, elapsed) hugedummybar:Update(elapsed) end)
		hugedummybar.enlarged = true
		hugedummybar:ApplyStyle()

		local HugeBarWidthSlider = BarSetupHuge:CreateSlider(L.Slider_BarWidth, 100, 400, 1)
		HugeBarWidthSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 20, -105)
		HugeBarWidthSlider:SetScript("OnShow", createDBTOnShowHandler("HugeWidth"))
		HugeBarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeWidth"))

		local HugeBarScaleSlider = BarSetupHuge:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05)
		HugeBarScaleSlider:SetPoint("TOPLEFT", HugeBarWidthSlider, "BOTTOMLEFT", 0, -10)
		HugeBarScaleSlider:SetScript("OnShow", createDBTOnShowHandler("HugeScale"))
		HugeBarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeScale"))

		local HugeBarOffsetXSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1)
		HugeBarOffsetXSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 220, -105)
		HugeBarOffsetXSlider:SetScript("OnShow", createDBTOnShowHandler("HugeBarXOffset"))
		HugeBarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarXOffset"))

		local HugeBarOffsetYSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetY, -5, 25, 1)
		HugeBarOffsetYSlider:SetPoint("TOPLEFT", HugeBarOffsetXSlider, "BOTTOMLEFT", 0, -10)
		HugeBarOffsetYSlider:SetScript("OnShow", createDBTOnShowHandler("HugeBarYOffset"))
		HugeBarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarYOffset"))


		BarSetupPanel:SetMyOwnHeight()
	end

	do
		local specPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_SpecWarnFrame, "option")
		local specArea = specPanel:CreateArea(L.Area_SpecWarn, nil, 515, true)
		local check1 = specArea:CreateCheckButton(L.SpecWarn_Enabled, true, nil, "ShowSpecialWarnings")
		local check2 = specArea:CreateCheckButton(L.SpecWarn_FlashFrame, true, nil, "ShowFlashFrame")
		local check3 = specArea:CreateCheckButton(L.SpecWarn_AdSound, true, nil, "ShowAdvSWSound")

		local showbutton = specArea:CreateButton(L.SpecWarn_DemoButton, 120, 16)
		showbutton:SetPoint('TOPRIGHT', specArea.frame, "TOPRIGHT", -5, -5)
		showbutton:SetNormalFontObject(GameFontNormalSmall)
		showbutton:SetHighlightFontObject(GameFontNormalSmall)
		showbutton:SetScript("OnClick", function() DBM:ShowTestSpecialWarning(nil, 1) end)

		local movemebutton = specArea:CreateButton(L.SpecWarn_MoveMe, 120, 16)
		movemebutton:SetPoint('TOPRIGHT', showbutton, "BOTTOMRIGHT", 0, -5)
		movemebutton:SetNormalFontObject(GameFontNormalSmall)
		movemebutton:SetHighlightFontObject(GameFontNormalSmall)
		movemebutton:SetScript("OnClick", function() DBM:MoveSpecialWarning() end)

		local color0 = specArea:CreateColorSelect(64)
		color0:SetPoint('TOPLEFT', specArea.frame, "TOPLEFT", 20, -110)
		local color0text = specArea:CreateText(L.SpecWarn_FontColor, 80)
		color0text:SetPoint("BOTTOM", color0, "TOP", 5, 4)
		local color0reset = specArea:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		color0reset:SetPoint('TOP', color0, "BOTTOM", 5, -10)
		color0reset:SetScript("OnClick", function(self)
				DBM.Options.SpecialWarningFontCol[1] = DBM.DefaultOptions.SpecialWarningFontCol[1]
				DBM.Options.SpecialWarningFontCol[2] = DBM.DefaultOptions.SpecialWarningFontCol[2]
				DBM.Options.SpecialWarningFontCol[3] = DBM.DefaultOptions.SpecialWarningFontCol[3]
				color0:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
		end)
		do
			local firstshow = true
			color0:SetScript("OnShow", function(self)
					firstshow = true
					self:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
			end)
			color0:SetScript("OnColorSelect", function(self)
					if firstshow then firstshow = false return end
					DBM.Options.SpecialWarningFontCol[1] = select(1, self:GetColorRGB())
					DBM.Options.SpecialWarningFontCol[2] = select(2, self:GetColorRGB())
					DBM.Options.SpecialWarningFontCol[3] = select(3, self:GetColorRGB())
					color0text:SetTextColor(self:GetColorRGB())
					DBM:UpdateSpecialWarningOptions()
					DBM:ShowTestSpecialWarning(nil, 1)
			end)
		end
		
		local Fonts = MixinSharedMedia3("font", {
			{	text	= "Default",		value 	= STANDARD_TEXT_FONT,			font = STANDARD_TEXT_FONT		},
			{	text	= "Arial",			value 	= "Fonts\\ARIALN.TTF",			font = "Fonts\\ARIALN.TTF"		},
			{	text	= "Skurri",			value 	= "Fonts\\skurri.ttf",			font = "Fonts\\skurri.ttf"		},
			{	text	= "Morpheus",		value 	= "Fonts\\MORPHEUS.ttf",		font = "Fonts\\MORPHEUS.ttf"	}
		})

		local FontDropDown = specArea:CreateDropdown(L.SpecWarn_FontType, Fonts, DBM.Options.SpecialWarningFont,
			function(value)
				DBM.Options.SpecialWarningFont = value
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
			end
		)
		FontDropDown:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 130, -105)

		local fontSizeSlider = specArea:CreateSlider(L.SpecWarn_FontSize, 16, 60, 1, 200)
		fontSizeSlider:SetPoint('TOPLEFT', FontDropDown, "TOPLEFT", 20, -45)
		do
			local firstshow = true
			fontSizeSlider:SetScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFontSize)
			end)
			fontSizeSlider:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFontSize = self:GetValue()
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
			end)
		end

		local color1 = specArea:CreateColorSelect(64)
		color1:SetPoint('TOPLEFT', color0, "TOPLEFT", 0, -105)
		local color1text = specArea:CreateText(L.SpecWarn_FlashColor, 80)
		color1text:SetPoint("BOTTOM", color1, "TOP", 5, 4)
		local color1reset = specArea:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		color1reset:SetPoint('TOP', color1, "BOTTOM", 5, -10)
		color1reset:SetScript("OnClick", function(self)
				DBM.Options.SpecialWarningFlashCol1[1] = DBM.DefaultOptions.SpecialWarningFlashCol1[1]
				DBM.Options.SpecialWarningFlashCol1[2] = DBM.DefaultOptions.SpecialWarningFlashCol1[2]
				DBM.Options.SpecialWarningFlashCol1[3] = DBM.DefaultOptions.SpecialWarningFlashCol1[3]
				color1:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
		end)
		do
			local firstshow = true
			color1:SetScript("OnShow", function(self)
					firstshow = true
					self:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
			end)
			color1:SetScript("OnColorSelect", function(self)
					if firstshow then firstshow = false return end
					DBM.Options.SpecialWarningFlashCol1[1] = select(1, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol1[2] = select(2, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol1[3] = select(3, self:GetColorRGB())
					color1text:SetTextColor(self:GetColorRGB())
					DBM:UpdateSpecialWarningOptions()
					DBM:ShowTestSpecialWarning(nil, 1)
			end)
		end
		
		local color2 = specArea:CreateColorSelect(64)
		color2:SetPoint('TOPLEFT', color1, "TOPLEFT", 0, -105)
		local color2text = specArea:CreateText(L.SpecWarn_FlashColor, 80)
		color2text:SetPoint("BOTTOM", color2, "TOP", 5, 4)
		local color2reset = specArea:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		color2reset:SetPoint('TOP', color2, "BOTTOM", 5, -10)
		color2reset:SetScript("OnClick", function(self)
				DBM.Options.SpecialWarningFlashCol2[1] = DBM.DefaultOptions.SpecialWarningFlashCol2[1]
				DBM.Options.SpecialWarningFlashCol2[2] = DBM.DefaultOptions.SpecialWarningFlashCol2[2]
				DBM.Options.SpecialWarningFlashCol2[3] = DBM.DefaultOptions.SpecialWarningFlashCol2[3]
				color2:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 2)
		end)
		do
			local firstshow = true
			color2:SetScript("OnShow", function(self)
					firstshow = true
					self:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
			end)
			color2:SetScript("OnColorSelect", function(self)
					if firstshow then firstshow = false return end
					DBM.Options.SpecialWarningFlashCol2[1] = select(1, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol2[2] = select(2, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol2[3] = select(3, self:GetColorRGB())
					color2text:SetTextColor(self:GetColorRGB())
					DBM:UpdateSpecialWarningOptions()
					DBM:ShowTestSpecialWarning(nil, 2)
			end)
		end
		
		local color3 = specArea:CreateColorSelect(64)
		color3:SetPoint('TOPLEFT', color2, "TOPLEFT", 0, -105)
		local color3text = specArea:CreateText(L.SpecWarn_FlashColor, 80)
		color3text:SetPoint("BOTTOM", color3, "TOP", 5, 4)
		local color3reset = specArea:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
		color3reset:SetPoint('TOP', color3, "BOTTOM", 5, -10)
		color3reset:SetScript("OnClick", function(self)
				DBM.Options.SpecialWarningFlashCol3[1] = DBM.DefaultOptions.SpecialWarningFlashCol3[1]
				DBM.Options.SpecialWarningFlashCol3[2] = DBM.DefaultOptions.SpecialWarningFlashCol3[2]
				DBM.Options.SpecialWarningFlashCol3[3] = DBM.DefaultOptions.SpecialWarningFlashCol3[3]
				color3:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
				DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 3)
		end)
		do
			local firstshow = true
			color3:SetScript("OnShow", function(self)
					firstshow = true
					self:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
			end)
			color3:SetScript("OnColorSelect", function(self)
					if firstshow then firstshow = false return end
					DBM.Options.SpecialWarningFlashCol3[1] = select(1, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol3[2] = select(2, self:GetColorRGB())
					DBM.Options.SpecialWarningFlashCol3[3] = select(3, self:GetColorRGB())
					color3text:SetTextColor(self:GetColorRGB())
					DBM:UpdateSpecialWarningOptions()
					DBM:ShowTestSpecialWarning(nil, 3)
			end)
		end

		-- SpecialWarn Sound
		local Sounds = MixinSharedMedia3("sound", {
			{	text	= L.NoSound,		value	= "" },
			{	text	= "Default",		value 	= "Sound\\Spells\\PVPFlagTaken.ogg", 		sound=true },
			{	text	= "Blizzard",		value 	= "Sound\\interface\\UI_RaidBossWhisperWarning.ogg", 		sound=true },
			{	text	= "Beware!",		value 	= "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg", 		sound=true },
			{	text	= "Destruction",	value 	= "Sound\\Creature\\KilJaeden\\KILJAEDEN02.ogg", 		sound=true },
			{	text	= "NotPrepared",	value 	= "Sound\\Creature\\Illidan\\BLACK_Illidan_04.ogg", 		sound=true },
			{	text	= "NightElfBell",	value 	= "Sound\\Doodad\\BellTollNightElf.ogg", 	sound=true }
		})

		local SpecialWarnSoundDropDown = specArea:CreateDropdown(L.SpecialWarnSound, Sounds,
			DBM.Options.SpecialWarningSound, function(value)
				DBM.Options.SpecialWarningSound = value
			end
		)
		SpecialWarnSoundDropDown:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 130, -210)

		local flashdurSlider = specArea:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)   -- (text , min_value , max_value , step , width)
		flashdurSlider:SetPoint('TOPLEFT', SpecialWarnSoundDropDown, "TOPLEFT", 20, -45)
		do
			local firstshow = true
			flashdurSlider:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashDura1)
			end)
			flashdurSlider:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashDura1 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
			end)
		end

		local flashdalphaSlider = specArea:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)   -- (text , min_value , max_value , step , width)
		flashdalphaSlider:SetPoint('BOTTOMLEFT', flashdurSlider, "BOTTOMLEFT", 150, -0)
		do
			local firstshow = true
			flashdalphaSlider:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashAlph1)
			end)
			flashdalphaSlider:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashAlph1 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 1)
			end)
		end

		local SpecialWarnSoundDropDown2 = specArea:CreateDropdown(L.SpecialWarnSound2, Sounds,
			DBM.Options.SpecialWarningSound2, function(value)
				DBM.Options.SpecialWarningSound2 = value
			end
		)
		SpecialWarnSoundDropDown2:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 130, -315)

		local flashdurSlider2 = specArea:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)   -- (text , min_value , max_value , step , width)
		flashdurSlider2:SetPoint('TOPLEFT', SpecialWarnSoundDropDown2, "TOPLEFT", 20, -45)
		do
			local firstshow = true
			flashdurSlider2:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashDura2)
			end)
			flashdurSlider2:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashDura2 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 2)
			end)
		end

		local flashdalphaSlider2 = specArea:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)   -- (text , min_value , max_value , step , width)
		flashdalphaSlider2:SetPoint('BOTTOMLEFT', flashdurSlider2, "BOTTOMLEFT", 150, -0)
		do
			local firstshow = true
			flashdalphaSlider2:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashAlph2)
			end)
			flashdalphaSlider2:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashAlph2 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 2)
			end)
		end

		local SpecialWarnSoundDropDown3 = specArea:CreateDropdown(L.SpecialWarnSound3, Sounds,
			DBM.Options.SpecialWarningSound3, function(value)
				DBM.Options.SpecialWarningSound3 = value
			end
		)
		SpecialWarnSoundDropDown3:SetPoint("TOPLEFT", specArea.frame, "TOPLEFT", 130, -415)

		local flashdurSlider3 = specArea:CreateSlider(L.SpecWarn_FlashDur, 0.2, 2, 0.2, 120)   -- (text , min_value , max_value , step , width)
		flashdurSlider3:SetPoint('TOPLEFT', SpecialWarnSoundDropDown3, "TOPLEFT", 20, -45)
		do
			local firstshow = true
			flashdurSlider3:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashDura3)
			end)
			flashdurSlider3:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashDura3 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 3)
			end)
		end

		local flashdalphaSlider3 = specArea:CreateSlider(L.SpecWarn_FlashAlpha, 0.1, 1, 0.1, 120)   -- (text , min_value , max_value , step , width)
		flashdalphaSlider3:SetPoint('BOTTOMLEFT', flashdurSlider3, "BOTTOMLEFT", 150, -0)
		do
			local firstshow = true
			flashdalphaSlider3:HookScript("OnShow", function(self)
				firstshow = true
				self:SetValue(DBM.Options.SpecialWarningFlashAlph3)
			end)
			flashdalphaSlider3:HookScript("OnValueChanged", function(self)
				if firstshow then firstshow = false return end
				DBM.Options.SpecialWarningFlashAlph3 = self:GetValue()
				--DBM:UpdateSpecialWarningOptions()
				DBM:ShowTestSpecialWarning(nil, 3)
			end)
		end

		local resetbutton = specArea:CreateButton(L.SpecWarn_ResetMe, 120, 16)
		resetbutton:SetPoint('BOTTOMRIGHT', specArea.frame, "BOTTOMRIGHT", -5, 5)
		resetbutton:SetNormalFontObject(GameFontNormalSmall)
		resetbutton:SetHighlightFontObject(GameFontNormalSmall)
		resetbutton:SetScript("OnClick", function()
				DBM.Options.ShowSpecialWarnings = DBM.DefaultOptions.ShowSpecialWarnings
				DBM.Options.ShowFlashFrame = DBM.DefaultOptions.ShowFlashFrame
				DBM.Options.ShowAdvSWSound = DBM.DefaultOptions.ShowAdvSWSound
				DBM.Options.SpecialWarningFont = DBM.DefaultOptions.SpecialWarningFont
				DBM.Options.SpecialWarningSound = DBM.DefaultOptions.SpecialWarningSound
				DBM.Options.SpecialWarningSound2 = DBM.DefaultOptions.SpecialWarningSound2
				DBM.Options.SpecialWarningSound3 = DBM.DefaultOptions.SpecialWarningSound3
				DBM.Options.SpecialWarningFontSize = DBM.DefaultOptions.SpecialWarningFontSize
				DBM.Options.SpecialWarningFlashCol1[1] = DBM.DefaultOptions.SpecialWarningFlashCol1[1]
				DBM.Options.SpecialWarningFlashCol1[2] = DBM.DefaultOptions.SpecialWarningFlashCol1[2]
				DBM.Options.SpecialWarningFlashCol1[3] = DBM.DefaultOptions.SpecialWarningFlashCol1[3]
				DBM.Options.SpecialWarningFlashCol2[1] = DBM.DefaultOptions.SpecialWarningFlashCol2[1]
				DBM.Options.SpecialWarningFlashCol2[2] = DBM.DefaultOptions.SpecialWarningFlashCol2[2]
				DBM.Options.SpecialWarningFlashCol2[3] = DBM.DefaultOptions.SpecialWarningFlashCol2[3]
				DBM.Options.SpecialWarningFlashCol3[1] = DBM.DefaultOptions.SpecialWarningFlashCol3[1]
				DBM.Options.SpecialWarningFlashCol3[2] = DBM.DefaultOptions.SpecialWarningFlashCol3[2]
				DBM.Options.SpecialWarningFlashCol3[3] = DBM.DefaultOptions.SpecialWarningFlashCol3[3]
				DBM.Options.SpecialWarningFlashDura1 = DBM.DefaultOptions.SpecialWarningFlashDura1
				DBM.Options.SpecialWarningFlashDura2 = DBM.DefaultOptions.SpecialWarningFlashDura2
				DBM.Options.SpecialWarningFlashDura3 = DBM.DefaultOptions.SpecialWarningFlashDura3
				DBM.Options.SpecialWarningFlashAlph1 = DBM.DefaultOptions.SpecialWarningFlashAlph1
				DBM.Options.SpecialWarningFlashAlph2 = DBM.DefaultOptions.SpecialWarningFlashAlph2
				DBM.Options.SpecialWarningFlashAlph3 = DBM.DefaultOptions.SpecialWarningFlashAlph3
				DBM.Options.SpecialWarningPoint = DBM.DefaultOptions.SpecialWarningPoint
				DBM.Options.SpecialWarningX = DBM.DefaultOptions.SpecialWarningX
				DBM.Options.SpecialWarningY = DBM.DefaultOptions.SpecialWarningY
				check1:SetChecked(DBM.Options.ShowSpecialWarnings)
				check2:SetChecked(DBM.Options.ShowFlashFrame)
				check3:SetChecked(DBM.Options.ShowAdvSWSound)
				FontDropDown:SetSelectedValue(DBM.Options.SpecialWarningFont)
				SpecialWarnSoundDropDown:SetSelectedValue(DBM.Options.SpecialWarningSound)
				SpecialWarnSoundDropDown2:SetSelectedValue(DBM.Options.SpecialWarningSound2)
				SpecialWarnSoundDropDown3:SetSelectedValue(DBM.Options.SpecialWarningSound3)
				fontSizeSlider:SetValue(DBM.DefaultOptions.SpecialWarningFontSize)
				color0:SetColorRGB(DBM.Options.SpecialWarningFontCol[1], DBM.Options.SpecialWarningFontCol[2], DBM.Options.SpecialWarningFontCol[3])
				color1:SetColorRGB(DBM.Options.SpecialWarningFlashCol1[1], DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3])
				color2:SetColorRGB(DBM.Options.SpecialWarningFlashCol2[1], DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3])
				color3:SetColorRGB(DBM.Options.SpecialWarningFlashCol3[1], DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3])
				flashdurSlider:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura1)
				flashdurSlider2:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura2)
				flashdurSlider3:SetValue(DBM.DefaultOptions.SpecialWarningFlashDura3)
				flashdalphaSlider:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph1)
				flashdalphaSlider2:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph2)
				flashdalphaSlider3:SetValue(DBM.DefaultOptions.SpecialWarningFlashAlph3)
				DBM:UpdateSpecialWarningOptions()
		end)
		specPanel:SetMyOwnHeight()
	end

	do
		local hpPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_HPFrame, "option")
		local hpArea = hpPanel:CreateArea(L.Area_HPFrame, nil, 150, true)
		local alwaysbttn = hpArea:CreateCheckButton(L.HP_Enabled, true, nil, "AlwaysShowHealthFrame")
		local growbttn = hpArea:CreateCheckButton(L.HP_GrowUpwards, true)
		growbttn:SetScript("OnShow",  function(self) self:SetChecked(DBM.Options.HealthFrameGrowUp) end)
		growbttn:SetScript("OnClick", function(self)
				DBM.Options.HealthFrameGrowUp = not not self:GetChecked()
				DBM.BossHealth:UpdateSettings()
		end)

		local BarWidthSlider = hpArea:CreateSlider(L.BarWidth, 150, 275, 1)
		BarWidthSlider:SetPoint("TOPLEFT", hpArea.frame, "TOPLEFT", 20, -75)
		BarWidthSlider:SetScript("OnShow", function(self) self:SetValue(DBM.Options.HealthFrameWidth or 100) end)
		BarWidthSlider:HookScript("OnValueChanged", function(self)
				DBM.Options.HealthFrameWidth = self:GetValue()
				DBM.BossHealth:UpdateSettings()
		end)

		local resetbutton = hpArea:CreateButton(L.Reset, 120, 16)
		resetbutton:SetPoint('BOTTOMRIGHT', hpArea.frame, "BOTTOMRIGHT", -5, 5)
		resetbutton:SetNormalFontObject(GameFontNormalSmall)
		resetbutton:SetHighlightFontObject(GameFontNormalSmall)
		resetbutton:SetScript("OnClick", function()
				DBM.Options.HPFramePoint = DBM.DefaultOptions.HPFramePoint
				DBM.Options.HPFrameX = DBM.DefaultOptions.HPFrameX
				DBM.Options.HPFrameY = DBM.DefaultOptions.HPFrameY
				DBM.Options.AlwaysShowHealthFrame = DBM.DefaultOptions.AlwaysShowHealthFrame
				DBM.Options.HealthFrameGrowUp = DBM.DefaultOptions.HealthFrameGrowUp
				DBM.Options.HealthFrameWidth = DBM.DefaultOptions.HealthFrameWidth
				alwaysbttn:SetChecked(DBM.Options.AlwaysShowHealthFrame)
				growbttn:SetChecked(DBM.Options.HealthFrameGrowUp)
				BarWidthSlider:SetValue(DBM.Options.HealthFrameWidth)
				DBM.BossHealth:UpdateSettings()
		end)

		local function createDummyFunc(i) return function() return i end end
		local showbutton = hpArea:CreateButton(L.HP_ShowDemo, 120, 16)
		showbutton:SetPoint('BOTTOM', resetbutton, "TOP", 0, 5)
		showbutton:SetNormalFontObject(GameFontNormalSmall)
		showbutton:SetHighlightFontObject(GameFontNormalSmall)
		showbutton:SetScript("OnClick", function()
				DBM.BossHealth:Show("Health Frame")
				DBM.BossHealth:AddBoss(createDummyFunc(25), "TestBoss 1")
				DBM.BossHealth:AddBoss(createDummyFunc(50), "TestBoss 2")
				DBM.BossHealth:AddBoss(createDummyFunc(75), "TestBoss 3")
				DBM.BossHealth:AddBoss(createDummyFunc(100), "TestBoss 4")
		end)
	end

	do
		local spamPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_SpamFilter, "option")
		local spamOutArea = spamPanel:CreateArea(L.Area_SpamFilter_Outgoing, nil, 170, true)
		spamOutArea:CreateCheckButton(L.SpamBlockNoShowAnnounce, true, nil, "DontShowBossAnnounces")
		spamOutArea:CreateCheckButton(L.DontShowFarWarnings, true, nil, "DontShowFarWarnings")
		spamOutArea:CreateCheckButton(L.SpamBlockNoSendWhisper, true, nil, "DontSendBossWhispers")
		spamOutArea:CreateCheckButton(L.SpamBlockNoSetIcon, true, nil, "DontSetIcons")
		spamOutArea:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
		spamOutArea:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
		spamOutArea:CreateCheckButton(L.SpamBlockNoHealthFrame, true, nil, "DontShowHealthFrame")

		local spamArea = spamPanel:CreateArea(L.Area_SpamFilter, nil, 150, true)
		spamArea:CreateCheckButton(L.StripServerName, true, nil, "StripServerName")
		spamArea:CreateCheckButton(L.SpamBlockBossWhispers, true, nil, "SpamBlockBossWhispers")
		spamArea:CreateCheckButton(L.BlockVersionUpdateNotice, true, nil, "BlockVersionUpdateNotice")
		if BigBrother and type(BigBrother.ConsumableCheck) == "function" then
			spamArea:CreateCheckButton(L.ShowBBOnCombatStart, true, nil, "ShowBigBrotherOnCombatStart")
			spamArea:CreateCheckButton(L.BigBrotherAnnounceToRaid, true, nil, "BigBrotherAnnounceToRaid")
		end
		local spamPTArea = spamPanel:CreateArea(L.Area_PullTimer, nil, 160, true)
		spamPTArea:CreateCheckButton(L.DontShowPTNoID, true, nil, "DontShowPTNoID")
		spamPTArea:CreateCheckButton(L.DontShowPT, true, nil, "DontShowPT")
		spamPTArea:CreateCheckButton(L.DontShowPTText, true, nil, "DontShowPTText")
		spamPTArea:CreateCheckButton(L.DontPlayPTCountdown, true, nil, "DontPlayPTCountdown")
		local SPTCDT = spamPTArea:CreateCheckButton(L.DontShowPTCountdownText, true, nil, "DontShowPTCountdownText")
		
		local PTSlider = spamPTArea:CreateSlider(L.PT_Threshold, 3, 30, 1, 300)   -- (text , min_value , max_value , step , width)
		PTSlider:SetPoint('TOPLEFT', SPTCDT, "TOPLEFT", 62, -40)--Position seems based on text size so on diff locals it'll actually be in different places :\
		PTSlider:HookScript("OnShow", function(self) self:SetValue(DBM.Options.PTCountThreshold) end)
		PTSlider:HookScript("OnValueChanged", function(self) DBM.Options.PTCountThreshold = self:GetValue() end)
		
		spamPTArea:AutoSetDimension()
		spamArea:AutoSetDimension()
		spamOutArea:AutoSetDimension()
		spamPanel:SetMyOwnHeight()
	end
	
	do
		local hideBlizzPanel = DBM_GUI_Frame:CreateNewPanel(L.Panel_HideBlizzard, "option")
		local hideBlizzArea = hideBlizzPanel:CreateArea(L.Area_HideBlizzard, nil, 160, true)
		hideBlizzArea:CreateCheckButton(L.HideBossEmoteFrame, true, nil, "HideBossEmoteFrame")
		hideBlizzArea:CreateCheckButton(L.HideWatchFrame, true, nil, "HideWatchFrame")
		hideBlizzArea:CreateCheckButton(L.HideTooltips, true, nil, "HideTooltips")
		local filterYell	= hideBlizzArea:CreateCheckButton(L.SpamBlockSayYell, true, nil, "FilterSayAndYell")
		
		local movieOptions = {
			{	text	= L.Disable,	value 	= "Never"},
			{	text	= L.AfterFirst	,value 	= "AfterFirst"},
			{	text	= L.Always		,value 	= "Block"},
		}
		local blockMovieDropDown = hideBlizzArea:CreateDropdown(L.DisableCinematics, movieOptions,
		DBM.Options.MovieFilter, function(value)
			DBM.Options.MovieFilter = value
		end
		)
		blockMovieDropDown:SetPoint("TOPLEFT", filterYell, "TOPLEFT", 0, -40)

		hideBlizzPanel:SetMyOwnHeight()
	end
	
	do
		local extraFeaturesPanel 	= DBM_GUI_Frame:CreateNewPanel(L.Panel_ExtraFeatures, "option")
		local chatAlertsArea		= extraFeaturesPanel:CreateArea(L.Area_ChatAlerts, nil, 100, true)
		local WorldBossAlert		= chatAlertsArea:CreateCheckButton(L.WorldBossAlert, true, nil, "WorldBossAlert")

		local soundAlertsArea		 = extraFeaturesPanel:CreateArea(L.Area_SoundAlerts, nil, 100, true)
		local LFDEnhance			= soundAlertsArea:CreateCheckButton(L.LFDEnhance, true, nil, "LFDEnhance")

		local bossLoggingArea		= extraFeaturesPanel:CreateArea(L.Area_AutoLogging, nil, 100, true)
		local AutologBosses			= bossLoggingArea:CreateCheckButton(L.AutologBosses, true, nil, "AutologBosses")
		local AdvancedAutologBosses
		if Transcriptor then
			AdvancedAutologBosses	= bossLoggingArea:CreateCheckButton(L.AdvancedAutologBosses, true, nil, "AdvancedAutologBosses")
		end
		local LogOnlyRaidBosses		= bossLoggingArea:CreateCheckButton(L.LogOnlyRaidBosses, true, nil, "LogOnlyRaidBosses")
		
		-- Pizza Timer (create your own timer menu)
		local pizzaarea = extraFeaturesPanel:CreateArea(L.PizzaTimer_Headline, nil, 85, true)

		local textbox = pizzaarea:CreateEditBox(L.PizzaTimer_Title, "Pizza!", 175)
		local hourbox = pizzaarea:CreateEditBox(L.PizzaTimer_Hours, "0", 25)
		local minbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Mins, "15", 25)
		local secbox  = pizzaarea:CreateEditBox(L.PizzaTimer_Secs, "0", 25)

		textbox:SetMaxLetters(17)
		textbox:SetPoint('TOPLEFT', 30, -25)
		hourbox:SetNumeric()
		hourbox:SetMaxLetters(2)
		hourbox:SetPoint('TOPLEFT', textbox, "TOPRIGHT", 20, 0)
		minbox:SetNumeric()
		minbox:SetMaxLetters(2)
		minbox:SetPoint('TOPLEFT', hourbox, "TOPRIGHT", 20, 0)
		secbox:SetNumeric()
		secbox:SetMaxLetters(2)
		secbox:SetPoint('TOPLEFT', minbox, "TOPRIGHT", 20, 0)

		local BcastTimer = pizzaarea:CreateCheckButton(L.PizzaTimer_BroadCast)
		local okbttn  = pizzaarea:CreateButton(L.PizzaTimer_ButtonStart)
		okbttn:SetPoint('TOPLEFT', textbox, "BOTTOMLEFT", -7, -8)
		BcastTimer:SetPoint("TOPLEFT", okbttn, "TOPRIGHT", 10, 3)

		pizzaarea.frame:SetScript("OnShow", function(self)
			if DBM:GetRaidRank() == 0 then
				BcastTimer:Hide()
			else
				BcastTimer:Show()
			end
		end)

		okbttn:SetScript("OnClick", function()
			local time = (hourbox:GetNumber() * 60*60) + (minbox:GetNumber() * 60) + secbox:GetNumber()
			if textbox:GetText() and time > 0 then
				DBM:CreatePizzaTimer(time,  textbox:GetText(), BcastTimer:GetChecked())
			end
		end)
		-- END Pizza Timer
		chatAlertsArea:AutoSetDimension()
		soundAlertsArea:AutoSetDimension()
		bossLoggingArea:AutoSetDimension()
		extraFeaturesPanel:SetMyOwnHeight()
	end

	-- Set Revision // please don't translate this!
	DBM_GUI_OptionsFrameRevision:SetText("Deadly Boss Mods "..DBM.DisplayVersion.." (r"..DBM.Revision..")")
	if L.TranslationBy then
		DBM_GUI_OptionsFrameTranslation:SetText(L.TranslationByPrefix .. L.TranslationBy)
	end
	DBM_GUI_OptionsFrameWebsite:SetText(L.Website)
	local frame = CreateFrame("Frame", nil, DBM_GUI_OptionsFrame)
	frame:SetAllPoints(DBM_GUI_OptionsFrameWebsite)
	frame:SetScript("OnMouseUp", function(...) DBM:ShowUpdateReminder(nil, nil, DBM_FORUMS_COPY_URL_DIALOG) end)
end
DBM:RegisterOnGuiLoadCallback(CreateOptionsMenu, 1)

do
	local function OnShowGetStats(stats, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, top3value1, top3value2, top3value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3, bottom3value1, bottom3value2, bottom3value3)
		return function(self)
			top1value1:SetText( stats.normalKills )
			top1value2:SetText( stats.normalPulls - stats.normalKills )
			top1value3:SetText( stats.normalBestTime and ("%d:%02d"):format(math.floor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-" )
			if statsType == 1 then--Party instance
				top2value1:SetText( stats.heroicKills )
				top2value2:SetText( stats.heroicPulls-stats.heroicKills )
				top2value3:SetText( stats.heroicBestTime and ("%d:%02d"):format(math.floor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-" )
				top3value1:SetText( stats.challengeKills )
				top3value2:SetText( stats.challengePulls-stats.challengeKills )
				top3value3:SetText( stats.challengeBestTime and ("%d:%02d"):format(math.floor(stats.challengeBestTime / 60), stats.challengeBestTime % 60) or "-" )
			elseif statsType == 2 and stats.normal25Pulls and stats.normal25Pulls > 0 and stats.normal25Pulls > stats.normalPulls then--Fix for BC instance
				top1value1:SetText( stats.normal25Kills )
				top1value2:SetText( stats.normal25Pulls - stats.normal25Kills )
				top1value3:SetText( stats.normal25BestTime and ("%d:%02d"):format(math.floor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-" )
			else
				top2value1:SetText( stats.normal25Kills )
				top2value2:SetText( stats.normal25Pulls - stats.normal25Kills )
				top2value3:SetText( stats.normal25BestTime and ("%d:%02d"):format(math.floor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-" )
				top3value1:SetText( stats.lfr25Kills )
				top3value2:SetText( stats.lfr25Pulls-stats.lfr25Kills )
				top3value3:SetText( stats.lfr25BestTime and ("%d:%02d"):format(math.floor(stats.lfr25BestTime / 60), stats.lfr25BestTime % 60) or "-" )
				bottom1value1:SetText( stats.heroicKills )
				bottom1value2:SetText( stats.heroicPulls-stats.heroicKills )
				bottom1value3:SetText( stats.heroicBestTime and ("%d:%02d"):format(math.floor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-" )
				bottom2value1:SetText( stats.heroic25Kills )
				bottom2value2:SetText( stats.heroic25Pulls-stats.heroic25Kills )
				bottom2value3:SetText( stats.heroic25BestTime and ("%d:%02d"):format(math.floor(stats.heroic25BestTime / 60), stats.heroic25BestTime % 60) or "-" )
				bottom3value1:SetText( stats.flexKills )
				bottom3value2:SetText( stats.flexPulls-stats.flexKills )
				bottom3value3:SetText( stats.flexBestTime and ("%d:%02d"):format(math.floor(stats.flexBestTime / 60), stats.flexBestTime % 60) or "-" )
			end
		end
	end

	local function CreateBossModTab(addon, panel, subtab)
		if not panel then
			error("Panel is nil", 2)
		end
		
		if addon.noStatistics then return end

		local ptext = panel:CreateText(L.BossModLoaded:format(subtab and addon.subTabs[subtab] or addon.name), nil, nil, GameFontNormal)
		ptext:SetPoint('TOPLEFT', panel.frame, "TOPLEFT", 10, -10)

		local bossstats = 0
		local area = panel:CreateArea(nil, panel.frame:GetWidth() - 20, 0)
		area.frame:SetPoint("TOPLEFT", 10, -25)
		area.onshowcall = {}

		for _, mod in ipairs(DBM.Mods) do
			if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) and not mod.isTrashMod and not mod.noStatistics then
				local statsType = 0
				bossstats = bossstats + 1
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
				stats.flexKills = stats.flexKills or 0
				stats.flexPulls = stats.flexPulls or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Pulls = stats.normal25Pulls or 0
				stats.heroic25Kills = stats.heroic25Kills or 0
				stats.heroic25Pulls = stats.heroic25Pulls or 0
				stats.lfr25Kills = stats.lfr25Kills or 0
				stats.lfr25Pulls = stats.lfr25Pulls or 0

				--Create Frames
				local Title			= area:CreateText(mod.localization.general.name, nil, nil, GameFontHighlight, "LEFT")

				local top1header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 1, 1st column
				local top1text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 1, 2nd column
				local top2text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 1, 3rd column
				local top3text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top3text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top3text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top3value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top3value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				local bottom1header		= area:CreateText("", nil, nil, GameFontDisableSmall, "LEFT")--Row 2, 1st column
				local bottom1text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2header		= area:CreateText("", nil, nil, GameFontDisableSmall, "LEFT")--Row 2, 2nd column
				local bottom2text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 2, 3rd column
				local bottom3text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom3value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				--Set default position
				top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
				top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
				top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
				top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
				top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
				top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
				top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)

				--Set enable or disable per mods.
				if mod.oneFormat then
					statsType = 2--Fix for BC instance
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*5*(bossstats-1)))
					--Do not use top1 header.
					top1text1:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*5 )
				elseif mod.type == "PARTY" or mod.type == "SCENARIO" then--If party or scenario instance have no heroic, we should use oneFormat.
					statsType = 1
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*(bossstats-1)))
					if mod.hasChallenge then
						--Use top1, top2 and top3 area.
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
						--Set header text.
						top3header:SetText(CHALLENGE_MODE)
						if mod.type == "SCENARIO" then
							top3text2:SetText(L.Statistic_Incompletes)
						end
					else
						--Use top1 and top2 area.
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
					end
					--Set header text.
					top1header:SetText(PLAYER_DIFFICULTY1)
					top2header:SetText(PLAYER_DIFFICULTY2)
					if mod.type == "SCENARIO" then
						top1text2:SetText(L.Statistic_Incompletes)
						top2text2:SetText(L.Statistic_Incompletes)
					end
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
				elseif mod.type == "RAID" and mod.noHeroic then
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*(bossstats-1)))
					--Use top1 and top2 area.
					top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
					top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
					top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
					top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
					top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
					top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
					top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
					--Set header text.
					top1header:SetText(RAID_DIFFICULTY1)
					top2header:SetText(RAID_DIFFICULTY2)
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
				elseif mod.type == "RAID" and not mod.hasLFR then
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*10*(bossstats-1)))
					--Use top1, top2, bottom1 and bottom2 area.
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
					--Set header text.
					top1header:SetText(RAID_DIFFICULTY1)
					top2header:SetText(RAID_DIFFICULTY2)
					bottom1header:SetText(PLAYER_DIFFICULTY2)
					bottom2header:SetText(PLAYER_DIFFICULTY2)
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*10 )
				elseif mod.type == "RAID" and not mod.hasFlex then
					--Use top1, top2, top3, bottom1 and bottom2 area.
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*10*(bossstats-1)))
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
					top1header:SetText(RAID_DIFFICULTY1)
					top2header:SetText(RAID_DIFFICULTY2)
					top3header:SetText(PLAYER_DIFFICULTY3)
					bottom1header:SetText(PLAYER_DIFFICULTY2)
					bottom2header:SetText(PLAYER_DIFFICULTY2)
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*10 )
				else--Uses everything
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*10*(bossstats-1)))
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
					bottom3header:SetPoint("LEFT", bottom2header, "LEFT", 150, 0)
					bottom3text1:SetPoint("LEFT", bottom2text1, "LEFT", 150, 0)
					bottom3text2:SetPoint("LEFT", bottom2text2, "LEFT", 150, 0)
					bottom3text3:SetPoint("LEFT", bottom2text3, "LEFT", 150, 0)
					bottom3value1:SetPoint("TOPLEFT", bottom3text1, "TOPLEFT", 80, 0)
					bottom3value2:SetPoint("TOPLEFT", bottom3text2, "TOPLEFT", 80, 0)
					bottom3value3:SetPoint("TOPLEFT", bottom3text3, "TOPLEFT", 80, 0)
					top1header:SetText(RAID_DIFFICULTY1)
					top2header:SetText(RAID_DIFFICULTY2)
					top3header:SetText(PLAYER_DIFFICULTY3)
					bottom1header:SetText(PLAYER_DIFFICULTY2)
					bottom2header:SetText(PLAYER_DIFFICULTY2)
					bottom3header:SetText(PLAYER_DIFFICULTY4 or "Flexible")--Remove extra string in 5.4 live
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*10 )
				end

				table.insert(area.onshowcall, OnShowGetStats(mod.stats, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, top3value1, top3value2, top3value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3, bottom3value1, bottom3value2, bottom3value3))
			end
		end
		area.frame:SetScript("OnShow", function(self)
			for _,v in pairs(area.onshowcall) do
				v()
			end
		end)
		panel:SetMyOwnHeight()
		DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
	end

	local function LoadAddOn_Button(self)
		if DBM:LoadMod(self.modid) then
			self:Hide()
			self.headline:Hide()
			CreateBossModTab(self.modid, self.modid.panel)
			DBM_GUI_OptionsFrameBossMods:Hide()
			DBM_GUI_OptionsFrameBossMods:Show()
		end
	end

	local Categories = {}
	local subTabId = 0
	function DBM_GUI:UpdateModList()
		for k,addon in ipairs(DBM.AddOns) do
			if not Categories[addon.category] then
				-- Create a Panel for "Wrath of the Lich King" "Burning Crusade" ...
				local expLevel = GetExpansionLevel()
				if expLevel == 4 then--Choose default expanded category based on players current expansion is.
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_"..addon.category:upper()] or L.TabCategory_Other, nil, (addon.category:upper()=="MOP"))
				elseif expLevel == 3 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_"..addon.category:upper()] or L.TabCategory_Other, nil, (addon.category:upper()=="CATA"))
				elseif expLevel == 2 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_"..addon.category:upper()] or L.TabCategory_Other, nil, (addon.category:upper()=="WotLK"))
				elseif expLevel == 1 then
					Categories[addon.category] = DBM_GUI:CreateNewPanel(L["TabCategory_"..addon.category:upper()] or L.TabCategory_Other, nil, (addon.category:upper()=="BC"))
				end
				if L["TabCategory_"..addon.category:upper()] then
					local ptext = Categories[addon.category]:CreateText(L["TabCategory_"..addon.category:upper()])
					ptext:SetPoint('TOPLEFT', Categories[addon.category].frame, "TOPLEFT", 10, -10)
				end
			end

			if not addon.panel then
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				addon.panel = Categories[addon.category]:CreateNewPanel(addon.modId or "Error: No-modId", nil, false, nil, addon.name)

				if not IsAddOnLoaded(addon.modId) then
					local button = addon.panel:CreateButton(L.Button_LoadMod, 200, 30)
					button.modid = addon
					button.headline = addon.panel:CreateText(L.BossModLoad_now, 350)
					button.headline:SetHeight(50)
					button.headline:SetPoint("CENTER", button, "CENTER", 0, 80)

					button:SetScript("OnClick", LoadAddOn_Button)
					button:SetPoint('CENTER', 0, -20)
				else
					CreateBossModTab(addon, addon.panel)
				end
			end

			if addon.panel and addon.subTabs and IsAddOnLoaded(addon.modId) then
				-- Create a Panel for "Arachnid Quarter" "Plague Quarter" ...
				if not addon.subPanels then addon.subPanels = {} end

				for k,v in pairs(addon.subTabs) do
					if not addon.subPanels[k] then
						subTabId = subTabId + 1
						addon.subPanels[k] = addon.panel:CreateNewPanel("SubTab"..subTabId, nil, false, nil, v)
						CreateBossModTab(addon, addon.subPanels[k], k)
					end
				end
			end


			for _, mod in ipairs(DBM.Mods) do
				if mod.modId == addon.modId then
					if not mod.panel and (not addon.subTabs or (addon.subPanels and addon.subPanels[mod.subTab])) then
						if addon.subTabs and addon.subPanels[mod.subTab] then
							mod.panel = addon.subPanels[mod.subTab]:CreateNewPanel(mod.id or "Error: DBM.Mods", nil, nil, nil, mod.localization.general.name)
						else
							mod.panel = addon.panel:CreateNewPanel(mod.id or "Error: DBM.Mods", nil, nil, nil, mod.localization.general.name)
						end
						DBM_GUI:CreateBossModPanel(mod)
					end
				end
			end
		end
		if DBM_GUI_OptionsFrame:IsShown() then
			DBM_GUI_OptionsFrame:Hide()
			DBM_GUI_OptionsFrame:Show()
		end
	end


	function DBM_GUI:CreateBossModPanel(mod)
		if not mod.panel then
			DBM:AddMsg("Couldn't create boss mod panel for "..mod.localization.general.name)
			return false
		end
		local panel = mod.panel
		local category

		local iconstat = panel.frame:CreateFontString("DBM_GUI_Mod_Icons"..mod.localization.general.name, "ARTWORK")
		iconstat:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", -16, -24)
		iconstat:SetFontObject(GameFontNormal)
		iconstat:SetText(L.IconsInUse)
		for i=1, 8, 1 do
			local icon = panel.frame:CreateTexture()
			icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons.blp")
			icon:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", 2-(i*18), -40)
			icon:SetWidth(16)
			icon:SetHeight(16)
			if not mod.usedIcons or not mod.usedIcons[i] then		icon:SetAlpha(0.25)		end
			if 		i == 1 then		icon:SetTexCoord(0,		0.25,	0,		0.25)
			elseif	i == 2 then		icon:SetTexCoord(0.25,	0.5,	0,		0.25)
			elseif	i == 3 then		icon:SetTexCoord(0.5, 	0.75,	0,		0.25)
			elseif	i == 4 then		icon:SetTexCoord(0.75,	1,		0,		0.25)
			elseif	i == 5 then		icon:SetTexCoord(0,		0.25,	0.25,	0.5)
			elseif	i == 6 then		icon:SetTexCoord(0.25,	0.5,	0.25,	0.5)
			elseif	i == 7 then		icon:SetTexCoord(0.5,	0.75,	0.25,	0.5)
			elseif	i == 8 then		icon:SetTexCoord(0.75,	1,		0.25,	0.5)
			end
		end

		local reset  = panel:CreateButton(L.Mod_Reset, 150, nil, nil, GameFontNormalSmall)
		reset:SetPoint('TOPRIGHT', panel.frame, "TOPRIGHT", -14, -2)
		reset:SetScript("OnClick", function(self)
			local savedOptions = _G[mod.modId:gsub("-", "").."_SavedVars"][mod.id] or {}
			table.wipe(savedOptions)
			for i, v in ipairs(DBM.Mods) do
				if v.id == mod.id then
					for option, optionValue in pairs(v.DefaultOptions) do
						savedOptions[option] = optionValue
					end
					v.Options = savedOptions or {}
					break
				end
			end
			panel:Refresh()
		end)
		local button = panel:CreateCheckButton(L.Mod_Enabled, true)
		button:SetScript("OnShow",  function(self) self:SetChecked(mod.Options.Enabled) end)
		button:SetPoint('TOPLEFT', panel.frame, "TOPLEFT", 8, -24)
		button:SetScript("OnClick", function(self) mod:Toggle()	end)

		for _, catident in pairs(mod.categorySort) do
			category = mod.optionCategories[catident]
			local catpanel = panel:CreateArea(mod.localization.cats[catident], nil, nil, true)
			local button, lastButton, addSpacer
			for _,v in ipairs(category) do
				if v == DBM_OPTION_SPACER then
					addSpacer = true
				elseif type(mod.Options[v]) == "boolean" then
					lastButton = button
					if mod.Options[v .. "SpecialWarningSound"] then
						button = catpanel:CreateCheckButton(mod.localization.options[v], true, nil, nil, nil, v .. "SpecialWarningSound", mod)
					else
						button = catpanel:CreateCheckButton(mod.localization.options[v], true)
					end
					if addSpacer then
						button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -6)
						addSpacer = false
					end
					button:SetScript("OnShow",  function(self)
						self:SetChecked(mod.Options[v])
					end)
					button:SetScript("OnClick", function(self)
						mod.Options[v] = not mod.Options[v]
						if mod.optionFuncs and mod.optionFuncs[v] then mod.optionFuncs[v]() end
					end)
				elseif mod.dropdowns and mod.dropdowns[v] then
					lastButton = button
					local dropdownOptions = {}
					for i, v in ipairs(mod.dropdowns[v]) do
						dropdownOptions[#dropdownOptions + 1] = { text = mod.localization.options[v], value = v }
					end
					button = catpanel:CreateDropdown(mod.localization.options[v], dropdownOptions, mod.Options[v], function(value) mod.Options[v] = value end)
					if addSpacer then
						button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -6)
						addSpacer = false
					else
						button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -10)
					end
					button:SetScript("OnShow", function(self)
						self:SetSelectedValue(mod.Options[v])
					end)
				end
			end
			catpanel:AutoSetDimension()
			panel:SetMyOwnHeight()
		end
	end
end
