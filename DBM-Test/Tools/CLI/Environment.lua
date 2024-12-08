package.path = package.path .. ";./CLI/?.lua;./Shared/?.lua;../../DBM-Core/Libs/?/?.lua"

-- No-op/pass-through on CLI
DBM = {}
DBM.Test = {}
---@source ../WoW/Environment.lua:15
function DBM.Test.CreateSharedModule(name, obj) return obj or {} end

-- LibStub support
_G.strmatch = string.match
require "LibStub"

local libStubGetLib = LibStub.GetLibrary

local libsLoading = {}
---@generic T
---@param major `T`
---@param silent? boolean
---@return table|T library
local function libStubLoader(self, major, silent, ...)
	-- Some libs will try to load itself to explicitly find previous versions, causing a recursion error in require
	if libsLoading[major] and silent then
		return nil
	end
	libsLoading[major] = true
	require(major)
	libsLoading[major] = nil
	return libStubGetLib(self, major, silent, ...)
end

getmetatable(LibStub).__call = libStubLoader
LibStub.GetLibrary = libStubLoader
