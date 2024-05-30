local L = DBM_CORE_L

---@class DBM
local DBM = DBM

local frame, fontstring, fontstringFooter, editBox, urlText

local function CreateOurFrame()
	---@class DBMUpdateFrame: Frame, BackdropTemplate
	frame = CreateFrame("Frame", "DBMUpdateReminder", UIParent, "BackdropTemplate")
	frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
	frame:SetWidth(430)
	frame:SetHeight(100)
	frame:SetPoint("TOP", 0, -230)
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- ????
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 11, right = 12, top = 12, bottom = 11 },
	}
	frame:ApplyBackdrop()
	fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstring:SetWidth(410)
	fontstring:SetHeight(0)
	fontstring:SetPoint("TOP", 0, -16)
	editBox = CreateFrame("EditBox", nil, frame)
	do
		local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
		editBoxLeft:SetTexture(130959)--"Interface\\ChatFrame\\UI-ChatInputBorder-Left"
		editBoxLeft:SetHeight(32)
		editBoxLeft:SetWidth(32)
		editBoxLeft:SetPoint("LEFT", -14, 0)
		editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
		local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
		editBoxRight:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
		editBoxRight:SetHeight(32)
		editBoxRight:SetWidth(32)
		editBoxRight:SetPoint("RIGHT", 6, 0)
		editBoxRight:SetTexCoord(0.875, 1, 0, 1)
		local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
		editBoxMiddle:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
		editBoxMiddle:SetHeight(32)
		editBoxMiddle:SetWidth(1)
		editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
		editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
		editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
	end
	editBox:SetHeight(32)
	editBox:SetWidth(250)
	editBox:SetPoint("TOP", fontstring, "BOTTOM", 0, -4)
	editBox:SetFontObject(GameFontHighlight)
	editBox:SetTextInsets(0, 0, 0, 1)
	editBox:SetFocus()
	editBox:SetScript("OnTextChanged", function(self)
		editBox:SetText(urlText)
		editBox:HighlightText()
	end)
	editBox:SetScript("OnEscapePressed", function()
		frame:Hide()
	end)
	fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstringFooter:SetWidth(410)
	fontstringFooter:SetHeight(0)
	fontstringFooter:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
	local button = CreateFrame("Button", nil, frame)
	button:SetHeight(24)
	button:SetWidth(75)
	button:SetPoint("BOTTOM", 0, 13)
	button:SetNormalFontObject(GameFontNormal)
	button:SetHighlightFontObject(GameFontHighlight)
	button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button:SetText(OKAY)
	button:SetScript("OnClick", function()
		frame:Hide()
	end)
end

local function setFrameWidth(extraWidth)
	extraWidth = extraWidth or 0
	frame:SetWidth(430 + extraWidth)
	fontstringFooter:SetWidth(410 + extraWidth)
	editBox:SetWidth(250 + extraWidth)
	fontstring:SetWidth(400 + extraWidth)
end

function DBM:ShowUpdateReminder(newVersion, newRevision, text, url, extraWidth, textJustify)
	urlText = url or "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki"
	if not frame then
		CreateOurFrame()
	end
	setFrameWidth(extraWidth)
	editBox:SetText(url or "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki")
	editBox:HighlightText()
	editBox:SetFocus()
	frame:Show()
	if newVersion then
		fontstring:SetText(L.UPDATEREMINDER_HEADER:format(newVersion, newRevision))
		fontstringFooter:SetText(L.UPDATEREMINDER_FOOTER)
	elseif text then
		fontstring:SetText(text)
		fontstringFooter:SetText(L.UPDATEREMINDER_FOOTER_GENERIC)
	end
	if textJustify == "LEFT" then
		fontstring:SetPoint("TOP", 10, -16)
	else
		fontstring:SetPoint("TOP", 0, -16)
	end
	fontstring:SetJustifyH(textJustify or "CENTER")
	frame:SetHeight(110 + fontstring:GetHeight())
end
