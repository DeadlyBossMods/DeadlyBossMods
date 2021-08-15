DBT = {
	bars = {},
	numBars = 0
}
local DBT = DBT

local standardFont
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

DBT.DefaultOptions = {
	StartColorR = 1,
	StartColorG = 0.7,
	StartColorB = 0,
	EndColorR = 1,
	EndColorG = 0,
	EndColorB = 0,
	--Type 1 (Add)
	StartColorAR = 0.375,
	StartColorAG = 0.545,
	StartColorAB = 1,
	EndColorAR = 0.15,
	EndColorAG = 0.385,
	EndColorAB = 1,
	--Type 2 (AOE)
	StartColorAER = 1,
	StartColorAEG = 0.466,
	StartColorAEB = 0.459,
	EndColorAER = 1,
	EndColorAEG = 0.043,
	EndColorAEB = 0.247,
	--Type 3 (Targeted)
	StartColorDR = 0.9,
	StartColorDG = 0.3,
	StartColorDB = 1,
	EndColorDR = 1,
	EndColorDG = 0,
	EndColorDB = 1,
	--Type 4 (Interrupt)
	StartColorIR = 0.47,
	StartColorIG = 0.97,
	StartColorIB = 1,
	EndColorIR = 0.047,
	EndColorIG = 0.88,
	EndColorIB = 1,
	--Type 5 (Role)
	StartColorRR = 0.5,
	StartColorRG = 1,
	StartColorRB = 0.5,
	EndColorRR = 0.11,
	EndColorRG = 1,
	EndColorRB = 0.3,
	--Type 6 (Phase)
	StartColorPR = 1,
	StartColorPG = 0.776,
	StartColorPB = 0.420,
	EndColorPR = 0.5,
	EndColorPG = 0.41,
	EndColorPB = 0.285,
	--Type 7 (Important/User set only)
	StartColorUIR = 1,
	StartColorUIG = 1,
	StartColorUIB = 0.0627450980392157,
	EndColorUIR = 1,
	EndColorUIG = 0.92156862745098,
	EndColorUIB = 0.0117647058823529,
	Bar7ForceLarge = false,
	Bar7CustomInline = true,
	-- Small bar
	BarXOffset = 0,
	BarYOffset = 0,
	Width = 183,
	Height = 20,
	Alpha = 0.8,
	Scale = 0.9,
	TimerX = -223,
	TimerY = -260,
	ExpandUpwards = false,
	FillUpBars = true,
	TimerPoint = "TOPRIGHT",
	Sort = "Sort",
	-- Huge bar
	EnlargeBarTime = 11,
	HugeBarXOffset = 0,
	HugeBarYOffset = 0,
	HugeWidth = 200,
	HugeHeight = 20,
	HugeAlpha = 1,
	HugeScale = 1.03,
	HugeTimerX = 0,
	HugeTimerY = -120,
	ExpandUpwardsLarge = false,
	FillUpLargeBars = true,
	HugeBarsEnabled = true,
	HugeTimerPoint = "CENTER",
	HugeSort = "Sort",
	-- Misc
	TextColorR = 1,
	TextColorG = 1,
	TextColorB = 1,
	TDecimal = 11,
	FontSize = 10,
	FlashBar = false,
	Spark = true,
	ColorByType = true,
	NoBarFade = false,
	InlineIcons = true,
	IconLeft = true,
	IconRight = false,
	IconLocked = true,
	DynamicColor = true,
	ClickThrough = false,
	KeepBars = true,
	FadeBars = true,
	StripCDText = true,
	Texture = "Interface\\AddOns\\DBM-StatusBarTimers\\textures\\default.blp",
	Font = "standardFont",
	FontFlag = "None",
	BarStyle = "NoAnim",
	Skin = ""
}

local barPrototype, unusedBarObjects, barIsAnimating = {}, {}, false
local smallBars, largeBars = {}, {}

local smallBarsAnchor, largeBarsAnchor = CreateFrame("Frame", nil, UIParent), CreateFrame("Frame", nil, UIParent)
smallBarsAnchor:SetSize(1, 1)
smallBarsAnchor:SetPoint("TOPRIGHT", 223, -260)
smallBarsAnchor:SetClampedToScreen(true)
smallBarsAnchor:SetMovable(true)
smallBarsAnchor:Show()
largeBarsAnchor:SetSize(1, 1)
largeBarsAnchor:SetPoint("CENTER", 0, -120)
largeBarsAnchor:SetClampedToScreen(true)
largeBarsAnchor:SetMovable(true)
largeBarsAnchor:Show()

local ipairs, pairs, next, type, setmetatable, tinsert, tsort = ipairs, pairs, next, type, setmetatable, table.insert, table.sort
local UIParent = UIParent

function DBT:AddDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			self:AddDefaultOptions(t1[i], v)
		end
	end
end

