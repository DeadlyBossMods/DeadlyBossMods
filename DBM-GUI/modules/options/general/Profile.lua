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
createTextbox:SetPoint("TOPLEFT", 25, -25)
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
local isNewDropdown = applyProfile.mytype == "dropdown2"
applyProfile:SetPoint("TOPLEFT", isNewDropdown and 15 or 0, -20)
if isNewDropdown then
	applyProfile.myheight = 30
end
applyProfile:SetScript("OnShow", function()
	applyProfile:SetSelectedValue(DBM_UsedProfile)
end)

local copyProfileArea		= profilePanel:CreateArea(L.Area_CopyProfile)
local copyProfile			= copyProfileArea:CreateDropdown(L.SelectProfileToCopy, profileDropdown, nil, nil, function(value)
	DBM:CopyProfile(value)
	C_Timer.After(0.05, Refresh)
end)
copyProfile:SetPoint("TOPLEFT", isNewDropdown and 15 or 0, -20)
if isNewDropdown then
	copyProfile.myheight = 30
end
copyProfile:SetScript("OnShow", function()
	copyProfile.value = nil
	copyProfile.text = nil
	if copyProfile.mytype == "dropdown" then
		_G[copyProfile:GetName() .. "Text"]:SetText("")
	end
end)

local deleteProfileArea		= profilePanel:CreateArea(L.Area_DeleteProfile)
local deleteProfile			= deleteProfileArea:CreateDropdown(L.SelectProfileToDelete, profileDropdown, nil, nil, function(value)
	DBM:DeleteProfile(value)
	C_Timer.After(0.05, Refresh)
end)
deleteProfile:SetPoint("TOPLEFT", isNewDropdown and 15 or 0, -20)
if isNewDropdown then
	deleteProfile.myheight = 30
end
deleteProfile:SetScript("OnShow", function()
	deleteProfile.value = nil
	deleteProfile.text = nil
	if copyProfile.mytype == "dropdown" then
		_G[deleteProfile:GetName() .. "Text"]:SetText("")
	end
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
local importExportText = importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true)
local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
	DBM_GUI:CreateExportProfile({
		payloadType = "Profile",
		payloadVersion = 1,
		DBM		= DBM.Options,
		DBT		= DBT_AllPersistentOptions[_G["DBM_UsedProfile"]],
		minimap	= DBM_MinimapIcon
	})
end)
exportProfile:SetPoint("TOPLEFT", importExportText, "BOTTOMLEFT", 0, -12)
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
---@class DBMImportProfileButton: DBMPanelButton
local importProfile = importExportProfilesArea:CreateButton(L.ButtonImportProfile, 120, 20, function()
	DBM_GUI:CreateImportProfile(function(importTable)
		if type(importTable.DBM) ~= "table" or type(importTable.DBT) ~= "table" or type(importTable.minimap) ~= "table" then
			DBM:AddMsg("Failed to import profile string. The data may be invalid/corrupted or from an unsupported format.")
			return false
		end
		local errors = {}
		-- Check if voice pack missing
		local activeVP = importTable.DBM.ChosenVoicePack2
		if not DBM:IsNoneValue(activeVP) then
			if not DBM.VoiceVersions[activeVP] or (DBM.VoiceVersions[activeVP] and DBM.VoiceVersions[activeVP] == 0) then
				if activeVP ~= "VEM" then
					DBM:AddMsg(L.ImportVoiceMissing:format(activeVP))
					tinsert(errors, "ChosenVoicePack2")
				end
			end
		end
		-- Check if sound packs are missing
		for _, soundSetting in ipairs({
			"RaidWarningSound", "SpecialWarningSound", "SpecialWarningSound2", "SpecialWarningSound3", "SpecialWarningSound4", "SpecialWarningSound5", "EventSoundVictory2",
			"EventSoundWipe", "EventSoundEngage2", "EventSoundMusic", "EventSoundDungeonBGM", "RangeFrameSound1", "RangeFrameSound2"
		}) do
			local activeSound = importTable.DBM[soundSetting]
			if type(activeSound) == "string" and not DBM:IsNoneValue(activeSound) and not DBM:ValidateSound(activeSound, true, true) then
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
		return true
	end, "Profile", 1)
end)
importProfile.myheight = 12
importProfile:SetPoint("LEFT", exportProfile, "RIGHT", 2, 0)

local function exportSpellRenameData()
	local exportRenames = {}
	if type(DBM.Options) == "table" and type(DBM.Options.SpellRenames) == "table" then
		for spellId, rename in pairs(DBM.Options.SpellRenames) do
			local normalizedSpellId = DBM:NormalizeSpellRenameKey(spellId)
			local sanitizedRename = DBM:SanitizeSpellRename(rename)
			local explicitClear = type(rename) == "string" and rename:match("^%s*$") ~= nil
			if normalizedSpellId and (sanitizedRename or explicitClear) then
				exportRenames[normalizedSpellId] = sanitizedRename or ""
			end
		end
	end
	return exportRenames
end

local function importSpellRenameData(importTable)
	if type(importTable) ~= "table" then
		return false
	end
	local importedRenames = {}
	local sourceEntries, validEntries, invalidEntries = 0, 0, 0
	for spellId, rename in pairs(importTable) do
		sourceEntries = sourceEntries + 1
		local normalizedSpellId = DBM:NormalizeSpellRenameKey(spellId)
		local sanitizedRename = DBM:SanitizeSpellRename(rename)
		local explicitClear = type(rename) == "string" and rename:match("^%s*$") ~= nil
		if normalizedSpellId and (sanitizedRename or explicitClear) then
			importedRenames[normalizedSpellId] = sanitizedRename or ""
			validEntries = validEntries + 1
		else
			invalidEntries = invalidEntries + 1
		end
	end
	if invalidEntries > 0 or (sourceEntries > 0 and validEntries == 0) then
		DBM:AddMsg(L.ImportSpellRenamesFailed)
		return false
	end
	if type(DBM.Options) ~= "table" then
		DBM:AddMsg(L.ImportSpellRenamesFailed)
		return false
	end
	if DBM:ReplaceSpellRenames(importedRenames) == false then
		DBM:AddMsg(L.ImportSpellRenamesFailed)
		return false
	end
	DBM:AddMsg(L.SpellRenamesImported)
	C_Timer.After(0.05, function()
		if DBM_GUI and DBM_GUI.UpdateModList then
			DBM_GUI:UpdateModList()
		end
	end)
	return true
end

local importExportSpellRenamesArea = profilePanel:CreateArea(L.Area_ImportExportSpellRenames)
local importExportSpellRenamesText = importExportSpellRenamesArea:CreateText(L.ImportExportSpellRenamesInfo, nil, true)
local exportSpellRenames = importExportSpellRenamesArea:CreateButton(L.ButtonExportSpellRenames, 160, 20, function()
	DBM_GUI:CreateExportSpellRenames(exportSpellRenameData())
end)
exportSpellRenames:SetPoint("TOPLEFT", importExportSpellRenamesText, "BOTTOMLEFT", 0, -12)
local importSpellRenames = importExportSpellRenamesArea:CreateButton(L.ButtonImportSpellRenames, 160, 20, function()
	DBM_GUI:CreateImportSpellRenames(importSpellRenameData)
end)
importSpellRenames.myheight = 12
importSpellRenames:SetPoint("LEFT", exportSpellRenames, "RIGHT", 2, 0)

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
