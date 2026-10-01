local L = DBM_GUI_L
local DBT = DBT

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_ColorByType, "option")

local BarColors = BarSetupPanel:CreateArea(L.AreaTitle_BarColors)
local movemebutton = BarColors:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", BarColors.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function()
	DBM_GUI:CollapseForPreview(DBT:ShowMovableBar())
end)

local testmebutton = BarColors:CreateButton(L.Button_TestBars, 100, 16)
testmebutton:SetPoint("BOTTOMRIGHT", BarColors.frame, "BOTTOMRIGHT", -2, 4)
testmebutton:SetNormalFontObject(GameFontNormalSmall)
testmebutton:SetHighlightFontObject(GameFontNormalSmall)
testmebutton:SetScript("OnClick", function()
	DBM_GUI:CollapseForPreview(DBM:DemoMode())
end)

local function lockDummyBarSize(bar)
	-- Preview bars ignore the live bar size/scale options
	local old = bar.ApplyStyle
	function bar:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

---@return DBTBar dummyBar
---@return Button startColor
local function createColorTypeOption(area, colorType, info)
	local startR, startG, startB = "StartColor" .. info.suffix .. "R", "StartColor" .. info.suffix .. "G", "StartColor" .. info.suffix .. "B"
	local endR, endG, endB = "EndColor" .. info.suffix .. "R", "EndColor" .. info.suffix .. "G", "EndColor" .. info.suffix .. "B"
	local startColor = area:CreateColorSelect(info.startLabel, function(_, r, g, b)
		DBT:SetOption(startR, r)
		DBT:SetOption(startG, g)
		DBT:SetOption(startB, b)
	end, function(self)
		self:SetColorRGB(DBT.DefaultOptions[startR], DBT.DefaultOptions[startG], DBT.DefaultOptions[startB], true)
	end)
	local endColor = area:CreateColorSelect(info.endLabel, function(_, r, g, b)
		DBT:SetOption(endR, r)
		DBT:SetOption(endG, g)
		DBT:SetOption(endB, b)
	end, function(self)
		self:SetColorRGB(DBT.DefaultOptions[endR], DBT.DefaultOptions[endG], DBT.DefaultOptions[endB], true)
	end)
	startColor:SetPoint("TOPLEFT", area.frame, "TOPLEFT", info.x, info.y)
	endColor:SetPoint("TOPLEFT", startColor, "TOPRIGHT", info.gap, 0)
	startColor.myheight = info.myheight
	endColor.myheight = 0

	startColor:SetColorRGB(DBT.Options[startR], DBT.Options[startG], DBT.Options[startB])
	endColor:SetColorRGB(DBT.Options[endR], DBT.Options[endG], DBT.Options[endB])

	local dummyBar = DBT:CreateDummyBar(colorType, nil, info.barLabel)
	dummyBar.frame:SetParent(area.frame)
	dummyBar.frame:SetPoint("BOTTOMLEFT", startColor, "TOPLEFT", 20, 10)
	dummyBar.frame:SetScript("OnUpdate", function(_, elapsed)
		dummyBar:Update(elapsed)
	end)
	lockDummyBarSize(dummyBar)
	return dummyBar, startColor
end

-- Array index is the DBT color type; type 1's 10px gap is intentional legacy layout
local standardColorTypes = {
	{suffix = "A",  startLabel = L.BarStartColorAdd,       endLabel = L.BarEndColorAdd,       barLabel = L.CBTAdd,       x = 30,  y = -55,  gap = 10, myheight = 75},
	{suffix = "AE", startLabel = L.BarStartColorAOE,       endLabel = L.BarEndColorAOE,       barLabel = L.CBTAOE,       x = 270, y = -55,  gap = 20, myheight = 0},
	{suffix = "D",  startLabel = L.BarStartColorDebuff,    endLabel = L.BarEndColorDebuff,    barLabel = L.CBTTargeted,  x = 30,  y = -140, gap = 20, myheight = 75},
	{suffix = "I",  startLabel = L.BarStartColorInterrupt, endLabel = L.BarEndColorInterrupt, barLabel = L.CBTInterrupt, x = 270, y = -140, gap = 20, myheight = 0},
	{suffix = "R",  startLabel = L.BarStartColorRole,      endLabel = L.BarEndColorRole,      barLabel = L.CBTRole,      x = 30,  y = -225, gap = 20, myheight = 75},
	{suffix = "P",  startLabel = L.BarStartColorPhase,     endLabel = L.BarEndColorPhase,     barLabel = L.CBTPhase,     x = 270, y = -225, gap = 20, myheight = 0},
}
for colorType, info in ipairs(standardColorTypes) do
	createColorTypeOption(BarColors, colorType, info)
end

--Custom bar emphasis stuff for classic only, midnight secret api can't use this stuff
local ImpBarColors = BarSetupPanel:CreateArea(L.AreaTitle_ImpBarColors)

local dummybarcolor7, color1Type7 = createColorTypeOption(ImpBarColors, 7, {suffix = "UI", startLabel = L.BarStartColorUI, endLabel = L.BarEndColorUI, barLabel = L.CBTImportant, x = 30, y = -55, gap = 20, myheight = 75})
dummybarcolor7:ApplyStyle()

local dummybarcolor8 = createColorTypeOption(ImpBarColors, 8, {suffix = "I2", startLabel = L.BarStartColorI2, endLabel = L.BarEndColorI2, barLabel = L.CBTImportant, x = 270, y = -55, gap = 20, myheight = 0})
dummybarcolor8:ApplyStyle()

--Important Bar Options
local bar7OptionsText = ImpBarColors:CreateText(L.Bar7Header, 405)
bar7OptionsText:SetPoint("TOPLEFT", color1Type7, "BOTTOMLEFT", 0, -30)

local forceLarge = ImpBarColors:CreateCheckButton(L.Bar7ForceLarge, false, nil, nil, "Bar7ForceLarge")
forceLarge:SetPoint("TOPLEFT", bar7OptionsText, "BOTTOMLEFT")
forceLarge:SetScript("OnClick", function()
	DBT:SetOption("Bar7ForceLarge", not DBT.Options.Bar7ForceLarge)
	if DBT.Options.Bar7ForceLarge then
		dummybarcolor7.enlarged = true
	else
		dummybarcolor7.enlarged = false
	end
	dummybarcolor7:ApplyStyle()
end)
forceLarge.myheight = 60

local customInline = ImpBarColors:CreateCheckButton(L.Bar7CustomInline, false, nil, nil, "Bar7CustomInline")
customInline:SetPoint("LEFT", forceLarge, "LEFT", 200, 0)
customInline:SetScript("OnClick", function()
	DBT:SetOption("Bar7CustomInline", not DBT.Options.Bar7CustomInline)
	--Update Bar 7
	local ttext = _G[dummybarcolor7.frame:GetName().."BarName"]:GetText() or ""
	ttext = ttext:gsub("|T.-|t", "")
	dummybarcolor7:SetText(ttext)
	--Update Bar 8
	local ttext2 = _G[dummybarcolor8.frame:GetName().."BarName"]:GetText() or ""
	ttext2 = ttext2:gsub("|T.-|t", "")
	dummybarcolor8:SetText(ttext2)
end)
