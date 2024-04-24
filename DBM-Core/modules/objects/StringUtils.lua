---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class StringUtils
local stringUtils = private:GetPrototype("StringUtils")

local pcall, floor, type = pcall, math.floor, type

local function replace(cap1)
	return cap1 == "%" and CL.UNKNOWN
end

-- fail-safe format, replaces missing arguments with unknown
-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
function stringUtils.pformat(fstr, ...)
	local ok, str = pcall(format, fstr, ...)
	return ok and str or fstr:gsub("(%%+)([^%%%s%)<]+)", replace):gsub("%%%%", "%%")
end

function stringUtils.strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time * 100) / 100
	if time < 60 then
		return L.TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return L.TIMER_FORMAT_MINS:format(time / 60)
	else
		return L.TIMER_FORMAT:format(time / 60, time % 60)
	end
end

function DBM:strFromTime(time)
	return stringUtils.strFromTime(time)
end

--Another custom server name strip function that first strips out the "><" DBM wraps around playernames
function stringUtils.stripServerName(cap)
	return DBM:GetShortServerName(cap:sub(2, -2))
end
