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


------------------------
--  Create the frame  --
------------------------
function createFrame()
	local frame = CreateFrame("GameTooltip", "DBMRangeCheck", UIParent, "GameTooltipTemplate")
	local elapsed = 0
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("CENTER", 100, -40)
	frame:SetHeight(64)
	frame:SetWidth(128)
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
	end)
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.5 and self.checkFunc then
			onUpdate(self)
		end
	end)
	return frame
end


----------------
--  OnUpdate  --
----------------
function onUpdate(self)
	local color
	local i = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(range))
	for i = 1, GetNumRaidMembers() do
		if self.checkFunc("raid"..i) then
			i = i + 1
			color = RAID_CLASS_COLORS[select(2, UnitClass("raid"..i))] or NORMAL_FONT_COLOR
			self:AddLine(UnitName("raid"..i), color.r, color.g, color.b)
			if i >= 5 then break end
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
	local bandages = {21991, 34721, 38643, 34722} -- 38640 <-- Dense Frostweave Bandage (removed from the game?)
	
	checkFuncs[15] = function(uId)
		for i, v in ipairs(bandages) do
			if IsItemInRange(v, uId) == 1 then -- you should have one of these bandages in your cache
				return true
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
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame)
end

function rangeCheck:Hide()
	frame:Hide()
end














