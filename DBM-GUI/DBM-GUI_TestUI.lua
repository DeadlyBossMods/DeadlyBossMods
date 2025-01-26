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

local function createImportTranscriptorFrame()
	---@class DBMImportTranscriptorFrame: Frame, BackdropTemplate
	importTranscriptorFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	importTranscriptorFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	importTranscriptorFrame:SetFrameLevel(importTranscriptorFrame:GetFrameLevel() + 10)
	importTranscriptorFrame:SetSize(540, 207)
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

	local input = CreateFrame("EditBox", nil, importTranscriptorFrame, "InputBoxTemplate")
	input:SetTextInsets(7, 7, 3, 3)
	input:SetFontObject(GameFontDisable)
	input:SetMultiLine(true)
	input:EnableMouse(true)
	input:SetAutoFocus(true)
	input:SetMaxBytes(100)
	input:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -10)
	input:SetWidth(350)
	input:SetHeight(32)
	input:SetScript("OnShow", function(self) self:Enable() self:SetFocus() self:SetCursorPosition(0) end)
	input:SetText(L.PasteLogHere)
	input:SetScript("OnEscapePressed", function(self)
		importTranscriptorFrame:Hide()
	end)
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
	local importLocalButton, createTestButton, exportTestButton
	local function dropdownEntryFromLog(log, encounterOffset)
		if encounterOffset then
			local encounter = log.encounters[encounterOffset]
			local timestamp = date("%Y-%m-%d %H:%M:%S", log.timestamp + (encounter.startTime or 0))
			local name = ("%s: %s (%d) %s, %.0f seconds, %d log entries"):format(
				timestamp, encounter.name, encounter.id, encounter.success and "Kill" or "Wipe", encounter.endTime - encounter.startTime, encounter.endOffset - encounter.startOffset)
			return {
				value = {name = name, log = log, startOffset = encounter.startOffset, endOffset = encounter.endOffset},
				text = name
			}
		else
			local timestamp = date("%Y-%m-%d %H:%M:%S", log.timestamp)
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
			local firstLogWithEncounters = 1
			for i, v in ipairs(logs) do
				if #v.encounters >= 1 then
					firstLogWithEncounters = i
					break
				end
			end
			if #logs >= 1 then
				logSelect:SetSelectedValue(dropdownEntryFromLog(logs[firstLogWithEncounters], #logs[firstLogWithEncounters].encounters >= 1 and 1 or nil))
				createTestButton:Enable()
				exportTestButton:Enable()
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
				---@diagnostic disable-next-line: param-type-mismatch
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
	importLocalButton:SetNormalFontObject(GameFontNormalSmall)
	importLocalButton:SetHighlightFontObject(GameFontHighlightSmall)
	importLocalButton:SetDisabledFontObject(GameFontDisableSmall)
	importLocalButton:SetPoint("LEFT", input, "RIGHT", 3, 1)
	importLocalButton:SetSize(130, 40)
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
		exportTestButton:Enable()
	end
	logSelect = DBM_GUI:CreateDropdown(L.SelectLogDropdown, getLogEntries, nil, nil, onLogSelect, 300, nil, importTranscriptorFrame)
	local isNewDropdown = logSelect.mytype == "dropdown2"
	logSelect:SetSelectedValue({value = {}, text = L.SelectLogDropdown})
	logSelect:SetPoint("TOPLEFT", input, "BOTTOMLEFT", isNewDropdown and -5 or -16, -15)

	local anonCheckbox = CreateFrame("CheckButton", nil, importTranscriptorFrame, "OptionsBaseCheckButtonTemplate")
	local anonCheckboxText = importTranscriptorFrame:CreateFontString(nil, nil, "GameFontNormal")
	anonCheckboxText:SetText(L.AnonymizeTest)
	anonCheckbox:SetPoint("TOPLEFT", logSelect, "BOTTOMLEFT", isNewDropdown and 0 or 16, -2)
	anonCheckboxText:SetPoint("LEFT", anonCheckbox, "RIGHT", 0, 0)
	anonCheckbox:SetScript("OnShow", function(self)
		self:SetChecked(DBM_Test_Settings.AnonymizeImports)
	end)
	anonCheckbox:SetChecked(DBM_Test_Settings.AnonymizeImports)
	anonCheckbox:SetScript("OnClick", function()
		DBM_Test_Settings.AnonymizeImports = not DBM_Test_Settings.AnonymizeImports
	end)

	---@param callback fun(self: Button, gen: DBMTranscriptorParserTestGenerator, startTimer: number)
	local function testGenerator(callback)
		return function(self)
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
				local gen = parser:NewTestGenerator(logSelect.value.log, logSelect.value.startOffset, logSelect.value.endOffset, nil, not DBM_Test_Settings.AnonymizeImports, true, true)
				callback(self, gen, start)
			end
			local cr = coroutine.create(f)
			frame:SetScript("OnUpdate", function()
				if coroutine.status(cr) == "suspended" then
					local ok, err = coroutine.resume(cr)
					---@diagnostic disable-next-line: param-type-mismatch
					if not ok then error("error in async task: " .. tostring(err) .. "\nstack:\n" .. debugstack(cr)) end
				end
			end)
		end
	end
	createTestButton = CreateFrame("Button", nil, importTranscriptorFrame, "UIPanelButtonTemplate")
	createTestButton:SetPoint("TOPLEFT", anonCheckbox, "BOTTOMLEFT", 0, 0)
	createTestButton:SetSize(100, 20)
	createTestButton:SetText(L.CreateTest)
	createTestButton:Disable()
	createTestButton:SetScript("OnClick", testGenerator(function(self, gen, startTime)
		local def = gen:GetTestDefinition()
		def.ephemeral = true
		def.showInAllMods = false
		def.mod = importTranscriptorFrame.mod.id
		-- TODO: add option to rename it
		def.name = "Imported/" .. logSelect.value.name
		-- TODO: the name should be unique as it contains timestamp and encounter, so we could prevent double imports across multiple sessions here
		-- but this is good enough, just want to prevent people from clicking the button twice
		logSelect.value.imported = true
		ephemeralTests[#ephemeralTests + 1] = def
		self:SetText(L.CreateTest)
		input:SetText(L.CreatedTest:format(#def.log, GetTimePreciseSec() - startTime))
		self:Enable()
		importTranscriptorFrame.parentTestSelect:RefreshLazyValues()
		importTranscriptorFrame.parentTestSelect:SetSelectedValue(def.name)
		importTranscriptorFrame.parentPlayerSelect:GenerateMenu()
	end))
	exportTestButton = CreateFrame("Button", nil, importTranscriptorFrame, "UIPanelButtonTemplate")
	exportTestButton:SetPoint("LEFT", createTestButton, "RIGHT", 10, 0)
	exportTestButton:SetSize(100, 20)
	exportTestButton:SetText(L.ExportTest)
	exportTestButton:Disable()
	exportTestButton:SetScript("OnClick", testGenerator(function(self, gen, startTime)
		local exportedTest =
			gen:GetHeaderString() .. "\n" ..
			gen:GetPlayersString() .. "\n" ..
			gen:GetLogString() .. "\n" ..
			gen:GetCompressedLogString() .. "\n" ..
			"}\n"
		self:SetText(L.ExportTest)
		input:SetText(L.CreatedTest:format(gen.stats.outputLines, GetTimePreciseSec() - startTime))
		self:Enable()
		local infoText = L.ExportedTest:format(gen.stats.outputLines, (1 - gen.stats.outputLines / gen.stats.parsedLines) * 100)
		if DBM_Test_Settings.AnonymizeImports then
			local numFailedAnon = 0
			gen.anonymizer:CheckForLeaks(exportedTest, function(str)
				numFailedAnon = numFailedAnon + 1
				DBM:AddMsg(L.ExportTestFailedNonAnonString:format(str))
				exportedTest = "-- " .. L.ExportTestFailedNonAnonString:format(str) .. "\n" .. exportedTest
			end)
			if numFailedAnon > 0 then
				infoText = L.ExportedTestFailedAnon:format(numFailedAnon)
			end
		end
		DBM:ShowUpdateReminder(nil, nil, infoText, exportedTest)
	end))


	local close = CreateFrame("Button", nil, importTranscriptorFrame, "UIPanelButtonTemplate")
	close:SetPoint("BOTTOMRIGHT", -15, 15)
	close:SetSize(100, 20)
	close:SetText(CLOSE)
	close:SetScript("OnClick", function()
		importTranscriptorFrame:Hide()
	end)
end

local function showImportTranscriptorFrame(testSelect, playerSelect, mod)
	if not importTranscriptorFrame then
		createImportTranscriptorFrame()
	end
	importTranscriptorFrame.parentTestSelect = testSelect
	importTranscriptorFrame.parentPlayerSelect = playerSelect
	importTranscriptorFrame.mod = mod
	importTranscriptorFrame:Show()
end

local compressAsync = CreateFrame("Frame")
---@param testData TestDefinition
local function serializeLog(testData)
	if testData.compressedLog then return end
	local libSerialize = LibStub("LibSerialize")
	local libDeflate = LibStub("LibDeflate")
	local handler = libSerialize:SerializeAsync(testData.log)
	compressAsync:SetScript("OnUpdate", function()
		local completed, serialized = handler()
		if completed then
			compressAsync:Hide()
			testData.compressedLog = libDeflate:EncodeForPrint(libDeflate:CompressDeflate(serialized))
		end
	end)
	testData.duration = testData.log[#testData.log][1]
	compressAsync:Show()
end

---@param panel DBMPanel
---@param mod DBMMod
function DBM_GUI:AddModTestOptionsAbove(panel, mod)
	local ok = DBM.Test:LoadAllTests() -- Boss mod frames are created lazily so this is actually only run once the user clicks on a test frame
	if not ok then
		DBM:AddMsg("Failed not load testing support, make sure that DBM-Test is installed and enabled")
		return 0
	end
	local tests = DBM.Test:GetTestsForMod(mod) or {}
	local infoArea = panel:CreateArea(L.DevPanelArea)
	infoArea:CreateText(L.DevModPanelExplanation, nil, true)

	-- Mod loading
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

	-- Test/player selection
	local testSelectArea = panel:CreateArea(L.TestSelectArea)
	local testSelect, playerSelect
	local importLog = testSelectArea:CreateButton(L.ImportTranscriptor)
	importLog:SetScript("OnClick", function()
		showImportTranscriptorFrame(testSelect, playerSelect, mod)
	end)
	local runOrStopTest, saveLogButton, alwaysShowButton
	importLog:SetPoint("TOPLEFT", testSelectArea.frame, "TOPLEFT", 10, -10)
	local function getTestEntries()
		local values = {}
		for _, v in ipairs(tests) do
			values[#values + 1] = {text = v.name, value = v} -- TODO: add extra info
		end
		for _, v in ipairs(ephemeralTests) do
			if v.showInAllMods or v.mod == mod.id then
				values[#values + 1] = {text = v.name, value = v}
			end
		end
		if #values == 0 then
			values[#values + 1] = {value = {}, text = L.NoTestDataAvailable}
		end
		return values
	end
	local function onTestDropdownSelect(value)
		testSelect:SetSelectedValue({value = value, text = value.name})
	end
	testSelect = testSelectArea:CreateDropdown(L.SelectTestLog, getTestEntries, nil, nil, onTestDropdownSelect, 300)
	local isNewDropdown = testSelect.mytype == "dropdown2"
	testSelect:OnSelectionChanged(function()
		if runOrStopTest then runOrStopTest:Enable() end
		if alwaysShowButton then alwaysShowButton:Hide() alwaysShowButton:Show() end
		if saveLogButton then saveLogButton:Hide() saveLogButton:Show() end
	end)
	local function resetTestSelection()
		local testEntries = getTestEntries()
		testSelect:RefreshLazyValues()
		if #testEntries >= 1 then
			testSelect:SetSelectedValue(testEntries[1].text)
		else
			testSelect:SetSelectedValue(L.NoTestDataAvailable)
		end
	end
	testSelect:SetScript("OnShow", function(self)
		if self.value and self.value.ephemeral and not self.value.showInAllMods and self.value.mod ~= mod.id then
			-- "Show in all mods" was deselected from a different mod, reset selection
			resetTestSelection()
		elseif not self.values then
			resetTestSelection()
		end
	end)
	testSelect.myheight = 40
	testSelect:SetPoint("TOPLEFT", importLog, "BOTTOMLEFT", isNewDropdown and 0 or -16, -15)
	local function getPlayerEntries()
		local testData = testSelect.value ---@type TestDefinition
		if not testData or not testData.players then
			return {value = DEFAULT, text = DEFAULT}
		end
		local values = {}
		values[#values + 1] = {text = L.RewriteAllToYou, value = "EverythingOnYou"}
		values[#values + 1] = {value = DEFAULT, text = DEFAULT .. (testData.perspective and (" (%s)"):format(testData.perspective) or "")}
		for _, v in ipairs(testData.players) do
			local player = v[1]
			if RAID_CLASS_COLORS[v.class] then
				player = RAID_CLASS_COLORS[v.class]:WrapTextInColorCode(player)
			end
			if v.role then
				player = player .. (" (%s)"):format(v.role)
			end
			if v.logRecorder then
				player = player .. (" (log recorder)")
			end
			values[#values + 1] = {
				text = player,
				value = v[1]
			}
		end
		return values
	end
	local function onPlayerDropdownSelect(value)
		playerSelect:SetSelectedValue({value = value, text = value.name})
	end
	playerSelect = testSelectArea:CreateDropdown(L.SelectPerspective, getPlayerEntries, nil, nil, onPlayerDropdownSelect, 300)
	playerSelect.myheight = 40
	playerSelect:SetSelectedValue({value = DEFAULT, text = DEFAULT})
	playerSelect:SetPoint("TOPLEFT", testSelect, "BOTTOMLEFT", 0, -10)

	-- Saved logs
	alwaysShowButton = testSelectArea:CreateCheckButton(L.ShowThisTestEverywhere, false)
	alwaysShowButton:SetScript("OnShow", function(self)
		if not testSelect.value or not testSelect.value.ephemeral then
			self:Disable()
			self.textObj:SetFontObject("p", GameFontDisable)
			self:SetChecked(false)
			return
		end
		self:Enable()
		self.textObj:SetFontObject("p", GameFontNormal)
		self:SetChecked(testSelect.value.showInAllMods)
	end)
	alwaysShowButton:SetScript("OnClick", function(self)
		testSelect.value.showInAllMods = not testSelect.value.showInAllMods
		if not testSelect.value.showInAllMods then
			testSelect.value.mod = mod.id
		end
	end)
	alwaysShowButton:SetPoint("LEFT", testSelect, "RIGHT", 35, 0)
	saveLogButton = testSelectArea:CreateCheckButton(L.SaveThisTest, false)
	saveLogButton:SetScript("OnShow", function(self)
		if not testSelect.value or not testSelect.value.ephemeral then
			self:Disable()
			self.textObj:SetFontObject("p", GameFontDisable)
			self:SetChecked(testSelect.value)
			return
		end
		self:Enable()
		self.textObj:SetFontObject("p", GameFontNormal)
		self:SetChecked(testSelect.value.persistent)
	end)
	saveLogButton:SetScript("OnClick", function(self)
		testSelect.value.persistent = not testSelect.value.persistent
		if testSelect.value.persistent then
			serializeLog(testSelect.value)
			DBM_Test_PersistentImports = DBM_Test_PersistentImports or {}
			DBM_Test_PersistentImports[testSelect.value.name] = testSelect.value
		end
	end)
	saveLogButton:SetPoint("TOP", alwaysShowButton, "BOTTOM", 0, -10)

	-- Test running
	runOrStopTest = panel:CreateButton(L.RunTest, 130, 30)
	runOrStopTest.myheight = 40
	runOrStopTest:SetPoint("TOPLEFT", testSelectArea.frame, "BOTTOMLEFT", 0, -10)
	if #tests == 0 and #ephemeralTests == 0 then
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
	local showReport = panel:CreateButton(L.ShowReport, 130, 30)
	showReport.myheight = 40
	showReport:SetPoint("TOPLEFT", runOrStopTest, "BOTTOMLEFT", 0, -5)
	showReport:Disable()
	showReport:SetScript("OnClick", function()
		if lastResults then
			lastResults:ShowReport()
		end
	end)
	local skipStage = panel:CreateButton(L.SkipPhase, 130, 30)
	skipStage:SetPoint("LEFT", showReport, "RIGHT", 5, 0)
	skipStage:SetScript("OnClick", function()
		if DBM.Test.timeWarper then
			DBM.Test.timeWarper:SkipToStage()
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

local savedVariablesLoaded = false
local persistentTestLoader = CreateFrame("Frame")
persistentTestLoader:RegisterEvent("ADDON_LOADED")
persistentTestLoader:SetScript("OnEvent", function(self, _, addon)
	if savedVariablesLoaded then return end
	if addon == "DBM-Test" or addon == "DBM-GUI" and DBM.Test.loaded then
		-- Loading order can vary between these two mods
		DBM_Test_PersistentImports = DBM_Test_PersistentImports or {}
		for _, v in pairs(DBM_Test_PersistentImports) do
			ephemeralTests[#ephemeralTests + 1] = v
		end
		savedVariablesLoaded = true
	end
end)
