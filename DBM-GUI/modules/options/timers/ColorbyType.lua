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
local color1Type1 = BarColors:CreateColorSelect(64)
local color2Type1 = BarColors:CreateColorSelect(64)
color1Type1:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -65)
color2Type1:SetPoint("TOPLEFT", color1Type1, "TOPRIGHT", 20, 0)
color1Type1.myheight = 84
color2Type1.myheight = 0

local color1Type1reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type1reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type1reset:SetPoint("TOP", color1Type1, "BOTTOM", 5, -10)
color2Type1reset:SetPoint("TOP", color2Type1, "BOTTOM", 5, -10)
color1Type1reset:SetScript("OnClick", function()
	color1Type1:SetColorRGB(DBT.DefaultOptions.StartColorAR, DBT.DefaultOptions.StartColorAG, DBT.DefaultOptions.StartColorAB)
end)
color2Type1reset:SetScript("OnClick", function()
	color2Type1:SetColorRGB(DBT.DefaultOptions.EndColorAR, DBT.DefaultOptions.EndColorAG, DBT.DefaultOptions.EndColorAB)
end)

local color1Type1text = BarColors:CreateText(L.BarStartColorAdd, 80)
local color2Type1text = BarColors:CreateText(L.BarEndColorAdd, 80)
color1Type1text:SetPoint("BOTTOM", color1Type1, "TOP", 0, 4)
color2Type1text:SetPoint("BOTTOM", color2Type1, "TOP", 0, 4)
color1Type1text.myheight = 0
color2Type1text.myheight = 0
color1Type1:SetColorRGB(DBT.Options.StartColorAR, DBT.Options.StartColorAG, DBT.Options.StartColorAB)
color1Type1text:SetTextColor(DBT.Options.StartColorAR, DBT.Options.StartColorAG, DBT.Options.StartColorAB)
color2Type1:SetColorRGB(DBT.Options.EndColorAR, DBT.Options.EndColorAG, DBT.Options.EndColorAB)
color2Type1text:SetTextColor(DBT.Options.EndColorAR, DBT.Options.EndColorAG, DBT.Options.EndColorAB)
color1Type1:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorAR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorAG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorAB", select(3, self:GetColorRGB()))
	color1Type1text:SetTextColor(self:GetColorRGB())
end)
color2Type1:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorAR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorAG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorAB", select(3, self:GetColorRGB()))
	color2Type1text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor1 = DBT:CreateDummyBar(1, nil, L.CBTAdd)
dummybarcolor1.frame:SetParent(BarColors.frame)
dummybarcolor1.frame:SetPoint("TOP", color2Type1text, "LEFT", 10, 40)
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
local color1Type2 = BarColors:CreateColorSelect(64)
local color2Type2 = BarColors:CreateColorSelect(64)
color1Type2:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 250, -65)
color2Type2:SetPoint("TOPLEFT", color1Type2, "TOPRIGHT", 20, 0)
color1Type2.myheight = 0
color2Type2.myheight = 0

local color1Type2reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type2reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type2reset:SetPoint("TOP", color1Type2, "BOTTOM", 5, -10)
color2Type2reset:SetPoint("TOP", color2Type2, "BOTTOM", 5, -10)
color1Type2reset:SetScript("OnClick", function()
	color1Type2:SetColorRGB(DBT.DefaultOptions.StartColorAER, DBT.DefaultOptions.StartColorAEG, DBT.DefaultOptions.StartColorAEB)
end)
color2Type2reset:SetScript("OnClick", function()
	color2Type2:SetColorRGB(DBT.DefaultOptions.EndColorAER, DBT.DefaultOptions.EndColorAEG, DBT.DefaultOptions.EndColorAEB)
end)

