---------------
--  Globals  --
---------------
DBM.InfoFrame = {}

-------------------
-- Local Globals --
-------------------
local DBM = DBM
local L = DBM_CORE_L
local UnitClass, GetTime, GetPartyAssignment, UnitGroupRolesAssigned, GetRaidTargetIndex, UnitExists, UnitGetTotalAbsorbs, UnitName, UnitHealth, UnitPower, UnitPowerMax, UnitIsDeadOrGhost, UnitThreatSituation, UnitPosition, UnitIsUnit, UIDropDownMenu_CreateInfo, UIDropDownMenu_AddButton = UnitClass, GetTime, GetPartyAssignment, UnitGroupRolesAssigned, GetRaidTargetIndex, UnitExists, UnitGetTotalAbsorbs, UnitName, UnitHealth, UnitPower, UnitPowerMax, UnitIsDeadOrGhost, UnitThreatSituation, UnitPosition, UnitIsUnit, UIDropDownMenu_CreateInfo, UIDropDownMenu_AddButton
local error, tostring, type, pairs, ipairs, select, tonumber, tsort, twipe, mfloor, mmax, mmin, mrandom, schar, ssplit, CAfter = error, tostring, type, pairs, ipairs, select, tonumber, table.sort, table.wipe, math.floor, math.max, math.min, math.random, string.char, string.split, C_Timer.After
local NORMAL_FONT_COLOR, SPELL_FAILED_OUT_OF_RANGE = NORMAL_FONT_COLOR, SPELL_FAILED_OUT_OF_RANGE
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

--------------
--  Locals  --
--------------
local infoFrame = DBM.InfoFrame
local frame, initializeDropdown, currentMapId, currentEvent, createFrame
local maxLines, modLines, maxCols, modCols, prevLines = 5, 5, 1, 1, 0
local sortMethod = 1--1 Default, 2 SortAsc, 3 GroupId
local lines, sortedLines, icons, value = {}, {}, {}, {}
local playerName = UnitName("player")

---------------------
--  Dropdown Menu  --
---------------------
do
	local function toggleLocked()
		DBM.Options.InfoFrameLocked = not DBM.Options.InfoFrameLocked
	end

	local function toggleShowSelf()
		DBM.Options.InfoFrameShowSelf = not DBM.Options.InfoFrameShowSelf
	end

	local function setLines(_, line)
		prevLines = 0
		DBM.Options.InfoFrameLines = line
		if line ~= 0 then
			maxLines = line
		else
			maxLines = modLines or 5
		end
	end

	local function setCols(_, col)
		prevLines = 0
		DBM.Options.InfoFrameCols = col
		if col ~= 0 then
			maxCols = col
		else
			maxCols = modCols or 5
		end
	end

	function initializeDropdown(_, level, menu)
		local info

		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = LOCK_FRAME
			if DBM.Options.InfoFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.keepShownOnClick = true
			info.text = L.INFOFRAME_SHOW_SELF
			if DBM.Options.InfoFrameShowSelf then
				info.checked = true
			end
			info.func = toggleShowSelf
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.INFOFRAME_SETLINES
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "lines"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L.INFOFRAME_SETCOLS
			info.notCheckable = true
			info.hasArrow = true
			info.keepShownOnClick = true
			info.menuList = "cols"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = HIDE
			info.notCheckable = true
			info.func = infoFrame.Hide
			info.arg1 = infoFrame
			UIDropDownMenu_AddButton(info, 1)
		elseif level == 2 then
			if menu == "lines" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINESDEFAULT
				info.func = setLines
				info.arg1 = 0
				info.checked = (DBM.Options.InfoFrameLines == 0)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(3)
				info.func = setLines
				info.arg1 = 3
				info.checked = (DBM.Options.InfoFrameLines == 3)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(5)
				info.func = setLines
				info.arg1 = 5
				info.checked = (DBM.Options.InfoFrameLines == 5)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(8)
				info.func = setLines
				info.arg1 = 8
				info.checked = (DBM.Options.InfoFrameLines == 8)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(10)
				info.func = setLines
				info.arg1 = 10
				info.checked = (DBM.Options.InfoFrameLines == 10)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(15)
				info.func = setLines
				info.arg1 = 15
				info.checked = (DBM.Options.InfoFrameLines == 15)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINES_TO:format(20)
				info.func = setLines
				info.arg1 = 20
				info.checked = (DBM.Options.InfoFrameLines == 20)
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "cols" then
				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_LINESDEFAULT
				info.func = setCols
				info.arg1 = 0
				info.checked = (DBM.Options.InfoFrameCols == 0)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_COLS_TO:format(1)
				info.func = setCols
				info.arg1 = 1
				info.checked = (DBM.Options.InfoFrameCols == 1)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_COLS_TO:format(2)
				info.func = setCols
				info.arg1 = 2
				info.checked = (DBM.Options.InfoFrameCols == 2)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_COLS_TO:format(3)
				info.func = setCols
				info.arg1 = 3
				info.checked = (DBM.Options.InfoFrameCols == 3)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_COLS_TO:format(4)
				info.func = setCols
				info.arg1 = 4
				info.checked = (DBM.Options.InfoFrameCols == 4)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = L.INFOFRAME_COLS_TO:format(5)
				info.func = setCols
				info.arg1 = 5
				info.checked = (DBM.Options.InfoFrameCols == 5)
				UIDropDownMenu_AddButton(info, 2)
			end
		end
	end
