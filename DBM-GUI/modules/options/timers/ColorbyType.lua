local L = DBM_GUI_L

local BarSetupPanel = DBM_GUI.Cat_Timers:CreateNewPanel(L.Panel_ColorByType, "option")

local BarColors = BarSetupPanel:CreateArea(L.AreaTitle_BarColors)
local movemebutton = BarColors:CreateButton(L.MoveMe, 100, 16)
movemebutton:SetPoint("TOPRIGHT", BarColors.frame, "TOPRIGHT", -2, -4)
movemebutton:SetNormalFontObject(GameFontNormalSmall)
movemebutton:SetHighlightFontObject(GameFontNormalSmall)
movemebutton:SetScript("OnClick", function() DBM.Bars:ShowMovableBar() end)

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
	color1Type1:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorAR"), DBM.Bars:GetDefaultOption("StartColorAG"), DBM.Bars:GetDefaultOption("StartColorAB"))
end)
color2Type1reset:SetScript("OnClick", function()
	color2Type1:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorAR"), DBM.Bars:GetDefaultOption("EndColorAG"), DBM.Bars:GetDefaultOption("EndColorAB"))
end)

local color1Type1text = BarColors:CreateText(L.BarStartColorAdd, 80)
local color2Type1text = BarColors:CreateText(L.BarEndColorAdd, 80)
color1Type1text:SetPoint("BOTTOM", color1Type1, "TOP", 0, 4)
color2Type1text:SetPoint("BOTTOM", color2Type1, "TOP", 0, 4)
color1Type1text.myheight = 0
color2Type1text.myheight = 0
color1Type1:SetColorRGB(DBM.Bars:GetOption("StartColorAR"), DBM.Bars:GetOption("StartColorAG"), DBM.Bars:GetOption("StartColorAB"))
color1Type1text:SetTextColor(DBM.Bars:GetOption("StartColorAR"), DBM.Bars:GetOption("StartColorAG"), DBM.Bars:GetOption("StartColorAB"))
color2Type1:SetColorRGB(DBM.Bars:GetOption("EndColorAR"), DBM.Bars:GetOption("EndColorAG"), DBM.Bars:GetOption("EndColorAB"))
color2Type1text:SetTextColor(DBM.Bars:GetOption("EndColorAR"), DBM.Bars:GetOption("EndColorAG"), DBM.Bars:GetOption("EndColorAB"))
color1Type1:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorAR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorAG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorAB", select(3, self:GetColorRGB()))
	color1Type1text:SetTextColor(self:GetColorRGB())
end)
color2Type1:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorAR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorAG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorAB", select(3, self:GetColorRGB()))
	color2Type1text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor1 = DBM.Bars:CreateDummyBar(1, nil, L.CBTAdd)
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
	color1Type2:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorAER"), DBM.Bars:GetDefaultOption("StartColorAEG"), DBM.Bars:GetDefaultOption("StartColorAEB"))
end)
color2Type2reset:SetScript("OnClick", function()
	color2Type2:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorAER"), DBM.Bars:GetDefaultOption("EndColorAEG"), DBM.Bars:GetDefaultOption("EndColorAEB"))
end)

local color1Type2text = BarColors:CreateText(L.BarStartColorAOE, 80)
local color2Type2text = BarColors:CreateText(L.BarEndColorAOE, 80)
color1Type2text:SetPoint("BOTTOM", color1Type2, "TOP", 0, 4)
color2Type2text:SetPoint("BOTTOM", color2Type2, "TOP", 0, 4)
color1Type2text.myheight = 0
color2Type2text.myheight = 0
color1Type2:SetColorRGB(DBM.Bars:GetOption("StartColorAER"), DBM.Bars:GetOption("StartColorAEG"), DBM.Bars:GetOption("StartColorAEB"))
color1Type2text:SetTextColor(DBM.Bars:GetOption("StartColorAER"), DBM.Bars:GetOption("StartColorAEG"), DBM.Bars:GetOption("StartColorAEB"))
color2Type2:SetColorRGB(DBM.Bars:GetOption("EndColorAER"), DBM.Bars:GetOption("EndColorAEG"), DBM.Bars:GetOption("EndColorAEB"))
color2Type2text:SetTextColor(DBM.Bars:GetOption("EndColorAER"), DBM.Bars:GetOption("EndColorAEG"), DBM.Bars:GetOption("EndColorAEB"))
color1Type2:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorAER", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorAEG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorAEB", select(3, self:GetColorRGB()))
	color1Type2text:SetTextColor(self:GetColorRGB())
