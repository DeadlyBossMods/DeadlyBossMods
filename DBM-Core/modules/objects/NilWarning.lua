---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local test = private:GetPrototype("DBMTest")


local mt = {}
function mt.__index(_, key)
	local err = "attempted to access key " .. tostring(key) .. " on nil warning object -- check game version logic"
	if test.testRunning then
		error(err)
	else
		DBM:Debug(err)
	end
	return function() end
end

-- A warning object that just shows a (debug)-error if invoked.
-- This is useful as a placeholder for timers that do not exist in the current game version.
-- Example usage:
-- local fooTimer = DBM:IsSeasonal("SeasonOfDiscovery") and mod:NewCDTimer(...) or mod:NewNilWarning()
-- This does two things:
-- 1. it avoids a LuaLS problem where the nil check doesn't work as expected
-- 2. if we somehow still call an object for a different game version we get a useful warning instead of an error outside of tests
---@return nil
function bossModPrototype:NewNilWarning()
	return setmetatable({}, mt)
end
