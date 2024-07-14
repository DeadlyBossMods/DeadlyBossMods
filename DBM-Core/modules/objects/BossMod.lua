---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local scheduler = private:GetModule("DBMScheduler")
local tableUtils = private:GetPrototype("TableUtils")
local test = private:GetPrototype("DBMTest")

---@type table<string, DBMMod>
local modsById = setmetatable({}, {__mode = "v"})
local mt = {__index = bossModPrototype}

-- The definition of DBM mods is unfortunately spread out across multiple files and functions.
-- This class definition defines some fields that are either expected to be set by a mod implementation directly
-- or are set by helper functions in DBM.

---@class DBMMod
---@field OnCombatStart fun(self: DBMMod, delay: number, startedByCastOrRegenDisabledOrMessage: boolean, startedByEncounter: boolean)
---@field OnCombatEnd fun(self: DBMMod, wipe: boolean, delayedSecondCall: boolean?)
---@field OnLeavingCombat fun()
---@field OnSync fun(self: DBMMod, event: string, ...: string)
---@field OnBWSync fun(self: DBMMod, msg: string, extra: string, sender: string)
---@field OnTranscriptorSync fun(self: DBMMod, msg: string, sender: string)
---@field OnInitialize fun(self: DBMMod, mod: DBMMod)
---@field OnTimerRecovery fun(self: DBMMod)
---@field CustomHealthUpdate fun(self: DBMMod): string
---@field stats ModStats
---@field registeredUnitEvents table<string, boolean>?
---@field bossHealthUpdateTime number?
---@field isTrashModBossFightAllowed boolean?
---@field respawnTime number?
---@field noStatistics boolean?
---@field statTypes string?
---@field upgradedMPlus boolean?
---@field onlyHighest boolean?
---@field soloChallenge boolean?
---@field disableHealthCombat boolean?
---@field isCustomMod boolean?
---@field sendMainBossGUID boolean? Used to force enable nameplate timers for main boss

---@param name string|number Name of mod is usually journalID for auto translation or a unique string
---@param modId string? Must match parent module name (ie DBM-Party-Classic) or it won't appear in GUI
---@param modSubTab number? Defines sub tab for mod in GUI
---@param instanceId number? Encounter Journal Instance ID
---@param nameModifier number|function?
function DBM:NewMod(name, modId, modSubTab, instanceId, nameModifier)
	name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
	if name == "DBM-ProfilesDummy" then return {} end
	if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
	---@type table
	local addon = nil
	for _, v in ipairs(self.AddOns) do
		if v.modId == modId then
			addon = v
			break
		end
	end
	---@class DBMMod
	local obj = setmetatable(
		{
			Options = {
				Enabled = true,
			},
			---@type table<string, any>
			DefaultOptions = {
				Enabled = true,
			},
			subTab = modSubTab,
			optionCategories = {
			},
			categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "specialannounce", "timer", "sound", "yell", "nameplate", "paura", "icon", "misc"},
			id = name,
			announces = {},
			specwarns = {},
			timers = {},
			yells = {},
			vb = {},
			iconRestore = {},
			modId = modId,
			instanceId = instanceId,
			revision = 0,
			SyncThreshold = 8,
			localization = self:GetModLocalization(name),
			groupSpells = {},
			groupOptions = tableUtils.orderedTable(),
			addon = addon,
			inCombat = false,
			isTrashMod = false,
			isDummyMod = false,
		},
		mt
	)
	test:Trace(obj, "NewMod", name, modId)
	if test.testRunning and test.Mocks and test.Mocks.SetModEnvironment then
		test.Mocks:SetModEnvironment(2)
	end

	if tonumber(name) and EJ_GetEncounterInfo and EJ_GetEncounterInfo(tonumber(name)) then
		local t = EJ_GetEncounterInfo(tonumber(name))
		if type(nameModifier) == "number" then--Get name form EJ_GetCreatureInfo
			t = select(2, EJ_GetCreatureInfo(nameModifier, tonumber(name)))
		elseif type(nameModifier) == "function" then--custom name modify function
			t = nameModifier(t or name)
		else--default name modify
			t = tostring(t)
			t = string.split(",", t or name)
		end
		obj.localization.general.name = t or name
		obj.modelId = select(4, EJ_GetCreatureInfo(1, tonumber(name)))
	elseif name:match("z%d+") then
		local t = GetRealZoneText(tonumber(string.sub(name, 2)))
		if type(nameModifier) == "number" then--do nothing
		elseif type(nameModifier) == "function" then--custom name modify function
			t = nameModifier(t or name)
		else--default name modify
			t = string.split(",", t or name)
		end
		obj.localization.general.name = t or name
	elseif name:match("m%d+") then
		local t = C_Map.GetMapInfo(tonumber(name:sub(2)) or 0)
		local nameStr = t and t.name
		if type(nameModifier) == "number" then--do nothing
		elseif type(nameModifier) == "function" then--custom name modify function
			nameStr = nameModifier(nameStr or name)
		else--default name modify
			nameStr = string.split(",", nameStr or name)
		end
		obj.localization.general.name = nameStr or name
	elseif name:match("d%d+") then
		local t = self:GetDungeonInfo(string.sub(name, 2))
		if type(nameModifier) == "number" then--do nothing
		elseif type(nameModifier) == "function" then--custom name modify function
			t = nameModifier(t or name)
		else--default name modify
			t = string.split(",", t or obj.localization.general.name or name)
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

