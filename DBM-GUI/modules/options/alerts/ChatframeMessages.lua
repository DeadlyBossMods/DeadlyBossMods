local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local L = DBM_GUI_L
local generalWarningPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Tab_GeneralMessages, "option")

local selectChatFrameArea = generalWarningPanel:CreateArea(L.SelectChatFrameArea)
local selectFrameButton = selectChatFrameArea:CreateButton(L.SelectChatFrameButton, 96, 22)
selectFrameButton:SetPoint("LEFT", selectChatFrameArea.frame, "LEFT", 10, 0)
local selectFrameInfo = selectChatFrameArea:CreateText(nil, nil, nil, nil, nil, 0)
selectFrameInfo:SetPoint("LEFT", selectFrameButton, "RIGHT", 10, 0)

local function findChatFrameUnderCursor()
	local f = EnumerateFrames()
	while f do
		if not f:IsProtected() and not f:IsForbidden() then
			if f:GetName() and f:GetName():match("^ChatFrame") and f:IsMouseOver() and f:IsVisible() then
				local id = f:GetName():match("ChatFrame(%d+)")
				id = tonumber(id)
				if id and _G["ChatFrame" .. id] then
					return "ChatFrame" .. id
				end
			end
		end
		f = EnumerateFrames(f)
	end
end
local function updateChatInfoText()
	selectFrameInfo:SetText(L.SelectChatFrameInfoIdle:format(
		DBM.Options.ChatFrame == "DEFAULT_CHAT_FRAME" and L.SelectChatFrameDefaultName
			or HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(DBM.Options.ChatFrame)
			or HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(DBM_COMMON_L.UNKNOWN)
	))
	selectFrameInfo:GetWidth() -- this somehow fixes a bug that the updated text sometimes doesn't show
end
updateChatInfoText()

local selectingChatFrame = false
selectFrameButton:SetScript("OnShow", updateChatInfoText)
selectFrameButton:SetScript("OnHide", function() selectingChatFrame = false end)
selectFrameButton:SetScript("OnClick", function() selectingChatFrame = true end)
selectFrameButton:SetScript("OnEvent", function(self, event)
	if selectingChatFrame and event == "GLOBAL_MOUSE_DOWN" then
		local newFrame = findChatFrameUnderCursor()
		if newFrame then
			DBM.Options.ChatFrame = newFrame
			DBM:AddMsg(L.SelectChatFrameInfoDone, nil, nil, true)
			updateChatInfoText()
			selectingChatFrame = false
		end
	end
end)
local lastText
selectFrameButton:SetScript("OnUpdate", function()
	if not selectingChatFrame then return end
	local newFrame = findChatFrameUnderCursor()
	local newText
	if newFrame then
		newText = L.SelectChatFrameInfoSelectNow:format(HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(newFrame))
	else
		newText = L.SelectChatFrameInfoSelect
	end
	if newText ~= lastText then
		lastText = newText
		selectFrameInfo:SetText(newText)
		selectFrameInfo:GetWidth() -- this somehow fixes a bug that the updated text sometimes doesn't show
	end
end)
selectFrameButton:RegisterEvent("GLOBAL_MOUSE_DOWN")

local resetbutton = selectChatFrameArea:CreateButton(L.Reset, 120, 16)
resetbutton:SetPoint("BOTTOMRIGHT", selectChatFrameArea.frame, "BOTTOMRIGHT", -2, 4)
resetbutton:SetNormalFontObject(GameFontNormalSmall)
resetbutton:SetHighlightFontObject(GameFontNormalSmall)
resetbutton:SetScript("OnClick", function()
	-- Set Options
	DBM.Options.ChatFrame = DBM.DefaultOptions.ChatFrame
	-- Set UI visuals
	updateChatInfoText()
end)

local generalCoreArea = generalWarningPanel:CreateArea(L.CoreMessages)
generalCoreArea:CreateCheckButton(L.ShowPizzaMessage, true, nil, "ShowPizzaMessage")
generalCoreArea:CreateCheckButton(L.ShowAllVersions, true, nil, "ShowAllVersions")
generalCoreArea:CreateCheckButton(L.ShowReminders, true, nil, "ShowReminders")

local generalMessagesArea = generalWarningPanel:CreateArea(L.CombatMessages)
generalMessagesArea:CreateCheckButton(L.ShowEngageMessage, true, nil, "ShowEngageMessage")
generalMessagesArea:CreateCheckButton(L.ShowDefeatMessage, true, nil, "ShowDefeatMessage")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessages, true, nil, "ShowGuildMessages")
if isRetail then
	generalMessagesArea:CreateCheckButton(L.ShowGuildMessagesPlus, true, nil, "ShowGuildMessagesPlus")
end

local generalExtraAlerts = generalWarningPanel:CreateArea(L.Area_ChatAlerts)
if isRetail then
	generalExtraAlerts:CreateCheckButton(L.RoleSpecAlert, true, nil, "RoleSpecAlert")
	generalExtraAlerts:CreateCheckButton(L.CheckGear, true, nil, "CheckGear")
else
	generalExtraAlerts:CreateCheckButton(L.WorldBuffAlert, true, nil, "WorldBuffAlert")
end
generalExtraAlerts:CreateCheckButton(L.WorldBossAlert, true, nil, "WorldBossAlert")

local generalBugsAlerts = generalWarningPanel:CreateArea(L.Area_BugAlerts)
generalBugsAlerts:CreateCheckButton(L.BadTimerAlert, true, nil, "BadTimerAlert")
