---@class DBMCoreNamespace
local private = select(2, ...)

local isRetail = private.isRetail

---@class DevToolsModule: DBMModule
local module = private:NewModule("DevToolsModule")

---@class DBM
local DBM = private:GetPrototype("DBM")

local appendToDebugLog, showDebugLog, hideDebugLog
local debugLogFightStartTime

function module:OnModuleLoad()
	self:OnDebugToggle()
end

local mfloor, mmax = math.floor, math.max
local sformat = string.format

do
	local debugLogFrame, debugLogViewport, clearButton
	local debugLogLineFrames = {}
	local debugLogEntries = {}
	local maxDebugLogEntries = 1500
	local debugLogSoftClosed = true
	local lineHeight = 14
	local bottomSafetyLines = 1
	local debugLogLineCount = 0
	local debugLogStartIndex = 1
	local debugLogTopVisibleLine = 1
	local debugLogNormalPoint, debugLogNormalRelativeTo, debugLogNormalX, debugLogNormalY
	local ensureLineFrame, getPhysicalIndex

	local function getVisibleLineCount()
		if not debugLogViewport then return 1 end
		-- Only count fully visible rows and reserve one blank row at the bottom so
		-- sequential screenshots cannot lose their final line to clipping or cropping.
		return mmax(1, mfloor(debugLogViewport:GetHeight() / lineHeight) - bottomSafetyLines)
	end

	local function getMaxTopVisibleLine()
		return mmax(1, debugLogLineCount - getVisibleLineCount() + 1)
	end

	local function clampTopVisibleLine()
		if debugLogTopVisibleLine < 1 then
			debugLogTopVisibleLine = 1
		end
		local maxTop = getMaxTopVisibleLine()
		if debugLogTopVisibleLine > maxTop then
			debugLogTopVisibleLine = maxTop
		end
	end

	local function getEntry(logicalIndex)
		if logicalIndex < 1 or logicalIndex > debugLogLineCount then return nil end
		return debugLogEntries[getPhysicalIndex(logicalIndex)]
	end

	local function updateVisibleLines()
		if not debugLogViewport then return end
		local visibleLineCount = getVisibleLineCount()
		for i = 1, visibleLineCount do
			local line = ensureLineFrame(i)
			local text = getEntry(debugLogTopVisibleLine + i - 1)
			if text then
				line:SetText(text)
				line:Show()
			else
				line:SetText("")
				line:Hide()
			end
		end
		if #debugLogLineFrames > visibleLineCount then
			for i = visibleLineCount + 1, #debugLogLineFrames do
				debugLogLineFrames[i]:SetText("")
				debugLogLineFrames[i]:Hide()
			end
		end
	end

	local function refreshDebugLog(scrollToBottom)
		if not debugLogViewport then return end
		if scrollToBottom then
			debugLogTopVisibleLine = getMaxTopVisibleLine()
		end
		clampTopVisibleLine()
		updateVisibleLines()
	end

	local function scrollDebugLogByLines(lineDelta)
		debugLogTopVisibleLine = debugLogTopVisibleLine + lineDelta
		refreshDebugLog(false)
	end

	local function scrollDebugLogByPage(pageDelta)
		-- Pages are contiguous: no repeated lines to trim from sequential screenshots.
		scrollDebugLogByLines(getVisibleLineCount() * pageDelta)
	end

	local function setDebugLogSoftClosed(softClosed)
		if not debugLogFrame then return end
		debugLogSoftClosed = softClosed
		if softClosed then
			-- Move off-screen to the right
			debugLogFrame:ClearAllPoints()
			debugLogFrame:SetPoint("LEFT", UIParent, "RIGHT", 5000, 0)
		else
			-- Restore to previous position
			debugLogFrame:ClearAllPoints()
			debugLogFrame:SetPoint(debugLogNormalPoint or "CENTER", debugLogNormalRelativeTo or UIParent, debugLogNormalPoint or "CENTER", debugLogNormalX or 0, debugLogNormalY or 0)
		end
	end

	ensureLineFrame = function(index)
		if debugLogLineFrames[index] then return debugLogLineFrames[index] end
		local line = debugLogViewport:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		line:SetJustifyH("LEFT")
		line:SetJustifyV("TOP")
		line:SetWordWrap(false)
		line:SetMaxLines(1)
		line:SetPoint("TOPLEFT", debugLogViewport, "TOPLEFT", 0, -((index - 1) * lineHeight))
		line:SetPoint("RIGHT", debugLogViewport, "RIGHT", 0, 0)
		debugLogLineFrames[index] = line
		return line
	end

	getPhysicalIndex = function(logicalIndex)
		return ((debugLogStartIndex + logicalIndex - 2) % maxDebugLogEntries) + 1
	end

	local function clearAllLines()
		debugLogLineCount = 0
		debugLogStartIndex = 1
		for i = 1, #debugLogEntries do
			debugLogEntries[i] = nil
		end
		for i = 1, #debugLogLineFrames do
			debugLogLineFrames[i]:SetText("")
			debugLogLineFrames[i]:Hide()
		end
	end

	local function createDebugLogFrame()
		---@class DBMDebugLogFrame: Frame, BackdropTemplate
		debugLogFrame = CreateFrame("Frame", "DBMDebugLogFrame", UIParent, "BackdropTemplate")
		debugLogFrame:Hide()
		debugLogFrame:SetFrameStrata("DIALOG")
		debugLogFrame.backdropInfo = {
			bgFile		= "Interface\\BUTTONS\\WHITE8X8",
			tile		= true,
			tileSize	= 16
		}
		debugLogFrame:ApplyBackdrop()
		debugLogFrame:SetPoint("CENTER")
		debugLogFrame:SetSize(1200, 808)
		debugLogFrame:SetBackdropColor(0, 0, 0, 1)
		debugLogFrame:SetClampedToScreen(false)
		-- Store the normal position for later restoration
		debugLogNormalPoint = "CENTER"
		debugLogNormalRelativeTo = UIParent
		debugLogNormalX = 0
		debugLogNormalY = 0
		debugLogFrame:SetMovable(true)
		debugLogFrame:SetToplevel(true)
		debugLogFrame:EnableMouse(true)
		debugLogFrame:RegisterForDrag("LeftButton")
		debugLogFrame:SetScript("OnDragStart", function(self)
			self:StartMoving()
		end)
		debugLogFrame:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing()
		end)

		local title = debugLogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		title:SetPoint("TOP", debugLogFrame, "TOP", 0, -12)
		title:SetText("DBM Debug Log")

		local closeButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelCloseButton")
		closeButton:SetPoint("TOPRIGHT", debugLogFrame, "TOPRIGHT", -5, -5)
		closeButton:SetScript("OnClick", function()
			hideDebugLog()
		end)

		clearButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelButtonTemplate")
		clearButton:SetPoint("BOTTOMRIGHT", debugLogFrame, "BOTTOMRIGHT", -12, 12)
		clearButton:SetSize(80, 22)
		clearButton:SetText("Clear")
		clearButton:SetScript("OnClick", function()
			clearAllLines()
			refreshDebugLog()
		end)

		debugLogViewport = CreateFrame("Frame", nil, debugLogFrame)
		debugLogViewport:SetPoint("TOPLEFT", debugLogFrame, "TOPLEFT", 12, -38)
		debugLogViewport:SetPoint("BOTTOMRIGHT", debugLogFrame, "BOTTOMRIGHT", -52, 42)
		debugLogViewport:SetClipsChildren(true)
		debugLogViewport:EnableMouseWheel(true)
		debugLogViewport:SetScript("OnMouseWheel", function(_, delta)
			if delta > 0 then
				debugLogTopVisibleLine = debugLogTopVisibleLine - 3
			else
				debugLogTopVisibleLine = debugLogTopVisibleLine + 3
			end
			refreshDebugLog(false)
		end)
		debugLogViewport:SetScript("OnSizeChanged", function()
			refreshDebugLog(false)
		end)

		local scrollUpButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelButtonTemplate")
		scrollUpButton:SetPoint("TOPRIGHT", debugLogFrame, "TOPRIGHT", -12, -40)
		scrollUpButton:SetSize(28, 20)
		scrollUpButton:SetText("^")
		scrollUpButton:SetScript("OnClick", function()
			scrollDebugLogByLines(-1)
		end)

		local scrollDownButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelButtonTemplate")
		scrollDownButton:SetPoint("TOPRIGHT", scrollUpButton, "BOTTOMRIGHT", 0, -4)
		scrollDownButton:SetSize(28, 20)
		scrollDownButton:SetText("v")
		scrollDownButton:SetScript("OnClick", function()
			scrollDebugLogByLines(1)
		end)

		local pageUpButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelButtonTemplate")
		pageUpButton:SetPoint("TOPRIGHT", scrollDownButton, "BOTTOMRIGHT", 0, -8)
		pageUpButton:SetSize(28, 20)
		pageUpButton:SetText("^^")
		pageUpButton:SetScript("OnClick", function()
			scrollDebugLogByPage(-1)
		end)

		local pageDownButton = CreateFrame("Button", nil, debugLogFrame, "UIPanelButtonTemplate")
		pageDownButton:SetPoint("TOPRIGHT", pageUpButton, "BOTTOMRIGHT", 0, -4)
		pageDownButton:SetSize(28, 20)
		pageDownButton:SetText("vv")
		pageDownButton:SetScript("OnClick", function()
			scrollDebugLogByPage(1)
		end)

		refreshDebugLog(true)
		setDebugLogSoftClosed(true)
	end

	--Debug Mode
	local function getFightTime()
		if not debugLogFightStartTime then return nil end
		return mfloor((GetTime() - debugLogFightStartTime) * 100 + 0.5) / 100
	end

	function private:StartDebugLogFight()
		debugLogFightStartTime = GetTime()
	end

	function private:EndDebugLogFight()
		debugLogFightStartTime = nil
	end

	function appendToDebugLog(text)
		local wasAtBottom = debugLogTopVisibleLine >= getMaxTopVisibleLine()
		local formattedText
		local time = getFightTime()
		if time then
			formattedText = sformat("%.2f: %s", time, text)
		else
			formattedText = text
		end
		if debugLogLineCount < maxDebugLogEntries then
			debugLogLineCount = debugLogLineCount + 1
			debugLogEntries[getPhysicalIndex(debugLogLineCount)] = formattedText
		else
			debugLogEntries[debugLogStartIndex] = formattedText
			debugLogStartIndex = (debugLogStartIndex % maxDebugLogEntries) + 1
			if debugLogTopVisibleLine > 1 then
				debugLogTopVisibleLine = debugLogTopVisibleLine - 1
			end
		end
		if debugLogFrame and debugLogFrame:IsShown() and not debugLogSoftClosed then
			refreshDebugLog(wasAtBottom)
		end
	end

	function showDebugLog()
		if not DBM.Options or not DBM.Options.DebugMode then return end
		if not debugLogFrame then
			createDebugLogFrame()
		end
		debugLogFrame:Show()
		setDebugLogSoftClosed(false)
		refreshDebugLog(true)
	end

	function hideDebugLog()
		if not debugLogFrame then return end
		if DBM.Options and DBM.Options.DebugMode then
			setDebugLogSoftClosed(true)
		else
			debugLogFrame:Hide()
		end
	end

	function DBM:ToggleDebugLog()
		if DBM.Options and not DBM.Options.DebugMode then return end
		if not debugLogFrame or debugLogSoftClosed then
			showDebugLog()
		else
			hideDebugLog()
		end
	end

	function module:UpdateDebugLogStateFromDebugMode()
		if not DBM.Options then return end
		if DBM.Options.DebugMode then
			if not debugLogFrame then
				createDebugLogFrame()
			end
			debugLogFrame:Show()
			setDebugLogSoftClosed(true)
		else
			if debugLogFrame then
				debugLogFrame:Hide()
			end
		end
	end