end)
color2Type2:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorAER", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorAEG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorAEB", select(3, self:GetColorRGB()))
	color2Type2text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor2 = DBM.Bars:CreateDummyBar(2, nil, L.CBTAOE)
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
	color1Type3:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorDR"), DBM.Bars:GetDefaultOption("StartColorDG"), DBM.Bars:GetDefaultOption("StartColorDB"))
end)
color2Type3reset:SetScript("OnClick", function()
	color2Type3:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorDR"), DBM.Bars:GetDefaultOption("EndColorDG"), DBM.Bars:GetDefaultOption("EndColorDB"))
end)

local color1Type3text = BarColors:CreateText(L.BarStartColorDebuff, 80)
local color2Type3text = BarColors:CreateText(L.BarEndColorDebuff, 80)
color1Type3text:SetPoint("BOTTOM", color1Type3, "TOP", 0, 4)
color2Type3text:SetPoint("BOTTOM", color2Type3, "TOP", 0, 4)
color1Type3text.myheight = 0
color2Type3text.myheight = 0
color1Type3:SetColorRGB(DBM.Bars:GetOption("StartColorDR"), DBM.Bars:GetOption("StartColorDG"), DBM.Bars:GetOption("StartColorDB"))
color1Type3text:SetTextColor(DBM.Bars:GetOption("StartColorDR"), DBM.Bars:GetOption("StartColorDG"), DBM.Bars:GetOption("StartColorDB"))
color2Type3:SetColorRGB(DBM.Bars:GetOption("EndColorDR"), DBM.Bars:GetOption("EndColorDG"), DBM.Bars:GetOption("EndColorDB"))
color2Type3text:SetTextColor(DBM.Bars:GetOption("EndColorDR"), DBM.Bars:GetOption("EndColorDG"), DBM.Bars:GetOption("EndColorDB"))
color1Type3:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorDR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorDG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorDB", select(3, self:GetColorRGB()))
	color1Type3text:SetTextColor(self:GetColorRGB())
end)
color2Type3:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorDR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorDG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorDB", select(3, self:GetColorRGB()))
	color2Type3text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor3 = DBM.Bars:CreateDummyBar(3, nil, L.CBTTargeted)
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
	color1Type4:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorIR"), DBM.Bars:GetDefaultOption("StartColorIG"), DBM.Bars:GetDefaultOption("StartColorIB"))
end)
color2Type4reset:SetScript("OnClick", function()
	color2Type4:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorIR"), DBM.Bars:GetDefaultOption("EndColorIG"), DBM.Bars:GetDefaultOption("EndColorIB"))
end)

local color1Type4text = BarColors:CreateText(L.BarStartColorInterrupt, 80)
local color2Type4text = BarColors:CreateText(L.BarEndColorInterrupt, 80)
color1Type4text:SetPoint("BOTTOM", color1Type4, "TOP", 0, 4)
color2Type4text:SetPoint("BOTTOM", color2Type4, "TOP", 0, 4)
color1Type4text.myheight = 0
color2Type4text.myheight = 0
color1Type4:SetColorRGB(DBM.Bars:GetOption("StartColorIR"), DBM.Bars:GetOption("StartColorIG"), DBM.Bars:GetOption("StartColorIB"))
color1Type4text:SetTextColor(DBM.Bars:GetOption("StartColorIR"), DBM.Bars:GetOption("StartColorIG"), DBM.Bars:GetOption("StartColorIB"))
color2Type4:SetColorRGB(DBM.Bars:GetOption("EndColorIR"), DBM.Bars:GetOption("EndColorIG"), DBM.Bars:GetOption("EndColorIB"))
color2Type4text:SetTextColor(DBM.Bars:GetOption("EndColorIR"), DBM.Bars:GetOption("EndColorIG"), DBM.Bars:GetOption("EndColorIB"))
color1Type4:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorIR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorIG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorIB", select(3, self:GetColorRGB()))
	color1Type4text:SetTextColor(self:GetColorRGB())
