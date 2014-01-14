-- ***************************************************
-- **             DBM Range Check Frame             **
-- **         http://www.deadlybossmods.com         **
-- ***************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://wow.gamespot.com.cn
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: BlueNyx/nBlueWiz			bluenyx@gmail.com / everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share ?to copy, distribute, display, and perform the work
--    * to Remix ?to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--
-- This file makes use of the following free (Creative Commons Sampling Plus 1.0) sounds:
--    * alarmclockbeeps.ogg by tedthetrumpet (http://www.freesound.org/usersViewSingle.php?id=177)
--    * blip_8.ogg by Corsica_S (http://www.freesound.org/usersViewSingle.php?id=7037)
--  The full of text of the license can be found in the file "Sounds\Creative Commons Sampling Plus 1.0.txt".

---------------
--  Globals  --
---------------
DBM.RangeCheck = {}

--------------
--  Locals  --
--------------
local rangeCheck = DBM.RangeCheck
local mainFrame = CreateFrame("Frame")
local updater
local textFrame
local createTextFrame
local radarFrame
local createRadarFrame
local updateIcon
local updateRangeFrame
local dropdownFrame
local initializeDropdown
local activeRange = 0
local dots = {}
local dims

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local GetPlayerMapPosition = GetPlayerMapPosition
local GetPlayerFacing = GetPlayerFacing
local UnitName, UnitClass, UnitIsUnit, UnitIsDeadOrGhost, UnitAffectingCombat = UnitName, UnitClass, UnitIsUnit, UnitIsDeadOrGhost, UnitAffectingCombat
local GetNumGroupMembers, GetNumSubgroupMembers = GetNumGroupMembers, GetNumSubgroupMembers
local GetCurrentMapDungeonLevel = GetCurrentMapDungeonLevel
local GetRaidTargetIndex = GetRaidTargetIndex
local GetTime = GetTime
local max, sin, cos, pi = math.max, math.sin, math.cos, math.pi

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local BLIP_TEX_COORDS = {
	["WARRIOR"]	= { 0,	   0.125, 0,    0.25 },
	["PALADIN"]	= { 0.125, 0.25,  0,    0.25 },
	["HUNTER"]	= { 0.25,  0.375, 0,    0.25 },
	["ROGUE"]	= { 0.375, 0.5,   0,    0.25 },
	["PRIEST"]	= { 0.5,   0.625, 0,    0.25 },
	["DEATHKNIGHT"]	= { 0.625, 0.75,  0,    0.25 },
	["SHAMAN"]	= { 0.75,  0.875, 0,    0.25 },
	["MAGE"]	= { 0.875, 1,     0,    0.25 },
	["WARLOCK"]	= { 0,     0.125, 0.25, 0.5  },
	["DRUID"]	= { 0.25,  0.375, 0.25, 0.5  },
	["MONK"]	= { 0.125, 0.25, 0.25, 0.5 }
}
---------------------
--  Dropdown Menu  --
---------------------

-- todo: this dropdown menu is somewhat ugly and unflexible....
do
	local sound0 = "none"
	local sound1 = "Interface\\AddOns\\DBM-Core\\Sounds\\blip_8.ogg"
	local sound2 = "Interface\\AddOns\\DBM-Core\\Sounds\\alarmclockbeeps.ogg"
	local function setSound(self, option, sound)
		DBM.Options[option] = sound
		if sound ~= "none" then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(sound, "Master")
			else
				PlaySoundFile(sound)
			end
		end
	end

	local function setRange(self, range)
		rangeCheck:Hide()
		rangeCheck:Show(range, mainFrame.filter)
	end

	local function setFrames(self, option)
		DBM.Options.RangeFrameFrames = option
		rangeCheck:Hide()
		rangeCheck:Show(mainFrame.range, mainFrame.filter)
	end

	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	function initializeDropdown(dropdownFrame, level, menu)
		local info
		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "frames"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = LOCK_FRAME
			if DBM.Options.RangeFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = HIDE
			info.notCheckable = true
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)

		elseif level == 2 then
			if menu == "range" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(6)
				info.func = setRange
				info.arg1 = 6
				info.checked = (mainFrame.range == 6)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(8)
				info.func = setRange
				info.arg1 = 8
				info.checked = (mainFrame.range == 8)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(10)
				info.func = setRange
				info.arg1 = 10
				info.checked = (mainFrame.range == 10)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(11)
				info.func = setRange
				info.arg1 = 11
				info.checked = (mainFrame.range == 11)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(12)
				info.func = setRange
				info.arg1 = 12
				info.checked = (mainFrame.range == 12)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(15)
				info.func = setRange
				info.arg1 = 15
				info.checked = (mainFrame.range == 15)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(20)
				info.func = setRange
				info.arg1 = 20
				info.checked = (mainFrame.range == 20)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(28)
				info.func = setRange
				info.arg1 = 28
				info.checked = (mainFrame.range == 28)
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "sounds" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_1
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound1"
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_2
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound2"
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "frames" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_TEXT
				info.func = setFrames
				info.arg1 = "text"
				info.checked = (DBM.Options.RangeFrameFrames == "text")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_RADAR
				info.func = setFrames
				info.arg1 = "radar"
				info.checked = (DBM.Options.RangeFrameFrames == "radar")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_BOTH
				info.func = setFrames
				info.arg1 = "both"
				info.checked = (DBM.Options.RangeFrameFrames == "both")
				UIDropDownMenu_AddButton(info, 2)
			end
		elseif level == 3 then
			local option = menu
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_0
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound0
			info.checked = (DBM.Options[option] == sound0)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_1
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound1
			info.checked = (DBM.Options[option] == sound1)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_2
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound2
			info.checked = (DBM.Options[option] == sound2)
			UIDropDownMenu_AddButton(info, 3)
		end
	end
end

-----------------
-- Play Sounds --
-----------------
local soundUpdate = 0
local function updateSound(num)
	if not UnitAffectingCombat("player") or (GetTime() - soundUpdate) < 5 then return end
	soundUpdate = GetTime()
	if num == 1 then
		if DBM.Options.RangeFrameSound1 ~= "none" then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(DBM.Options.RangeFrameSound1, "Master")
			else
				PlaySoundFile(DBM.Options.RangeFrameSound1)
			end
		end
	elseif num > 1 then
		if DBM.Options.RangeFrameSound2 ~= "none" then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(DBM.Options.RangeFrameSound2, "Master")
			else
				PlaySoundFile(DBM.Options.RangeFrameSound2)
			end
		end
	end
end

------------------------
--  Create the frame  --
------------------------
function createTextFrame()
	local elapsed = 0
	local textFrame = CreateFrame("GameTooltip", "DBMRangeCheck", UIParent, "GameTooltipTemplate")
	dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", textFrame, "UIDropDownMenuTemplate")
	textFrame:SetFrameStrata("DIALOG")
	textFrame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	textFrame:SetHeight(64)
	textFrame:SetWidth(64)
	textFrame:EnableMouse(true)
	textFrame:SetToplevel(true)
	textFrame:SetMovable()
	GameTooltip_OnLoad(textFrame)
	textFrame:SetPadding(16)
	textFrame:RegisterForDrag("LeftButton")
	textFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	textFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	textFrame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return textFrame
end

function createRadarFrame()
	local radarFrame = CreateFrame("Frame", "DBMRangeCheckRadar", UIParent)
	radarFrame:SetFrameStrata("DIALOG")
	radarFrame:SetPoint(DBM.Options.RangeFrameRadarPoint, UIParent, DBM.Options.RangeFrameRadarPoint, DBM.Options.RangeFrameRadarX, DBM.Options.RangeFrameRadarY)
	radarFrame:SetHeight(128)
	radarFrame:SetWidth(128)
	radarFrame:EnableMouse(true)
	radarFrame:SetToplevel(true)
	radarFrame:SetMovable()
	radarFrame:RegisterForDrag("LeftButton")
	radarFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	radarFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameRadarX = x
		DBM.Options.RangeFrameRadarY = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local bg = radarFrame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(radarFrame)
	bg:SetBlendMode("BLEND")
	bg:SetTexture(0, 0, 0, 0.3)
	radarFrame.background = bg

	local circle = radarFrame:CreateTexture(nil, "ARTWORK")
	circle:SetSize(85, 85)
	circle:SetPoint("CENTER")
	circle:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\radar_circle.blp")
	circle:SetVertexColor(0, 1, 0)
	circle:SetBlendMode("ADD")
	radarFrame.circle = circle

	local player = radarFrame:CreateTexture(nil, "OVERLAY")
	player:SetSize(32, 32)
	player:SetTexture("Interface\\Minimap\\MinimapArrow.blp")
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	local text = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	text:SetWidth(128)
	text:SetHeight(15)
	text:SetPoint("BOTTOMLEFT", radarFrame, "TOPLEFT", 0,0)
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	radarFrame.text = text

	local inRangeText = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	inRangeText:SetWidth(128)
	inRangeText:SetHeight(15)
	inRangeText:SetPoint("TOPLEFT", radarFrame, "BOTTOMLEFT", 0,0)
	inRangeText:SetTextColor(1, 1, 1, 1)
	inRangeText:Hide()
	radarFrame.inRangeText = inRangeText

	for i = 1, 40 do
		local dot = radarFrame:CreateTexture(nil, "OVERLAY")
		dot:SetSize(24, 24)
		dot:SetTexture("Interface\\Minimap\\PartyRaidBlips")
		dot:Hide()
		dots[i] = dot
	end

	radarFrame:Hide()
	return radarFrame
end

----------------
--  OnUpdate  --
----------------
do
	local rotation, pixelsperyard, activeDots, numPlayers, circleColor, prevRange, prevNumClosePlayer, prevColor = 0, 0, 0, 0, 0, 0, 0, 0
	local unitList = {}

	local function setDot(id)
		local dot = dots[id]
		local x = dots[id].x
		local y = dots[id].y
		local range = dots[id].range
		if range < (activeRange * 1.5) then -- if person is closer than 1.5 * range, show the dot. Else hide it
			local dx = ((x * cos(rotation)) - (-y * sin(rotation))) * pixelsperyard -- Rotate the X,Y based on player facing
			local dy = ((x * sin(rotation)) + (-y * cos(rotation))) * pixelsperyard
			dot:ClearAllPoints()
			dot:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
			if not dot.isShown then
				dot.isShown = true
				dot:Show()
			end
		elseif dot.isShown then
			dot.isShown = nil
			dot:Hide()
		end
	end

	function updateIcon()
		numPlayers = GetNumGroupMembers()
		activeDots = max(numPlayers, activeDots)
		for i = 1, activeDots do
			local dot = dots[i]
			if i <= numPlayers then
				unitList[i] = IsInRaid() and "raid"..i or "party"..i
				local uId = unitList[i]
				local _, class = UnitClass(uId)
				local icon = GetRaidTargetIndex(uId)
				dot.class = class
				if icon then
					dot.icon = icon
					dot:SetTexture(format("Interface\\TargetingFrame\\UI-RaidTargetingIcon_%d", icon))
					dot:SetTexCoord(0, 1, 0, 1)
					dot:SetSize(16, 16)
					dot:SetDrawLayer("OVERLAY", 1)
				else
					dot.icon = nil
					class = class or "PRIEST"
					local c = RAID_CLASS_COLORS[class]
					dot:SetTexture("Interface\\Minimap\\PartyRaidBlips")
					dot:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
					dot:SetSize(24, 24)
					dot:SetDrawLayer("OVERLAY", 0)
				end
			elseif dot.isShown then
				dot.isShown = nil
				dot:Hide()
			end
		end
	end

	function updateRangeFrame()
		activeRange = mainFrame.range
		local tEnabled = textFrame.isShown
		local rEnabled = radarFrame.isShown
		if tEnabled then
			textFrame:ClearLines()
			textFrame:SetText(DBM_CORE_RANGECHECK_HEADER:format(activeRange), 1, 1, 1)
		end
		if rEnabled and prevRange ~= activeRange then
			prevRange = activeRange
			pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (activeRange * 3)
			radarFrame.circle:SetSize(activeRange * pixelsperyard * 2, activeRange * pixelsperyard * 2)
			radarFrame.text:SetText(DBM_CORE_RANGERADAR_HEADER:format(activeRange))
		end

		dims = dims or DBM:GetMapSizes()

		local playerX, playerY = GetPlayerMapPosition("player")
		if playerX == 0 and playerY == 0 then return end -- Somehow we can't get the correct position?

		rotation = (2 * pi) - GetPlayerFacing()
		local closePlayer = 0
		for i = 1, numPlayers do
			local uId = unitList[i]
			local dot = dots[i]
			local filter = mainFrame.filter
			if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and (not filter or filter(uId)) then
				local x, y = GetPlayerMapPosition(uId)
				local cx = (x - playerX) * dims[1]
				local cy = (y - playerY) * dims[2]
				local range = (cx * cx + cy * cy) ^ 0.5
				local inRange = false
				if range < (activeRange * 1.1) then-- add 10% because of map data inaccuracies
					closePlayer = closePlayer + 1
					inRange = true
				end
				if tEnabled and inRange and closePlayer < 6 then-- display up to 5 players in text range frame.
					local playerName = UnitName(uId)
					local color = RAID_CLASS_COLORS[dot.class] or NORMAL_FONT_COLOR
					local icon = dot.icon
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, playerName) or playerName
					textFrame:AddLine(text, color.r, color.g, color.b)
				end
				if rEnabled then
					dot.x = cx
					dot.y = cy
					dot.range = range
					setDot(i)
				end
			elseif rEnabled and dot.isShown then
				dot.isShown = nil
				dot:Hide()
			end
		end

		local warnThreshold = mainFrame.redCircleNumPlayers
		if tEnabled then
			textFrame:Show()
		end
		if rEnabled then
			if prevNumClosePlayer ~= closePlayer then
				radarFrame.inRangeText:SetText(DBM_CORE_RANGERADAR_IN_RANGE_TEXT:format(closePlayer))
				if closePlayer >= warnThreshold then -- only show the text if the circle is red
					circleColor = 2
					radarFrame.inRangeText:Show()
				else
					circleColor = 1
					radarFrame.inRangeText:Hide()
				end
				prevNumClosePlayer = closePlayer
			end

			if UnitIsDeadOrGhost("player") then
				circleColor = 3
			end

			if prevColor ~= circleColor then
				if circleColor == 1 then
					radarFrame.circle:SetVertexColor(0, 1, 0)
				elseif circleColor == 2 then
					radarFrame.circle:SetVertexColor(1, 0, 0)
				else
					radarFrame.circle:SetVertexColor(1, 1, 1)
				end
				prevColor = circleColor
			end
		end

		if closePlayer >= warnThreshold then
			updateSound(closePlayer)
		end
	end