end

------------------------
--  Create the frame  --
------------------------
function createFrame()
	frame = CreateFrame("Frame", "DBMInfoFrame", UIParent, DBM:IsAlpha() and "BackdropTemplate")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
		tile		= true,
		tileSize	= 16
	}
	if not DBM:IsAlpha() then
		frame:SetBackdrop(frame.backdropInfo)
	else
		frame:ApplyBackdrop()
	end
	frame:SetPoint(DBM.Options.InfoFramePoint, UIParent, DBM.Options.InfoFramePoint, DBM.Options.InfoFrameX, DBM.Options.InfoFrameY)
	frame:SetSize(10, 10)
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		if not DBM.Options.InfoFrameLocked then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.InfoFrameX = x
		DBM.Options.InfoFrameY = y
		DBM.Options.InfoFramePoint = point
	end)
	frame:SetScript("OnEvent", function(self, event, ...)
		if infoFrame[event] then
			infoFrame[event](self, ...)
		end
	end)
	frame:SetScript("OnMouseDown", function(_, button)
		if button == "RightButton" then
			local dropdownFrame = CreateFrame("Frame", "DBMInfoFrameDropdown", frame, "UIDropDownMenuTemplate")
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown)
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local header = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	header:SetTextColor(1, 1, 1)
	header:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 2, 2)
	frame.header = header
	infoFrame:SetHeader()

	frame.lines = {}
end

------------------------
--  Update functions  --
------------------------
local updateCallbacks = {}

local function sortFuncDesc(a, b)
	return lines[a] > lines[b]
end

local function sortFuncAsc(a, b)
	return lines[a] < lines[b]
end

local function sortGroupId(a, b)
	return DBM.GetGroupId(DBM, a) < DBM.GetGroupId(DBM, b)
end

