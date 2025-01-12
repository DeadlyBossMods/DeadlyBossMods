---@class DBMCoreNamespace
local private = select(2, ...)

---@class TrashCombatScanningModule: DBMModule
local module = private:NewModule("TrashCombatScanningModule")
module:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

if DBM:IsPostMoP() then
	module:RegisterEvents("CHALLENGE_MODE_COMPLETED")
end

local registeredZones = {}--Global table for tracking registered zones
local registeredSyncZone = {}--Global table for tracking registered zones that use syncing
local ActiveGUIDs = {}--GUIDS we're flagged in combat with
local inCombat = false
local syncingActive = false
local currentZone = DBM:GetCurrentArea() or 0
--Only up to two cached mods at a time, since it's unlikely more than 2 mods will be scanning units at once
local affixesMod--Mythic+ or Raid affixes module
local lastUsedMod--Trash module for given zone
local cachedMods = {}

---Scan for new Unit Engages
---<br>This will break if more than one mod is scanning units at once, which shouldn't happen since you can't be in more than one dungeon at same time (and affixes doesn't monitor this)
---@param self DBMMod
local function ScanEngagedUnits(self, delay)
	--Scan mouseover
	if UnitAffectingCombat("mouseover") and not UnitIsFriend("mouseover", "player") then
		local guid = UnitGUID("mouseover")
		if guid and DBM:IsCreatureGUID(guid) then
			if not ActiveGUIDs[guid] then
				ActiveGUIDs[guid] = true
				local cid = DBM:GetCIDFromGUID(guid)
				self:StartEngageTimers(guid, cid, delay)
				DBM:Debug("Firing Engaged Unit for "..guid..". Scantime: "..delay, 3, nil, true)
			end
		end
	end
	--Scan softenemy
	if UnitAffectingCombat("softenemy") and not UnitIsFriend("softenemy", "player") then
		local guid = UnitGUID("softenemy")
		if guid and DBM:IsCreatureGUID(guid) then
			if not ActiveGUIDs[guid] then
				ActiveGUIDs[guid] = true
				local cid = DBM:GetCIDFromGUID(guid)
				self:StartEngageTimers(guid, cid, delay)
				DBM:Debug("Firing Engaged Unit for "..guid..". Scantime: "..delay, 3, nil, true)
			end
		end
	end
	--Iterate over all raid/party members and their targets
	local uId = (IsInRaid() and "raid") or "party"
	for i = 0, GetNumGroupMembers() do
		local id = (i == 0 and "target") or uId .. i .. "target"
		if UnitAffectingCombat(id) and not UnitIsFriend(id, "player") then
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				if not ActiveGUIDs[guid] then
					ActiveGUIDs[guid] = true
					local cid = DBM:GetCIDFromGUID(guid)
					self:StartEngageTimers(guid, cid, delay)
					DBM:Debug("Firing Engaged Unit for "..guid..". Scantime: "..delay, 3, nil, true)
					--WARNING. this is a REALLY shitty work around that will hit sync throttling quite rapidly
					if syncingActive and DBM.Options.ZoneCombatSyncing then--ZoneCombatSyncing is off by default due to above comment and can't be turned on via GUI
						private.sendSync(private.DBMSyncProtocol, "ZC", guid .. "\t" .. cid, "ALERT")
					end
				end
			end
		end
	end
	--Now scan nameplates
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		if foundUnit and UnitAffectingCombat(foundUnit) and not UnitIsFriend(foundUnit, "player") then
			local guid = UnitGUID(foundUnit)
			if guid and DBM:IsCreatureGUID(guid) then
				if not ActiveGUIDs[guid] then
					ActiveGUIDs[guid] = true
					local cid = DBM:GetCIDFromGUID(guid)
					self:StartEngageTimers(guid, cid, 0)
					DBM:Debug("Firing Engaged Unit for "..guid..". Scantime: "..delay, 3, nil, true)
				end
			end
		end
	end
	--Only run twice per second.
	DBM:Schedule(0.5, ScanEngagedUnits, self, 0.5)--Apply 0.5 delay on repeat scans
end

---@param delay number
local function checkForCombat(delay)
	local combatFound = DBM:GroupInCombat()
	if combatFound and not inCombat then
		inCombat = true
		DBM:Debug("Zone Combat Detected", 2, nil, true)
		if affixesMod then
			affixesMod:EnteringZoneCombat()
		end
		if lastUsedMod then
			if lastUsedMod.EnteringZoneCombat then
				lastUsedMod:EnteringZoneCombat()
			end
			if lastUsedMod.StartEngageTimers then
				ScanEngagedUnits(lastUsedMod, delay)--Apply only the pre combat delay on initial instant scan
				DBM:Debug("Starting Engaged Unit Scans", 2)
			end
		end
	elseif not combatFound and inCombat then
		inCombat = false
		table.wipe(ActiveGUIDs)--if no one is in combat, save to assume all engaged units gone
		DBM:Debug("Zone Combat Ended", 2, nil, true)
		if affixesMod then
			affixesMod:LeavingZoneCombat()
		end
		if lastUsedMod then
			if lastUsedMod.LeavingZoneCombat then
				lastUsedMod:LeavingZoneCombat()
			end
		end
		DBM:Unschedule(ScanEngagedUnits)
	end
end

local eventsRegistered = false
local function DelayedZoneCheck(force)
	currentZone = DBM:GetCurrentArea() or 0
	if not force and registeredZones[currentZone] and not eventsRegistered then
		eventsRegistered = true
		if registeredSyncZone[currentZone] then
			syncingActive = true
		end
		module:RegisterShortTermEvents(
			"UNIT_FLAGS player party1 party2 party3 party4",
			"PLAYER_REGEN_DISABLED",
			"PLAYER_REGEN_ENABLED"
		)
		if DBM:IsPostMoP() then
			module:RegisterShortTermEvents("CHALLENGE_MODE_DEATH_COUNT_UPDATED")
		end
		DBM:Unschedule(checkForCombat)
		checkForCombat(0)--Still run an initial check
		DBM:Debug("Registering Trash Tracking Events", 2)
		lastUsedMod = DBM:GetModByName(cachedMods[currentZone])
	elseif force or (not registeredZones[currentZone] and eventsRegistered) then
		eventsRegistered = false
		syncingActive = false
		inCombat = false
		table.wipe(ActiveGUIDs)
		lastUsedMod = nil
		module:UnregisterShortTermEvents()
		DBM:Unschedule(checkForCombat)
		DBM:Unschedule(ScanEngagedUnits)
		DBM:Debug("Unregistering Trash Tracking Events", 2)
	end
end
--Monitor bitflag of players, which should change with combat states
--Only party is monitored because main use case is dungeons and delves.
--And we don't want to waste performance in registered raids. 5 players should be enough to determine raid combat
function module:UNIT_FLAGS()
	--Use throttled delay to avoid checks running too often when multiple flags change at once
	if DBM:AntiSpam(0.1, "UNIT_FLAGS") then
		DBM:Unschedule(checkForCombat)
		DBM:Debug("DBM is scheduling combat checks", 3)--Temporary debug, it will clutter transcriptor logs
		--Delay check til next frame to ensure flags are updated
		DBM:Schedule(0.1, checkForCombat, 0.1)
		DBM:Schedule(0.25, checkForCombat, 0.25)
		DBM:Schedule(0.5, checkForCombat, 0.5)
		DBM:Schedule(0.75, checkForCombat, 0.75)
	end
end
--Sometimes UNIT_FLAGS doesn't fire if group is spead out, so we track backup events that can indicate combat status changed
module.CHALLENGE_MODE_DEATH_COUNT_UPDATED	= module.UNIT_FLAGS
module.PLAYER_REGEN_DISABLED	= module.UNIT_FLAGS
module.PLAYER_REGEN_ENABLED	= module.UNIT_FLAGS

function module:LOADING_SCREEN_DISABLED()
	if DBM:AntiSpam(0.1, "DelayedZoneCheck") then
		DBM:Unschedule(DelayedZoneCheck)
		--Checks Delayed 3 second after core checks to prevent race condition of checking before core did and updated cached ID
		--Delayed 2 seconds longer than Affixes mod so there is no race condition. Affixes needs to register events first
		DBM:Schedule(4, DelayedZoneCheck)
		DBM:Schedule(8, DelayedZoneCheck)
	end
end
module.OnModuleLoad = module.LOADING_SCREEN_DISABLED
module.ZONE_CHANGED_NEW_AREA	= module.LOADING_SCREEN_DISABLED
function module:CHALLENGE_MODE_COMPLETED()
	--This basically force unloads things even when in a dungeon, so it's not scanning trash that doesn't fight back
	DelayedZoneCheck(true)
end

function module:ENCOUNTER_START()
	--This basically force unloads things in a raid, since we're not typically fighting trash during a raid boss
	--Also force disables zone syncing
	syncingActive = false
	if IsInRaid() then
		DelayedZoneCheck(true)
	else
		--If we're in a dungeon, we use it as yet another redundant combat check
		if registeredZones and DBM:AntiSpam(0.25, "UNIT_FLAGS") then
			DBM:Unschedule(checkForCombat)
			DBM:Schedule(0.1, checkForCombat, 0.1)
			DBM:Schedule(0.25, checkForCombat, 0.25)
			DBM:Schedule(0.5, checkForCombat, 0.5)
			DBM:Schedule(0.75, checkForCombat, 0.75)
		end
	end
end

function module:ENCOUNTER_END()
	--Restore trash registered zone combat events if there are any
	if registeredSyncZone[currentZone] then
		syncingActive = true
	end
	if IsInRaid() then
		DelayedZoneCheck()
	else
		--If we're in a dungeon, we use it as yet another redundant combat check
		if registeredZones and DBM:AntiSpam(0.25, "UNIT_FLAGS") then
			DBM:Unschedule(checkForCombat)
			DBM:Schedule(0.1, checkForCombat, 0.1)
			DBM:Schedule(0.25, checkForCombat, 0.25)
			DBM:Schedule(0.5, checkForCombat, 0.5)
			DBM:Schedule(0.75, checkForCombat, 0.75)
		end
	end
end

function module:OnSync(sender, guid, cid)
	if not ActiveGUIDs[guid] then
		ActiveGUIDs[guid] = true
		lastUsedMod:StartEngageTimers(guid, cid, 0)
		DBM:Debug("Firing Synced Engaged Unit for "..guid, 3, nil, true)
	end
end

---Used for registering combat with enemies that don't support conventional means (such as dungeon trash)
---@param zone number Instance ID of the zone
---@param modId? string|number The mod id to register for combat scanning
---@param useSyncing boolean? If true, this mod will use syncing for combat scanning to solve range issues
function bossModPrototype:RegisterZoneCombat(zone, modId, useSyncing)
	modId = modId or self.id
	if DBM.Options.NoCombatScanningFeatures then return end
	if not registeredZones[zone] then
		registeredZones[zone] = true
	end
	if not registeredSyncZone[zone] then
		registeredSyncZone[zone] = useSyncing
	end
	if modId == "MPlusAffixes" then
		affixesMod = DBM:GetModByName(modId)--Just cache mod outright, it'll never change
		DBM:Debug("|cffff0000Registered affixesMod for modID: |r"..modId, 2, nil, true)
	elseif not cachedMods[zone] then
		cachedMods[zone] = modId
		DBM:Debug("|cffff0000Registered cachedMods for modID: |r"..modId, 2, nil, true)
	end
	module:LOADING_SCREEN_DISABLED()
end

---@param zone number Instance ID of the zone
---@param modId? string|number The mod id to register for combat scanning
function bossModPrototype:UnregisterZoneCombat(zone, modId)
	modId = modId or self.id
	if DBM.Options.NoCombatScanningFeatures then return end
	if not registeredZones[zone] then
		registeredZones[zone] = nil
	end
	DelayedZoneCheck()--trigger unregister
	local mod = DBM:GetModByName(modId)
	if affixesMod == mod then
		affixesMod = nil
		DBM:Debug("Unregistered affixesMod for modID: "..modId, 2, nil, true)
	elseif cachedMods[zone] == modId then
		cachedMods[zone] = nil
		DBM:Debug("Unregistered cachedMods for modID: "..modId, 2, nil, true)
	end
end

do
	local bossUids = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "boss6", "boss7", "boss8", "boss9", "boss10"
	}

	---@param self DBMMod
	---@param scanTime number amount of time to subtrack from timers
	---@param maxScanTime number Max Scan time before giving up
	local function ScanEngagedBossUnits(self, scanTime, maxScanTime)
		--Scan Common Boss Units and mouseovers
		for _, unitId in ipairs(bossUids) do
			if UnitAffectingCombat(unitId) then
				local guid = UnitGUID(unitId)
				if guid and DBM:IsCreatureGUID(guid) then
					if not ActiveGUIDs[guid] then
						ActiveGUIDs[guid] = true
						local cid = DBM:GetCIDFromGUID(guid)
						self:StartEngageTimers(guid, cid, scanTime)
						DBM:Debug("Firing Engaged Unit for "..guid..". Scantime: "..scanTime, 3, nil, true)
					end
				end
			end
		end
		if maxScanTime == scanTime then return end
		DBM:Schedule(0.5, ScanEngagedBossUnits, self, scanTime+0.5, maxScanTime)
	end
	---Used to scan for boss Units on engage for starging nameplate timers on council type boss encounters
	---<br>Uses mod:StartEngageTimers(guid, cid, scanTime) as return function to start timers
	---@param maxScanTime number?
	function bossModPrototype:RegisterBossUnitScan(maxScanTime)
		ScanEngagedBossUnits(self, 0, maxScanTime or 3)
	end
end
