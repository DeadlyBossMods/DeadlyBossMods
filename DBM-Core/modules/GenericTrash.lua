---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
if not (private.isRetail or private.isForever) or not DBM:IsPostMidnight() then return end

---@class GenericTrash: DBMModule
local module = private:NewModule("GenericTrash")
local difficulties = private:GetPrototype("Difficulties")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local inCombat = private.combatDetectionState.inCombat
local GetTime, GetInstanceInfo = GetTime, GetInstanceInfo
local UnitLevel, UnitClassification, UnitIsEnemy = UnitLevel, UnitClassification, UnitIsEnemy
local UnitAffectingCombat, UnitIsUnit = UnitAffectingCombat, UnitIsUnit
local UnitExists = UnitExists
local IsEncounterInProgress = private.IsEncounterInProgress

local registered, completed = false, false
local difficulty, instanceId, instanceType = 0, 0, 0
local optionPrefix
local optionPrefixes = {[2] = "GenericTrashDungeon", [3] = "GenericTrashRaid", [4] = "GenericTrashDelve"}
local zoneChecks, retries, previous = {}, {}, {}

local function cancelTimers(timers)
	for timer in pairs(timers) do
		timer:Cancel()
	end
	table.wipe(timers)
end

-- nil means ordinary trash; true/false means an enrolled/unenrolled boss encounter.
local function bossPermission()
	local enrolled = false
	for _, mod in ipairs(inCombat) do
		if not mod.isTrashMod and mod.combatInfo and mod.combatInfo.type ~= "scenario" then
			if not mod.enableGenericTrash or not mod.Options.Enabled then
				return false
			end
			enrolled = true
		end
	end
	if enrolled then return true end
	if private.isRetail and difficulty == 8 then
		-- Blizzard treats the whole key as an encounter, not just its bosses.
		for i = 1, 10 do
			if UnitExists("boss" .. i) then return false end
		end
	elseif IsEncounterInProgress() then
		return false
	end
end

local function eligible(permission)
	if not optionPrefix or not DBM.Options[optionPrefix .. "Enabled"] then return false end
	if private.isForever then return true end
	if difficulty == 8 then
		-- A completed key can retain difficulty 8, including across a UI reload.
		return instanceType == 2 and not completed and C_ChallengeMode.IsChallengeModeActive() and (permission == true or difficulties:IsSeasonalDungeon(instanceId) or DBM.Options.GenericTrashDungeonAllDungeons)
	end
	return permission == true or instanceType ~= 2 or DBM.Options.GenericTrashDungeonAllDungeons
end

function module:Deactivate()
	if registered then
		self:UnregisterShortTermEvents()
		registered = false
	end
	cancelTimers(retries)
	table.wipe(previous)
end

function module:CheckZone()
	local _, nativeType, difficultyId, _, _, _, _, mapId = GetInstanceInfo()
	local contentType
	if private.isForever then
		contentType = nativeType == "party" and 2 or nativeType == "raid" and 3 or 0
	else
		contentType = difficulties:InstanceType(mapId)
	end
	if mapId ~= instanceId or difficultyId ~= difficulty or contentType ~= instanceType then
		self:Deactivate()
	end
	difficulty, instanceId, instanceType = difficultyId, mapId, contentType
	optionPrefix = optionPrefixes[instanceType]
	if private.isForever and optionPrefix then
		optionPrefix = instanceType == 2 and "GenericTrashForeverDungeon" or "GenericTrashForeverRaid"
	end
	local extraCategory = private.isForever and "Elite" or instanceType ~= 3 and "Lieutenant"
	if not eligible(bossPermission()) or not (DBM.Options[optionPrefix .. "Cast"] or DBM.Options[optionPrefix .. "Channel"] or (extraCategory and DBM.Options[optionPrefix .. extraCategory])) then
		self:Deactivate()
	elseif not registered then
		self:RegisterShortTermEvents(
			"UNIT_SPELLCAST_START_UNFILTERED",
			"UNIT_SPELLCAST_SUCCEEDED_UNFILTERED",
			"UNIT_SPELLCAST_CHANNEL_START_UNFILTERED",
			"PLAYER_TARGET_CHANGED",
			"NAME_PLATE_UNIT_ADDED",
			"NAME_PLATE_UNIT_REMOVED"
		)
		registered = true
	end
end

---@param resetEncounter boolean? Clear pending casts and throttles after encounter/module state changes.
function DBM:UpdateGenericTrashOptions(resetEncounter)
	if resetEncounter then
		cancelTimers(retries)
		table.wipe(previous)
	end
	module:CheckZone()
end

function module:QueueZoneChecks()
	cancelTimers(zoneChecks)
	self:Deactivate()
	-- Core refreshes its zone/difficulty at 1/5 seconds; follow it at 2/6.
	for _, delay in ipairs({0, 2, 6}) do
		local timer
		timer = C_Timer.NewTimer(delay, function()
			zoneChecks[timer] = nil
			self:CheckZone()
		end)
		zoneChecks[timer] = true
	end
end

function module:OnModuleLoad()
	self:RegisterEvents("LOADING_SCREEN_DISABLED", "ZONE_CHANGED_NEW_AREA")
	if not private.isForever then
		self:RegisterEvents("CHALLENGE_MODE_START", "CHALLENGE_MODE_RESET", "CHALLENGE_MODE_COMPLETED")
	end
	self:QueueZoneChecks()
