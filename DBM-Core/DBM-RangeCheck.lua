---------------
--  Globals  --
---------------
DBM.RangeCheck = {}

--------------
--  Locals  --
--------------
local L = DBM_CORE_L
local rangeCheck = DBM.RangeCheck
local mainFrame = CreateFrame("Frame")
local textFrame, radarFrame, updateIcon, updateRangeFrame, initializeDropdown
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS -- For Phanx' Class Colors

--retail/beta compat
local UnitInPhase = _G["UnitInPhase"] or function(unit)
	local reason = UnitPhaseReason(unit)--9.x replacement for UnitinPhase
	if reason then--Any reason, means they are out of phase
		return false
	end
	return true
end

-- Function for automatically converting inputed ranges from old mods to be ones that have valid item/api checks
local function setCompatibleRestrictedRange(range)
	if range <= 4 then
		range = 4
	elseif range <= 6 then
		range = 6
	elseif range <= 8 then
		range = 8
	elseif range <= 10 then
		range = 10
	elseif range <= 11 then
		range = 11
	elseif range <= 13 then
		range = 13
	elseif range <= 18 then
		range = 18
	elseif range <= 23 then
		range = 23
	elseif range <= 30 then
		range = 30
	elseif range <= 33 then
		range = 33
	elseif range <= 43 then
		range = 43
	elseif range <= 48 then
		range = 48
	elseif range <= 53 then
		range = 53
	elseif range <= 60 then
		range = 60
	elseif range <= 80 then
		range = 80
	end
	return range
end

local itsBCAgain

do
	local CheckInteractDistance, IsItemInRange, UnitInRange = CheckInteractDistance, IsItemInRange, UnitInRange
	-- All ranges are tested and compared against UnitDistanceSquared.
	-- Example: Worgsaw has a tooltip of 6 but doesn't factor in hitboxes/etc. It doesn't return false until UnitDistanceSquared of 8.
	local itemRanges = {
		[4] = 90175, -- Gin-Ji Knife Set
		[6] = 37727, -- Ruby Acorn
		[8] = 8149, -- Voodoo Charm
		[13] = 32321, -- Sparrowhawk Net
		[18] = 6450, -- Silk Bandage
		[23] = 21519, -- Mistletoe
		[33] = 1180, -- Scroll of Stamina
		[43] = 34471, -- Vial of the Sunwell (UnitInRange api alternate if item checks break)
		[48] = 32698, -- Wrangling Rope
		[53] = 116139, -- Haunting Memento
		[60] = 32825, -- Soul Cannon
		[80] = 35278, -- Reinforced Net
	}

	local apiRanges = {
		[10] = 3, -- CheckInteractDistance (Duel)
		[11] = 2, -- CheckInteractDistance (Trade)
		[30] = 1, -- CheckInteractDistance (Inspect)
	}

	function itsBCAgain(uId, checkrange)
		if checkrange then -- Specified range, this check only cares whether unit is within specific range
			if itemRanges[checkrange] then -- Only query item range for requested active range check
				return IsItemInRange(itemRanges[checkrange], uId) and checkrange or 1000
			elseif apiRanges[checkrange] then -- Only query item range for requested active range if no item found for it
				return CheckInteractDistance(uId, apiRanges[checkrange]) and checkrange or 1000
			else
				 return 1000 -- Just so it has a numeric value, even if it's unknown to protect from nil errors
			end
		else -- No range passed, this is being used by a getDistanceBetween function that needs to calculate precise distances of members of raid (well as precise as possible with a crappy api)
			if IsItemInRange(90175, uId) then return 4
			elseif IsItemInRange(37727, uId) then return 6
			elseif IsItemInRange(8149, uId) then return 8
			elseif CheckInteractDistance(uId, 3) then return 10
			elseif CheckInteractDistance(uId, 2) then return 11
			elseif IsItemInRange(32321, uId) then return 13
			elseif IsItemInRange(6450, uId) then return 18
			elseif IsItemInRange(21519, uId) then return 23
			elseif CheckInteractDistance(uId, 1) then return 30
			elseif IsItemInRange(1180, uId) then return 33
			elseif UnitInRange(uId) then return 43
			elseif IsItemInRange(32698, uId) then return 48
			elseif IsItemInRange(116139, uId) then return 53
			elseif IsItemInRange(32825, uId) then return 60
			elseif IsItemInRange(35278, uId) then return 80
			else return 1000 end -- Just so it has a numeric value, even if it's unknown to protect from nil errors
		end
	end