local function updateLines(preSorted)
	twipe(sortedLines)
	if preSorted then
		-- Copy table as code from mod keeps around references this this and the "normal" table is wiped regularly
		for i, v in ipairs(preSorted) do
			sortedLines[i] = v
		end
	else
		for i in pairs(lines) do
			sortedLines[#sortedLines + 1] = i
		end
		if sortMethod == 3 then
			tsort(sortedLines, sortGroupId)
		elseif sortMethod == 2 then
			tsort(sortedLines, sortFuncAsc)
		else
			tsort(sortedLines, sortFuncDesc)
		end
	end
	for _, v in ipairs(updateCallbacks) do
		v(sortedLines)
	end
end

--[[
local function namesortFuncAsc(a, b)
	return a < b
end

local function updateNamesortLines()
	twipe(sortedLines)
	for i in pairs(lines) do
		sortedLines[#sortedLines + 1] = i
	end
	tsort(sortedLines, namesortFuncAsc)
	for _, v in ipairs(updateCallbacks) do
		v(sortedLines)
	end
end
]]--

local function updateLinesCustomSort(sortFunc)
	twipe(sortedLines)
	for i in pairs(lines) do
		sortedLines[#sortedLines + 1] = i
	end
	tsort(sortedLines, sortFunc)
	for _, v in ipairs(updateCallbacks) do
		v(sortedLines)
	end
end

local function updateIcons()
	twipe(icons)
	for uId in DBM:GetGroupMembers() do
		local icon = GetRaidTargetIndex(uId)
		local icon2 = GetRaidTargetIndex(uId .. "target")
		if icon then
			icons[DBM:GetUnitFullName(uId)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon)
		end
		if icon2 then
			icons[DBM:GetUnitFullName(uId .. "target")] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon2)
		end
	end
	for i = 1, 5 do
		local icon = GetRaidTargetIndex("boss" .. i)
		if icon then
			icons[UnitName("boss" .. i)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon)
		end
	end
end

local function updateHealth()
	twipe(lines)
	local threshold = value[1]
	for uId in DBM:GetGroupMembers() do
		if UnitHealth(uId) < threshold and not UnitIsDeadOrGhost(uId) then
			lines[DBM:GetUnitFullName(uId)] = UnitHealth(uId) - threshold
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerPower()
	twipe(lines)
	local threshold = value[1]
	local powerType = value[2]
	local spellFilter = value[3]
	-- Value 4 is the noUpdate handler
	-- Value 5 is sorting method, handled in show handler
	for uId in DBM:GetGroupMembers() do
		if not spellFilter or not DBM:UnitDebuff(uId, spellFilter) then
			local maxPower = UnitPowerMax(uId, powerType)
			if maxPower ~= 0 and not UnitIsDeadOrGhost(uId) and UnitPower(uId, powerType) / UnitPowerMax(uId, powerType) * 100 >= threshold then
				lines[DBM:GetUnitFullName(uId)] = UnitPower(uId, powerType)
			end
		end
	end
	if DBM.Options.InfoFrameShowSelf and not lines[playerName] and UnitPower("player", powerType) > 0 then
		lines[playerName] = UnitPower("player", powerType)
	end
	updateLines()
	updateIcons()
end

local function updateEnemyPower()
	twipe(lines)
	local threshold = value[1]
	local powerType = value[2]
	local specificUnit = value[3]
	if powerType then -- Only do power type defined
		if specificUnit then
			local currentPower, maxPower = UnitPower(specificUnit, powerType), UnitPowerMax(specificUnit, powerType)
			if maxPower and maxPower > 0 then
				local percent = currentPower / maxPower * 100
				if percent >= threshold then
					lines[UnitName(specificUnit)] = mfloor(percent) .. "%"
				end
			end
		else
			if specificUnit then
				local currentPower, maxPower = UnitPower(specificUnit), UnitPowerMax(specificUnit)
				if maxPower and maxPower > 0 then
					local percent = currentPower / maxPower * 100
					if percent >= threshold then
						lines[UnitName(specificUnit)] = mfloor(percent) .. "%"
					end
				end
			else
				for i = 1, 5 do
					local uId = "boss" .. i
					local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
					if maxPower and maxPower > 0 then
						local percent = currentPower / maxPower * 100
						if percent >= threshold then
							lines[UnitName(uId)] = mfloor(percent) .. "%"
						end
					end
				end
			end
		end
	else -- Check primary power type and alternate power types together. This should only be used if BOTH power types exist on same boss, else fix your shit MysticalOS
		for i = 1, 5 do
			local uId = "boss" .. i
			-- Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower > 0 then
				if currentPower / maxPower * 100 >= threshold then
					lines[UnitName(uId)] = currentPower
				end
			end
			-- Alternate Power
			local currentAltPower, maxAltPower = UnitPower(uId, 10), UnitPowerMax(uId, 10)
			if maxAltPower and maxAltPower > 0 then
				if currentAltPower / maxAltPower * 100 >= threshold then
					lines[UnitName(uId)] = L.INFOFRAME_ALT .. currentAltPower
				end
			end
		end
	end
	updateLines()
	updateIcons()
end

local function updateEnemyAbsorb()
	twipe(lines)
	local spellInput = value[1]
	local totalAbsorb = value[2]
	local specificUnit = value[3]
	if specificUnit then
		if UnitExists(specificUnit) then
			local absorbAmount
			if spellInput then -- Get specific spell absorb
				absorbAmount = select(16, DBM:UnitBuff(specificUnit, spellInput)) or select(16, DBM:UnitDebuff(specificUnit, spellInput))
			else -- Get all of them
				absorbAmount = UnitGetTotalAbsorbs(specificUnit)
			end
			if absorbAmount and absorbAmount > 0 then
				local text
				if totalAbsorb then
					text = absorbAmount / totalAbsorb * 100
					lines[UnitName(specificUnit)] = mfloor(text) .. "%"
				else
					text = absorbAmount
					lines[UnitName(specificUnit)] = mfloor(text)
				end
			end
		end
	else
		for i = 1, 5 do
			local uId = "boss" .. i
			if UnitExists(uId) then
				local absorbAmount
				if spellInput then -- Get specific spell absorb
					absorbAmount = select(16, DBM:UnitBuff(uId, spellInput)) or select(16, DBM:UnitDebuff(uId, spellInput))
				else -- Get all of them
					absorbAmount = UnitGetTotalAbsorbs(uId)
				end
				if absorbAmount and absorbAmount > 0 then
					lines[UnitName(uId)] = mfloor(totalAbsorb and absorbAmount / totalAbsorb * 100 or absorbAmount) .. "%"
				end
			end
		end
	end
	updateLines()
	updateIcons()
end

local function updateAllAbsorb()
	twipe(lines)
	local spellInput = value[1]
	local totalAbsorb = value[2]
	local totalAbsorb2 = value[3]
	for i = 1, 5 do
		local uId = "boss" .. i
		if UnitExists(uId) then
			local absorbAmount
			if spellInput then -- Get specific spell absorb
				absorbAmount = select(16, DBM:UnitBuff(uId, spellInput)) or select(16, DBM:UnitDebuff(uId, spellInput))
			else -- Get all of them
				absorbAmount = UnitGetTotalAbsorbs(uId)
			end
			if absorbAmount then
				lines[UnitName(uId)] = mfloor(totalAbsorb and absorbAmount / totalAbsorb * 100 or absorbAmount) .. "%"
			end
		end
	end
	if spellInput then
		for uId in DBM:GetGroupMembers() do
			local absorbAmount = select(16, DBM:UnitBuff(uId, spellInput)) or select(16, DBM:UnitDebuff(uId, spellInput))
			if absorbAmount then
				lines[DBM:GetUnitFullName(uId)] = mfloor(totalAbsorb and absorbAmount / totalAbsorb2 * 100 or absorbAmount) .. "%"
			end
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerAbsorb()
	twipe(lines)
	local spellInput = value[1]
	local totalAbsorb = value[2]
	for uId in DBM:GetGroupMembers() do
		local absorbAmount = select(16, DBM:UnitBuff(uId, spellInput)) or select(16, DBM:UnitDebuff(uId, spellInput))
		if absorbAmount then
			lines[DBM:GetUnitFullName(uId)] = mfloor(totalAbsorb and absorbAmount / totalAbsorb * 100 or absorbAmount)
		end
	end
	updateLines()
	updateIcons()
end

-- Buffs that are good to have, therefor bad not to have them.
local function updatePlayerBuffs()
	twipe(lines)
	local spellName = value[1]
	local tankIgnored = value[2]
	for uId in DBM:GetGroupMembers() do
		if tankIgnored and (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1)) then
		else
			if not DBM:UnitBuff(uId, spellName) and not UnitIsDeadOrGhost(uId) then
				lines[DBM:GetUnitFullName(uId)] = ""
			end
		end
	end
	updateLines()
	updateIcons()
end

-- Debuffs that are good to have, therefor it's bad NOT to have them.
local function updateGoodPlayerDebuffs()
	twipe(lines)
	local spellInput = value[1]
	local tankIgnored = value[2]
	for uId in DBM:GetGroupMembers() do
		if tankIgnored and (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1)) then
		else
			if not DBM:UnitDebuff(uId, spellInput) and not UnitIsDeadOrGhost(uId) then
				lines[DBM:GetUnitFullName(uId)] = ""
			end
		end
	end
	updateLines()
	updateIcons()
