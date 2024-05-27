--[===[@non-alpha@
do return end
--@end-non-alpha@]===]

---@class DBMGUI
local DBM_GUI = DBM_GUI

DBM_GUI.Cat_Development = DBM_GUI:CreateNewPanel("Development & Testing", "option")

local infoArea = DBM_GUI.Cat_Development:CreateArea("Development and Testing UI")
infoArea:CreateText("You are seeing this UI tab because you have an alpha or development build of DBM installed.", nil, true)

local testPanel = DBM_GUI.Cat_Development:CreateNewPanel("Tests", "option")

---@class TimeWarpSlider: DBMPanelSlider
local timeWarpSlider = testPanel:CreateSlider("", 1, 500, 1, 400)
timeWarpSlider:SetPoint("TOPLEFT", testPanel.frame, "TOPLEFT", 20, -20)
timeWarpSlider:SetScript("OnValueChanged", function(self, value)
	local sliderMax = select(2, self:GetMinMaxValues())
	if value >= sliderMax then -- slider at max == dynamic fastest speed
		DBM_Test_DefaultTimeWarp = 0
		timeWarpSlider.textFrame:SetText("Time warp: dynamic (fastest)")
		if DBM.Test.timeWarper then
			DBM.Test.timeWarper:SetSpeed(0)
		end
		return
	end
	value = self:TransformInput(value)
	DBM_Test_DefaultTimeWarp = value
	timeWarpSlider.textFrame:SetFormattedText("Time warp: %dx", value)
	if DBM.Test.timeWarper then
		DBM.Test.timeWarper:SetSpeed(value)
	end
end)

-- exponential slider that isn't too steep and feels good
timeWarpSlider.steepness = 3.3
function timeWarpSlider:TransformInput(value)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	value = (value - sliderMin) / (sliderMax - sliderMin)
	return (math.exp(value * self.steepness) - 1) / (math.exp(self.steepness) - 1) * (sliderMax - sliderMin) + sliderMin
end

function timeWarpSlider:TransformInputInverse(value)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	value = (value - sliderMin) / (sliderMax - sliderMin)
	return math.log((math.exp(self.steepness) - 1) * (value - 1 / (1 - math.exp(self.steepness)))) / self.steepness * (sliderMax - sliderMin) + sliderMin
end


local runButtons = {}