end

---------------------
--  Dropdown Menu  --
---------------------
do
	local sound0 = "none"
	local sound1 = "Interface\\AddOns\\DBM-Core\\Sounds\\blip_8.ogg"
	local sound2 = "Interface\\AddOns\\DBM-Core\\Sounds\\alarmclockbeeps.ogg"

	local function setSound(self, option, sound)
		DBM.Options[option] = sound
		if sound ~= "none" then
			DBM:PlaySoundFile(sound)
		end
	end

	local function setRange(self, range)
		rangeCheck:Hide(true)
		rangeCheck:Show(range, mainFrame.filter, true, mainFrame.redCircleNumPlayers or 1)
	end

	local function setThreshold(self, threshold)
		rangeCheck:Hide(true)
		rangeCheck:Show(mainFrame.range, mainFrame.filter, true, threshold)
	end

	local function setFrames(self, option)
		DBM.Options.RangeFrameFrames = option
		rangeCheck:Hide(true)
		rangeCheck:Show(mainFrame.range, mainFrame.filter, true, mainFrame.redCircleNumPlayers or 1)
	end

	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	function initializeDropdown(_, level, menu)
		local info

		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SETTHRESHOLD
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "threshold"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
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
			info.func = function() rangeCheck:Hide(true) end
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)
		elseif level == 2 then
			if menu == "range" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(4)
				info.func = setRange
				info.arg1 = 4
				info.checked = (mainFrame.range == 4)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(6)
				info.func = setRange
				info.arg1 = 6
				info.checked = (mainFrame.range == 6)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(8)
				info.func = setRange
				info.arg1 = 8
				info.checked = (mainFrame.range == 8)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(10)
				info.func = setRange
				info.arg1 = 10
				info.checked = (mainFrame.range == 10)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(13)
				info.func = setRange
				info.arg1 = 13
				info.checked = (mainFrame.range == 13)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(18)
				info.func = setRange
				info.arg1 = 18
				info.checked = (mainFrame.range == 18)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(23)
				info.func = setRange
				info.arg1 = 23
				info.checked = (mainFrame.range == 23)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(30)
				info.func = setRange
				info.arg1 = 30
				info.checked = (mainFrame.range == 30)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(33)
				info.func = setRange
				info.arg1 = 33
				info.checked = (mainFrame.range == 33)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SETRANGE_TO:format(43)
				info.func = setRange
				info.arg1 = 43
				info.checked = (mainFrame.range == 43)
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "threshold" then
				info = UIDropDownMenu_CreateInfo()
				info.text = 1
				info.func = setThreshold
				info.arg1 = 1
				info.checked = (mainFrame.redCircleNumPlayers == 1)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 2
				info.func = setThreshold
				info.arg1 = 2
				info.checked = (mainFrame.redCircleNumPlayers == 2)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 3
				info.func = setThreshold
				info.arg1 = 3
				info.checked = (mainFrame.redCircleNumPlayers == 3)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 4
				info.func = setThreshold
				info.arg1 = 4
				info.checked = (mainFrame.redCircleNumPlayers == 4)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 5
				info.func = setThreshold
				info.arg1 = 5
				info.checked = (mainFrame.redCircleNumPlayers == 5)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 6
				info.func = setThreshold
				info.arg1 = 6
				info.checked = (mainFrame.redCircleNumPlayers == 6)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = 8
				info.func = setThreshold
				info.arg1 = 8
				info.checked = (mainFrame.redCircleNumPlayers == 8)
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "sounds" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SOUND_OPTION_1
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound1"
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_SOUND_OPTION_2
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound2"
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "frames" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_TEXT
				info.func = setFrames
				info.arg1 = "text"
				info.checked = (DBM.Options.RangeFrameFrames == "text")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_RADAR
				info.func = setFrames
				info.arg1 = "radar"
				info.checked = (DBM.Options.RangeFrameFrames == "radar")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.RANGECHECK_OPTION_BOTH
				info.func = setFrames
				info.arg1 = "both"
				info.checked = (DBM.Options.RangeFrameFrames == "both")
				UIDropDownMenu_AddButton(info, 2)
			end
		elseif level == 3 then
			local option = menu
			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_0
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound0
			info.checked = (DBM.Options[option] == sound0)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_1
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound1
			info.checked = (DBM.Options[option] == sound1)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.RANGECHECK_SOUND_2
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
local updateSound
local soundUpdate = 0

