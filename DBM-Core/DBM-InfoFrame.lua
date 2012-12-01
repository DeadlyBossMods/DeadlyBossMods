-- ********************************************
-- **             DBM Info Frame             **
-- **     http://www.deadlybossmods.com      **
-- ********************************************
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
local pIndex
local extraPIndex
local lowestFirst
local iconModifier
local headerText = "DBM Info Frame"	-- this is only used if DBM.InfoFrame:SetHeader(text) is not called before :Show()
local currentEvent
local sortingAsc
local lines = {}
local icons = {}
local sortedLines = {}
local lastStacks = {}

---------------------
--  Dropdown Menu  --
---------------------
-- todo: this dropdown menu is somewhat ugly and unflexible....
do
	local function toggleLocked()
		DBM.Options.InfoFrameLocked = not DBM.Options.InfoFrameLocked
	end
	local function toggleShowSelf()
		DBM.Options.InfoFrameShowSelf = not DBM.Options.InfoFrameShowSelf
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
			info.text = DBM_CORE_INFOFRAME_SHOW_SELF
			if DBM.Options.InfoFrameShowSelf then
				info.checked = true
			end
			info.func = toggleShowSelf
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

local function updateIcons()
	table.wipe(icons)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			local icon = GetRaidTargetIndex(uId)
			if icon then
				icons[UnitName(uId)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon)
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			local icon = GetRaidTargetIndex(uId)
			if icon then
				icons[UnitName(uId)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon)
			end
		end
		local icon = GetRaidTargetIndex("player")
		if icon then
			icons[UnitName("player")] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(icon)
		end
	end
end

local function updateHealth()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			local icon = GetRaidTargetIndex(uId)
			if UnitHealth(uId) < infoFrameThreshold and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = UnitHealth(uId) - infoFrameThreshold
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if UnitHealth(uId) < infoFrameThreshold and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = UnitHealth(uId) - infoFrameThreshold
			end
		end
		if UnitHealth("player") < infoFrameThreshold and not UnitIsDeadOrGhost("player") then
			lines[UnitName("player")] = UnitHealth("player") - infoFrameThreshold
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerPower()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if not UnitIsDeadOrGhost("raid"..i) and UnitPower("raid"..i, pIndex)/UnitPowerMax("raid"..i, pIndex)*100 >= infoFrameThreshold then
				lines[UnitName("raid"..i)] = UnitPower("raid"..i, pIndex)
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			if not UnitIsDeadOrGhost("party"..i) and UnitPower("party"..i, pIndex)/UnitPowerMax("party"..i, pIndex)*100 >= infoFrameThreshold then
				lines[UnitName("party"..i)] = UnitPower("party"..i, pIndex)
			end
		end
	end
	if DBM.Options.InfoFrameShowSelf and not lines[UnitName("player")] and UnitPower("player", pIndex) > 0 then
		lines[UnitName("player")] = UnitPower("player", pIndex)
	end
	updateLines()
	updateIcons()
end

local function updateEnemyPower()
	table.wipe(lines)
	for i = 1, 5 do
		if UnitPower("boss"..i, pIndex)/UnitPowerMax("boss"..i, pIndex)*100 >= infoFrameThreshold then
			lines[UnitName("boss"..i)] = UnitPower("boss"..i, pIndex)
		end
	end
	if extraPIndex then
		if UnitPower("player", extraPIndex) > 0 then
			lines[UnitName("player")] = UnitPower("player", extraPIndex)
		end
	end
	updateLines()
end

