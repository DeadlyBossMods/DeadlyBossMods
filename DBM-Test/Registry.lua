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
	local libSerialize = LibStub("LibSerialize")
	local libDeflate = LibStub("LibDeflate")
	local decodedLog = libDeflate:DecodeForPrint(testData.compressedLog)
	yield()
	local serializedLog = libDeflate:DecompressDeflate(decodedLog)
	local handler = libSerialize:DeserializeAsync(serializedLog)
	local completed, success, deserialized
	repeat
		yield()
		completed, success, deserialized = handler()
	until completed
	if not success then
		error("failed to decompress log " .. testData.name)
	end
	testData.log = deserialized
end

local function loadTestAsync(testData)
	if not testData.mod then
		test:DecompressLog(testData)
	end
	if C_AddOns.IsAddOnLoaded(testData.addon) then
		test:GuessMod(testData)
	end
	if testData.mod then
		testData.mod = tostring(testData.mod) -- Canonicalize mod ids to strings because DBM:NewMod() does so internally and the UI only has the stringified ID available
		testsByMod[testData.mod] = testsByMod[testData.mod] or {}
		table.insert(testsByMod[testData.mod], testData)
	end
end

test._loadTestAsyncInternal = loadTestAsync -- required for DBM-Offline which doesn't do OnUpdate outside the timewarper

local testsLoading = {}
local testLoaderFrame = CreateFrame("Frame")
local testLoader = coroutine.create(function()
	while true do
		if #testsLoading > 0 then
			local testData = testsLoading[#testsLoading]
			testsLoading[#testsLoading] = nil
			loadTestAsync(testData)
		else
			testLoaderFrame:Hide()
			yield()
		end
	end
end)

testLoaderFrame:SetScript("OnUpdate", function(self)
	if coroutine.status(testLoader) == "dead" then
		self:Hide()
		return
	end
	local ok, err = coroutine.resume(testLoader)
	if not ok then error(err) end
end)

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
	self.Registry.tests[def.name] = def
	table.insert(self.Registry.sortedTests, def.name)
	testsLoading[#testsLoading + 1] = def
	testLoaderFrame:Show()
end

-- Deprecated, test reports were deleted in favor of DBM-Offline
function test:Report()
	DBM:Debug("called deprecated DBM.Test:Report()")
end