do
	local UnitAffectingCombat = UnitAffectingCombat

	function updateSound(num)
		if not UnitAffectingCombat("player") or (GetTime() - soundUpdate) < 5 then
			return
		end
		soundUpdate = GetTime()
		if num == 1 then
			if DBM.Options.RangeFrameSound1 ~= "none" then
				DBM:PlaySoundFile(DBM.Options.RangeFrameSound1)
			end
		elseif num > 1 then
			if DBM.Options.RangeFrameSound2 ~= "none" then
				DBM:PlaySoundFile(DBM.Options.RangeFrameSound2)
			end
		end
	end
end

------------------------
--  Create the frame  --
------------------------
local function createTextFrame()
	textFrame = CreateFrame("Frame", "DBMRangeCheck", UIParent, DBM:IsAlpha() and "BackdropTemplate")
	textFrame:SetFrameStrata("DIALOG")
	textFrame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background",--131071
		tile		= true,
		tileSize	= 16
	}
	if not DBM:IsAlpha() then
		textFrame:SetBackdrop(textFrame.backdropInfo)
	else
		textFrame:ApplyBackdrop()
	end
	textFrame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	textFrame:SetSize(128, 12)
	textFrame:SetClampedToScreen(true)
	textFrame:EnableMouse(true)
	textFrame:SetToplevel(true)
	textFrame:SetMovable(true)
	textFrame:RegisterForDrag("LeftButton")
	textFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	textFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	textFrame:SetScript("OnMouseDown", function(_, button)
		if button == "RightButton" then
			local dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", UIParent)
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown)
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local text = textFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	text:SetWidth(128)
	text:SetHeight(15)
	text:SetPoint("BOTTOMLEFT", textFrame, "TOPLEFT")
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	textFrame.text = text

	local inRangeText = textFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	inRangeText:SetWidth(128)
	inRangeText:SetHeight(15)
	inRangeText:SetPoint("TOPLEFT", textFrame, "BOTTOMLEFT")
	inRangeText:SetTextColor(1, 1, 1, 1)
	inRangeText:Hide()
	textFrame.inRangeText = inRangeText

	textFrame.lines = {}
	for i = 1, 5 do
		local line = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		line:SetSize(128, 12)
		line:SetJustifyH("LEFT")
		if i == 1 then
			line:SetPoint("TOPLEFT", textFrame, "TOPLEFT", 6, -6)
		else
			line:SetPoint("TOPLEFT", textFrame.lines[i - 1], "LEFT", 0, -6)
		end
		textFrame.lines[i] = line
	end
end