end

do
	local eventsRegistered = false
	local UnitName, UnitGUID, UnitExists, UnitIsVisible, UnitCanAttack, UnitIsFriend, UnitIsUnit = UnitName, UnitGUID, UnitExists, UnitIsVisible, UnitCanAttack, UnitIsFriend, UnitIsUnit
	local bossUnits = {
		"boss1", "boss2", "boss3", "boss4", "boss5",
		"boss6", "boss7", "boss8", "boss9", "boss10",
		"arena1", "arena2", "arena3", "arena4", "arena5",
	}
	function module:UNIT_TARGETABLE_CHANGED(uId)
		local inCombat = private.getInCombat()
		if #inCombat == 0 then return end
		DBM:Debug("|c00D8B4FEUTC|r fired for "..uId..": "..(UnitName(uId) or "?").." [CanAttack:"..tostring(UnitCanAttack("player", uId)).." IsFriend:"..tostring(UnitIsFriend("player", uId)).." Exists:"..tostring(UnitExists(uId)).." IsVisible:"..tostring(UnitIsVisible(uId)).."]", 3, nil, nil, true, true)
	end

	function module:UNIT_FLAGS(uId)
		if DBM.Options.DebugLevel < 2 then return end
		local inCombat = private.getInCombat()
		if #inCombat == 0 then return end
		DBM:Debug("|c00D8B4FEUF|r fired for "..uId..": "..(UnitName(uId) or "?").." [CanAttack:"..tostring(UnitCanAttack("player", uId)).." IsFriend:"..tostring(UnitIsFriend("player", uId)).." Exists:"..tostring(UnitExists(uId)).." IsVisible:"..tostring(UnitIsVisible(uId)).."]", 3, nil, nil, true, true)
	end

	function module:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		local inCombat = private.getInCombat()
		if #inCombat == 0 then return end
		local hasBossUnits = false
		for i = 1, #bossUnits do
			local unit = bossUnits[i]
			if UnitExists(unit) then
				hasBossUnits = true
				DBM:Debug("|c00D8B4FEIEEU|r fired for "..unit..": "..(UnitName(unit) or "?").." ("..(UnitGUID(unit) or "?")..") [CanAttack:"..tostring(UnitCanAttack("player", unit)).." IsFriend:"..tostring(UnitIsFriend("player", unit)).." Exists:"..tostring(UnitExists(unit)).." IsVisible:"..tostring(UnitIsVisible(unit)).."]", 3, nil, nil, true, true)
			end
		end
		if not hasBossUnits then
			DBM:Debug("|c00D8B4FEIEEU|r: no boss units found", 3, nil, nil, true, true)
		end
	end

	function module:UNIT_SPELLCAST_START(uId, _, spellId)
		if DBM.Options.DebugLevel < 3 then return end
		if uId == "target" and (UnitIsUnit("target", "boss1") or UnitIsUnit("target", "boss2") or UnitIsUnit("target", "boss3")) then return end
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("|c0069CCF0UNIT_SPELLCAST_START|r fired for "..uId..": "..UnitName(uId).."'s "..spellName.." ("..spellId..")", 4, nil, nil, true, true)
	end
	function module:UNIT_SPELLCAST_STOP(uId, _, spellId)
		if DBM.Options.DebugLevel < 3 then return end
		if uId == "target" and (UnitIsUnit("target", "boss1") or UnitIsUnit("target", "boss2") or UnitIsUnit("target", "boss3")) then return end
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("|c0069CCF0UNIT_SPELLCAST_STOP|r fired for "..uId..": "..UnitName(uId).."'s "..spellName.." ("..spellId..")", 4, nil, nil, true, true)
	end

	function module:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if DBM.Options.DebugLevel < 3 then return end
		if uId == "target" and (UnitIsUnit("target", "boss1") or UnitIsUnit("target", "boss2") or UnitIsUnit("target", "boss3")) then return end
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("|c0069CCF0UNIT_SPELLCAST_SUCCEEDED|r fired for "..uId..": "..UnitName(uId).."'s "..spellName.." ("..spellId..")", 4, nil, nil, true, true)
	end

	function module:UNIT_SPELLCAST_CHANNEL_START(uId, _, spellId)
		if DBM.Options.DebugLevel < 2 then return end
		if uId == "target" and (UnitIsUnit("target", "boss1") or UnitIsUnit("target", "boss2") or UnitIsUnit("target", "boss3")) then return end
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("|c0069CCF0UNIT_SPELLCAST_CHANNEL_START|r fired for "..uId..": "..UnitName(uId).."'s "..spellName.." ("..spellId..")", 3, nil, nil, true, true)
	end

	function module:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, spellId)
		if DBM.Options.DebugLevel < 2 then return end
		if uId == "target" and (UnitIsUnit("target", "boss1") or UnitIsUnit("target", "boss2") or UnitIsUnit("target", "boss3")) then return end
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("|c0069CCF0UNIT_SPELLCAST_CHANNEL_STOP|r fired for "..uId..": "..UnitName(uId).."'s "..spellName.." ("..spellId..")", 3, nil, nil, true, true)
	end

	--Spammy events that core doesn't otherwise need are now dynamically registered/unregistered based on whether or not user is actually debugging
	function module:OnDebugToggle()
		if DBM.Options.DebugMode then
			if eventsRegistered then
				self:UnregisterShortTermEvents()
				eventsRegistered = false
			end
			if isRetail then
				if DBM.Options.DebugLevel >= 3 then
					self:RegisterShortTermEvents(
						"UNIT_SPELLCAST_START boss1 boss2 boss3 boss4 boss5 target",
						"UNIT_SPELLCAST_STOP boss1 boss2 boss3 boss4 boss5 target",
						"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5 target",
						"UNIT_SPELLCAST_CHANNEL_START boss1 boss2 boss3 boss4 boss5 target",
						"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4 boss5 target",
						"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
						"UNIT_TARGETABLE_CHANGED",
						"UNIT_FLAGS boss1 boss2 boss3 boss4 boss5"
					)
					eventsRegistered = true
				elseif DBM.Options.DebugLevel >= 2 then
					self:RegisterShortTermEvents(
						"UNIT_SPELLCAST_CHANNEL_START boss1 boss2 boss3 boss4 boss5",--target omitted at level 2
						"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4 boss5",--target omitted at level 2
						"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
						"UNIT_TARGETABLE_CHANGED",
						"UNIT_FLAGS boss1 boss2 boss3 boss4 boss5"
					)
					eventsRegistered = true
				elseif DBM.Options.DebugLevel >= 1 then
					self:RegisterShortTermEvents(
						"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
						"UNIT_TARGETABLE_CHANGED"
					)
					eventsRegistered = true
				end
			else--No Boss unit Ids in classic, register backups
				if DBM.Options.DebugLevel >= 3 then
					self:RegisterShortTermEvents(
	--					"UNIT_SPELLCAST_START target focus",
						"UNIT_SPELLCAST_SUCCEEDED target focus",
	--					"UNIT_SPELLCAST_STOP target focus",
						"UNIT_TARGETABLE_CHANGED"
					)
					eventsRegistered = true
				elseif DBM.Options.DebugLevel >= 2 then
					self:RegisterShortTermEvents("UNIT_TARGETABLE_CHANGED")
					eventsRegistered = true
				end
			end
		elseif eventsRegistered then
			eventsRegistered = false
			self:UnregisterShortTermEvents()
		end
		self:UpdateDebugLogStateFromDebugMode()
	end

	function module:OnDebugLevelChanged()
		if not DBM.Options or not DBM.Options.DebugMode then return end
		self:OnDebugToggle()
	end

	---Utility function for debugging DBM and blizzard events
	---@param text string|number
	---@param level number? Level 1: non spammy events. Level 2: mildly spammy events. Level 3: very spammy events.
	---@param useSound boolean? Play 'ding' sound when displaying message
	---@param alwaysFireEvent boolean? Used specifically for transcriptor logging
	---@param isLogged boolean? Used specifically for events we want logged in the DBM Debug Log frame
	---@param combatFiltered boolean? Used specifically for events we want filtered by combat state
	function DBM:Debug(text, level, useSound, alwaysFireEvent, isLogged, combatFiltered)
		if isLogged and DBM.Options and DBM.Options.DebugMode then
			appendToDebugLog(text)
		end
		--Still fire debug callbacks for transcriptor even if user level debug is not enabled
		--Cap debug level to 2 for transcriptor unless user specifically specifies 3
		if (DBM.Options and DBM.Options.DebugLevel == 3) or (level or 1) < 3 or alwaysFireEvent then
			DBM:FireEvent("DBM_Debug", text, level)
		end
		if not DBM.Options or not DBM.Options.DebugMode then return end
		if combatFiltered and InCombatLockdown() then return end
		if (level or 1) <= DBM.Options.DebugLevel then
			local frame = _G[tostring(DBM.Options.ChatFrame)]
			frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
			frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
		end
		if DBM.Options.DebugSound and useSound then
			DBM:PlaySoundFile(567458)--"Ding"
		end
	end
