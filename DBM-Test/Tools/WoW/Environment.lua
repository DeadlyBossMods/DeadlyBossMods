local modules = {}

local env = setmetatable({}, {__index = _G})
function env.require(name)
	modules[name] = modules[name] or {} -- Creating it implicitly allows us to not worry about loading order in .toc
	return modules[name]
end

---@class DBMTest
local test = DBM.Test

-- Create a shared module that can be `require`d in both a CLI and WoW environment. Must be before any `require` calls in the current file.
function test.CreateSharedModule(name)
	---@diagnostic disable-next-line: param-type-mismatch --no clue why it's complaining here, this is obviously correct
	setfenv(2, env)
	modules[name] = modules[name] or {}
	return modules[name]
end

test.GetSharedModule = env.require
