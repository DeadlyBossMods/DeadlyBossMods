local L = DBM_GUI_L

local BarSetupPanel = DBM_GUI_Frame:CreateNewPanel(L.BarSetup, "option")

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

local BarSetup = BarSetupPanel:CreateArea(L.AreaTitle_BarSetup)

local color1 = BarSetup:CreateColorSelect(64)
local color2 = BarSetup:CreateColorSelect(64)
color1:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 30, -80)
color2:SetPoint("TOPLEFT", color1, "TOPRIGHT", 20, 0)
color1.myheight = 84
color2.myheight = 0

local color1reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
local color2reset = BarSetup:CreateButton(L.Reset, 64, 10, nil, GameFontNormalSmall)
color1reset:SetPoint("TOP", color1, "BOTTOM", 5, -10)
color2reset:SetPoint("TOP", color2, "BOTTOM", 5, -10)
color1reset:SetScript("OnClick", function()
	color1:SetColorRGB(DBM.Bars:GetDefaultOption("StartColorR"), DBM.Bars:GetDefaultOption("StartColorG"), DBM.Bars:GetDefaultOption("StartColorB"))
end)
color2reset:SetScript("OnClick", function()
	color2:SetColorRGB(DBM.Bars:GetDefaultOption("EndColorR"), DBM.Bars:GetDefaultOption("EndColorG"), DBM.Bars:GetDefaultOption("EndColorB"))
end)

local color1text = BarSetup:CreateText(L.BarStartColor, 80)
local color2text = BarSetup:CreateText(L.BarEndColor, 80)
color1text:SetPoint("BOTTOM", color1, "TOP", 0, 4)
color2text:SetPoint("BOTTOM", color2, "TOP", 0, 4)
color1text.myheight = 0
color2text.myheight = 0
color1:SetColorRGB(DBM.Bars:GetOption("StartColorR"), DBM.Bars:GetOption("StartColorG"), DBM.Bars:GetOption("StartColorB"))
color1text:SetTextColor(DBM.Bars:GetOption("StartColorR"), DBM.Bars:GetOption("StartColorG"), DBM.Bars:GetOption("StartColorB"))
color2:SetColorRGB(DBM.Bars:GetOption("EndColorR"), DBM.Bars:GetOption("EndColorG"), DBM.Bars:GetOption("EndColorB"))
color2text:SetTextColor(DBM.Bars:GetOption("EndColorR"), DBM.Bars:GetOption("EndColorG"), DBM.Bars:GetOption("EndColorB"))
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

local maindummybar = DBM.Bars:CreateDummyBar(nil, nil, SMALL)
maindummybar.frame:SetParent(BarSetup.frame)
maindummybar.frame:SetPoint("TOP", color2text, "LEFT", 10, 60)
maindummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	maindummybar:Update(elapsed)
end)
do
	-- little hook to prevent this bar from changing size/scale
	local old = maindummybar.ApplyStyle
	function maindummybar:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
maindummybar:ApplyStyle()

local maindummybarHuge = DBM.Bars:CreateDummyBar(nil, nil, LARGE)
maindummybarHuge.frame:SetParent(BarSetup.frame)
maindummybarHuge.frame:SetPoint("TOP", color2text, "LEFT", 10, 35)
maindummybarHuge.frame:SetScript("OnUpdate", function(_, elapsed)
	maindummybarHuge:Update(elapsed)
end)
maindummybarHuge.enlarged = true
maindummybarHuge.dummyEnlarge = true
do
	-- Little hook to prevent this bar from changing size/scale
	local old = maindummybarHuge.ApplyStyle
	function maindummybarHuge:ApplyStyle(...)
		old(self, ...)
		self.frame:SetWidth(183)
		self.frame:SetScale(0.9)
		_G[self.frame:GetName() .. "Bar"]:SetWidth(183)
	end
end
maindummybarHuge:ApplyStyle()

local Styles = {
	{
		text	= L.BarDBM,
		value	= "DBM"
	},
	{
		text	= L.BarSimple,
		value	= "NoAnim"
	}
}

local StyleDropDown = BarSetup:CreateDropdown(L.BarStyle, Styles, "DBT", "BarStyle", function(value)
	DBM.Bars:SetOption("BarStyle", value)
end, 210)
StyleDropDown:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 210, -25)
StyleDropDown.myheight = 0

local Textures = DBM_GUI:MixinSharedMedia3("statusbar", {
	{
		text	= "Default",
		value	= "Interface\\AddOns\\DBM-DefaultSkin\\textures\\default.blp"
	},
	{
		text	= "Blizzad",
		value	= "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar" -- 136570
	},
	{
		text	= "Glaze",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\glaze.blp"
	},
	{
		text	= "Otravi",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\otravi.blp"
	},
	{
		text	= "Smooth",
		value	= "Interface\\AddOns\\DBM-Core\\textures\\smooth.blp"
	}
})

