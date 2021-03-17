local L = DBM_GUI_L

local DBM = DBM
local type, ipairs, tinsert = type, ipairs, table.insert
local LibStub = _G["LibStub"]

local Create, Refresh
local profileDropdown = {}

local profilePanel			= DBM_GUI.Cat_General:CreateNewPanel(L.Panel_Profile, "option")

local createProfileArea		= profilePanel:CreateArea(L.Area_CreateProfile)
local createTextbox			= createProfileArea:CreateEditBox(L.EnterProfileName, "", 175)
createTextbox:SetMaxLetters(17)
createTextbox:SetPoint("TOPLEFT", 30, -25)
createTextbox:SetScript("OnEnterPressed", function()
	Create()
end)

local createButton			= createProfileArea:CreateButton(L.CreateProfile)
createButton:SetPoint("LEFT", createTextbox, "RIGHT", 10, 0)
createButton:SetScript("OnClick", function()
	Create()
end)

local applyProfileArea		= profilePanel:CreateArea(L.Area_ApplyProfile)
local applyProfile			= applyProfileArea:CreateDropdown(L.SelectProfileToApply, profileDropdown, nil, nil, function(value)
	DBM_UsedProfile = value
	DBM:ApplyProfile(value)
	Refresh()
end)
applyProfile:SetPoint("TOPLEFT", 0, -20)
applyProfile:SetScript("OnShow", function()
	applyProfile:SetSelectedValue(DBM_UsedProfile)
end)

local copyProfileArea		= profilePanel:CreateArea(L.Area_CopyProfile)
local copyProfile			= copyProfileArea:CreateDropdown(L.SelectProfileToCopy, profileDropdown, nil, nil, function(value)
	DBM:CopyProfile(value)
	C_Timer.After(0.05, Refresh)
end)
copyProfile:SetPoint("TOPLEFT", 0, -20)
copyProfile:SetScript("OnShow", function()
	copyProfile.value = nil
	copyProfile.text = nil
	_G[copyProfile:GetName() .. "Text"]:SetText("")
end)

local deleteProfileArea		= profilePanel:CreateArea(L.Area_DeleteProfile)
local deleteProfile			= deleteProfileArea:CreateDropdown(L.SelectProfileToDelete, profileDropdown, nil, nil, function(value)
	DBM:DeleteProfile(value)
	C_Timer.After(0.05, Refresh)
end)
deleteProfile:SetPoint("TOPLEFT", 0, -20)
deleteProfile:SetScript("OnShow", function()
	deleteProfile.value = nil
	deleteProfile.text = nil
	_G[deleteProfile:GetName() .. "Text"]:SetText("")
end)

local dualProfileArea		= profilePanel:CreateArea(L.Area_DualProfile)
local dualProfile			= dualProfileArea:CreateCheckButton(L.DualProfile, true)
dualProfile:SetScript("OnClick", function()
	DBM_UseDualProfile = not DBM_UseDualProfile
	DBM:SpecChanged(true)
end)
dualProfile:SetChecked(DBM_UseDualProfile)

local function actuallyImport(importTable)
	DBM.Options = importTable.DBM -- Cached options
	DBM_AllSavedOptions[_G["DBM_UsedProfile"]] = importTable.DBM
	DBT_AllPersistentOptions[_G["DBM_UsedProfile"]] = importTable.DBT
	DBM_MinimapIcon = importTable.minimap
	if importTable.minimap.hide then
		LibStub("LibDBIcon-1.0"):Hide("DBM")
	else
		LibStub("LibDBIcon-1.0"):Show("DBM")
	end
	DBT:SetOption("Skin", DBT.Options.Skin) -- Forces a hard update on bars.
	DBM:AddMsg("Profile imported.")
end

local importExportProfilesArea = profilePanel:CreateArea(L.Area_ImportExportProfile)
importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true)
local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
	DBM_GUI:CreateExportProfile({
		DBM		= DBM.Options,
		DBT		= DBT_AllPersistentOptions[_G["DBM_UsedProfile"]],
		minimap	= DBM_MinimapIcon
	})
end)
exportProfile:SetPoint("TOPLEFT", 12, -20)
local localeTable = {
	RaidWarningSound		= "RaidWarnSound",
	SpecialWarningSound		= "SpecialWarnSoundOption",
	SpecialWarningSound2	= "SpecialWarnSoundOption",
	SpecialWarningSound3	= "SpecialWarnSoundOption",
	SpecialWarningSound4	= "SpecialWarnSoundOption",
	SpecialWarningSound5	= "SpecialWarnSoundOption",
	EventSoundVictory2		= "EventVictorySound",
	EventSoundWipe			= "EventWipeSound",
	EventSoundEngage2		= "EventEngageSound",
	EventSoundMusic			= "EventEngageMusic",
	EventSoundDungeonBGM	= "EventDungeonMusic"
}
local importProfile = importExportProfilesArea:CreateButton(L.ButtonImportProfile, 120, 20, function()
	DBM_GUI:CreateImportProfile(function(importTable)
		local errors = {}
		-- Check if voice pack missing
		local activeVP = importTable.DBM.ChosenVoicePack
		if activeVP ~= "None" then
			if not DBM.VoiceVersions[activeVP] or (DBM.VoiceVersions[activeVP] and DBM.VoiceVersions[activeVP] == 0) then
				DBM:AddMsg(L.VOICE_MISSING)
				tinsert(errors, "ChosenVoicePack")
			end
		end
		-- Check if sound packs are missing
		for _, soundSetting in ipairs({
			"RaidWarningSound", "SpecialWarningSound", "SpecialWarningSound2", "SpecialWarningSound3", "SpecialWarningSound4", "SpecialWarningSound5", "EventSoundVictory2",
			"EventSoundWipe", "EventSoundEngage2", "EventSoundMusic", "EventSoundDungeonBGM", "RangeFrameSound1", "RangeFrameSound2"
		}) do
			local activeSound = importTable.DBM[soundSetting]
			if type(activeSound) == "string" and activeSound:lower() ~= "none" and not DBM:ValidateSound(activeSound, true, true) then
				DBM:AddMsg(L.ImportErrorOn:format(L[localeTable[soundSetting]] or soundSetting))
				tinsert(errors, soundSetting)
			end
		end
		-- Create popup confirming if they wish to continue (and therefor resetting to default)
		if #errors > 0 then
			local popup = StaticPopup_Show("IMPORTPROFILE_ERROR")
			if popup then
				popup.importFunc = function()
					for _, soundSetting in ipairs(errors) do
						importTable.DBM[soundSetting] = DBM.DefaultOptions[soundSetting]
					end
					actuallyImport(importTable)
				end
			end
		else
			actuallyImport(importTable)
		end
	end)
end)
importProfile.myheight = 0
importProfile:SetPoint("LEFT", exportProfile, "RIGHT", 2, 0)

function Create()
	if createTextbox:GetText() then
		local text = createTextbox:GetText()
		text = text:gsub(" ", "")
		if text ~= "" then
			DBM:CreateProfile(createTextbox:GetText())
			createTextbox:SetText("")
			createTextbox:ClearFocus()
			Refresh()
		end
	end
end

function Refresh()
	table.wipe(profileDropdown)
	for name, _ in pairs(DBM_AllSavedOptions) do
		table.insert(profileDropdown, {
			text	= name,
			value	= name
		})
	end
	applyProfile:GetScript("OnShow")()
	copyProfile:GetScript("OnShow")()
	deleteProfile:GetScript("OnShow")()
end
Refresh()
