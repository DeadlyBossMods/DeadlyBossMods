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
local checkFuncs = {}
local frame
local createFrame
local radarFrame
local createRadarFrame
local onUpdate
local onUpdateRadar
local dropdownFrame
local initializeDropdown
local initRangeCheck -- initializes the range check for a specific range (if necessary), returns false if the initialization failed (because of a map range check in an unknown zone)
local positions = {}

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local BLIP_TEX_COORDS = {
	["WARRIOR"]	= { 0, 0.125, 0, 0.25 },
	["PALADIN"]	= { 0.125, 0.25, 0, 0.25 },
	["HUNTER"]	= { 0.25, 0.375, 0, 0.25 },
	["ROGUE"]	= { 0.375, 0.5, 0, 0.25 },
	["PRIEST"]	= { 0.5, 0.625, 0, 0.25 },
	["DEATHKNIGHT"]	= { 0.625, 0.75, 0, 0.25 },
	["SHAMAN"]	= { 0.75, 0.875, 0, 0.25 },
	["MAGE"]	= { 0.875, 1, 0, 0.25 },
	["WARLOCK"]	= { 0, 0.125, 0.25, 0.5 },
	["DRUID"]	= { 0.25, 0.375, 0.25, 0.5 }
}

---------------------
--  Dropdown Menu  --
---------------------

-- todo: this dropdown menu is somewhat ugly and unflexible....
do
	local function setRange(self, range)
		rangeCheck:Show(range)
	end
	
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
	
	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	local function toggleRadar()
		DBM.Options.RangeFrameRadar = not DBM.Options.RangeFrameRadar
		if DBM.Options.RangeFrameRadar then
			radarFrame = radarFrame or createRadarFrame()
			radarFrame:Show()
		else
			radarFrame:Hide()
		end
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
			info.text = DBM_CORE_RANGECHECK_LOCK
			if DBM.Options.RangeFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)
			
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_RADAR
			if DBM.Options.RangeFrameRadar then
				info.checked = true
			end
			info.func = toggleRadar
			UIDropDownMenu_AddButton(info, 1)
			
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_HIDE
			info.notCheckable = true
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)

		elseif level == 2 then
			if menu == "range" then
				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(5)
					info.func = setRange
					info.arg1 = 5
					info.checked = (frame.range == 5)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(6)
					info.func = setRange
					info.arg1 = 6
					info.checked = (frame.range == 6)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(8)
					info.func = setRange
					info.arg1 = 8
					info.checked = (frame.range == 8)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(10)
				info.func = setRange
				info.arg1 = 10
				info.checked = (frame.range == 10)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(11)
				info.func = setRange
				info.arg1 = 11
				info.checked = (frame.range == 11)
				UIDropDownMenu_AddButton(info, 2)

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(12)
					info.func = setRange
					info.arg1 = 12
					info.checked = (frame.range == 12)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(15)
				info.func = setRange
				info.arg1 = 15
				info.checked = (frame.range == 15)
				UIDropDownMenu_AddButton(info, 2)

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(20)
					info.func = setRange
					info.arg1 = 20
					info.checked = (frame.range == 20)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(28)
				info.func = setRange
				info.arg1 = 28
				info.checked = (frame.range == 28)
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
local function updateSound(numPlayers) -- called every 5 seconds
	if not UnitAffectingCombat("player") then
		return
	end
	if numPlayers == 1 then
		if DBM.Options.RangeFrameSound1 ~= "none" then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(DBM.Options.RangeFrameSound1, "Master")
			else
				PlaySoundFile(DBM.Options.RangeFrameSound1)
			end
		end
	elseif numPlayers > 1 then
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
function createFrame()
	local elapsed = 0
	local frame = CreateFrame("GameTooltip", "DBMRangeCheck", UIParent, "GameTooltipTemplate")
	dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", frame, "UIDropDownMenuTemplate")
	frame:SetFrameStrata("DIALOG")
	frame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable()
	GameTooltip_OnLoad(frame)
	frame:SetPadding(16)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.5 and self.checkFunc then
			onUpdate(self, elapsed)
			elapsed = 0
		end
	end)
	frame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return frame
end

function createRadarFrame()
	if not DBM.Options.RangeFrameRadar then return end
	local elapsed = 0
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
		DBM.Options.RangeFrameYRadar = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.1 then
			onUpdateRadar(self, elapsed)
			elapsed = 0
		end
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
	circle:SetPoint("CENTER")
	circle:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\radar_circle.blp")
	circle:SetBlendMode("ADD")
	radarFrame.circle = circle

	local player = radarFrame:CreateTexture(nil, "OVERLAY")
	player:SetSize(32, 32)
	player:SetTexture("Interface\\Minimap\\MinimapArrow.blp")
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	radarFrame:Show()
	return radarFrame
