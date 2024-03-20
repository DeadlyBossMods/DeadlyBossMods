local L = DBM_CORE_L

local frame, text, ignore, cancel

local function CreateOurFrame()
	---@class DBMHyperlinkFrame: Frame, BackdropTemplate
	frame = CreateFrame("Frame", "DBMHyperLinks", UIParent, "BackdropTemplate")
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- 312922
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
		tile		= true,
		tileSize	= 16,
		edgeSize	= 16,
		insets		= { left = 1, right = 1, top = 1, bottom = 1 }
	}
	frame:ApplyBackdrop()
	frame:SetSize(500, 80)
	frame:SetPoint("TOP", UIParent, "TOP", 0, -200)
	frame:SetFrameStrata("DIALOG")

	text = frame:CreateFontString()
	text:SetFontObject(ChatFontNormal)
	text:SetWidth(470)
	text:SetWordWrap(true)
	text:SetPoint("TOP", frame, "TOP", 0, -15)

	local accept = CreateFrame("Button", nil, frame)
	accept:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
	accept:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
	accept:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
	accept:SetSize(128, 35)
	accept:SetPoint("BOTTOM", frame, "BOTTOM", -75, 0)
	accept:SetScript("OnClick", function()
		DBM:AddToPizzaIgnore(ignore)
		DBT:CancelBar(cancel)
		frame:Hide()
	end)

	local atext = accept:CreateFontString()
	atext:SetFontObject(ChatFontNormal)
	atext:SetPoint("CENTER", accept, "CENTER", 0, 5)
	atext:SetText(YES)

	local decline = CreateFrame("Button", nil, frame)
	decline:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
	decline:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
	decline:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
	decline:SetSize(128, 35)
	decline:SetPoint("BOTTOM", frame, "BOTTOM", 75, 0)
	decline:SetScript("OnClick", function()
		frame:Hide()
	end)

	local dtext = decline:CreateFontString()
	dtext:SetFontObject(ChatFontNormal)
	dtext:SetPoint("CENTER", decline, "CENTER", 0, 5)
	dtext:SetText(NO)
	PlaySound(850)
end

local function LinkHook(self, link)
	local _, linkType, arg1, arg2, arg3, arg4, arg5, arg6 = strsplit(":", link)
	if linkType ~= "DBM" then
		return
	end
	if arg1 == "cancel" then
		DBT:CancelBar(link:match("garrmission:DBM:cancel:(.+):nil$"))
	elseif arg1 == "ignore" then
		cancel = link:match("garrmission:DBM:ignore:(.+):[^%s:]+$")
		ignore = link:match(":([^:]+)$")
		if not frame then
			CreateOurFrame()
		end
		text:SetText(L.PIZZA_CONFIRM_IGNORE:format(ignore))
		frame:Show()
	elseif arg1 == "update" then
		DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision
	elseif arg1 == "news" then
		DBM:ShowUpdateReminder(nil, nil, L.COPY_URL_DIALOG_NEWS, "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki/%5BNews%5D-DBM-Module-Restructuring-and-unification")
	elseif arg1 == "noteshare" then
		local mod = DBM:GetModByName(arg2 or "")
		if mod then
			DBM:ShowNoteEditor(mod, arg3, arg4, arg5, arg6)--modvar, ability, text, sender
		else--Should not happen, since mod was verified before getting this far, but just in case
			DBM:Debug("Bad note share, mod not valid")
		end
	end
end

DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", LinkHook) -- Handles the weird case that the default chat frame is not one of the normal chat frames (3rd party chat frames or whatever causes this)
local i = 1
while _G["ChatFrame" .. i] do
	if _G["ChatFrame" .. i] ~= DEFAULT_CHAT_FRAME then
		_G["ChatFrame" .. i]:HookScript("OnHyperlinkClick", LinkHook)
	end
	i = i + 1
end
