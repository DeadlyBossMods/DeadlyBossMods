---@class DBMTest
local test = DBM.Test

test.Registry = {
	---@type table<string, TestDefinition>
	tests = {},
	---@type string[]
	sortedTests = {}
}

---@type table<string|integer, TestDefinition[]>
local testsByMod = {}

function test:GetTestsForMod(mod)
	mod = type(mod) == "table" and mod.id or mod
	return testsByMod[mod]
end

local function yield()
	if coroutine.running() then
		coroutine.yield()
	end
end

function test:DecompressLog(testData)
	if testData.log then return end
	DBM:Debug("DecompressLog(" .. testData.name .. ")", 1)
	local decodedLog = C_EncodingUtil.DecodeBase64(testData.compressedLog, 0)
	yield()
	local serializedLog = C_EncodingUtil.DecompressString(decodedLog, 0)
	yield()
	local deserialized = C_EncodingUtil.DeserializeCBOR(serializedLog)
	if type(deserialized) ~= "table" then
		error("failed to decompress log " .. testData.name)
	end
	testData.log = deserialized
end

local addonLoadedFrame = CreateFrame("Frame")
addonLoadedFrame:RegisterEvent("ADDON_LOADED")
addonLoadedFrame:SetScript("OnEvent", function(self, _, addonName)
	if C_AddOns.GetAddOnMetadata(addonName, "X-DBM-Mod") then
		for _, v in pairs(test.Registry.tests) do
			if v.addon == addonName and not v.mod then
				test:GuessMod(v)
				if v.mod then
					testsByMod[v.mod] = testsByMod[v.mod] or {}
					table.insert(testsByMod[v.mod], v)
				end
			end
		end
	end
end)

---@param def TestDefinition
function test:DefineTest(def)
	if self.Registry.tests[def.name] then
		error("duplicate test name " .. def.name, 2)
	end
	if C_AddOns.IsAddOnLoaded(def.addon) then
		test:GuessMod(def)
	end
	if def.mod then
		def.mod = tostring(def.mod)
		testsByMod[def.mod] = testsByMod[def.mod] or {}
		table.insert(testsByMod[def.mod], def)
	end
	self.Registry.tests[def.name] = def
	table.insert(self.Registry.sortedTests, def.name)
end

-- Deprecated, test reports were deleted in favor of DBM-Offline
function test:Report()
	DBM:Debug("called deprecated DBM.Test:Report()")
end
