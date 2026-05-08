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
	local linkType, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(":", link)
	if linkType ~= "addon" or arg1 ~= "DBM" then
		return
	end
	arg1, arg2, arg3, arg4, arg5, arg6 = arg2, arg3, arg4, arg5, arg6, arg7
	if arg1 == "cancel" then
		DBT:CancelBar(link:match("addon:DBM:cancel:(.+):nil$"))
	elseif arg1 == "ignore" then
		cancel = link:match("addon:DBM:ignore:(.+):[^%s:]+$")
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

-- Use native addon hyperlink routing so we don't sit in generic SetItemRef execution paths.
EventRegistry:RegisterCallback("SetItemRef", function(_, link)
	if type(link) == "string" and not DBM:issecretvalue(link) and link:find("addon:DBM:", 1, true) then
		LinkHook(nil, link)
	end
end)
