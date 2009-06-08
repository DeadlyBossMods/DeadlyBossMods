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
--    * Arta (DBM-Party)
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
local onUpdate
local dropdownFrame
local initialize

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------
--  Dropdown Menu  --
---------------------
do
	local function setRange(self, range)
		rangeCheck:Show(range)
	end
	function initialize(dropdownFrame, level)
		local info
		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			UIDropDownMenu_AddButton(info, 1)
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_HIDE
			info.notCheckable = true
			info.func = function() rangeCheck:Hide() end
			UIDropDownMenu_AddButton(info, 1)
		elseif level == 2 then
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
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(15)
			info.func = setRange
			info.arg1 = 15
			info.checked = (frame.range == 15)
			UIDropDownMenu_AddButton(info, 2)
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(28)
			info.func = setRange
			info.arg1 = 28
			info.checked = (frame.range == 28)
			UIDropDownMenu_AddButton(info, 2)
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
		self:StartMoving()
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
			onUpdate(self)
			elapsed = 0
		end
	end)
	frame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initialize, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return frame
end


----------------
--  OnUpdate  --
----------------
function onUpdate(self)
	local color
	local j = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(self.range or 10), 1, 1, 1)
	for i = 1, GetNumRaidMembers() do
		if (not UnitIsUnit("raid"..i, "player")) and (not UnitIsDeadOrGhost("raid"..i)) and self.checkFunc("raid"..i) then
			j = j + 1
			color = RAID_CLASS_COLORS[select(2, UnitClass("raid"..i))] or NORMAL_FONT_COLOR
			self:AddLine(UnitName("raid"..i), color.r, color.g, color.b)
			if j >= 5 then break end
		end
	end
	self:Show()
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

do
	local bandages = {21991, 34721, 38643, 34722}  -- you should have one of these bandages in your cache

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
function rangeCheck:Show(range)
	range = range or 10
	frame = frame or createFrame()
	frame.checkFunc = checkFuncs[range] or error(("Range \"%d yd\" is not supported."):format(range), 2)
	frame.range = range
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame)
end

function rangeCheck:Hide()
	if frame then frame:Hide() end
end

function rangeCheck:IsShown()
	return frame and frame:IsShown()
end