local TextureDropDown = BarSetup:CreateDropdown(L.BarTexture, Textures, "DBT", "Texture", function(value)
	DBM.Bars:SetOption("Texture", value)
end)
TextureDropDown:SetPoint("TOPLEFT", StyleDropDown, "BOTTOMLEFT", 0, -10)
TextureDropDown.myheight = 0

local Fonts = DBM_GUI:MixinSharedMedia3("font", {
	{
		text	= "Default",
		value	= "standardFont"
	},
	{
		text	= "Arial",
		value	= "Fonts\\ARIALN.TTF"
	},
	{
		text	= "Skurri",
		value	= "Fonts\\skurri.ttf"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS.ttf"
	}
})

local FontDropDown = BarSetup:CreateDropdown(L.Bar_Font, Fonts, "DBT", "Font", function(value)
	DBM.Bars:SetOption("Font", value)
end)
FontDropDown:SetPoint("TOPLEFT", TextureDropDown, "BOTTOMLEFT", 0, -10)
FontDropDown.myheight = 0

local FontFlags = {
	{
		text	= L.None,
		value	= "None"
	},
	{
		text	= L.Outline,
		value	= "OUTLINE",
		flag	= true
	},
	{
		text	= L.ThickOutline,
		value	= "THICKOUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeOutline,
		value	= "MONOCHROME,OUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeThickOutline,
		value	= "MONOCHROME,THICKOUTLINE",
		flag	= true
	}
}

local FontFlagDropDown = BarSetup:CreateDropdown(L.Warn_FontStyle, FontFlags, "DBT", "FontFlag",
	function(value)
		DBM.Bars:SetOption("FontFlag", value)
	end)
FontFlagDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, -10)
FontFlagDropDown.myheight = 0

local iconleft = BarSetup:CreateCheckButton(L.BarIconLeft, nil, nil, nil, "IconLeft")
iconleft:SetPoint("TOPLEFT", FontFlagDropDown, "BOTTOMLEFT", 10, 0)

local iconright = BarSetup:CreateCheckButton(L.BarIconRight, nil, nil, nil, "IconRight")
iconright:SetPoint("LEFT", iconleft, "LEFT", 130, 0)

local SparkBars = BarSetup:CreateCheckButton(L.BarSpark, false, nil, nil, "Spark")
SparkBars:SetPoint("TOPLEFT", iconleft, "BOTTOMLEFT")

local FlashBars = BarSetup:CreateCheckButton(L.BarFlash, false, nil, nil, "FlashBar")
FlashBars:SetPoint("TOPLEFT", SparkBars, "BOTTOMLEFT")

local ColorBars = BarSetup:CreateCheckButton(L.BarColorByType, false, nil, nil, "ColorByType")
ColorBars:SetPoint("TOPLEFT", FlashBars, "BOTTOMLEFT")

local InlineIcons = BarSetup:CreateCheckButton(L.BarInlineIcons, false, nil, nil, "InlineIcons")
InlineIcons:SetPoint("LEFT", ColorBars, "LEFT", 130, 0)

-- Functions for bar setup
local function createDBTOnValueChangedHandler(option)
	return function(self)
		DBM.Bars:SetOption(option, self:GetValue())
		self:SetValue(DBM.Bars:GetOption(option))
	end
end

local function resetDBTValueToDefault(slider, option)
	DBM.Bars:SetOption(option, DBM.Bars:GetDefaultOption(option))
	slider:SetValue(DBM.Bars:GetOption(option))
end

local FontSizeSlider = BarSetup:CreateSlider(L.Bar_FontSize, 7, 18, 1)
FontSizeSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -180)
FontSizeSlider:SetValue(DBM.Bars:GetOption("FontSize"))
FontSizeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("FontSize"))

local BarHeightSlider = BarSetup:CreateSlider(L.Bar_Height, 10, 35, 1)
BarHeightSlider:SetPoint("TOPLEFT", BarSetup.frame, "TOPLEFT", 20, -220)
BarHeightSlider:SetValue(DBM.Bars:GetOption("Height"))
BarHeightSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Height"))

local DisableBarFade = BarSetup:CreateCheckButton(L.NoBarFade, false, nil, nil, "NoBarFade")
DisableBarFade:SetPoint("TOPLEFT", BarHeightSlider, "BOTTOMLEFT", 0, -50)
DisableBarFade.myheight = 50 -- Extra padding because right buttons are offset from sliders

local BarBehaviors = BarSetupPanel:CreateArea(L.AreaTitle_Behavior)