end

----------------
--  OnUpdate  --
----------------

function onUpdate(self, elapsed)
print("hi")
end

local soundUpdate = 0
function onUpdate(self, elapsed)
	local color
	local j = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(self.range), 1, 1, 1)
	if initRangeCheck(self.range) then
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				local uId = "raid"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end	
			end
		elseif GetNumPartyMembers() > 0 then
			for i = 1, GetNumPartyMembers() do
				local uId = "party"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end	
			end
		end
	else
		self:AddLine(DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED:format(self.range))
	end
	soundUpdate = soundUpdate + elapsed
	if soundUpdate >= 5 and j > 0 then
		updateSound(j)
		soundUpdate = 0
	end
	self:Show()
end

do
	local rotation, pixelsperyard, playerTooClose
	local function createDot(name)
		local class = positions[name].class
		local dot = CreateFrame("Frame", "DBMRangeCheckRadarDot"..name, radarFrame, "WorldMapPartyUnitTemplate")
		dot:SetFrameStrata("TOOLTIP")
		dot:SetWidth(24)
		dot:SetHeight(24)
		dot.icon:SetTexCoord(
			BLIP_TEX_COORDS[class][1],
			BLIP_TEX_COORDS[class][2],
			BLIP_TEX_COORDS[class][3],
			BLIP_TEX_COORDS[class][4]
		)

		positions[name].dot = dot	-- store the dot so we can use it later again
		return dot
	end

	local function setDot(name)
		local dot = positions[name].dot or createDot(name)		-- load the dot, or create a new one if none exists yet
		local x = positions[name].x
		local y = positions[name].y
		local range = (x*x + y*y) ^ 0.5

		if range < (1.5 * frame.range) then							-- if person is closer than 1.5 * range, show the dot. Else hide it
			local dx = ((x * math.cos(rotation)) - (-1 * y * math.sin(rotation))) * pixelsperyard		-- Rotate the X,Y based on player facing
			local dy = ((x * math.sin(rotation)) + (-1 * y * math.cos(rotation))) * pixelsperyard

			dot:ClearAllPoints()
			dot:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
			dot:Show()
		else
			dot:Hide()
		end
		if range < 1.05 * frame.range then		-- add an extra 5% in case of inaccuracy
			positions[name].tooClose = true
		else
			positions[name].tooClose = false
		end			
	end

	local function createTestDots()
		positions["arta"] = {class="PRIEST",x=10.6,y=0}
		positions["omega"] = {class="WARRIOR",x=0,y=-15}
		positions["jack"] = {class="HUNTER",x=-5,y=11}
		positions["gerard"] = {class="MAGE",x=5.3,y=-9.8}
		positions["simon"] = {class="DRUID",x=12,y=6}
		positions["steven"] = {class="DEATHKNIGHT",x=-19,y=3}
	end
	local function showTestDots()
		if not positions["arta"] then createTestDots() end
		setDot("arta") setDot("omega") setDot("jack") setDot("gerard") setDot("simon") setDot("steven")
	end

	function onUpdateRadar(self, elapsed)
		if not DBM.Options.RangeFrameRadar then return end
		pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (frame.range * 3)
		rotation = (2 * math.pi) - GetPlayerFacing()
		radarFrame.circle:SetSize(frame.range * pixelsperyard * 2, frame.range * pixelsperyard * 2)

		local playerX, playerY = GetPlayerMapPosition("player")
		local mapName = GetMapInfo()
		local dims  = DBM.MapSizes[mapName] and DBM.MapSizes[mapName][GetCurrentMapDungeonLevel()]
		if not dims then return end
		local numPlayers = 0
		local unitID = "raid%d"
		if GetNumRaidMembers() > 0 then
			unitID = "raid%d"
			numPlayers = GetNumRaidMembers()
		elseif GetNumPartyMembers() > 0 then
			unitID = "party%d"
			numPlayers = GetNumPartyMembers()
		end
		for i=1, numPlayers do
			local uId = unitID:format(i)
			if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) then
				local x,y = GetPlayerMapPosition(uId)
				local name = UnitName(uId)
				if not positions[uId] then
					positions[uId] = {
						name = name,
						class = select(2, UnitClass(uId)),
						x = (x - playerX) * dims[1],
						y = (y - playerY) * dims[2]
					}
					setDot(uId)
				else
					if positions[uId].name ~= name then
						positions[uId].name = name
						positions[uId].class = select(2, UnitClass(uId))
					end
					local dx = positions[uId].x - ((x - playerX) * dims[1])
					local dy = positions[uId].y - ((y - playerY) * dims[2])
					if (dx*dx)^0.5 > 0.1 or (dy*dy)^0.5 > 0.1 then 	-- did person move? If not, we dont have to update the dot-						positions[name].x = (playerX - x) * dims[1]-						positions[name].y = (playerY - y) * dims[2]+						positions[name].x = (x - playerX) * dims[1]+						positions[name].y = (y - playerY) * dims[2]
						positions[uId].x = (x - playerX) * dims[1]
						positions[uId].y = (y - playerY) * dims[2]
						setDot(uId)
					end
				end
			end
		end

		local playerTooClose = false
		for i,v in pairs(positions) do
			if v.tooClose then
				playerTooClose = true
				break;
			end
		end
		if playerTooClose then
			radarFrame.circle:SetVertexColor(1,0,0)
		else
			radarFrame.circle:SetVertexColor(0,1,0)
		end
		self:Show()
	end