end

-- Debuffs that are bad to have, therefor it is bad to have them.
-- Function will auto handle spellName or spellId via DBMs unit debuff handler and spellInput type
local function updateBadPlayerDebuffs()
	twipe(lines)
	local spellInput = value[1]
	local tankIgnored = value[2]
	for uId in DBM:GetGroupMembers() do
		if tankIgnored and (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1)) then
		else
			if DBM:UnitDebuff(uId, spellInput) and not UnitIsDeadOrGhost(uId) then
				lines[DBM:GetUnitFullName(uId)] = ""
			end
		end
	end
	updateLines()
	updateIcons()
end

--Debuffs with important durations that we track
local function updatePlayerDebuffRemaining()
	twipe(lines)
	local spellInput = value[1]
	for uId in DBM:GetGroupMembers() do
		local expires = select(6, DBM:UnitDebuff(uId, spellInput))
		if expires then
			if expires == 0 then
				lines[DBM:GetUnitFullName(uId)] = 9000--Force sorting the unknowns under the ones we do know.
			else
				local debuffTime = expires - GetTime()
				lines[DBM:GetUnitFullName(uId)] = mfloor(debuffTime)
			end
		end
	end
	updateLines()
	updateIcons()
end

-- Buffs with important durations that we track
local function updatePlayerBuffRemaining()
	twipe(lines)
	local spellInput = value[1]
	for uId in DBM:GetGroupMembers() do
		local expires = select(6, DBM:UnitBuff(uId, spellInput))
		if expires then
			if expires == 0 then
				lines[DBM:GetUnitFullName(uId)] = 9000--Force sorting the unknowns under the ones we do know.
			else
				local debuffTime = expires - GetTime()
				lines[DBM:GetUnitFullName(uId)] = mfloor(debuffTime)
			end
		end
	end
	updateLines()
	updateIcons()
end

-- Debuffs that are bad to have, but we want to show players who do NOT have them
-- Function will auto handle spellName or spellId via DBMs unit debuff handler and spellInput type
local function updateReverseBadPlayerDebuffs()
	twipe(lines)
	local spellInput = value[1]
	local tankIgnored = value[2]
	for uId in DBM:GetGroupMembers() do
		if tankIgnored and (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1)) then
		else
			if not DBM:UnitDebuff(uId, spellInput) and not UnitIsDeadOrGhost(uId) and not DBM:UnitBuff(uId, 27827) then--27827 Spirit of Redemption. This particular info frame wants to ignore this
				lines[DBM:GetUnitFullName(uId)] = ""
			end
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerBuffStacks()
	twipe(lines)
	local spellInput = value[1]
	for uId in DBM:GetGroupMembers() do
		local spellName, _, count = DBM:UnitBuff(uId, spellInput)
		if spellName and count then
			lines[DBM:GetUnitFullName(uId)] = count
		end
	end
	updateIcons()
	updateLines()
