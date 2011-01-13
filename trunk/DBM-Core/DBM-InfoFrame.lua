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
--    * koKR: BlueNyx					bluenyx@gmail.com
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
--    * to Share — to copy, distribute, display, and perform the work
--    * to Remix — to make derivative works
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
DBM.InfoFrame = {}

--------------
--  Locals  --
--------------
local infoFrame = DBM.InfoFrame
local frame
local createFrame
local onUpdate
local dropdownFrame
local initializeDropdown
local maxlines
local infoFrameThreshold 
local extraOptions
local headerText = "DBM Info Frame"	-- this is only used if DBM.InfoFrame:SetHeader(text) is not called before :Show()
local currentEvent
local sortingAsc
local lines = {}
local sortedLines = {}


-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------
--  Dropdown Menu  --
---------------------

-- todo: this dropdown menu is somewhat ugly and unflexible....
do
	
	local function toggleLocked()
		DBM.Options.InfoFrameLocked = not DBM.Options.InfoFrameLocked
	end
	
	function initializeDropdown(dropdownFrame, level, menu)
		local info
		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_INFOFRAME_LOCK
			if DBM.Options.InfoFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)			

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_INFOFRAME_HIDE
			info.notCheckable = true
			info.func = infoFrame.Hide
			info.arg1 = infoFrame
			UIDropDownMenu_AddButton(info, 1)
		end
	end
end


------------------------
--  Create the frame  --
------------------------
function createFrame()
	local elapsed = 0
	local frame = CreateFrame("GameTooltip", "DBMInfoFrame", UIParent, "GameTooltipTemplate")
	dropdownFrame = CreateFrame("Frame", "DBMInfoFrameDropdown", frame, "UIDropDownMenuTemplate")
	frame:SetFrameStrata("DIALOG")
	frame:SetPoint(DBM.Options.InfoFramePoint, UIParent, DBM.Options.InfoFramePoint, DBM.Options.InfoFrameX, DBM.Options.InfoFrameY)
	frame:SetHeight(maxlines*12)
	frame:SetWidth(64)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable()
	GameTooltip_OnLoad(frame)
	frame:SetPadding(16)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		if not DBM.Options.InfoFrameLocked then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		ValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.InfoFrameX = x
		DBM.Options.InfoFrameY = y
		DBM.Options.InfoFramePoint = point
	end)
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.5 then
			onUpdate(self, elapsed)
			elapsed = 0
		end
	end)
	frame:SetScript("OnEvent", function(self, event, ...)
		if infoFrame[event] then
			infoFrame[event](self, ...)
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


------------------------
--  Update functions  --
------------------------
local function sortFuncDesc(a, b) return lines[a] > lines[b] end
local function sortFuncAsc(a, b) return lines[a] < lines[b] end
local function updateLines()
	table.wipe(sortedLines)
	for i in pairs(lines) do
		sortedLines[#sortedLines + 1] = i
	end
	if sortingAsc then
		table.sort(sortedLines, sortFuncAsc)
	else
		table.sort(sortedLines, sortFuncDesc)
	end
end

local function updateHealth()
	table.wipe(lines)
	for i = 1, GetNumRaidMembers() do
		if UnitHealth("raid"..i) < infoFrameThreshold then
			lines["raid"..i] = UnitHealth("raid"..i) - infoFrameThreshold 
		end
	end
	updateLines()
end

function infoFrame:UNIT_POWER(uId, powerType)
	if powerType == select(1, extraOptions) and UnitInRaid(uId) then
		local power = UnitPower(uId, select(2, extraOptions))
		local powerMax = UnitPowerMax(uId, select(2, extraOptions))
		if power < 0 or infoFrameThreshold and power/powerMax*100 < infoFrameThreshold then
			lines[uId] = nil
		else
			lines[uId] = power
		end
		updateLines()
	end
end


----------------
--  OnUpdate  --
----------------
function onUpdate(self, elapsed)
	self:ClearLines()
	if headerText then
		self:AddLine(headerText, 255, 255, 255, 0)
	end
	if currentEvent == "health" then
		updateHealth()
	end
	for i = 1, #sortedLines do
		if self:NumLines() > maxlines then break end
		local uId = sortedLines[i]
		local power = lines[uId]
		local nameColor = RAID_CLASS_COLORS[select(2, uId)] or NORMAL_FONT_COLOR
		self:AddDoubleLine(UnitName(uId), power, nameColor.R, nameColor.G, nameColor.B, 255, 255, 255)	-- (leftText, rightText, left.R, left.G, left.B, right.R, right.G, right.B)
													-- Add a method to color the power value?
	end
		
	self:Show()
end


---------------
--  Methods  --
---------------
function infoFrame:Show(maxLines, event, threshold, ...)
	if type(maxLines) ~= "number" then
		return self:Show(5, maxLines, event, ...)
	end

	infoFrameThreshold = threshold
	maxlines = maxLines or 5	-- default 5 lines
	extraOptions = ...
	currentEvent = event
	frame = frame or createFrame()

	if event == "health" then
		sortingAsc = true	-- Person who misses the most HP to be at threshold is listed on top
		updateHealth()
	else
		frame:RegisterEvent(event)
	end
	
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame, 0)
end

function infoFrame:Hide()
	if frame then 
		table.wipe(lines)
		table.wipe(sortedLines)
		headerText = nil
		sortingAsc = false
		infoFrameThreshold = nil
		frame:Hide()
		if currentEvent ~= "health" then
			frame:UnregisterEvent(currentEvent)
		end
		currentEvent = nil
	end
end

function infoFrame:IsShown()
	return frame and frame:IsShown()
end

function infoFrame:SetHeader(text)
	if not text then return end
	headerText = text
end

function infoFrame:SetSorting(ascending)
	sortingAsc = ascending
end