local color1Type2text = BarColors:CreateText(L.BarStartColorAOE, 80)
local color2Type2text = BarColors:CreateText(L.BarEndColorAOE, 80)
color1Type2text:SetPoint("BOTTOM", color1Type2, "TOP", 0, 4)
color2Type2text:SetPoint("BOTTOM", color2Type2, "TOP", 0, 4)
color1Type2text.myheight = 0
color2Type2text.myheight = 0
color1Type2:SetColorRGB(DBT.Options.StartColorAER, DBT.Options.StartColorAEG, DBT.Options.StartColorAEB)
color1Type2text:SetTextColor(DBT.Options.StartColorAER, DBT.Options.StartColorAEG, DBT.Options.StartColorAEB)
color2Type2:SetColorRGB(DBT.Options.EndColorAER, DBT.Options.EndColorAEG, DBT.Options.EndColorAEB)
color2Type2text:SetTextColor(DBT.Options.EndColorAER, DBT.Options.EndColorAEG, DBT.Options.EndColorAEB)
color1Type2:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorAER", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorAEG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorAEB", select(3, self:GetColorRGB()))
	color1Type2text:SetTextColor(self:GetColorRGB())
end)
color2Type2:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorAER", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorAEG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorAEB", select(3, self:GetColorRGB()))
	color2Type2text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor2 = DBT:CreateDummyBar(2, nil, L.CBTAOE)
dummybarcolor2.frame:SetParent(BarColors.frame)
dummybarcolor2.frame:SetPoint("TOP", color2Type2text, "LEFT", 10, 40)
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
local color1Type3 = BarColors:CreateColorSelect(64)
local color2Type3 = BarColors:CreateColorSelect(64)
color1Type3:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -220)
color2Type3:SetPoint("TOPLEFT", color1Type3, "TOPRIGHT", 20, 0)
color1Type3.myheight = 74
color2Type3.myheight = 0

local color1Type3reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type3reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type3reset:SetPoint("TOP", color1Type3, "BOTTOM", 5, -10)
color2Type3reset:SetPoint("TOP", color2Type3, "BOTTOM", 5, -10)
color1Type3reset:SetScript("OnClick", function()
	color1Type3:SetColorRGB(DBT.DefaultOptions.StartColorDR, DBT.DefaultOptions.StartColorDG, DBT.DefaultOptions.StartColorDB)
end)
color2Type3reset:SetScript("OnClick", function()
	color2Type3:SetColorRGB(DBT.DefaultOptions.EndColorDR, DBT.DefaultOptions.EndColorDG, DBT.DefaultOptions.EndColorDB)
end)

local color1Type3text = BarColors:CreateText(L.BarStartColorDebuff, 80)
local color2Type3text = BarColors:CreateText(L.BarEndColorDebuff, 80)
color1Type3text:SetPoint("BOTTOM", color1Type3, "TOP", 0, 4)
color2Type3text:SetPoint("BOTTOM", color2Type3, "TOP", 0, 4)
color1Type3text.myheight = 0
color2Type3text.myheight = 0
color1Type3:SetColorRGB(DBT.Options.StartColorDR, DBT.Options.StartColorDG, DBT.Options.StartColorDB)
color1Type3text:SetTextColor(DBT.Options.StartColorDR, DBT.Options.StartColorDG, DBT.Options.StartColorDB)
color2Type3:SetColorRGB(DBT.Options.EndColorDR, DBT.Options.EndColorDG, DBT.Options.EndColorDB)
color2Type3text:SetTextColor(DBT.Options.EndColorDR, DBT.Options.EndColorDG, DBT.Options.EndColorDB)
color1Type3:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorDR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorDG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorDB", select(3, self:GetColorRGB()))
	color1Type3text:SetTextColor(self:GetColorRGB())
end)
color2Type3:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorDR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorDG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorDB", select(3, self:GetColorRGB()))
	color2Type3text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor3 = DBT:CreateDummyBar(3, nil, L.CBTTargeted)
dummybarcolor3.frame:SetParent(BarColors.frame)
dummybarcolor3.frame:SetPoint("TOP", color2Type3text, "LEFT", 10, 40)
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
local color1Type4 = BarColors:CreateColorSelect(64)
local color2Type4 = BarColors:CreateColorSelect(64)
color1Type4:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 250, -220)
color2Type4:SetPoint("TOPLEFT", color1Type4, "TOPRIGHT", 20, 0)
color1Type4.myheight = 0
color2Type4.myheight = 0