end)
color2Type4:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorIR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorIG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorIB", select(3, self:GetColorRGB()))
	color2Type4text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor4 = DBM.Bars:CreateDummyBar(4, nil, L.CBTInterrupt)
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
	color1Type5:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorRR"), DBM.Bars:GetDefaultOption("StartColorRG"), DBM.Bars:GetDefaultOption("StartColorRB"))
end)
color2Type5reset:SetScript("OnClick", function()
	color2Type5:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorRR"), DBM.Bars:GetDefaultOption("EndColorRG"), DBM.Bars:GetDefaultOption("EndColorRB"))
end)

local color1Type5text = BarColors:CreateText(L.BarStartColorRole, 80)
local color2Type5text = BarColors:CreateText(L.BarEndColorRole, 80)
color1Type5text:SetPoint("BOTTOM", color1Type5, "TOP", 0, 4)
color2Type5text:SetPoint("BOTTOM", color2Type5, "TOP", 0, 4)
color1Type5text.myheight = 0
color2Type5text.myheight = 0
color1Type5:SetColorRGB(DBM.Bars:GetOption("StartColorRR"), DBM.Bars:GetOption("StartColorRG"), DBM.Bars:GetOption("StartColorRB"))
color1Type5text:SetTextColor(DBM.Bars:GetOption("StartColorRR"), DBM.Bars:GetOption("StartColorRG"), DBM.Bars:GetOption("StartColorRB"))
color2Type5:SetColorRGB(DBM.Bars:GetOption("EndColorRR"), DBM.Bars:GetOption("EndColorRG"), DBM.Bars:GetOption("EndColorRB"))
color2Type5text:SetTextColor(DBM.Bars:GetOption("EndColorRR"), DBM.Bars:GetOption("EndColorRG"), DBM.Bars:GetOption("EndColorRB"))
color1Type5:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorRR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorRG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorRB", select(3, self:GetColorRGB()))
	color1Type5text:SetTextColor(self:GetColorRGB())
end)
color2Type5:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorRR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorRG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorRB", select(3, self:GetColorRGB()))
	color2Type5text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor5 = DBM.Bars:CreateDummyBar(5, nil, L.CBTRole)
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
	color1Type6:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorPR"), DBM.Bars:GetDefaultOption("StartColorPG"), DBM.Bars:GetDefaultOption("StartColorPB"))
end)
color2Type6reset:SetScript("OnClick", function()
	color2Type6:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorPR"), DBM.Bars:GetDefaultOption("EndColorPG"), DBM.Bars:GetDefaultOption("EndColorPB"))
end)

local color1Type6text = BarColors:CreateText(L.BarStartColorPhase, 80)
local color2Type6text = BarColors:CreateText(L.BarEndColorPhase, 80)
color1Type6text:SetPoint("BOTTOM", color1Type6, "TOP", 0, 4)
color2Type6text:SetPoint("BOTTOM", color2Type6, "TOP", 0, 4)
color1Type6text.myheight = 0
color2Type6text.myheight = 0
color1Type6:SetColorRGB(DBM.Bars:GetOption("StartColorPR"), DBM.Bars:GetOption("StartColorPG"), DBM.Bars:GetOption("StartColorPB"))
color1Type6text:SetTextColor(DBM.Bars:GetOption("StartColorPR"), DBM.Bars:GetOption("StartColorPG"), DBM.Bars:GetOption("StartColorPB"))
color2Type6:SetColorRGB(DBM.Bars:GetOption("EndColorPR"), DBM.Bars:GetOption("EndColorPG"), DBM.Bars:GetOption("EndColorPB"))
color2Type6text:SetTextColor(DBM.Bars:GetOption("EndColorPR"), DBM.Bars:GetOption("EndColorPG"), DBM.Bars:GetOption("EndColorPB"))
color1Type6:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorPR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorPG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorPB", select(3, self:GetColorRGB()))
	color1Type6text:SetTextColor(self:GetColorRGB())
