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
--    * enGB/enUS: Tandanu
--    * deDE: Tandanu/Nitram
--    * ruRU: BootWin
--    * zhTW: Azael/kc10577
--    * (add your names here!)
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
local threshold
local extraOptions
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
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
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
		if not DBM.Options.infoFrameLocked then
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


----------------
--  OnUpdate  --
----------------
function onUpdate(self, elapsed)
	self:ClearLines()
	self:AddLine("something", 55, 51, 105)
	local numLines = 0
	for i = 1, #sortedLines do
		if numLines >= maxlines then break end
		local name = sortedLines[i]
		local power = lines[name]
		local text = name..": "..power
		self:AddLine(text, 255, 255, 255)
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
	frame = frame or createFrame()

	if event == "health" then
		-- health check (check if everyone is above -threshold- HP) -> not implemented
	else
		frame:RegisterEvent(event)
	end
	
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame, 0)
end

function infoFrame:Hide()
	if frame then 
		frame:Hide() 
		table.wipe(lines)
		table.wipe(sortedLines)
	end
end

function infoFrame:IsShown()
	return frame and frame:IsShown()
end




------------------------
--  Update functions  --
------------------------
local function sortFunc(a, b) return lines[a] > lines[b] end
local function updateLines()
	table.wipe(sortedLines)
	for i in pairs(lines) do
		sortedLines[#sortedLines + 1] = i
	end
	table.sort(sortedLines, sortFunc)
end

function infoFrame:UNIT_POWER(uId, powerType)
	if powerType == select(1, extraOptions) then --and UnitInRaid(uId) then
		local name = UnitName(uId)
		local power = UnitPower(uId, select(2, extraOptions))
		if power < 0 then
			lines[name] = nil
		else
			lines[name] = power
		end
		updateLines()
	end
end
	