local color1Type4reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type4reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type4reset:SetPoint("TOP", color1Type4, "BOTTOM", 5, -10)
color2Type4reset:SetPoint("TOP", color2Type4, "BOTTOM", 5, -10)
color1Type4reset:SetScript("OnClick", function()
	color1Type4:SetColorRGB(DBT.DefaultOptions.StartColorIR, DBT.DefaultOptions.StartColorIG, DBT.DefaultOptions.StartColorIB)
end)
color2Type4reset:SetScript("OnClick", function()
	color2Type4:SetColorRGB(DBT.DefaultOptions.EndColorIR, DBT.DefaultOptions.EndColorIG, DBT.DefaultOptions.EndColorIB)
end)

local color1Type4text = BarColors:CreateText(L.BarStartColorInterrupt, 80)
local color2Type4text = BarColors:CreateText(L.BarEndColorInterrupt, 80)
color1Type4text:SetPoint("BOTTOM", color1Type4, "TOP", 0, 4)
color2Type4text:SetPoint("BOTTOM", color2Type4, "TOP", 0, 4)
color1Type4text.myheight = 0
color2Type4text.myheight = 0
color1Type4:SetColorRGB(DBT.Options.StartColorIR, DBT.Options.StartColorIG, DBT.Options.StartColorIB)
color1Type4text:SetTextColor(DBT.Options.StartColorIR, DBT.Options.StartColorIG, DBT.Options.StartColorIB)
color2Type4:SetColorRGB(DBT.Options.EndColorIR, DBT.Options.EndColorIG, DBT.Options.EndColorIB)
color2Type4text:SetTextColor(DBT.Options.EndColorIR, DBT.Options.EndColorIG, DBT.Options.EndColorIB)
color1Type4:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorIR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorIG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorIB", select(3, self:GetColorRGB()))
	color1Type4text:SetTextColor(self:GetColorRGB())
end)
color2Type4:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorIR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorIG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorIB", select(3, self:GetColorRGB()))
	color2Type4text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor4 = DBT:CreateDummyBar(4, nil, L.CBTInterrupt)
dummybarcolor4.frame:SetParent(BarColors.frame)
dummybarcolor4.frame:SetPoint("TOP", color2Type4text, "LEFT", 10, 40)
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
local color1Type5 = BarColors:CreateColorSelect(64)
local color2Type5 = BarColors:CreateColorSelect(64)
color1Type5:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -375)
color2Type5:SetPoint("TOPLEFT", color1Type5, "TOPRIGHT", 20, 0)
color1Type5.myheight = 74
color2Type5.myheight = 0

local color1Type5reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type5reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type5reset:SetPoint("TOP", color1Type5, "BOTTOM", 5, -10)
color2Type5reset:SetPoint("TOP", color2Type5, "BOTTOM", 5, -10)
color1Type5reset:SetScript("OnClick", function()
	color1Type5:SetColorRGB(DBT.DefaultOptions.StartColorRR, DBT.DefaultOptions.StartColorRG, DBT.DefaultOptions.StartColorRB)
end)
color2Type5reset:SetScript("OnClick", function()
	color2Type5:SetColorRGB(DBT.DefaultOptions.EndColorRR, DBT.DefaultOptions.EndColorRG, DBT.DefaultOptions.EndColorRB)
end)

local color1Type5text = BarColors:CreateText(L.BarStartColorRole, 80)
local color2Type5text = BarColors:CreateText(L.BarEndColorRole, 80)
color1Type5text:SetPoint("BOTTOM", color1Type5, "TOP", 0, 4)
color2Type5text:SetPoint("BOTTOM", color2Type5, "TOP", 0, 4)
color1Type5text.myheight = 0
color2Type5text.myheight = 0
color1Type5:SetColorRGB(DBT.Options.StartColorRR, DBT.Options.StartColorRG, DBT.Options.StartColorRB)
color1Type5text:SetTextColor(DBT.Options.StartColorRR, DBT.Options.StartColorRG, DBT.Options.StartColorRB)
color2Type5:SetColorRGB(DBT.Options.EndColorRR, DBT.Options.EndColorRG, DBT.Options.EndColorRB)
color2Type5text:SetTextColor(DBT.Options.EndColorRR, DBT.Options.EndColorRG, DBT.Options.EndColorRB)
color1Type5:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorRR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorRG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorRB", select(3, self:GetColorRGB()))
	color1Type5text:SetTextColor(self:GetColorRGB())
