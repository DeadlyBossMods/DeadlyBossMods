---@class DBMCoreNamespace
local private = select(2, ...)

local twipe = table.wipe
local UnitExists, UnitPlayerOrPetInRaid, UnitGUID =
	UnitExists, UnitPlayerOrPetInRaid, UnitGUID

---@class TargetScanningModule: DBMModule
local module = private:NewModule("TargetScanningModule")

--Traditional loop scanning method tables
local targetScanCount = {}
local filteredTargetCache = {}
local bossuIdCache = {}
--UNIT_TARGET scanning method table
local unitScanCount = 0
local unitMonitor = {}

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local test = private:GetPrototype("DBMTest")

function module:OnModuleEnd()
	twipe(targetScanCount)
	twipe(filteredTargetCache)
	twipe(bossuIdCache)
	unitScanCount = 0
	twipe(unitMonitor)
end

do
	local CL = DBM_COMMON_L

	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "boss6", "boss7", "boss8", "boss9", "boss10", "focus", "target"
	}

	local fullUids = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "boss6", "boss7", "boss8", "boss9", "boss10",
		"mouseover", "target", "focus", "focustarget", "targettarget", "mouseovertarget",
		"party1target", "party2target", "party3target", "party4target",
		"raid1target", "raid2target", "raid3target", "raid4target", "raid5target", "raid6target", "raid7target", "raid8target", "raid9target", "raid10target",
		"raid11target", "raid12target", "raid13target", "raid14target", "raid15target", "raid16target", "raid17target", "raid18target", "raid19target", "raid20target",
		"raid21target", "raid22target", "raid23target", "raid24target", "raid25target", "raid26target", "raid27target", "raid28target", "raid29target", "raid30target",
		"raid31target", "raid32target", "raid33target", "raid34target", "raid35target", "raid36target", "raid37target", "raid38target", "raid39target", "raid40target",
		"nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
		"nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
		"nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
		"nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40"
	}

	local function getBossTarget(guid, scanOnlyBoss)
		local name, uid, bossuid
		local cacheuid = bossuIdCache[guid] or "boss1"
		--Try to check last used unit token cache before iterating again.
		if UnitGUID(cacheuid) == guid then
			bossuid = cacheuid
			name = DBM:GetUnitFullName(cacheuid.."target")
			uid = cacheuid.."target"
			bossuIdCache[guid] = bossuid
		end
		if name then return name, uid, bossuid end
		--Else, perform iteration again
		local unitID = DBM:GetUnitIdFromGUID(guid, scanOnlyBoss)
		if unitID then
			bossuid = unitID
			name = DBM:GetUnitFullName(unitID.."target")
			uid = unitID.."target"
			bossuIdCache[guid] = bossuid
		end
		return name, uid, bossuid
	end

	---@param cidOrGuid number|string
	---@param scanOnlyBoss boolean?
	---@return string? name, string? uid, string? bossuid
	function bossModPrototype:GetBossTarget(cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		DBM:Debug("GetBossTarget firing for :"..tostring(self).." "..tostring(cidOrGuid).." "..tostring(scanOnlyBoss), 3)
		if type(cidOrGuid) == "number" then--CID passed, slower and slighty more hacky scan
			cidOrGuid = cidOrGuid or self.creatureId
			local cacheuid = bossuIdCache[cidOrGuid] or "boss1"
			if self:GetUnitCreatureId(cacheuid) == cidOrGuid then
				bossuIdCache[cidOrGuid] = cacheuid
				bossuIdCache[UnitGUID(cacheuid)] = cacheuid
				name, uid, bossuid = getBossTarget(UnitGUID(cacheuid), scanOnlyBoss)
			else
				local usedTable = scanOnlyBoss and bossTargetuIds or fullUids
				for _, uId in ipairs(usedTable) do
					if self:GetUnitCreatureId(uId) == cidOrGuid then
						bossuIdCache[cidOrGuid] = uId
						bossuIdCache[UnitGUID(uId)] = uId
						name, uid, bossuid = getBossTarget(UnitGUID(uId), scanOnlyBoss)
						break
					end
				end
			end
		else
			name, uid, bossuid = getBossTarget(cidOrGuid, scanOnlyBoss)
		end
		if uid then
			local cid = self:GetUnitCreatureId(uid)
			if cid == 24207 or cid == 80258 or cid == 87519 then--Filter useless units, like "Army of the Dead", that would otherwise throw off the target scan
				return
			end
		end
		return name, uid, bossuid
	end

	---Manually aborts BossTargetScanner
	---@param cidOrGuid string|number
	---@param returnFunc string
	function bossModPrototype:BossTargetScannerAbort(cidOrGuid, returnFunc)
		targetScanCount[cidOrGuid] = nil--Reset count for later use.
		self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
		DBM:Debug("Boss target scan for "..cidOrGuid.." should be aborting.", 2)
		filteredTargetCache[cidOrGuid] = nil
	end

	---All purpose boss target scanner with many filter and scan options.
	---@param cidOrGuid string|number?
	---@param returnFunc string name of the function mod scanner runs on completion that's within boss mod
	---@param scanInterval number? frequency of scan
	---@param scanTimes number? number of times to scan before running final scan
	---@param scanOnlyBoss boolean? used to scope scan to only scan "boss" unitIDs
	---@param isEnemyScan boolean? used to filter friendly targets from scan results. Useful if scanning for a boss targetting another enemy
	---@param isFinalScan boolean? don't manually use this, it's auto used on final scan. This should be nil in boss mods
	---@param targetFilter string? used to filter specific targets froms can results (useful when boss rapid casts and want to avoid previous mechanics target)
	---@param tankFilter boolean? used to filter players with tank role from scan results.
	---@param onlyPlayers boolean? used to ignore npcs and pets
	---@param filterFallback boolean? if true, tells function to allow person defined in targetFilter to be used in final scan if no other target found
	function bossModPrototype:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter, onlyPlayers, filterFallback)
		--Increase scan count
		cidOrGuid = cidOrGuid or self.creatureId
		if not cidOrGuid then return end
		if not targetScanCount[cidOrGuid] then
			targetScanCount[cidOrGuid] = 0
			DBM:Debug("Boss target scan started for "..cidOrGuid, 2)
		end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		scanInterval = scanInterval or 0.05
		scanTimes = scanTimes or 16
		local targetname, targetuid, bossuid = self:GetBossTarget(cidOrGuid, scanOnlyBoss)
		DBM:Debug("Boss target scan "..targetScanCount[cidOrGuid].." of "..scanTimes..", found target "..(targetname or "nil").." using "..(bossuid or "nil"), 3)--Doesn't hurt to keep this, as level 3
		--Do scan
		--Cache the filtered target if using a filter target fallback
		--so when scan ends we can return that instead of tank when scan ends
		--(because boss might have already swapped back to aggro target by then)
		if targetname and targetname ~= CL.UNKNOWN and filterFallback and targetFilter and targetFilter == targetname then
			filteredTargetCache[cidOrGuid] = {}
			filteredTargetCache[cidOrGuid].target = targetname
			filteredTargetCache[cidOrGuid].targetuid = targetuid
		end
		--Hard return filter target, with no other checks like tank or hostility if final scan and cache exists
		if filteredTargetCache[cidOrGuid] and isFinalScan then
			targetScanCount[cidOrGuid] = nil
			self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
			local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
			self[returnFunc](self, filteredTargetCache[cidOrGuid].targetname, filteredTargetCache[cidOrGuid].targetuid, bossuid, scanningTime)--Return results to warning function with all variables.
			DBM:Debug("BossTargetScanner has ended for "..cidOrGuid, 2)
			filteredTargetCache[cidOrGuid] = nil
		--Perform normal scan criteria matching
		elseif targetname and targetuid and targetname ~= CL.UNKNOWN and (not targetFilter or (targetFilter and targetFilter ~= targetname)) then
			if not IsInGroup() then scanTimes = 1 end--Solo, no reason to keep scanning, give faster warning. But only if first scan is actually a valid target, which is why i have this check HERE
			if (isEnemyScan and UnitIsFriend("player", targetuid) or (onlyPlayers and DBM:IsNonPlayableGUID(UnitGUID(targetuid))) or self:IsTanking(targetuid, bossuid, nil, true)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player. On Only player, ignore npcs and pets
				if targetScanCount[cidOrGuid] < scanTimes then--Make sure no infinite loop.
					self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers, filterFallback)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan, or npc/pet on only person)
				else--Go final scan.
					self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers, filterFallback)
				end
			else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				if (tankFilter and self:IsTanking(targetuid, bossuid, nil, true)) or (isFinalScan and isEnemyScan) or onlyPlayers and DBM:IsNonPlayableGUID(UnitGUID(targetuid)) then return end--If enemyScan and playerDetected, return nothing
				local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
				self[returnFunc](self, targetname, targetuid, bossuid, scanningTime)--Return results to warning function with all variables.
				DBM:Debug("BossTargetScanner has ended for "..cidOrGuid, 2)
				filteredTargetCache[cidOrGuid] = nil
			end
		--target was nil, lets schedule a rescan here too.
		else
			if targetScanCount[cidOrGuid] < scanTimes then--Make sure not to infinite loop here as well.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers, filterFallback)
			elseif not isFinalScan then--Still trigger a final scan check, even if the target was nil/unknown on final scan, to make sure isFinalScan+filterFallback run if it exists and final scan was a failure
				self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers, filterFallback)
			else
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				filteredTargetCache[cidOrGuid] = nil
			end
		end
	end
