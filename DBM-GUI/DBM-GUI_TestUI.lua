local L = DBM_GUI_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

---@param panel DBMPanel
---@param mod DBMMod
function DBM_GUI:AddModTestOptionsAbove(panel, mod)
	DBM.Test:LoadAllTests() -- Boss mod frames are created lazily so this is actually only run once the user clicks on a test frame
	local tests = DBM.Test:GetTestsForMod(mod)
	local runOrStopTest = panel:CreateButton(L.RunTest, 120, 30)
	runOrStopTest.myheight = 40
	runOrStopTest:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 8, -14)
	if not tests or #tests == 0 then
		runOrStopTest:Disable()
	end
	runOrStopTest:SetScript("OnClick", function()
		if DBM.Test.testRunning then
			DBM.Test:StopTests()
		else
			DBM.Test:RunTest(tests[1].name)
		end
	end)
	DBM:RegisterCallback("DBMTest_Start", function() runOrStopTest:SetText(L.StopTest) end)
	DBM:RegisterCallback("DBMTest_Stop", function() runOrStopTest:SetText(L.RunTest) end)
	local timeWarpSlider = DBM_GUI:CreateTimewarpSlider(panel)
	timeWarpSlider:SetPoint("LEFT", runOrStopTest, "RIGHT", 10, 0)
	return 50 -- FIXME: calculate this
end
