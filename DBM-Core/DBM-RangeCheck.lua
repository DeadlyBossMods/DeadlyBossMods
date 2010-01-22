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
local onUpdate
local dropdownFrame
local initialize

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

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
			PlaySoundFile(sound)
		end
	end
	
	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end
	
	function initialize(dropdownFrame, level, menu)
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
			info.text = DBM_CORE_RANGECHECK_HIDE
			info.notCheckable = true
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)
		elseif level == 2 then
			if menu == "range" then
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
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(12)
				info.func = setRange
				info.arg1 = 12
				info.checked = (frame.range == 12)
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
			PlaySoundFile(DBM.Options.RangeFrameSound1)
		end
	elseif numPlayers > 1 then
		if DBM.Options.RangeFrameSound2 ~= "none" then
			PlaySoundFile(DBM.Options.RangeFrameSound2)
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
			UIDropDownMenu_Initialize(dropdownFrame, initialize, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return frame
end


----------------
--  OnUpdate  --
----------------
local soundUpdate = 0
function onUpdate(self, elapsed)
	local color
	local j = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(self.range or 10), 1, 1, 1)
	for i = 1, GetNumRaidMembers() do
		if (not UnitIsUnit("raid"..i, "player")) and (not UnitIsDeadOrGhost("raid"..i)) and self.checkFunc("raid"..i, self.range) then
			j = j + 1
			color = RAID_CLASS_COLORS[select(2, UnitClass("raid"..i))] or NORMAL_FONT_COLOR
			self:AddLine(UnitName("raid"..i), color.r, color.g, color.b)
			if j >= 5 then break end
		end
	end
	soundUpdate = soundUpdate + elapsed
	if soundUpdate >= 5 and j > 0 then
		updateSound(j)
		soundUpdate = 0
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
	-- the map size data is copied from Deus Vox Encounters (http://wow.curse.com/downloads/wow-addons/details/deus-vox-encounters.aspx)
	local mapDimensions = {
		Ulduar = {
			[1] = {3064.9614761023, 2039.5413309668},	-- Expedition Base Camp			-- CONFIRM
			[2] = {624.19069622949, 415.89374357805},	-- Antechamber of Ulduar		-- CONFIRM
			[3] = {1238.37427179,	823.90183235628},	-- Conservatory of Life			-- CONFIRM
			[4] = {848.38069183829, 564.6688835337},	-- Prison of Yogg-Saron			-- CONFIRM
			[5] = {1460.4694647684, 974.65312886234},	-- Spark of Imagination			-- CONFIRM
			[6] = {576.71549337896, 384.46653291368},	-- The Mind's Eye (Under Yogg)	-- CONFIRM
		},
		Naxxramas = {
			[1] = {1018.3655494957, 679.40523953718},	-- Construct	-- CONFIRM
			[2] = {1019.1310739251, 679.18864376555},	-- Arachnid		-- CONFIRM
			[3] = {1118.1083638787, 744.57895516418},	-- Military		-- CONFIRM
			[4] = {1117.0809918236, 745.97398439776},	-- Plague		-- CONFIRM
			[5] = {1927.3190541014, 1284.6530841959},	-- Entrance		-- CONFIRM
			[6] = {610.62737087301, 407.3875157986},	-- KT/Sapphiron	-- CONFIRM
		},
		TheObsidianSanctum = {
			[0] = {1081.6334214432, 721.79860069158},	-- CONFIRM
		},
		TheEyeofEternity = {
			[1] = {400.728405332355, 267.09113174487},	-- CONFIRM
		},
		TheArgentColiseum = {
			[1] = {344.20785972537, 229.57961178118},	-- CONFIRM
			[2] = {688.60679691348, 458.95801567569},	-- CONFIRM
		},
		VaultofArchavon = {
			[1] = {842.2254908359, 561.59878021123},	-- CONFIRM
		},
		IcecrownCitadel = {
			[1] = {1262.8025621533, 841.91669450207},	-- The Lower Citadel		-- CONFIRM
			[2] = {993.25701607873, 662.58829476644},	-- The Rampart of Skulls	-- CONFIRM
			[3] = {181.83564716405, 121.29684810833},	-- Deathbringer's Rise		-- CONFIRM
			[4] = {720.60965618252, 481.1621506613},	-- The Frost Queen's Lair	-- CONFIRM
			[5] = {1069.6156745738, 713.83371679543},	-- The Upper Reaches		-- CONFIRM
			[6] = {348.05218433541, 232.05964286208},	-- Royal Quarters			-- CONFIRM
		},
	}
   
	local function mapRangeCheck(uId, range)
		local pX, pY = GetPlayerMapPosition("player")
		if pX == 0 and pY == 0 then
			SetMapToCurrentZone()
			pX, pY = GetPlayerMapPosition("player")
		end
		local uX, uY = GetPlayerMapPosition(uId)
		local list = mapDimensions[GetMapInfo()]
		if not list then
			return
		end
		local dims = list[GetCurrentMapDungeonLevel()]
		if not dims and list and GetCurrentMapDungeonLevel() == 0 then -- we are in a known zone but the dungeon level seems to be wrong
			SetMapToCurrentZone() -- fixes the dungeon level
			dims = list[GetCurrentMapDungeonLevel()] -- try again
			if not dims then -- there is actually a level 0 in this zone but we don't know about it...too bad :(
				return
			end
		elseif not dims then
			return
		end
		local dX = (pX - uX) * dims[1]
		local dY = (pY - uY) * dims[2]
		return math.sqrt(dX * dX + dY * dY) < range * 1.005
	end
	
	setmetatable(checkFuncs, {
		__index = function(t, k)
			return mapRangeCheck
		end
	})
end

do
	local bandages = {21991, 34721, 38643, 34722, 34721, 34722}  -- you should have one of these bandages in your cache

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
	onUpdate(frame, 0)
end

function rangeCheck:Hide()
	if frame then frame:Hide() end
end

function rangeCheck:IsShown()
	return frame and frame:IsShown()
end

