---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = DBM

local L = DBM_CORE_L

local SendAddonMessage = C_ChatInfo.SendAddonMessage

local frame, fontstring, editBox, button3

local function CreateOurFrame()
	---@class DBMNotesEditorFrame: Frame, BackdropTemplate
	frame = CreateFrame("Frame", "DBMNotesEditor", UIParent, "BackdropTemplate")
	frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
	frame:SetWidth(430)
	frame:SetHeight(140)
	frame:SetPoint("TOP", 0, -230)
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 11, right = 12, top = 12, bottom = 11 }
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
	editBox:SetText("")
	local fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstringFooter:SetWidth(410)
	fontstringFooter:SetHeight(0)
	fontstringFooter:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
	fontstringFooter:SetText(L.NOTEFOOTER)
	local button = CreateFrame("Button", nil, frame)
	button:SetHeight(24)
	button:SetWidth(75)
	button:SetPoint("BOTTOM", 80, 13)
	button:SetNormalFontObject(GameFontNormal)
	button:SetHighlightFontObject(GameFontHighlight)
	button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button:SetText(OKAY)
	button:SetScript("OnClick", function(self)
		frame.mod.Options[frame.modvar .. "SWNote"] = editBox:GetText() or ""
		frame.mod = nil
		frame.modvar = nil
		frame.abilityName = nil
		frame:Hide()
	end)
	local button2 = CreateFrame("Button", nil, frame)
	button2:SetHeight(24)
	button2:SetWidth(75)
	button2:SetPoint("BOTTOM", 0, 13)
	button2:SetNormalFontObject(GameFontNormal)
	button2:SetHighlightFontObject(GameFontHighlight)
	button2:SetNormalTexture(button2:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button2:SetPushedTexture(button2:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button2:SetHighlightTexture(button2:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button2:SetText(CANCEL)
	button2:SetScript("OnClick", function(self)
		frame.mod = nil
		frame.modvar = nil
		frame.abilityName = nil
		frame:Hide()
	end)
	button3 = CreateFrame("Button", nil, frame)
	button3:SetHeight(24)
	button3:SetWidth(75)
	button3:SetPoint("BOTTOM", -80, 13)
	button3:SetNormalFontObject(GameFontNormal)
	button3:SetHighlightFontObject(GameFontHighlight)
	button3:SetNormalTexture(button3:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button3:SetPushedTexture(button3:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button3:SetHighlightTexture(button3:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button3:SetText(SHARE_QUEST_ABBREV)
	button3:SetScript("OnClick", function(self)
		local syncText = editBox:GetText() or ""
		if syncText == "" then
			DBM:AddMsg(L.NOTESHAREERRORBLANK)
		elseif IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
			DBM:AddMsg(L.NOTESHAREERRORGROUPFINDER)
		else
			local playerName, _, playerRealm = DBM:GetMyPlayerInfo()
			local fullname = playerName.."-"..playerRealm
			local msg = frame.mod.id.."\t"..frame.modvar.."\t"..syncText.."\t"..frame.abilityName
			if IsInRaid() then
				SendAddonMessage(private.DBMPrefix, fullname .. "\t" .. private.DBMSyncProtocol .. "\tNS\t" .. msg, "RAID")
				DBM:AddMsg(L.NOTESHARED)
			elseif IsInGroup(1) then
				SendAddonMessage(private.DBMPrefix, fullname .. "\t" .. private.DBMSyncProtocol .. "\tNS\t" .. msg, "PARTY")
				DBM:AddMsg(L.NOTESHARED)
			else--Solo
				DBM:AddMsg(L.NOTESHAREERRORSOLO)
			end
		end
	end)
end

function DBM:ShowNoteEditor(mod, modvar, abilityName, syncText, sender)
	if not frame then
		CreateOurFrame()
	else
		if frame:IsShown() and syncText then
			self:AddMsg(L.NOTESHAREERRORALREADYOPEN)
			return
		end
	end
	frame:Show()
	frame.mod = mod
	frame.modvar = modvar
	frame.abilityName = abilityName
	if syncText then
		button3:Hide()--Don't show share button in shared notes
		fontstring:SetText(L.NOTESHAREDHEADER:format(sender, abilityName))
		editBox:SetText(syncText)
	else
		button3:Show()
		fontstring:SetText(L.NOTEHEADER:format(abilityName))
		if type(mod.Options[modvar .. "SWNote"]) == "string" then
			editBox:SetText(mod.Options[modvar .. "SWNote"])
		else
			editBox:SetText("")
		end
	end
end