end

updater = mainFrame:CreateAnimationGroup()
updater:SetLooping("REPEAT")
local anim = updater:CreateAnimation()
anim:SetDuration(0.05)

mainFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" or event == "RAID_TARGET_UPDATE" then
		updateIcon()
	elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
		dims = nil
		DBM:UpdateMapSizes()
	end
end)

-----------------------
--  Check functions  --
-----------------------
local getDistanceBetween
do
	function getDistanceBetween(uId, x, y)
		-- alternative arguments: uId, uId2
		if type(x) == "string" then
			x, y = GetPlayerMapPosition(x)
		end
		local startX, startY = GetPlayerMapPosition(uId)
		local dims = DBM:GetMapSizes()
		if not dims then return end
		local dX = (startX - x) * dims[1]
		local dY = (startY - y) * dims[2]
		return (dX * dX + dY * dY) ^ 0.5
	end

	local function mapRangeCheck(uId, range)
		return getDistanceBetween(uId, GetPlayerMapPosition("player")) < range
	end
end

---------------
--  Methods  --
---------------
function rangeCheck:Show(range, filter, forceshow, redCircleNumPlayers)
	if DBM.Options.DontShowRangeFrame and not forceshow then return end
	DBM:UpdateMapSizes()--Force a mapsize update after SetMapToCurrentZone to ensure our information is current
	if type(range) == "function" then -- the first argument is optional
		return self:Show(nil, range)
	end
	range = range or 10
	redCircleNumPlayers = redCircleNumPlayers or 1
	textFrame = textFrame or createTextFrame()
	radarFrame = radarFrame or createRadarFrame()
	if DBM.Options.RangeFrameFrames == "text" or DBM.Options.RangeFrameFrames == "both" then
		textFrame.isShown = true
		textFrame:Show()
		textFrame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	if DBM.Options.RangeFrameFrames == "radar" or DBM.Options.RangeFrameFrames == "both" then
		radarFrame.isShown = true
		radarFrame:Show()
	end
	mainFrame.range = range
	mainFrame.filter = filter
	mainFrame.redCircleNumPlayers = redCircleNumPlayers
	if not mainFrame.eventRegistered then
		mainFrame.eventRegistered = true
		updateIcon()
		mainFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
		mainFrame:RegisterEvent("RAID_TARGET_UPDATE")
		mainFrame:RegisterEvent("ZONE_CHANGED")
		mainFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
		mainFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	end
	updater:SetScript("OnLoop", updateRangeFrame)
	updater:Play()
end

function rangeCheck:Hide()
	updater:Stop()
	activeRange = 0
	if mainFrame.eventRegistered then
		mainFrame.eventRegistered = nil
		mainFrame:UnregisterAllEvents()
	end
	if textFrame then
		textFrame.isShown = nil
		textFrame:Hide()
	end
	if radarFrame then
		radarFrame.isShown = nil
		radarFrame:Hide() 
	end
end

function rangeCheck:IsShown()
	return textFrame and textFrame.isShown or radarFrame and radarFrame.isShown
end

-- GetDistance(uId) -- distance between you and the given uId
-- GetDistance(uId, x, y) -- distance between uId and the coordinates
-- GetDistance(uId, uId2) -- distance between the two uIds
function rangeCheck:GetDistance(...)
	return getDistanceBetween(...)
end
