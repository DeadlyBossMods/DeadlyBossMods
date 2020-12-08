local L = DBM_GUI_L

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

local importExportProfilesArea = profilePanel:CreateArea(L.Area_ImportExportProfile)
importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true)
local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
	DBM_GUI:CreateExportProfile(DBM.Options)
end)
exportProfile:SetPoint("TOPLEFT", 12, -20)
local importProfile = importExportProfilesArea:CreateButton(L.ButtonImportProfile, 120, 20, function()
	DBM_GUI:CreateImportProfile(function(importTable)
		print("We got an import table.")
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
