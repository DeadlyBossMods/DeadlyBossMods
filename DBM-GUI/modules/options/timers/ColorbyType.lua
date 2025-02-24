local L = DBM_GUI_L
local DBT = DBT

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_ColorByType, "option")

local BarColors = BarSetupPanel:CreateArea(L.AreaTitle_BarColors)
local movemebutton = BarColors:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", BarColors.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function()
	DBT:ShowMovableBar()
end)

local testmebutton = BarColors:CreateButton(L.Button_TestBars, 100, 16)
testmebutton:SetPoint("BOTTOMRIGHT", BarColors.frame, "BOTTOMRIGHT", -2, 4)
testmebutton:SetNormalFontObject(GameFontNormalSmall)
testmebutton:SetHighlightFontObject(GameFontNormalSmall)
testmebutton:SetScript("OnClick", function()
	DBM:DemoMode()
end)

--Color Type 1 (Adds)
local color1Type1 = BarColors:CreateColorSelect(L.BarStartColorAdd, function(_, r, g, b)
	DBT:SetOption("StartColorAR", r)
	DBT:SetOption("StartColorAG", g)
	DBT:SetOption("StartColorAB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorAR, DBT.DefaultOptions.StartColorAG, DBT.DefaultOptions.StartColorAB, true)
end)
local color2Type1 = BarColors:CreateColorSelect(L.BarEndColorAdd, function(_, r, g, b)
	DBT:SetOption("EndColorAR", r)
	DBT:SetOption("EndColorAG", g)
	DBT:SetOption("EndColorAB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorAR, DBT.DefaultOptions.EndColorAG, DBT.DefaultOptions.EndColorAB, true)
end)
color1Type1:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -55)
color2Type1:SetPoint("TOPLEFT", color1Type1, "TOPRIGHT", 10, 0)
color1Type1.myheight = 75
color2Type1.myheight = 0

color1Type1:SetColorRGB(DBT.Options.StartColorAR, DBT.Options.StartColorAG, DBT.Options.StartColorAB)
color2Type1:SetColorRGB(DBT.Options.EndColorAR, DBT.Options.EndColorAG, DBT.Options.EndColorAB)

---@class DummyColorBar1: DBTBar
local dummybarcolor1 = DBT:CreateDummyBar(1, nil, L.CBTAdd)
dummybarcolor1.frame:SetParent(BarColors.frame)
dummybarcolor1.frame:SetPoint("BOTTOMLEFT", color1Type1, "TOPLEFT", 20, 10)
dummybarcolor1.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor1:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor1.ApplyStyle
	function dummybarcolor1:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

--Color Type 2 (AOE)
local color1Type2 = BarColors:CreateColorSelect(L.BarStartColorAOE, function(_, r, g, b)
	DBT:SetOption("StartColorAER", r)
	DBT:SetOption("StartColorAEG", g)
	DBT:SetOption("StartColorAEB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorAER, DBT.DefaultOptions.StartColorAEG, DBT.DefaultOptions.StartColorAEB, true)
end)
local color2Type2 = BarColors:CreateColorSelect(L.BarEndColorAOE, function(_, r, g, b)
	DBT:SetOption("EndColorAER", r)
	DBT:SetOption("EndColorAEG", g)
	DBT:SetOption("EndColorAEB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorAER, DBT.DefaultOptions.EndColorAEG, DBT.DefaultOptions.EndColorAEB, true)
end)
color1Type2:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 270, -55)
color2Type2:SetPoint("TOPLEFT", color1Type2, "TOPRIGHT", 20, 0)
color1Type2.myheight = 0
color2Type2.myheight = 0

color1Type2:SetColorRGB(DBT.Options.StartColorAER, DBT.Options.StartColorAEG, DBT.Options.StartColorAEB)
color2Type2:SetColorRGB(DBT.Options.EndColorAER, DBT.Options.EndColorAEG, DBT.Options.EndColorAEB)

---@class DummyColorBar2: DBTBar
local dummybarcolor2 = DBT:CreateDummyBar(2, nil, L.CBTAOE)
dummybarcolor2.frame:SetParent(BarColors.frame)
dummybarcolor2.frame:SetPoint("BOTTOMLEFT", color1Type2, "TOPLEFT", 20, 10)
dummybarcolor2.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor2:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor2.ApplyStyle
	function dummybarcolor2:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

--Color Type 3 (Debuff)
local color1Type3 = BarColors:CreateColorSelect(L.BarStartColorDebuff, function(_, r, g, b)
	DBT:SetOption("StartColorDR", r)
	DBT:SetOption("StartColorDG", g)
	DBT:SetOption("StartColorDB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorDR, DBT.DefaultOptions.StartColorDG, DBT.DefaultOptions.StartColorDB, true)
end)
local color2Type3 = BarColors:CreateColorSelect(L.BarEndColorDebuff, function(_, r, g, b)
	DBT:SetOption("EndColorDR", r)
	DBT:SetOption("EndColorDG", g)
	DBT:SetOption("EndColorDB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorDR, DBT.DefaultOptions.EndColorDG, DBT.DefaultOptions.EndColorDB, true)
end)
color1Type3:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -140)
color2Type3:SetPoint("TOPLEFT", color1Type3, "TOPRIGHT", 20, 0)
color1Type3.myheight = 75
color2Type3.myheight = 0

color1Type3:SetColorRGB(DBT.Options.StartColorDR, DBT.Options.StartColorDG, DBT.Options.StartColorDB)
color2Type3:SetColorRGB(DBT.Options.EndColorDR, DBT.Options.EndColorDG, DBT.Options.EndColorDB)

---@class DummyColorBar3: DBTBar
local dummybarcolor3 = DBT:CreateDummyBar(3, nil, L.CBTTargeted)
dummybarcolor3.frame:SetParent(BarColors.frame)
dummybarcolor3.frame:SetPoint("BOTTOMLEFT", color1Type3, "TOPLEFT", 20, 10)
dummybarcolor3.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor3:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor3.ApplyStyle
	function dummybarcolor3:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

--Color Type 4 (Interrupt)
local color1Type4 = BarColors:CreateColorSelect(L.BarStartColorInterrupt, function(_, r, g, b)
	DBT:SetOption("StartColorIR", r)
	DBT:SetOption("StartColorIG", g)
	DBT:SetOption("StartColorIB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorIR, DBT.DefaultOptions.StartColorIG, DBT.DefaultOptions.StartColorIB, true)
end)
local color2Type4 = BarColors:CreateColorSelect(L.BarEndColorInterrupt, function(_, r, g, b)
	DBT:SetOption("EndColorIR", r)
	DBT:SetOption("EndColorIG", g)
	DBT:SetOption("EndColorIB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorIR, DBT.DefaultOptions.EndColorIG, DBT.DefaultOptions.EndColorIB, true)
end)
color1Type4:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 270, -140)
color2Type4:SetPoint("TOPLEFT", color1Type4, "TOPRIGHT", 20, 0)
color1Type4.myheight = 0
color2Type4.myheight = 0

color1Type4:SetColorRGB(DBT.Options.StartColorIR, DBT.Options.StartColorIG, DBT.Options.StartColorIB)
color2Type4:SetColorRGB(DBT.Options.EndColorIR, DBT.Options.EndColorIG, DBT.Options.EndColorIB)

---@class DummyColorBar4: DBTBar
local dummybarcolor4 = DBT:CreateDummyBar(4, nil, L.CBTInterrupt)
dummybarcolor4.frame:SetParent(BarColors.frame)
dummybarcolor4.frame:SetPoint("BOTTOMLEFT", color1Type4, "TOPLEFT", 20, 10)
dummybarcolor4.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor4:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor4.ApplyStyle
	function dummybarcolor4:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

--Color Type 5 (Role)
local color1Type5 = BarColors:CreateColorSelect(L.BarStartColorRole, function(_, r, g, b)
	DBT:SetOption("StartColorRR", r)
	DBT:SetOption("StartColorRG", g)
	DBT:SetOption("StartColorRB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorRR, DBT.DefaultOptions.StartColorRG, DBT.DefaultOptions.StartColorRB, true)
end)
local color2Type5 = BarColors:CreateColorSelect(L.BarEndColorRole, function(_, r, g, b)
	DBT:SetOption("EndColorRR", r)
	DBT:SetOption("EndColorRG", g)
	DBT:SetOption("EndColorRB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorRR, DBT.DefaultOptions.EndColorRG, DBT.DefaultOptions.EndColorRB, true)
end)
color1Type5:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -225)
color2Type5:SetPoint("TOPLEFT", color1Type5, "TOPRIGHT", 20, 0)
color1Type5.myheight = 75
color2Type5.myheight = 0

color1Type5:SetColorRGB(DBT.Options.StartColorRR, DBT.Options.StartColorRG, DBT.Options.StartColorRB)
color2Type5:SetColorRGB(DBT.Options.EndColorRR, DBT.Options.EndColorRG, DBT.Options.EndColorRB)

---@class DummyColorBar5: DBTBar
local dummybarcolor5 = DBT:CreateDummyBar(5, nil, L.CBTRole)
dummybarcolor5.frame:SetParent(BarColors.frame)
dummybarcolor5.frame:SetPoint("BOTTOMLEFT", color1Type5, "TOPLEFT", 20, 10)
dummybarcolor5.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor5:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor5.ApplyStyle
	function dummybarcolor5:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

--Color Type 6 (Phase)
local color1Type6 = BarColors:CreateColorSelect(L.BarStartColorPhase, function(_, r, g, b)
	DBT:SetOption("StartColorPR", r)
	DBT:SetOption("StartColorPG", g)
	DBT:SetOption("StartColorPB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorPR, DBT.DefaultOptions.StartColorPG, DBT.DefaultOptions.StartColorPB, true)
end)
local color2Type6 = BarColors:CreateColorSelect(L.BarEndColorPhase, function(_, r, g, b)
	DBT:SetOption("EndColorPR", r)
	DBT:SetOption("EndColorPG", g)
	DBT:SetOption("EndColorPB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorPR, DBT.DefaultOptions.EndColorPG, DBT.DefaultOptions.EndColorPB, true)
end)
color1Type6:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 270, -225)
color2Type6:SetPoint("TOPLEFT", color1Type6, "TOPRIGHT", 20, 0)
color1Type6.myheight = 0
color2Type6.myheight = 0

color1Type6:SetColorRGB(DBT.Options.StartColorPR, DBT.Options.StartColorPG, DBT.Options.StartColorPB)
color2Type6:SetColorRGB(DBT.Options.EndColorPR, DBT.Options.EndColorPG, DBT.Options.EndColorPB)

---@class DummyColorBar6: DBTBar
local dummybarcolor6 = DBT:CreateDummyBar(6, nil, L.CBTPhase)
dummybarcolor6.frame:SetParent(BarColors.frame)
dummybarcolor6.frame:SetPoint("BOTTOMLEFT", color1Type6, "TOPLEFT", 20, 10)
dummybarcolor6.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor6:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor6.ApplyStyle
	function dummybarcolor6:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end

local ImpBarColors = BarSetupPanel:CreateArea(L.AreaTitle_ImpBarColors)

--Color Type 7 (Important (User))
local color1Type7 = ImpBarColors:CreateColorSelect(L.BarStartColorUI, function(_, r, g, b)
	DBT:SetOption("StartColorUIR", r)
	DBT:SetOption("StartColorUIG", g)
	DBT:SetOption("StartColorUIB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorUIR, DBT.DefaultOptions.StartColorUIG, DBT.DefaultOptions.StartColorUIB, true)
end)
local color2Type7 = ImpBarColors:CreateColorSelect(L.BarEndColorUI, function(_, r, g, b)
	DBT:SetOption("EndColorUIR", r)
	DBT:SetOption("EndColorUIG", g)
	DBT:SetOption("EndColorUIB", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorUIR, DBT.DefaultOptions.EndColorUIG, DBT.DefaultOptions.EndColorUIB, true)
end)
color1Type7:SetPoint("TOPLEFT", ImpBarColors.frame, "TOPLEFT", 30, -55)
color2Type7:SetPoint("TOPLEFT", color1Type7, "TOPRIGHT", 20, 0)
color1Type7.myheight = 75
color2Type7.myheight = 0

color1Type7:SetColorRGB(DBT.Options.StartColorUIR, DBT.Options.StartColorUIG, DBT.Options.StartColorUIB)
color2Type7:SetColorRGB(DBT.Options.EndColorUIR, DBT.Options.EndColorUIG, DBT.Options.EndColorUIB)

---@class DummyColorBar7: DBTBar
local dummybarcolor7 = DBT:CreateDummyBar(7, nil, L.CBTImportant)
dummybarcolor7.frame:SetParent(ImpBarColors.frame)
dummybarcolor7.frame:SetPoint("BOTTOMLEFT", color1Type7, "TOPLEFT", 20, 10)
dummybarcolor7.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor7:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor7.ApplyStyle
	function dummybarcolor7:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
dummybarcolor7:ApplyStyle()

--Important 2
local color1Type8 = ImpBarColors:CreateColorSelect(L.BarStartColorI2, function(_, r, g, b)
	DBT:SetOption("StartColorI2R", r)
	DBT:SetOption("StartColorI2G", g)
	DBT:SetOption("StartColorI2B", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.StartColorI2R, DBT.DefaultOptions.StartColorI2G, DBT.DefaultOptions.StartColorI2B, true)
end)
local color2Type8 = ImpBarColors:CreateColorSelect(L.BarEndColorI2, function(_, r, g, b)
	DBT:SetOption("EndColorI2R", r)
	DBT:SetOption("EndColorI2G", g)
	DBT:SetOption("EndColorI2B", b)
end, function(self)
	self:SetColorRGB(DBT.DefaultOptions.EndColorI2R, DBT.DefaultOptions.EndColorI2G, DBT.DefaultOptions.EndColorI2B, true)
end)
color1Type8:SetPoint("TOPLEFT", ImpBarColors.frame, "TOPLEFT", 270, -55)
color2Type8:SetPoint("TOPLEFT", color1Type8, "TOPRIGHT", 20, 0)
color1Type8.myheight = 0
color2Type8.myheight = 0

color1Type8:SetColorRGB(DBT.Options.StartColorI2R, DBT.Options.StartColorI2G, DBT.Options.StartColorI2B)
color2Type8:SetColorRGB(DBT.Options.EndColorI2R, DBT.Options.EndColorI2G, DBT.Options.EndColorI2B)

---@class DummyColorBar8: DBTBar
local dummybarcolor8 = DBT:CreateDummyBar(8, nil, L.CBTImportant)
dummybarcolor8.frame:SetParent(ImpBarColors.frame)
dummybarcolor8.frame:SetPoint("BOTTOMLEFT", color1Type8, "TOPLEFT", 20, 10)
dummybarcolor8.frame:SetScript("OnUpdate", function(_, elapsed)
	dummybarcolor8:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = dummybarcolor8.ApplyStyle
	function dummybarcolor8:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
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
	local ttext = _G[dummybarcolor7.frame:GetName().."BarName"]:GetText() or ""
	ttext = ttext:gsub("|T.-|t", "")
	dummybarcolor7:SetText(ttext)
end)