end)
color2Type6:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorPR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorPG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorPB", select(3, self:GetColorRGB()))
	color2Type6text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor6 = DBM.Bars:CreateDummyBar(6, nil, L.CBTPhase)
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
	color1Type7:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorUIR"), DBM.Bars:GetDefaultOption("StartColorUIG"), DBM.Bars:GetDefaultOption("StartColorUIB"))
end)
color2Type7reset:SetScript("OnClick", function()
	color2Type7:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorUIR"), DBM.Bars:GetDefaultOption("EndColorUIG"), DBM.Bars:GetDefaultOption("EndColorUIB"))
end)

local color1Type7text = BarColors:CreateText(L.BarStartColorUI, 80)
local color2Type7text = BarColors:CreateText(L.BarEndColorUI, 80)
color1Type7text:SetPoint("BOTTOM", color1Type7, "TOP", 0, 4)
color2Type7text:SetPoint("BOTTOM", color2Type7, "TOP", 0, 4)
color1Type7text.myheight = 0
color2Type7text.myheight = 0
color1Type7:SetColorRGB(DBM.Bars:GetOption("StartColorUIR"), DBM.Bars:GetOption("StartColorUIG"), DBM.Bars:GetOption("StartColorUIB"))
color1Type7text:SetTextColor(DBM.Bars:GetOption("StartColorUIR"), DBM.Bars:GetOption("StartColorUIG"), DBM.Bars:GetOption("StartColorUIB"))
color2Type7:SetColorRGB(DBM.Bars:GetOption("EndColorUIR"), DBM.Bars:GetOption("EndColorUIG"), DBM.Bars:GetOption("EndColorUIB"))
color2Type7text:SetTextColor(DBM.Bars:GetOption("EndColorUIR"), DBM.Bars:GetOption("EndColorUIG"), DBM.Bars:GetOption("EndColorUIB"))
color1Type7:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("StartColorUIR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorUIG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("StartColorUIB", select(3, self:GetColorRGB()))
	color1Type7text:SetTextColor(self:GetColorRGB())
end)
color2Type7:SetScript("OnColorSelect", function(self)
	DBM.Bars:SetOption("EndColorUIR", select(1, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorUIG", select(2, self:GetColorRGB()))
	DBM.Bars:SetOption("EndColorUIB", select(3, self:GetColorRGB()))
	color2Type7text:SetTextColor(self:GetColorRGB())
end)

local dummybarcolor7 = DBM.Bars:CreateDummyBar(7, nil, L.CBTImportant)
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
	DBM.Bars:SetOption("Bar7ForceLarge", not DBM.Bars:GetOption("Bar7ForceLarge"))
	if DBM.Bars:GetOption("Bar7ForceLarge") then
		dummybarcolor7.enlarged = true
	else
		dummybarcolor7.enlarged = false
	end
	dummybarcolor7:ApplyStyle()
end)

local customInline = BarColors:CreateCheckButton(L.Bar7CustomInline, false, nil, nil, "Bar7CustomInline")
customInline:SetPoint("TOPLEFT", forceLarge, "BOTTOMLEFT")
customInline:SetScript("OnClick", function(self)
	DBM.Bars:SetOption("Bar7CustomInline", not DBM.Bars:GetOption("Bar7CustomInline"))
	local ttext = _G[dummybarcolor7.frame:GetName().."BarName"]:GetText() or ""
	ttext = ttext:gsub("|T.-|t", "")
	dummybarcolor7:SetText(ttext)
end)