---@param name string|number
---@return DBMMod
function DBM:GetModByName(name)
	return modsById[tostring(name)]
end


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
	if type(func) ~= "function" then return end
	DBM:Debug("Registering RegisterOnUpdateHandler")
	scheduler:StartScheduler()
	self.elapsed = 0
	self.updateInterval = interval or 0
	private.updateFunctions[self] = func
end

function bossModPrototype:UnregisterOnUpdateHandler()
	self.elapsed = nil
	self.updateInterval = nil
	table.wipe(private.updateFunctions)
end

---Set the stage number.
---<br>Use 0 to auto increment by 1
---<br>Use 0.5 to auto increment by 0.5
---@param stage number
function bossModPrototype:SetStage(stage)
	if stage == 0 then--Increment request instead of hard value
		if not self.vb.phase then return end--Person DCed mid fight and somehow managed to perfectly time running SetStage with a value of 0 before getting variable recovery
		self.vb.phase = self.vb.phase + 1
	elseif stage == 0.5 then--Half Increment request instead of hard value
		self.vb.phase = self.vb.phase + 0.5
	else
		self.vb.phase = stage
	end
	--Separate variable to use SetStage totality for very niche weak aura practices
	if not self.vb.stageTotality then
		self.vb.stageTotality = 0
	end
	self.vb.stageTotality = self.vb.stageTotality + 1
	if self.inCombat then--Safety, in event mod manages to run any phase change calls out of combat/during a wipe we'll just safely ignore it
		DBM:FireEvent("DBM_SetStage", self, self.id, self.vb.phase, self.multiEncounterPullDetection and self.multiEncounterPullDetection[1] or self.encounterId, self.vb.stageTotality)--Mod, modId, Stage, Encounter Id (if available), total number of times SetStage has been called since combat start
		--Note, some encounters have more than one encounter Id, for these encounters, the first ID from mod is always returned regardless of actual engage ID triggered fight
		DBM:Debug("DBM_SetStage: " .. self.vb.phase .. "/" .. self.vb.stageTotality)
	end
end

