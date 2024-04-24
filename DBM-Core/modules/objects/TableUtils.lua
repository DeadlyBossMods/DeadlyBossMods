---@class DBMCoreNamespace
local private = select(2, ...)

---@class TableUtils
local tableUtils = private:GetPrototype("TableUtils")

local ipairs, tremove = ipairs, table.remove

-- Checks if a given value is in an array.
---@return boolean found
function tableUtils.checkEntry(t, val)
	for _, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function tableUtils.removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			existed = true
		end
	end
	return existed
end

function tableUtils.orderedTable()
	local nextkey, firstkey = {}, {}
	nextkey[nextkey] = firstkey

	local function onext(self, key)
		while key ~= nil do
			key = nextkey[key]
			local val = self[key]
			if val ~= nil then
				return key, val
			end
		end
	end

	local selfmeta = firstkey
	selfmeta.__nextkey = nextkey

	function selfmeta:__newindex(key, val)
		rawset(self, key, val)
		if nextkey[key] == nil then
			nextkey[nextkey[nextkey]] = key
			nextkey[nextkey] = key
		end
	end

	function selfmeta:__pairs()
		return onext, self, firstkey
	end

	return setmetatable({}, selfmeta)
end