end

local function updatePlayerDebuffStacks()
	twipe(lines)
	local spellInput = value[1]
	for uId in DBM:GetGroupMembers() do
		local spellName, _, count = DBM:UnitDebuff(uId, spellInput)
		if spellName and count then
			lines[DBM:GetUnitFullName(uId)] = count
		end
	end
	updateIcons()
	updateLines()
end

local function updatePlayerAggro()
	twipe(lines)
	local aggroType = value[1]
	local tankIgnored = value[2]
	for uId in DBM:GetGroupMembers() do
		if tankIgnored and (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1)) then
		else
			local currentThreat = UnitThreatSituation(uId) or 0
			if currentThreat >= aggroType then
				lines[DBM:GetUnitFullName(uId)] = ""
			end
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerTargets()
	twipe(lines)
	local cId = value[1]
	for uId, _ in DBM:GetGroupMembers() do
		if DBM:GetUnitCreatureId(uId .. "target") ~= cId and (UnitGroupRolesAssigned(uId) == "DAMAGER" or UnitGroupRolesAssigned(uId) == "NONE") then
			lines[DBM:GetUnitFullName(uId)] = ""
		end
	end
	updateLines()
	updateIcons()
end

local function updateByFunction()
	local func = value[1]
	local sortFunc = value[2]
	local useIcon = value[3]
	local presortedLines
	lines, presortedLines = func()
	if sortFunc then
		if type(sortFunc) == "function" then
			updateLinesCustomSort(sortFunc)
		else
			updateLines()
		end
	else
		updateLines(presortedLines)
	end
	if useIcon then
		updateIcons()
	end
end

-- Unsorted table maintained by mod and just sent here.
-- Never updated by onupdate method, requires manual updates when mod updates table
local function updateByTable(table)
	twipe(lines)
	if table then
		for i, v in pairs(table) do
			lines[i] = v
		end
	end
	updateLines()
	updateIcons()
end

local function updateTest()
	twipe(lines)
	lines["Alpha"] = 1
	lines["Beta"] = 10
	lines["Gamma"] = 25
	lines["Delta"] = 50
	lines["Epsilon"] = 100
	updateLines()
end

local test2Table
local function updateTest2()
	twipe(lines)
	if not test2Table then
		test2Table = {}
		for _ = 1, 40 do
			local ident = ""
			for _ = 1, mrandom(5, 12) do
				ident = ident .. schar(mrandom(65, 90))
			end
			test2Table[ident] = mrandom(1, 10) * 10
		end
	end
	for k, v in pairs(test2Table) do
		lines[k] = v
	end
	updateLines()
end

local test3Counter = 0
local function updateTest3()
	twipe(lines)
	if not test2Table then
		test2Table = {}
		for _ = 1, 40 do
			local ident = ""
			for _ = 1, mrandom(5, 12) do
				ident = ident .. schar(mrandom(65, 90))
			end
			test2Table[ident] = mrandom(1, 10) * 10
		end
	end
	if test3Counter < 40 then
		local count = 0
		for k, _ in pairs(test2Table) do
			if count > 40 - test3Counter then
				break
			end
			count = count + 1
			lines[k] = mrandom(1, 10) * 10
		end
		test3Counter = test3Counter + 1
	end
	updateLines()
end

local events = {
	["health"] = updateHealth,
	["playerpower"] = updatePlayerPower,
	["enemypower"] = updateEnemyPower,
	["enemyabsorb"] = updateEnemyAbsorb,
	["allabsorb"] = updateAllAbsorb,
	["playerabsorb"] = updatePlayerAbsorb,
	["playerbuff"] = updatePlayerBuffs,
	["playergooddebuff"] = updateGoodPlayerDebuffs,
	["playerbaddebuff"] = updateBadPlayerDebuffs,
	["playerdebuffremaining"] = updatePlayerDebuffRemaining,
	["playerbuffremaining"] = updatePlayerBuffRemaining,
	["reverseplayerbaddebuff"] = updateReverseBadPlayerDebuffs,
	["playeraggro"] = updatePlayerAggro,
	["playerbuffstacks"] = updatePlayerBuffStacks,
	["playerdebuffstacks"] = updatePlayerDebuffStacks,
	["playertargets"] = updatePlayerTargets,
	["function"] = updateByFunction,
	["table"] = updateByTable,
	["test"] = updateTest,
	["test2"] = updateTest2,
	["test3"] = updateTest3
}