---If args are passed, returns true or false for specific Stage
---<br>If no args given, just returns current stage and stage total
---@param stage number? stage value to checkf or true/false rules
---@param checkType number? 0 or nil for just current stage match, 1 for less than check, 2 for greater than check, 3 not equal check
---@param useTotal boolean? uses stage total instead of current
function bossModPrototype:GetStage(stage, checkType, useTotal)
	local currentStage, currentTotal = self.vb.phase or 0, self.vb.stageTotality or 0
	if stage then
		checkType = checkType or 0--Optional pass if just an exact match check
		if (checkType == 0) and (useTotal and currentTotal or currentStage) == stage then
			return true
		elseif (checkType == 1) and (useTotal and currentTotal or currentStage) < stage then
			return true
		elseif (checkType == 2) and (useTotal and currentTotal or currentStage) > stage then
			return true
		elseif (checkType == 3) and (useTotal and currentTotal or currentStage) ~= stage then
			return true
		end
		return false
	else
		return currentStage, currentTotal--This api doesn't need encounter Id return, since this is the local mod prototype version, which means it's already linked to specific encounter
	end
end

---Used to flag an event during a boss fight that affects Raid affixes
---@param eventType number 0 = Stop, 1 = Start, 2 = extend due to spell queue/delay
---@param stage number?
---@param timeAdjust number? Used to define extend amount for eventType 2
---@param spellDebit boolean? The extended timer is debited from next cast
function bossModPrototype:AffixEvent(eventType, stage, timeAdjust, spellDebit)
	if self.inCombat then--Safety, in event mod manages to run any phase change calls out of combat/during a wipe we'll just safely ignore it
		DBM:FireEvent("DBM_AffixEvent", self, self.id, eventType, self.multiEncounterPullDetection and self.multiEncounterPullDetection[1] or self.encounterId, stage or 1, timeAdjust, spellDebit)--Mod, modId, type (0 end, 1, begin, 2, timerExtend), Encounter Id (if available), stage, amount of time to extend to, spellDebit, whether to subtrack the previous extend arg from next timer
	end
end

