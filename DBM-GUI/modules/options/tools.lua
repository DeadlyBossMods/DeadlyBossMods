local L		= DBM_GUI_L
local CL	= DBM_CORE_L

---@class DBMGUI
local DBM_GUI = DBM_GUI

DBM_GUI.CAT_TOOLS = DBM_GUI:CreateNewPanel("TOOLS", "tools")

DBM_GUI.tabs[6].buttons[1].hidden = true -- Hide the category

local area		= DBM_GUI.CAT_TOOLS:CreateArea(L.OTabTools)

local latency = area:CreateButton(L.Tools_LatencyCheck, 120, 30)
latency:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10)
latency:SetScript("OnClick", function()
	DBM.Latency:Show()
end)

local durability = area:CreateButton(L.Tools_DurabilityCheck, 120, 30)
durability.myheight = 0
durability:SetPoint("LEFT", latency, "RIGHT", 10, 0)
durability:SetScript("OnClick", function()
	DBM.Durability:Show()
end)

local area2 = DBM_GUI.CAT_TOOLS:CreateArea(L.Tools_BreakTimer)

local duration = area2:CreateEditBox(L.Tools_Duration, "")
duration.myheight = 30
duration:SetPoint("TOPLEFT", area2.frame, "TOPLEFT", 15, -25)

local startBtn = area2:CreateButton(L.Tools_BreakTimer)
startBtn.myheight = 0
startBtn:SetPoint("LEFT", duration, "RIGHT", 10, 0)
startBtn:SetScript("OnClick", function()
	DBM:CreateBreakTimer(tonumber(duration:GetText()) or 10)
end)

local area3 = DBM_GUI.CAT_TOOLS:CreateArea(L.Tools_PizzaTimer)

local duration2 = area3:CreateEditBox(L.Tools_Duration, "")
duration2.myheight = 30
duration2:SetPoint("TOPLEFT", area3.frame, "TOPLEFT", 15, -25)

local message = area3:CreateEditBox(L.Tools_Message, "", 300, 20)
message.myheight = 40
message:SetPoint("TOPLEFT", duration2, "BOTTOMLEFT", 0, -20)

local startBtn2 = area3:CreateButton(L.Tools_PizzaTimer)
startBtn2.myheight = 0
startBtn2:SetPoint("LEFT", duration2, "RIGHT", 10, 0)
startBtn2:SetScript("OnClick", function()
	local difficultyIndex = DBM:GetCurrentDifficulty()
	local permission = true
	if DBM:GetRaidRank() == 0 or difficultyIndex == 7 or difficultyIndex == 17 or IsTrialAccount() then
		DBM:AddMsg(CL.ERROR_NO_PERMISSION)
		permission = false
	end
	local time, text = duration2:GetText(), message:GetText()
	if not time and not text then
		DBM:AddMsg(CL.PIZZA_ERROR_USAGE)
		return
	end
	local _min, _sec = string.split(":", time)
	local min = tonumber(_min or "") or 0
	local sec = tonumber(_sec or "")
	if min and not sec then
		sec = min
		min = 0
	end
	DBM:CreatePizzaTimer(min * 60 + sec, text, permission)
end)
