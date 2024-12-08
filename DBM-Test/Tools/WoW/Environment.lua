local modules = {}

local env = setmetatable({}, {__index = _G})
function env.require(name)
	modules[name] = modules[name] or {} -- Creating it implicitly allows us to not worry about loading order in .toc
	return modules[name]
end

---@class DBMTest
local test = DBM.Test

-- Create a shared module that can be accessed with `require' in both a CLI and WoW environment. Must be before any `require` calls in the current file.
-- Must not be used as a tail call. Name must match the file name with "."" as a path separator (like require expects).
---@return table
function test.CreateSharedModule(name, obj)
	setfenv(2, env)
	if modules[name] and obj then -- Object was already implicitly created by require, add data we are adding
		for k, v in pairs(obj) do
			modules[name][k] = v
		end
	end
	modules[name] = modules[name] or obj or {}
	return modules[name]
end

test.GetSharedModule = env.require
