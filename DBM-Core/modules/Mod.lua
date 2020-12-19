local DBM, L = DBM, DBM_CORE_L

local error, ipairs, select, setmetatable, tonumber, tostring, type = error, ipairs, select, setmetatable, tonumber, tostring, type
local ssplit, ssub, tconcat, tinsert, tremove, tsort, twipe = string.split, string.sub, table.concat, table.insert, table.remove, table.sort, table.wipe
local C_TimerNewTicker = C_Timer.NewTicker

local playerName = UnitName("player")

local SWFilterDisabed = 11

local standardFont
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

local function releaseDate(year, month, day, hour, minute, second)
	hour = hour or 0
	minute = minute or 0
	second = second or 0
	return second + minute * 10^2 + hour * 10^4 + day * 10^6 + month * 10^8 + year * 10^10
end

local function parseCurseDate(date)
	date = tostring(date)
	if #date == 13 then
		-- support for broken curse timestamps: leading 0 in hours is missing...
		date = date:sub(1, 8) .. "0" .. date:sub(9, #date)
	end
	local year, month, day, hour, minute, second = tonumber(date:sub(1, 4)), tonumber(date:sub(5, 6)), tonumber(date:sub(7, 8)), tonumber(date:sub(9, 10)), tonumber(date:sub(11, 12)), tonumber(date:sub(13, 14))
	if year and month and day and hour and minute and second then
		return releaseDate(year, month, day, hour, minute, second)
	end
end

local function stripServerName(cap)
	return DBM:GetShortServerName(cap:sub(2, -2))
end

local function scheduleRepeat(time, spellId, func, mod, self, ...)
	--Loops until debuff is gone
	if DBM:UnitAura("player", spellId) then--GetPlayerAuraBySpellID
		func(...)--Probably not going to work, this is going to need to get a lot more hacky
		DBM:Schedule(time or 2, scheduleRepeat, time, spellId, func, mod, self, ...)
	end
end

local function scheduleCountdown(time, numAnnounces, func, mod, self, ...)
	time = time or 5
	numAnnounces = numAnnounces or 3
	for i = 1, numAnnounces do
		--In event time is < numbmer of announces (ie 2 second time, with 3 announces)
		local validTime = time - i
		if validTime >= 1 then
			DBM:Schedule(validTime, func, mod, self, i, ...)
		end
	end
end

local function checkEntry(t, val)
	for _, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			existed = true
		end
	end
	return existed
end

local pformat
do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
	local function replace(cap1, cap2)
		return cap1 == "%" and L.UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s<]+)", replace):gsub("%%%%", "%%")
	end
end

local bossModPrototype = {}

