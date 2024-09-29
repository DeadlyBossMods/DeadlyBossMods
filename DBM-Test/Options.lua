---@class DBMTestSavedSettings
local defaultOptions = {
	AnonymizeImports = false
}

DBM_Test_Settings = nil ---@type DBMTestSavedSettings

local function varsLoaded()
	DBM_Test_Settings = DBM_Test_Settings or {}
	setmetatable(DBM_Test_Settings, {__index = defaultOptions})
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "DBM-Test" then
		varsLoaded()
	end
end)