end

do
	local EJ_SetDifficulty, EJ_GetEncounterInfoByIndex = EJ_SetDifficulty, EJ_GetEncounterInfoByIndex
	---Used to scan a range of instance IDs to find right one.
	---<br>Returns GetRealZoneText for entire range
	---@param low number?
	---@param peak number?
	---@param contains string?
	function DBM:FindDungeonMapIDs(low, peak, contains)
		local start = low or 1
		local range = peak or 4000
		DBM:AddMsg("-----------------")
		for i = start, range do
			local dungeon = GetRealZoneText(i)
			if dungeon and dungeon ~= "" then
				if not contains or contains and dungeon:find(contains) then
					DBM:AddMsg(i..": "..dungeon)
				end
			end
		end
	end

	---Used to scan a range of journal IDs to find right one.
	---<br>Returns EJ_GetInstanceInfo for entire range
	---@param low number?
	---@param peak number?
	---@param contains string?
	function DBM:FindInstanceIDs(low, peak, contains)
		local start = low or 1
		local range = peak or 3000
		DBM:AddMsg("-----------------")
		for i = start, range do
			local instance = EJ_GetInstanceInfo(i)
			if instance then
				if not contains or contains and instance:find(contains) then
					DBM:AddMsg(i..": "..instance)
				end
			end
		end
	end

	---Used to scan a range of instance queue IDs to find right one.
	---<br>Returns GetDungeonInfo for entire range
	---@param low number?
	---@param peak number?
	---@param contains string?
	function DBM:FindScenarioIDs(low, peak, contains)
		local start = low or 1
		local range = peak or 3000
		DBM:AddMsg("-----------------")
		for i = start, range do
			local instance = DBM:GetDungeonInfo(i)
			if instance and (not contains or contains and instance:find(contains)) then
				DBM:AddMsg(i..": "..instance)
			end
		end
	end

	--/run DBM:FindEncounterIDs(1192)--Shadowlands
	--/run DBM:FindEncounterIDs(1178, 23)--Dungeon Template (mythic difficulty)
	--/run DBM:FindEncounterIDs(237, 1)--Classic Dungeons need diff 1 specified
	--/run DBM:FindDungeonMapIDs(1, 500)--Find Classic Dungeon Map IDs
	--/run DBM:FindInstanceIDs(1, 300)--Find Classic Dungeon Journal IDs
	function DBM:FindEncounterIDs(instanceID, diff)
		if not instanceID then
			DBM:AddMsg("Error: Function requires instanceID be provided")
		end
		if not isRetail then
			DBM:AddMsg("Error: There is no Dungeon Journal in classic")
		end
		if not diff then diff = 14 end--Default to "normal" in 6.0+ if diff arg not given.
		EJ_SetDifficulty(diff)--Make sure it's set to right difficulty or it'll ignore mobs (ie ra-den if it's not set to heroic). Use user specified one as primary, with curernt zone difficulty as fallback
		DBM:AddMsg("-----------------")
		for i=1, 25 do
			local name, _, encounterID = EJ_GetEncounterInfoByIndex(i, instanceID)
			if name then
				DBM:AddMsg(encounterID..": "..name)
			end
		end
	end
end

-- Item range diagnostics are deliberately independent of the production range frame.
do
	local L = DBM_CORE_L
	local candidates, ranges, itemIDs
	local testFrame, activeTest, lastExport, lastContext
	local lastCandidates, distanceFrame, activeDistanceTest, lastDistanceExport
	local finishDistanceTest
	local cacheTimeout, requestBatchSize = 10, 40
	local distanceInterval, distanceTolerance = 0.1, 0.5

	-- Nominal ranges from LibRangeCheck-3.0 v38 FriendItems (MIT).
	-- Authors: mitch0, WoWUIDev Community. Preserve client-specific ranges and ordering.
	-- Tables are constructed only when the diagnostic is first invoked.
	local function getFriendItems()
		if private.isClassic or private.isForever then
			return {
				[5] = {1970, 8149, 15826, 16308, 16991, 17117, 20403, 22259, 208855, 209027, 209057, 213036, 221199, 225943},
				[10] = {17626, 17689, 21267, 23164, 226207, 226208, 226209, 226210, 226211, 226212, 226213, 226214},
				[15] = {1251, 2581, 3530, 3531, 6450, 6451, 8544, 8545, 14529, 14530, 19066, 19067, 19068, 19307, 20065, 20066, 20067, 20232, 20234, 20235, 20237, 20243, 20244, 23684, 232433},
				[20] = {
					12450, 12451, 12455, 12457, 12458, 12460, 17757, 21519, 219963, 219965, 219983, 219984, 219985, 219986, 219987, 219988, 219989, 219990, 219991, 219992,
					219993, 219994, 219995, 219996, 219997, 219998, 220053, 220054, 220055, 220056, 220057, 220058, 220059, 220060, 220061, 220062, 220063, 220064, 220065, 220066,
					220067, 220068, 220069, 220070, 220071, 220072, 220073, 220074, 220075, 220076, 220077, 220078, 220079, 220080, 220081, 220082, 220083, 220084, 220085, 220086,
					220087, 220088, 220089, 220090, 220091, 220092, 220093, 220094, 220095, 220096, 220097, 220098, 220099, 220100, 220101, 220102, 220103, 220104, 220105, 220106,
					220792, 223168, 223171, 224806, 224893, 231298, 231836, 232344
				},
				[25] = {13289},
				[30] = {
					954, 955, 1180, 1181, 1477, 1478, 1711, 1712, 1851, 1912, 2289, 2290, 2948, 3012, 3013, 4381, 4419, 4421, 4422, 4424, 4425, 4426, 4444, 5232, 5613, 6452,
					6453, 10305, 10306, 10307, 10308, 10309, 10310, 11563, 11564, 11567, 16892, 16893, 16895, 16896, 17202, 17310, 18637, 19440, 20908, 21038, 21713, 22200, 22206, 22218
				},
				[35] = {18904},
				[40] = {1713, 5205, 5323, 8346, 11562, 18640, 18662, 213349, 216500, 216503, 216517, 216607, 230280},
				[45] = {221316},
				[50] = {221315},
				[100] = {5418, 17162, 23715, 23718, 23719, 23721, 23722, 227685},
			}
		elseif private.isCata then
			return {
				[3] = {42732},
				[5] = {
					1970, 8149, 15826, 16991, 17117, 20403, 22259, 23485, 23659, 33310, 33342, 33563, 34954, 34973, 35116, 35401, 35736, 36771, 36786, 36956, 37187, 37202, 37568, 37576,
					38330, 38467, 38627, 38676, 38731, 40587, 45001, 45080, 49743, 49948, 50471, 50742, 50746, 52014, 52271, 52712, 53120, 56837, 58502, 58885, 58955, 58965, 61302, 63150,
					63427, 65667, 67232, 71978, 72110
				},
				[7] = {61323, 62899, 63350},
				[8] = {29052, 33278, 34368, 35943, 37932, 56821, 68678},
				[10] = {
					17626, 17689, 21267, 22896, 22962, 23164, 30656, 32321, 33418, 34083, 34250, 35293, 36859, 37307, 38697, 40551, 41988, 42164, 43059, 44576, 47033, 50131, 52709, 52819,
					53009, 54215, 54462, 54463, 56012, 56222, 58167, 58200, 58203, 60382, 60870, 62057, 62326, 62541, 64312, 67249, 68677, 68679, 68682, 69240
				},
				[15] = {
					1251, 2581, 3530, 3531, 6450, 6451, 8544, 8545, 14529, 14530, 19066, 19067, 19068, 19307, 20065, 20066, 20067, 20232, 20234, 20235, 20237, 20243, 20244, 21990, 21991,
					30651, 30652, 30653, 30654, 31129, 32907, 33621, 34721, 34722, 36764, 38573, 38640, 38641, 38643, 39268, 44646, 44959, 46722, 52481, 53049, 53050, 53051, 53101, 53104,
					53105, 54851, 56180, 56184, 58169, 58966, 58967, 63391, 64995
				},
				[20] = {
					17757, 21519, 22473, 23394, 23693, 29817, 29818, 30175, 32424, 33088, 34127, 34257, 34711, 34869, 36796, 36827, 36835, 36847, 37708, 39157, 39206, 39238, 39577, 39651,
					39664, 40397, 42624, 42894, 43206, 43315, 44817, 44975, 46363, 48104, 49202, 50053, 52044, 52073, 52484, 52566, 53107, 55141, 55158, 55230, 56798, 57920, 58177, 63079,
					63426, 67241, 68606, 68607, 71085
				},
				[25] = {13289, 31463, 32966, 34979, 46885, 56247},
				[30] = {
					954, 955, 1180, 1181, 1477, 1478, 1711, 1712, 1912, 2289, 2290, 3012, 3013, 4381, 4419, 4421, 4422, 4424, 4425, 4426, 4444, 5613, 6452, 6453, 10305, 10306, 10307,
					10308, 10309, 10310, 11567, 17202, 17310, 18637, 19440, 20908, 21713, 22200, 22206, 22218, 23337, 27498, 27499, 27500, 27501, 27502, 27503, 31437, 31828, 32680, 32960,
					33108, 33457, 33458, 33459, 33460, 33461, 33462, 33865, 34068, 34191, 34598, 34684, 35557, 36732, 37091, 37092, 37093, 37094, 37097, 37098, 38515, 40686, 40917, 42774,
					43463, 43464, 43465, 43466, 43467, 43468, 44414, 44653, 44731, 44915, 45073, 49138, 49199, 49219, 49882, 50163, 52710, 52715, 56069, 56227, 57172, 58935, 60861, 63303,
					63304, 63305, 63306, 63307, 63308, 64637, 69825
				},
				[35] = {16103, 18904, 24501, 35121, 41505, 44890, 49028, 56576},
				[40] = {
					1713, 5323, 8346, 11562, 18640, 18662, 24541, 31088, 33081, 33581, 34255, 34471, 34494, 37438, 38266, 38308, 38332, 39305, 39615, 40532, 44114, 44222, 44228, 44804,
					44812, 44832, 50354, 50430, 50726, 52490, 53794, 55165, 56136, 56169, 56463, 60490, 60808, 65162, 71627
				},
				[45] = {28369, 32698, 34691, 49647, 52059, 52833, 62794},
				[60] = {32825, 34111, 34121, 37877, 37887, 50851},
				[70] = {41265},
				[80] = {28131, 35278, 35506, 42769, 50031, 62775, 63092, 63104, 63393},
				[100] = {17162, 23715, 23718, 23719, 23721, 23722, 28025, 29877, 34151, 34152, 34153, 34154, 34155, 41058, 44212},
				[150] = {46954},
			}
		else -- Reference's shared Retail/TBC/Wrath/Mists list: cache availability is NOT assumed.
			return {
				[2] = {168948, 194718},
				[3] = {42732, 200469},
				[4] = {129055},
				[5] = {
					1970, 8149, 15826, 16991, 17117, 20403, 22259, 23485, 23659, 33310, 33342, 33563, 34954, 34973, 35116, 35401, 35736, 36771, 36786, 36956, 37187, 37202, 37568, 37576,
					38330, 38467, 38627, 38676, 38731, 40587, 45001, 45080, 49948, 50471, 50742, 50746, 52014, 52271, 52712, 53120, 56837, 58502, 58885, 58955, 58965, 61302, 63150, 63427,
					65667, 67232, 71978, 72110, 79021, 79057, 79102, 79819, 79932, 80302, 80590, 80591, 80592, 80593, 80594, 80595, 85215, 85216, 85217, 85219, 85267, 85268, 85269, 89197,
					89202, 89233, 89326, 89328, 89329, 89880, 91806, 114835, 120293, 133065, 136605, 137299, 139463, 142065, 142262, 143597, 143773, 150759, 151563, 151570, 151624, 152472,
					152630, 152971, 152995, 153049, 153112, 153496, 153513, 156518, 156532, 157771, 158678, 159470, 159782, 160045, 160429, 160433, 160559, 160561, 160571, 160585, 161247,
					162450, 162589, 163607, 163720, 163740, 166972, 166973, 167041, 168410, 169653, 172020, 173013, 173148, 174197, 174326, 177817, 180613, 181364, 183689, 183698, 183797,
					184622, 186445, 186448, 186695, 187504, 192467, 192795, 194052, 194434, 197805, 202874, 203731, 208124, 208738, 208985, 213539, 215145, 216687, 217159, 219385, 224799
				},
				[6] = {164766, 219525},
				[7] = {61323, 62899, 63350, 88589, 153249},
				[8] = {33278, 34368, 35943, 37932, 56821, 82311, 82787, 84242, 128776, 152730},
				[10] = {
					17626, 17689, 21267, 22962, 30656, 32321, 33418, 34083, 35293, 36859, 37307, 38697, 40551, 41988, 42164, 43059, 44576, 47033, 50131, 52709, 52819, 53009, 54215, 54462,
					54463, 56012, 56222, 58167, 58200, 58203, 60382, 60870, 62057, 62326, 62541, 64312, 67249, 68679, 69240, 78947, 79884, 80220, 81177, 82381, 90067, 106958, 106987, 107656,
					112321, 118418, 119440, 124100, 129190, 132877, 136386, 140314, 152278, 153537, 153565, 156549, 158190, 158907, 158908, 166701, 166784, 166785, 168053, 168811, 168891,
					169860, 169943, 169944, 170161, 172955, 173870, 174323, 175063, 184292, 184314, 187943, 191375, 191376, 191377, 193917, 202096, 202112, 202271, 202714, 205045, 207632,
					219469, 223322
				},
				[12] = {208068},
				[15] = {
					1251, 2581, 3530, 3531, 6450, 6451, 8544, 8545, 14529, 14530, 19066, 19067, 19068, 19307, 20065, 20066, 20067, 20232, 20234, 20235, 20237, 20243, 20244, 21990, 21991,
					30651, 30652, 30653, 30654, 31129, 32907, 33621, 34721, 34722, 36764, 38573, 39268, 44646, 44959, 46722, 52481, 53049, 53050, 53051, 53101, 53104, 53105, 54851, 56184,
					58169, 58966, 58967, 63391, 64995, 72985, 72986, 79027, 82829, 111603, 115475, 115497, 115533, 133940, 133942, 136653, 143636, 144228, 146971, 147445, 152395, 152613,
					158381, 158382, 158935, 161333, 165762, 165815, 173191, 173192, 173691, 179359, 179921, 179978, 179983, 186102, 186569, 189384, 193064, 194048, 194049, 194050, 197928,
					211943, 215133, 219322, 219323, 219324, 224194, 224440, 224441, 224442
				},
				[20] = {
					17757, 21519, 22473, 23394, 23693, 29817, 29818, 30175, 33088, 34127, 34257, 34711, 34869, 36796, 36827, 36835, 36847, 37708, 39157, 39206, 39238, 39577, 39651, 39664,
					40397, 42624, 42894, 43206, 43315, 44817, 44975, 46363, 48104, 49202, 52044, 52073, 52484, 52566, 53107, 55141, 55158, 55230, 56798, 57920, 58177, 63079, 63426, 67241,
					68606, 71085, 77475, 85884, 87558, 87763, 88487, 88587, 91902, 93180, 93751, 103786, 103789, 103795, 103797, 110508, 114967, 116172, 116810, 116811, 116812, 118414,
					118415, 118511, 124506, 127707, 128634, 128650, 130260, 134119, 134824, 134860, 142260, 142494, 142495, 142496, 142497, 143865, 147886, 151135, 151763, 151912, 152590,
					158174, 162140, 162631, 163172, 163516, 163517, 163518, 163520, 163521, 167071, 167091, 168122, 168525, 173534, 174749, 183105, 184505, 184506, 186094, 187708, 187816,
					187839, 188002, 188697, 189449, 189479, 189561, 189572, 189573, 191408, 191682, 191854, 191865, 192477, 192743, 194447, 202310, 202875, 203706, 205980, 208884, 211535,
					223312, 223316, 229413
				},
				[25] = {13289, 31463, 34979, 46885, 56247, 74771, 117013, 152983, 153012, 169308, 170540, 185775, 198088, 198478, 204274, 204808, 208846, 209349, 210010, 210011, 210199, 210881, 228996},
				[30] = {
					954, 955, 1180, 1181, 1477, 1478, 1711, 1712, 2289, 2290, 3012, 3013, 4381, 4419, 4421, 4422, 4424, 4425, 4426, 4444, 5613, 6452, 6453, 10305, 10306, 10307, 10308,
					10309, 10310, 11567, 17202, 17310, 18637, 19440, 21713, 22200, 22218, 23337, 27498, 27499, 27500, 27501, 27502, 27503, 31437, 31828, 32680, 32960, 33108, 33457, 33458,
					33459, 33460, 33461, 33462, 33865, 34068, 34191, 34598, 34684, 35557, 36732, 37091, 37092, 37093, 37094, 37097, 37098, 38515, 40686, 40917, 42774, 43463, 43464, 43465,
					43466, 43467, 43468, 44653, 44915, 45073, 49138, 49199, 49882, 50163, 52710, 52715, 56069, 56227, 57172, 58935, 60861, 63303, 63304, 63305, 63306, 63307, 63308, 64637,
					69825, 80337, 85231, 86589, 88580, 92019, 110490, 110492, 116648, 116651, 118179, 118181, 118182, 118183, 118184, 118185, 118283, 118284, 118285, 118286, 118287, 118288,
					118643, 119083, 128632, 128648, 136339, 138026, 138733, 139427, 143863, 147420, 153219, 156665, 156831, 158332, 160307, 160525, 166230, 166797, 168407, 168947, 169209,
					169446, 169673, 169674, 169675, 173358, 173693, 173888, 178873, 183944, 188692, 188693, 189454, 192471, 193736, 193757, 193892, 194122, 194712, 194731, 194733, 194734,
					194735, 194736, 194738, 194818, 200120, 202270, 204473, 205688, 206160, 210755, 210764, 210766, 210767, 212602, 215142, 215158, 218124, 223220, 224026, 225887
				},
				[35] = {18904, 24501, 35121, 41505, 44890, 49028, 56576, 151363, 180899, 193212},
				[38] = {140786},
				[40] = {
					1713, 5232, 5323, 8346, 11562, 18640, 18662, 31088, 33081, 33581, 34255, 34471, 34494, 37438, 38266, 38308, 38332, 39305, 39615, 40532, 44114, 44222, 44228, 44812,
					50354, 50430, 50726, 52490, 53794, 55165, 56136, 56169, 56463, 60490, 60808, 65162, 71627, 74612, 82468, 90883, 90888, 92965, 92980, 93668, 94525, 95763, 96135, 96507,
					96879, 104323, 104324, 110426, 110506, 114926, 116400, 116759, 118190, 118236, 119159, 128505, 128506, 128772, 132511, 133305, 133462, 133706, 133928, 133998, 133999,
					136927, 137462, 138884, 139333, 139882, 141005, 141306, 141411, 147882, 147883, 152574, 152996, 153182, 153483, 153571, 153675, 155567, 155569, 156528, 156649, 156868,
					158320, 159882, 160649, 163741, 165702, 167863, 167865, 168012, 169152, 169305, 169311, 169490, 173379, 174007, 174927, 175733, 178495, 178496, 178530, 180953, 181360,
					182653, 183599, 183808, 184017, 184313, 184841, 185720, 186421, 186474, 188761, 191044, 193678, 193826, 193856, 198047, 198081, 201815, 203714, 204343, 204388, 204714,
					207390, 211000, 217929, 219306, 225656
				},
				[45] = {28369, 32698, 34691, 49647, 52059, 52833, 62794, 88377, 207057, 207083},
				[46] = {219320},
				[50] = {110009, 116139, 147006, 147007, 151957, 151958, 160443, 160557, 161452, 165578, 182451, 184020, 184029, 207084, 212175},
				[55] = {74637},
				[60] = {32825, 34111, 34121, 37877, 37887, 50851, 127030, 153679, 156928, 169279},
				[70] = {41265, 202642},
				[80] = {35278, 35506, 42769, 50031, 62775, 63092, 63104, 63393, 152572, 152610, 159761, 168253, 185742, 194891},
				[90] = {133925},
				[100] = {41058, 44212, 83134, 109082, 160739, 161422, 200549, 202020, 210223, 222976},
				[120] = {160988, 168430, 169681, 211963},
				[150] = {46954, 153204, 192750},
				[200] = {75208, 86546, 89163, 152657},
			}
		end
	end

	local function initializeCandidates()
		if candidates then return end
		local nominalItems = getFriendItems()
		candidates, ranges, itemIDs = {}, {}, {}
		for nominal in pairs(nominalItems) do
			ranges[#ranges + 1] = nominal + 3 -- DBM player-hitbox convention, applied exactly once.
		end
		table.sort(ranges)
		local allSeen = {}
		for _, range in ipairs(ranges) do
			local list, seen = {}, {}
			for _, itemID in ipairs(nominalItems[range - 3]) do
				if not seen[itemID] then
					seen[itemID] = true
					list[#list + 1] = itemID
				end
				if not allSeen[itemID] then
					allSeen[itemID] = true
					itemIDs[#itemIDs + 1] = itemID
				end
			end
			candidates[range] = list
		end
	end

	local function unitContext(unit)
		if InCombatLockdown() or not UnitExists(unit) or not UnitIsVisible(unit) or UnitIsDeadOrGhost(unit) then return end
		if UnitIsUnit(unit, "player") then return "self" end
		local reaction = UnitCanAttack("player", unit) and "hostile" or UnitIsFriend("player", unit) and "friendly"
		if reaction then
			return reaction .. (UnitIsPlayer(unit) and "-player" or "-npc")
		end
	end

	local function stopTest()
		activeTest = nil
		if testFrame then
			testFrame:SetScript("OnUpdate", nil)
			testFrame:SetScript("OnEvent", nil)
			testFrame:UnregisterAllEvents()
		end
	end

	---Copy the latest completed diagnostic, without rerunning its checks.
	function DBM:ShowRangeTestResults()
		if not lastExport then
			self:AddMsg(L.RANGE_TEST_NODATA)
			return
		end
		self:ShowUpdateReminder(nil, nil, L.RANGE_TEST_HEADER:format(lastContext), lastExport, 200)
		return lastExport
	end

	local function finishTest(test)
		-- Select by candidate order, NEVER by the order item data arrived.
		local entries, passed, failed, incomplete = {}, 0, 0, 0
		local selected = {}
		for _, range in ipairs(ranges) do
			local nilCount, cacheFailures = 0, 0
			local winner, inRange
			for _, itemID in ipairs(candidates[range]) do
				if test.cache[itemID] == "cached" then
					local result = test.check(itemID, test.unit)
					-- Legacy global APIs can return 1/0; never mistake false/0 for failure.
					if result == true or result == false or result == 1 or result == 0 then
						winner, inRange = itemID, result == true or result == 1
						break
					end
					nilCount = nilCount + 1
				else
					cacheFailures = cacheFailures + 1
				end
			end
			if winner then
				passed = passed + 1
				local name = test.itemInfo(winner) or "?"
				selected[#selected + 1] = {range = range, itemID = winner, name = name, partial = cacheFailures > 0}
				DBM:AddMsg(L.RANGE_TEST_PASS:format(range, winner, name, tostring(inRange), cacheFailures > 0 and L.RANGE_TEST_PARTIAL or ""))
				entries[#entries + 1] = sformat("%d=%d,%s,%d,%d", range, winner, inRange and "T" or "F", nilCount, cacheFailures)
			elseif cacheFailures > 0 then
				incomplete = incomplete + 1
				DBM:AddMsg(L.RANGE_TEST_INCOMPLETE:format(range, nilCount, cacheFailures))
				entries[#entries + 1] = sformat("%d=INCOMPLETE,%d,%d", range, nilCount, cacheFailures)
			else
				failed = failed + 1
				DBM:AddMsg(L.RANGE_TEST_FAIL:format(range, nilCount, cacheFailures))
				entries[#entries + 1] = sformat("%d=FAIL,%d,0", range, nilCount)
			end
		end
		-- Schema v2 uses ^ for headers to avoid WoW pipe escapes in the copy dialog.
		-- adjustedRange=itemID,T/F,precedingNil,precedingCacheFailure;
		-- or adjustedRange=FAIL/INCOMPLETE,nilCount,cacheFailureCount. No unit identity.
		local version, build, _, interface = GetBuildInfo()
		lastContext = test.context
		lastCandidates = {context = test.context, items = selected}
		lastExport = sformat("DBMRangeTest:2^data=LRC38^version=%s^build=%s^toc=%s^project=%s^season=%s^context=%s^offset=3^%s",
			version, build, tostring(interface), tostring(WOW_PROJECT_ID), tostring(private.currentSeason or 0), test.context, table.concat(entries, ";"))
		stopTest()
		DBM:AddMsg(L.RANGE_TEST_DONE:format(passed, failed, incomplete))
		if test.export then DBM:ShowRangeTestResults() end
	end

	local function updateTest()
		local test = activeTest
		if not test then return end
		-- Combat guard runs before identity inspection; this is an out-of-combat diagnostic.
		if unitContext(test.unit) ~= test.context or UnitGUID(test.unit) ~= test.guid then
			stopTest()
			DBM:AddMsg(L.RANGE_TEST_ABORTED)
			return
		end
		local now = GetTime()
		local batchEnd = math.min(test.nextRequest + requestBatchSize - 1, #test.queue)
		for index = test.nextRequest, batchEnd do
			local itemID = test.queue[index]
			-- Set state BEFORE requesting: load events can be dispatched synchronously.
			test.cache[itemID] = now
			test.request(itemID)
		end
		test.nextRequest = batchEnd + 1
		local pending = test.nextRequest <= #test.queue
		for _, itemID in ipairs(itemIDs) do
			local requestedAt = test.cache[itemID]
			if type(requestedAt) == "number" then
				if test.cached(itemID) then
					test.cache[itemID] = "cached"
				elseif now - requestedAt >= cacheTimeout then
					test.cache[itemID] = "timeout"
				else
					pending = true
				end
			end
		end
		if not pending then finishTest(test) end
	end

	---Find the first usable item at every nominal+3 range on the selected unit.
	---Both in-range and out-of-range results PASS; cached nil does not.
	---/run DBM:TestRanges("target", true) -- print and copy; repeat on friendly/hostile units.
	---@param unit string? Defaults to target; no implicit self fallback.
	---@param export boolean? Open the copy dialog on completion.
	function DBM:TestRanges(unit, export)
		if activeDistanceTest then finishDistanceTest(true) end
		stopTest() -- A new call supersedes the previous run, even if the new unit is invalid.
		unit = unit or "target"
		local context = type(unit) == "string" and unitContext(unit)
		local guid = context and UnitGUID(unit)
		if not context or not guid then
			self:AddMsg(L.RANGE_TEST_INVALID)
			return
		end
		local check = C_Item and C_Item.IsItemInRange or IsItemInRange
		local itemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
		local cached = C_Item and C_Item.IsItemDataCachedByID
		local request = C_Item and C_Item.RequestLoadItemDataByID
		local cacheEvent = "ITEM_DATA_LOAD_RESULT"
		if not cached or not request then
			-- GetItemInfo requests uncached data on legacy clients; poll for its name.
			cached = itemInfo and function(itemID) return itemInfo(itemID) ~= nil end
			request = itemInfo
			cacheEvent = "GET_ITEM_INFO_RECEIVED"
		end
		if not check or not itemInfo or not cached or not request then
			self:AddMsg(L.RANGE_TEST_UNSUPPORTED)
			return
		end
		initializeCandidates()
		local test = {
			unit = unit, guid = guid, context = context, export = export,
			check = check, itemInfo = itemInfo, cached = cached, request = request,
			cache = {}, queue = {}, nextRequest = 1, elapsed = 0,
		}
		for _, itemID in ipairs(itemIDs) do
			if cached(itemID) then
				test.cache[itemID] = "cached"
			else
				test.cache[itemID] = "queued"
				test.queue[#test.queue + 1] = itemID
			end
		end
		activeTest = test
		if context == "self" then self:AddMsg(L.RANGE_TEST_SELF) end
		self:AddMsg(L.RANGE_TEST_READY:format(context, #test.queue))
		if not testFrame then testFrame = CreateFrame("Frame") end
		testFrame:SetScript("OnEvent", function(_, event, itemID, success)
			if not activeTest then return end
			if event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_ENTERING_WORLD" then
				stopTest()
				DBM:AddMsg(L.RANGE_TEST_ABORTED)
			elseif type(activeTest.cache[itemID]) == "number" and success == false then
				-- A failed load isn't evidence that the item's range check returns nil.
				activeTest.cache[itemID] = activeTest.cached(itemID) and "cached" or "failed"
			end
		end)
		testFrame:RegisterEvent(cacheEvent)
		testFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		testFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		testFrame:SetScript("OnUpdate", function(_, elapsed)
			if not activeTest then return end
			activeTest.elapsed = activeTest.elapsed + elapsed
			if activeTest.elapsed >= 0.1 then
				activeTest.elapsed = 0
				updateTest()
			end
		end)
		updateTest() -- Warm caches complete immediately; cold caches start a bounded batch.
	end

	local function measuredDistance(unit)
		if not UnitDistanceSquared then return end
		local squared, checked = UnitDistanceSquared(unit)
		-- Never compare or calculate with protected/unavailable API payloads.
		if issecretvalue and (issecretvalue(squared) or issecretvalue(checked)) then return end
		if (checked ~= true and checked ~= 1) or type(squared) ~= "number" or squared ~= squared or squared < 0 or squared == math.huge then return end
		return squared ^ 0.5 -- Convert to yards; expected ranges already include +3.
	end

	local function distanceText(value)
		return value and sformat("%.2f", value) or "?"
	end

	---Copy the latest stopped calibration without rerunning it.
	function DBM:ShowRangeDistanceResults()
		if not lastDistanceExport then
			self:AddMsg(L.RANGE_DISTANCE_NODATA)
			return
		end
		self:ShowUpdateReminder(nil, nil, L.RANGE_DISTANCE_HEADER, lastDistanceExport, 200)
		return lastDistanceExport
	end

	finishDistanceTest = function(aborted)
		local test = activeDistanceTest
		if not test then return end
		activeDistanceTest = nil
		distanceFrame:SetScript("OnUpdate", nil)
		distanceFrame:SetScript("OnEvent", nil)
		distanceFrame:UnregisterAllEvents()
		if aborted then DBM:AddMsg(L.RANGE_DISTANCE_ABORTED) end
		local entries, passed, failed, incomplete = {}, 0, 0, 0
		for _, item in ipairs(test.items) do
			local lower, upper = item.range - distanceTolerance, item.range + distanceTolerance
			local contradictory = item.maxTrue and item.minFalse and item.maxTrue > item.minFalse
			local status
			if item.mismatches > 0 then
				status = "FAIL"
				failed = failed + 1
			elseif not aborted and item.missing == 0 and not contradictory and item.maxTrue and item.minFalse
				and item.maxTrue >= lower and item.maxTrue <= upper and item.minFalse >= lower and item.minFalse <= upper then
				status = "PASS"
				passed = passed + 1
			else
				status = "INCOMPLETE"
				incomplete = incomplete + 1
			end
			DBM:AddMsg(L.RANGE_DISTANCE_ROW:format(item.range, item.itemID, item.name, L["RANGE_DISTANCE_" .. status],
				distanceText(item.maxTrue), distanceText(item.minFalse), item.trueCount, item.falseCount, item.mismatches, item.missing,
				item.partial and L.RANGE_TEST_PARTIAL or ""))
			-- range=itemID,status,maxTrue,minFalse,trueCount,falseCount,mismatchCount,
			-- missingCount,worstDistance,worstResult,contradictory,partialDiscovery.
			entries[#entries + 1] = sformat("%d=%d,%s,%s,%s,%d,%d,%d,%d,%s,%s,%d,%d", item.range, item.itemID, status,
				distanceText(item.maxTrue), distanceText(item.minFalse), item.trueCount, item.falseCount, item.mismatches, item.missing,
				distanceText(item.worstDistance), item.worstResult or "?", contradictory and 1 or 0, item.partial and 1 or 0)
		end
		local version, build, _, interface = GetBuildInfo()
		lastDistanceExport = sformat("DBMRangeDistance:2^data=LRC38^version=%s^build=%s^toc=%s^project=%s^season=%s^discovery=%s^context=%s^offset=3^tolerance=0.5^interval=0.1^run=%s^%s",
			version, build, tostring(interface), tostring(WOW_PROJECT_ID), tostring(private.currentSeason or 0), test.discoveryContext, test.context,
			aborted and "ABORTED" or "STOPPED", table.concat(entries, ";"))
		DBM:AddMsg(L.RANGE_DISTANCE_DONE:format(passed, failed, incomplete))
	end

	local function sampleDistances()
		local test = activeDistanceTest
		if not test then return end
		-- Restrictions/combat are checked before identity inspection or distance arithmetic.
		if InCombatLockdown() or DBM:HasMapRestrictions() then
			finishDistanceTest(true)
			return
		end
		if not UnitExists(test.unit) then
			if not test.needsTarget then
				test.needsTarget = true
				DBM:AddMsg(L.RANGE_DISTANCE_REACQUIRE)
			end
			return
		end
		test.needsTarget = nil
		if unitContext(test.unit) ~= test.context or UnitGUID(test.unit) ~= test.guid then
			finishDistanceTest(true)
			return
		end
		local distance = measuredDistance(test.unit)
		if not distance then
			DBM:AddMsg(L.RANGE_DISTANCE_UNAVAILABLE)
			finishDistanceTest(true)
			return
		end
		for _, item in ipairs(test.items) do
			local result = test.check(item.itemID, test.unit)
			if not (issecretvalue and issecretvalue(result)) and (result == true or result == false or result == 1 or result == 0) then
				local inRange = result == true or result == 1
				if inRange then
					item.trueCount = item.trueCount + 1
					item.maxTrue = math.max(item.maxTrue or distance, distance)
				else
					item.falseCount = item.falseCount + 1
					item.minFalse = math.min(item.minFalse or distance, distance)
				end
				local errorDistance = inRange and distance - item.range or item.range - distance
				if errorDistance > distanceTolerance then
					item.mismatches = item.mismatches + 1
					if errorDistance > item.worstError then
						item.worstError, item.worstDistance, item.worstResult = errorDistance, distance, inRange and "T" or "F"
					end
				end
			else
				item.missing = item.missing + 1 -- Unavailable is never an out-of-range result.
			end
		end
	end

	---Continuously measure the latest TestRanges winners while moving around a stationary unit.
	---/run DBM:TestRangeDistances("target") -- outdoors with a party/raid player recommended.
	---@param unit string? Defaults to target; requires checked UnitDistanceSquared readings.
	function DBM:TestRangeDistances(unit)
		if activeDistanceTest then finishDistanceTest(true) end
		stopTest()
		if not lastCandidates or #lastCandidates.items == 0 then
			self:AddMsg(L.RANGE_DISTANCE_NOCANDIDATES)
			return
		end
		self:UpdateMapRestrictions()
		unit = unit or "target"
		local context = type(unit) == "string" and not self:HasMapRestrictions() and unitContext(unit)
		if not context or context == "self" then
			self:AddMsg(L.RANGE_DISTANCE_INVALID)
			return
		end
		local guid = UnitGUID(unit)
		local check = C_Item and C_Item.IsItemInRange or IsItemInRange
		if not guid or not check or not measuredDistance(unit) then
			self:AddMsg(L.RANGE_DISTANCE_UNAVAILABLE)
			return
		end
		local test = {unit = unit, guid = guid, context = context, discoveryContext = lastCandidates.context, check = check, items = {}, elapsed = 0}
		for _, selected in ipairs(lastCandidates.items) do
			test.items[#test.items + 1] = {
				range = selected.range, itemID = selected.itemID, name = selected.name, partial = selected.partial,
				trueCount = 0, falseCount = 0, mismatches = 0, missing = 0, worstError = 0,
			}
		end
		activeDistanceTest = test
		if not distanceFrame then distanceFrame = CreateFrame("Frame") end
		distanceFrame:SetScript("OnEvent", function()
			finishDistanceTest(true) -- Combat or world loading; keep explicitly partial evidence.
		end)
		distanceFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		distanceFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		distanceFrame:SetScript("OnUpdate", function(_, elapsed)
			if activeDistanceTest ~= test then return end
			test.elapsed = test.elapsed + elapsed
			if test.elapsed >= distanceInterval then
				test.elapsed = test.elapsed % distanceInterval
				sampleDistances()
			end
		end)
		self:AddMsg(L.RANGE_DISTANCE_READY:format(#test.items))
		sampleDistances()
	end

	---Stop sampling and copy collected evidence, even while waiting for the original target.
	---/run DBM:StopRangeDistances(true)
	---@param export boolean? Open the copy dialog after stopping.
	function DBM:StopRangeDistances(export)
		if activeDistanceTest then
			local test = activeDistanceTest
			local aborted = InCombatLockdown() or self:HasMapRestrictions()
				or (UnitExists(test.unit) and (unitContext(test.unit) ~= test.context or UnitGUID(test.unit) ~= test.guid or not measuredDistance(test.unit)))
			finishDistanceTest(aborted)
		end
		if export and not InCombatLockdown() then self:ShowRangeDistanceResults() end
	end
end

--Taint the script that disables /run /dump, etc
--ScriptsDisallowedForBeta = function() return false end

--/run for i = 1, 100 do DBM:Debug("|cffffff00FILLING LOG WITH TRASH" .. i, 2, nil, nil, true) end