local DecimalSlider = BarBehaviors:CreateSlider(L.Bar_Decimal, 5, 60, 1)
DecimalSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 20, -25)
DecimalSlider:SetValue(DBM.Bars:GetOption("TDecimal"))
DecimalSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("TDecimal"))

local EnlargeTimeSlider = BarBehaviors:CreateSlider(L.Bar_EnlargeTime, 6, 30, 1)
EnlargeTimeSlider:SetPoint("TOPLEFT", BarBehaviors.frame, "TOPLEFT", 230, -25)
EnlargeTimeSlider:SetValue(DBM.Bars:GetOption("EnlargeBarTime"))
EnlargeTimeSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("EnlargeBarTime"))
EnlargeTimeSlider.myheight = 0

local ClickThrough = BarBehaviors:CreateCheckButton(L.ClickThrough, true, nil, nil, "ClickThrough")
ClickThrough:SetPoint("TOPLEFT", DecimalSlider, "BOTTOMLEFT", 0, -15)
ClickThrough.myheight = 25

BarBehaviors:CreateCheckButton(L.BarSort, true, nil, nil, "Sort")
BarBehaviors:CreateCheckButton(L.ShortTimerText, true, nil, "ShortTimerText")
BarBehaviors:CreateCheckButton(L.StripTimerText, true, nil, nil, "StripCDText")
BarBehaviors:CreateCheckButton(L.KeepBar, true, nil, nil, "KeepBars")
BarBehaviors:CreateCheckButton(L.FadeBar, true, nil, nil, "FadeBars")

local BarSetupSmall = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupSmall)

local smalldummybar = DBM.Bars:CreateDummyBar(nil, nil, SMALL)
smalldummybar.frame:SetParent(BarSetupSmall.frame)
smalldummybar.frame:SetPoint("BOTTOM", BarSetupSmall.frame, "TOP", 0, -35)
smalldummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	smalldummybar:Update(elapsed)
end)

local ExpandUpwards = BarSetupSmall:CreateCheckButton(L.ExpandUpwards, false, nil, nil, "ExpandUpwards")
ExpandUpwards:SetPoint("TOPLEFT", smalldummybar.frame, "BOTTOMLEFT", -50, -15)

local FillUpBars = BarSetupSmall:CreateCheckButton(L.FillUpBars, false, nil, nil, "FillUpBars")
FillUpBars:SetPoint("TOPLEFT", smalldummybar.frame, "BOTTOMLEFT", 100, -15)

local BarWidthSlider = BarSetupSmall:CreateSlider(L.Slider_BarWidth, 100, 400, 1, 310)
BarWidthSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 20, -90)
BarWidthSlider:SetValue(DBM.Bars:GetOption("Width"))
BarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Width"))

local BarScaleSlider = BarSetupSmall:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05, 310)
BarScaleSlider:SetPoint("TOPLEFT", BarWidthSlider, "BOTTOMLEFT", 0, -10)
BarScaleSlider:SetValue(DBM.Bars:GetOption("Scale"))
BarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Scale"))

local AlphaSlider = BarSetupSmall:CreateSlider(L.Bar_Alpha, 0, 1, 0.1)
AlphaSlider:SetPoint("TOPLEFT", BarScaleSlider, "BOTTOMLEFT", 0, -10)
AlphaSlider:SetValue(DBM.Bars:GetOption("Alpha"))
AlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("Alpha"))

local BarOffsetXSlider = BarSetupSmall:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1, 120)
BarOffsetXSlider:SetPoint("TOPLEFT", BarSetupSmall.frame, "TOPLEFT", 350, -90)
BarOffsetXSlider:SetValue(DBM.Bars:GetOption("BarXOffset"))
BarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarXOffset"))
BarOffsetXSlider.myheight = 0

local BarOffsetYSlider = BarSetupSmall:CreateSlider(L.Slider_BarOffSetY, -5, 35, 1, 120)
BarOffsetYSlider:SetPoint("TOPLEFT", BarOffsetXSlider, "BOTTOMLEFT", 0, -10)
BarOffsetYSlider:SetValue(DBM.Bars:GetOption("BarYOffset"))
BarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("BarYOffset"))
BarOffsetYSlider.myheight = 0

local barResetbutton = BarSetupSmall:CreateButton(L.SpecWarn_ResetMe, 120, 16)
barResetbutton:SetPoint("BOTTOMRIGHT", BarSetupSmall.frame, "BOTTOMRIGHT", -2, 4)
barResetbutton:SetNormalFontObject(GameFontNormalSmall)
barResetbutton:SetHighlightFontObject(GameFontNormalSmall)
barResetbutton:SetScript("OnClick", function()
	resetDBTValueToDefault(BarWidthSlider, "Width")
	resetDBTValueToDefault(BarScaleSlider, "Scale")
	resetDBTValueToDefault(BarOffsetXSlider, "BarXOffset")
	resetDBTValueToDefault(BarOffsetYSlider, "BarYOffset")
	resetDBTValueToDefault(AlphaSlider, "Alpha")
end)