local function createRadarFrame()
	radarFrame = CreateFrame("Frame", "DBMRangeCheckRadar", UIParent)
	radarFrame:SetFrameStrata("DIALOG")
	radarFrame:SetPoint(DBM.Options.RangeFrameRadarPoint, UIParent, DBM.Options.RangeFrameRadarPoint, DBM.Options.RangeFrameRadarX, DBM.Options.RangeFrameRadarY)
	radarFrame:SetSize(128, 128)
	radarFrame:SetClampedToScreen(true)
	radarFrame:EnableMouse(true)
	radarFrame:SetToplevel(true)
	radarFrame:SetMovable(true)
	radarFrame:RegisterForDrag("LeftButton")
	radarFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	radarFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameRadarX = x
		DBM.Options.RangeFrameRadarY = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnMouseDown", function(_, button)
		if button == "RightButton" then
			local dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", UIParent)
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown)
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local bg = radarFrame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(radarFrame)
	bg:SetBlendMode("BLEND")
	bg:SetColorTexture(0, 0, 0, 0.3)
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
	player:SetTexture(136431) -- "Interface\\Minimap\\MinimapArrow.blp"
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	local text = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	text:SetWidth(128)
	text:SetHeight(15)
	text:SetPoint("BOTTOMLEFT", radarFrame, "TOPLEFT")
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	radarFrame.text = text

	local inRangeText = radarFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	inRangeText:SetWidth(128)
	inRangeText:SetHeight(15)
	inRangeText:SetPoint("TOPLEFT", radarFrame, "BOTTOMLEFT")
	inRangeText:SetTextColor(1, 1, 1, 1)
	inRangeText:Hide()
	radarFrame.inRangeText = inRangeText

	radarFrame.dots = {}
	for i = 1, 40 do
		local dot = radarFrame:CreateTexture(nil, "OVERLAY")
		dot:SetSize(24, 24)
		dot:SetTexture(249183) -- "Interface\\Minimap\\PartyRaidBlips"
		dot:Hide()
		radarFrame.dots[i] = dot
	end

	radarFrame:Hide()
end