---@param ... DBMEvent|string
function bossModPrototype:RegisterEventsInCombat(...)
	test:Trace(self, "RegisterEvents", "InCombat", ...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(-11) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.inCombatOnlyEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
		end
	end
end

---Used to filter casts from non combat units
---@param sourceGUID string
---@param customunitID string? if provided, makes check require GUID match this unitID (such as "target")
---@param loose boolean? In a loose check, this just checks if we're in combat and alone. Designed for solo runs like torghast or delves
---@param allowFriendly boolean?
---@param strict boolean? Used for even more strict filtering that makes it also require player themselves are in combat (usually used in outdoor world such as timeless isle)
---@return boolean
function bossModPrototype:IsValidWarning(sourceGUID, customunitID, loose, allowFriendly, strict)
	if loose and InCombatLockdown() and GetNumGroupMembers() < 2 then return true end
	if customunitID then
		if UnitExists(customunitID) and UnitGUID(customunitID) == sourceGUID and UnitAffectingCombat(customunitID) and (allowFriendly or not UnitIsFriend("player", customunitID)) then return true end
	else
		local unitId = DBM:GetUnitIdFromGUID(sourceGUID)
		if unitId and UnitExists(unitId) and UnitAffectingCombat(unitId) and (allowFriendly or not UnitIsFriend("player", unitId)) then
			if strict and not InCombatLockdown() then
				return false
			else
				return true
			end
		end
	end
	return false
end

function bossModPrototype:IsCriteriaCompleted(criteriaIDToCheck)
	if not private.isRetail then--Fixme if MoP classic becomes a thing
		print("bossModPrototype:IsCriteriaCompleted should not be called in classic, report this message")
		return false
	end
	if not criteriaIDToCheck then
		error("usage: mod:IsCriteriaComplected(criteriaId)")
		return false
	end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	local GetCriteriaInfo = C_ScenarioInfo.GetCriteriaInfo or C_Scenario.GetCriteriaInfo
	for i = 1, numCriteria do
		local info, _, criteriaCompleted, _, _, _, _, _, criteriaID = GetCriteriaInfo(i)
		--Quick/lazy fix for War Within. Cleanup later when all clients are updated
		if type(info) == "table" then
			criteriaCompleted = info.completed
			criteriaID = info.criteriaID
		end
		if criteriaID and criteriaID == criteriaIDToCheck and criteriaCompleted then
			return true
		end
	end
	return false
end

---Used to restrict enclosed code to only run if player is under a certain latency threshold
---@param custom number? Custom latency threshold to check against, otherwise global threshold is used
---@return boolean
function bossModPrototype:LatencyCheck(custom)
	return select(4, GetNetStats()) < (custom or DBM.Options.LatencyThreshold)
end

bossModPrototype.IconNumToString = DBM.IconNumToString
bossModPrototype.IconNumToTexture = DBM.IconNumToTexture
bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.HasMapRestrictions = DBM.HasMapRestrictions
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID
bossModPrototype.GetUnitIdFromCID = DBM.GetUnitIdFromCID
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby
bossModPrototype.GetGossipID = DBM.GetGossipID
bossModPrototype.SelectMatchingGossip = DBM.SelectMatchingGossip
bossModPrototype.SelectGossip = DBM.SelectGossip

do
	local bossCache = {}
	local lastTank

	---Returns current name and unitID of person tanking requested target if possible, false otherwise
	---@param cidOrGuid number|string
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
					local id = (i == 0 and "target") or unitId .. i
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
				return lastTank, uId
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
	local IsItemInRange = C_Item and C_Item.IsItemInRange or IsItemInRange

	---Used when we want to alert or filter based on proximity to the casting boss
	---@param cidOrGuid number|string
	---@param onlyBoss boolean? Used when you only need to check "boss" unitids
	---@param itemId number? Used to define which item (range) is used. 32698 (48) is used if empty
	---@param distance number? Used for tank distance fallback if item api is restricted
	---@param defaultReturn boolean? Fallback return if all checks fail (whether a failure returns true or false)
	---@return boolean
	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, distance, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId
		if type(cidOrGuid) == "number" then--CID passed
			uId = DBM:GetUnitIdFromCID(cidOrGuid, onlyBoss)
		else--GUID
			uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		end
		if uId then
			if not UnitIsFriend("player", uId) then--API only allowed on hostile unit
				itemId = itemId or 32698
				--/dump IsItemInRange(32698, "target")
				local inRange = IsItemInRange(itemId, uId)
				if inRange ~= nil then--IsItemInRange was a success if it returned true or false, if it failed it returns nil
					return inRange
				else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
					DBM:Debug("CheckBossDistance failed on IsItemInRange due to bad check/unitId: " .. cidOrGuid, 2)
					return self:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)--Return tank distance check fallback
				end
			else--Non hostile, immediately forward to very gimped TankDistance check (43 yards within tank target)
				DBM:Debug("CheckBossDistance failed on IsItemInRange due to friendly unit: " .. cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: " .. cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	---This is still restricted because it uses friendly api, which isn't available to us in combat
	---@param cidOrGuid number|string
	---@param onlyBoss boolean? Used when you only need to check "boss" unitids
	---@param defaultReturn boolean? Fallback return if all checks fail (whether a failure returns true or false)
	---@return boolean
	function bossModPrototype:CheckTankDistance(cidOrGuid, _, onlyBoss, defaultReturn)--distance
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		--distance = distance or 43--Basically unused
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			return rangeCache[cidOrGuid]
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid, onlyBoss)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId .. i
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
						rangeCache[cidOrGuid] = inRange2
						return inRange2
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						rangeCache[cidOrGuid] = true
						return true
					end
				end
				--Return true as safety
				rangeCache[cidOrGuid] = true
				return true
			end
			DBM:Debug("CheckTankDistance failed on uId for: " .. cidOrGuid, 2)
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

-----------------------
--  Filter Methods  --
-----------------------