----------------
--  OnUpdate  --
----------------
local friendlyEvents = {
	["health"] = true,
	["playerpower"] = true,
	["playerabsorb"] = true,
	["playerbuff"] = true,
	["playergooddebuff"] = true,
	["playerbaddebuff"] = true,
	["playerdebuffremaining"] = true,
	["playerbuffremaining"] = true,
	["reverseplayerbaddebuff"] = true,
	["playeraggro"] = true,
	["playerbuffstacks"] = true,
	["playerdebuffstacks"] = true,
	["playertargets"] = true
}

local function onUpdate(frame, table)
	if events[currentEvent] then
		events[currentEvent](table)
	else
		if frame then
			frame:Hide()
		end
	end
	local color = NORMAL_FONT_COLOR
	infoFrame:ClearLines()
	local linesShown = 0
	for i = 1, #sortedLines do
		if linesShown >= maxLines * maxCols then
			break
		end
		local leftText = sortedLines[i]
		if not leftText then
			error("DBM InfoFrame: leftText cannot be nil, Notify DBM author. Infoframe force shutting down ", 2)
			frame:Hide()
			return
		elseif leftText and type(leftText) ~= "string" then
			tostring(leftText)
		end
		local rightText = lines[leftText]
		local extra, extraName = ssplit("*", leftText) -- Find just unit name, if extra info had to be added to make unique
		local icon = icons[extraName or leftText] and icons[extraName or leftText] .. leftText
		if friendlyEvents[currentEvent] then
			local unitId = DBM:GetRaidUnitId(DBM:GetUnitFullName(extraName or leftText)) or "player"--Prevent nil logical error
			if unitId and select(4, UnitPosition(unitId)) == currentMapId then
				local _, class = UnitClass(unitId)
				if class then
					color = RAID_CLASS_COLORS[class]
					if DBM.Options.StripServerName then -- StripServerName option is checked here, even though it's checked in GetShortServerName function, because we have to apply custom 3rd column hack reconstruction
						local shortName = DBM:GetShortServerName(extraName or leftText)
						if extraName then -- 3 column hack is present, we need to reconstruct leftText with shortened name
							leftText = extra.."*"..shortName
						else -- LeftText is name, just replace it with shortname
							leftText = shortName
						end
					end
				end
				linesShown = linesShown + 1
				if unitId and UnitIsUnit(unitId, "player") then -- It's player.
					if currentEvent == "health" or currentEvent == "playerpower" or currentEvent == "playerabsorb" or currentEvent == "playerbuff" or currentEvent == "playergooddebuff" or currentEvent == "playerbaddebuff" or currentEvent == "playerdebuffremaining" or currentEvent == "playerdebuffstacks" or currentEvent == "playerbuffremaining" or currentEvent == "playertargets" or currentEvent == "playeraggro" then--Red
						infoFrame:SetLine(linesShown, icon or leftText, rightText, 255, 0, 0, 255, 255, 255)
					else -- Green
						infoFrame:SetLine(linesShown, icon or leftText, rightText, 0, 255, 0, 255, 255, 255)
					end
				else -- It's not player, do nothing special with it. Ordinary class colored text.
					if currentEvent == "playerdebuffremaining" or currentEvent == "playerbuffremaining" then
						local numberValue = tonumber(rightText)
						if numberValue < 6 then
							infoFrame:SetLine(linesShown, icon or leftText, rightText, color.r, color.g, color.b, 255, 0, 0)--Red
						elseif numberValue < 11 then
							infoFrame:SetLine(linesShown, icon or leftText, rightText, color.r, color.g, color.b, 255, 127.5, 0)--Orange
						else
							if numberValue == 9000 then -- Out of range players
								infoFrame:SetLine(linesShown, icon or leftText, SPELL_FAILED_OUT_OF_RANGE, color.r, color.g, color.b, 255, 0, 0)--Red
							else
								infoFrame:SetLine(linesShown, icon or leftText, rightText, color.r, color.g, color.b, 255, 255, 255)--White
							end
						end
					else
						infoFrame:SetLine(linesShown, icon or leftText, rightText, color.r, color.g, color.b, 255, 255, 255)
					end
				end
			end
		else
			local color2 = NORMAL_FONT_COLOR -- Only custom into frames will have chance of putting player names on right side
			local unitId = DBM:GetRaidUnitId(DBM:GetUnitFullName(extraName or leftText))
			local unitId2 = DBM:GetRaidUnitId(DBM:GetUnitFullName(rightText))
			-- Class color names in custom functions too, IF unitID exists
			if unitId then -- Check left text
				local _, class = UnitClass(unitId)
				if class then
					color = RAID_CLASS_COLORS[class]
					if DBM.Options.StripServerName then--StripServerName option is checked here, even though it's checked in GetShortServerName function, because we have to apply custom 3rd column hack reconstruction
						local shortName = DBM:GetShortServerName(extraName or leftText)
						if extraName then -- 3 column hack is present, we need to reconstruct leftText with shortened name
							leftText = extra.."*"..shortName
						else -- LeftText is name, just replace it with shortname
							leftText = shortName
						end
					end
				end
			else
				color = NORMAL_FONT_COLOR
			end
			if unitId2 then -- Check right text
				local _, class = UnitClass(unitId2)
				if class then
					color2 = RAID_CLASS_COLORS[class]
					rightText = DBM:GetShortServerName(rightText)
				end
			end
			linesShown = linesShown + 1
			infoFrame:SetLine(linesShown, icon or leftText, rightText, color.r, color.g, color.b, color2.r, color2.g, color2.b)
		end
	end
	local maxWidth1, maxWidth2 = {}, {}
	local linesPerRow = mmin(maxLines, mfloor(linesShown / maxCols + 0.99))
	local shouldUpdate = prevLines ~= linesShown
	for i = 1, linesShown do
		if shouldUpdate then
			infoFrame:AlignLine(i * 2 - 1, linesPerRow * 2)
			infoFrame:AlignLine(i * 2, linesPerRow * 2)
		end
		local m = mfloor(i / linesPerRow + 0.99)
		frame.lines[i * 2 - 1]:SetWidth(0) -- Hack here, because the string width doesn't calculate properly.
		frame.lines[i * 2]:SetWidth(0)
		maxWidth1[m] = mmax(maxWidth1[m] or 0, frame.lines[i * 2 - 1]:GetStringWidth())
		maxWidth2[m] = mmax(maxWidth2[m] or 0, frame.lines[i * 2]:GetStringWidth())
	end
	local width = 0
	for i, _ in pairs(maxWidth1) do
		local maxWid, maxWid2 = maxWidth1[i], maxWidth2[i]
		width = width + maxWid + maxWid2 + 18
		for ii = 1, linesPerRow do
			local m = ((i - 1) * linesPerRow * 2) + (ii * 2)
			if not frame.lines[m] then
				break
			end
			frame.lines[m - 1]:SetSize(maxWid, 12)
			frame.lines[m]:SetSize(maxWid2, 12)
		end
	end
	if width == 0 then
		width = 105
	end
	frame:SetSize(width, (linesPerRow * 12) + 12)
	frame:Show()
	prevLines = linesShown
