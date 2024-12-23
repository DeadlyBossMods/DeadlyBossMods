---@class DBMTest
local test = DBM.Test

local nilValue = newproxy(false)

---@class DBMTestMocks
local mocks = {}
test.Mocks = mocks

function mocks.GetTime()
	return test.timeWarper and test.timeWarper:GetTime() or GetTime()
end

local bband = bit.band

local fakeCLEUArgs = {
	-- Number of args to handle nil values gracefully
	n = nil
}
function mocks.CombatLogGetCurrentEventInfo()
	if fakeCLEUArgs.n then
		return unpack(fakeCLEUArgs, 1, fakeCLEUArgs.n)
	else
		return CombatLogGetCurrentEventInfo()
	end
end

function mocks:SetFakeCLEUArgs(...)
	table.wipe(fakeCLEUArgs)
	fakeCLEUArgs.n = 0
	for i = 1, select("#", ...) do
		-- Add missing args, see transcribeCleu() in ParseTranscriptor
		if fakeCLEUArgs.n == 0 then
			fakeCLEUArgs.n = fakeCLEUArgs.n + 1
			fakeCLEUArgs[fakeCLEUArgs.n] = self:GetTime()
		elseif fakeCLEUArgs.n == 2 then
			fakeCLEUArgs.n = fakeCLEUArgs.n + 1
			fakeCLEUArgs[fakeCLEUArgs.n] = false -- hideCaster
		end
		fakeCLEUArgs.n = fakeCLEUArgs.n + 1
		fakeCLEUArgs[fakeCLEUArgs.n] = select(i, ...)
	end
	if select("#", ...) > 0 then
		local srcFlags = fakeCLEUArgs[6]
		local dstFlags = fakeCLEUArgs[10]
		if bband(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
			fakeCLEUArgs[4] = UnitGUID("player")
			fakeCLEUArgs[5] = UnitName("player")
		end
		if bband(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
			fakeCLEUArgs[8] = UnitGUID("player")
			fakeCLEUArgs[9] = UnitName("player")
		end
	end
end

---@type InstanceInfo
local fakeInstanceInfo
function mocks.GetInstanceInfo()
	if fakeInstanceInfo then
		return fakeInstanceInfo.name, fakeInstanceInfo.instanceType, fakeInstanceInfo.difficultyID,
			fakeInstanceInfo.difficultyName, fakeInstanceInfo.maxPlayers, fakeInstanceInfo.dynamicDifficulty,
			fakeInstanceInfo.isDynamic, fakeInstanceInfo.instanceID, fakeInstanceInfo.instanceGroupSize,
			fakeInstanceInfo.lfgDungeonID
	else
		return GetInstanceInfo()
	end
end

---@param instanceInfo InstanceInfo
function mocks:SetInstanceInfo(instanceInfo)
	fakeInstanceInfo = instanceInfo
	test:HookPrivate("LastInstanceMapID", instanceInfo.instanceID)
end

local fakeIsEncounterInProgress
function mocks.IsEncounterInProgress()
	return fakeIsEncounterInProgress
end

function mocks:SetEncounterInProgress(value)
	fakeIsEncounterInProgress = value
end

function mocks.AntiSpam(mod, time, ...)
	-- Mods often define AntiSpam timeouts in whole seconds and some periodic damage effects trigger exactly every second
	-- This can lead to flaky tests as they sometimes trigger and sometimes don't because even with fake time there is unfortunately still some dependency on actual frame timings
	-- Just subtracting 0.1 seconds fixes this problem; an example affected by this is SoD/ST/FesteringRotslime
	if time and time > 0 and math.floor(time) == time then
		time = time - 0.1
	end
	return DBM.AntiSpam(mod, time, ...)
end

-- TODO: mocking the whole "raid" local in DBM would increase coverage a bit
function mocks.DBMGetRaidUnitId(_, name)
	if not name then return end
	return "fakeunitid-name-" .. name
end

-- Boss target reconstruction
local bosses = {}
local unitTargets = {}
local unitTargetsAge = {}
local guids = {}
local namesToGuids = {}

-- Used by target scanner to get unit ID for a given guid
function mocks.DBMGetUnitIdFromGUID(_, guid, scanOnlyBoss)
	-- Since we primarily scan bosses this will return a boss unit id in retail
	-- But for classic we'll end up with a lot of fakeunitid-guid-* ids
	return bosses[guid] and bosses[guid].uId or not scanOnlyBoss and "fakeunitid-guid-" .. guid
end

-- Triggered by INSTANCE_ENCOUNTER_ENGAGE_UNIT to learn boss unit IDs and GUIDs
function mocks:UpdateBoss(uId, name, guid, canAttack, exists, visible)
	local boss = {uId = uId, name = name, guid = guid, canAttack = canAttack, exists = exists, visible = visible}
	bosses[guid] = boss
	bosses[uId] = boss
end

-- Triggered by UNIT_TARGET events that give us a unit ID and names
function mocks:UpdateTarget(uId, name, target)
	local fakeGuid = "fakeunitid-name-" .. name
	unitTargets[fakeGuid] = target
	unitTargets[uId] = target
	unitTargetsAge[fakeGuid] = self:GetTime()
	unitTargetsAge[uId] = self:GetTime()
end

local function getRecentUnitTarget(id)
	local lastUpdate = unitTargetsAge[id]
	if lastUpdate and mocks.GetTime() - lastUpdate > 5 then -- 5 seconds as arbitrary cut-off time after which we consider target info stale
		unitTargets[id] = nil
	end
	return unitTargets[id]
end

-- Triggered by SPELL_CAST_START events to learn names of creatures by GUID.
-- This is useful in classic where we often end up with GUIDs without any further information due to lack of IEEU events and boss unit ids
function mocks:LearnGuidNameMapping(guid, name)
	guids[guid] = name
	namesToGuids[name] = guid
end

-- Conflicts are ignored, best we can do for classic.
-- Used for the health check case which usually only cares about cid which should have a unique name.
function mocks:GuessGuid(name)
	return namesToGuids[name]
end

-- Used by target scanner
function mocks.DBMGetUnitFullName(_, uId)
	if type(uId) ~= "string" then return end -- Some code relies on GetUnitName (which the original is a wrapper for) returning nil for invalid arguments
	local base = uId:match("(.-)target$")
	if base then -- target scanner use
		-- In retail this is likely to be a boss unit id from DBMGetUnitIdFromGUID above, very convenient because we get UNIT_TARGET events for these
		if getRecentUnitTarget(base) then
			return getRecentUnitTarget(base)
		end
		-- However, in classic this will be a fakeunitid-guid-*
		local guid = base:match("^fakeunitid%-guid%-(.*)")
		if guid and guids[guid] then
			return getRecentUnitTarget("fakeunitid-name-" .. guids[guid])
		end
	end
	-- Generic use case
	local fromFakeId = uId:match("fakeunitid%-name%-(.*)")
	return fromFakeId or bosses[uId] and bosses[uId].name
end

local function parseFakeUnit(id)
	return {
		unitId = not id:match("^fakeunitd") and id,
		name = id:match("^fakeunitid%-name%-(.*)") or UnitName(id),
		guid = id:match("^fakeunitid%-guid%-(.*)") or UnitGUID(id),
	}
end

-- Stores timestamps of when someone had aggro
local threatInfo = {}
function mocks.UnitDetailedThreatSituation(playerUid, enemyUid)
	local player = parseFakeUnit(playerUid)
	local enemy = parseFakeUnit(enemyUid)
	if not enemy.name and not enemy.guid then return end
	if not player.name and not player.guid then return end
	local tanks = threatInfo[enemy.name or enemy.guid]
	-- Enemy unknown or player was never tanking it
	if not tanks or not tanks.names[player.name] and not tanks.guids[player.guid] then
		return false, nil, 0, 0, 0
	end
	local sortedTanks = {}
	for name, time in pairs(tanks.names) do
		sortedTanks[#sortedTanks + 1] = {time = time, name = name}
	end
	for guid, time in pairs(tanks.guids) do
		sortedTanks[#sortedTanks + 1] = {time = time, guid = guid}
	end
	table.sort(sortedTanks, function(e1, e2) return e1.time < e2.time end)
	local lastTank = sortedTanks[#sortedTanks]
	-- Latest target is "securely tanking" (status 3), no matter how stale that information is
	if lastTank.name == player.name or lastTank.guid == player.guid then
		return true, 3, 100, 100, 1000
	end
	-- Was previously tanking, so high threat but not target
	return true, 1, 99, 99, 990
end

function mocks:SetThreat(playerGuid, playerName, enemyGuid, enemyName)
	threatInfo[enemyName] = threatInfo[enemyName] or {names = {}, guids = {}}
	threatInfo[enemyName].names[playerName] = self:GetTime()
	threatInfo[enemyName].guids[playerGuid] = self:GetTime()
	threatInfo[enemyGuid] = threatInfo[enemyGuid] or {names = {}, guids = {}}
	threatInfo[enemyGuid].names[playerName] = self:GetTime()
	threatInfo[enemyGuid].guids[playerGuid] = self:GetTime()
end

function mocks.DBMNumRealAlivePlayers()
	return fakeInstanceInfo.instanceGroupSize or 10
end

local unitsInCombat = {}
function mocks.UnitAffectingCombat(unit)
	return unitsInCombat[unit]
end

function mocks:SetUnitAffectingCombat(unit, unitName, unitGuid, inCombat)
	if unit then
		unitsInCombat[unit] = inCombat
	end
	if unitGuid then
		unitsInCombat[DBM:GetUnitIdFromGUID(unitGuid)] = inCombat
	end
	if unitName then
		unitsInCombat[DBM:GetRaidUnitId(unitName)] = inCombat
	end
end

local unitAuras = {}
local function checkUnitAura(auraType, uId, spellInput1, spellInput2, spellInput3, spellInput4, spellInput5)
	if not unitAuras[uId] then
		return
	end
	local spellTable = unitAuras[uId][spellInput1] and (unitAuras[uId][spellInput1].auraType == auraType or not auraType) and unitAuras[uId][spellInput1]
		or unitAuras[uId][spellInput2] and (unitAuras[uId][spellInput2].auraType == auraType or not auraType) and unitAuras[uId][spellInput2]
		or unitAuras[uId][spellInput3] and (unitAuras[uId][spellInput3].auraType == auraType or not auraType) and unitAuras[uId][spellInput3]
		or unitAuras[uId][spellInput4] and (unitAuras[uId][spellInput4].auraType == auraType or not auraType) and unitAuras[uId][spellInput4]
		or unitAuras[uId][spellInput5] and (unitAuras[uId][spellInput5].auraType == auraType or not auraType) and unitAuras[uId][spellInput5]
	if not spellTable then
		return
	end
	return spellTable.spellName, 0, spellTable.amount, nil, 0, 0, nil, false, nil, spellTable.spellId, nil, nil, nil, nil, nil, spellTable.amount
end

function mocks.DBMUnitDebuff(_, ...)
	return checkUnitAura("DEBUFF", ...)
end

function mocks.DBMUnitBuff(_, ...)
	return checkUnitAura("BUFF", ...)
end

function mocks.DBMUnitAura(_, ...)
	return checkUnitAura(nil, ...)
end

function mocks:ApplyUnitAura(name, guid, spellId, spellName, auraType, amount)
	local uId = DBM:GetRaidUnitId(name)
	local uIdbyGuid = DBM:GetUnitIdFromGUID(guid)
	local auras = unitAuras[uId] or {}
	unitAuras[uId] = auras
	unitAuras[uIdbyGuid] = auras
	if guid == UnitGUID("player") then
		unitAuras["player"] = auras
	end
	local entry = auras[spellId] or auras[spellName] or {
		spellId = spellId,
		spellName = spellName,
	}
	auras[spellId] = entry
	auras[spellName] = entry
	entry.time = self:GetTime()
	entry.auraType = auraType
	entry.amount = amount or entry.amount or 1
end

function mocks:RemoveUnitAura(name, guid, spellId, spellName)
	local uId = DBM:GetRaidUnitId(name)
	local uIdbyGuid = DBM:GetUnitIdFromGUID(guid)
	local auras = unitAuras[uId] or {}
	unitAuras[uId] = auras
	unitAuras[uIdbyGuid] = auras
	if guid == UnitGUID("player") then
		unitAuras["player"] = auras
	end
	auras[spellId] = nil
	auras[spellName] = nil
end

local unitPower = {}
function mocks.UnitPower(uId, ...)
	return bosses[uId] and bosses[uId].power or unitPower[uId] or UnitPower(uId, ...)
end

function mocks.UnitPowerMax(uId)
	return bosses[uId] and bosses[uId].power or unitPower[uId] and 100 or UnitPowerMax(uId)
end

function mocks:UpdateUnitPower(uId, name, power)
	unitPower[uId] = power
	if name then
		unitPower["fakeunitid-name-" .. name] = power
	end
	if bosses[uId] then
		bosses[uId].power = power
	end
end

local unitHealth = {}
function mocks.UnitHealth(uId)
	return unitHealth[uId] or UnitHealth(uId)
end

function mocks.UnitHealthMax(uId)
	return unitHealth[uId] and 100 or UnitHealthMax(uId)
end

function mocks:UpdateUnitHealth(uId, name, health)
	unitHealth[uId] = health
	if name then
		unitHealth["fakeunitid-name-" .. name] = health
	end
end

function mocks.UnitExists(uId)
	return bosses[uId] and bosses[uId].exists or UnitExists(uId)
end

function mocks.UnitGUID(uId)
	local fromFakeId = uId:match("fakeunitid%-guid%-(.*)")
	return bosses[uId] and bosses[uId].guid or fromFakeId or UnitGUID(uId)
end

function mocks.IsInScenario()
	return fakeInstanceInfo and fakeInstanceInfo.instanceType == "scenario"
end
mocks.IsInScenarioGroup = mocks.IsInScenario

test.restoreModVariables = {}
function test:HookModVar(mod, key, val)
	self.restoreModVariables[mod] = self.restoreModVariables[mod] or {}
	local old = mod[key]
	if old == nil then
		old = nilValue
	end
	self.restoreModVariables[mod][key] = old
	mod[key] = val
end

function test:HookDbmVar(key, val)
	self.restoreDbmVariables = self.restoreDbmVariables or {}
	local old = DBM[key]
	if old == nil then
		old = nilValue
	end
	self.restoreDbmVariables[key] = old
	DBM[key] = val
end

function test:SetupHooks()
	self:HookPrivate("CombatLogGetCurrentEventInfo", mocks.CombatLogGetCurrentEventInfo)
	self:HookPrivate("GetInstanceInfo", mocks.GetInstanceInfo)
	mocks:SetEncounterInProgress(false)
	self:HookPrivate("IsEncounterInProgress", mocks.IsEncounterInProgress)
	self:HookPrivate("UnitDetailedThreatSituation", mocks.UnitDetailedThreatSituation)
	self:HookPrivate("UnitAffectingCombat", mocks.UnitAffectingCombat)
	self:HookPrivate("UnitGUID", mocks.UnitGUID)
	self:HookModVar(self.modUnderTest, "AntiSpam", mocks.AntiSpam)
	self:HookDbmVar("GetRaidUnitId", mocks.DBMGetRaidUnitId)
	self:HookDbmVar("GetUnitIdFromGUID", mocks.DBMGetUnitIdFromGUID)
	self:HookDbmVar("NumRealAlivePlayers", mocks.DBMNumRealAlivePlayers)
	self:HookDbmVar("UnitBuff", mocks.DBMUnitBuff)
	self:HookDbmVar("UnitDebuff", mocks.DBMUnitDebuff)
	self:HookDbmVar("UnitAura", mocks.DBMUnitAura)
	self:HookDbmVar("GetUnitFullName", mocks.DBMGetUnitFullName)
	table.wipe(threatInfo)
	table.wipe(unitsInCombat)
	table.wipe(bosses)
	table.wipe(unitTargets)
	table.wipe(unitAuras)
	table.wipe(unitPower)
	table.wipe(unitHealth)
	table.wipe(guids)
	table.wipe(namesToGuids)
end

function mocks:HookModGlobal(key, val)
	if rawget(self.modEnv, key) then
		error("tried to hook " .. key .. " twice in modEnv, this function must only be called once before all mods load")
	end
	local old = self.modEnv[key]
	if old and type(old) ~= "function" then
		-- if we need this implement it by making __index a function instead of a direct reference to _G
		-- (nil is supported because DBM-Offline doesn't bother adding fakes for everything as most things are mocked anyways)
		error("tried to hook " .. key .. " of type " .. type(old) .. ", only functions are supported for now")
	end
	self.modEnv[key] = function(...)
		if test.testRunning then
			return val(...)
		else
			return old(...)
		end
	end
end

-- Must be called before mods are loaded because they may cache pre-existing globals otherwise
function mocks:GetMockEnvironment()
	if self.modEnv then
		return self.modEnv
	end
	self.modEnv = setmetatable({}, {__index = _G})
	self:HookModGlobal("UnitPower", mocks.UnitPower)
	self:HookModGlobal("UnitPowerMax", mocks.UnitPowerMax)
	self:HookModGlobal("UnitHealth", mocks.UnitHealth)
	self:HookModGlobal("UnitHealthMax", mocks.UnitHealthMax)
	self:HookModGlobal("UnitExists", mocks.UnitExists)
	self:HookModGlobal("UnitGUID", mocks.UnitGUID)
	self:HookModGlobal("UnitDetailedThreatSituation", mocks.UnitDetailedThreatSituation)
	self:HookModGlobal("UnitAffectingCombat", mocks.UnitAffectingCombat)
	self:HookModGlobal("GetTime", mocks.GetTime)
	self:HookModGlobal("CombatLogGetCurrentEventInfo", mocks.CombatLogGetCurrentEventInfo)
	self:HookModGlobal("GetInstanceInfo", mocks.GetInstanceInfo)
	self:HookModGlobal("IsEncounterInProgress", mocks.IsEncounterInProgress)
	return self.modEnv
end

-- Called by DBM:NewMod() if tests are active, tests activate prior to loading the mod under test anyways to trace loading events
function mocks:SetModEnvironment(stackDepth)
	self:GetMockEnvironment()
	setfenv(stackDepth + 1, self.modEnv)
end

function mocks:IsModLoadedWithMocks(mod)
	local mockEnv = self:GetMockEnvironment()
	for _, v in pairs(mod) do
		if type(v) == "function" then
			if getfenv(v) == mockEnv then -- any function having that environment is good enough, this is just for showing a warning in the UI
				return true
			end
		end
	end
	return false
end

function test:TeardownHooks()
	self:UnhookPrivates()
	for _, mod in ipairs(DBM.Mods) do
		if self.restoreModVariables[mod] then
			for k, v in pairs(self.restoreModVariables[mod]) do
				if v == nilValue then
					mod[k] = nil
				else
					mod[k] = v
				end
			end
		end
		self.restoreModVariables[mod] = nil
	end
	if self.restoreDbmVariables then
		for k, v in pairs(self.restoreDbmVariables) do
			if v == nilValue then
				DBM[k] = nil
			else
				DBM[k] = v
			end
		end
	end
end
