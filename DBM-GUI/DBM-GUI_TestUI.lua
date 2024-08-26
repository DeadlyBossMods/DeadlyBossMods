local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

local test = DBM.Test

local function runTest(name, perspective)
	local settings = { ---@type DBMTestOptions
		playground = true, -- Use real mod and DBM options
		allowErrors = true,
		allOnYou = perspective == "EverythingOnYou",
		perspective = perspective ~= DEFAULT and perspective
	}
	DBM.Test:RunTest(name, nil, settings)
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
	importLog:Disable() -- TODO: implement, but annoying to implement because needs to merge CLI stuff into WoW stuff
	importLog:SetPoint("TOPLEFT", testSelectArea.frame, "TOPLEFT", 10, -10)
	local function getTestEntries()
		local values = {}
		for _, v in ipairs(tests) do
			values[#values + 1] = {text = v.name, value = v} -- TODO: add extra info
		end
		return values
	end
	local testSelect
	local function onTestDropdownSelect(value)
		testSelect:SetSelectedValue({value = value, text = value.name})
	end
	testSelect = testSelectArea:CreateDropdown(L.SelectTestLog, getTestEntries, nil, nil, onTestDropdownSelect, 300)
	testSelect.myheight = 40
	if #tests >= 1 then
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

	local runOrStopTest = panel:CreateButton(L.RunTest, 120, 30)
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
				runTest(testSelect.value.name, playerSelect.value)
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