end

---------------
--  Methods  --
---------------
--Arg 1: spellName, health/powervalue, customfunction, table type. Arg 2: TankIgnore, Powertype, SortFunction, totalAbsorb, sortmethod (table/stacks). Arg 3: SpellFilter, UseIcon. Arg 4: disable onUpdate. Arg 5: sortmethod (playerpower)
function infoFrame:Show(modMaxLines, event, ...)
	if DBM.Options.DontShowInfoFrame and not (event or ""):find("test") then
		error("Invalid event: " .. event or "nil")
		return
	end
	prevLines = 0
	currentMapId = select(4, UnitPosition("player"))
	modLines = modMaxLines
	if DBM.Options.InfoFrameLines and DBM.Options.InfoFrameLines ~= 0 then
		maxLines = DBM.Options.InfoFrameLines
	else
		maxLines = modMaxLines or 5
	end
	if DBM.Options.InfoFrameCols and DBM.Options.InfoFrameCols ~= 0 then
		maxCols = DBM.Options.InfoFrameCols
	else
		-- TODO, still needs more finite control via gui later on
		-- I think dynamic options modMaxLines/10 modMaxLines/5 are both valid options, as well as just capping at 2 >= 10
		maxCols = modMaxLines and modMaxLines >= 10 and 2 or 1
	end
	twipe(value)
	for i = 1, select("#", ...) do
		value[i] = select(i, ...)
	end
	if not frame then
		createFrame()
	end
	-- Orders event to use spellID no matter what and not spell name
	if event:find("byspellid") then
		event = event:gsub("byspellid", "") -- Strip off the byspellid, it served it's purpose, it simply told infoframe to not convert to spellName
		if type(value[1]) ~= "number" then
			error("DBM-InfoFrame: byspellid method must use spellId", 2)
			return
		end
	-- If spellId is given as value one and it's not a byspellid event, convert to spellname
	-- This also allows spell name to be given by mod, since value 1 verifies it's a number
	elseif type(value[1]) == "number" and event ~= "health" and event ~= "function" and event ~= "table" and event ~= "playertargets" and event ~= "playeraggro" and event ~= "playerpower" and event ~= "enemypower" and event ~= "test" and event ~= "test2" then
		-- Outside of "byspellid" functions, typical frames will still use spell NAME matching not spellID.
		-- This just determines if we convert the spell input to a spell Name, if a spellId was provided for a non byspellid infoframe
		value[1] = DBM:GetSpellInfo(value[1])
	end
	currentEvent = event
	if event == "playerbuff" or event == "playerbaddebuff" or event == "playergooddebuff" then
		sortMethod = 3 -- Sort by group ID
	elseif event == "health" or event == "playerdebuffremaining" then
		sortMethod = 2 -- Sort lowest first
	elseif (event == "playerdebuffstacks" or event == "table") and value[2] and type(value[2]) == "number" then
		sortMethod = value[2]
	elseif event == "playerpower" and value[5] and type(value[5]) == "number" then
		sortMethod = value[5]
	else
		sortMethod = 1 -- Sort highest first
	end
	if events[currentEvent] then
		events[currentEvent](value[1])
	else
		error("DBM-InfoFrame: Unsupported event", 2)
		return
	end
	if not friendlyEvents[currentEvent] then
		twipe(icons)
	end
	frame:Show()
	onUpdate(frame, value[1])
	if not frame.ticker and not value[4] and event ~= "table" then
		frame.ticker = C_Timer.NewTicker(0.5, function()
			onUpdate(frame)
		end)
	elseif frame.ticker and value[4] then -- Redundancy, in event calling a non onupdate infoframe show without a hide event to unschedule ticker based infoframe
		frame.ticker:Cancel()
		frame.ticker = nil
	end