do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab, instanceId, nameModifier)
		name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
		if name == "DBM-ProfilesDummy" then return end
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				DefaultOptions = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "timer", "sound", "yell", "nameplate", "icon", "misc"},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				vb = {},
				iconRestore = {},
				modId = modId,
				instanceId = instanceId,
				revision = 0,
				SyncThreshold = 8,
				localization = self:GetModLocalization(name)
			},
			mt
		)
		for _, v in ipairs(self.AddOns) do
			if v.modId == modId then
				obj.addon = v
				break
			end
		end

		if tonumber(name) and EJ_GetEncounterInfo then
			local t = EJ_GetEncounterInfo(tonumber(name))
			if type(nameModifier) == "number" then--Get name form EJ_GetCreatureInfo
				t = select(2, EJ_GetCreatureInfo(nameModifier, tonumber(name)))
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = tostring(t)
				t = ssplit(",", t or name)
			end
			obj.localization.general.name = t or name
			obj.modelId = select(4, EJ_GetCreatureInfo(1, tonumber(name)))
		elseif name:match("z%d+") then
			local t = GetRealZoneText(ssub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = ssplit(",", t or name)
			end
			obj.localization.general.name = t or name
		elseif name:match("d%d+") then
			local t = GetDungeonInfo(ssub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = ssplit(",", t or name)
			end
			obj.localization.general.name = t or name
		else
			obj.localization.general.name = obj.localization.general.name or name
		end
		tinsert(self.Mods, obj)
		if modId then
			self.ModLists[modId] = self.ModLists[modId] or {}
			tinsert(self.ModLists[modId], name)
		end
		modsById[name] = obj
		obj:SetZone()
		return obj
	end

	function DBM:GetModByName(name)
		return modsById[tostring(name)]
	end
end

-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.UnregisterInCombatEvents = DBM.UnregisterInCombatEvents
bossModPrototype.AddMsg = DBM.AddMsg
bossModPrototype.RegisterShortTermEvents = DBM.RegisterShortTermEvents
bossModPrototype.UnregisterShortTermEvents = DBM.UnregisterShortTermEvents

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		self.zones = {}
		if self.addon and self.addon.mapId then
			for _, v in ipairs(self.addon.mapId) do
				self.zones[v] = true
			end
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {}
		for i = 1, select("#", ...) do
			self.zones[select(i, ...)] = true
		end
	else -- disable zone detection
		self.zones = nil
	end
end

function bossModPrototype:Toggle()
	if self.Options.Enabled then
		self:DisableMod()
	else
		self:EnableMod()
	end
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self:Stop()
	self.Options.Enabled = false
end

function bossModPrototype:Stop()
	for _, v in ipairs(self.timers) do
		v:Stop()
	end
	self:Unschedule()
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	DBM.StartScheduler()
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	DBM.updateFunctions[self] = func
end

function bossModPrototype:UnregisterOnUpdateHandler()
	self.elapsed = nil
	self.updateInterval = nil
	twipe(DBM.updateFunctions)
end

function bossModPrototype:RegisterEventsInCombat(...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.inCombatOnlyEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
		end
	end
end

function bossModPrototype:IsDifficulty(...)
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsLFR()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "lfr" or diff == "lfr25" then
		return true
	end
	return false
end

--Dungeons: normal, heroic. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic5" or diff == "normal5" then
		return true
	end
	return false
end

--Dungeons: normal, heroic. Raids: LFR, normal
function bossModPrototype:IsEasy()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normal" or diff == "lfr" or diff == "lfr25" or diff == "heroic5" or diff == "normal5" then
		return true
	end
	return false
end

--Dungeons: mythic, mythic+. Raids: heroic, mythic
function bossModPrototype:IsHard()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "mythic" or diff == "challenge5" or diff == "heroic" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has a normal mode
function bossModPrototype:IsNormal()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normal" or diff == "normal5" or diff == "normal10" or diff == "normal20" or diff == "normal25" or diff == "normal40" or diff == "normalisland" or diff == "normalwarfront" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has a heroic mode
function bossModPrototype:IsHeroic()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic" or diff == "heroic5" or diff == "heroic10" or diff == "heroic25" or diff == "heroicisland" or diff == "heroicwarfront" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has mythic mode, with mythic+ included
function bossModPrototype:IsMythic()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "mythic" or diff == "challenge5" or diff == "mythicisland" then
		return true
	end
	return false
end

function bossModPrototype:IsEvent()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "event5" or diff == "event20" or diff == "event40" then
		return true
	end
	return false
end

function bossModPrototype:IsWarfront()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalwarfront" or diff == "heroicwarfront" then
		return true
	end
	return false
end

function bossModPrototype:IsIsland()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalisland" or diff == "heroicisland" or diff == "mythicisland" then
		return true
	end
	return false
end

function bossModPrototype:IsScenario()
	local diff = DBM.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalscenario" or diff == "heroicscenario" then
		return true
	end
	return false
end

function bossModPrototype:IsValidWarning(sourceGUID, customunitID, loose)
	if loose and InCombatLockdown() and GetNumGroupMembers() < 2 then return true end--In a loose check, this basically just checks if we're in combat, important for solo runs of torghast to not gimp mod too much
	if customunitID then
		if UnitExists(customunitID) and UnitGUID(customunitID) == sourceGUID and UnitAffectingCombat(customunitID) then return true end
	else
		for uId in DBM:GetGroupMembers() do
			local target = uId.."target"
			if UnitExists(target) and UnitGUID(target) == sourceGUID and UnitAffectingCombat(target) then return true end
			local targettwo = uId.."targettarget"
			if UnitExists(targettwo) and UnitGUID(targettwo) == sourceGUID and UnitAffectingCombat(targettwo) then return true end
		end
	end
	return false
end

--force param is used when CheckInterruptFilter is actually being used for a simpe target/focus check and nothing more.
--checkCooldown should never be passed with skip or COUNT interrupt warnings. It should be passed with any other interrupt filter
function bossModPrototype:CheckInterruptFilter(sourceGUID, force, checkCooldown, ignoreTandF)
	if DBM.Options.FilterInterrupt2 == "None" and not force then return true end--user doesn't want to use interrupt filter, always return true
	if DBM.Options.FilterInterrupt2 == "Always" and not force then return false end--user wants to filter ALL interrupts, always return false
	--Pummel, Mind Freeze, Counterspell, Kick, Skull Bash, Rebuke, Silence, Wind Shear, Disrupt, Solar Beam
	local InterruptAvailable = true
	local requireCooldown = checkCooldown
	if (DBM.Options.FilterInterrupt2 == "onlyTandF") or self.isTrashMod and (DBM.Options.FilterInterrupt2 == "TandFandBossCooldown") then
		requireCooldown = false
	end
	if requireCooldown and (UnitIsDeadOrGhost("player") or (GetSpellCooldown(6552)) ~= 0 or (GetSpellCooldown(47528)) ~= 0 or (GetSpellCooldown(282151)) ~= 0 or (GetSpellCooldown(2139)) ~= 0 or (GetSpellCooldown(1766)) ~= 0 or (GetSpellCooldown(106839)) ~= 0 or (GetSpellCooldown(96231)) ~= 0 or (GetSpellCooldown(15487)) ~= 0 or (GetSpellCooldown(57994)) ~= 0 or (GetSpellCooldown(183752)) ~= 0 or (GetSpellCooldown(78675)) ~= 0) then
		InterruptAvailable = false--checkCooldown check requested and player has no spell that can interrupt available (or is dead)
	end
	local unitID = (UnitGUID("target") == sourceGUID) and "target" or (UnitGUID("focus") == sourceGUID) and "focus" or nil
	if InterruptAvailable and (ignoreTandF or unitID) then
		--Check if it's casting something that's not interruptable at the moment
		--needed for torghast since many mobs can have interrupt immunity with same spellIds as other mobs that can be interrupted
		if unitID then
			if UnitCastingInfo(unitID) then
				local _, _, _, _, _, _, _, notInterruptible = UnitCastingInfo(unitID)
				if notInterruptible then return false end
			elseif UnitChannelInfo(unitID) then
				local _, _, _, _, _, _, notInterruptible = UnitChannelInfo(unitID)
				if notInterruptible then return false end
			end
		end
		return true
	end
	return false
end

function bossModPrototype:CheckDispelFilter()
	if not DBM.Options.FilterDispel then return true end
	--Druid: Nature's Cure (88423), Remove Corruption (2782), Monk: Detox (115450) Monk: Detox (218164), Priest: Purify (527) Priest: Purify Disease (213634), Paladin: Cleanse (4987), Shaman: Cleanse Spirit (51886), Purify Spirit (77130), Mage: Remove Curse (475), Warlock: Singe Magic (89808)
	--start, duration, enable = GetSpellCooldown
	--start & duration == 0 if spell not on cd
	if UnitIsDeadOrGhost("player") then return false end--if dead, can't dispel
	if (GetSpellCooldown(88423)) ~= 0 or (GetSpellCooldown(2782)) ~= 0 or (GetSpellCooldown(115450)) ~= 0 or (GetSpellCooldown(218164)) ~= 0 or (GetSpellCooldown(527)) ~= 0 or (GetSpellCooldown(213634)) ~= 0 or (GetSpellCooldown(4987)) ~= 0 or (GetSpellCooldown(51886)) ~= 0 or (GetSpellCooldown(77130)) ~= 0 or (GetSpellCooldown(475)) ~= 0 or (GetSpellCooldown(89808)) ~= 0 then
		return false
	end
	return true
end

function bossModPrototype:IsCriteriaCompleted(criteriaIDToCheck)
	if not criteriaIDToCheck then
		geterrorhandler()("usage: mod:IsCriteriaComplected(criteriaId)")
		return false
	end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	for i = 1, numCriteria do
		local _, _, criteriaCompleted, _, _, _, _, _, criteriaID = C_Scenario.GetCriteriaInfo(i)
		if criteriaID == criteriaIDToCheck and criteriaCompleted then
			return true
		end
	end
	return false
end

function bossModPrototype:LatencyCheck(custom)
	return select(4, GetNetStats()) < (custom or DBM.Options.LatencyThreshold)
end

function bossModPrototype:CheckBigWigs(name)
	local unit = DBM:GetRaidUnit(name)
	if unit and unit.bwversion then
		return unit.bwversion
	else
		return false
	end
end

bossModPrototype.IconNumToString = DBM.IconNumToString
bossModPrototype.IconNumToTexture = DBM.IconNumToTexture
bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.HasMapRestrictions = DBM.HasMapRestrictions
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby
bossModPrototype.IsTrivial = DBM.IsTrivial

do
	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "focus", "target"
	}
	local targetScanCount = {}
	local repeatedScanEnabled = {}

	local function getBossTarget(guid, scanOnlyBoss)
		local name, uid, bossuid
		local cacheuid = DBM.bossuIdCache[guid] or "boss1"
		if UnitGUID(cacheuid) == guid then
			bossuid = cacheuid
			name = DBM:GetUnitFullName(cacheuid.."target")
			uid = cacheuid.."target"
			DBM.bossuIdCache[guid] = bossuid
		end
		if name then return name, uid, bossuid end
		for _, uId in ipairs(bossTargetuIds) do
			if UnitGUID(uId) == guid then
				bossuid = uId
				name = DBM:GetUnitFullName(uId.."target")
				uid = uId.."target"
				DBM.bossuIdCache[guid] = bossuid
				break
			end
		end
		if name or scanOnlyBoss then return name, uid, bossuid end
		-- Now lets check nameplates
		for i = 1, 40 do
			if UnitGUID("nameplate"..i) == guid then
				bossuid = "nameplate"..i
				name = DBM:GetUnitFullName("nameplate"..i.."target")
				uid = "nameplate"..i.."target"
				DBM.bossuIdCache[guid] = bossuid
				break
			end
		end
		if name then return name, uid, bossuid end
		-- failed to detect from default uIds, scan all group members's target.
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if UnitGUID("raid"..i.."target") == guid then
					bossuid = "raid"..i.."target"
					name = DBM:GetUnitFullName("raid"..i.."targettarget")
					uid = "raid"..i.."targettarget"
					DBM.bossuIdCache[guid] = bossuid
					break
				end
			end
		elseif IsInGroup() then
			for i = 1, GetNumSubgroupMembers() do
				if UnitGUID("party"..i.."target") == guid then
					bossuid = "party"..i.."target"
					name = DBM:GetUnitFullName("party"..i.."targettarget")
					uid = "party"..i.."targettarget"
					DBM.bossuIdCache[guid] = bossuid
					break
				end
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:GetBossTarget(cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		if type(cidOrGuid) == "number" then
			cidOrGuid = cidOrGuid or self.creatureId
			local cacheuid = DBM.bossuIdCache[cidOrGuid] or "boss1"
			if self:GetUnitCreatureId(cacheuid) == cidOrGuid then
				DBM.bossuIdCache[cidOrGuid] = cacheuid
				DBM.bossuIdCache[UnitGUID(cacheuid)] = cacheuid
				name, uid, bossuid = getBossTarget(UnitGUID(cacheuid), scanOnlyBoss)
			else
				local found = false
				for _, uId in ipairs(bossTargetuIds) do
					if self:GetUnitCreatureId(uId) == cidOrGuid then
						found = true
						DBM.bossuIdCache[cidOrGuid] = uId
						DBM.bossuIdCache[UnitGUID(uId)] = uId
						name, uid, bossuid = getBossTarget(UnitGUID(uId), scanOnlyBoss)
						break
					end
				end
				if not found and not scanOnlyBoss then
					if IsInRaid() then
						for i = 1, GetNumGroupMembers() do
							if self:GetUnitCreatureId("raid"..i.."target") == cidOrGuid then
								DBM.bossuIdCache[cidOrGuid] = "raid"..i.."target"
								DBM.bossuIdCache[UnitGUID("raid"..i.."target")] = "raid"..i.."target"
								name, uid, bossuid = getBossTarget(UnitGUID("raid"..i.."target"))
								break
							end
						end
					elseif IsInGroup() then
						for i = 1, GetNumSubgroupMembers() do
							if self:GetUnitCreatureId("party"..i.."target") == cidOrGuid then
								DBM.bossuIdCache[cidOrGuid] = "party"..i.."target"
								DBM.bossuIdCache[UnitGUID("party"..i.."target")] = "party"..i.."target"
								name, uid, bossuid = getBossTarget(UnitGUID("party"..i.."target"))
								break
							end
						end
					end
				end
			end
		else
			name, uid, bossuid = getBossTarget(cidOrGuid, scanOnlyBoss)
		end
		if uid then
			local cid = DBM:GetUnitCreatureId(uid)
			if cid == 24207 or cid == 80258 or cid == 87519 then--filter army of the dead/Garrison Footman (basically same thing as army)
				return nil, nil, nil
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:BossTargetScannerAbort(cidOrGuid, returnFunc)
		targetScanCount[cidOrGuid] = nil--Reset count for later use.
		self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
		DBM:Debug("Boss target scan for "..cidOrGuid.." should be aborting.", 3)
	end

	function bossModPrototype:BossUnitTargetScannerAbort(uId)
		if not uId then--Not called with unit, means mod requested to clear all used units
			DBM:Debug("BossUnitTargetScannerAbort called without unit, clearing all targetMonitor units", 2)
			twipe(DBM.targetMonitor)
			return
		end
		if DBM.targetMonitor[uId] and DBM.targetMonitor[uId].allowTank and UnitExists(uId.."target") and UnitPlayerOrPetInRaid(uId.."target") then
			self:Debug("targetMonitor unit exists, allowTank target exists", 2)
			local modId, returnFunc = DBM.targetMonitor[uId].modid, DBM.targetMonitor[uId].returnFunc
			self:Debug("targetMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			local mod = self:GetModByName(modId)
			self:Debug("targetMonitor found a target that probably is a tank", 2)
			mod[returnFunc](mod, self:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
		end
		DBM.targetMonitor[uId] = nil
		DBM:Debug("Boss unit target scan should be aborting for "..uId, 3)
	end

	function bossModPrototype:BossUnitTargetScanner(uId, returnFunc, scanTime, allowTank)
		--UNIT_TARGET event monitor target scanner. Will instantly detect a target change of a registered Unit
		--If target change occurs before this method is called (or if boss doesn't change target because cast ends up actually being on the tank, target scan will fail completely
		--If allowTank is passed, it basically tells this scanner to return current target of unitId at time of failure/abort when scanTime is complete
		local scanDuration = scanTime or 1.5
		DBM.targetMonitor[uId] = {}
		DBM.targetMonitor[uId].modid, DBM.targetMonitor[uId].returnFunc, DBM.targetMonitor[uId].allowTank = self.id, returnFunc, allowTank
		self:ScheduleMethod(scanDuration, "BossUnitTargetScannerAbort", uId)--In case of BossUnitTargetScanner firing too late, and boss already having changed target before monitor started, it needs to abort after x seconds
	end

	function bossModPrototype:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter, onlyPlayers)
		--Increase scan count
		cidOrGuid = cidOrGuid or self.creatureId
		if not cidOrGuid then return end
		if not targetScanCount[cidOrGuid] then targetScanCount[cidOrGuid] = 0 end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		scanInterval = scanInterval or 0.05
		scanTimes = scanTimes or 16
		local targetname, targetuid, bossuid = self:GetBossTarget(cidOrGuid, scanOnlyBoss)
		DBM:Debug("Boss target scan "..targetScanCount[cidOrGuid].." of "..scanTimes..", found target "..(targetname or "nil").." using "..(bossuid or "nil"), 3)--Doesn't hurt to keep this, as level 3
		--Do scan
		if targetname and targetname ~= L.UNKNOWN and (not targetFilter or (targetFilter and targetFilter ~= targetname)) then
			if not IsInGroup() then scanTimes = 1 end--Solo, no reason to keep scanning, give faster warning. But only if first scan is actually a valid target, which is why i have this check HERE
			if (isEnemyScan and UnitIsFriend("player", targetuid) or (onlyPlayers and not UnitIsPlayer("player", targetuid)) or self:IsTanking(targetuid, bossuid)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player. On Only player, ignore npcs and pets
				if targetScanCount[cidOrGuid] < scanTimes then--Make sure no infinite loop.
					self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan, or npc/pet on only person)
				else--Go final scan.
					self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers)
				end
			else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				if (tankFilter and self:IsTanking(targetuid, bossuid)) or (isFinalScan and isEnemyScan) or onlyPlayers and not UnitIsPlayer("player", targetuid) then return end--If enemyScan and playerDetected, return nothing
				local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
				self[returnFunc](self, targetname, targetuid, bossuid, scanningTime)--Return results to warning function with all variables.
			end
		else--target was nil, lets schedule a rescan here too.
			if targetScanCount[cidOrGuid] < scanTimes then--Make sure not to infinite loop here as well.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers)
			else
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
			end
		end
	end

	--infinite scanner. so use this carefully.
	local function repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		if repeatedScanEnabled[returnFunc] then
			cidOrGuid = cidOrGuid or mod.creatureId
			scanInterval = scanInterval or 0.1
			local targetname, targetuid, bossuid = mod:GetBossTarget(cidOrGuid, scanOnlyBoss)
			if targetname and (includeTank or not mod:IsTanking(targetuid, bossuid)) then
				mod[returnFunc](mod, targetname, targetuid, bossuid)
			end
			DBM:Schedule(scanInterval, repeatedScanner, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		end
	end

	function bossModPrototype:StartRepeatedScan(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		repeatedScanEnabled[returnFunc] = true
		repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, self)
	end

	function bossModPrototype:StopRepeatedScan(returnFunc)
		repeatedScanEnabled[returnFunc] = nil
	end
end

do
	local bossCache = {}
	local lastTank

	function bossModPrototype:GetCurrentTank(cidOrGuid)
		if lastTank and GetTime() - (bossCache[cidOrGuid] or 0) < 2 then -- return last tank within 2 seconds of call
			return lastTank
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for GetCurrentTank we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				bossCache[cidOrGuid] = GetTime()
				lastTank = UnitName(uId)
				return UnitName(lastTank), uId
			end
			return false
		end
	end
end

--Now this function works perfectly. But have some limitation due to DBM.RangeCheck:GetDistance() function.
--Unfortunely, DBM.RangeCheck:GetDistance() function cannot reflects altitude difference. This makes range unreliable.
--So, we need to cafefully check range in difference altitude (Especially, tower top and bottom)
do
	local rangeCache = {}
	local rangeUpdated = {}

	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		if uId then
			itemId = itemId or 32698
			local inRange = IsItemInRange(itemId, uId)
			if inRange then--IsItemInRange was a success
				return inRange
			else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
				DBM:Debug("CheckBossDistance failed on IsItemInRange for: "..cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, nil, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: "..cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	function bossModPrototype:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		distance = distance or 43
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			if rangeCache[cidOrGuid] > distance then
				return false
			else
				return true
			end
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid, onlyBoss)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				if UnitIsUnit(uId, "player") then return true end--If "player" is target, avoid doing any complicated stuff
				if not UnitIsPlayer(uId) then
					local inRange2, checkedRange = UnitInRange(uId)--43
					if checkedRange then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
						return inRange2 and true or false
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						return true
					end
				end
				local inRange =  DBM.RangeCheck:GetDistance("player", uId)--We check how far we are from the tank who has that boss
				rangeCache[cidOrGuid] = inRange
				rangeUpdated[cidOrGuid] = GetTime()
				if inRange and (inRange > distance) then--You are not near the person tanking boss
					return false
				end
				--Tank in range, return true.
				return true
			end
			DBM:Debug("CheckTankDistance failed on uId for: "..cidOrGuid, 2)
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

---------------------
--  Class Methods  --
---------------------
do
	--[[local specFlags ={
		["Tank"] = true,
		["Dps"] = true,
		["Healer"] = true,
		["Melee"] = true,--ANY melee, including tanks or healers that are 100% excempt from healer/ranged mechanics (like mistweaver monks)
		["MeleeDps"] = true,
		["Physical"] = true,
		["Ranged"] = true,--ANY ranged, healer and dps included
		["RangedDps"] = true,--Only ranged dps
		["ManaUser"] = true,--Affected by things like mana drains, or mana detonation, etc
		["SpellCaster"] = true,--Has channeled casts, can be interrupted/spell locked by roars, etc, include healers. Use CasterDps if dealing with reflect
		["CasterDps"] = true,--Ranged dps that uses spells, relevant for spell reflect type abilities that only reflect spells but not ranged physical such as hunters
		["RaidCooldown"] = true,
		["RemovePoison"] = true,--from ally
		["RemoveDisease"] = true,--from ally
		["RemoveCurse"] = true,--from ally
		["RemoveMagic"] = true,--from ally
		["RemoveEnrage"] = true,--Can remove enemy enrage. returned in 8.x+!
		["MagicDispeller"] = true,--from ENEMY, not debuffs on players. use "Healer" or "RemoveMagic" for ally magic dispels. ALL healers can do that on retail, and warlock Imps
		["ImmunityDispeller"] = true,--Priest mass dispel or Warrior Shattering Throw (shadowlands)
		["HasInterrupt"] = true,--Has an interrupt that is 24 seconds or less CD that is BASELINE (not a talent)
		["HasImmunity"] = true,--Has an immunity that can prevent or remove a spell effect (not just one that reduces damage like turtle or dispursion)
	}]]

	local specRoleTable = {
		[62] = {	--Arcane Mage
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
			["RemoveCurse"] = true,
		},
		[1449] = {	--Initial Mage (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
		[65] = {	--Holy Paladin
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Devotion Aura
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["HasImmunity"] = true,
		},
		[66] = {	--Protection Paladin
			["Tank"] = true,
			["Melee"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[70] = {	--Retribution Paladin
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[1451] = {	--Initial Paladin (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Healer"] = true,
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["SpellCaster"] = true,
		},
		[71] = {	--Arms Warrior
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["Physical"] = true,
			["HasInterrupt"] = true,
			["ImmunityDispeller"] = true,
		},
		[73] = {	--Protection Warrior
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["ImmunityDispeller"] = true,
		},
		[1446] = {	--Initial Warrior (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[102] = {	--Balance Druid
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["RemoveEnrage"] = true,
		},
		[103] = {	--Feral Druid
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[104] = {	--Guardian Druid
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[105] = {	-- Restoration Druid
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Tranquility
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["RemoveEnrage"] = true,
			["RemoveMagic"] = true,
		},
		[1447] = {	-- Initial Druid (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["Healer"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
		},
		[250] = {	--Blood DK
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[251] = {	--Frost DK
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[1455] = {	--Initial DK (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[253] = {	--Beastmaster Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[254] = {	--Markmanship Hunter Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[255] = {	--Survival Hunter (Legion+)
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[1448] = {	--Initial Hunter (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
		},
		[256] = {	--Discipline Priest
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligable target for dps only debuffs
			["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["MagicDispeller"] = true,
			["ImmunityDispeller"] = true,
		},
		[258] = {	--Shadow Priest
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["ImmunityDispeller"] = true,
			["HasInterrupt"] = true,
			["RemoveDisease"] = true,
		},
		[1452] = {	--Initial Priest (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Healer"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
		[259] = {	--Assassination Rogue
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[1453] = {	--Initial Rogue (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[262] = {	--Elemental Shaman
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[263] = {	--Enhancement Shaman
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[264] = {	--Restoration Shaman
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Spirit Link Totem
			["RemoveCurse"] = true,
			["RemoveMagic"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[1444] = {	--Initial Shaman (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Healer"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["Physical"] = true,
		},
		[265] = {	--Affliction Warlock
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RemoveMagic"] = true,--Singe Magic (Imp)
			["CasterDps"] = true,
		},
		[1454] = {	--Initial Warlock (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
		[268] = {	--Brewmaster Monk
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
		},
		[269] = {	--Windwalker Monk
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
		},
		[270] = {	--Mistweaver Monk
			["Healer"] = true,
			["Melee"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Revival
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
		},
		[1450] = {	--Initial Monk (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Healer"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
		},
		[577] = {	--Havok Demon Hunter
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["MagicDispeller"] = true,
		},
		[581] = {	--Vengeance Demon Hunter
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["MagicDispeller"] = true,
		},
		[1456] = {	--Initial Demon Hunter (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
	}
	specRoleTable[63] = specRoleTable[62]--Frost Mage same as arcane
	specRoleTable[64] = specRoleTable[62]--Fire Mage same as arcane
	specRoleTable[72] = specRoleTable[71]--Fury Warrior same as Arms
	specRoleTable[252] = specRoleTable[251]--Unholy DK same as frost
	specRoleTable[257] = specRoleTable[256]--Holy Priest same as disc
	specRoleTable[260] = specRoleTable[259]--Combat Rogue same as Assassination
	specRoleTable[261] = specRoleTable[259]--Subtlety Rogue same as Assassination
	specRoleTable[266] = specRoleTable[265]--Demonology Warlock same as Affliction
	specRoleTable[267] = specRoleTable[265]--Destruction Warlock same as Affliction

	--[[function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			flagText = flagText:gsub("-", "")
			if not specFlags[flagText] then
				print("bad flag found : "..flagText)
			end
		end
		self:GetRoleFlagValue2(flag)
	end]]

	--to check flag is correct, remove comment block specFlags table and GetRoleFlagValue function, change this to GetRoleFlagValue2
	--disable flag check normally because double flag check comsumes more cpu on mod load.
	function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			if flagText:match("^-") then
				flagText = flagText:gsub("-", "")
				if not specRoleTable[DBM.currentSpecID][flagText] then
					return true
				end
			else
				if specRoleTable[DBM.currentSpecID][flagText] then
					return true
				end
			end
		end
		return false
	end

	function bossModPrototype:IsMeleeDps(uId)
		if uId then--This version includes ONLY melee dps
			local role = UnitGroupRolesAssigned(uId)
			if role == "HEALER" or role == "TANK" then--Auto filter healer/tank from dps check
				return false
			end
			local _, class = UnitClass(uId)
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "DEMONHUNTER" then
				return true
			end
			--Inspect throttle exists, so have to do it this way
			if class == "DRUID" or class == "SHAMAN" or class == "PALADIN" or class == "MONK" then
				local unitMaxPower = UnitPowerMax(uId)
				local powerType = UnitPowerType(uId)
				local altPowerType = UnitPower(uId, 8)--Additional check for balance druids shapeshifted into bear/cat but may still have > 0 lunar power
				--Healers all have 50k mana at 60, dps have 10k mana, plus healers still filtered by role check too
				--Tanks are already filtered out by role check
				--Maelstrom and Lunar power filtered out because they'd also return less than 11000 power (they'd both be 100)
				--feral druids, enhance shamans, windwalker monks, ret paladins should all be caught by less than 11000 power checks after filters
				if powerType ~= 11 and powerType ~= 8 and altPowerType == 0 and unitMaxPower < 11000 then--Maelstrom and Lunar power filters
					return true
				end
			end
			return false
		end
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[DBM.currentSpecID]["MeleeDps"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsMelee(uId, mechanical)--mechanical arg means the check is asking if boss mechanics consider them melee (even if they aren't, such as holy paladin/mistweaver monks)
		if uId then--This version includes monk healers as melee and tanks as melee
			local _, class = UnitClass(uId)
			--In mechanical check, ALL paladins are melee so don't need anything fancy, as for rest of classes here, same deal
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "MONK" or class == "DEMONHUNTER" or (mechanical and class == "PALADIN") then
				return true
			end
			--Inspect throttle exists, so have to do it this way
			if (class == "DRUID" or class == "SHAMAN" or class == "PALADIN") then
				local powerType = UnitPowerType(uId)
				local unitMaxPower = UnitPowerMax(uId)
				local altPowerType = UnitPower(uId, 8)--Additional check for balance druids shapeshifted into bear/cat but may still have > 0 lunar power
				--Hunters are now all flagged ranged because it's no longer possible to tell a survival hunter from marksman. neither will be using a pet and both have 100 focus.
				--Druids without lunar poewr or 50k mana are either feral or guardian
				--Shamans without maelstrom and 50k mana can only be enhancement
				--Paladins without 50k mana can only be prot or ret
				if powerType ~= 11 and powerType ~= 8 and altPowerType == 0 and unitMaxPower < 11000 then--Maelstrom and Lunar power filters
					return true
				end
			end
			return false
		end
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[DBM.currentSpecID]["Melee"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsRanged()
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[DBM.currentSpecID]["Ranged"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsSpellCaster()
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[DBM.currentSpecID]["SpellCaster"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsMagicDispeller()
		if not DBM.currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[DBM.currentSpecID]["MagicDispeller"] then
			return true
		else
			return false
		end
	end
end

function bossModPrototype:UnitClass(uId)
	if uId then--Return unit requested
		local _, class = UnitClass(uId)
		return class
	end
	return UnitClass("player")--else return "player"
end

function bossModPrototype:IsTank()
	--IsTanking already handles external calls, no need here.
	if not DBM.currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(DBM.currentSpecID)
	if role == "TANK" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsDps(uId)
	if uId then--External unit call.
		if UnitGroupRolesAssigned(uId) == "DAMAGER" then
			return true
		end
		return false
	end
	if not DBM.currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(DBM.currentSpecID)
	if role == "DAMAGER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsHealer(uId)
	if uId then--External unit call.
		if UnitGroupRolesAssigned(uId) == "HEALER" then
			return true
		end
		return false
	end
	if not DBM.currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(DBM.currentSpecID)
	if role == "HEALER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsTanking(unit, boss, isName, onlyRequested, bossGUID, includeTarget)
	if isName then--Passed combat log name, so pull unit ID
		unit = DBM:GetRaidUnitId(unit)
	end
	if not unit then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--Prefer threat target first
	if boss then--Only checking one bossID as requested
		--Check threat first
		local tanking, status = UnitDetailedThreatSituation(unit, boss)
		if tanking or (status == 3) then
			return true
		end
		--Non threat fallback
		if includeTarget and UnitExists(boss) then
			local guid = UnitGUID(boss)
			local _, targetuid = self:GetBossTarget(guid, true)
			if UnitIsUnit(unit, targetuid) then
				return true
			end
		end
	else--Check all of them if one isn't defined
		for i = 1, 5 do
			local unitID = "boss"..i
			local guid = UnitGUID(unitID)
			--No GUID, any unit having threat returns true, GUID, only specific unit matching guid
			if not bossGUID or (guid and guid == bossGUID) then
				--Check threat first
				local tanking, status = UnitDetailedThreatSituation(unit, unitID)
				if tanking or (status == 3) then
					return true
				end
				--Non threat fallback
				if includeTarget and UnitExists(unitID) then
					local _, targetuid = self:GetBossTarget(guid, true)
					if UnitIsUnit(unit, targetuid) then
						return true
					end
				end
			end
		end
		--Check group targets if no boss unitIDs found and bossGUID passed.
		--This allows IsTanking to be used in situations boss UnitIds don't exist
		if bossGUID then
			local groupType = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local unitID = (i == 0 and "target") or groupType..i.."target"
				local guid = UnitGUID(unitID)
				if guid and guid == bossGUID then
					--Check threat first
					local tanking, status = UnitDetailedThreatSituation(unit, unitID)
					if tanking or (status == 3) then
						return true
					end
					--Non threat fallback
					if includeTarget and UnitExists(unitID) then
						local _, targetuid = self:GetBossTarget(guid, true)
						if UnitIsUnit(unit, targetuid) then
							return true
						end
					end
				end
			end
		end
	end
	if not onlyRequested then
		--Use these as fallback if threat target not found
		if GetPartyAssignment("MAINTANK", unit, 1) then
			return true
		end
		if UnitGroupRolesAssigned(unit) == "TANK" then
			return true
		end
	end
	return false
end

function bossModPrototype:GetNumAliveTanks()
	if not IsInGroup() then return 1 end--Solo raid, you're the "tank"
	local count = 0
	local uId = (IsInRaid() and "raid") or "party"
	for i = 1, DBM:GetNumRealGroupMembers() do
		if UnitGroupRolesAssigned(uId..i) == "TANK" and not UnitIsDeadOrGhost(uId..i) then
			count = count + 1
		end
	end
	return count
end

----------------------------
--  Boss Health Function  --
----------------------------
function DBM:GetBossHP(cIdOrGUID, onlyHighest)
	local uId = DBM.bossHealthuIdCache[cIdOrGUID] or "target"
	local guid = UnitGUID(uId)
	--Target or Cached (if already called with this cid or GUID before)
	if (self:GetCIDFromGUID(guid) == cIdOrGUID or guid == cIdOrGUID) and UnitHealthMax(uId) ~= 0 then
		if DBM.bossHealth[cIdOrGUID] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return DBM.bossHealth[cIdOrGUID], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if not onlyHighest or onlyHighest and hp > (DBM.bossHealth[cIdOrGUID] or 0) then
			DBM.bossHealth[cIdOrGUID] = hp
		end
		return hp, uId, UnitName(uId)
		--Focus
	elseif (self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0 then
		if DBM.bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return DBM.bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		if not onlyHighest or onlyHighest and hp > (DBM.bossHealth[cIdOrGUID] or 0) then
			DBM.bossHealth[cIdOrGUID] = hp
		end
		return hp, "focus", UnitName("focus")
	else
		--Boss UnitIds
		for i = 1, 5 do
			local unitID = "boss"..i
			local bossguid = UnitGUID(unitID)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitID) ~= 0 then
				if DBM.bossHealth[cIdOrGUID] and (UnitHealth(unitID) == 0 and not UnitIsDead(unitID)) then return DBM.bossHealth[cIdOrGUID], unitID, UnitName(unitID) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
				if not onlyHighest or onlyHighest and hp > (DBM.bossHealth[cIdOrGUID] or 0) then
					DBM.bossHealth[cIdOrGUID] = hp
				end
				DBM.bossHealthuIdCache[cIdOrGUID] = unitID
				return hp, unitID, UnitName(unitID)
			end
		end
		--Scan raid/party target frames
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local bossguid = UnitGUID(unitId)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
				if DBM.bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return DBM.bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				if not onlyHighest or onlyHighest and hp > (DBM.bossHealth[cIdOrGUID] or 0) then
					DBM.bossHealth[cIdOrGUID] = hp
				end
				DBM.bossHealthuIdCache[cIdOrGUID] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
	return nil
end

function DBM:GetBossHPByUnitID(uId)
	if UnitHealthMax(uId) ~= 0 then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		DBM.bossHealth[uId] = hp
		return hp, uId, UnitName(uId)
	end
	return nil
end

function bossModPrototype:SetMainBossID(cid)
	self.mainBoss = cid
end

function bossModPrototype:SetBossHPInfoToHighest(numBoss)
	if numBoss ~= false then
		self.numBoss = numBoss or (self.multiMobPullDetection and #self.multiMobPullDetection)
	end
	self.highesthealth = true
end

function bossModPrototype:GetHighestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = DBM.bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (DBM.bossHealth[mob] or 0) > (hp or 0) and (DBM.bossHealth[mob] or 0) < 100 then-- ignore full health.
				hp = DBM.bossHealth[mob]
			end
		end
	end
	return hp
end

function bossModPrototype:GetLowestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = DBM.bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (DBM.bossHealth[mob] or 100) < (hp or 100) and (DBM.bossHealth[mob] or 100) > 0 then-- ignore zero health.
				hp = DBM.bossHealth[mob]
			end
		end
	end
	return hp
end

bossModPrototype.GetBossHP = DBM.GetBossHP

-----------------------
--  Announce Object  --
-----------------------
do
	local frame = CreateFrame("Frame", "DBMWarning", UIParent)
	local font1u = CreateFrame("Frame", "DBMWarning1Updater", UIParent)
	local font2u = CreateFrame("Frame", "DBMWarning2Updater", UIParent)
	local font3u = CreateFrame("Frame", "DBMWarning3Updater", UIParent)
	local font1 = frame:CreateFontString("DBMWarning1", "OVERLAY", "GameFontNormal")
	font1:SetWidth(1024)
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMWarning2", "OVERLAY", "GameFontNormal")
	font2:SetWidth(1024)
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	local font3 = frame:CreateFontString("DBMWarning3", "OVERLAY", "GameFontNormal")
	font3:SetWidth(1024)
	font3:SetHeight(0)
	font3:SetPoint("TOP", font2, "BOTTOM", 0, 0)
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 300)
	font1u:Hide()
	font2u:Hide()
	font3u:Hide()

	local font1elapsed, font2elapsed, font3elapsed

	local function fontHide1()
		local duration = DBM.Options.WarningDuration2
		if font1elapsed > duration * 1.3 then
			font1u:Hide()
			font1:Hide()
			if frame.font1ticker then
				frame.font1ticker:Cancel()
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.WarningDuration2
		if font2elapsed > duration * 1.3 then
			font2u:Hide()
			font2:Hide()
			if frame.font2ticker then
				frame.font2ticker:Cancel()
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	local function fontHide3()
		local duration = DBM.Options.WarningDuration2
		if font3elapsed > duration * 1.3 then
			font3u:Hide()
			font3:Hide()
			if frame.font3ticker then
				frame.font3ticker:Cancel()
				frame.font3ticker = nil
			end
		elseif font3elapsed > duration then
			font3elapsed = font3elapsed + 0.05
			local alpha = 1 - (font3elapsed - duration) / (duration * 0.3)
			font3:SetAlpha(alpha > 0 and alpha or 0)
		else
			font3elapsed = font3elapsed + 0.05
			font3:SetAlpha(1)
		end
	end

	font1u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font1.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font1:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font1:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font1:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font2u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font2.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font2:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font2:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font2:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font3u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font3.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font3:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font3:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font3:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	function DBM:UpdateWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(self.Options.WarningPoint, UIParent, self.Options.WarningPoint, self.Options.WarningX, self.Options.WarningY)
		local font = self.Options.WarningFont == "standardFont" and standardFont or self.Options.WarningFont
		font1:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font2:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font3:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		if self.Options.WarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
			font3:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
			font3:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			font1u:Show()
			added = true
			frame.font1ticker = frame.font1ticker or C_TimerNewTicker(0.05, fontHide1)
		elseif not frame.font2ticker then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			font2u:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_TimerNewTicker(0.05, fontHide2)
		elseif not frame.font3ticker or force then
			font3elapsed = 0
			font3.lastUpdate = GetTime()
			font3:SetText(text)
			font3:Show()
			font3u:Show()
			fontHide3()
			added = true
			frame.font3ticker = frame.font3ticker or C_TimerNewTicker(0.05, fontHide3)
		end
		if not added then
			local prevText1 = font2:GetText()
			local prevText2 = font3:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			font2:SetText(prevText2)
			font2elapsed = font3elapsed
			self:AddWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			anchorFrame:Hide()
			if anchorFrame.ticker then
				anchorFrame.ticker:Cancel()
				anchorFrame.ticker = nil
			end
			font1elapsed = self.Options.WarningDuration2
			font2elapsed = self.Options.WarningDuration2
			font3elapsed = self.Options.WarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			self.Bars:CancelBar(L.MOVE_WARNING_BAR)
		end

		function DBM:MoveWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					self.Bars:CancelBar(L.MOVE_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.WarningPoint = point
					self.Options.WarningX = xOfs
					self.Options.WarningY = yOfs
					self:Schedule(15, moveEnd, self)
					self.Bars:CreateBar(15, L.MOVE_WARNING_BAR, 237538)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				anchorFrame:Show()
				anchorFrame.ticker = anchorFrame.ticker or C_TimerNewTicker(5, function() self:AddWarning(L.MOVE_WARNING_MESSAGE) end)
				self:AddWarning(L.MOVE_WARNING_MESSAGE)
				self:Schedule(15, moveEnd, self)
				self.Bars:CreateBar(15, L.MOVE_WARNING_BAR, 237538)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	-- TODO: is there a good reason that this is a weak table?
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	local function setText(announceType, spellId, castTime, preWarnTime)
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellId = ssub(spellId, 3)
			spellName = DBM:EJ_GetSectionInfo(spellId) or L.UNKNOWN
		else
			spellName = (spellId or 0) >= 6 and DBM:GetSpellInfo(spellId) or L.UNKNOWN
		end
		local text
		if announceType == "cast" then
			local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
			local timer = (select(4, DBM:GetSpellInfo(spellId)) or 1000) / spellHaste
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(preWarnTime or 5)))
			end
		elseif announceType == "stage" or announceType == "prestage" then
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		elseif announceType == "stagechange" then
			text = L.AUTO_ANNOUNCE_TEXTS.spell
		else
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
	end

	-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
			local argTable = {...}
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.WarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				message,
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			self.combinedcount = 0
			self.combinedtext = {}
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					local noStrip = cap:match("noStrip ")
					if not noStrip then
						local name = cap
						local playerClass = DBM:GetRaidClass(name)
						if playerClass ~= "UNKNOWN" then
							cap = DBM:GetShortServerName(cap)--Only run realm strip function if class color was valid (IE it's an actual playername)
						end
						local playerColor = RAID_CLASS_COLORS[playerClass] or color
						if playerColor then
							cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
						end
					else
						cap = cap:sub(9)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			DBM:AddWarning(text)
			if DBM.Options.ShowWarningsInChat then
				if not DBM.Options.WarningIconChat then
					text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
				end
				self.mod:AddMsg(text, nil)
			end
			if self.sound > 0 then
				if self.sound > 1 and DBM.Options.ChosenVoicePack ~= "None" and not DBM.voiceSessionDisabled and self.sound <= SWFilterDisabed then return end
				if not self.option or self.mod.Options[self.option.."SWSound"] ~= "None" then
					DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)--Validate true
				end
			end
			--Message: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: you, target, targetsource, spell, ends, endtarget, fades, adds, count, stack, cast, soon, sooncount, prewarn, bait, stage, stagechange, prestage, moveto
			------Personal/Role (Applies to you, or your job): you, stack, bait, moveto, fades
			------General Target Messages (informative, doesn't usually apply to you): target, targetsource
			------Fight Changes (Stages, adds, boss buff/debuff, etc): stage, stagechange, prestage, adds, ends, endtarget
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			DBM:FireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function announcePrototype:CombinedShow(delay, ...)
		if self.option and not self.mod.Options[self.option] then return end
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 7 then--Throttle spam. We may not need more than 6 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBM:Unschedule(self.Show, self.mod, self)
		DBM:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Schedule(t, ...)
		return DBM:Schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Countdown(time, numAnnounces, ...)
		scheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return DBM:Unschedule(self.Show, self.mod, self, ...)
	end

	function announcePrototype:Play(name, customPath)
		local voice = DBM.Options.ChosenVoicePack
		if DBM.voiceSessionDisabled or voice == "None" then return end
		local always = DBM.Options.AlwaysPlayVoice
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter and not always then return end--don't show announces that are generic target announces
		if (not DBM.Options.DontShowBossAnnounces and (not self.option or self.mod.Options[self.option]) or always) and self.sound <= SWFilterDisabed then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function announcePrototype:ScheduleVoice(t, ...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		DBM:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBM:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function announcePrototype:ScheduleVoiceOverLap(t, ...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return DBM:Schedule(t, self.Play, self.mod, self, ...)
	end

	function announcePrototype:CancelVoice(...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return DBM:Unschedule(self.Play, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, soundOption)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		if type(text) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized text cannot be numbers, fix this for |r"..text)
		end
		if type(optionName) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized optionNames cannot be numbers, fix this for |r"..text)
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = soundOption or 1,
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = text
			self:AddBoolOption(obj.option, optionDefault, "announce")
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (partially auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
		end
		local optionVersion, alternateSpellId
		if type(optionName) == "number" then
			if optionName > 1000 then--Being used as spell name shortening
				if DBM.Options.WarningShortText then
					alternateSpellId = optionName
				end
			else--Being used as option version
				optionVersion = optionName
			end
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			print("newAnnounce for "..color.." is using OptionVersion hack. this is depricated")
			return
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, castTime, preWarnTime)
		icon = icon or spellId
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116,
				sound = soundOption or 1,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				noFilter = noFilter,
				castTime = castTime,
				preWarnTime = preWarnTime,
			},
			mt
		)
		local catType = "announce"--Default to General announce
		--Change if Personal or Other
		if announceType == "target" or announceType == "targetcount" or announceType == "stack" then
			catType = "announceother"
		end
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, catType)
		elseif not (optionName == false) then
			obj.option = catType..spellId..announceType..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, catType)
			if noFilter and announceType == "target" then
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS["targetNF"]:format(spellId)
			else
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId)
			end
		end
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewYouAnnounce(spellId, color, ...)
		return newAnnounce(self, "you", spellId, color or 1, ...)
	end

	function bossModPrototype:NewTargetNoFilterAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		return newAnnounce(self, "target", spellId, color or 3, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, true)
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetsource", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 3, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "endtarget", spellId, color or 2, ...)
	end

	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 2, ...)
	end

	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "adds", spellId, color or 3, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 2, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, noArg, soundOption)
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, soundOption)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "sooncount", spellId, color or 2, ...)
	end

	--This object disables sounds, it's almost always used in combation with a countdown timer. Even if not a countdown, its a text only spam not a sound spam
	function bossModPrototype:NewCountdownAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		return newAnnounce(self, "countdown", spellId, color or 4, icon, optionDefault, optionName, castTime, preWarnTime, 0, noFilter)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, noArg, soundOption)
		return newAnnounce(self, "prewarn", spellId, color or 2, icon, optionDefault, optionName, nil, time, soundOption)
	end

	function bossModPrototype:NewBaitAnnounce(spellId, color, ...)
		return newAnnounce(self, "bait", spellId, color or 3, ...)
	end

	function bossModPrototype:NewPhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "stage", stage, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
		return newAnnounce(self, "stagechange", 0, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "prestage", stage, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewMoveToAnnounce(spellId, color, ...)
		return newAnnounce(self, "moveto", spellId, color or 3, ...)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local voidForm = GetSpellInfo(194249)
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			print("newYell for: "..yellText.." is using OptionVersion hack. This is depricated")
			return
		end
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local displayText
		if not yellText then
			if type(spellId) == "string" and spellId:match("ej%d+") then
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(ssub(spellId, 3)) or L.UNKNOWN)
			else
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(spellId) or L.UNKNOWN)
			end
		end
		--Passed spellid as yellText.
		--Auto localize spelltext using yellText instead
		if yellText and type(yellText) == "number" then
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(yellText) or L.UNKNOWN)
		end
		local obj = setmetatable(
			{
				spellId = spellId,
				text = displayText or yellText,
				mod = self,
				chatType = chatType,
				yellType = yellType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "yell")
		elseif not (optionName == false) then
			obj.option = "Yell"..(spellId or yellText)..(yellType ~= "yell" and yellType or "")..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "yell")
			self.localization.options[obj.option] = L.AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
		end
		return obj
	end

	--Standard "Yell" object that will use SAY/YELL based on what's defined in the object (Defaulting to SAY if nil)
	--I realize object being :Yell is counter intuitive to default being "SAY" but for many years the default was YELL and it's too many years of mods to change now
	function yellPrototype:Yell(...)
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), self.chatType or "SAY")
		end
	end
	yellPrototype.Show = yellPrototype.Yell

	--Force override to use say message, even when object defines "YELL"
	function yellPrototype:Say(...)
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return DBM:Schedule(t, self.Yell, self.mod, self, ...)
	end

	--Standard schedule object to schedule a say/yell based on what's defined in object
	function yellPrototype:Countdown(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				scheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			scheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
		end
	end

	--Scheduled Force override to use SAY message, even when object defines "YELL"
	function yellPrototype:CountdownSay(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				scheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			scheduleCountdown(time, numAnnounces, self.Say, self.mod, self, ...)
		end
	end

	function yellPrototype:Repeat(...)
		scheduleRepeat(time, self.Yell, self.spellId, self.mod, self, ...)
	end

	function yellPrototype:Cancel(...)
		return DBM:Unschedule(self.Yell, self.mod, self, ...)
	end

	function bossModPrototype:NewYell(...)
		return newYell(self, "yell", ...)
	end

	function bossModPrototype:NewShortYell(...)
		return newYell(self, "shortyell", ...)
	end

	function bossModPrototype:NewCountYell(...)
		return newYell(self, "count", ...)
	end

	function bossModPrototype:NewFadesYell(...)
		return newYell(self, "fade", ...)
	end

	function bossModPrototype:NewShortFadesYell(...)
		return newYell(self, "shortfade", ...)
	end

	function bossModPrototype:NewIconFadesYell(...)
		return newYell(self, "iconfade", ...)
	end

	function bossModPrototype:NewPosYell(...)
		return newYell(self, "position", ...)
	end

	function bossModPrototype:NewComboYell(...)
		return newYell(self, "combo", ...)
	end

	function bossModPrototype:NewPlayerRepeatYell(...)
		return newYell(self, "repeatplayer", ...)
	end

	function bossModPrototype:NewIconRepeatYell(...)
		return newYell(self, "repeaticon", ...)
	end
end

------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", "DBMSpecialWarning", UIParent)
	local font1 = frame:CreateFontString("DBMSpecialWarning1", "OVERLAY", "ZoneTextFont")
	font1:SetWidth(1024)
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMSpecialWarning2", "OVERLAY", "ZoneTextFont")
	font2:SetWidth(1024)
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	local font1elapsed, font2elapsed, moving

	local function fontHide1()
		local duration = DBM.Options.SpecialWarningDuration2
		if font1elapsed > duration * 1.3 then
			font1:Hide()
			if frame.font1ticker then
				frame.font1ticker:Cancel()
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.SpecialWarningDuration2
		if font2elapsed > duration * 1.3 then
			font2:Hide()
			if frame.font2ticker then
				frame.font2ticker:Cancel()
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		local font = self.Options.SpecialWarningFont == "standardFont" and standardFont or self.Options.SpecialWarningFont
		frame:SetPoint(self.Options.SpecialWarningPoint, UIParent, self.Options.SpecialWarningPoint, self.Options.SpecialWarningX, self.Options.SpecialWarningY)
		font1:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font2:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font1:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		font2:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		if self.Options.SpecialWarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddSpecialWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			added = true
			frame.font1ticker = frame.font1ticker or C_TimerNewTicker(0.05, fontHide1)
		elseif not frame.font2ticker or force then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_TimerNewTicker(0.05, fontHide2)
		end
		if not added then
			local prevText1 = font2:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			self:AddSpecialWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			moving = false
			anchorFrame:Hide()
			font1elapsed = self.Options.SpecialWarningDuration2
			font2elapsed = self.Options.SpecialWarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			self.Bars:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					self.Bars:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.SpecialWarningPoint = point
					self.Options.SpecialWarningX = xOfs
					self.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd, self)
					self.Bars:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, 237538)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				moving = true
				anchorFrame:Show()
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:Schedule(15, moveEnd, self)
				self.Bars:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, 237538)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	local function classColoringFunction(cap)
		cap = cap:sub(2, -2)
		local noStrip = cap:match("noStrip ")
		if not noStrip then
			local name = cap
			local playerClass = DBM:GetRaidClass(name)
			if playerClass ~= "UNKNOWN" then
				cap = DBM:GetShortServerName(cap)--Only run strip code on valid player classes
				if DBM.Options.SWarnClassColor then
					local playerColor = RAID_CLASS_COLORS[playerClass]
					if playerColor then
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					end
				end
			end
		else
			cap = cap:sub(9)
		end
		return cap
	end

	local textureCode = " |T%s:12:12|t "

	local function setText(announceType, spellId, stacks)
		local text, spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = DBM:EJ_GetSectionInfo(ssub(spellId, 3)) or L.UNKNOWN
		else
			spellName = (spellId or 0) >= 6 and DBM:GetSpellInfo(spellId) or L.UNKNOWN
		end
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(stacks or 5)))
			end
		else
			text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
	end

	function specialWarningPrototype:Show(...)
		--Check if option for this warning is even enabled
		if (not self.option or self.mod.Options[self.option]) and not moving and frame then
			--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
			if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
			--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
			if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
			--Lastly, we check if it's a tank warning and filter if not in tank spec. This is done because tank warnings on by default and handled fluidly by spec, not option setting
			if self.announceType == "taunt" and DBM.Options.FilterTankSpec and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
			local argTable = {...}
			-- add a default parameter for move away warnings
			if self.announceType == "gtfo" then
				if DBM:UnitBuff("player", 27827) then return end--Don't tell a priest in spirit of redemption form to GTFO, they can't, and they don't take damage from it anyhow
				if #argTable == 0 then
					argTable[1] = L.BAD
				end
			end
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.SWarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s"):format(
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or "",
				message,
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or ""
			)
			local noteHasName = false
			if self.option then
				local noteText = self.mod.Options[self.option .. "SWNote"]
				if noteText and type(noteText) == "string" and noteText ~= "" then--Filter false bool and empty strings
					local count1 = self.announceType == "count" or self.announceType == "switchcount" or self.announceType == "targetcount"
					local count2 = self.announceType == "interruptcount"
					if count1 or count2 then--Counts support different note for EACH count
						local noteCount
						local notesTable = {ssplit("/", noteText)}
						if count1 then
							noteCount = argTable[1]--Count should be first arg in table
						elseif count2 then
							noteCount = argTable[2]--Count should be second arg in table
						end
						if type(noteCount) == "string" then
							--Probably a hypehnated double count like inferno slice or marked for death
							local mainCount = ssplit("-", noteCount)
							noteCount = tonumber(mainCount)
						end
						noteText = notesTable[noteCount]
						if noteText and type(noteText) == "string" and noteText ~= "" then--Refilter after string split to make sure a note for this count exists
							local hasPlayerName = noteText:find(playerName)
							if DBM.Options.SWarnNameInNote and hasPlayerName then
								noteHasName = 5
							end
							--Terminate special warning, it's an interrupt count warning without player name and filter enabled
							if count2 and DBM.Options.FilterInterruptNoteName and not hasPlayerName then return end
							noteText = " ("..noteText..")"
							text = text..noteText
						end
					else--Non count warnings will have one note, period
						if DBM.Options.SWarnNameInNote and noteText:find(playerName) then
							noteHasName = 5
						end
						if self.announceType and self.announceType:find("switch") then
							noteText = noteText:gsub(">.-<", classColoringFunction)--Class color note text before combining with warning text.
						end
						noteText = " ("..noteText..")"
						text = text..noteText
					end
				end
			end
			--Text is disabled, suresss text from screen and chat frame
			if not DBM.Options.DontShowSpecialWarningText then
				--No stripping on switch warnings, ever. They will NEVER have player name, but often have adds with "-" in name
				if self.announceType and not self.announceType:find("switch") then
					text = text:gsub(">.-<", classColoringFunction)
				end
				DBM:AddSpecialWarning(text)
				if DBM.Options.ShowSWarningsInChat then
					local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					self.mod:AddMsg(colorCode.."["..L.MOVE_SPECIAL_WARNING_TEXT.."] "..text.."|r", nil)
				end
			end
			self.combinedcount = 0
			self.combinedtext = {}
			if not UnitIsDeadOrGhost("player") and not DBM.Options.DontShowSpecialWarningFlash then
				if noteHasName then
					if DBM.Options.SpecialWarningFlash5 then--Not included in above if statement on purpose. we don't want to trigger else rule if noteHasName is true but SpecialWarningFlash5 is false
						local repeatCount = DBM.Options.SpecialWarningFlashCount5 or 1
						DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol5[1],DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3], DBM.Options.SpecialWarningFlashDura5, DBM.Options.SpecialWarningFlashAlph5, repeatCount-1)
					end
				else
					local number = self.flash
					if DBM.Options["SpecialWarningFlash"..number] then
						local repeatCount = DBM.Options["SpecialWarningFlashCount"..number] or 1
						local flashcolor = DBM.Options["SpecialWarningFlashCol"..number]
						DBM.Flash:Show(flashcolor[1], flashcolor[2], flashcolor[3], DBM.Options["SpecialWarningFlashDura"..number], DBM.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
					end
				end
			end
			--Text: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: spell, ends, fades, soon, bait, dispel, interrupt, interruptcount, you, youcount, youpos, soakpos, target, targetcount, defensive, taunt, close, move, keepmove, stopmove,
			----gtfo, dodge, dodgecount, dodgeloc, moveaway, moveawaycount, moveto, soak, jump, run, cast, lookaway, reflect, count, sooncount, stack, switch, switchcount, adds, addscustom, targetchange, prewarn
			------General Target Messages (but since it's a special warning, it applies to you in some way): target, targetcount
			------Fight Changes (Stages, adds, boss buff/debuff, etc): adds, addscustom, targetchange, switch, switchcount, ends
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			------Personal/Role (Applies to you, or your job): Everything Else
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			DBM:FireEvent("DBM_Announce", text, self.icon, self.type, self.spellId, self.mod.id, true)
			if self.sound and not DBM.Options.DontPlaySpecialWarningSound then
				local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
				if noteHasName and type(soundId) == "number" then soundId = noteHasName end--Change number to 5 if it's not a custom sound, else, do nothing with it
				if self.hasVoice and DBM.Options.ChosenVoicePack ~= "None" and not DBM.voiceSessionDisabled and self.hasVoice <= SWFilterDisabed and (type(soundId) == "number" and soundId < 5 and DBM.Options.VoiceOverSpecW2 == "DefaultOnly" or DBM.Options.VoiceOverSpecW2 == "All") then return end
				if not self.option or self.mod.Options[self.option.."SWSound"] ~= "None" then
					DBM:PlaySpecialWarningSound(soundId or 1)
				end
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function specialWarningPrototype:CombinedShow(delay, ...)
		--Check if option for this warning is even enabled
		if self.option and not self.mod.Options[self.option] then return end
		--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
		if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
		--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 6 then--Throttle spam. We may not need more than 5 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBM:Unschedule(self.Show, self.mod, self)
		DBM:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:DelayedShow(delay, ...)
		DBM:Unschedule(self.Show, self.mod, self, ...)
		DBM:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Schedule(t, ...)
		return DBM:Schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Countdown(time, numAnnounces, ...)
		scheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(t, ...)
		return DBM:Unschedule(self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Play(name, customPath)
		local always = DBM.Options.AlwaysPlayVoice
		local voice = DBM.Options.ChosenVoicePack
		if DBM.voiceSessionDisabled or voice == "None" then return end
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		if ((not self.option or self.mod.Options[self.option]) or always) and self.hasVoice <= SWFilterDisabed then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function specialWarningPrototype:ScheduleVoice(t, ...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		DBM:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBM:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function specialWarningPrototype:ScheduleVoiceOverLap(t, ...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return DBM:Schedule(t, self.Play, self.mod, self, ...)
	end

	function specialWarningPrototype:CancelVoice(...)
		if DBM.voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return DBM:Unschedule(self.Play, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty, texture)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
		if type(text) == "string" and text:match("OptionVersion") then
			print("NewSpecialWarning: you must provide remove optionversion hack for "..optionDefault)
			return
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local seticon
		if texture then
			seticon = (type(texture) == "string" and texture:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(texture, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(texture, 3)))) or (type(texture) == "number" and GetSpellTexture(texture)) or nil
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				icon = seticon,
			},
			mt
		)
		local optionId = optionName or optionName ~= false and text
		if optionId then
			obj.voiceOptionId = hasVoice and "Voice"..optionId or nil
			obj.option = optionId..(optionVersion or "")
			self:AddSpecialWarningOption(optionId, optionDefault, runSound, "announce")
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local alternateSpellId
		if type(optionName) == "number" then
			if DBM.Options.SpecialWarningShortText then
				alternateSpellId = optionName
			end
			optionName = nil
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, stacks)
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				stacks = stacks,
				icon = (type(spellId) == "string" and spellId:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3)))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or nil
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif not (optionName == false) then
			local difficultyIcon = ""
			if difficulty then
				--1 LFR, 2 Normal, 3 Heroic, 4 Mythic
				--Likely 1 and 2 will never be used, but being prototyped just in case
				if difficulty == 3 then
					difficultyIcon = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:18:18:0:0:255:66:102:118:7:27|t"
				elseif difficulty == 4 then
					difficultyIcon = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:18:18:0:0:255:66:133:153:40:58|t"
				end
			end
			obj.option = "SpecWarn"..spellId..announceType..(optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
			else
				self.localization.options[obj.option] = difficultyIcon..L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			local catType = "announce"--Default to General announce
			--Directly affects another target (boss or player) that you need to know about
			if announceType == "target" or announceType == "targetcount" or announceType == "close" or announceType == "reflect" then
				catType = "announceother"
				--Directly affects you
			elseif announceType == "you" or announceType == "youcount" or announceType == "youpos" or announceType == "move" or announceType == "dodge" or announceType == "dodgecount" or announceType == "moveaway" or announceType == "moveawaycount" or announceType == "keepmove" or announceType == "stopmove" or announceType == "run" or announceType == "stack" or announceType == "moveto" or announceType == "soak" or announceType == "soakpos" then
				catType = "announcepersonal"
				--Things you have to do to fulfil your role
			elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" or announceType == "interruptcount" or announceType == "switch" or announceType == "switchcount" then
				catType = "announcerole"
			end
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, catType)
		end
		obj.voiceOptionId = hasVoice and "Voice"..spellId or nil
		tinsert(self.specwarns, obj)
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
		return newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningEnd(text, optionDefault, ...)
		return newSpecialWarning(self, "ends", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningFades(text, optionDefault, ...)
		return newSpecialWarning(self, "fades", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoon(text, optionDefault, ...)
		return newSpecialWarning(self, "soon", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningBait(text, optionDefault, ...)
		return newSpecialWarning(self, "bait", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDispel(text, optionDefault, ...)
		return newSpecialWarning(self, "dispel", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterrupt(text, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterruptCount(text, optionDefault, ...)
		return newSpecialWarning(self, "interruptcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYou(text, optionDefault, ...)
		return newSpecialWarning(self, "you", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouCount(text, optionDefault, ...)
		return newSpecialWarning(self, "youcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouPos(text, optionDefault, ...)
		return newSpecialWarning(self, "youpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoakPos(text, optionDefault, ...)
		return newSpecialWarning(self, "soakpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetCount(text, optionDefault, ...)
		return newSpecialWarning(self, "targetcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDefensive(text, optionDefault, ...)
		return newSpecialWarning(self, "defensive", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTaunt(text, optionDefault, ...)
		return newSpecialWarning(self, "taunt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(text, optionDefault, ...)
		return newSpecialWarning(self, "close", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(text, optionDefault, ...)
		return newSpecialWarning(self, "move", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningKeepMove(text, optionDefault, ...)
		return newSpecialWarning(self, "keepmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStopMove(text, optionDefault, ...)
		return newSpecialWarning(self, "stopmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningGTFO(text, optionDefault, ...)
		return newSpecialWarning(self, "gtfo", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodge(text, optionDefault, ...)
		return newSpecialWarning(self, "dodge", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeCount(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgecount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeLoc(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgeloc", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAway(text, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAwayCount(text, optionDefault, ...)
		return newSpecialWarning(self, "moveawaycount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveTo(text, optionDefault, ...)
		return newSpecialWarning(self, "moveto", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoak(text, optionDefault, ...)
		return newSpecialWarning(self, "soak", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningJump(text, optionDefault, ...)
		return newSpecialWarning(self, "jump", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningLookAway(text, optionDefault, ...)
		return newSpecialWarning(self, "lookaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(text, optionDefault, ...)
		return newSpecialWarning(self, "reflect", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoonCount(text, optionDefault, ...)
		return newSpecialWarning(self, "sooncount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitchCount(text, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAdds(text, optionDefault, ...)
		return newSpecialWarning(self, "adds", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAddsCustom(text, optionDefault, ...)
		return newSpecialWarning(self, "addscustom", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetChange(text, optionDefault, ...)
		return newSpecialWarning(self, "targetchange", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(text, optionDefault, time, ...)
		return newSpecialWarning(self, "prewarn", text, time, optionDefault, ...)
	end

	function DBM:PlayCountSound(number, forceVoice, forcePath)
		if number > 10 then return end
		local voice
		if forceVoice then--For options example
			voice = forceVoice
		else
			voice = self.Options.CountdownVoice
		end
		local path
		local maxCount = 5
		if forcePath then
			path = forcePath
		else
			for i = 1, #self.Counts do
				if self.Counts[i].value == voice then
					path = self.Counts[i].path
					maxCount = self.Counts[i].max
					break
				end
			end
		end
		if not path or (number > maxCount) then return end
		self:PlaySoundFile(path..number..".ogg")
	end

	function DBM:RegisterCountSound(t, v, p, m)
		--Prevent duplicate insert
		for i = 1, #self.Counts do
			if self.Counts[i].value == v then return end
		end
		--Insert into counts table.
		if t and v and p and m then
			tinsert(self.Counts, { text = t, value = v, path = p, max = m })
		end
	end

	function DBM:CheckVoicePackVersion(value)
		local activeVP = self.Options.ChosenVoicePack
		--Check if voice pack out of date
		if activeVP ~= "None" and activeVP == value then
			if self.VoiceVersions[value] < 11 then--Version will be bumped when new voice packs released that contain new voices.
				if self.Options.ShowReminders then
					self:AddMsg(L.VOICE_PACK_OUTDATED)
				end
				SWFilterDisabed = self.VoiceVersions[value]--Set disable to version on current voice pack
			else
				SWFilterDisabed = 11
			end
		end
	end

	function DBM:PlaySpecialWarningSound(soundId, force)
		local sound
		if not force and DBM:IsTrivial() and DBM.Options.DontPlayTrivialSpecialWarningSound then
			sound = self.Options.RaidWarningSound
		else
			sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
		end
		self:PlaySoundFile(sound, nil, true)
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text, number, noSound, force)
		if moving then
			return
		end
		self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, testWarningEnd)
		if number and not noSound then
			self:PlaySpecialWarningSound(number, force)
		end
		if number and DBM.Options["SpecialWarningFlash"..number] then
			local flashColor = self.Options["SpecialWarningFlashCol"..number]
			local repeatCount = self.Options["SpecialWarningFlashCount"..number] or 1
			self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura"..number], self.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
		end
	end
end

--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}
	local countvoice1, countvoice2, countvoice3
	local countvoice1max, countvoice2max, countvoice3max = 5, 5, 5
	local countpath1, countpath2, countpath3

	--Merged countdown object for timers with build-in countdown
	function DBM:BuildVoiceCountdownCache()
		countvoice1 = self.Options.CountdownVoice
		countvoice2 = self.Options.CountdownVoice2
		countvoice3 = self.Options.CountdownVoice3
		for i = 1, #self.Counts do
			local curVoice = self.Counts[i]
			if curVoice.value == countvoice1 then
				countpath1 = curVoice.path
				countvoice1max = curVoice.max
			end
			if curVoice.value == countvoice2 then
				countpath2 = curVoice.path
				countvoice2max = curVoice.max
			end
			if curVoice.value == countvoice3 then
				countpath3 = curVoice.path
				countvoice3max = curVoice.max
			end
		end
	end

	local function playCountSound(timerId, path)
		DBM:PlaySoundFile(path)
	end

	local function playCountdown(timerId, timer, voice, count)
		if DBM.Options.DontPlayCountdowns then return end
		timer = timer or 10
		count = count or 5
		voice = voice or 1
		if timer <= count then count = floor(timer) end
		if not countpath1 or not countpath2 or not countpath3 then
			DBM:Debug("Voice cache not built at time of playCountdown. On fly caching.", 3)
			DBM:BuildVoiceCountdownCache()
		end
		local maxCount, path
		if type(voice) == "string" then
			maxCount = 5--Safe to assume if it's not one of the built ins, it's likely heroes/OW, which has a max of 5
			path = voice
		elseif voice == 2 then
			maxCount = countvoice2max or 10
			path = countpath2 or "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\"
		elseif voice == 3 then
			maxCount = countvoice3max or 5
			path = countpath3 or "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\"
		else
			maxCount = countvoice1max or 10
			path = countpath1 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
		end
		if not path then--Should not happen but apparently it does somehow
			DBM:Debug("Voice path failed in countdownProtoType:Start.")
			return
		end
		if count == 0 then--If a count of 0 is passed,then it's a "Countout" timer, not "Countdown"
			for i = 1, timer do
				if i < maxCount then
					DBM:Schedule(i, playCountSound, timerId, path..i..".ogg")
				end
			end
		else
			for i = count, 1, -1 do
				if i <= maxCount then
					DBM:Schedule(timer-i, playCountSound, timerId, path..i..".ogg")
				end
			end
		end
	end

	function timerPrototype:Start(timer, ...)
		if DBM.Options.DontShowBossTimers then return end
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			if self.type and (self.type == "cdcount" or self.type == "nextcount") and not self.allowdouble then--remove previous timer.
				for i = #self.startedTimers, 1, -1 do
					if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
						local bar = DBM.Bars:GetBar(self.startedTimers[i])
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
							ttext = ttext.."("..self.id..")"
							if bar.timer > 0.2 then
								local phaseText = self.mod.vb.phase and " ("..SCENARIO_STAGE:format(self.mod.vb.phase)..")" or ""
								if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug")
									DBM:FireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug", 2)
								else
									DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining, 2)
								end
							end
						end
					end
					DBM.Bars:CancelBar(self.startedTimers[i])
					DBM:FireEvent("DBM_TimerStop", self.startedTimers[i])
					self.startedTimers[i] = nil
				end
			end
			timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			--AI timer api:
			--Starting ai timer with (1) indicates it's a first timer after pull
			--Starting timer with (2) or (3) indicates it's a stage 2 or stage 3 first timer
			--Starting AI timer with anything above 3 indicarets it's a regular timer and to use shortest time in between two regular casts
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			if self.type == "ai" then--A learning timer
				if not DBM.Options.AITimer then return end
				if timer > 4 then--Normal behavior.
					local newPhase = false
					for i = 1, 4 do
						--Check for any phase timers that are strings, if a string it means last cast of this ability was first case of a given stage
						if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then--This is first cast of spell, we need to generate self.firstPullTimer
							self["phase"..i.."CastTimer"] = tonumber(self["phase"..i.."CastTimer"])
							self["phase"..i.."CastTimer"] = GetTime() - self["phase"..i.."CastTimer"]--We have generated a self.phase1CastTimer! Next pull, DBM should know timer for first cast next pull. FANCY!
							DBM:Debug("AI timer learned a first timer for current phase of "..self["phase"..i.."CastTimer"], 2)
							newPhase = true
						end
					end
					if self.lastCast and not newPhase then--We have a GetTime() on last cast and it's not affected by a phase change
						local timeLastCast = GetTime() - self.lastCast--Get time between current cast and last cast
						if timeLastCast > 4 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
							if not self.lowestSeenCast or (self.lowestSeenCast and self.lowestSeenCast > timeLastCast) then--Always use lowest seen cast for a timer
								self.lowestSeenCast = timeLastCast
								DBM:Debug("AI timer learned a new lowest timer of "..self.lowestSeenCast, 2)
							end
						end
					end
					self.lastCast = GetTime()
					if self.lowestSeenCast then--Always use lowest seen cast for timer
						timer = self.lowestSeenCast
					else
						return--Don't start the bogus timer shoved into timer field in the mod
					end
				else--AI timer passed with 4 or less is indicating phase change, with timer as phase number
					if self["phase"..timer.."CastTimer"] and type(self["phase"..timer.."CastTimer"]) == "number" then
						--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
						local bar = DBM.Bars:GetBar(id)
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							if bar.timer > 0.2 then
								self["phase"..timer.."CastTimer"] = self["phase"..timer.."CastTimer"] - remaining
								DBM:Debug("AI timer learned a lower first timer for current phase of "..self["phase"..timer.."CastTimer"], 2)
							end
						end
						timer = self["phase"..timer.."CastTimer"]
					else--No first pull timer generated yet, set it to GetTime, as a string
						self["phase"..timer.."CastTimer"] = tostring(GetTime())
						return--Don't start the x second timer
					end
				end
			end
			if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
				if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") then
					local bar = DBM.Bars:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
						ttext = ttext.."("..self.id..")"
						if bar.timer > 0.2 then
							local phaseText = self.mod.vb.phase and " ("..SCENARIO_STAGE:format(self.mod.vb.phase)..")" or ""
							if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug")
								DBM:FireEvent("DBM_Debug", "Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining..". Please report this bug", 2)
							else
								DBM:Debug("Timer "..ttext..phaseText.. " refreshed before expired. Remaining time is : "..remaining, 2)
							end
						end
					end
				end
			end
			local colorId = 0
			if self.option then
				colorId = self.mod.Options[self.option .. "TColor"]
			elseif self.colorType and type(self.colorType) == "string" then--No option for specific timer, but another bool option given that tells us where to look for TColor
				colorId = self.mod.Options[self.colorType .. "TColor"] or 0
			end
			local countVoice, countVoiceMax = 0, self.countdownMax or 4
			if self.option then
				countVoice = self.mod.Options[self.option .. "CVoice"]
				if not self.fade and (type(countVoice) == "string" or countVoice > 0) then--Started without faded and has count voice assigned
					playCountdown(id, timer, countVoice, countVoiceMax)--timerId, timer, voice, count
				end
			end
			local bar = DBM.Bars:CreateBar(timer, id, self.icon, nil, nil, nil, nil, colorId, nil, self.keep, self.fade, countVoice, countVoiceMax)
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			local msg
			if self.type and not self.text then
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), ...)
			else
				if type(self.text) == "number" then--spellId passed in timer text, it's a timer with short text
					msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.text, self.name), ...)
				else
					msg = pformat(self.text, ...)
				end
			end
			msg = msg:gsub(">.-<", stripServerName)
			bar:SetText(msg, self.inlineIcon)
			--ID: Internal DBM timer ID
			--msg: Timer Text (Do not use msg has an event trigger, it varies language to language or based on user timer options. Use this to DISPLAY only (such as timer replacement UI). use spellId field 99% of time
			--timer: Raw timer value (number).
			--Icon: Texture Path for Icon
			--type: Timer type (Cooldowns: cd, cdcount, nextcount, nextsource, cdspecial, nextspecial, stage, ai. Durations: target, active, fades, roleplay. Casting: cast)
			--spellId: Raw spellid if available (most timers will have spellId or EJ ID unless it's a specific timer not tied to ability such as pull or combat start or rez timers. EJ id will be in format ej%d
			--colorID: Type classification (1-Add, 2-Aoe, 3-targeted ability, 4-Interrupt, 5-Role, 6-Stage, 7-User(custom))
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--Keep: true or nil, whether or not to keep bar on screen when it expires (if true, timer should be retained until an actual TimerStop occurs or a new TimerStart with same barId happens (in which case you replace bar with new one)
			--fade: true or nil, whether or not to fade a bar (set alpha to usersetting/2)
			--spellName: Sent so users can use a spell name instead of spellId, if they choose. Mostly to be more classic wow friendly, spellID is still preferred method (even for classic)
			--MobGUID if it could be parsed out of args
			local guid
			if select("#", ...) > 0 then--If timer has args
				for i = 1, select("#", ...) do
					local v = select(i, ...)
					if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
						guid = v--If found, guid will be passed in DBM_TimerStart callback
					end
				end
			end
			DBM:FireEvent("DBM_TimerStart", id, msg, timer, self.icon, self.type, self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid)
			tinsert(self.startedTimers, id)
			if not self.keep then--Don't ever remove startedTimers on a schedule, if it's a keep timer
				self.mod:Unschedule(removeEntry, self.startedTimers, id)
				self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			end
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	--A way to set the fade to yes or no, overriding hardcoded value in NewTimer object with temporary one
	--If this method is used, it WILL persist until reload or changing it back
	function timerPrototype:SetFade(fadeOn, ...)
		--Done this way so SetFade can be used with :Start without needless performance cost (ie, ApplyStyle won't run unless it needs to)
		if fadeOn and not self.fade then
			self.fade = true--set timer object metatable, which will make sure next bar started uses fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and not bar.fade then
				DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetFade enable call")
				end
			end
		elseif not fadeOn and self.fade then
			self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and bar.fade then
				DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetFade disable call")
				end
			end
		end
	end

	--This version does NOT set timer object meta, only started bar meta
	--Use this if you only want to alter an already STARTED temporarily
	--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
	function timerPrototype:SetSTFade(fadeOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			if fadeOn and not bar.fade then
				DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetSTFade enable call")
				end
			elseif not fadeOn and bar.fade then
				DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.fade = false
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetSTFade disable call")
				end
			end
		end
	end

	function timerPrototype:SetSTKeep(keepOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			if keepOn and not bar.keep then
				bar.keep = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
			elseif not keepOn and bar.keep then
				DBM:FireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.keep = false
				bar:ApplyStyle()
			end
		end
	end

	function timerPrototype:DelayedStart(delay, ...)
		DBM:Unschedule(self.Start, self.mod, self, ...)
		DBM:Schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return DBM:Schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(...)
		return DBM:Unschedule(self.Start, self.mod, self, ...)
	end

	--TODO, figure out why this function doesn't properly stop count timers when calling stop without count on count timers
	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				DBM:FireEvent("DBM_TimerStop", self.startedTimers[i])
				DBM.Bars:CancelBar(self.startedTimers[i])
				DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					local guid
					for j = 1, select("#", ...) do
						local v = select(j, ...)
						if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
							guid = v--If found, guid will be passed in DBM_TimerStart callback
						end
					end
					DBM:FireEvent("DBM_TimerStop", id, guid)
					DBM.Bars:CancelBar(id)
					DBM:Unschedule(playCountSound, id)--Unschedule countdown by timerId
					tremove(self.startedTimers, i)
				end
			end
		end
		if self.type == "ai" then--A learning timer
			if not DBM.Options.AITimer then return end
			self.lastCast = nil
			for i = 1, 4 do
				--Check for any phase timers that are strings and never got a chance to become AI timers, then wipe them
				if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then
					self["phase"..i.."CastTimer"] = nil
					DBM:Debug("Wiping incomplete new timer of stage "..i, 2)
				end
			end
		end
	end

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)
	end

	function timerPrototype:GetTime(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
	end

	function timerPrototype:GetRemaining(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and bar.timer or 0
	end

	function timerPrototype:IsStarted(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		DBM:FireEvent("DBM_TimerUpdate", id, elapsed, totalTime)
		if bar and bar.countdown and bar.countdown > 0 then
			DBM:Unschedule(playCountSound, id)
			if not bar.fade then--Don't start countdown voice if it's faded bar
				playCountdown(id, totalTime-elapsed, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
				DBM:Debug("Updating a countdown after a timer Update call for timer ID:"..id)
			end
		end
		return DBM.Bars:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:AddTime(extendAmount, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			return self:Start(extendAmount, ...)
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar then
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					if bar.countdown then
						DBM:Unschedule(playCountSound, id)
						if not bar.fade then--Don't start countdown voice if it's faded bar
							local newRemaining = (total+extendAmount) - elapsed
							playCountdown(id, newRemaining, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
							DBM:Debug("Updating a countdown after a timer AddTime call for timer ID:"..id)
						end
					end
					DBM:FireEvent("DBM_TimerUpdate", id, elapsed, total+extendAmount)
					return DBM.Bars:UpdateBar(id, elapsed, total+extendAmount)
				end
			end
		end
	end

	function timerPrototype:RemoveTime(reduceAmount, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			return--Do nothing
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar then
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					local newRemaining = (total-reduceAmount) - elapsed
					if newRemaining > 0 then
						if bar.countdown and newRemaining > 2 then
							DBM:Unschedule(playCountSound, id)
							if not bar.fade then--Don't start countdown voice if it's faded bar
								playCountdown(id, newRemaining, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
								DBM:Debug("Updating a countdown after a timer RemoveTime call for timer ID:"..id)
							end
						end
						DBM:FireEvent("DBM_TimerUpdate", id, elapsed, total-reduceAmount)
						return DBM.Bars:UpdateBar(id, elapsed, total-reduceAmount)
					else--New remaining less than 0
						if bar.countdown then
							DBM:Unschedule(playCountSound, id)
						end
						DBM:FireEvent("DBM_TimerStop", id)
						return DBM.Bars:CancelBar(id)
					end
				end
			end
		end
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116)
		end
	end

	function timerPrototype:UpdateInline(newInline, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
			return bar:SetText(ttext, newInline or self.inlineIcon)
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetText(name, self.inlineIcon)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName, colorType, countdown)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer", nil, colorType, countdown)
		end
	end

	--If a new countdown default is added to a NewTimer object, change optionName of timer to reset a new default
	function bossModPrototype:NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		if r and type(r) == "string" then
			DBM:Debug("|cffff0000r probably has inline icon in it and needs to be fixed for |r"..name..r)
			r = nil--Fix it for users
		end
		if inlineIcon and type(inlineIcon) == "number" then
			DBM:Debug("|cffff0000spellID texture path or colorType is in inlineIcon field and needs to be fixed for |r"..name..inlineIcon)
			inlineIcon = nil--Fix it for users
		end
		local icon = (type(texture) == "string" and texture:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(ssub(texture, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(texture, 3)))) or (type(texture) == "number" and GetSpellTexture(texture)) or tonumber(texture) or "136116"
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				colorType = colorType,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- If a new countdown is added to an existing timer that didn't have one before, use optionName (number) to force timer to reset defaults by assigning it a new variable
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b)
		if type(timer) == "string" and timer:match("OptionVersion") then
			DBM:Debug("|cffff0000OptionVersion hack depricated, remove it from: |r"..spellId)
			return
		end
		if type(colorType) == "number" and colorType > 7 then
			DBM:Debug("|cffff0000texture is in the colorType arg for: |r"..spellId)
		end
		--Use option optionName for optionVersion as well, no reason to split.
		--This ensures that remaining arg positions match for auto generated and regular NewTimer
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local allowdouble
		if type(timer) == "string" and timer:match("d%d+") then
			allowdouble = true
			timer = tonumber(ssub(timer, 2))
		end
		local spellName, icon
		local unparsedId = spellId
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or tonumber(texture) or spellId and select(10, GetAchievementInfo(spellId))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 136116
			if timerType == "stage" then
				colorType = 6
			end
		elseif timerType == "roleplay" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 237538
			colorType = 6
		elseif timerType == "adds" or timerType == "addscustom" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 136116
			colorType = 1
		else
			if type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = DBM:EJ_GetSectionInfo(ssub(spellId, 3)) or ""
			else
				spellName = DBM:GetSpellInfo(spellId or 0)
			end
			if spellName then
				icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(ssub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId))
			else
				icon = nil
			end
		end
		--spellName = spellName or tostring(spellId)--this actually breaks stuff in 9.0 when spell info fails to return on first try
		local timerTextValue
		if timerText then
			--If timertext is a number, accept it as a secondary auto translate spellid
			if DBM.Options.ShortTimerText and type(timerText) == "number" then
				timerTextValue = timerText
				spellName = DBM:GetSpellInfo(timerText or 0)--Override Cached spell Name
			else
				timerTextValue = self.localization.timers[timerText] or timerText--Check timers table first, otherwise accept it as literal timer text
			end
		end
		local id = "Timer"..(spellId or 0)..timerType..(optionVersion or "")
		local obj = setmetatable(
			{
				text = timerTextValue,
				type = timerType,
				spellId = spellId,
				name = spellName,--If name gets stored as nil, it'll be corrected later in Timer start, if spell name returns in a later attempt
				timer = timer,
				id = id,
				icon = icon,
				colorType = colorType,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				allowdouble = allowdouble,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "roleplay" then--Timers without spellid, generic
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	--Buff/Debuff/event on boss
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	----Buff/Debuff on players
	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
	end

	function bossModPrototype:NewCastCountTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castcount", timer, ...)
	end

	function bossModPrototype:NewCastSourceTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastSourceTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castsource", timer, ...)
	end

	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	function bossModPrototype:NewCDSpecialTimer(...)
		return newTimer(self, "cdspecial", ...)
	end

	function bossModPrototype:NewNextSpecialTimer(...)
		return newTimer(self, "nextspecial", ...)
	end

	function bossModPrototype:NewPhaseTimer(...)
		return newTimer(self, "stage", ...)
	end

	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	function bossModPrototype:NewAddsTimer(...)
		return newTimer(self, "adds", ...)
	end

	function bossModPrototype:NewAddsCustomTimer(...)
		return newTimer(self, "addscustom", ...)
	end

	function bossModPrototype:NewAITimer(...)
		return newTimer(self, "ai", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId, Name)
		local spellName
		if Name then
			spellName = Name--Pull from name stored in object
		elseif spellId then
			DBM:Debug("|cffff0000GetLocalizedTimerText fallback, this should not happen and is a bug. this fallback should be deleted if this message is never seen after async code is live|r")
			if timerType == "achievement" then
				spellName = select(2, GetAchievementInfo(spellId))
			elseif type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = DBM:EJ_GetSectionInfo(ssub(spellId, 3))
			else
				spellName = DBM:GetSpellInfo(spellId)
			end
			--Name wasn't provided, but we succeeded in gettinga  name, generate one into object now for caching purposes
			--This would really only happen if GetSpellInfo failed to return spell name on first attempt (which now happens in 9.0)
			if spellName then
				self.name = spellName
			end
		end
		if L.AUTO_TIMER_TEXTS[timerType.."short"] and DBM.Bars:GetOption("StripCDText") then
			return pformat(L.AUTO_TIMER_TEXTS[timerType.."short"], spellName)
		else
			return pformat(L.AUTO_TIMER_TEXTS[timerType], spellName)
		end
	end
end

------------------------------
--  Berserk/Combat Objects  --
------------------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - timer or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, L.MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, L.MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, L.MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, L.MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, L.SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, L.SEC) end
		end
	end

	function enragePrototype:Schedule(t)
		return self.owner:Schedule(t, self.Start, self)
	end

	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		if self.warning1 then
			self.warning1:Cancel()
		end
		if self.warning2 then
			self.warning2:Cancel()
		end
		self.bar:Stop()
	end
	enragePrototype.Stop = enragePrototype.Cancel

	function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
		timer = timer or 600
		local warning1 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk")
		local obj = setmetatable(
			{
				warning1 = warning1,
				warning2 = warning2,
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end

	function bossModPrototype:NewCombatTimer(timer, text, barText, barIcon)
		timer = timer or 10
		--NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_COMBAT, barIcon or "132349", nil, "timer_combat", nil, nil, nil, 1, 5)
		local obj = setmetatable(
			{
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end
end

---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if cat == "timer" then
		self.DefaultOptions[name.."TColor"] = extraOption or 0
		self.DefaultOptions[name.."CVoice"] = extraOptionTwo or 0
	end
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if cat == "timer" then
		self.Options[name.."TColor"] = extraOption or 0
		self.Options[name.."CVoice"] = extraOptionTwo or 0
	end
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name.."SWSound"] = defaultSound or 1
	self.DefaultOptions[name.."SWNote"] = true
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name.."SWSound"] = defaultSound or 1
	self.Options[name.."SWNote"] = true
	self:SetOptionCategory(name, cat)
end

function bossModPrototype:AddSetIconOption(name, spellId, default, isHostile, iconsUsed)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "icon")
	if isHostile then
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = L.AUTO_ICONS_OPTION_TEXT2:format(spellId)
	else
		self.localization.options[name] = L.AUTO_ICONS_OPTION_TEXT:format(spellId)
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name].." ("
		for i=1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			if 		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t"
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t"
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t"
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t"
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t"
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t"
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t"
			end
		end
		self.localization.options[name] = self.localization.options[name]..")"
	end
end

function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if isRunTo == 2 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT:format(spellId)
	elseif isRunTo == 3 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT3:format(spellId)
	else
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT2:format(spellId)
	end
end

function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["RangeFrame"] = (default == nil) or default
	self:SetOptionCategory("RangeFrame", "misc")
	if spellId then
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
end

function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if spellId then
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT:format(spellId)
	else
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT_MULTI
	end
end

function bossModPrototype:AddNamePlateOption(name, spellId, default)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = L.AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame"..oVersion] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame"..oVersion] = (default == nil) or default
	self:SetOptionCategory("InfoFrame"..oVersion, "misc")
	if spellId then
		self.localization.options["InfoFrame"..oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
	else
		self.localization.options["InfoFrame"..oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT2
	end
end

function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = L.AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

function bossModPrototype:AddSpeedClearOption(name, default)
	self.DefaultOptions["SpeedClearTimer"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["SpeedClearTimer"] = (default == nil) or default
	self:SetOptionCategory("SpeedClearTimer", "timer")
	self.localization.options["SpeedClearTimer"] = L.AUTO_SPEEDCLEAR_OPTION_TEXT:format(name)
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "slider", value = default or 0}
	self.Options[name] = default or 0
	self:SetOptionCategory(name, cat)
	self.sliders = self.sliders or {}
	self.sliders[name] = {
		minValue = minValue,
		maxValue = maxValue,
		valueStep = valueStep,
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddEditboxOption(name, default, cat, width, height, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "editbox", value = default or ""}
	self.Options[name] = default or ""
	self:SetOptionCategory(name, cat)
	self.editboxes = self.editboxes or {}
	self.editboxes[name] = {
		width = width,
		height = height
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddButton(name, onClick, cat, width, height, fontObject)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = {
		onClick = onClick,
		width = width,
		height = height,
		fontObject = fontObject
	}
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
function bossModPrototype:AddDropdownOption(name, options, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "dropdown", value = default}
	self.Options[name] = default
	self:SetOptionCategory(name, cat)
	self.dropdowns = self.dropdowns or {}
	self.dropdowns[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddOptionSpacer(cat)
	cat = cat or "misc"
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

function bossModPrototype:AddOptionLine(text, cat)
	cat = cat or "misc"
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
	end
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], {line = true, text = text})
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end

function bossModPrototype:AddAnnounceLine(text)
	return self:AddOptionLine(text, "announce")
end

function bossModPrototype:AddTimerLine(text)
	return self:AddOptionLine(text, "timer")
end

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc")
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for i, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[i] = nil
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
	end
	tinsert(self.optionCategories[cat], name)
	tinsert(self.categorySort, cat)
end

--------------
--  Combat  --
--------------
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	local info = {
		type = cType,
		mob = self.creatureId,
		eId = self.encounterId,
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
	end
	if self.multiEncounterPullDetection then
		info.multiEncounterPullDetection = self.multiEncounterPullDetection
	end
	if self.noESDetection then
		info.noESDetection = self.noESDetection
	end
	if self.noEEDetection then
		info.noEEDetection = self.noEEDetection
	end
	if self.noBKDetection then
		info.noBKDetection = self.noBKDetection
	end
	if self.noFriendlyEngagement then
		info.noFriendlyEngagement = self.noFriendlyEngagement
	end
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.noWBEsync then
		info.noWBEsync = self.noWBEsync
	end
	if self.noBossDeathKill then
		info.noBossDeathKill = self.noBossDeathKill
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for _, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for v in pairs(self.zones) do
		DBM.combatInfo[v] = DBM.combatInfo[v] or {}
		tinsert(DBM.combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	if msgType == "kill" then
		if select("#", ...) > 0 then -- calling this method with 0 IDs means "use the values from SetCreatureID", this is already done by RegisterCombat as calling RegisterKill should be optional --> mod:RegisterKill("kill") with no IDs is never necessary
			self.combatInfo.killMobs = {}
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if type(v) == "number" then
					self.combatInfo.killMobs[v] = true
				end
			end
		end
	else
		self.combatInfo.killType = msgType
		self.combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			self.combatInfo.killMsgs[v] = true
		end
	end
end

function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.noCombatInVehicle = not flag
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
			self.numBoss = #self.multiMobPullDetection
			if self.inCombat then
				--Called mid combat, fix some variables
				self.vb.bossLeft = self.numBoss
			end
		end
		for i = 1, select("#", ...) do
			local cId = select(i, ...)
			DBM.bossIds[cId] = true
		end
	else
		local cId = ...
		DBM.bossIds[cId] = true
		self.numBoss = 1
	end
end

function bossModPrototype:SetEncounterID(...)
	self.encounterId = ...
	if select("#", ...) > 1 then
		self.multiEncounterPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiEncounterPullDetection = self.multiEncounterPullDetection
		end
	end
end

function bossModPrototype:DisableESCombatDetection()
	self.noESDetection = true
	if self.combatInfo then
		self.combatInfo.noESDetection = true
	end
end

function bossModPrototype:DisableEEKillDetection()
	self.noEEDetection = true
	if self.combatInfo then
		self.combatInfo.noEEDetection = true
	end
end

function bossModPrototype:DisableBKKillDetection()
	self.noBKDetection = true
	if self.combatInfo then
		self.combatInfo.noBKDetection = true
	end
end

function bossModPrototype:DisableFriendlyDetection()
	self.noFriendlyEngagement = true
	if self.combatInfo then
		self.combatInfo.noFriendlyEngagement = true
	end
end

function bossModPrototype:DisableRegenDetection()
	self.noRegenDetection = true
	if self.combatInfo then
		self.combatInfo.noRegenDetection = true
	end
end

function bossModPrototype:DisableWBEngageSync()
	self.noWBEsync = true
	if self.combatInfo then
		self.combatInfo.noWBEsync = true
	end
end

function bossModPrototype:IsInCombat()
	return self.inCombat
end

function bossModPrototype:IsAlive()
	return not UnitIsDeadOrGhost("player")
end

function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

-- needs to be called after RegisterCombat
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.wipeTimer = t
end

-- fix for LFR ToES Tsulong combat detection bug after killed.
function bossModPrototype:SetReCombatTime(t, t2)--T1, after kill. T2 after wipe
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function bossModPrototype:SetOOCBWComms()
	tinsert(DBM.oocBWComms, self)
end

-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, ...)
	event = event or ""
	local arg = select("#", ...) > 0 and strjoin("\t", tostringall(...)) or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id .. event .. arg -- *not* the same as the sync string, as it doesn't use the revision information
	local time = GetTime()
	--Mod syncs are more strict and enforce latency threshold always.
	--Do not put latency check in main sendSync local function (line 313) though as we still want to get version information, etc from these users.
	if not DBM.modSyncSpam[spamId] or (time - DBM.modSyncSpam[spamId]) > 8 then
		self:ReceiveSync(event, nil, self.revision or 0, tostringall(...))
		DBM:SendSync("M", str)
	end
end

function bossModPrototype:SendBigWigsSync(msg, extra)
	msg = "B^".. msg
	if extra then
		msg = msg .."^".. extra
	end
	if IsInGroup() then
		SendAddonMessage("BigWigs", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not DBM.modSyncSpam[spamId] or (time - DBM.modSyncSpam[spamId]) > self.SyncThreshold) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
		DBM.modSyncSpam[spamId] = time
		-- we have to use the sender as last argument for compatibility reasons (stupid old API...)
		-- avoid table allocations for frequently used number of arguments
		if select("#", ...) <= 1 then
			-- syncs with no arguments have an empty argument (also for compatibility reasons)
			self:OnSync(event, ... or "", sender)
		elseif select("#", ...) == 2 then
			self:OnSync(event, ..., select(2, ...), sender)
		else
			local tmp = { ... }
			tmp[#tmp + 1] = sender
			self:OnSync(event, unpack(tmp))
		end
	end
end

function bossModPrototype:SetRevision(revision)
	revision = parseCurseDate(revision or "")
	if not revision or revision == "@project-date-integer@" then
		-- bad revision: either forgot the svn keyword or using github
		revision = DBM.Revision
	end
	self.revision = revision
end

--Either treat it as a valid number, or a curse string that needs to be made into a valid number
function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	return DBM:Schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return DBM:Unschedule(f, self, ...)
end

function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Schedule(t, self[method], self, ...)
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod

-------------
--  Icons  --
-------------

do
	local scanExpires = {}
	local addsIcon = {}
	local addsIconSet = {}

	function bossModPrototype:SetIcon(target, icon, timer)
		if not target then return end--Fix a rare bug where target becomes nil at last second (end combat fires and clears targets)
		if DBM.Options.DontSetIcons or not DBM.enableIcons or DBM:GetRaidRank(playerName) == 0 then
			return
		end
		self:UnscheduleMethod("SetIcon", target)
		if type(icon) ~= "number" or type(target) ~= "string" then--icon/target probably backwards.
			DBM:Debug("|cffff0000SetIcon is being used impropperly. Check icon/target order|r")
			return--Fail silently instead of spamming icon lua errors if we screw up
		end
		icon = icon and icon >= 0 and icon <= 8 and icon or 8
		local uId = DBM:GetRaidUnitId(target)
		if uId and UnitIsUnit(uId, "player") and DBM:GetNumRealGroupMembers() < 2 then return end--Solo raid, no reason to put icon on yourself.
		if uId or UnitExists(target) then--target accepts uid, unitname both.
			uId = uId or target
			--save previous icon into a table.
			local oldIcon = self:GetIcon(uId) or 0
			if not self.iconRestore[uId] then
				self.iconRestore[uId] = oldIcon
			end
			--set icon
			if oldIcon ~= icon then--Don't set icon if it's already set to what we're setting it to
				SetRaidTarget(uId, self.iconRestore[uId] and icon == 0 and self.iconRestore[uId] or icon)
			end
			--schedule restoring old icon if timer enabled.
			if timer then
				self:ScheduleMethod(timer, "SetIcon", target, 0)
			end
		end
	end

	do
		local iconSortTable = {}
		local iconSet = {}

		local function sort_by_group(v1, v2)
			return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
		end

		local function clearSortTable(scanID)
			iconSortTable[scanID] = nil
			iconSet[scanID] = nil
		end

		function bossModPrototype:SetIconByAlphaTable(returnFunc, scanID)
			tsort(iconSortTable[scanID])--Sorted alphabetically
			for i = 1, #iconSortTable[scanID] do
				local target = iconSortTable[scanID][i]
				if i > 8 then
					DBM:Debug("|cffff0000Too many players to set icons, reconsider where using icons|r", 2)
					return
				end
				if not self.iconRestore[target] then
					local oldIcon = self:GetIcon(target) or 0
					self.iconRestore[target] = oldIcon
				end
				SetRaidTarget(target, i)--Icons match number in table in alpha sort
				if returnFunc then
					self[returnFunc](self, target, i)--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
				end
			end
			DBM:Schedule(1.5, clearSortTable, scanID)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
		end

		function bossModPrototype:SetAlphaIcon(delay, target, maxIcon, returnFunc, scanID)
			if not target then return end
			if DBM.Options.DontSetIcons or not DBM.enableIcons or DBM:GetRaidRank(playerName) == 0 then
				return
			end
			scanID = scanID or 1
			local uId = DBM:GetRaidUnitId(target)
			if uId or UnitExists(target) then--target accepts uid, unitname both.
				uId = uId or target
				if not iconSortTable[scanID] then iconSortTable[scanID] = {} end
				if not iconSet[scanID] then iconSet[scanID] = 0 end
				local foundDuplicate = false
				for i = #iconSortTable[scanID], 1, -1 do
					if iconSortTable[scanID][i] == uId then
						foundDuplicate = true
						break
					end
				end
				if not foundDuplicate then
					iconSet[scanID] = iconSet[scanID] + 1
					tinsert(iconSortTable[scanID], uId)
				end
				self:UnscheduleMethod("SetIconByAlphaTable")
				if maxIcon and iconSet[scanID] == maxIcon then
					self:SetIconByAlphaTable(returnFunc, scanID)
				elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(delay or 0.5, "SetIconByAlphaTable", returnFunc, scanID)
				end
			end
		end

		function bossModPrototype:SetIconBySortedTable(startIcon, reverseIcon, returnFunc, scanID)
			tsort(iconSortTable[scanID], sort_by_group)
			local icon, CustomIcons
			if startIcon and type(startIcon) == "table" then--Specific gapped icons
				CustomIcons = true
				icon = 1
			else
				icon = startIcon or 1
			end
			for _, v in ipairs(iconSortTable[scanID]) do
				if not self.iconRestore[v] then
					local oldIcon = self:GetIcon(v) or 0
					self.iconRestore[v] = oldIcon
				end
				if CustomIcons then
					SetRaidTarget(v, startIcon[icon])--do not use SetIcon function again. It already checked in SetSortedIcon function.
					icon = icon + 1
					if returnFunc then
						self[returnFunc](self, v, startIcon[icon])--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
					end
				else
					SetRaidTarget(v, icon)--do not use SetIcon function again. It already checked in SetSortedIcon function.
					if reverseIcon then
						icon = icon - 1
					else
						icon = icon + 1
					end
					if returnFunc then
						self[returnFunc](self, v, icon)--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
					end
				end
			end
			DBM:Schedule(1.5, clearSortTable, scanID)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
		end

		function bossModPrototype:SetSortedIcon(delay, target, startIcon, maxIcon, reverseIcon, returnFunc, scanID)
			if not target then return end
			if DBM.Options.DontSetIcons or not DBM.enableIcons or DBM:GetRaidRank(playerName) == 0 then
				return
			end
			scanID = scanID or 1
			if not startIcon then startIcon = 1 end
			local uId = DBM:GetRaidUnitId(target)
			if uId or UnitExists(target) then--target accepts uid, unitname both.
				uId = uId or target
				if not iconSortTable[scanID] then iconSortTable[scanID] = {} end
				if not iconSet[scanID] then iconSet[scanID] = 0 end
				local foundDuplicate = false
				for i = #iconSortTable[scanID], 1, -1 do
					if iconSortTable[scanID][i] == uId then
						foundDuplicate = true
						break
					end
				end
				if not foundDuplicate then
					iconSet[scanID] = iconSet[scanID] + 1
					tinsert(iconSortTable[scanID], uId)
				end
				self:UnscheduleMethod("SetIconBySortedTable")
				if maxIcon and iconSet[scanID] == maxIcon then
					self:SetIconBySortedTable(startIcon, reverseIcon, returnFunc, scanID)
				elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(delay or 0.5, "SetIconBySortedTable", startIcon, reverseIcon, returnFunc, scanID)
				end
			end
		end
	end

	function bossModPrototype:GetIcon(uIdOrTarget)
		local uId = DBM:GetRaidUnitId(uIdOrTarget) or uIdOrTarget
		return UnitExists(uId) and GetRaidTargetIndex(uId)
	end

	function bossModPrototype:RemoveIcon(target)
		return self:SetIcon(target, 0)
	end

	function bossModPrototype:ClearIcons()
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) then
					SetRaidTarget("raid"..i, 0)
				end
			end
		else
			for i = 1, GetNumSubgroupMembers() do
				if UnitExists("party"..i) and GetRaidTargetIndex("party"..i) then
					SetRaidTarget("party"..i, 0)
				end
			end
		end
	end

	function bossModPrototype:CanSetIcon(optionName)
		if DBM.canSetIcons[optionName] then
			return true
		end
		return false
	end

	local mobUids = {"mouseover", "target", "boss1", "boss2", "boss3", "boss4", "boss5",
		"nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
		"nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
		"nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
		"nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40"}
	function bossModPrototype:ScanForMobs(creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID, skipMarked)
		if not optionName then optionName = self.findFastestComputer[1] end
		if DBM.canSetIcons[optionName] then
			--Declare variables.
			DBM:Debug("canSetIcons true", 2)
			local timeNow = GetTime()
			if not creatureID then--This function must not be used to boss, so remove self.creatureId. Accepts cid, guid and cid table
				error("DBM:ScanForMobs calld without creatureID")
				return
			end
			iconSetMethod = iconSetMethod or 0--Set IconSetMethod -- 0: Descending / 1:Ascending / 2: Force Set / 9:Force Stop
			scanningTime = scanningTime or 8
			maxIcon = maxIcon or 8 --We only have 8 icons.
			isFriendly = isFriendly or false
			secondCreatureID = secondCreatureID or 0
			scanInterval = scanInterval or 0.2
			--With different scanID, this function can support multi scanning same time. Required for Nazgrim.
			local scanID = 0
			if type(creatureID) == "number" then
				scanID = creatureID --guid and table no not supports multi scanning. only cid supports multi scanning
			end
			if iconSetMethod == 9 then--Force stop scanning
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				return
			end
			if not addsIcon[scanID] then addsIcon[scanID] = mobIcon or 8 end
			if not addsIconSet[scanID] then addsIconSet[scanID] = 0 end
			if not scanExpires[scanID] then scanExpires[scanID] = timeNow + scanningTime end
			--DO SCAN NOW
			for _, unitid2 in ipairs(mobUids) do
				local guid2 = UnitGUID(unitid2)
				local cid2 = self:GetCIDFromGUID(guid2)
				local isEnemy = UnitIsEnemy("player", unitid2) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid2)) then
					isFiltered = true
					DBM:Debug("A unit skipped because it's a filtered mob", 3)
				end
				if not isFiltered then
					if guid2 and type(creatureID) == "table" and creatureID[cid2] and not DBM.addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid2]) == "number" then
							SetRaidTarget(unitid2, creatureID[cid2])
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						DBM.addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid2 and (guid2 == creatureID or cid2 == creatureID or cid2 == secondCreatureID) and not DBM.addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid2, mobIcon)
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						DBM.addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			for uId in DBM:GetGroupMembers() do
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				local cid = self:GetCIDFromGUID(guid)
				local isEnemy = UnitIsEnemy("player", unitid) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid)) then
					isFiltered = true
					DBM:Debug("ScanForMobs aborting because filtered mob", 2)
				end
				if not isFiltered then
					if guid and type(creatureID) == "table" and creatureID[cid] and not DBM.addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid]) == "number" then
							SetRaidTarget(unitid, creatureID[cid])
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						DBM.addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid and (guid == creatureID or cid == creatureID or cid == secondCreatureID) and not DBM.addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid, mobIcon)
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						DBM.addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			if timeNow < scanExpires[scanID] then--scan for limited times.
				self:ScheduleMethod(scanInterval, "ScanForMobs", creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID)
			else
				DBM:Debug("Stopping ScanForMobs for: "..(optionName or "nil"), 2)
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				--Do not wipe adds GUID table here, it's wiped by :Stop() which is called by EndCombat
			end
		else
			DBM:Debug("Not elected to set icons for "..(optionName or "nil"), 2)
		end
	end
end

function bossModPrototype:SetModelScale(scale)
	self.modelScale = scale
end

function bossModPrototype:SetModelOffset(x, y, z)
	self.modelOffsetX = x
	self.modelOffsetY = y
	self.modelOffsetZ = z
end

function bossModPrototype:SetModelRotation(r)
	self.modelRotation = r
end

function bossModPrototype:SetModelSequence(v)
	self.modelSequence = v
end

function bossModPrototype:SetModelID(id)
	self.modelId = id
end

function bossModPrototype:SetModelSound(long, short)--PlaySoundFile prototype for model viewer, long is long sound, short is a short clip, configurable in UI, both sound paths defined in boss mods.
	self.modelSoundLong = long
	self.modelSoundShort = short
end

function bossModPrototype:GetLocalizedStrings()
	self.localization.miscStrings.name = self.localization.general.name
	return self.localization.miscStrings
end