do
	local CreateFrame, GetTime, IsShiftKeyDown = CreateFrame, GetTime, IsShiftKeyDown

	local function onUpdate(self, elapsed)
		if self.obj then
			self.obj.curTime = GetTime()
			self.obj.delta = self.obj.curTime - self.obj.lastUpdate
			if barIsAnimating and self.obj.delta >= 0.01 or self.obj.delta >= 0.04 then
				self.obj.lastUpdate = self.obj.curTime
				self.obj:Update(self.obj.delta)
			end
		end
	end

	local function onMouseDown(self, btn)
		if self.obj and btn == "LeftButton" and DBT.movable then
			if self.obj.enlarged then
				largeBarsAnchor:StartMoving()
			else
				smallBarsAnchor:StartMoving()
			end
		end
	end

	local function onMouseUp(self, btn)
		if self.obj then
			smallBarsAnchor:StopMovingOrSizing()
			largeBarsAnchor:StopMovingOrSizing()
			DBT:SavePosition()
			if btn == "RightButton" then
				self.obj:Cancel()
			elseif btn == "LeftButton" and IsShiftKeyDown() then
				self.obj:Announce()
			end
		end
	end

	local function onHide(self)
		smallBarsAnchor:StopMovingOrSizing()
		largeBarsAnchor:StopMovingOrSizing()
	end

	local fCounter = 1

	local function createBarFrame(self)
		local frame = CreateFrame("Frame", "DBT_Bar_" .. fCounter, smallBarsAnchor)
		frame:SetSize(195, 20)
		frame:SetScript("OnUpdate", onUpdate)
		frame:SetScript("OnMouseDown", onMouseDown)
		frame:SetScript("OnMouseUp", onMouseUp)
		frame:SetScript("OnHide", onHide)
		local bar = CreateFrame("StatusBar", "$parentBar", frame)
		bar:SetPoint("CENTER", frame, "CENTER")
		bar:SetSize(195, 20)
		bar:SetMinMaxValues(0, 1)
		bar:SetStatusBarTexture(self.Options.Texture)
		bar:SetStatusBarColor(1, 0.7, 0)
		local background = bar:CreateTexture(nil, "BACKGROUND")
		background:SetAllPoints()
		background:SetColorTexture(0, 0, 0, 0.3)
		local spark = bar:CreateTexture("$parentSpark", "OVERLAY")
		spark:SetPoint("CENTER", bar, "CENTER")
		spark:SetSize(32, 64)
		spark:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\Spark.blp")
		spark:SetBlendMode("ADD")
		local timer = bar:CreateFontString("$parentTimer", "OVERLAY", "GameFontHighlightSmall")
		timer:SetPoint("RIGHT", bar, "RIGHT", -1, 0.5)
		local name = bar:CreateFontString("$parentName", "OVERLAY", "GameFontHighlightSmall")
		name:SetPoint("LEFT", bar, "LEFT", 7, 0.5)
		name:SetPoint("RIGHT", timer, "LEFT", -7, 0)
		name:SetWordWrap(false)
		name:SetJustifyH("LEFT")
		local icon1 = bar:CreateTexture("$parentIcon1", "OVERLAY")
		icon1:SetPoint("RIGHT", bar, "LEFT")
		icon1:SetSize(20, 20)
		local icon2 = bar:CreateTexture("$parentIcon2", "OVERLAY")
		icon2:SetPoint("LEFT", bar, "RIGHT")
		icon2:SetSize(20, 20)

		fCounter = fCounter + 1

		frame:EnableMouse(not self.Options.ClickThrough or self.movable)
		return frame
	end

	local mt = {__index = barPrototype}

	function DBT:CreateBar(timer, id, icon, huge, small, color, isDummy, colorType, inlineIcon, keep, fade, countdown, countdownMax)
		if (not timer or type(timer) == "string" or timer <= 0) or (self.numBars >= 15 and not isDummy) then
			return
		end
		-- Most efficient place to block it, nil colorType instead of checking option every update
		if not self.Options.ColorByType then
			colorType = nil
		end
		local newBar = self:GetBar(id)
		if newBar then -- Update an existing bar
			newBar.lastUpdate = GetTime()
			newBar.huge = huge or nil
			newBar.paused = nil
			newBar:SetTimer(timer) -- This can kill the timer and the timer methods don't like dead timers
			if newBar.dead then
				return
			end
			newBar:SetElapsed(0)
			if newBar.dead then
				return
			end
			newBar:ApplyStyle()
			newBar:SetText(id)
			newBar:SetIcon(icon)
		else -- Create a new bar
			newBar = next(unusedBarObjects)
			if newBar then
				newBar.lastUpdate = GetTime()
				unusedBarObjects[newBar] = nil
				newBar.dead = nil -- Resurrected it :)
				newBar.id = id
				newBar.timer = timer
				newBar.totalTime = timer
				newBar.moving = nil
				newBar.enlarged = nil
				newBar.fadingIn = 0
				newBar.small = small
				newBar.color = color
				newBar.colorType = colorType
				newBar.flashing = nil
				newBar.inlineIcon = inlineIcon
				newBar.keep = keep
				newBar.fade = fade
				newBar.countdown = countdown
				newBar.countdownMax = countdownMax
			else -- Duplicate code ;(
				local newFrame = createBarFrame(self)
				newBar = setmetatable({
					frame = newFrame,
					id = id,
					timer = timer,
					totalTime = timer,
					owner = self,
					moving = nil,
					enlarged = nil,
					fadingIn = 0,
					small = small,
					color = color,
					flashing = nil,
					colorType = colorType,
					inlineIcon = inlineIcon,
					keep = keep,
					fade = fade,
					countdown = countdown,
					countdownMax = countdownMax,
					lastUpdate = GetTime()
				}, mt)
				newFrame.obj = newBar
			end
			self.numBars = self.numBars + 1
			if ((colorType and colorType == 7 and self.Options.Bar7ForceLarge) or (timer <= (self.Options.EnlargeBarTime or 11) or huge)) and self.Options.HugeBarsEnabled then -- Start enlarged
				newBar.enlarged = true
				newBar.huge = true
				tinsert(largeBars, newBar)
			else
				newBar.huge = nil
				tinsert(smallBars, newBar)
			end
			newBar:SetText(id)
			newBar:SetIcon(icon)
			self.bars[newBar] = true
			self:UpdateBars(true)
			newBar:ApplyStyle()
			newBar:Update(0)
		end
		return newBar
	end
end

do
	function DBT:LoadOptions(id)
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not DBT_AllPersistentOptions[DBM_UsedProfile] then
			DBT_AllPersistentOptions[DBM_UsedProfile] = {}
		end
		DBT_AllPersistentOptions[DBM_UsedProfile][id] = DBT_AllPersistentOptions[DBM_UsedProfile][id] or {}
		self:AddDefaultOptions(DBT_AllPersistentOptions[DBM_UsedProfile][id], self.DefaultOptions)
		self.Options = DBT_AllPersistentOptions[DBM_UsedProfile][id]
		self:Rearrange()
		-- Fix font if it's nil or set to any of standard font values
		if not self.Options.Font or (self.Options.Font == "Fonts\\2002.TTF" or self.Options.Font == "Fonts\\ARKai_T.ttf" or self.Options.Font == "Fonts\\blei00d.TTF" or self.Options.Font == "Fonts\\FRIZQT___CYR.TTF" or self.Options.Font == "Fonts\\FRIZQT__.TTF") then
			self.Options.Font = self.DefaultOptions.Font
		end
		-- Migrate texture from default skin to internal
		if self.Options.Texture == "Interface\\AddOns\\DBM-DefaultSkin\\textures\\default.blp" then
			self.Options.Texture = self.DefaultOptions.Texture
		end
		-- Migrate sort
		if self.Options.Sort == true then
			self.Options.Sort = "Sort"
		end
	end

	function DBT:CreateProfile(id)
		if not id or id == "" or id:find(" ") then
			self:AddMsg(DBM_CORE_L.PROFILE_CREATE_ERROR)
			return
		end
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		if not DBT_AllPersistentOptions[DBM_UsedProfile] then
			DBT_AllPersistentOptions[DBM_UsedProfile] = {}
		end
		if DBT_AllPersistentOptions[DBM_UsedProfile][id] then
			DBM:AddMsg(DBM_CORE_L.PROFILE_CREATE_ERROR_D:format(id))
			return
		end
		DBT_AllPersistentOptions[DBM_UsedProfile][id] = DBT_AllPersistentOptions[DBM_UsedProfile][id] or {}
		self:AddDefaultOptions(DBT_AllPersistentOptions[DBM_UsedProfile][id], self.DefaultOptions)
		self.Options = DBT_AllPersistentOptions[DBM_UsedProfile][id]
		self:Rearrange()
		DBM:AddMsg(DBM_CORE_L.PROFILE_CREATED:format(id))
	end

	function DBT:ApplyProfile(id, hasPrinted)
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not id or not DBT_AllPersistentOptions[DBM_UsedProfile] or not DBT_AllPersistentOptions[DBM_UsedProfile][id] then
			DBM:AddMsg(DBM_CORE_L.PROFILE_APPLY_ERROR:format(id or DBM_CORE_L.UNKNOWN))
			return
		end
		self:AddDefaultOptions(DBT_AllPersistentOptions[DBM_UsedProfile][id], self.DefaultOptions)
		self.Options = DBT_AllPersistentOptions[DBM_UsedProfile][id]
		self:Rearrange()
		if not hasPrinted then
			DBM:AddMsg(DBM_CORE_L.PROFILE_APPLIED:format(id))
		end
	end

	function DBT:CopyProfile(name, id, hasPrinted)
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not hasPrinted then
			if not name or not DBT_AllPersistentOptions[name] then
				DBM:AddMsg(DBM_CORE_L.PROFILE_COPY_ERROR:format(name or DBM_CORE_L.UNKNOWN))
				return
			elseif name == DBM_UsedProfile then
				DBM:AddMsg(DBM_CORE_L.PROFILE_COPY_ERROR_SELF)
				return
			end
		end
		if not DBT_AllPersistentOptions[DBM_UsedProfile] then
			DBT_AllPersistentOptions[DBM_UsedProfile] = {}
		end
		if not DBT_AllPersistentOptions[name] then
			DBT_AllPersistentOptions[name] = {}
		end
		DBT_AllPersistentOptions[DBM_UsedProfile][id] = DBT_AllPersistentOptions[name][id] or {}
		self:AddDefaultOptions(DBT_AllPersistentOptions[DBM_UsedProfile][id], self.DefaultOptions)
		self.Options = DBT_AllPersistentOptions[DBM_UsedProfile][id]
		self:Rearrange()
		if not hasPrinted then
			DBM:AddMsg(DBM_CORE_L.PROFILE_COPIED:format(name))
		end
	end

	function DBT:DeleteProfile(name, id)
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		if name == "Default" or not DBT_AllPersistentOptions[name] then
			return
		end
		DBT_AllPersistentOptions[name] = nil
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		self.Options = DBT_AllPersistentOptions[DBM_UsedProfile][id]
		self:Rearrange()
	end

	function DBT:Rearrange()
		smallBarsAnchor:ClearAllPoints()
		largeBarsAnchor:ClearAllPoints()
		smallBarsAnchor:SetPoint(self.Options.TimerPoint, UIParent, self.Options.TimerPoint, self.Options.TimerX, self.Options.TimerY)
		largeBarsAnchor:SetPoint(self.Options.HugeTimerPoint, UIParent, self.Options.HugeTimerPoint, self.Options.HugeTimerX, self.Options.HugeTimerY)
		self:ApplyStyle()
	end
end

do
	local oldInfoFrameLocked, oldRangeFrameLocked

	local function updateClickThrough(self, newValue)
		if not self.movable then
			for bar in self:GetBarIterator() do
				if not bar.dummy then
					bar.frame:EnableMouse(not newValue)
				end
			end
		end
	end

	local function moveEnd(self)
		updateClickThrough(self, self.Options.ClickThrough)
		self.movable = false
		DBM.Options.InfoFrameLocked = oldInfoFrameLocked
		DBM.InfoFrame:Hide()
		DBM.Options.RangeFrameLocked = oldRangeFrameLocked
		DBM.RangeCheck:Hide(true)
	end

	function DBT:ShowMovableBar(small, large)
		if small or small == nil then
			self:CreateBar(20, "Move1", 136116, nil, true):SetText(DBM_CORE_L.MOVABLE_BAR)
		end
		if large or large == nil then
			self:CreateBar(20, "Move2", 136116, true):SetText(DBM_CORE_L.MOVABLE_BAR)
		end
		updateClickThrough(self, false)
		self.movable = true
		DBM:Unschedule(moveEnd, self)
		DBM:Schedule(20, moveEnd, self)
		oldInfoFrameLocked = DBM.Options.InfoFrameLocked
		DBM.Options.InfoFrameLocked = false
		DBM.InfoFrame:Show(5, "test")
		oldRangeFrameLocked = DBM.Options.RangeFrameLocked
		DBM.Options.RangeFrameLocked = false
		DBM.RangeCheck:Show(nil, nil, true)
	end

	function DBT:SetOption(option, value, noUpdate)
		if option == "ExpandUpwards" or option == "ExpandUpwardsLarge" or option == "BarYOffset" or option == "BarXOffset" or option == "HugeBarYOffset" or option == "HugeBarXOffset" then
			for bar in self:GetBarIterator() do
				if not bar.dummy then
					if bar.moving == "enlarge" then
						bar.enlarged = true
						bar.moving = nil
						tinsert(largeBars, bar)
					else
						bar.moving = nil
					end
				end
			end
		elseif option == "ClickThrough" then
			updateClickThrough(self, value)
		end
		self.Options[option] = value
		if not noUpdate then
			self:UpdateBars(true)
			self:ApplyStyle()
		end
	end
end

do
	local dummyBars = 0
	local function dummyCancel(self)
		self.timer = self.totalTime
		self.flashing = nil
		self:Update(0)
		self.flashing = nil
		_G[self.frame:GetName() .. "BarSpark"]:SetAlpha(1)
	end

	function DBT:CreateDummyBar(colorType, inlineIcon, text)
		dummyBars = dummyBars + 1
		local dummy = self:CreateBar(25, "dummy" .. dummyBars, 136116, nil, true, nil, true, colorType, inlineIcon) -- "Interface\\Icons\\Spell_Nature_WispSplode"
		dummy:SetText(text or "Dummy", inlineIcon)
		dummy:Cancel()
		self.bars[dummy] = true
		unusedBarObjects[dummy] = nil
		dummy.frame:SetParent(UIParent)
		dummy.frame:ClearAllPoints()
		dummy.frame:SetScript("OnUpdate", nil)
		dummy.Cancel = dummyCancel
		dummy:ApplyStyle()
		dummy.dummy = true
		return dummy
	end
end

function DBT:GetBarIterator()
	if not self.bars then
		DBM:Debug("GetBarIterator failed for unknown reasons")
		return
	end
	return pairs(self.bars)
end

function DBT:GetBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			return bar
		end
	end
end

function DBT:CancelBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar.paused = nil
			bar:Cancel()
			return true
		end
	end
	return false
end

function DBT:UpdateBar(id, elapsed, totalTime)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar:SetTimer(totalTime or bar.totalTime)
			bar:SetElapsed(elapsed or self.totalTime - self.timer)
			return true
		end
	end
	return false
end

function DBT:SetAnnounceHook(f)
	self.announceHook = f
end

function DBT:UpdateBars(sortBars)
	if sortBars and self.Options.Sort ~= "None" then
		tsort(largeBars, function(x, y)
			if self.Options.HugeSort == "Invert" then
				return x.timer < y.timer
			end
			return x.timer > y.timer
		end)
		tsort(smallBars, function(x, y)
			if self.Options.Sort == "Invert" then
				return x.timer < y.timer
			end
			return x.timer > y.timer
		end)
	end
	for i, bar in ipairs(largeBars) do
		bar.frame:ClearAllPoints()
		bar.frame:SetPoint("TOP", largeBarsAnchor, "TOP", (i - 1) * self.Options.HugeBarXOffset, ((i - 1) * (self.Options.HugeHeight + self.Options.HugeBarYOffset)) * (self.Options.ExpandUpwardsLarge and 1 or -1))
	end
	for i, bar in ipairs(smallBars) do
		bar.frame:ClearAllPoints()
		bar.frame:SetPoint("TOP", smallBarsAnchor, "TOP", (i - 1) * self.Options.BarXOffset, ((i - 1) * (self.Options.Height + self.Options.BarYOffset)) * (self.Options.ExpandUpwards and 1 or -1))
	end
end

function DBT:ApplyStyle()
	for bar in self:GetBarIterator() do
		bar:ApplyStyle()
	end
end

function DBT:SavePosition()
	local point, _, _, x, y = smallBarsAnchor:GetPoint(1)
	self:SetOption("TimerPoint", point)
	self:SetOption("TimerX", x)
	self:SetOption("TimerY", y)
	point, _, _, x, y = largeBarsAnchor:GetPoint(1)
	self:SetOption("HugeTimerPoint", point)
	self:SetOption("HugeTimerX", x)
	self:SetOption("HugeTimerY", y)
end

function DBT:ShowTestBars()
	self:CreateBar(10, "Test 1", 136116) -- "Interface\\Icons\\Spell_Nature_WispSplode"
	self:CreateBar(14, "Test 2", 136116)
	self:CreateBar(20, "Test 3", 136116)
	self:CreateBar(12, "Test 4", 136116)
	self:CreateBar(21.5, "Test 5", 136116)
end

function barPrototype:SetTimer(timer)
	self.totalTime = timer
	self:Update(0)
end

function barPrototype:ResetAnimations(makeBig)
	self:RemoveFromList()
	self.moving = nil
	if DBT.Options.HugeBarsEnabled and makeBig then
		self.enlarged = true
		tinsert(largeBars, self)
	else
		self.enlarged = nil
		tinsert(smallBars, self)
	end
	self:ApplyStyle()
end

function barPrototype:Pause()
	self.flashing = nil
	self.ftimer = nil
	self:Update(0)
	self.paused = true
	self:ResetAnimations() -- Forces paused bar into small bars so they don't clutter huge bars anchor
	DBT:UpdateBars(true)
end

function barPrototype:Resume()
	self.paused = nil
	DBT:UpdateBars(true)
end

function barPrototype:SetElapsed(elapsed)
	self.timer = self.totalTime - elapsed
	local enlargeTime = DBT.Options.EnlargeBarTime or 11
	-- Bar was large, or moving (animating from the small to large bar anchor) at time this was called
	-- Force reset animation and move it back to the small anchor since time was added to bar
	if (self.enlarged or self.moving == "enlarge") and self.timer > enlargeTime then
		self:ResetAnimations()
	-- Bar was small, or moving from small to large when time was removed
	-- Also force reset animation but this time move it from small anchor into large one
	elseif (not self.enlarged or self.moving == "enlarge") and self.timer <= enlargeTime then
		self:ResetAnimations(true)
	end
	self:Update(0)
	DBT:UpdateBars(true)
end

function barPrototype:SetText(text, inlineIcon)
	if not DBT.Options.InlineIcons then
		inlineIcon = nil
	end
	-- Force change color type 7 to custom inlineIcon
	_G[self.frame:GetName().."BarName"]:SetText(((self.colorType and self.colorType == 7 and DBT.Options.Bar7CustomInline) and DBM_CORE_L.IMPORTANT_ICON or inlineIcon or "") .. text)
end

function barPrototype:SetIcon(icon)
	local frame_name = self.frame:GetName()
	_G[frame_name.."BarIcon1"]:SetTexture(icon)
	_G[frame_name.."BarIcon2"]:SetTexture(icon)
end

function barPrototype:SetColor(color)
	-- Fix to allow colors not require the table keys
	if color[1] and not color.r then
		color = {
			r = color[1],
			g = color[2],
			b = color[3]
		}
	end
	self.color = color
	local frame_name = self.frame:GetName()
	_G[frame_name .. "Bar"]:SetStatusBarColor(color.r, color.g, color.b)
	_G[frame_name .. "BarSpark"]:SetVertexColor(color.r, color.g, color.b)
end

local colorVariables = {
	[1] = "A",--Add
	[2] = "AE",--AoE
	[3] = "D",--Debuff/Targeted attack
	[4] = "I",--Interrupt
	[5] = "R",--Role
	[6] = "P",--Phase
	[7] = "UI",--User
}

local function stringFromTimer(t)
	if t <= DBT.Options.TDecimal then
		return ("%.1f"):format(t)
	elseif t <= 60 then
		return ("%d"):format(t)
	else
		return ("%d:%0.2d"):format(t / 60, math.fmod(t, 60))
	end
end

function barPrototype:Update(elapsed)
	local frame = self.frame
	local frame_name = frame:GetName()
	local bar = _G[frame_name .. "Bar"]
	local spark = _G[frame_name .. "BarSpark"]
	local timer = _G[frame_name .. "BarTimer"]
	local paused = self.paused
	self.timer = self.timer - (paused and 0 or elapsed)
	local timerValue = self.timer
	local totaltimeValue = self.totalTime
	local barOptions = DBT.Options
	local currentStyle = barOptions.BarStyle
	local sparkEnabled = barOptions.Spark
	local isMoving = self.moving
	local isFadingIn = self.fadingIn
	local colorCount = self.colorType
	local enlargeHack = self.dummyEnlarge or colorCount == 7 and barOptions.Bar7ForceLarge
	local enlargeTime = barOptions.EnlargeBarTime or 11
	local isEnlarged = self.enlarged and not paused
	local fillUpBars = isEnlarged and barOptions.FillUpLargeBars or not isEnlarged and barOptions.FillUpBars
	local ExpandUpwards = isEnlarged and barOptions.ExpandUpwardsLarge or not isEnlarged and barOptions.ExpandUpwards
	if barOptions.DynamicColor and not self.color then
		local r, g, b
		if colorCount and colorCount >= 1 then
			local colorVar = colorVariables[colorCount]
			if barOptions.NoBarFade then
				r = isEnlarged and barOptions["EndColor"..colorVar.."R"] or barOptions["StartColor"..colorVar.."R"]
				g = isEnlarged and barOptions["EndColor"..colorVar.."G"] or barOptions["StartColor"..colorVar.."G"]
				b = isEnlarged and barOptions["EndColor"..colorVar.."B"] or barOptions["StartColor"..colorVar.."B"]
			else
				r = barOptions["StartColor"..colorVar.."R"] + (barOptions["EndColor"..colorVar.."R"] - barOptions["StartColor"..colorVar.."R"]) * (1 - timerValue/totaltimeValue)
				g = barOptions["StartColor"..colorVar.."G"] + (barOptions["EndColor"..colorVar.."G"] - barOptions["StartColor"..colorVar.."G"]) * (1 - timerValue/totaltimeValue)
				b = barOptions["StartColor"..colorVar.."B"] + (barOptions["EndColor"..colorVar.."B"] - barOptions["StartColor"..colorVar.."B"]) * (1 - timerValue/totaltimeValue)
			end
		else
			if barOptions.NoBarFade then
				r = isEnlarged and barOptions.EndColorR or barOptions.StartColorR
				g = isEnlarged and barOptions.EndColorG or barOptions.StartColorG
				b = isEnlarged and barOptions.EndColorB or barOptions.StartColorB
			else
				r = barOptions.StartColorR + (barOptions.EndColorR - barOptions.StartColorR) * (1 - timerValue/totaltimeValue)
				g = barOptions.StartColorG + (barOptions.EndColorG - barOptions.StartColorG) * (1 - timerValue/totaltimeValue)
				b = barOptions.StartColorB + (barOptions.EndColorB - barOptions.StartColorB) * (1 - timerValue/totaltimeValue)
			end
		end
		bar:SetStatusBarColor(r, g, b)
		if sparkEnabled then
			spark:SetVertexColor(r, g, b)
		end
	end
	if timerValue <= 0 and not (barOptions.KeepBars and self.keep) then
		return self:Cancel()
	else
		if fillUpBars then
			if currentStyle == "NoAnim" and isEnlarged and not enlargeHack then
				-- Simple/NoAnim Bar mimics BW in creating a new bar on large bar anchor instead of just moving the small bar
				bar:SetValue(1 - timerValue/(totaltimeValue < enlargeTime and totaltimeValue or enlargeTime))
			else
				bar:SetValue(1 - timerValue/totaltimeValue)
			end
		else
			if currentStyle == "NoAnim" and isEnlarged and not enlargeHack then
				-- Simple/NoAnim Bar mimics BW in creating a new bar on large bar anchor instead of just moving the small bar
				bar:SetValue(timerValue/(totaltimeValue < enlargeTime and totaltimeValue or enlargeTime))
			else
				bar:SetValue(timerValue/totaltimeValue)
			end
		end
		timer:SetText(stringFromTimer(timerValue))
	end
	if isFadingIn and isFadingIn < 0.5 and currentStyle ~= "NoAnim" then
		self.fadingIn = isFadingIn + elapsed
		if (isEnlarged and barOptions.HugeAlpha == 1) or barOptions.Alpha == 1 then -- Only fade in if alpha is 1, otherwise we already have a faded bar
			frame:SetAlpha((isFadingIn) / 0.5)
		end
	elseif isFadingIn then
		self.fadingIn = nil
	end
	if timerValue <= 7.75 and not self.flashing and barOptions.FlashBar and not paused then
		self.flashing = true
		self.ftimer = 0
	elseif self.flashing and timerValue > 7.75 then
		self.flashing = nil
		self.ftimer = nil
	end
	if sparkEnabled then
		spark:ClearAllPoints()
		spark:SetSize(12, barOptions[isEnlarged and 'HugeHeight' or 'Height'] * 3)
		spark:SetPoint("CENTER", bar, "LEFT", bar:GetValue() * bar:GetWidth(), -1)
	else
		spark:SetAlpha(0)
	end
	if self.flashing then
		local r, g, b = bar:GetStatusBarColor()
		local ftime = self.ftimer % 1.25
		if ftime >= 0.5 then
			bar:SetStatusBarColor(r, g, b, 1)
			if sparkEnabled then
				spark:SetAlpha(1)
			end
		elseif ftime >= 0.25 then
			bar:SetStatusBarColor(r, g, b, 1 - (0.5 - ftime) / 0.25)
			if sparkEnabled then
				spark:SetAlpha(1 - (0.5 - ftime) / 0.25)
			end
		else
			bar:SetStatusBarColor(r, g, b, 1 - (ftime / 0.25))
			if sparkEnabled then
				spark:SetAlpha(1 - (ftime / 0.25))
			end
		end
		self.ftimer = self.ftimer + elapsed
	end
	local melapsed = self.moveElapsed
	if isMoving == "move" and melapsed <= 0.5 then
		barIsAnimating = true
		self.moveElapsed = melapsed + elapsed
		local newX = self.moveOffsetX + (barOptions[isEnlarged and "HugeBarXOffset" or "BarXOffset"] - self.moveOffsetX) * (melapsed / 0.5)
		local newY
		if ExpandUpwards then
			newY = self.moveOffsetY + (barOptions[isEnlarged and "HugeBarYOffset" or "BarYOffset"] - self.moveOffsetY) * (melapsed / 0.5)
		else
			newY = self.moveOffsetY + (-barOptions[isEnlarged and "HugeBarYOffset" or "BarYOffset"] - self.moveOffsetY) * (melapsed / 0.5)
		end
		frame:ClearAllPoints()
		frame:SetPoint(self.movePoint, self.moveAnchor, self.movePoint, newX, newY)
	elseif isMoving == "move" then
		barIsAnimating = false
		self.moving = nil
		isMoving = nil
	elseif isMoving == "enlarge" and melapsed <= 1 then
		barIsAnimating = true
		self:AnimateEnlarge(elapsed)
	elseif isMoving == "enlarge" then
		barIsAnimating = false
		self.moving = nil
		isMoving = nil
		self.enlarged = true
		isEnlarged = true
		tinsert(largeBars, self)
		self:ApplyStyle()
		DBT:UpdateBars(true)
	elseif isMoving == "nextEnlarge" then
		barIsAnimating = false
		self.moving = nil
		isMoving = nil
		self.enlarged = true
		isEnlarged = true
		tinsert(largeBars, self)
		self:ApplyStyle()
		DBT:UpdateBars(true)
	end
	if not paused and (timerValue <= enlargeTime) and not self.small and not isEnlarged and isMoving ~= "enlarge" and DBT.Options.HugeBarsEnabled then
		self:RemoveFromList()
		self:Enlarge()
	end
	DBT:UpdateBars()
end

function barPrototype:RemoveFromList()
	if self.moving ~= "enlarge" then
		tDeleteItem(self.enlarged and largeBars or smallBars, self)
	end
end

function barPrototype:Cancel()
	self.frame:Hide()
	self:RemoveFromList()
	DBT.bars[self] = nil
	unusedBarObjects[self] = self
	self.dead = true
	DBT.numBars = DBT.numBars - 1
end

function barPrototype:ApplyStyle()
	local frame = self.frame
	local frame_name = frame:GetName()
	local bar = _G[frame_name.."Bar"]
	local spark = _G[frame_name.."BarSpark"]
	local icon1 = _G[frame_name.."BarIcon1"]
	local icon2 = _G[frame_name.."BarIcon2"]
	local name = _G[frame_name.."BarName"]
	local timer = _G[frame_name.."BarTimer"]
	local barOptions = DBT.Options
	local sparkEnabled = barOptions.Spark
	local enlarged = self.enlarged
	if self.color then
		local barRed, barGreen, barBlue = self.color.r, self.color.g, self.color.b
		bar:SetStatusBarColor(barRed, barGreen, barBlue)
		if sparkEnabled then
			spark:SetVertexColor(barRed, barGreen, barBlue)
		end
	else
		local barStartRed, barStartGreen, barStartBlue
		if self.colorType then
			local colorCount = self.colorType
			if colorCount == 1 then--Add
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorAR, barOptions.StartColorAG, barOptions.StartColorAB
			elseif colorCount == 2 then--AOE
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorAER, barOptions.StartColorAEG, barOptions.StartColorAEB
			elseif colorCount == 3 then--Debuff
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorDR, barOptions.StartColorDG, barOptions.StartColorDB
			elseif colorCount == 4 then--Interrupt
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorIR, barOptions.StartColorIG, barOptions.StartColorIB
			elseif colorCount == 5 then--Role
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorRR, barOptions.StartColorRG, barOptions.StartColorRB
			elseif colorCount == 6 then--Phase
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorPR, barOptions.StartColorPG, barOptions.StartColorPB
			elseif colorCount == 7 then--Important
				barStartRed, barStartGreen, barStartBlue = barOptions.StartColorUIR, barOptions.StartColorUIG, barOptions.StartColorUIB
			end
		else
			barStartRed, barStartGreen, barStartBlue = barOptions.StartColorR, barOptions.StartColorG, barOptions.StartColorB
		end
		bar:SetStatusBarColor(barStartRed, barStartGreen, barStartBlue)
		if sparkEnabled then
			spark:SetVertexColor(barStartRed, barStartGreen, barStartBlue)
		end
	end
	local barTextColorRed, barTextColorGreen, barTextColorBlue = barOptions.TextColorR, barOptions.TextColorG, barOptions.TextColorB
	local barHeight, barHugeHeight, barWidth, barHugeWidth = barOptions.Height, barOptions.HugeHeight, barOptions.Width, barOptions.HugeWidth
	name:SetTextColor(barTextColorRed, barTextColorGreen, barTextColorBlue)
	timer:SetTextColor(barTextColorRed, barTextColorGreen, barTextColorBlue)
	if barOptions.IconLeft then icon1:Show() else icon1:Hide() end
	if barOptions.IconRight then icon2:Show() else icon2:Hide() end
	if enlarged then
		bar:SetSize(barHugeWidth, barHugeHeight)
		frame:SetScale(barOptions.HugeScale)
		if barOptions.FadeBars and self.fade then
			frame:SetAlpha(barOptions.HugeAlpha / 2)
		else
			frame:SetAlpha(barOptions.HugeAlpha)
		end
	else
		bar:SetSize(barWidth, barHeight)
		frame:SetScale(barOptions.Scale)
		if barOptions.FadeBars and self.fade and barOptions.Alpha ~= 0 then
			frame:SetAlpha(barOptions.Alpha / 2)
		else
			frame:SetAlpha(barOptions.Alpha)
		end
	end
	if barOptions.IconLocked then
		local sizeHeight = enlarged and barHugeHeight or barHeight
		frame:SetSize(enlarged and barHugeWidth or barWidth, sizeHeight)
		icon1:SetSize(sizeHeight, sizeHeight)
		icon2:SetSize(sizeHeight, sizeHeight)
	end
	self.frame:Show()
	if sparkEnabled then
		spark:SetAlpha(1)
	end
	local r, g, b = bar:GetStatusBarColor()
	bar:SetStatusBarColor(r, g, b, 1)
	local barFont = barOptions.Font == "standardFont" and standardFont or barOptions.Font
	local barFontSize, barFontFlag = barOptions.FontSize, barOptions.FontFlag
	name:SetFont(barFont, barFontSize, barFontFlag)
	name:SetPoint("LEFT", bar, "LEFT", 3, 0)
	timer:SetFont(barFont, barFontSize, barFontFlag)
	self:Update(0)
end

do
	local tostring, mfloor = tostring, math.floor
	local ChatEdit_GetActiveWindow, SendChatMessage, IsInGroup, IsInRaid = ChatEdit_GetActiveWindow, SendChatMessage, IsInGroup, IsInRaid

	function barPrototype:Announce()
		local msg
		if DBT.announceHook then
			msg = DBT.announceHook(self)
		end
		msg = msg or ("%s %d:%02d"):format(tostring(_G[self.frame:GetName().."BarName"]:GetText()):gsub("|T.-|t", ""), mfloor(self.timer / 60), self.timer % 60)
		local chatWindow = ChatEdit_GetActiveWindow()
		if chatWindow then
			chatWindow:Insert(msg)
		else
			SendChatMessage(msg, (IsInGroup(2) and "INSTANCE_CHAT") or (IsInRaid() and "RAID") or "PARTY")
		end
	end
end

function barPrototype:MoveToNextPosition()
	if self.moving == "enlarge" or not self.frame then
		return
	end
	local newAnchor = self.enlarged and largeBarsAnchor or smallBarsAnchor
	local oldX = self.frame:GetRight() - self.frame:GetWidth()/2
	local oldY = self.frame:GetTop()
	local Enlarged = self.enlarged
	local ExpandUpwards = Enlarged and DBT.Options.ExpandUpwardsLarge or not Enlarged and DBT.Options.ExpandUpwards
	self.frame:ClearAllPoints()
	if ExpandUpwards then
		self.movePoint = "BOTTOM"
		self.frame:SetPoint("BOTTOM", newAnchor, "BOTTOM", DBT.Options[Enlarged and "HugeBarXOffset" or "BarXOffset"], DBT.Options[Enlarged and "HugeBarYOffset" or "BarYOffset"])
	else
		self.movePoint = "TOP"
		self.frame:SetPoint("TOP", newAnchor, "TOP", DBT.Options[Enlarged and "HugeBarXOffset" or "BarXOffset"], -DBT.Options[Enlarged and "HugeBarYOffset" or "BarYOffset"])
	end
	local newX = self.frame:GetRight() - self.frame:GetWidth()/2
	local newY = self.frame:GetTop()
	if DBT.Options.BarStyle ~= "NoAnim" then
		self.frame:ClearAllPoints()
		self.frame:SetPoint(self.movePoint, newAnchor, self.moveRelPoint, -(newX - oldX), -(newY - oldY))
		self.moving = "move"
	end
	self.moveAnchor = newAnchor
	self.moveOffsetX = -(newX - oldX)
	self.moveOffsetY = -(newY - oldY)
	self.moveElapsed = 0
end

function barPrototype:Enlarge()
	local oldX = self.frame:GetRight() - self.frame:GetWidth()/2
	local oldY = self.frame:GetTop()
	local Enlarged = self.enlarged
	local ExpandUpwards = Enlarged and DBT.Options.ExpandUpwardsLarge or not Enlarged and DBT.Options.ExpandUpwards
	self.frame:ClearAllPoints()
	if ExpandUpwards then
		self.movePoint = "BOTTOM"
		self.frame:SetPoint("BOTTOM", largeBarsAnchor, "BOTTOM", DBT.Options[Enlarged and "HugeBarXOffset" or "BarXOffset"], DBT.Options[Enlarged and "HugeBarYOffset" or "BarYOffset"])
	else
		self.movePoint = "TOP"
		self.frame:SetPoint("TOP", largeBarsAnchor, "TOP", DBT.Options[Enlarged and "HugeBarXOffset" or "BarXOffset"], -DBT.Options[Enlarged and "HugeBarYOffset" or "BarYOffset"])
	end
	local newX = self.frame:GetRight() - self.frame:GetWidth()/2
	local newY = self.frame:GetTop()
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOP", largeBarsAnchor, "BOTTOM", -(newX - oldX), -(newY - oldY))
	self.moving = DBT.Options.BarStyle == "NoAnim" and "nextEnlarge" or "enlarge"
	self.moveAnchor = largeBarsAnchor
	self.moveOffsetX = -(newX - oldX)
	self.moveOffsetY = -(newY - oldY)
	self.moveElapsed = 0
end

function barPrototype:AnimateEnlarge(elapsed)
	self.moveElapsed = self.moveElapsed + elapsed
	local melapsed = self.moveElapsed
	if melapsed < 1 then
		local calc = melapsed / 1
		local newX = self.moveOffsetX + (DBT.Options.HugeBarXOffset - self.moveOffsetX) * calc
		local newY = self.moveOffsetY + (DBT.Options.HugeBarYOffset - self.moveOffsetY) * calc
		local newWidth = DBT.Options.HugeWidth + (DBT.Options.Width - DBT.Options.HugeWidth) * calc
		local newHeight = DBT.Options.HugeHeight + (DBT.Options.Height - DBT.Options.HugeHeight) * calc
		local newScale = DBT.Options.HugeScale + (DBT.Options.Scale - DBT.Options.HugeScale) * calc
		self.frame:ClearAllPoints()
		self.frame:SetPoint(self.movePoint, self.moveAnchor, self.movePoint, newX, newY)
		self.frame:SetScale(newScale)
		self.frame:SetSize(newWidth, newHeight)
		_G[self.frame:GetName().."Bar"]:SetWidth(newWidth)
	else
		self.moving = nil
		self.enlarged = true
		tinsert(largeBars, self)
		DBT:UpdateBars(true)
		self:ApplyStyle()
	end
end

do
	local skins = {}

	local skin = {}
	skin.__index = skin

	function DBT:RegisterSkin(id)
		if id == "DefaultSkin" then
			DBM:AddMsg("DBM-DefaultSkin no longer used, please remove")
			DBM:AddMsg("DBM-DefaultSkin no longer used, please remove")
			DBM:AddMsg("DBM-DefaultSkin no longer used, please remove")
			return {}
		end
		if skins[id] then
			error("Skin '" .. id .. "' is already registered.", 2)
		end
		local obj = setmetatable({
			name		= id,
			Defaults	= {},
			Options		= {}
		}, skin)
		skins[id] = obj
		return obj
	end

	function DBT:SetSkin(id)
		local skin = skins[id]
		if not skin then
			error("Skin '" .. id .. "' doesn't exist", 2)
		end
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		if not DBT_AllPersistentOptions[DBM_UsedProfile] then
			DBT_AllPersistentOptions[DBM_UsedProfile] = {}
		end
		if not DBT_AllPersistentOptions[DBM_UsedProfile][id] then
			DBT_AllPersistentOptions[DBM_UsedProfile][id] = DBT_AllPersistentOptions[DBM_UsedProfile].DBM or {}
			for option, value in pairs(skin.Defaults) do
				DBT_AllPersistentOptions[DBM_UsedProfile][id][option] = value
			end
		end
		self:ApplyProfile(id, true)
		for option, value in pairs(skin.Options) do
			self:SetOption(option, value, true)
		end
		self:SetOption("Skin", id) -- Forces an UpdateBars and ApplyStyle
	end

	function DBT:ResetSkin()
		local DBM_UsedProfile = DBM_UsedProfile or "Default"
		if not DBT_AllPersistentOptions then
			DBT_AllPersistentOptions = {}
		end
		if not DBT_AllPersistentOptions[DBM_UsedProfile] then
			DBT_AllPersistentOptions[DBM_UsedProfile] = {}
		end
		DBT_AllPersistentOptions[DBM_UsedProfile]["DBM"] = self.DefaultOptions
		self.Options = self.DefaultOptions
		self:SetOption("Skin", "") -- Forces an UpdateBars and ApplyStyle
	end

	function DBT:GetSkins()
		return skins
	end
end