end)
color2Type5:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorRR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorRG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorRB", select(3, self:GetColorRGB()))
	color2Type5text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor5 = DBT:CreateDummyBar(5, nil, L.CBTRole)
dummybarcolor5.frame:SetParent(BarColors.frame)
dummybarcolor5.frame:SetPoint("TOP", color2Type5text, "LEFT", 10, 40)
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
local color1Type6 = BarColors:CreateColorSelect(64)
local color2Type6 = BarColors:CreateColorSelect(64)
color1Type6:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 250, -375)
color2Type6:SetPoint("TOPLEFT", color1Type6, "TOPRIGHT", 20, 0)
color1Type6.myheight = 0
color2Type6.myheight = 0

local color1Type6reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type6reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type6reset:SetPoint("TOP", color1Type6, "BOTTOM", 5, -10)
color2Type6reset:SetPoint("TOP", color2Type6, "BOTTOM", 5, -10)
color1Type6reset:SetScript("OnClick", function()
	color1Type6:SetColorRGB(DBT.DefaultOptions.StartColorPR, DBT.DefaultOptions.StartColorPG, DBT.DefaultOptions.StartColorPB)
end)
color2Type6reset:SetScript("OnClick", function()
	color2Type6:SetColorRGB(DBT.DefaultOptions.EndColorPR, DBT.DefaultOptions.EndColorPG, DBT.DefaultOptions.EndColorPB)
end)

local color1Type6text = BarColors:CreateText(L.BarStartColorPhase, 80)
local color2Type6text = BarColors:CreateText(L.BarEndColorPhase, 80)
color1Type6text:SetPoint("BOTTOM", color1Type6, "TOP", 0, 4)
color2Type6text:SetPoint("BOTTOM", color2Type6, "TOP", 0, 4)
color1Type6text.myheight = 0
color2Type6text.myheight = 0
color1Type6:SetColorRGB(DBT.Options.StartColorPR, DBT.Options.StartColorPG, DBT.Options.StartColorPB)
color1Type6text:SetTextColor(DBT.Options.StartColorPR, DBT.Options.StartColorPG, DBT.Options.StartColorPB)
color2Type6:SetColorRGB(DBT.Options.EndColorPR, DBT.Options.EndColorPG, DBT.Options.EndColorPB)
color2Type6text:SetTextColor(DBT.Options.EndColorPR, DBT.Options.EndColorPG, DBT.Options.EndColorPB)
color1Type6:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorPR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorPG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorPB", select(3, self:GetColorRGB()))
	color1Type6text:SetTextColor(self:GetColorRGB())
end)
color2Type6:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorPR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorPG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorPB", select(3, self:GetColorRGB()))
	color2Type6text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor6 = DBT:CreateDummyBar(6, nil, L.CBTPhase)
dummybarcolor6.frame:SetParent(BarColors.frame)
dummybarcolor6.frame:SetPoint("TOP", color2Type6text, "LEFT", 10, 40)
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

--Color Type 7 (Important (User))
local color1Type7 = BarColors:CreateColorSelect(64)
local color2Type7 = BarColors:CreateColorSelect(64)
color1Type7:SetPoint("TOPLEFT", BarColors.frame, "TOPLEFT", 30, -530)
color2Type7:SetPoint("TOPLEFT", color1Type7, "TOPRIGHT", 20, 0)
color1Type7.myheight = 74
color2Type7.myheight = 0