do
	local interruptSpells = {
		[1766] = true,--Rogue Kick
		[2139] = true,--Mage Counterspell
		[6552] = true,--Warrior Pummel
		[15487] = true,--Priest Silence
		[19647] = true,--Warlock pet Spell Lock
		[47528] = true,--Death Knight Mind Freeze
		[57994] = true,--Shaman Wind Shear
		[78675] = true,--Druid Solar Beam
		[89766] = true,--Warlock Pet Axe Toss
		[96231] = true,--Paldin Rebuke
		[106839] = true,--Druid Skull Bash
		[116705] = true,--Monk Spear Hand Strike
		[147362] = true,--Hunter Countershot
		[183752] = true,--Demon hunter Disrupt
--		[202137] = true,--Demon Hunter Sigil of Silence (Not uncommented because CheckInterruptFilter doesn't properly handle dual interrupts for single class yet)
		[351338] = true,--Evoker Quell
	}
	if private.isClassic then
		interruptSpells[8042] = true -- Shaman Earth Shock
	end
	---@param sourceGUID string
	---@param checkOnlyTandF boolean? is used when CheckInterruptFilter is actually being used for a simpe target/focus check and nothing more.
	---@param checkCooldown boolean? should always be passed true except for special rotations like count warnings when you should be alerted it's your turn even if you dropped ball and put it on CD at wrong time
	---@param ignoreTandF boolean? is usually used when interrupt is on a main boss or event that is global to entire raid and should always be alerted regardless of targetting.
	---@return boolean
	function bossModPrototype:CheckInterruptFilter(sourceGUID, checkOnlyTandF, checkCooldown, ignoreTandF)
		--Check healer spec filter
		if self:IsHealer() and (self.isTrashMod and DBM.Options.FilterTInterruptHealer or not self.isTrashMod and DBM.Options.FilterBInterruptHealer) then
			return false
		end

		--Check if cooldown check is required
		if checkCooldown and (self.isTrashMod and DBM.Options.FilterTInterruptCooldown or not self.isTrashMod and DBM.Options.FilterBInterruptCooldown) then
			for spellID, _ in pairs(interruptSpells) do
				--For an inverse check, don't need to check if it's known, if it's on cooldown it's known
				--This is possible since no class has 2 interrupt spells (well, actual interrupt spells)
				if (DBM:GetSpellCooldown(spellID)) ~= 0 then--Spell is on cooldown
					return false
				end
			end
		end

		local unitID
		-- Always assume we are currently targeting the unit in question in tests
		if UnitGUID("target") == sourceGUID or test.testRunning then
			unitID = "target"
		elseif not private.isClassic and (UnitGUID("focus") == sourceGUID) then
			unitID = "focus"
		elseif private.isRetail and (UnitGUID("softenemy") == sourceGUID) then
			unitID = "softenemy"
		end
		--Check if target/focus is required (or if checkOnlyTandF is used, meaning this isn't actually an interrupt API check)
		if checkOnlyTandF or (self.isTrashMod and DBM.Options.FilterTTargetFocus or not self.isTrashMod and DBM.Options.FilterBTargetFocus) then
			--Just return false if source isn't our target or focus, no need to do further checks
			if not ignoreTandF and not unitID then
				return false
			end
		end

		--Check if it's casting something that's not interruptable at the moment
		--needed for torghast since many mobs can have interrupt immunity with same spellIds as other mobs that can be interrupted
		if private.isRetail and unitID then
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
end

do
	--Only checks spells relevant for the dispel type
	---@enum (key) DispelType
	local typeCheck = {
		["magic"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[527] = true,--Priest: Purify (Magic and Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
			[89808] = true,--Warlock: Singe Magic (Magic)
			[360823] = true,--Evoker: Naturalize (Magic and Poison)
		},
		["curse"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[2782] = true,--Druid: Remove Corruption (Curse and Poison)
			[51886] = true,--Shaman: Cleanse Spirit (Curse)
			[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
			[475] = true,--Mage: Remove Curse (Curse)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
		["poison"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[2782] = true,--Druid: Remove Corruption (Curse and Poison)
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[218164] = true,--Monk: Detox (non Healer) (Poison and Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[360823] = true,--Evoker: Naturalize (Magic and Poison)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
			[365585] = true,--Evoker: Expunge (Poison)
		},
		["disease"] = {
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[218164] = true,--Monk: Detox (non Healer) (Poison and Disease)
			[527] = true,--Priest: Purify (Magic and Disease)
			[213634] = true,--Priest: Purify Disease (Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
		["bleed"] = {
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
	}
	local lastCheck, lastReturn = 0, true
	---Smart alert filtering based on cooldown check for dispel type
	---@param dispelType DispelType
	function bossModPrototype:CheckDispelFilter(dispelType)
		if not DBM.Options.FilterDispel then return true end
		-- Retail - Druid: Nature's Cure (88423), Remove Corruption (2782), Monk: Detox (115450) Monk: Detox (218164), Priest: Purify (527) Priest: Purify Disease (213634), Paladin: Cleanse (4987), Shaman: Cleanse Spirit (51886), Purify Spirit (77130), Mage: Remove Curse (475), Warlock: Singe Magic (89808)
		-- Classic - Druid: Remove Curse (2782), Priest: Purify (527), Paladin: Cleanse (4987), Mage: Remove Curse (475)
		--start, duration, enable = GetSpellCooldown
		--start & duration == 0 if spell not on cd
		if UnitIsDeadOrGhost("player") then return false end--if dead, can't dispel
		if GetTime() - lastCheck < 0.1 then--Recently returned status, return same status to save cpu from aggressive api checks caused by CheckDispelFilter running on multiple raid members getting debuffed at once
			return lastReturn
		end
		if dispelType then
			--Singe magic requires checking if pet is out
			if dispelType == "magic" and (DBM:GetSpellCooldown(89808)) == 0 and (UnitExists("pet") and self:GetCIDFromGUID(UnitGUID("pet")) == 416) then
				lastCheck = GetTime()
				lastReturn = true
				return true
			end
			--We cannot do inverse check here because some classes actually have two dispels for same type (such as evoker)
			--Therefor, we can't go false if only one of them are on cooldown. We have to go true of any of them aren't on CD instead
			--As such, we have to check if a spell is known in addition to it not being on cooldown
			for spellID, _ in pairs(typeCheck[dispelType]) do
				if typeCheck[dispelType][spellID] and IsSpellKnown(spellID) and (DBM:GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					if (spellID == 4987 or spellID == 88423) and not DBM:IsHealer() then--These spellIds can only dispel if healer specced
						lastReturn = false
					else--We trust the table return
						lastReturn = true
					end
					return lastReturn
				end
			end
		else--use lazy check until all mods are migrated to define type
			error("DBM CheckDispelFilter must provide dispel type")
		end
		lastCheck = GetTime()
		lastReturn = false
		return false
	end
end

do
	--Spell tables likely missing stuff
	---@enum (key) CCType
	local typeCheck = {
		["disrupt"] = {--used for abilities that any CC will break (except root and slow type spells since they don't stop casts)
			[107570] = true,--Warrior: Storm Bolt (Stun)
			[46968] = true,--Warrior: Shockwave (Stun)
			[221562] = true,--DK: Asphyxiate (Stun)
			[179057] = true,--DH: Chaos Nova (Stun)
		},
		["stun"] = {
			[107570] = true,--Warrior: Storm Bolt (Stun)
			[46968] = true,--Warrior: Shockwave (Stun)
			[221562] = true,--DK: Asphyxiate (Stun)
			[5211] = true,--Druid: Mighty Bash (Stun)
			[408] = true,--Rogue: Kidney Shot (Stun)
			[1833] = true,--Rogue: Cheap Shot (Stun)
			[192058] = true,--Shaman: Capacitor Totem (Stun)
		},
		["knock"] = {
			[132469] = true,--Druid: Typhoon
			--[102793] = true,--Druid: Ursol's Vortex
			[108199] = true,--DK: Gorefiends Grasp
			[49576] = true,--DK: Death Grip (!Also a taunt!)
			[157981] = true,--Mage: Blast Wave
			[51490] = true,--Shaman: Thunderstorm
		},
		["disorient"] = {
			[5246] = true,--Warrior: Intimidating Shout
			[33786] = true,--Druid: Cyclone
			[2094] = true,--Rogue: Blind
			[31661] = true,--Mage: Dragon's Breath
		},
		["incapacitate"] = {
			[99] = true,--Druid: Incapacitating Roar
			[217832] = true,--DH: Imprison
			[118] = true,--Mage: Polymorph (Should be shared CD with all variants, so only need one ID)
			[383121] = true,--Mage: Mass Polymorph
			[197214] = true,--Shaman: Sundering
			[51514] = true,--Shaman: Hex
		},
		["root"] = {
			[339] = true,--Druid: Entangling roots
			[122] = true,--Mage: Frost Nova
			[51485] = true,--Shaman: Earthgrab Totem
		},
		--Many slows are spamable abilities, but can still be used in inverse CD filter
		--Since this filter checks if it's available, not if it isn't
		--So can still also be used as an "Is a slow spell known" check :D
		["slow"] = {
			[1715] = true,--Warrior: Hamstring
			[45524] = true,--DK: Chains of Ice
			[202138] = true,--DH: Sigil of Chains (also a knock?)
			[120] = true,--Mage: Cone of Cold
			[2484] = true,--Shaman: Earthbind Totem
		},
		["sleep"] = {
			[2637] = true,--Druid: Hibernate
		},
	}
	local lastCheck, lastReturn = 0, true
	---Smart alert filtering based on cooldown check for cc type
	---@param ccType CCType
	function bossModPrototype:CheckCCFilter(ccType)
		if not DBM.Options.FilterCrowdControl then return true end
		--start, duration, enable = GetSpellCooldown
		--start & duration == 0 if spell not on cd
		if UnitIsDeadOrGhost("player") then return false end--if dead, can't crowd control
		if GetTime() - lastCheck < 0.1 then--Recently returned status, return same status to save cpu from aggressive api checks caused by CheckCCFilter running from multiple mobs casting at once
			return lastReturn
		end
		--We cannot do inverse check here because some classes actually have two ccs for same type (such as warrior)
		--Therefor, we can't go false if only one of them are on cooldown. We have to go true of any of them aren't on CD instead
		--As such, we have to check if a spell is known in addition to it not being on cooldown
		for spellID, _ in pairs(typeCheck[ccType]) do
			if typeCheck[ccType][spellID] and IsSpellKnown(spellID) and (DBM:GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
				lastCheck = GetTime()
				lastReturn = true
				return lastReturn
			end
		end
		lastCheck = GetTime()
		lastReturn = false
		return false
	end
end

---Automatic parsing of allTimers tables in boss mods
---@param table table the table name that contains all the data
---@param difficultyName string|boolean string for difficulty name, false otherwise
---@param phase number|boolean number for phase number, false otherwise
---@param spellId number
---@param count number|boolean? cast count if count object, false/nil otherwise
function bossModPrototype:GetFromTimersTable(table, difficultyName, phase, spellId, count)
	local prev = table

	if difficultyName ~= false then
		if not difficultyName or not prev[difficultyName] then
			DBM:Debug("difficultyName is missing from table")
			return
		end
		prev = prev[difficultyName]
	end

	if phase ~= false then
		if not phase or not prev[phase] then
			DBM:Debug("phase is missing from table")
			return
		end
		prev = prev[phase]
	end

	if not prev[spellId] then
		DBM:Debug("spellId is missing from table")
		return
	end
	prev = prev[spellId]

	if count then
		prev = prev[count]
	end

	return prev
end


--Function to actually register specific media to specific auras
---@param auraspellId number ID of Private aura we're actually monitoring (if it doesn't match option key, put option key in altOptionId)
---@param voice VPSound|any voice pack media path
---@param voiceVersion number Required voice pack verion (if not met, falls back to default special warning sounds)
---@param altOptionId number? Used if auraspellId doesn't match option key (usually happens when registering multiple ids for a single spell)
function bossModPrototype:EnablePrivateAuraSound(auraspellId, voice, voiceVersion, altOptionId)
	if DBM.Options.DontPlayPrivateAuraSound then return end
	local optionId = altOptionId or auraspellId
	if optionId and self.Options["PrivateAuraSound" .. optionId] then
		if not self.paSounds then self.paSounds = {} end
		local soundId = self.Options["PrivateAuraSound" .. optionId .. "SWSound"] or DBM.Options.SpecialWarningSound--Shouldn't be nil value, but just in case options fail to load, fallback to default SW1 sound
		local mediaPath
		--Check valid voice pack sound
		local chosenVoice = DBM.Options.ChosenVoicePack2
		if chosenVoice ~= "None" and not private.voiceSessionDisabled and voiceVersion <= private.swFilterDisabled then
			local isVoicePackUsed
			--Vet if user has voice pack enabled by sound ID
			if type(soundId) == "number" and soundId < 5 then--Value 1-4 are SW1 defaults, otherwise it's file data ID and handled by Custom
				isVoicePackUsed = DBM.Options["VPReplacesSA" .. soundId]
			else
				isVoicePackUsed = DBM.Options.VPReplacesCustom
			end
			if isVoicePackUsed then
				mediaPath = "Interface\\AddOns\\DBM-VP" .. chosenVoice .. "\\" .. voice .. ".ogg"
			else
				mediaPath = type(soundId) == "number" and DBM.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId
			end
		else
			mediaPath = type(soundId) == "number" and DBM.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId
		end
		--Absolute media path is still a number, so at this point we know it's file data Id, we need to set soundFileID
		if type(mediaPath) == "number" then
			self.paSounds[#self.paSounds + 1] = C_UnitAuras.AddPrivateAuraAppliedSound({
				spellID = auraspellId,
				unitToken = "player",
				soundFileID = mediaPath,
				outputChannel = "master",
			})
		else--It's a string, so it's not an ID, we need to set soundFileName instead
			self.paSounds[#self.paSounds + 1] = C_UnitAuras.AddPrivateAuraAppliedSound({
				spellID = auraspellId,
				unitToken = "player",
				--Another cause of LuaLS being stupid for some reason
				---@diagnostic disable-next-line: assign-type-mismatch
				soundFileName = mediaPath,
				outputChannel = "master",
			})
		end
	end
end

--TODO, add ability to remove specific ID only with this function. I'm not so good with tables though so gotta figure it out later
function bossModPrototype:DisablePrivateAuraSounds()
	if DBM.Options.DontPlayPrivateAuraSound then return end
	for _, id in next, self.paSounds do
		C_UnitAuras.RemovePrivateAuraAppliedSound(id)
	end
	self.paSounds = nil
end

---@param t number
---@param f function
---@param ... any?
function bossModPrototype:Schedule(t, f, ...)
	return scheduler:Schedule(t, f, self, ...)
end

---@param f function? If nil, all schedules for this mod are unscheduled
---@param ... any?
function bossModPrototype:Unschedule(f, ...)
	return scheduler:Unschedule(f, self, ...)
end

---@param t number
---@param method string
---@param ... any?
function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	local id = self:Schedule(t, self[method], self, ...)
	test:Trace(self, "SetScheduleMethodName", id, self, method, ...)
	return id
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

---@param method string
---@param ... any?
function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod

-----------------------
--  Model Functions  --
-----------------------
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
