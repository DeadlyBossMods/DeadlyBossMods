---@class DBMCoreNamespace
local private = select(2, ...)

local prototypes = {}

-- Get or create a prototype for a class in DBM.
---@generic T
---@param name `T`
---@return T
function private:GetPrototype(name)
	local prototype = prototypes[name] or {}
	prototypes[name] = prototype
	return prototype
end