----------------
--  OnUpdate  --
----------------
do
	local UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected, GetPlayerFacing, UnitClass, IsInRaid, GetNumGroupMembers, GetRaidTargetIndex, GetBestMapForUnit = UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected, GetPlayerFacing, UnitClass, IsInRaid, GetNumGroupMembers, GetRaidTargetIndex, C_Map.GetBestMapForUnit
	local max, sin, cos, pi2 = math.max, math.sin, math.cos, math.pi * 2
	local circleColor, rotation, pixelsperyard, activeDots, prevRange, prevThreshold, prevNumClosePlayer, prevclosestRange, prevColor, prevType = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	local unitList = {}
	local BLIP_TEX_COORDS = {
		["WARRIOR"]		 = { 0, 0.125, 0, 0.25 },
		["PALADIN"]		 = { 0.125, 0.25, 0, 0.25 },
		["HUNTER"]		 = { 0.25, 0.375, 0, 0.25 },
		["ROGUE"]		 = { 0.375, 0.5, 0, 0.25 },
		["PRIEST"]		 = { 0.5, 0.625, 0, 0.25 },
		["DEATHKNIGHT"]	 = { 0.625, 0.75, 0, 0.25 },
		["SHAMAN"]		 = { 0.75, 0.875, 0, 0.25 },
		["MAGE"]		 = { 0.875, 1, 0, 0.25 },
		["WARLOCK"]		 = { 0, 0.125, 0.25, 0.5 },
		["DRUID"]		 = { 0.25, 0.375, 0.25, 0.5 },
		["MONK"]		 = { 0.125, 0.25, 0.25, 0.5 },
		["DEMONHUNTER"]	 = { 0.375, 0.5, 0.25, 0.5 },
	}

	local function setDot(id, sinTheta, cosTheta)
		local dot = radarFrame.dots[id]
		if dot.range < (mainFrame.range * 1.5) then -- If person is closer than 1.5 * range, show the dot. Else hide it
			dot:ClearAllPoints()
			dot:SetPoint("CENTER", radarFrame, "CENTER", ((dot.x * cosTheta) - (-dot.y * sinTheta)) * pixelsperyard, ((dot.x * sinTheta) + (-dot.y * cosTheta)) * pixelsperyard)
			dot:Show()
		elseif dot:IsShown() then
			dot:Hide()
		end
	end

	function updateIcon()
		local numPlayers = GetNumGroupMembers()
		activeDots = max(numPlayers, activeDots)
		for i = 1, activeDots do
			local dot = radarFrame.dots[i]
			if i <= numPlayers then
				unitList[i] = IsInRaid() and "raid" .. i or "party" .. i
				local _, class = UnitClass(unitList[i])
				local icon = GetRaidTargetIndex(unitList[i])
				dot.class = class
				if icon and icon < 9 then
					dot.icon = icon
					dot:SetTexture(13700 .. icon) -- "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. icon
					dot:SetTexCoord(0, 1, 0, 1)
					dot:SetSize(16, 16)
					dot:SetDrawLayer("OVERLAY", 1)
				else
					dot.icon = nil
					class = class or "PRIEST"
					dot:SetTexture(249183) -- "Interface\\Minimap\\PartyRaidBlips"
					dot:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
					dot:SetSize(24, 24)
					dot:SetDrawLayer("OVERLAY", 0)
				end
			elseif dot:IsShown() then
				dot:Hide()
			end
		end
	end

	function updateRangeFrame()
		if mainFrame.hideTime > 0 and GetTime() > mainFrame.hideTime then
			rangeCheck:Hide()
			return
		end
		local activeRange = mainFrame.range
		local restricted = mainFrame.restrictions
		local tEnabled = textFrame:IsShown()
		local rEnabled = radarFrame:IsShown()
		local reverse = mainFrame.reverse
		local warnThreshold = mainFrame.redCircleNumPlayers
		if tEnabled then
			for i = 1, 5 do
				textFrame.lines[i]:SetText("")
				textFrame.lines[i]:Hide()
			end
			if reverse then
				if warnThreshold > 1 then
					textFrame.text:SetText(L.RANGECHECK_RHEADERT:format(activeRange, warnThreshold))
				else
					textFrame.text:SetText(L.RANGECHECK_RHEADER:format(activeRange))
				end
			else
				if warnThreshold > 1 then
					textFrame.text:SetText(L.RANGECHECK_HEADERT:format(activeRange, warnThreshold))
				else
					textFrame.text:SetText(L.RANGECHECK_HEADER:format(activeRange))
				end
			end
		end
		if rEnabled and (prevRange ~= activeRange or prevThreshold ~= mainFrame.redCircleNumPlayers) then
			prevRange = activeRange
			pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (activeRange * 3)
			radarFrame.circle:SetSize(activeRange * pixelsperyard * 2, activeRange * pixelsperyard * 2)
			if reverse then
				radarFrame.text:SetText(L.RANGERADAR_RHEADER:format(activeRange, mainFrame.redCircleNumPlayers))
			else
				radarFrame.text:SetText(L.RANGERADAR_HEADER:format(activeRange, mainFrame.redCircleNumPlayers))
			end
		end

		local playerMapId = GetBestMapForUnit("player") or 0
		if not restricted then
			rotation = pi2 - (GetPlayerFacing() or 0)
		end
		local sinTheta = sin(rotation)
		local cosTheta = cos(rotation)
		local closePlayer = 0
		local closestRange
		local closetName
		local filter = mainFrame.filter
		local type = reverse and 2 or filter and 1 or 0
		local onlySummary = mainFrame.onlySummary
		for i = 1, GetNumGroupMembers() do
			local uId = unitList[i]
			local dot = radarFrame.dots[i]
			local mapId = GetBestMapForUnit(uId) or 0
			if UnitExists(uId) and playerMapId == mapId and not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and UnitIsConnected(uId) and UnitInPhase(uId) and (not filter or filter(uId)) then
				local range = restricted and itsBCAgain(uId, activeRange) or UnitDistanceSquared(uId) ^ 0.5
				local inRange = false
				if range < activeRange + 0.5 then
					closePlayer = closePlayer + 1
					inRange = true
					if rEnabled then -- Only used by radar
						if not closestRange then
							closestRange = range
						elseif range < closestRange then
							closestRange = range
						end
					end
					if not closetName then
						closetName = DBM:GetUnitFullName(uId)
						closetName = DBM:GetShortServerName(closetName)
					end
				end
				if tEnabled and inRange and not onlySummary and closePlayer < 6 then -- Display up to 5 players in text range frame.
					local playerName = DBM:GetUnitFullName(uId)
					playerName = DBM:GetShortServerName(playerName)
					local color = RAID_CLASS_COLORS[dot.class] or NORMAL_FONT_COLOR
					textFrame.lines[closePlayer]:SetText(dot.icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(dot.icon, playerName) or playerName)
					textFrame.lines[closePlayer]:SetTextColor(color.r, color.g, color.b)
					textFrame.lines[closePlayer]:Show()
					textFrame:SetHeight((closePlayer * 12) + 12)
				end
				if rEnabled then
					local playerX, playerY = UnitPosition("player")
					local x, y = UnitPosition(uId)
					if not x and not y then
						rangeCheck:Hide(true)
						return
					end
					dot.x = -(x - playerX)
					dot.y = -(y - playerY)
					dot.range = range
					setDot(i, sinTheta, cosTheta)
				end
			elseif rEnabled and dot:IsShown() then
				dot:Hide()
			end
		end

		if tEnabled then
			-- Green Text (Regular range frame and not near too many players, or reverse range frame and we ARE near enough)
			textFrame.inRangeText:SetText(L.RANGECHECK_IN_RANGE_TEXT:format(closePlayer, activeRange))
			textFrame.inRangeText:Show()
			if (reverse and closePlayer >= warnThreshold) or (not reverse and closePlayer < warnThreshold) then
				textFrame.inRangeText:SetTextColor(0, 1, 0)
			-- Red Text (Regular range frame and we are near too many players, or reverse range frame and we aren't near enough)
			else
				updateSound(closePlayer)
				textFrame.inRangeText:SetTextColor(1, 0, 0)
			end
			textFrame:Show()
		end
		if rEnabled then
			if prevNumClosePlayer ~= closePlayer or prevclosestRange ~= closestRange or prevType ~= type then
				if closePlayer >= warnThreshold then -- Only show the text if the circle is red
					circleColor = reverse and 1 or 2
					if closePlayer == 1 then
						radarFrame.inRangeText:SetText(L.RANGERADAR_IN_RANGE_TEXTONE:format(closetName, closestRange))
					else
						radarFrame.inRangeText:SetText(L.RANGERADAR_IN_RANGE_TEXT:format(closePlayer, closestRange))
					end
					radarFrame.inRangeText:Show()
				else
					circleColor = reverse and 2 or 1
					radarFrame.inRangeText:Hide()
				end
				prevNumClosePlayer = closePlayer
				prevclosestRange = closestRange
				prevType = type
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
			if circleColor == 2 then -- Red
				updateSound(closePlayer)
			end
		end
	end
end

local updater = mainFrame:CreateAnimationGroup()
updater:SetLooping("REPEAT")
local anim = updater:CreateAnimation()
anim:SetDuration(0.05)

mainFrame:SetSize(0, 0)
mainFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" or event == "RAID_TARGET_UPDATE" then
		updateIcon()
	end
end)