end

module.LOADING_SCREEN_DISABLED = module.QueueZoneChecks
module.ZONE_CHANGED_NEW_AREA = module.QueueZoneChecks

function module:CHALLENGE_MODE_START()
	completed = false
	self:QueueZoneChecks()
end

function module:CHALLENGE_MODE_COMPLETED()
	completed = true
	cancelTimers(zoneChecks)
	self:Deactivate()
end

module.CHALLENGE_MODE_RESET = module.CHALLENGE_MODE_COMPLETED

function module:NAME_PLATE_UNIT_REMOVED(unit)
	for timer, token in pairs(retries) do
		if token == unit then
			timer:Cancel()
			retries[timer] = nil
		end
	end
end

module.NAME_PLATE_UNIT_ADDED = module.NAME_PLATE_UNIT_REMOVED

function module:PLAYER_TARGET_CHANGED()
	self:NAME_PLATE_UNIT_REMOVED("target")
end

local function resolveFilter(isLieutenant, isNonElite)
	local suffix
	if private.isForever then
		suffix = isLieutenant and "EliteFilter" or "StandardFilter"
	else
		suffix = isNonElite and "NonEliteFilter" or isLieutenant and "LieutenantFilter" or "StandardFilter"
	end
	local allowOff = private.isForever and not isLieutenant or not private.isForever and isNonElite
	local key = optionPrefix .. suffix
	local value = DBM.Options[key]
	if value ~= "target" and value ~= "all" and value ~= "messagesAllSoundsTarget" and not (allowOff and value == "off") then
		value = DBM.DefaultOptions[key]
	end
	return value
end

function module:HandleCast(unit, spellID, channel, castBarID, succeeded, retried)
	if not registered or not DBM:IsEnabled() or not DBM.Options.Enabled then return end
	local permission = bossPermission()
	if not eligible(permission) then
		self:Deactivate()
		return
	end
	if permission == false then return end
	-- Event unit tokens are public; spell/cast identities may be opaque.
	if succeeded and (DBM:issecretvalue(castBarID) or (castBarID ~= nil and castBarID ~= false)) then return end
	local classification = UnitClassification(unit)
	local isNonElite = classification == "normal" or classification == "rare" or classification == "minus"
	local isLieutenant
	if private.isForever then
		if not isNonElite and classification ~= "elite" and classification ~= "rareelite" and classification ~= "worldboss" then return end
		isLieutenant = not isNonElite
	else
		local level = UnitLevel(unit)
		local playerLevel = private.playerLevel
		isLieutenant = level == playerLevel + 1 or level == playerLevel + 2 or level == -1
		if (level < playerLevel - 3 or level > playerLevel) and not isLieutenant then return end
		-- Raid trash uses standard settings regardless of supported mob level.
		isLieutenant = isLieutenant and instanceType ~= 3
		if not isNonElite and classification ~= "elite" and classification ~= "rareelite" then return end
	end
	local filter = resolveFilter(isLieutenant, isNonElite)
	if filter == "off" then return end
	if filter == "target" then
		if unit ~= "target" then return end
	elseif not unit:find("^nameplate") then
		return
	end
	local category = optionPrefix .. (channel and "Channel" or isLieutenant and (private.isForever and "Elite" or "Lieutenant") or "Cast")
	if not DBM.Options[category] or DBM.Options.DontShowBossAnnounces or DBM.Options.HideDBMWarnings then return end
	if not UnitIsEnemy("player", unit) then return end
	-- Private core modules do not inherit DBMMod helpers; use its restricted unit-token path.
	if not bossModPrototype:CheckBossDistance(unit, nil, nil, 48, false, true) then return end
	if not UnitAffectingCombat(unit) then
		if not retried then
			local timer
			timer = C_Timer.NewTimer(0.05, function()
				retries[timer] = nil
				self:HandleCast(unit, spellID, channel, castBarID, succeeded, true)
			end)
			retries[timer] = unit
		end
		return
	end

	local unitIsTarget = UnitIsUnit("target", unit)
	local durationKey = optionPrefix .. "ThrottleDuration"
	local duration = DBM.Options[durationKey]
	if type(duration) ~= "number" or duration < 1 or duration > 5 or duration % 0.5 ~= 0 then
		duration = DBM.DefaultOptions[durationKey]
	end
	local now = GetTime()
	local shouldAlert = unitIsTarget or now - (previous[category] or -math.huge) > duration
	if not shouldAlert and DBM.Options[optionPrefix .. "ThrottleType"] ~= "sounds" then return end
	if shouldAlert and not unitIsTarget then
		previous[category] = now
	end
	local useSound = shouldAlert and (unitIsTarget or filter ~= "messagesAllSoundsTarget")
	DBM:AddSecretGenericWarning(unit, spellID, channel and 3 or isLieutenant and 4 or 2, useSound, DBM.Options[optionPrefix .. "ShowTargets"])
end

function module:UNIT_SPELLCAST_START_UNFILTERED(unit, _, spellID)
	self:HandleCast(unit, spellID, false)
end

function module:UNIT_SPELLCAST_SUCCEEDED_UNFILTERED(unit, _, spellID, castBarID)
	self:HandleCast(unit, spellID, false, castBarID, true)
end

function module:UNIT_SPELLCAST_CHANNEL_START_UNFILTERED(unit, _, spellID)
	self:HandleCast(unit, spellID, true)
end
