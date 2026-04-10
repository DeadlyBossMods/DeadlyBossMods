---@class DBMCoreNamespace
local private = select(2, ...)

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

---@class DevToolsModule: DBMModule
local module = private:NewModule("DevToolsModule")

---@class DBM
local DBM = private:GetPrototype("DBM")

local appendToDebugLog, showDebugLog, hideDebugLog

function module:OnModuleLoad()
	self:OnDebugToggle()
end

local mfloor, mmax, mceil = math.floor, math.max, math.ceil

do
	local debugLogFrame, debugLogViewport, debugLogContent, clearButton
	local debugLogLineFrames = {}
	local maxDebugLogEntries = 1000
	local debugLogSoftClosed = true
	local lineHeight = 14
	local debugLogLineCount = 0
	local debugLogStartIndex = 1
	local debugLogTopVisibleLine = 1
	local debugLogNormalPoint, debugLogNormalRelativeTo, debugLogNormalX, debugLogNormalY

	local function getVisibleLineCount()
		if not debugLogViewport then return 1 end
		return mmax(1, mceil(debugLogViewport:GetHeight() / lineHeight))
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

	local function refreshDebugLog(scrollToBottom)
		if not debugLogViewport or not debugLogContent then return end
		if scrollToBottom then
			debugLogTopVisibleLine = getMaxTopVisibleLine()
		end
		clampTopVisibleLine()
		debugLogContent:SetHeight(mmax(debugLogViewport:GetHeight(), debugLogLineCount * lineHeight + 8))
		debugLogContent:ClearAllPoints()
		debugLogContent:SetPoint("TOPLEFT", debugLogViewport, "TOPLEFT", 0, ((debugLogTopVisibleLine - 1) * lineHeight))
	end

	local function scrollDebugLogByLines(lineDelta)
		debugLogTopVisibleLine = debugLogTopVisibleLine + lineDelta
		refreshDebugLog(false)
	end

	local function scrollDebugLogByPage(pageDelta)
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

	local function ensureLineFrame(index)
		if debugLogLineFrames[index] then return debugLogLineFrames[index] end
		local line = debugLogContent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		line:SetJustifyH("LEFT")
		line:SetJustifyV("TOP")
		line:SetWordWrap(false)
		line:SetMaxLines(1)
		debugLogLineFrames[index] = line
		return line
	end

	local function getPhysicalIndex(logicalIndex)
		return ((debugLogStartIndex + logicalIndex - 2) % maxDebugLogEntries) + 1
	end

	local function updateLineLayout()
		for logicalIndex = 1, debugLogLineCount do
			local physicalIndex = getPhysicalIndex(logicalIndex)
			local line = ensureLineFrame(physicalIndex)
			line:ClearAllPoints()
			line:SetPoint("TOPLEFT", debugLogContent, "TOPLEFT", 0, -((logicalIndex - 1) * lineHeight))
			line:SetPoint("RIGHT", debugLogContent, "RIGHT", 0, 0)
			line:Show()
		end
		if debugLogLineCount < maxDebugLogEntries then
			for i = debugLogLineCount + 1, #debugLogLineFrames do
				debugLogLineFrames[i]:SetText("")
				debugLogLineFrames[i]:Hide()
			end
		end
	end

	local function clearAllLines()
		debugLogLineCount = 0
		debugLogStartIndex = 1
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

		debugLogContent = CreateFrame("Frame", nil, debugLogViewport)
		debugLogContent:SetSize(1140, 1)

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

		updateLineLayout()
		refreshDebugLog(true)
		setDebugLogSoftClosed(true)
	end

	--Debug Mode
	local function getFightTime()
		local inCombat = private.getInCombat()
		if #inCombat > 0 then--At least one boss is engaged
			for i = #inCombat, 1, -1 do
				local mod = inCombat[i]
				if mod and mod.combatInfo then
					return mfloor(GetTime() - (mod.combatInfo.pull or 0) + 0.5)
				end
			end
		else
			return nil
		end
	end

	function appendToDebugLog(text)
		local wasAtBottom = debugLogTopVisibleLine >= getMaxTopVisibleLine()
		local line
		if debugLogLineCount < maxDebugLogEntries then
			debugLogLineCount = debugLogLineCount + 1
			line = ensureLineFrame(getPhysicalIndex(debugLogLineCount))
		else
			line = ensureLineFrame(debugLogStartIndex)
			debugLogStartIndex = (debugLogStartIndex % maxDebugLogEntries) + 1
			if debugLogTopVisibleLine > 1 then
				debugLogTopVisibleLine = debugLogTopVisibleLine - 1
			end
		end
		local time = getFightTime()
		if time then
			line:SetText(time..": "..text)
		else
			line:SetText(text)
		end
		line:Show()
		updateLineLayout()
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
	local UnitName, UnitExists = UnitName, UnitExists
	function module:UNIT_TARGETABLE_CHANGED(uId)
		local transcriptor = _G["Transcriptor"]
		if DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging()) then
			local active = UnitExists(uId) and "true" or "false"
			DBM:Debug("UNIT_TARGETABLE_CHANGED event fired for "..UnitName(uId)..". Active: "..active)
		end
	end

	function module:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		local spellName = DBM:GetSpellName(spellId)
		DBM:Debug("UNIT_SPELLCAST_SUCCEEDED fired: "..UnitName(uId).."'s "..spellName.."("..spellId..")", 3)
	end

	--Spammy events that core doesn't otherwise need are now dynamically registered/unregistered based on whether or not user is actually debugging
	function module:OnDebugToggle()
		if DBM.Options.DebugMode and not eventsRegistered then
			eventsRegistered = true
			if isRetail then
				self:RegisterShortTermEvents("UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5", "UNIT_TARGETABLE_CHANGED")
			else--No Boss unit Ids in classic, register backups
				self:RegisterShortTermEvents("UNIT_SPELLCAST_SUCCEEDED target focus", "UNIT_TARGETABLE_CHANGED")
			end
		elseif not DBM.Options.DebugMode and eventsRegistered then
			eventsRegistered = false
			self:UnregisterShortTermEvents()
		end
		self:UpdateDebugLogStateFromDebugMode()
	end

	---Utility function for debugging DBM and blizzard events
	---@param text string|number
	---@param level number? Level 1: non spammy events. Level 2: mildly spammy events. Level 3: very spammy events.
	---@param useSound boolean? Play 'ding' sound when displaying message
	---@param alwaysFireEvent boolean? Used specifically for transcriptor logging
	---@param isLogged boolean? Used specifically for events we want logged in the DBM Debug Log frame
	function DBM:Debug(text, level, useSound, alwaysFireEvent, isLogged)
		if isLogged and DBM.Options and DBM.Options.DebugMode then
			appendToDebugLog(text)
		end
		--Still fire debug callbacks for transcriptor even if user level debug is not enabled
		--Cap debug level to 2 for transcriptor unless user specifically specifies 3
		if (DBM.Options and DBM.Options.DebugLevel == 3) or (level or 1) < 3 or alwaysFireEvent then
			DBM:FireEvent("DBM_Debug", text, level)
		end
		if not DBM.Options or not DBM.Options.DebugMode then return end
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

--Taint the script that disables /run /dump, etc
--ScriptsDisallowedForBeta = function() return false end

--/run for i = 1, 100 do DBM:Debug("|cffffff00FILLING LOG WITH TRASH" .. i, 2, nil, nil, true) end