-----------------------
--  Check functions  --
-----------------------
local getDistanceBetween, getDistanceBetweenAll

do
	local UnitPosition, UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected = UnitPosition, UnitExists, UnitIsUnit, UnitIsDeadOrGhost, UnitIsConnected

	function getDistanceBetweenAll(checkrange)
		local range
		for uId in DBM:GetGroupMembers() do
			if UnitExists(uId) and not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and UnitIsConnected(uId) and UnitInPhase(uId) then
				range = DBM:HasMapRestrictions() and itsBCAgain(uId, checkrange) or UnitDistanceSquared(uId) * 0.5
				if checkrange < (range + 0.5) then
					return true
				end
			end
		end
		return false
	end

	function getDistanceBetween(uId, x, y)
		local restrictionsActive = DBM:HasMapRestrictions()
		if not x then -- If only one arg then 2nd arg is always assumed to be player
			return restrictionsActive and itsBCAgain(uId) or UnitDistanceSquared(uId) ^ 0.5
		end
		if type(x) == "string" and UnitExists(x) then -- arguments: uId, uId2
			-- First attempt to avoid UnitPosition if any of args is player UnitDistanceSquared should work
			if UnitIsUnit("player", uId) then
				return restrictionsActive and itsBCAgain(x) or UnitDistanceSquared(x) ^ 0.5
			elseif UnitIsUnit("player", x) then
				return restrictionsActive and itsBCAgain(uId) or UnitDistanceSquared(uId) ^ 0.5
			else -- Neither unit is player, no way to avoid UnitPosition
				if restrictionsActive then -- Cannot compare two units that don't involve player with restrictions, just fail quietly
					return 1000
				end
				local uId2 = x
				x, y = UnitPosition(uId2)
				if not x then
					print("getDistanceBetween failed for: " .. uId .. " (" .. tostring(UnitExists(uId)) .. ") and " .. uId2 .. " (" .. tostring(UnitExists(uId2)) .. ")")
					return
				end
			end
		end
		if restrictionsActive then -- Cannot check distance between player and a location (not another unit, again, fail quietly)
			return 1000
		end
		local startX, startY = UnitPosition(uId)
		local dX = startX - x
		local dY = startY - y
		return (dX * dX + dY * dY) ^ 0.5
	end
