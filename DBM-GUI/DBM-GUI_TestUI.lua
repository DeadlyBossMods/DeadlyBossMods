local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

local test = DBM.Test

local tconcat = table.concat

local function runTest(test, perspective)
	local settings = { ---@type DBMTestOptions
		playground = true, -- Use real mod and DBM options
		allowErrors = true,
		allOnYou = perspective == "EverythingOnYou",
		perspective = perspective ~= DEFAULT and perspective
	}
	DBM.Test:RunTest(test, nil, settings)
end

local importTranscriptorFrame

local ephemeralTests = {}

local function showImportTranscriptorFrame()
	if importTranscriptorFrame then
		importTranscriptorFrame:Show()
		return
	end
	---@class DBMImportTranscriptorFrame: Frame, BackdropTemplate
	importTranscriptorFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	importTranscriptorFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	importTranscriptorFrame:SetFrameLevel(importTranscriptorFrame:GetFrameLevel() + 10)
	importTranscriptorFrame:SetSize(540, 190)
	importTranscriptorFrame:SetPoint("CENTER")
	importTranscriptorFrame.backdropInfo = {
		bgFile		= "Interface\\ChatFrame\\ChatFrameBackground", -- 130937
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 8, right = 8, top = 8, bottom = 8 }
	}
	importTranscriptorFrame:ApplyBackdrop()
	importTranscriptorFrame:SetBackdropColor(0, 0, 0, 1)
	importTranscriptorFrame:SetMovable(true)
	importTranscriptorFrame:EnableMouse(true)
	importTranscriptorFrame:RegisterForDrag("LeftButton")
	importTranscriptorFrame:SetScript("OnDragStart", importTranscriptorFrame.StartMoving)
	importTranscriptorFrame:SetScript("OnDragStop", importTranscriptorFrame.StopMovingOrSizing)
	local header = importTranscriptorFrame:CreateFontString(nil, nil, "GameFontNormal")
	header:SetWidth(540 - 32 - 32)
	header:SetHeight(0)
	header:SetPoint("TOP", 0, -16)
	header:SetText(L.ImportTranscriptorHeader)
	header:SetJustifyH("LEFT")

	---@class DBMPopupFrameBackdrop: Frame, BackdropTemplate
	local backdrop = CreateFrame("Frame", nil, importTranscriptorFrame, "BackdropTemplate")
	backdrop.backdropInfo = {
		bgFile		= "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border",
		tile		= true,
		tileSize	= 16,
		edgeSize	= 16,
		insets		= { left = 3, right = 3, top = 5, bottom = 3 }
	}
	backdrop:ApplyBackdrop()
	backdrop:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
	backdrop:SetBackdropBorderColor(0.4, 0.4, 0.4)
	local input = CreateFrame("EditBox", nil, importTranscriptorFrame)
	input:SetTextInsets(7, 7, 3, 3)
	input:SetFontObject(GameFontDisable)
	input:SetMultiLine(true)
	input:EnableMouse(true)
	input:SetAutoFocus(true)
	input:SetMaxBytes(100)
	input:SetPoint("TOPLEFT", header, "BOTTOMLEFT", -13, -10)
	input:SetWidth(360)
	input:SetHeight(28)
	input:SetScript("OnShow", function(self) self:Enable() self:SetFocus() self:SetCursorPosition(0) end)
	input:SetText(L.PasteLogHere)
	input:SetScript("OnEscapePressed", function(self)
		importTranscriptorFrame:Hide()
	end)
	backdrop:SetAllPoints(input)
	local logSelect
	local logs ---@type DBMTranscriptorParserLogInfo[]
	local buf = {}
	local pasteOffset1 = 1
	local pasteOffset2 = 1
	local function resetBuf()
		table.wipe(buf)
		pasteOffset1 = 1
		pasteOffset2 = 1
	end
	local pasteStart = GetTimePreciseSec()
	-- It looks like pasting into an edit box is extremely slow, it even seems slower than O(n), so it crashes your game even when working with trivial log sizes like hundreds of KiB.
	-- The only solution I could find was to limit the edit box size and piece the string together character by character.
	-- Other things I've tried that didn't work: setting an empty font, disabling all fancy text features like wrapping etc, making sure the font isn't shown/visible.
	-- This slow looking code manages to import a ~100 MiB log in ~50 seconds but only ~10 seconds of those are due to our code below, so not much that can be optimized.
	input:SetScript("OnChar", function(self, char)
		--local buf = buf -- Do not remove, this makes a measureable performance difference of ~2%
		local bufSize = 8192 -- Larger values don't increase performance
		buf[pasteOffset1] = char
		if pasteOffset1 == 1 and pasteOffset2 == 1 then
			pasteStart = GetTimePreciseSec()
		end
		-- This may look overly complicated, but:
		-- 1. a naive string concat is O(n^2) in space and doesn't work for large logs
		-- 2. Just using a very large array and concatenating once at the end is O(n) in space and time, but an array entry is 24 bytes,
		--    so it would use 2.4 GiB of memory for a 100 MiB log which works but isn't exactly great
		-- So we instead collect ~thousands of characters, concat them to get ~KiBs of strings, and then collect ~thousands of those and concat them to get ~MiBs of strings
		if pasteOffset1 == bufSize then
			buf[pasteOffset2] = tconcat(buf, "", pasteOffset2, #buf)
			if pasteOffset2 == bufSize / 2 then
				-- We are already at 32 MiB of data for 8 KiB buffers here, so no third layer is needed, just aggregate everything into the first field
				buf[1] = tconcat(buf, "", 1, pasteOffset2)
				pasteOffset1 = 2
				pasteOffset2 = 2
			else
				pasteOffset2 = pasteOffset2 + 1
				pasteOffset1 = pasteOffset2
			end
		else
			pasteOffset1 = pasteOffset1 + 1
		end
	end)
	local importLocalButton, createTestButton
	local function dropdownEntryFromLog(log, encounterOffset)
		if encounterOffset then
			local encounter = log.encounters[encounterOffset]
			local timestamp = date("%Y-%m-%d %H:%M:%d", log.timestamp + (encounter.startTime or 0))
			local name = ("%s: %s (%d) %s, %.0f seconds, %d log entries"):format(
				timestamp, encounter.name, encounter.id, encounter.success and "Kill" or "Wipe", encounter.endTime - encounter.startTime, encounter.endOffset - encounter.startOffset)
			return {
				value = {name = name, log = log, startOffset = encounter.startOffset, endOffset = encounter.endOffset},
				text = name
			}
		else
			local timestamp = date("%Y-%m-%d %H:%M:%d", log.timestamp)
			local name = ("%s: no encounters detected, %.0f seconds, %d log entries"):format(
				timestamp, log.endTime - log.startTime, #log.lines
			)
			return {
				value = {name = name, log = log, startOffset = 1, endOffset = #log.lines},
				text = name
			}
		end
	end
	local function importTranscriptor(text, callback)
		logSelect:SetSelectedValue({value = {}, text = L.Parsing})
		local parser = DBM.Test.GetSharedModule("ParseTranscriptor")
		local f = function()
			local ts = parser:New(text)
			logs = ts:GetLogs()
			if #logs >= 1 then
				logSelect:SetSelectedValue(dropdownEntryFromLog(logs[1], #logs[1].encounters == 1 and 1 or nil))
				createTestButton:Enable()
			else
				logSelect:SetSelectedValue({value = {}, text = L.NoLogsFound})
				importLocalButton:Enable()
			end
			if callback then callback(logs) end
		end
		local cr = coroutine.create(f)
		CreateFrame("Frame"):SetScript("OnUpdate", function(self)
			if coroutine.status(cr) == "suspended" then
				local ok, err = coroutine.resume(cr)
				if not ok then error("error in async task: " .. tostring(err) .. "\nstack:\n" .. debugstack(cr)) end
			else
				self:Hide()
			end
		end)
	end
	local function onPaste(text)
		if #text < 1000 then -- Only accept large things to prevent accidentally typing something here
			input:SetText(L.PasteLogHere)
			return
		end
		local pasteTime = GetTimePreciseSec() - pasteStart
		input:SetText(L.LogPasted:format(#text / 1024 / 1024, pasteTime, #text / pasteTime / 1024 / 1024))
		-- Disable local import button to make it clear that it's not expected to be clicked after pasting (and in fact overrides pasted text)
		-- It gets enabled again as soon as you do anything with the pasted data like opening the dropdown or creating a test or if the import fails
		importLocalButton:Disable()
		importTranscriptor(text)
	end
	input:SetScript("OnUpdate", function()
		if #buf > 0 then
			local text = tconcat(buf, "", 1, pasteOffset1 - 1)
			resetBuf()
			onPaste(text)
		end
	end)

	importLocalButton = CreateFrame("Button", nil, input, "UIPanelButtonTemplate")
	importLocalButton:SetPoint("LEFT", input, "RIGHT", 3, 1)
	importLocalButton:SetSize(140, 40)
	importLocalButton:SetText(L.ImportLocalTranscriptor)
	importLocalButton:SetScript("OnClick", function()
		if TranscriptDB and next(TranscriptDB) then
			resetBuf()
			importTranscriptor(nil, function(logs)
				local numEncounters = 0
				for _, v in ipairs(logs) do
					numEncounters = numEncounters + #v.encounters
				end
				input:SetText(L.LocalImportDone:format(#logs, numEncounters))
			end)
		else
			input:SetText(L.NoLocalTranscriptor)
		end
	end)
	local noLogsDropdownValue = {}
	local function getLogEntries()
		importLocalButton:Enable()
		if not logs or #logs == 0 then
			return {value = noLogsDropdownValue, text = L.NoLogsFound}
		end
		local entries = {}
		for _, v in ipairs(logs) do
			for i in ipairs(v.encounters) do
				entries[#entries + 1] = dropdownEntryFromLog(v, i)
			end
			if #v.encounters == 0 then
				entries[#entries + 1] = dropdownEntryFromLog(v)
			end
		end
		return entries
	end
	local function onLogSelect(value)
		if value == noLogsDropdownValue then return end
		logSelect:SetSelectedValue({value = value, text = value.name})
		createTestButton:Enable()
	end
	logSelect = DBM_GUI:CreateDropdown(L.SelectLogDropdown, getLogEntries, nil, nil, onLogSelect, 300, nil, importTranscriptorFrame)
	logSelect:SetSelectedValue({value = {}, text = L.SelectLogDropdown})
	logSelect:SetPoint("TOPLEFT", input, "BOTTOMLEFT", -16, -15)

	createTestButton = CreateFrame("Button", nil, importTranscriptorFrame, "UIPanelButtonTemplate")
	createTestButton:SetPoint("TOPLEFT", logSelect, "BOTTOMLEFT", 20, 0)
	createTestButton:SetSize(100, 20)
	createTestButton:SetText(L.CreateTest)
	createTestButton:Disable()
	createTestButton:SetScript("OnClick", function(self)
		if not logSelect.value then
			input:SetText(L.NoLogSelected)
			return
		elseif logSelect.value.imported then
			input:SetText(L.LogAlreadyImported)
			return
		end
		importLocalButton:Enable()
		self:SetText(L.Parsing)
		self:Disable()
		local parser = DBM.Test.GetSharedModule("ParseTranscriptor")
		local frame = CreateFrame("Frame")
		local f = function()
			local start = GetTimePreciseSec()
			local gen = parser:NewTestGenerator(logSelect.value.log, logSelect.value.startOffset, logSelect.value.endOffset, nil, true, true, true)
			local def = gen:GetTestDefinition()
			def.ephemeral = true
			def.name = "Imported/" .. logSelect.value.name
			-- TODO: the name should be unique as it contains timestamp and encounter, so we could prevent double imports across multiple sessions here
			-- but this is good enough, just want to prevent people from clicking the button twice
			logSelect.value.imported = true
			-- TODO: add option to store this persistently, but it's a bit messy because we need to serialize it to avoid size limits
			ephemeralTests[#ephemeralTests + 1] = def
			self:SetText(L.CreateTest)
			input:SetText(L.CreatedTest:format(#def.log, GetTimePreciseSec() - start))
			self:Enable()
		end
		local cr = coroutine.create(f)
		frame:SetScript("OnUpdate", function()
			if coroutine.status(cr) == "suspended" then
				local ok, err = coroutine.resume(cr)
				if not ok then error("error in async task: " .. tostring(err) .. "\nstack:\n" .. debugstack(cr)) end
			end
		end)
	end)

	local close = CreateFrame("Button", nil, importTranscriptorFrame, "UIPanelButtonTemplate")
	close:SetPoint("BOTTOMRIGHT", -15, 15)
	close:SetSize(100, 20)
	close:SetText(CLOSE)
	close:SetScript("OnClick", function()
		importTranscriptorFrame:Hide()
	end)
end

---@param panel DBMPanel
---@param mod DBMMod
function DBM_GUI:AddModTestOptionsAbove(panel, mod)
	DBM.Test:LoadAllTests() -- Boss mod frames are created lazily so this is actually only run once the user clicks on a test frame
	local tests = DBM.Test:GetTestsForMod(mod) or {}
	local infoArea = panel:CreateArea(L.DevPanelArea)
	infoArea:CreateText(L.DevModPanelExplanation, nil, true)

	local loadWithMocksArea = panel:CreateArea(L.TestSupportArea)
	local isLoadedWithMocks = test.Mocks:IsModLoadedWithMocks(mod)
	local loadedWithMocksText = loadWithMocksArea:CreateText(isLoadedWithMocks and L.ModLoadedWithTests or L.ModNotLoadedWithTests, nil, true)
	if not isLoadedWithMocks then
		loadedWithMocksText:SetTextColor(RED_FONT_COLOR:GetRGB())
	end
	local alwaysLoadWithTests = loadWithMocksArea:CreateCheckButton(L.AlwaysLoadModWithTests .. (isLoadedWithMocks and "" or L.ModLoadRequiresReload), true)
	alwaysLoadWithTests:SetScript("OnShow", function(self)
		self:SetChecked(DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[mod.id])
	end)
	alwaysLoadWithTests:SetScript("OnClick", function()
		DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[mod.id] = not DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[mod.id] or nil
		-- This setting also needs to be stored per addon because we need to know this before to loading the whole addon (and hence before we know if a given mod is part of it)
		local atLeastOneModNeedsTests = false
		for _, v in ipairs(DBM.Mods) do
			if v.addon.modId == mod.addon.modId and DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[mod.id] then
				atLeastOneModNeedsTests = true
			end
		end
		DBM_ModsToLoadWithFullTestSupport.addonsWithTests[mod.addon.modId] = atLeastOneModNeedsTests or nil
	end)

	local testSelectArea = panel:CreateArea(L.TestSelectArea)
	local importLog = testSelectArea:CreateButton(L.ImportTranscriptor)
	importLog:SetScript("OnClick", function()
		showImportTranscriptorFrame()
	end)
	local runOrStopTest
	importLog:SetPoint("TOPLEFT", testSelectArea.frame, "TOPLEFT", 10, -10)
	local function getTestEntries()
		local values = {}
		for _, v in ipairs(tests) do
			values[#values + 1] = {text = v.name, value = v} -- TODO: add extra info
		end
		for _, v in ipairs(ephemeralTests) do
			values[#values + 1] = {text = v.name, value = v}
		end
		return values
	end
	local testSelect
	local function onTestDropdownSelect(value)
		testSelect:SetSelectedValue({value = value, text = value.name})
		runOrStopTest:Enable()
	end
	testSelect = testSelectArea:CreateDropdown(L.SelectTestLog, getTestEntries, nil, nil, onTestDropdownSelect, 300)
	testSelect.myheight = 40
	if #ephemeralTests >= 1 then -- TODO: only select this by default if this was imported from this mod
		testSelect:SetSelectedValue({value = ephemeralTests[1], text = ephemeralTests[1].name})
	elseif #tests >= 1 then
		testSelect:SetSelectedValue({value = tests[1], text = tests[1].name})
	else
		testSelect:SetSelectedValue({value = {}, text = L.NoTestDataAvailable})
	end
	testSelect:SetPoint("TOPLEFT", importLog, "BOTTOMLEFT", -16, -15)
	local function getPlayerEntries()
		local testData = testSelect.value ---@type TestDefinition
		if not testData or not testData.players then
			return {value = DEFAULT, text = DEFAULT}
		end
		local values = {}
		values[#values + 1] = {text = L.RewriteAllToYou, value = "EverythingOnYou"}
		values[#values + 1] = {value = DEFAULT, text = DEFAULT}
		for _, v in ipairs(testData.players) do
			values[#values + 1] = {text = v[1], value = v[1]} -- TODO: add extra info
		end
		return values
	end
	local playerSelect
	local function onPlayerDropdownSelect(value)
		playerSelect:SetSelectedValue({value = value, text = value.name})
	end
	playerSelect = testSelectArea:CreateDropdown(L.SelectPerspective, getPlayerEntries, nil, nil, onPlayerDropdownSelect, 300)
	playerSelect.myheight = 40
	playerSelect:SetSelectedValue({value = DEFAULT, text = DEFAULT})
	playerSelect:SetPoint("TOPLEFT", testSelect, "BOTTOMLEFT", 0, -10)

	runOrStopTest = panel:CreateButton(L.RunTest, 120, 30)
	runOrStopTest.myheight = 40
	runOrStopTest:SetPoint("TOPLEFT", testSelectArea.frame, "BOTTOMLEFT", 0, -10)
	if #tests == 0 then
		runOrStopTest:Disable()
	end
	runOrStopTest:SetScript("OnClick", function()
		if DBM.Test.testRunning then
			DBM.Test:StopTests()
		else
			if testSelect.value and testSelect.value.name then
				local testData = testSelect.value
				if testData.ephemeral then
					testData.mod = mod.id
					testData.addon = mod.addon.modId
					testData.gameVersion = "Any"
				end
				if not testData.instanceInfo then
					DBM:AddMsg("No instanceInfo found for the mod -- please record logs with DBM installed to avoid this")
					-- TODO: shows this in the UI and add a UI to add it, but the new guessing works pretty well
				end
				runTest(testData, playerSelect.value)
			else
				DBM:AddMsg("No test data selected") -- Shouldn't happen, but I don't trust the dropdown code
			end
		end
	end)
	local lastResults ---@type DBMTestReporterPublic?
	local showReport = panel:CreateButton(L.ShowReport, 120, 30)
	showReport.myheight = 40
	showReport:SetPoint("TOPLEFT", runOrStopTest, "BOTTOMLEFT", 0, -5)
	showReport:Disable()
	showReport:SetScript("OnClick", function()
		if lastResults then
			lastResults:ShowReport()
		end
	end)
	-- FIXME: callbacks are not ideal to use here as we would need to filter them to our test
	DBM:RegisterCallback("DBMTest_Start", function()
		showReport:Disable()
		lastResults = nil
		runOrStopTest:SetText(L.StopTest)
	end)
	DBM:RegisterCallback("DBMTest_Stop", function(_, args)
		runOrStopTest:SetText(L.RunTest)
		if args.Canceled then
			lastResults = nil
			showReport:Disable()
		else
			showReport:Enable()
			lastResults = args.Reporter
		end
	end)

	local timeWarpSlider = DBM_GUI:CreateTimewarpSlider(panel)
	timeWarpSlider:SetPoint("LEFT", runOrStopTest, "RIGHT", 10, 0)
	local optionsText = panel:CreateText(L.RealModOptionsBelow)
	optionsText:SetPoint("TOPLEFT", showReport, "BOTTOMLEFT", 0, -10)
	local line = panel:CreateLine("", 31)
	line:SetPoint("TOPLEFT", showReport, "BOTTOMLEFT", -9, -20)

	-- Force temporary switch to the newly created frame to calculate positions
	local oldFrame = DBM_GUI.currentViewing
	DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
	-- Must be calculated before switching back
	local height = infoArea.frame:GetTop() - line:GetBottom() + 20
	if oldFrame then DBM_GUI_OptionsFrame:DisplayFrame(oldFrame) end -- nil if this is the very first frame you click on
	return height
end