end

function infoFrame:RegisterCallback(cb)
	updateCallbacks[#updateCallbacks + 1] = cb
end

function infoFrame:Update(time)
	if not frame then
		createFrame()
	end
	if frame:IsShown() then
		if time then
			CAfter(time, function()
				onUpdate(frame)
			end)
		else
			onUpdate(frame)
		end
	end
end

function infoFrame:UpdateTable(table)
	if not frame then
		createFrame()
	end
	if frame:IsShown() and table then
		onUpdate(frame, table)
	end
end

function infoFrame:SetHeader(text)
	if not frame then
		createFrame()
	end
	frame.header:SetText(text or "DBM Info Frame")
end

function infoFrame:ClearLines()
	if not frame then
		createFrame()
	end
	for i = 1, #frame.lines do
		frame.lines[i]:SetText("")
		frame.lines[i]:Hide()
	end
end

function infoFrame:AlignLine(lineNum, linesPerRow)
	local line = frame.lines[lineNum]
	line:SetJustifyH(lineNum % 2 == 0 and "RIGHT" or "LEFT")
	if lineNum == 1 then -- 1st entry left
		line:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -6)
	elseif lineNum == 2 then -- 1st entry right
		line:SetPoint("TOPLEFT", frame.lines[1], "TOPRIGHT", 6, 0)
	else
		if lineNum % linesPerRow == 1 then -- Column 2-x, 1st entry left
			line:SetPoint("TOPLEFT", frame.lines[lineNum - linesPerRow + 1], "TOPRIGHT", 12, 0)
		elseif lineNum % 2 == 0 then -- Column 2-x, Right entry
			line:SetPoint("TOPLEFT", frame.lines[lineNum - 1], "TOPRIGHT", 6, 0)
		else -- Column 2-x, Left entry
			line:SetPoint("TOPLEFT", frame.lines[lineNum - 2], "LEFT", 0, -6)
		end
	end
end

function infoFrame:SetLine(lineNum, leftText, rightText, colorR, colorG, colorB, color2R, color2G, color2B)
	if not frame then
		createFrame()
	end
	lineNum = lineNum * 2 - 1
	if not frame.lines[lineNum] then
		frame.lines[lineNum] = frame:CreateFontString("Line" .. lineNum, "OVERLAY", "GameFontNormal")
		frame.lines[lineNum + 1] = frame:CreateFontString("Line" .. lineNum + 1, "OVERLAY", "GameFontNormal")
	end
	frame.lines[lineNum]:SetText(leftText)
	frame.lines[lineNum]:SetTextColor(colorR or 255, colorG or 255, colorB or 255)
	frame.lines[lineNum]:Show()
	frame.lines[lineNum + 1]:SetText(rightText)
	frame.lines[lineNum + 1]:SetTextColor(color2R or 255, color2G or 255, color2B or 255)
	frame.lines[lineNum + 1]:Show()
end

function infoFrame:Hide()
	twipe(lines)
	twipe(icons)
	twipe(sortedLines)
	twipe(updateCallbacks)
	infoFrame:SetHeader()
	twipe(value)
	if frame then
		if frame.ticker then
			frame.ticker:Cancel()
			frame.ticker = nil
		end
		frame:Hide()
	end
	currentEvent = nil
	sortMethod = 1
end

function infoFrame:SetLines(lines)
	modLines = lines
end

function infoFrame:SetColumns(columns)
	modCols = columns
end

function infoFrame:IsShown()
	return frame and frame:IsShown()
end

function infoFrame:SetSortingAsc()
	sortMethod = 2
end

function infoFrame:SetSortingGroupId()
	sortMethod = 3
end
