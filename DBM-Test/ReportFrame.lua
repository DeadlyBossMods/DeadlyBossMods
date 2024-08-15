local DBM = DBM

---@class DBMTest
local test = DBM.Test

---@type DBMTestReportFrame
local frame


local function createFrame()
	if frame then return end
	local width = 1200
	---@class DBMTestReportFrame: Frame, BackdropTemplate
	frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:SetFrameStrata("FULLSCREEN_DIALOG") -- In front of other frames including DBM-GUI
	frame:SetWidth(width)
	frame:SetHeight(600)
	frame:SetPoint("TOP", 0, -80)
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 11, right = 12, top = 12, bottom = 11 },
	}
	frame:ApplyBackdrop()
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	local header = frame:CreateFontString(nil, nil, "GameFontNormal")
	header:SetWidth(width - 90)
	header:SetHeight(0)
	header:SetPoint("TOP", 0, -16)
	header:SetText("DBM test reports are a full log of how the mod under test reacted to injected events.\nThis is best viewed in an external text editor with a monospace font.")
	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOP", header, "BOTTOM")
	scrollFrame:SetPoint("LEFT", frame, "LEFT")
	scrollFrame:SetPoint("BOTTOMRIGHT", -40, 45)
	local editBox = CreateFrame("EditBox", nil, scrollFrame)
	frame.editBox = editBox
	-- Would be nice to have this wider and text getting clipped, but SetClipsChildren on the scrollFrame makes it clip its own scroll bar
	editBox:SetWidth(width - 45)
	editBox:SetMultiLine(true)
	editBox:SetFontObject(GameFontHighlight)
	editBox:SetTextInsets(16, 0, 0, 0)
	editBox:SetScript("OnTextChanged", function(self)
		self:SetText(self.text)
		self:HighlightText()
	end)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	scrollFrame:SetScrollChild(editBox)
	editBox:SetPoint("TOPLEFT", scrollFrame)
	editBox:SetPoint("BOTTOMRIGHT", scrollFrame)
	local footer = frame:CreateFontString(nil, nil, "GameFontNormal")
	footer:SetPoint("BOTTOM", 0, 20)
	footer:SetText("Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. "to copy or Escape to close.")
	frame.button = CreateFrame("Button", nil, frame)
	frame.button:SetHeight(24)
	frame.button:SetWidth(75)
	frame.button:SetPoint("BOTTOMRIGHT", -12, 14)
	frame.button:SetNormalFontObject(GameFontNormal)
	frame.button:SetHighlightFontObject(GameFontHighlight)
	frame.button:SetNormalTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	frame.button:SetPushedTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	frame.button:SetHighlightTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	frame.button:SetText(CLOSE)
	frame.button:SetScript("OnClick", function()
		frame:Hide()
	end)
end

function test:ShowTestReportFrame(report)
	report = report:gsub("\t", "  ")
	createFrame()
	frame.editBox.text = report
	frame.editBox:SetText(report)
	frame.editBox:SetFocus()
	frame:Show()
end