end


-----------------------
--  Check functions  --
-----------------------
checkFuncs[11] = function(uId)
	return CheckInteractDistance(uId, 2)
end


checkFuncs[10] = function(uId)
	return CheckInteractDistance(uId, 3)
end

checkFuncs[28] = function(uId)
	return CheckInteractDistance(uId, 4)
end


local getDistanceBetween
do
	local mapSizes = DBM.MapSizes
	
	function getDistanceBetween(uId, x, y)
		local startX, startY = GetPlayerMapPosition(uId)
		local mapName = GetMapInfo()
		local dims  = mapSizes[mapName] and mapSizes[mapName][GetCurrentMapDungeonLevel()]
		if not dims then
			return
		end
		local dX = (startX - x) * dims[1]
		local dY = (startY - y) * dims[2]
		return math.sqrt(dX * dX + dY * dY)
	end

	local function mapRangeCheck(uId, range)
		return getDistanceBetween(uId, GetPlayerMapPosition("player")) < range
	end
	
	function initRangeCheck(range)
		if checkFuncs[range] ~= mapRangeCheck then
			return true
		end
		local pX, pY = GetPlayerMapPosition("player")
		if pX == 0 and pY == 0 then
			SetMapToCurrentZone()
			pX, pY = GetPlayerMapPosition("player")
		end
		local levels = mapSizes[GetMapInfo()]
		if not levels then
			return false
		end
		local dims = levels[GetCurrentMapDungeonLevel()]
		if not dims and levels and GetCurrentMapDungeonLevel() == 0 then -- we are in a known zone but the dungeon level seems to be wrong
			SetMapToCurrentZone() -- fixes the dungeon level
			dims = levels[GetCurrentMapDungeonLevel()] -- try again
			if not dims then -- there is actually a level 0 in this zone but we don't know about it...too bad :(
				return false
			end
		elseif not dims then
			return false
		end
		return true -- everything ok!
	end
	
	setmetatable(checkFuncs, {
		__index = function(t, k)
			return mapRangeCheck
		end
	})
end

do
	local bandages = {21991, 34721, 34722, 53049, 53050, 53051}  -- you should have one of these bandages in your cache

	checkFuncs[15] = function(uId)
		for i, v in ipairs(bandages) do
			if IsItemInRange(v, uId) == 1 then
				return true
			elseif IsItemInRange(v, uId) == 0 then
				return false
			end
		end
	end
end


---------------
--  Methods  --
---------------
function rangeCheck:Show(range, filter)
	if type(range) == "function" then -- the first argument is optional
		return self:Show(nil, range)
	end
	
	range = range or 10
	frame = frame or createFrame()
	radarFrame = radarFrame or createRadarFrame()
	frame.checkFunc = checkFuncs[range] or error(("Range \"%d yd\" is not supported."):format(range), 2)
	frame.range = range
	frame.filter = filter
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame, 0)
	onUpdateRadar(radarFrame, 0)
end

function rangeCheck:Hide()
	if frame then frame:Hide() end
	if radarFrame then radarFrame:Hide() end
end

function rangeCheck:IsShown()
	return frame and frame:IsShown()
end

function rangeCheck:GetDistance(...)
	if initRangeCheck() then
		return getDistanceBetween(...)
	end
end