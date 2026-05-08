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
	if type(link) ~= "string" then
		return
	end
	if DBM:issecretvalue(link) then
		return
	end
	-- SetItemRef callbacks can provide either the full link (garrmission:DBM:...) or payload-only (DBM:...).
	if link:sub(1, 4) == "DBM:" then
		link = "garrmission:" .. link
	end
	if link:sub(1, 7) == "cancel:" or link:sub(1, 7) == "ignore:" or link:sub(1, 7) == "update:" or link:sub(1, 5) == "news:" or link:sub(1, 10) == "noteshare:" then
		link = "garrmission:DBM:" .. link
	end
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

-- Prefer SetItemRef callback when available so we don't taint chat frame execution paths.
local function TryHandleSetItemRef(...)
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if type(arg) == "string" and not DBM:issecretvalue(arg) then
			if arg:find("garrmission:DBM:", 1, true) or arg:find("DBM:", 1, true) or arg:find("cancel:", 1, true) or arg:find("ignore:", 1, true) or arg:find("noteshare:", 1, true) or arg:find("update:", 1, true) or arg:find("news:", 1, true) then
				LinkHook(nil, arg)
				return
			end
		end
	end
end

local hasSafeSetItemRefHook = false
--Callback doesn't actuallyw ork
--if EventRegistry and EventRegistry.RegisterCallback then
--	EventRegistry:RegisterCallback("SetItemRef", function(...)
--		TryHandleSetItemRef(...)
--	end)
--	hasSafeSetItemRefHook = true
--end
--This is probably still tainty but hopefully less so than old way
if hooksecurefunc and type(SetItemRef) == "function" then
	hooksecurefunc("SetItemRef", function(...)
		TryHandleSetItemRef(...)
	end)
	hasSafeSetItemRefHook = true
end
if not hasSafeSetItemRefHook then
	DBM:Debug("Hyperlinks: no safe SetItemRef hook path available; DBM links disabled to avoid taint-prone chat frame hooks")
end