end

---------------
--  Methods  --
---------------
local restoreRange, restoreFilter, restoreThreshold, restoreReverse

function rangeCheck:Show(range, filter, forceshow, redCircleNumPlayers, reverse, hideTime, onlySummary)
	if (DBM:GetNumRealGroupMembers() < 2 or DBM.Options.DontShowRangeFrame) and not forceshow then
		return
	end
	if type(range) == "function" then -- The first argument is optional
		return self:Show(nil, range)
	end
	range = range or 10
	redCircleNumPlayers = redCircleNumPlayers or 1
	if not textFrame then
		createTextFrame()
	end
	if not radarFrame then
		createRadarFrame()
	end
	local restrictionsActive = DBM:HasMapRestrictions()
	if (DBM.Options.RangeFrameFrames == "text" or DBM.Options.RangeFrameFrames == "both" or restrictionsActive) and not textFrame:IsShown() then
		if restrictionsActive then
			range = setCompatibleRestrictedRange(range)
		end
		textFrame:Show()
	end
	-- TODO, add check for restricted area here so we can prevent radar frame loading.
	if not restrictionsActive and (DBM.Options.RangeFrameFrames == "radar" or DBM.Options.RangeFrameFrames == "both") and not radarFrame:IsShown() then
		radarFrame:Show()
	end
	mainFrame.range = range
	mainFrame.filter = filter
	mainFrame.redCircleNumPlayers = redCircleNumPlayers
	mainFrame.reverse = reverse
	mainFrame.hideTime = hideTime and (GetTime() + hideTime) or 0
	mainFrame.restrictions = restrictionsActive
	mainFrame.onlySummary = onlySummary
	if not mainFrame.eventRegistered then
		mainFrame.eventRegistered = true
		updateIcon()
		mainFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
		mainFrame:RegisterEvent("RAID_TARGET_UPDATE")
	end
	updater:SetScript("OnLoop", updateRangeFrame)
	updater:Play()
	if forceshow and not DBM.Options.DontRestoreRange then -- Force means user activated range frame, store user value for restore function
		restoreRange, restoreFilter, restoreThreshold, restoreReverse = mainFrame.range, mainFrame.filter, mainFrame.redCircleNumPlayers, mainFrame.reverse
	end
end

function rangeCheck:Hide(force)
	if restoreRange and not force then -- Restore range frame to way it was when boss mod is done with it
		rangeCheck:Show(restoreRange, restoreFilter, true, restoreThreshold, restoreReverse)
	else
		restoreRange, restoreFilter, restoreThreshold, restoreReverse = nil, nil, nil, nil
		updater:Stop()
		if mainFrame.eventRegistered then
			mainFrame.eventRegistered = nil
			mainFrame:UnregisterAllEvents()
		end
		if textFrame then
			textFrame:Hide()
		end
		if radarFrame then
			radarFrame:Hide()
		end
	end
end

function rangeCheck:IsShown()
	return textFrame and textFrame:IsShown() or radarFrame and radarFrame:IsShown()
end

function rangeCheck:IsRadarShown()
	return radarFrame and radarFrame:IsShown()
end

function rangeCheck:UpdateRestrictions(force)
	mainFrame.restrictions = force or DBM:HasMapRestrictions()
end

function rangeCheck:SetHideTime(hideTime)
	mainFrame.hideTime = hideTime and (GetTime() + hideTime) or 0
end

function rangeCheck:GetDistance(...)
	return getDistanceBetween(...)
end

function rangeCheck:GetDistanceAll(checkrange)
	if DBM:HasMapRestrictions() then
		checkrange = setCompatibleRestrictedRange(checkrange)
	end
	return getDistanceBetweenAll(checkrange)
end