--Buffs that are good to have, therefor bad not to have them.
local function updatePlayerBuffs()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if not UnitBuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = ""
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if not UnitBuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = ""
			end
		end
		if not UnitBuff("player", GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost("player") then
			lines[UnitName("player")] = ""
		end
	end
	updateLines()
	updateIcons()
end

--Debuffs that are good to have, therefor it's bad NOT to have them.
local function updateGoodPlayerDebuffs()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if not UnitDebuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = ""
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if not UnitDebuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				local icon = GetRaidTargetIndex(uId)
				lines[UnitName(uId)] = ""
			end
		end
		if not UnitDebuff("player", GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost("player") then--"party"..i excludes player so manually add it in.
			lines[UnitName("player")] = ""
		end
	end
	updateLines()
	updateIcons()
end

--Debuffs that are bad to have, therefor it is bad to have them.
local function updateBadPlayerDebuffs()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if UnitDebuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = ""
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if  UnitDebuff(uId, GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost(uId) then
				local icon = GetRaidTargetIndex(uId)
				lines[UnitName(uId)] = ""
			end
		end
		if UnitDebuff("player", GetSpellInfo(infoFrameThreshold)) and not UnitIsDeadOrGhost("player") then--"party"..i excludes player so manually add it in.
			lines[UnitName("player")] = ""
		end
	end
	updateLines()
	updateIcons()
end

local function updatePlayerBuffStacks()
	table.wipe(lines)
	updateIcons()	-- update Icons first in case of an "icon modifier"
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if UnitBuff(uId, GetSpellInfo(infoFrameThreshold)) then
				lines[UnitName(uId)] = select(4, UnitBuff(uId, GetSpellInfo(infoFrameThreshold)))
			elseif UnitBuff(uId, GetSpellInfo(pIndex)) then
				lines[UnitName(uId)] = lastStacks[UnitName(uId)] or 0			-- is always 0 ?
				if iconModifier then
					icons[UnitName(uId)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(iconModifier)
				end
			end			
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if UnitBuff(uId, GetSpellInfo(infoFrameThreshold)) then
				lines[UnitName(uId)] = select(4, UnitBuff(uId, GetSpellInfo(infoFrameThreshold)))
			elseif UnitBuff(uId, GetSpellInfo(pIndex)) then
				lines[UnitName(uId)] = lastStacks[UnitName(uId)] or 0
				if iconModifier then
					icons[UnitName(uId)] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(iconModifier)
				end
			end
		end
		if UnitBuff("player", GetSpellInfo(infoFrameThreshold)) then
			lines[UnitName("player")] = select(4, UnitBuff("player", GetSpellInfo(infoFrameThreshold)))
		elseif UnitBuff("player", GetSpellInfo(pIndex)) then
			lines[UnitName("player")] = lastStacks[UnitName("player")]
			if iconModifier then
				icons[UnitName("player")] = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(iconModifier)
			end
		end
	end

	table.wipe(lastStacks)		-- 'Erase' the old table, and copy the current values into it
	for k,v in pairs(lines) do
		lastStacks[k] = v
	end

	updateLines()
end

local function updatePlayerAggro()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if UnitThreatSituation(uId) == infoFrameThreshold then
				lines[UnitName(uId)] = ""
			end
		end
		updateLines()
		updateIcons()
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if UnitThreatSituation(uId) == infoFrameThreshold then
				lines[UnitName(uId)] = ""
			end
		end
		if UnitThreatSituation("player") == infoFrameThreshold then--"party"..i excludes player so manually add it in.
			lines[UnitName("player")] = ""
		end
		updateLines()
		updateIcons()
	end
end

local function getUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return (guid and (tonumber(guid:sub(6, 10), 16))) or 0
end
local function updatePlayerTargets()
	table.wipe(lines)
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local uId = "raid"..i
			if getUnitCreatureId("raid"..i.."target") ~= infoFrameThreshold and (UnitGroupRolesAssigned("raid"..i) == "DAMAGER" or UnitGroupRolesAssigned("raid"..i) == "NONE") then
				lines[UnitName(uId)] = ""
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local uId = "party"..i
			if getUnitCreatureId("party"..i.."target") ~= infoFrameThreshold and (UnitGroupRolesAssigned("party"..i) == "DAMAGER" or UnitGroupRolesAssigned("party"..i) == "NONE") then
				lines[UnitName(uId)] = ""
			end
		end
		if getUnitCreatureId("target") ~= infoFrameThreshold and (UnitGroupRolesAssigned("player") == "DAMAGER" or UnitGroupRolesAssigned("player") == "NONE") then--"party"..i excludes player so manually add it in.
			lines[UnitName("player")] = ""
		end
	end
	updateLines()
	updateIcons()
end

----------------
--  OnUpdate  --
----------------
function onUpdate(self, elapsed)
	local addedSelf = false
	local color = NORMAL_FONT_COLOR
	self:ClearLines()
	if headerText then
		self:AddLine(headerText, 255, 255, 255, 0)
	end
	if currentEvent == "health" then
		updateHealth()
	elseif currentEvent == "playerpower" then
		updatePlayerPower()
	elseif currentEvent == "enemypower" then
		updateEnemyPower()
	elseif currentEvent == "playerbuff" then
		updatePlayerBuffs()
	elseif currentEvent == "playergooddebuff" then
		updateGoodPlayerDebuffs()
	elseif currentEvent == "playerbaddebuff" then
		updateBadPlayerDebuffs()
	elseif currentEvent == "playeraggro" then
		updatePlayerAggro()
	elseif currentEvent == "playerbuffstacks" then
		updatePlayerBuffStacks()
	elseif currentEvent == "playertargets" then
		updatePlayerTargets()
	end
--	updateIcons()
	for i = 1, math.min(#sortedLines, maxlines) do
		local name = sortedLines[i]
		local power = lines[name]
		local icon = icons[name]
		-- work-around for the player bug, "name" should actually be called "displayName" or something as it might contain the icon in addition to the name 
		-- so we need playerName if we just want the raw name
		local playerName = name
		if icon then
			name = icons[name]..name
		end
		if playerName == UnitName("player") then
			addedSelf = true
			if currentEvent == "playerbuff" or currentEvent == "playerbaddebuff" or currentEvent == "playergooddebuff" or currentEvent == "health" or currentEvent == "playertargets" or (currentEvent == "playeraggro" and infoFrameThreshold == 3) then--Player name on frame bad a thing make it red.
				self:AddDoubleLine(name, power, 255, 0, 0, 255, 255, 255)	-- (leftText, rightText, left.R, left.G, left.B, right.R, right.G, right.B)
			elseif currentEvent == "playerbuffstacks" or (currentEvent == "playeraggro" and infoFrameThreshold == 0) or currentEvent == "enemypower" then--Player name on frame is a good thing, make it green
				self:AddDoubleLine(name, power, 0, 255, 0, 255, 255, 255)	-- (leftText, rightText, left.R, left.G, left.B, right.R, right.G, right.B)
			else--it's not defined a color, so default to white.
				self:AddDoubleLine(name, power, color.R, color.G, color.B, 255, 255, 255)	-- (leftText, rightText, left.R, left.G, left.B, right.R, right.G, right.B)
			end
		else--It's not player, do nothing special with it. Ordinary white text.
			self:AddDoubleLine(name, power, color.R, color.G, color.B, 255, 255, 255)	-- (leftText, rightText, left.R, left.G, left.B, right.R, right.G, right.B)
		end
	end					 						-- Add a method to color the power value?
	if not addedSelf and DBM.Options.InfoFrameShowSelf and currentEvent == "playerpower" then 	-- Don't show self on health/enemypower/playerdebuff/playeraggro
		self:AddDoubleLine(UnitName("player"), lines[UnitName("player")], color.R, color.G, color.B, 255, 255, 255)
	end
	self:Show()
end


---------------
--  Methods  --
---------------
function infoFrame:Show(maxLines, event, threshold, ...)
	maxLines = maxLines or 5

	infoFrameThreshold = threshold
	maxlines = maxLines
	pIndex = select(1, ...)		-- used as 'filter' for player buff stacks
	iconModifier = select(2, ...)
	extraPIndex = select(3, ...)
	lowestFirst = select(4, ...)
	currentEvent = event
	frame = frame or createFrame()

	if lowestFirst then
		sortingAsc = true
	end
	if event == "health" then
		sortingAsc = true	-- Person who misses the most HP to be at threshold is listed on top
		updateHealth()
	elseif event == "playerpower" then
		updatePlayerPower()
	elseif event == "enemypower" then
		updateEnemyPower()
	elseif event == "playerbuff" then
		updatePlayerBuffs()
	elseif event == "playergooddebuff" then
		updateGoodPlayerDebuffs()
	elseif event == "playerbaddebuff" then
		updateBadPlayerDebuffs()
	elseif currentEvent == "playeraggro" then
		updatePlayerAggro()
	elseif currentEvent == "playerbuffstacks" then
		updatePlayerBuffStacks()
	elseif currentEvent == "playertargets" then
		updatePlayerTargets()
	elseif currentEvent == "test" then
	else		
		error("DBM-InfoFrame: Unsupported event", 2)
	end
	
	frame:Show()
	frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
	onUpdate(frame, 0)
end

function infoFrame:Hide()
	table.wipe(lines)
	table.wipe(sortedLines)
	headerText = "DBM Info Frame"
	sortingAsc = false
	infoFrameThreshold = nil
	pIndex = nil
	currentEvent = nil
	if frame then 
		frame:Hide()
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