local BarSetupHuge = BarSetupPanel:CreateArea(L.AreaTitle_BarSetupHuge)

BarSetupHuge:CreateCheckButton(L.EnableHugeBar, true, nil, nil, "HugeBarsEnabled")

local hugedummybar = DBM.Bars:CreateDummyBar(nil, nil, LARGE)
hugedummybar.frame:SetParent(BarSetupHuge.frame)
hugedummybar.frame:SetPoint("BOTTOM", BarSetupHuge.frame, "TOP", 0, -50)
hugedummybar.frame:SetScript("OnUpdate", function(_, elapsed)
	hugedummybar:Update(elapsed)
end)
hugedummybar.enlarged = true
hugedummybar.dummyEnlarge = true
hugedummybar:ApplyStyle()

local ExpandUpwardsLarge = BarSetupHuge:CreateCheckButton(L.ExpandUpwards, false, nil, nil, "ExpandUpwardsLarge")
ExpandUpwardsLarge:SetPoint("TOPLEFT", hugedummybar.frame, "BOTTOMLEFT", -50, -15)

local FillUpBarsLarge = BarSetupHuge:CreateCheckButton(L.FillUpBars, false, nil, nil, "FillUpLargeBars")
FillUpBarsLarge:SetPoint("TOPLEFT", hugedummybar.frame, "BOTTOMLEFT", 100, -15)

local HugeBarWidthSlider = BarSetupHuge:CreateSlider(L.Slider_BarWidth, 100, 400, 1, 310)
HugeBarWidthSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 20, -105)
HugeBarWidthSlider:SetValue(DBM.Bars:GetOption("HugeWidth"))
HugeBarWidthSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeWidth"))

local HugeBarScaleSlider = BarSetupHuge:CreateSlider(L.Slider_BarScale, 0.75, 2, 0.05, 310)
HugeBarScaleSlider:SetPoint("TOPLEFT", HugeBarWidthSlider, "BOTTOMLEFT", 0, -10)
HugeBarScaleSlider:SetValue(DBM.Bars:GetOption("HugeScale"))
HugeBarScaleSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeScale"))

local HugeAlphaSlider = BarSetupHuge:CreateSlider(L.Bar_Alpha, 0.1, 1, 0.1)
HugeAlphaSlider:SetPoint("TOPLEFT", HugeBarScaleSlider, "BOTTOMLEFT", 0, -10)
HugeAlphaSlider:SetValue(DBM.Bars:GetOption("HugeAlpha"))
HugeAlphaSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeAlpha"))

local HugeBarOffsetXSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetX, -50, 50, 1, 120)
HugeBarOffsetXSlider:SetPoint("TOPLEFT", BarSetupHuge.frame, "TOPLEFT", 350, -105)
HugeBarOffsetXSlider:SetValue(DBM.Bars:GetOption("HugeBarXOffset"))
HugeBarOffsetXSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarXOffset"))
HugeBarOffsetXSlider.myheight = 0

local HugeBarOffsetYSlider = BarSetupHuge:CreateSlider(L.Slider_BarOffSetY, -5, 35, 1, 120)
HugeBarOffsetYSlider:SetPoint("TOPLEFT", HugeBarOffsetXSlider, "BOTTOMLEFT", 0, -10)
HugeBarOffsetYSlider:SetValue(DBM.Bars:GetOption("HugeBarYOffset"))
HugeBarOffsetYSlider:HookScript("OnValueChanged", createDBTOnValueChangedHandler("HugeBarYOffset"))
HugeBarOffsetYSlider.myheight = 0

local hugeBarResetbutton = BarSetupHuge:CreateButton(L.SpecWarn_ResetMe, 120, 16)
hugeBarResetbutton:SetPoint("BOTTOMRIGHT", BarSetupHuge.frame, "BOTTOMRIGHT", -2, 4)
hugeBarResetbutton:SetNormalFontObject(GameFontNormalSmall)
hugeBarResetbutton:SetHighlightFontObject(GameFontNormalSmall)
hugeBarResetbutton:SetScript("OnClick", function()
	resetDBTValueToDefault(HugeBarWidthSlider, "HugeWidth")
	resetDBTValueToDefault(HugeBarScaleSlider, "HugeScale")
	resetDBTValueToDefault(HugeBarOffsetXSlider, "HugeBarXOffset")
	resetDBTValueToDefault(HugeBarOffsetYSlider, "HugeBarYOffset")
	resetDBTValueToDefault(HugeAlphaSlider, "HugeAlpha")
end)