end

do
	--UNIT_TARGET Target scanning method
	local eventsRegistered = false
	--Validate target is in group (I'm not sure why i actually required this since I didn't comment code when I added requirement, so I leave it for now)
	--If I determine this check isn't needed and it continues to be a problem i'll kill it off.
	--For now, I'll have check be smart and switch between raid and party and just disable when solo
	local function validateGroupTarget(unit)
		if IsInGroup() then
			if UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit) then
				return true
			end
		else--Solo
			return true
		end
	end
	function module:UNIT_TARGET_UNFILTERED(uId)
		--Active BossUnitTargetScanner
		DBM:Debug("UNIT_TARGET_UNFILTERED fired for :"..uId, 3)
		if unitMonitor[uId] and UnitExists(uId.."target") and validateGroupTarget(uId.."target") then
			DBM:Debug("unitMonitor for this unit exists, target exists in group", 2)
			local modId, returnFunc = unitMonitor[uId].modid, unitMonitor[uId].returnFunc
			DBM:Debug("unitMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			if not unitMonitor[uId].allowTank then
				local tanking, status = UnitDetailedThreatSituation(uId, uId.."target")--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
				if tanking or (status == 3) then
					DBM:Debug("unitMonitor ending for unit without 'allowTank', ignoring target", 2)
					return
				end
			end
			local mod = DBM:GetModByName(modId)--The whole reason we store modId in unitMonitor,
			DBM:Debug("unitMonitor success for this unit, a valid target for returnFunc", 2)
			mod[returnFunc](mod, DBM:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
			unitMonitor[uId] = nil
			unitScanCount = unitScanCount - 1
		end
		if unitScanCount == 0 then--Out of scans
			eventsRegistered = false
			self:UnregisterShortTermEvents()
			DBM:Debug("All target scans complete, unregistering events", 2)
		end
	end

	---Used to abort BossUnitTargetScanner on specified unit
	---@param uId string?
	function bossModPrototype:BossUnitTargetScannerAbort(uId)
		if not uId then--Not called with unit, means mod requested to clear all used units
			DBM:Debug("BossUnitTargetScannerAbort called without unit, clearing all unitMonitor units", 2)
			twipe(unitMonitor)
			unitScanCount = 0
			return
		end
		--If tank is allowed, return current target when scan ends no matter what.
		if unitMonitor[uId] and (unitMonitor[uId].allowTank or not IsInGroup()) and validateGroupTarget(uId.."target") then
			DBM:Debug("unitMonitor unit exists, allowTank target exists", 2)
			local modId, returnFunc = unitMonitor[uId].modid, unitMonitor[uId].returnFunc
			DBM:Debug("unitMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			DBM:Debug("unitMonitor found a target that probably is a tank", 2)
			self[returnFunc](self, DBM:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
		end
		unitMonitor[uId] = nil
		unitScanCount = unitScanCount - 1
		DBM:Debug("Boss unit target scan should be aborting for "..uId, 2)
	end

	---UNIT_TARGET event monitor target scanner. Will instantly detect a target change of a registered Unit
	---<br>If target change occurs before this method is called (or if boss doesn't change target because cast ends up actually being on the tank, target scan will fail completely
	---@param uId string
	---@param returnFunc string
	---@param scanTime number?
	---@param allowTank boolean? If allowTank is passed, it basically tells this scanner to return current target of unitId at time of failure/abort when scanTime is complete
	function bossModPrototype:BossUnitTargetScanner(uId, returnFunc, scanTime, allowTank)
		unitMonitor[uId] = {}
		unitScanCount = unitScanCount + 1
		unitMonitor[uId].modid, unitMonitor[uId].returnFunc, unitMonitor[uId].allowTank = self.id, returnFunc, allowTank
		self:ScheduleMethod(scanTime or 1.5, "BossUnitTargetScannerAbort", uId)--In case of BossUnitTargetScanner firing too late, and boss already having changed target before monitor started, it needs to abort after x seconds
		if not eventsRegistered then
			eventsRegistered = true
			module:RegisterShortTermEvents("UNIT_TARGET_UNFILTERED")
			DBM:Debug("Registering UNIT_TARGET event for BossUnitTargetScanner", 2)
		end
	end
end

do
	local repeatedScanEnabled = {}
	---@param mod DBMMod
	---@param cidOrGuid number|string?
	---@param returnFunc string
	---@param scanInterval number?
	---@param scanOnlyBoss boolean?
	---@param includeTank boolean?
	local function repeatedScanner(mod, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		if repeatedScanEnabled[returnFunc] then
			cidOrGuid = cidOrGuid or mod.creatureId
			scanInterval = scanInterval or 0.1
			local targetname, targetuid, bossuid = mod:GetBossTarget(cidOrGuid, scanOnlyBoss)
			if targetname and (includeTank or not mod:IsTanking(targetuid, bossuid, nil, true)) then
				mod[returnFunc](mod, targetname, targetuid, bossuid)
			end
			mod:Schedule(scanInterval, repeatedScanner, mod, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		end
	end

	---A scan method that uses an infinite loop for VERY specific niche situations like Hanz and Franz
	---@param self DBMMod
	---@param cidOrGuid number|string?
	---@param returnFunc string
	---@param scanInterval number?
	---@param scanOnlyBoss boolean?
	---@param includeTank boolean?
	function bossModPrototype:StartRepeatedScan(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		repeatedScanEnabled[returnFunc] = true
		repeatedScanner(self, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
	end

	function bossModPrototype:StopRepeatedScan(returnFunc)
		repeatedScanEnabled[returnFunc] = nil
	end
end


test:RegisterLocalHook("UnitGUID", function(val)
	local old = UnitGUID
	UnitGUID = val
	return old
end)
