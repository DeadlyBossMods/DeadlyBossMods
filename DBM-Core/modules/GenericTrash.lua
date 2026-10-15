---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
if not private.isRetail or not DBM:IsPostMidnight() then return end

---@class GenericTrash: DBMModule
local module = private:NewModule("GenericTrash")
local difficulties = private:GetPrototype("Difficulties")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local inCombat = private.combatDetectionState.inCombat
local GetTime, GetInstanceInfo = GetTime, GetInstanceInfo
local UnitLevel, UnitClassification, UnitIsEnemy = UnitLevel, UnitClassification, UnitIsEnemy
local UnitAffectingCombat, UnitIsUnit = UnitAffectingCombat, UnitIsUnit
local IsEncounterInProgress = IsEncounterInProgress

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

local function eligible()
	if not optionPrefix or not DBM.Options[optionPrefix .. "Enabled"] then return false end
	if difficulty == 8 then
		-- A completed key can retain difficulty 8, including across a UI reload.
		return instanceType == 2 and not completed and C_ChallengeMode.IsChallengeModeActive() and (difficulties:IsSeasonalDungeon(instanceId) or DBM.Options.GenericTrashDungeonAllDungeons)
	end
	return instanceType ~= 2 or DBM.Options.GenericTrashDungeonAllDungeons
end

local function bossFight()
	local allowBosses = instanceType == 4 and DBM.Options.GenericTrashDelveAllowBosses
	if not allowBosses and IsEncounterInProgress() then
		return true
	end
	for _, mod in ipairs(inCombat) do
		if mod.ignoreGenericTrash and mod.Options.Enabled then
			return true
		end
		if not allowBosses and not mod.isTrashMod and mod.addon and (mod.addon.type == "PARTY" or mod.addon.type == "RAID") then
			return true
		end
	end
	return false
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
	local _, _, difficultyId, _, _, _, _, mapId = GetInstanceInfo()
	if mapId ~= instanceId or difficultyId ~= difficulty then
		self:Deactivate()
	end
	difficulty, instanceId, instanceType = difficultyId, mapId, difficulties:InstanceType(mapId)
	optionPrefix = optionPrefixes[instanceType]
	if not eligible() or not (DBM.Options[optionPrefix .. "Cast"] or DBM.Options[optionPrefix .. "Channel"] or (instanceType ~= 3 and DBM.Options[optionPrefix .. "Lieutenant"])) then
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

function DBM:UpdateGenericTrashOptions()
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
	self:RegisterEvents("LOADING_SCREEN_DISABLED", "ZONE_CHANGED_NEW_AREA", "CHALLENGE_MODE_START", "CHALLENGE_MODE_RESET", "CHALLENGE_MODE_COMPLETED")
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
	local key = optionPrefix .. (isNonElite and "NonEliteFilter" or isLieutenant and "LieutenantFilter" or "StandardFilter")
	local value = DBM.Options[key]
	if value ~= "target" and value ~= "all" and value ~= "messagesAllSoundsTarget" and not (isNonElite and value == "off") then
		value = DBM.DefaultOptions[key]
	end
	return value
end

function module:HandleCast(unit, spellID, channel, castBarID, succeeded, retried)
	if not registered or not DBM:IsEnabled() or not DBM.Options.Enabled then return end
	if not eligible() then
		self:Deactivate()
		return
	end
	-- Event unit tokens are public; spell/cast identities may be opaque.
	if succeeded and (DBM:issecretvalue(castBarID) or (castBarID ~= nil and castBarID ~= false)) then return end
	local level = UnitLevel(unit)
	local isLieutenant = level == 91 or level == 92 or level == -1
	if level ~= 90 and not isLieutenant then return end
	-- Raid trash uses standard settings regardless of supported mob level.
	isLieutenant = isLieutenant and instanceType ~= 3
	local classification = UnitClassification(unit)
	local isNonElite = classification == "normal" or classification == "rare" or classification == "minus"
	if not isNonElite and classification ~= "elite" and classification ~= "rareelite" then return end
	local filter = resolveFilter(isLieutenant, isNonElite)
	if filter == "off" then return end
	if filter == "target" then
		if unit ~= "target" then return end
	elseif not unit:find("^nameplate") then
		return
	end
	local category = optionPrefix .. (channel and "Channel" or isLieutenant and "Lieutenant" or "Cast")
	if not DBM.Options[category] or DBM.Options.DontShowBossAnnounces or DBM.Options.HideDBMWarnings then return end
	if not UnitIsEnemy("player", unit) then return end
	-- Private core modules do not inherit DBMMod helpers; use its restricted unit-token path.
	if not bossModPrototype:CheckBossDistance(unit, nil, nil, 48, false, true) or bossFight() then return end
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
	DBM:AddSecretGenericWarning(unit, spellID, channel and 2 or isLieutenant and 3 or 4, useSound, DBM.Options[optionPrefix .. "ShowTargets"])
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