---@param tests TestDefinition[]
local function getTestDurationString(tests)
	local duration = 0
	for _, test in ipairs(tests) do
		duration = duration + test.log[#test.log][1] + 3.1 -- Tests wait 3.1 second for post-combat handlers (full event deregistration)
	end
	duration = math.floor(duration)
	local sec = duration % 60
	local min = math.floor(duration / 60)
	return ("%d:%02d"):format(min, sec)
end

---@param uiInfo TestUiInfo
---@param test TestDefinition
---@param result? TestResultEnum
local function setCombinedTestResults(uiInfo, test, result)
	if uiInfo.numTests == 1  and result == "Failure" then
		-- TODO: add flakiness detection here: did this succeed or fail in prior runs?
		test.uiInfo.statusText:SetText("Failed")
		test.uiInfo.statusText:SetTextColor(RED_FONT_COLOR:GetRGB())
		return
	end
	if result then
		uiInfo.childTestState[test] = result
	end
	local successCount = 0
	local failCount = 0
	for _, v in pairs(uiInfo.childTestState) do
		if v == "Success" then
			successCount = successCount + 1
		elseif v == "Failure" then
			failCount = failCount + 1
		end
	end
	uiInfo.statusText:SetFormattedText("%d/%d", successCount, uiInfo.numTests)
	if failCount > 0 then
		uiInfo.statusText:SetTextColor(RED_FONT_COLOR:GetRGB())
	elseif successCount == uiInfo.numTests then
		uiInfo.statusText:SetTextColor(GREEN_FONT_COLOR:GetRGB())
	else
		uiInfo.statusText:SetTextColor(ORANGE_FONT_COLOR:GetRGB())
	end
end

---@type TestDefinition[]
local queuedTests = {}
local runAllOrStopButton

local function stopAll()
	DBM.Test:StopTests()
	for _, test in ipairs(queuedTests) do
		setCombinedTestResults(test.uiInfo, test)
	end
	table.wipe(queuedTests)
	for _, button in ipairs(runButtons) do
		button:Enable()
	end
	runAllOrStopButton:SetText("Run all tests")
end

runAllOrStopButton = testPanel:CreateButton("Run all tests", 100, 35, function()
	if #queuedTests > 0 then
		stopAll()
	elseif runButtons[1] then
		runButtons[1]:GetScript("OnClick")(runButtons[1])
	else
		error("no tests installed")
	end
end)
runAllOrStopButton:SetPoint("TOPRIGHT", testPanel.frame, "TOPRIGHT", -10, -5)

---@param test TestDefinition
local function onTestStart(test)
	test.uiInfo.statusText:SetText("Running")
	test.uiInfo.statusText:SetTextColor(LIGHTBLUE_FONT_COLOR:GetRGB())
end

---@param results TestReporter
local function onTestFinish(test, results, testCount, numTests)
	if queuedTests[#queuedTests] == test then
		queuedTests[#queuedTests] = nil
	end
	local result = results:GetResult()
	for _, parent in ipairs(test.uiInfo.parents) do
		setCombinedTestResults(parent.uiInfo, test, result)
	end
	setCombinedTestResults(test.uiInfo, test, result)
	test.uiInfo.lastResults = results
	if results:HasDiff() then
		test.uiInfo.showDiffButton:Show()
	end
	if results:HasErrors() then
		test.uiInfo.showErrorsButton:Show()
	end
	if testCount == numTests then
		for _, button in ipairs(runButtons) do
			button:Enable()
		end
		runAllOrStopButton:SetText("Run all tests")
	end
end

---@param event TestCallbackEvent
---@param test TestDefinition
local function testStatusCallback(event, test, ...)
	if event == "TestStart" then
		return onTestStart(test)
	else
		return onTestFinish(test, ...)
	end
end

local function onRunTestClicked(tests)
	return function()
		for _, button in ipairs(runButtons) do
			button:Disable()
		end
		runAllOrStopButton:SetText("Stop tests")
		for i = #tests, 1, -1 do
			local test = tests[i]
			queuedTests[#queuedTests + 1] = test
			test.uiInfo.showDiffButton:Hide()
			test.uiInfo.showErrorsButton:Hide()
			test.uiInfo.statusText:SetText("Queued")
			test.uiInfo.statusText:SetTextColor(BLUE_FONT_COLOR:GetRGB())
		end
		onTestStart(tests[1])
		DBM.Test:RunTests(tests, nil, testStatusCallback)
	end
end

local testYIndex = 1
---@param tests TestDefinition[]
---@return TestUiInfo
local function createTestEntry(testName, tests, parents, indentation)
	local yDistance = 22
	local yPos = -yDistance * testYIndex - 35
	testYIndex = testYIndex + 1
	local xOffset = indentation * 10
	---@class TestUiInfo
	local uiInfo = {
		parents = parents,
		numTests = #tests,
		---@type table<TestDefinition, TestResultEnum>
		childTestState = {}
	}

	local statusText = testPanel:CreateText("", 55, false)
	uiInfo.statusText = statusText
	if #tests > 0 then
		statusText:SetText("0/" .. #tests)
	end
	statusText:SetPoint("TOPLEFT", testPanel.frame, "TOPLEFT", 7, yPos)
	statusText:SetMaxLines(1)
	local nameText = testPanel:CreateText(testName, 0, false)
	nameText:SetWidth(400) -- set width last like this instead of via parameter to avoid some odd placement for truncated text
	nameText:SetMaxLines(1)
	nameText:SetPoint("TOPLEFT", testPanel.frame, "TOPLEFT", 60 + xOffset, yPos)
	local runButton = testPanel:CreateButton("Run", 40, 22, onRunTestClicked(tests))
	runButton.myheight = yDistance
	runButtons[#runButtons + 1] = runButton
	runButton:SetPoint("TOPRIGHT", testPanel.frame, "TOPRIGHT", -10, yPos)
	local durationText = testPanel:CreateText(getTestDurationString(tests), 50, false, nil, "RIGHT")
	durationText:SetPoint("RIGHT", runButton, "LEFT", -5, 0)
	if #tests == 1 then
		---@class TestDefinition
		local test = tests[1]
		local showDiffButton = testPanel:CreateButton("Show diff", 0, 22, function(self)
			if test.uiInfo.lastResults then
				test.uiInfo.lastResults:ReportDiff(true)
			end
		end)
		uiInfo.showDiffButton = showDiffButton
		showDiffButton:SetPoint("RIGHT", runButton, "LEFT", -50, 0)
		showDiffButton:Hide()
		local showErrorsButton = testPanel:CreateButton("Show errors", 0, 22, function(self)
			if test.uiInfo.lastResults then
				test.uiInfo.lastResults:ReportErrors()
			end
		end)
		uiInfo.showErrorsButton = showErrorsButton
		showErrorsButton:SetPoint("RIGHT", showDiffButton, "LEFT", -5, 0)
		showErrorsButton:Hide()
		uiInfo.lastResults = nil
		test.uiInfo = uiInfo
	end
	return uiInfo
end

---@param node TestTreeNode
local function gatherChildTests(node, result)
	result = result or {}
	for _, v in ipairs(node.children) do
		if v.test then
			result[#result + 1] = v.test
		end
		gatherChildTests(v, result)
	end
	return result
end

local function getParents(node)
	local result = {}
	while node.parent do
		result[#result + 1] = node.parent
		node = node.parent
	end
	return result
end

---@class node TestTreeNode
local function createTestTreeEntry(node)
	-- Note: this not ideal if we have nodes that have a test and children (e.g., tests named a/b and a/b/c), it happens to work by coincidence
	-- as the only code that relies on having uiInfo in the node is the code that iterates over parents and both entries have the same parents.
	-- Also note that tests a/b and a/b/c shouldn't exist at the same time if you follow the naming pattern.
	if node.test then
		node.uiInfo = createTestEntry(node.test.name, {node.test}, getParents(node), node.depth)
	end
	if node.count > 1 then
		local name = node.path == "" and "All tests" or (node.path .. "/*")
		node.uiInfo = createTestEntry(name, gatherChildTests(node), getParents(node), node.depth)
	end
	for _, v in ipairs(node.children) do
		createTestTreeEntry(v)
	end
end

---@class TestTreeNode
local root = {
	---@type TestTreeNode?
	parent = nil,
	---@type TestTreeNode[]
	children = {},
	---@type TestDefinition
	test = nil, -- Node contains a test, if we follow the intended naming then this is mutually exclusive with #children > 0.
	path = "",
	depth = 0,
	count = 0,
	---@type TestUiInfo
	uiInfo = nil,
	---@type table<string, TestTreeNode>
	entries = {} -- Only used during tree construction, do not use afterwards.
}

local function insertElement(node, depth, name, pathElements)
	node.count = (node.count or 0) + 1
	local path = pathElements[depth]
	if not node.entries[path] then
		local entry = {parent = node, entries = {}, path = table.concat(pathElements, "/", 1, depth), children = {}, depth = depth, count = 0}
		node.entries[path] = entry
		table.insert(node.children, entry)
	end
	if depth < #pathElements then
		insertElement(node.entries[path], depth + 1, name, pathElements)
	else
		node.entries[path].test = DBM.Test.Registry.tests[name]
		node.entries[path].count = (node.entries[path].count or 0) + 1
	end
end

local function decrementDepth(node)
	node.depth = node.depth - 1
	for _, v in ipairs(node.children) do
		decrementDepth(v)
	end
end

local function pruneTree(node)
	local i = 1
	while i <= #node.children do
		local v = node.children[i]
		pruneTree(v)
		if not v.test and #v.children == 1 then
			v.children[1].parent = v.children[1].parent.parent
			node.children[i] = v.children[1]
			decrementDepth(v.children[1])
		else
			i = i + 1
		end
	end
end

local initialized
testPanel.frame:HookScript("OnShow", function(self)
	if initialized then return end
	initialized = true
	DBM.Test:LoadAllTests()
	if not DBM.Test:TestsLoaded() then
		local area = testPanel:CreateArea("No tests available")
		area:CreateText("Could not find any test definitions, check if DBM-Test-* mods are installed and enabled.", nil, true)
		return
	end
	local savedTimeWarpSliderVal = DBM_Test_DefaultTimeWarp or 0
	savedTimeWarpSliderVal = savedTimeWarpSliderVal > 0 and savedTimeWarpSliderVal or 500
	timeWarpSlider:SetValue(timeWarpSlider:TransformInputInverse(savedTimeWarpSliderVal))
	for _, testName in ipairs(DBM.Test.Registry.sortedTests) do
		local pathElements = {string.split("/", testName)}
		insertElement(root, 1, testName, pathElements)
	end
	pruneTree(root)
	createTestTreeEntry(root)
end)
