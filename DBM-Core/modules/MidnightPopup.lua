---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMidnightPopup
local MidnightPopup = {}
DBM.MidnightPopup = MidnightPopup

local L = DBM_CORE_L

function MidnightPopup:ShowMidnightPopup()
	local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	frame:SetFrameStrata("FULLSCREEN_DIALOG") -- In front of other frames including DBM-GUI
	frame:SetSize(600, 300)
	frame:SetPoint("TOP", 0, -230)
	frame.backdropInfo = {
		bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile		= true,
		tileSize	= 32,
		edgeSize	= 32,
		insets		= { left = 11, right = 12, top = 12, bottom = 11 },
	}
	frame:ApplyBackdrop()

	local header = frame:CreateFontString(nil, nil, "GameFontNormalLarge2")
	header:SetText(L.DEADLY_BOSS_MODS)
	header:SetWidth(550)
	header:SetHeight(0)
	header:SetPoint("TOP", 0, -16)

	local dropdownText1 = frame:CreateFontString(nil, nil, "GameFontNormal")
	dropdownText1:SetPoint("TOPLEFT", frame, 20, -40)
	dropdownText1:SetText(L.MN_TIMELINE_HEADER)

	local function IsSelected1(index)
		if index == 1 then
			return not DBM.Options.HideBlizzardTimeline
		elseif index == 2 then
			return not DBM.Options.HideDBMBars
		end
	end
	local function SetSelected1(index)
		if index == 1 then
			DBM.Options.HideBlizzardTimeline = not DBM.Options.HideBlizzardTimeline
			if DBM.Options.HideBlizzardTimeline then
				--We temp force cvar for now, ignore comment below, that's for 12.0.5
				C_CVar.SetCVar("encounterTimelineEnabled", "1")
				EncounterTimeline.TrackView:SetAlpha(0)
				EncounterTimeline.TimerView:SetAlpha(0)
				--We don't actually change cvar, just hide it with blizzard api instead
				--C_EncounterTimeline.SetViewType(0)
			else
				--We do set cvar because we want to actually enable for them if they choose for us to
				C_CVar.SetCVar("encounterTimelineEnabled", "1")
				--Restore cached viewtype from login
				C_EncounterTimeline.SetViewType(private.timelineViewType)
				EncounterTimeline.TrackView:SetAlpha(1)
				EncounterTimeline.TimerView:SetAlpha(1)
			end
		elseif index == 2 then
			DBM.Options.HideDBMBars = not DBM.Options.HideDBMBars
		end
	end

	---@class DBMMIDNIGHTDROPDOWN1: Button
	---@diagnostic disable-next-line: undefined-field, assign-type-mismatch -- self.frame comes from a subclass of DBM_GUI, DropdownButton isn't defined in ketho.wow-api
	local dropdown1 = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
	dropdown1:SetWidth(250)
	dropdown1:SetPoint("TOPLEFT", dropdownText1, "BOTTOMLEFT", 0, -10)
	---@diagnostic disable-next-line: undefined-field
	dropdown1:SetDefaultText(NONE)
	---@diagnostic disable-next-line: undefined-field
	dropdown1:SetupMenu(function(_, rootDescription)
		rootDescription:CreateCheckbox(L.MN_BLIZZARD_TIMELINE, IsSelected1, SetSelected1, 1)
		rootDescription:CreateCheckbox(L.MN_DBM_TIMELINE, IsSelected1, SetSelected1, 2)
	end)

	local dropdownText2 = frame:CreateFontString(nil, nil, "GameFontNormal")
	dropdownText2:SetPoint("TOPLEFT", dropdown1, "BOTTOMLEFT", 0, -20)
	dropdownText2:SetText(L.MN_WARNIGS_HEADER)

	local function IsSelected2(index)
		if index == 1 then
			return not DBM.Options.HideBossEmoteFrame2
		elseif index == 2 then
			return not DBM.Options.HideDBMWarnings
		end
	end
	local function SetSelected2(index)
		if index == 1 then
			DBM.Options.HideBossEmoteFrame2 = not DBM.Options.HideBossEmoteFrame2
			if DBM.Options.HideBossEmoteFrame2 then
				--We don't actually change cvar, just hide it with blizzard api instead
				C_EncounterWarnings.SetWarningsShown(false)
			else
				--We do set cvar because we want to actually enable for them if they choose for us to
				C_CVar.SetCVar("encounterWarningsEnabled", "1")
				C_EncounterWarnings.SetWarningsShown(true)
			end
		elseif index == 2 then
			DBM.Options.HideDBMWarnings = not DBM.Options.HideDBMWarnings
		end
	end

	---@class DBMMIDNIGHTDROPDOWN2: Button
	---@diagnostic disable-next-line: undefined-field, assign-type-mismatch -- DropdownButton isn't defined in ketho.wow-api
	local dropdown2 = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
	dropdown2:SetWidth(250)
	dropdown2:SetPoint("TOPLEFT", dropdownText2, "BOTTOMLEFT", 0, -10)
	---@diagnostic disable-next-line: undefined-field
	dropdown2:SetDefaultText(NONE)
	---@diagnostic disable-next-line: undefined-field
	dropdown2:SetupMenu(function(_, rootDescription)
		rootDescription:CreateCheckbox(L.MN_BLIZZARD_WARNINGS, IsSelected2, SetSelected2, 1)
		rootDescription:CreateCheckbox(L.MN_DBM_WARNINGS, IsSelected2, SetSelected2, 2)
	end)

	frame.button = CreateFrame("Button", nil, frame)
	frame.button:SetHeight(24)
	frame.button:SetWidth(75)
	frame.button:SetPoint("BOTTOM", 0, 16)
	frame.button:SetNormalFontObject(GameFontNormal)
	frame.button:SetHighlightFontObject(GameFontHighlight)
	frame.button:SetNormalTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	frame.button:SetPushedTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	frame.button:SetHighlightTexture(frame.button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	frame.button:SetText(CLOSE)
	frame.button:SetScript("OnClick", function()
		DBM.Options.HasShownMidnightPopup = true
		frame:Hide()
	end)
	frame:Show()
end
