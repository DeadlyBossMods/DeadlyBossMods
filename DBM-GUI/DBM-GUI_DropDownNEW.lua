local _, private = ...

local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

local defaultFont, defaultFontSize = GameFontHighlightSmall:GetFont()

local dropdownPrototype = CreateFrame("DropdownButton")

-- For lazily loaded dropdowns: pass a single dropdown entry, for normal dropdowns pass a single value or name
function dropdownPrototype:SetSelectedValue(selected)
	if type(selected) == "table" then -- Force value to whatever was given no matter if it exists
		self.value = selected.value
		self.text = selected.text
		self:GenerateMenu()
		if self.onSelectionChangedCallback then
			self:onSelectionChangedCallback(selected)
		end
	elseif selected and self.values and type(self.values) == "table" then
		for _, v in next, self.values do
			if v.value ~= nil and v.value == selected or v.text == selected then
				self.value = v.value
				self.text = v.text
				self:GenerateMenu()
				if self.onSelectionChangedCallback then
					self:onSelectionChangedCallback(v)
				end
			end
		end
	end
end

-- Called if the selection changes by either the user or by calling SetSelectedValue
function dropdownPrototype:OnSelectionChanged(callback)
	self.onSelectionChangedCallback = callback
end

function dropdownPrototype:RefreshLazyValues()
	if not self.valueGetter then
		error("called RefreshLazyValues() on a static dropdown", 2)
	end
	self.values = self:valueGetter()
end

-- values can either be a table or a function, if it's a function it gets called every time the dropdown is opened to populate the values
---@diagnostic disable-next-line: duplicate-set-field
function DBM_GUI:CreateDropdown(title, values, vartype, var, callfunc, width, height, parent, overrideText)
	if type(values) == "table" then
		for _, entry in next, values do
			entry.text = entry.text or "Missing entry.text"
			entry.value = entry.value or entry.text
		end
	end
	---@class DBMDropDown: Button
	---@diagnostic disable-next-line: undefined-field, assign-type-mismatch -- self.frame comes from a subclass of DBM_GUI, DropdownButton isn't defined in ketho.wow-api
	local dropdown = CreateFrame("DropdownButton", "DBM_GUI_DropDown" .. self:GetNewID(), parent or self.frame, "WowStyle1DropdownTemplate")
	setmetatable(dropdown, {
		__index = dropdownPrototype
	})
	dropdown.mytype = "dropdown2"
	dropdown.width = width or 120
	if type(values) == "function" then
		dropdown.valueGetter = values
	else
		dropdown.values = values
	end
	dropdown.callfunc = callfunc
	dropdown:SetWidth(dropdown.width + 30)

	if overrideText then
		---@diagnostic disable-next-line: undefined-field
		dropdown:OverrideText(overrideText)
	end

	local IsSelected = function(v)
		return v.value == dropdown.value or v.text == dropdown.text
	end
	local SetSelected = function(v)
		dropdown.value = v.value
		dropdown.text = v.text
		if v.sound then
			DBM:PlaySoundFile(v.value)
		end
		if v.func then
			v.func(v.value)
		end
		if dropdown.callfunc then
			dropdown.callfunc(v.value)
		end
		if dropdown.onSelectionChangedCallback then
			dropdown:onSelectionChangedCallback(v.value)
		end
	end

	---@diagnostic disable-next-line: undefined-field
	dropdown:SetupMenu(function(owner, rootDescription)
		if not dropdown:IsVisible() then
			return
		end
		rootDescription:SetScrollMode(200)

		if dropdown.valueGetter then
			dropdown:RefreshLazyValues()
		end

		for _, v in ipairs(dropdown.values) do
			local radio = rootDescription:CreateRadio(v.text, IsSelected, SetSelected, v)
			if v.font or v.flag then
				radio.font = CreateFont("DBM_FONT_" .. v.text)
				radio.font:SetFont(v.font and v.value or defaultFont, v.fontsize or defaultFontSize, v.flag and v.value or "")
				-- Do **NOT** call SetFont inside of the initializer function, or it will silently exit (Thanks blizzard)
				radio:AddInitializer(function(button)
					button.fontString:SetFontObject(radio.font)
				end)
			end
			if v.texture then
				radio:AddInitializer(function(button)
					local t = button:AttachTexture()
					t:SetPoint("TOPLEFT", 15, 0)
					t:SetPoint("BOTTOMRIGHT")
					t:SetTexture(v.value)
					return 200, 25
				end)
			end
			if IsSelected(v) then
				dropdown.value = v.value
				dropdown.text = v.text
			end
		end
		if dropdown.text then
			---@diagnostic disable-next-line: undefined-field
			dropdown:SetTooltip(function(tooltip)
				GameTooltip_SetTitle(tooltip, dropdown.text)
			end)
		end
	end)

	if title ~= nil and title ~= "" then
		local titleText = dropdown:CreateFontString(dropdown:GetName() .. "TitleText", "BACKGROUND")
		titleText:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 0, 1)
		titleText:SetFontObject(GameFontNormalSmall)
		titleText:SetText(private.parseDescription(title))
	end
	if vartype and vartype == "DBM" and DBM.Options[var] ~= nil then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBM.Options[var])
		end)
	elseif vartype and vartype == "DBT" then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(DBT.Options[var])
		end)
	elseif vartype then
		dropdown:SetScript("OnShow", function()
			dropdown:SetSelectedValue(vartype.Options[var])
		end)
	elseif type(dropdown.values) == "table" then
		for _, v in next, dropdown.values do
			if v.value ~= nil and v.value == var or v.text == var then
				dropdown.value = v.value
				dropdown.text = v.text
			end
		end
		---@diagnostic disable-next-line: undefined-field
		dropdown:GenerateMenu()
	end

	return dropdown
end