local color1Type7reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2Type7reset = BarColors:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1Type7reset:SetPoint("TOP", color1Type7, "BOTTOM", 5, -10)
color2Type7reset:SetPoint("TOP", color2Type7, "BOTTOM", 5, -10)
color1Type7reset:SetScript("OnClick", function()
	color1Type7:SetColorRGB(DBT.DefaultOptions.StartColorUIR, DBT.DefaultOptions.StartColorUIG, DBT.DefaultOptions.StartColorUIB)
end)
color2Type7reset:SetScript("OnClick", function()
	color2Type7:SetColorRGB(DBT.DefaultOptions.EndColorUIR, DBT.DefaultOptions.EndColorUIG, DBT.DefaultOptions.EndColorUIB)
end)

local color1Type7text = BarColors:CreateText(L.BarStartColorUI, 80)
local color2Type7text = BarColors:CreateText(L.BarEndColorUI, 80)
color1Type7text:SetPoint("BOTTOM", color1Type7, "TOP", 0, 4)
color2Type7text:SetPoint("BOTTOM", color2Type7, "TOP", 0, 4)
color1Type7text.myheight = 0
color2Type7text.myheight = 0
color1Type7:SetColorRGB(DBT.Options.StartColorUIR, DBT.Options.StartColorUIG, DBT.Options.StartColorUIB)
color1Type7text:SetTextColor(DBT.Options.StartColorUIR, DBT.Options.StartColorUIG, DBT.Options.StartColorUIB)
color2Type7:SetColorRGB(DBT.Options.EndColorUIR, DBT.Options.EndColorUIG, DBT.Options.EndColorUIB)
color2Type7text:SetTextColor(DBT.Options.EndColorUIR, DBT.Options.EndColorUIG, DBT.Options.EndColorUIB)
color1Type7:SetScript("OnColorSelect", function(self)
	DBT:SetOption("StartColorUIR", select(1, self:GetColorRGB()))
	DBT:SetOption("StartColorUIG", select(2, self:GetColorRGB()))
	DBT:SetOption("StartColorUIB", select(3, self:GetColorRGB()))
	color1Type7text:SetTextColor(self:GetColorRGB())
end)
color2Type7:SetScript("OnColorSelect", function(self)
	DBT:SetOption("EndColorUIR", select(1, self:GetColorRGB()))
	DBT:SetOption("EndColorUIG", select(2, self:GetColorRGB()))
	DBT:SetOption("EndColorUIB", select(3, self:GetColorRGB()))
	color2Type7text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor7 = DBT:CreateDummyBar(7, nil, L.CBTImportant)
dummybarcolor7.frame:SetParent(BarColors.frame)
dummybarcolor7.frame:SetPoint("TOP", color2Type7text, "LEFT", 10, 40)
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

--Type 7 Extra Options
local bar7OptionsText = BarColors:CreateText(L.Bar7Header, 405, nil, nil, "LEFT")
bar7OptionsText:SetPoint("TOPLEFT", color2Type7text, "TOPLEFT", 150, 0)
bar7OptionsText.myheight = 0

local forceLarge = BarColors:CreateCheckButton(L.Bar7ForceLarge, false, nil, nil, "Bar7ForceLarge")
forceLarge:SetPoint("TOPLEFT", bar7OptionsText, "BOTTOMLEFT")
forceLarge:SetScript("OnClick", function(self)
	DBT:SetOption("Bar7ForceLarge", not DBT.Options.Bar7ForceLarge)
	if DBT.Options.Bar7ForceLarge then
		dummybarcolor7.enlarged = true
	else
		dummybarcolor7.enlarged = false
	end
	dummybarcolor7:ApplyStyle()
end)

local customInline = BarColors:CreateCheckButton(L.Bar7CustomInline, false, nil, nil, "Bar7CustomInline")
customInline:SetPoint("TOPLEFT", forceLarge, "BOTTOMLEFT")
customInline:SetScript("OnClick", function(self)
	DBT:SetOption("Bar7CustomInline", not DBT.Options.Bar7CustomInline)
	local ttext = _G[dummybarcolor7.frame:GetName().."BarName"]:GetText() or ""
	ttext = ttext:gsub("|T.-|t", "")
	dummybarcolor7:SetText(ttext)
end)
