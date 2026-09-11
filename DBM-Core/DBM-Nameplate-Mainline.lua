---@diagnostic disable: duplicate-set-field -- Mutually exclusive with DBM-Nameplate.lua in client-specific TOCs.

---@class DBM
local DBM = DBM

-- Nameplate rendering is unavailable in Midnight content. Keep the public API so
-- older modules and third-party callers can remain version-agnostic without
-- loading the Classic renderer, creating frames, or registering callbacks.
---@class DBMNameplateFrame
local nameplateFrame = {}
DBM.Nameplate = nameplateFrame

function nameplateFrame:Show()
end

function nameplateFrame:Hide()
end

function nameplateFrame:IsShown()
	return false
end

function nameplateFrame:UpdateIconOptions()
end

function nameplateFrame:ValidateFontSettings()
end

function DBM.PauseTestTimer()
end
