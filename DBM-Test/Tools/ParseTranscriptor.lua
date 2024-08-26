local filter = require "Transcriptor-Filter"
local cliArgs = require "ArgParser"
local anonymizer = require "Anonymizer"

local unpack = unpack or table.unpack -- Lua 5.1 compat

local function logInfo(str, ...)
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	io.stderr:write(str, "\n")
end

local function usage()
	logInfo("Usage: lua ParseTranscriptor.lua --transcriptor <path to SavedVariables/Transcriptor.lua> [--entry \"[YYYY-MM-DD]@[HH:MM:SS]\" --start <log offset> --end <log offset> --player <player who logged this> --noheader]")
	os.exit(1)
end

local args = cliArgs:Parse(...)

if not args.transcriptor then
	usage()
end

local playerName = args.player

local function loadTranscriptorLuaString(code)
	local stupidParser = require "StupidParser"
	return stupidParser:ParseLua(code)
end

local function jsonToLua(json)
	-- The secret TWW logs are split with some weird tool that outputs json
	-- So far this code doesn't have any dependencies, I don't feel like pulling in one just to read json, so this hack is the best I can do
	local lines = {}
	for line in json:gmatch("([^\n]*)\n?") do
		line = line:gsub("^(%s*)\"(.-)\": [%[{]%s*$", "%1[\"%2\"] = {")
		line = line:gsub("^(%s*)\"([^\"]+)\":", "%1[\"%2\"] = ")
		line = line:gsub("^(%s*)],?(%s*)$", "%1},%2")
		-- FIXME: properly support \u escapes, but what is this even? UTF-16?
		line = line:gsub("\\u(%x%x%x)", "U%1")
		lines[#lines + 1] = line
	end
	return "TranscriptDB = {jsonLog = " .. table.concat(lines, "\n") .. "}"
end

local function loadTranscriptorDB(fileName)
	local file, err = io.open(fileName, "rb")
	if not file then error(err) end
	local code = file:read("*a")
	if fileName:match(".json$") then
		code = jsonToLua(code)
	end
	return loadTranscriptorLuaString(code)
end

local transcriptorDB = loadTranscriptorDB(args.transcriptor)
local logName = nil
local log = nil

for k, v in pairs(transcriptorDB) do
	if not args.entry or k:sub(1, #args.entry) == args.entry then
		if log then
			print("Multiple logs found in file, use --entry to select one of the following. A unique prefix is sufficient. ")
			for entry in pairs(transcriptorDB) do
				print(entry)
			end
			os.exit(1)
		end
		log = v
		logName = k
	end
end

if not log or not logName then
	print("Could not find specified log")
	os.exit(1)
end

local firstLog = tonumber(args.start)
local lastLog = tonumber(args["end"])

local function parseEncounterEvent(line)
	local id, name, difficulty, groupSize, success = line:match("%[ENCOUNTER_[SE][TN][AD]%w*%] (%d+)#([^#]+)#(%d+)#(%d+)#?(%d*)")
	if not id then return end
	id, difficulty, groupSize = tonumber(id), tonumber(difficulty), tonumber(groupSize)
	success = success == "1"
	return id, name, difficulty, groupSize, success, line:match("%[ENCOUNTER_START%]")
end

local encounterStarts = {}
local encounterEnds = {}
local bossKills = {}
local lastEncounterIsInProgressEnd
for i, v in ipairs(log.total) do
	local id, name, difficulty, groupSize, success, isStart = parseEncounterEvent(v)
	if id then
		local entry = {offset = i, id = id, name = name, difficulty = difficulty, groupSize = groupSize, success = success}
		if isStart then
			encounterStarts[#encounterStarts + 1] = entry
		else
			encounterEnds[#encounterEnds + 1] = entry
		end
	end
	if v:find("%[IsEncounterInProgress%(%)%] false") then
		lastEncounterIsInProgressEnd = i
	end
	if v:find("%[BOSS_KILL%]") then
		bossKills[#bossKills + 1] = {offset = i, name = v:match("%d#([^#]+)#")}
	end
end

logInfo("ENCOUNTER_START events:")
for _, v in ipairs(encounterStarts) do
	logInfo("%d: %s (%d), difficulty = %d, groupSize = %d", v.offset, v.name, v.id, v.difficulty, v.groupSize)
end
logInfo("ENCOUNTER_END events:")
for _, v in ipairs(encounterEnds) do
	logInfo("%d: %s (%d) (%s), difficulty = %d, groupSize = %d", v.offset, v.name, v.id, v.success and "Kill" or "Wipe", v.difficulty, v.groupSize)
end

local function findFrameBoundaries(offset)
	-- There is sometimes relevant stuff that is triggered by ENCOUNTER_START which is not guaranteed to be after this log entry
	-- So we include the whole frame, note that timestamps across a frame are guaranteed to be identical
	local frameTimestamp = log.total[offset]:match("^(<[%d*.]*) ")
	local firstEntry, lastEntry
	for i = 1, #log.total do
		local prevLastEntry = lastEntry
		if log.total[i]:sub(1, #frameTimestamp) == frameTimestamp then
			if not firstEntry then
				firstEntry = i
			end
			lastEntry = i
		end
		if lastEntry and prevLastEntry == lastEntry then
			return firstEntry, lastEntry
		end
	end
end

if not firstLog then
	if #encounterStarts == 1 then
		-- There is sometimes relevant stuff that is triggered by ENCOUNTER_START which may be logged before the actual event
		-- So we just include the whole frame
		firstLog = findFrameBoundaries(encounterStarts[1].offset)
	elseif #encounterStarts == 0 then
		logInfo("Log has no ENCOUNTER_START, starting at offset 1, use --start to override")
		firstLog = 1
	else
		logInfo("Log contains more than one ENCOUNTER_START")
		local encounterStartHelp = {}
		for i, v in ipairs(encounterStarts) do
			encounterStartHelp[i] = v.offset .. " (" .. v.name .. ")"
		end
		print("ENCOUNTER_START at: " .. table.concat(encounterStartHelp, ", "))
		print("Use --start to select offset explicitly")
		os.exit(1)
	end
end

if not lastLog then
	if #encounterEnds == 1 then
		lastLog = encounterEnds[1].offset
		-- BOSS_KILL often triggers after ENCOUNTER_END, we want to include both to test that we don't trigger end multiple times
		local lastBossKill = #bossKills > 0 and bossKills[#bossKills].offset
		if lastBossKill and lastBossKill < lastLog + 100 then
			lastLog = math.max(lastLog, lastBossKill)
		end
		-- Same as above, include the whole frame
		lastLog = select(2, findFrameBoundaries(lastLog))
	elseif #encounterEnds == 0 then
		if lastEncounterIsInProgressEnd then
			logInfo("Log has no ENCOUNTER_END, using last IsEncounterInProgress() = false which is at %d (%d entries after this)", lastEncounterIsInProgressEnd, #log.total - lastEncounterIsInProgressEnd)
			lastLog = select(2, findFrameBoundaries(lastEncounterIsInProgressEnd))
		else
			logInfo("Log has no ENCOUNTER_END and no IsEncounterInProgress() = false, using entire log file, use --end to override")
			lastLog = #log.total
		end
	else
		logInfo("Log contains more than one ENCOUNTER_END")
		local encounterEndHelp = {}
		for i, v in ipairs(encounterEnds) do
			encounterEndHelp[i] = v.offset .. " (" .. v.name .. ")"
		end
		logInfo("ENCOUNTER_END at: " .. table.concat(encounterEndHelp, ", "))
		logInfo("Use --end to select offset explicitly")
		os.exit(1)
	end
end
if lastLog > #log.total then
	logInfo("Specified last log entry %d, but log only has %d lines", lastLog, #log.total)
	os.exit(1)
end

local function guessType(str)
	if str == "nil" then
		return nil
	end
	if str == "true" then
		return true
	end
	if str == "false" then
		return false
	end
	if tostring(tonumber(str)) == str then
		return tonumber(str)
	end
	return str
end

local function guessTypes(...)
	if select("#", ...) == 1 then
		return guessType(...)
	else
		return guessType(...), guessTypes(select(2, ...))
	end
end

local hexMetatable = {
	__tostring = function(self)
		return "0x" .. ("%x"):format(self.value)
	end
}
local function hex(num)
	return setmetatable({value = num}, hexMetatable)
end

local function literal(lit)
	if type(lit) == "string" then
		return ("%q"):format(lit)
	else
		return tostring(lit)
	end
end

local function literals(...)
	if select("#", ...) == 1 then
		return literal(...)
	else
		return literal(...), literals(select(2, ...))
	end
end

local function literalsTable(...)
	local tbl = {...}
	for i = 1, select("#", ...) do
		tbl[i] = literal(select(i, ...))
	end
	return tbl
end

---@param info DBMInstanceInfo
local function getInstanceInfo(info)
	return ("{name = %s, instanceType = %s, difficultyID = %s, difficultyName = %s, difficultyModifier = %s, maxPlayers = %s, dynamicDifficulty = %s, isDynamic = %s, instanceID = %s, instanceGroupSize = %s, lfgDungeonID = %s}"):format(
		literals(info.name, info.instanceType, info.difficultyID, info.difficultyName, info.difficultyModifier, info.maxPlayers, info.dynamicDifficulty, info.isDynamic, info.instanceID, info.instanceGroupSize, info.lfgDungeonID)
	)
end

local function stripHealthInfo(name)
	return name:gsub("%([^)]+%%%)$", "")
end

local function transcribeUnitSpellEvent(event, params, anon)
	if params:match("^PLAYER_SPELL") then
		return -- Note: don't forget to scrub player name if you want to support this event
	end
	-- Transcriptor has some useful extra data that we can use to reconstruct unit targets, health and power
	local unitName, unitHp, unitPower, unitTarget, unit, guid, spellId = params:match("(.*)%(([%d.]*)%%%-([%d.]*)%%%){Target:([^}]*)} .* %[%[([^:]+):([^:]+):([^%]]+)%]%]")
	guid = anon:ScrubGUID(guid)
	unitTarget = anon:ScrubTarget(unitTarget)
	unitHp = tonumber(unitHp) or 0
	unitPower = tonumber(unitPower) or 0
	return literalsTable(event, unit, guid, tonumber(spellId), unitName, unitHp, unitPower, unitTarget)
end

-- Rough attempt at flag reconstruction, not 100% correct, we could be a bit more smart here about REACTION by tracking a GUID across multiple events
-- Or using sourceFlags from a previous event to build destFlags if source flags are logged
local function reconstructFlags(isPlayer, isPet, isNpc)
	local flags = 0
	if isPlayer then
		-- AFFILIATION_MINE/PARTY gets set by the test runner later to implement perspective shifting
		flags = flags + 0x0010  -- REACTION_FRIENDLY
		flags = flags + 0x0100  -- CONTROL_PLAYER
		flags = flags + 0x0400  -- TYPE_PLAYER
	elseif isPet then
		flags = flags + 0x0002  -- AFFILIATION_PARTY
		flags = flags + 0x0010  -- REACTION_FRIENDLY -- all pets are friendly for now
		flags = flags + 0x0100  -- CONTROL_PLAYER
		flags = flags + 0x1000  -- TYPE_PET
	elseif isNpc then
		flags = flags + 0x0008  -- AFFILIATION_OUTSIDER
		flags = flags + 0x0040  -- REACTION_HOSTILE -- all NPCs are hostile for now
		flags = flags + 0x0200  -- CONTROL_NPC
		flags = flags + 0x0800  -- TYPE_NPC
	end
	return flags
end

local flagWarningShown
local seenFriendlyCids = {}

local function transcribeCleu(rawParams, anon)
	local params = {}
	local i = 1 -- to handle nil
	for param in rawParams:gmatch("([^#]*)") do
		params[i] = guessType(param)
		i = i + 1
	end
	local event, sourceFlags, sourceGUID, sourceName, destGUID, destName, spellId, spellName, extraArg1, extraArg2
	if params[1]:match("%[CONDENSED%]") then
		local _
		event, sourceGUID, sourceName, _, spellId, spellName = unpack(params, 1, i - 1)
		destGUID = ""
	else
		if type(params[2]) == "number" then
			event, sourceFlags, sourceGUID, sourceName, destGUID, destName, spellId, spellName, extraArg1, extraArg2 = unpack(params, 1, i - 1)
			-- clear special flags to make flags look more uniform across events
			-- deliberately doing this in a bit ugly way to not pull in a dependency on bit.* for Lua 5.1
			-- TODO: target/focus could be used to reconstruct targets, but in practice logs won't contain this info
			if sourceFlags >= 0x80000000 then -- NONE
				sourceFlags = sourceFlags - 0x80000000
			end
			if sourceFlags >= 0x80000 then -- MAINASSIST
				sourceFlags = sourceFlags - 0x80000
			end
			if sourceFlags >= 0x40000 then -- MAINTANK
				sourceFlags = sourceFlags - 0x80000
			end
			if sourceFlags >= 0x20000 then -- FOCUS
				sourceFlags = sourceFlags - 0x20000
			end
			if sourceFlags >= 0x10000 then -- TARGET
				sourceFlags = sourceFlags - 0x10000
			end
		else
			if not flagWarningShown and params[1] == "SPELL_CAST_START" then -- not all entries are logged with flags
				logInfo("Note: log doesn't contain flags, /getspells logflags to log flags in Transcriptor. Results for mods relying heavily on flags may be inaccurate, but usually this is not a problem.")
				flagWarningShown = true
			end
			event, sourceGUID, sourceName, destGUID, destName, spellId, spellName, extraArg1, extraArg2 = unpack(params, 1, i - 1)
		end
	end
	if spellId and filter.ignoredSpellIds[spellId] then
		return
	end
	-- Scrub health/power info, TODO: this could potentially be used to fake UNIT_HEALTH events
	sourceName = sourceName and sourceName:gsub("([^%(]*)(%([%d.%%-]*)%)", "%1")
	destName = destName and destName:gsub("([^%(]*)(%([%d.%%-]*)%)", "%1")
	local sourceCid = sourceGUID and tonumber(sourceGUID:match("Creature%-0%-%d*%-%d*%-%d*%-(%d+)") or tonumber(sourceGUID:match("GameObject%-0%-%d*%-%d*%-%d*%-(%d+)")))
	local destCid = destGUID and tonumber(destGUID:match("Creature%-0%-%d*%-%d*%-%d*%-(%d+)") or destGUID:match("GameObject%-0%-%d*%-%d*%-%d*%-(%d+)"))
	if sourceCid and filter.ignoredCreatureIds[sourceCid] or destCid and filter.ignoredCreatureIds[destCid] then
		return
	end
	local destIsPlayer = destGUID and destGUID:match("^Player%-")
	local srcIsPlayer = sourceGUID and sourceGUID:match("^Player%-")
	local destIsPet = destGUID and destGUID:match("^Pet%-")
	local srcIsPet = sourceGUID and sourceGUID:match("^Pet%-")
	local destIsPlayerOrPet = destIsPlayer or destIsPet
	local srcIsPlayerOrPet = srcIsPlayer or srcIsPet
	local destIsNpc = destGUID and (destGUID:match("^Creature-") or destGUID:match("^Vehicle-"))
	local srcIsNpc = sourceGUID and (sourceGUID:match("^Creature-") or sourceGUID:match("^Vehicle-"))
	if event == "SPELL_DAMAGE[CONDENSED]" then event = "SPELL_DAMAGE" end
	if event == "SPELL_PERIODIC_DAMAGE[CONDENSED]" then event = "SPELL_PERIODIC_DAMAGE" end
	if event == "SPELL_SUMMON" and srcIsPlayerOrPet then
		return
	end
	-- FIXME: use sourceFlags if available to filter healing and attacks of friendly totems
	if (event:match("_ENERGIZE$") or event:match("_HEAL$")) and destIsPlayerOrPet then
		return
	end
	if event:match("_HEAL$") and srcIsPlayer and destIsNpc then -- Likely healing summons, opportunity to learn summon creature IDs not yet ignored
		if destCid then
			seenFriendlyCids[destCid] = destName
		end
		return
	end

	if (event:match("^SPELL_CAST") or event == "SPELL_EXTRA_ATTACKS") and srcIsPlayerOrPet then
		return
	end
	if (event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_PERIODIC_MISSED" or event == "SPELL_MISSED" or event == "DAMAGE_SHIELD" or event == "SWING_DAMAGE" or event == "DAMAGE_SHIELD_MISSED") and srcIsPlayerOrPet then
		return
	end
	if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_REMOVED_DOSE" or event == "SPELL_AURA_REFRESH" then
		-- Filter buffs by non-NPCs on players (some bosses case buffs on players, e.g., purgable mind controls)
		if extraArg1 == "BUFF" and destIsPlayerOrPet and not srcIsNpc then
			return
		end
		-- Filter debuffs on NPCs cast by non-NPCs
		if extraArg1 == "DEBUFF" and destIsNpc and not srcIsNpc then
			return
		end
	end
	if srcIsNpc then
		sourceName = stripHealthInfo(sourceName)
	end
	if destIsNpc then
		destName = stripHealthInfo(destName)
	end
	if srcIsNpc then
		sourceName = stripHealthInfo(sourceName)
	end
	if destIsNpc then
		destName = stripHealthInfo(destName)
	end
	if sourceFlags then -- scrub AFFILIATION_MINE/PARTY/RAID (bits 0-2) if we already have flags, this is important for perspective shifting
		sourceFlags = math.floor(sourceFlags / 8) * 8
	end
	sourceFlags = sourceFlags or reconstructFlags(srcIsPlayer, srcIsPet, srcIsNpc)
	local destFlags = reconstructFlags(destIsPlayer, destIsPet, destIsNpc)
	if sourceGUID and sourceGUID ~= "" then
		sourceName = anon:ScrubName(sourceName, sourceGUID)
		sourceGUID = anon:ScrubGUID(sourceGUID)
	end
	if destGUID and destGUID ~= "" then
		destName = anon:ScrubName(destName, destGUID)
		destGUID = anon:ScrubGUID(destGUID)
	end
	if event:match("_HEAL_ABSORBED") and extraArg1 and extraArg1 ~= "" then
		extraArg2 = anon:ScrubName(extraArg2, extraArg1)
		extraArg1 = anon:ScrubGUID(extraArg1)
	end
	return literalsTable(
		"COMBAT_LOG_EVENT_UNFILTERED", event,				-- skipping timestamp and hideCaster
		sourceGUID, sourceName, hex(sourceFlags), hex(0),	-- 0x0 == sourceRaidFlags, not logged
		destGUID, destName, hex(destFlags), hex(0),			-- 0x0 == destRaidFlags, not logged
		spellId, spellName, hex(0),							-- 0x0 == spellSchool, not logged
		extraArg1, extraArg2
	)
end

local function transcribeEvent(event, params, anon)
	if event:match("^DBM_") or event:match("^NAME_PLATE_UNIT_") or event:match("BigWigs_") or event == "Echo_Log" or event == "ARENA_OPPONENT_UPDATE" then
		return
	end
	if event:match("^UNIT_SPELL") then
		return transcribeUnitSpellEvent(event, params, anon)
	end
	if event == "PLAYER_TARGET_CHANGED" then
		-- TODO: do we ever care about player targets? typically used in filters and we don't want to filter
		return
	end
	if event == "CLEU" then
		return transcribeCleu(params, anon)
	end
	-- FIXME: it kinda sucks that we only parse after this, but since type guessing may depend on the event it's ugly both ways :/
	if event == "UNIT_TARGET" then
		params = params:gsub("([^#]*#)([^#]*)(#Target: )([^#]*)(#TargetOfTarget: )([^#]*)", function(arg1, arg2, arg3, arg4, arg5, arg6)
			return arg1 .. anon:ScrubTarget(arg2) .. arg3 .. anon:ScrubTarget(arg4) .. arg5 .. anon:ScrubTarget(arg6)
		end)
	end
	if event:match("^CHAT_MSG_MONSTER") or event:match("^CHAT_MSG_RAID_BOSS") then
		params = params:gsub("^" .. ("([^#]*)#"):rep(12), function(msg, name, arg3, arg4, targetName, arg6, arg7, arg8, arg9, arg10, arg11, senderGuid)
			-- Messages can *come from* pets
			return ("%s#"):rep(12):format(anon:ScrubChatMessage(msg, targetName), anon:ScrubPetName(name) or name, arg3, arg4, anon:ScrubName(targetName) or targetName, arg6, arg7, arg8, arg9, arg10, arg11, senderGuid == "nil" and senderGuid or anon:ScrubGUID(senderGuid))
		end)
	end
	if event == "RAID_BOSS_EMOTE" then
		params = params:gsub("^([^#]*)#", function(msg)
			return ("%s#"):format(anon:ScrubChatMessage(msg))
		end)
	end
	if event == "NAME_PLATE_UNIT_ADDED" then -- Especially relevant for mind controlled players (but currently filtered above anyways)
		local name, guid, extra = params:match("([^#]*)#([^#]*)(.*)")
		params = (anon:ScrubName(name, guid) or name) .. "#" .. anon:ScrubGUID(guid) .. extra
	end
	if event == "UNIT_TARGETABLE_CHANGED" then
		params = params:gsub("(Name:)([^#]*)(#GUID:)([^#]*)", function(prefix, name, separator, guid)
			return prefix .. anon:ScrubName(name, guid) .. separator .. anon:ScrubGUID(guid)
		end)
	end
	if event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" then
		-- capture limits prevents us from doing this a single glorious regex
		local prefix, suffix
		prefix, params = params:match("([^#]*#)(.*)")
		params, suffix = params:match("(" .. ("[^#]*#"):rep(8 * 5) .. ")(.*)")
		local newParams = ""
		for boss in params:gmatch("(" .. ("[^#]*#"):rep(8) .. ")") do
			newParams = newParams .. boss:gsub("^" .. ("([^#]*)#"):rep(8), function(arg1, arg2, arg3, arg4, arg5, guid, arg7, arg8)
				return ("%s#"):rep(8):format(arg1, arg2, arg3, arg4, arg5, guid == "nil" and guid or anon:ScrubGUID(guid), arg7, arg8)
			end)
		end
		params = prefix .. newParams .. suffix
	end
	if event == "GOSSIP_SHOW" then
		local guid, suffix = params:match("([^#]*)#(.*)")
		params = anon:ScrubGUID(guid) .. "#" .. suffix
	end
	if event == "CHAT_MSG_ADDON" then
		local subEvent, msg, name = params:match("([^#]*)#([^#]*)#([^#]*)")
		if subEvent == "RAID_BOSS_WHISPER_SYNC" then
			-- Name will always contain the server here, even if there is no cross-server stuff otherwise; this is annoying because the anonymizer might not have learned the name with the server suffix
			return literalsTable("CHAT_MSG_RAID_BOSS_WHISPER", msg, anon:ScrubName(name) or anon:ScrubName(name:match("([^-]*)")), 0, false)
		else
			logInfo("Unhandled CHAT_MSG_ADDON log message " .. params)
		end
	end
	-- TODO: UNIT_AURA?
	-- Generic event
	local result = {literal(event)}
	for param in params:gmatch("([^#]*)") do
		result[#result + 1] = literal(guessType(param))
	end
	return result
end

-- TODO: this relies a lot on DBM debug logs -- we could try to make some educated guesses if we don't have these
local function getMetadataFromLog()
	local player
	local instanceInfo = {} ---@type DBMInstanceInfo
	local encounterInfo = {}
	for i, line in ipairs(log.total) do
		-- Only grab instance and encounter info from within relevant log area
		if i >= firstLog and i <= lastLog then
			if line:match("GetInstanceInfo%(%) =") then
				---@diagnostic disable-next-line: assign-type-mismatch
				instanceInfo.name, instanceInfo.instanceType, instanceInfo.difficultyID, instanceInfo.difficultyName, instanceInfo.maxPlayers, instanceInfo.dynamicDifficulty, instanceInfo.isDynamic, instanceInfo.instanceID, instanceInfo.instanceGroupSize, instanceInfo.lfgDungeonID
				= guessTypes(line:match(
					"%[DBM_Debug%] GetInstanceInfo%(%) = ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^#]+)"
				))
			elseif line:match("DBM:GetCurrentInstanceDifficulty%(%) = normal20, 20 Player%(%d%)") then -- SoD/Molten Core heat levels
				local modifier = line:match("%((%d)%)")
				instanceInfo.difficultyModifier = tonumber(modifier) or 0
			elseif line:match("%[ENCOUNTER_[SE][TN][AD]") then
				local id, name, difficulty, _, success, isStart = parseEncounterEvent(line)
				if not encounterInfo.id or id == encounterInfo.id then -- multiple different encounters in one log? you'll have to do something by hand
					encounterInfo.id = id
					encounterInfo.name = name
					encounterInfo.difficulty = difficulty
					if not isStart then
						encounterInfo.kill = success
					end
				end
			end
		end
		-- But we can grab the player id from anywhere
		if not player then
			player = line:match("%[UNIT_SPELLCAST_SUCCEEDED%] PLAYER_SPELL{([^}]+)} %-.*%- %[%[player:Cast%-")
		end
	end
	return player, instanceInfo, encounterInfo, logName:match("Version: 1%.") and "SeasonOfDiscovery" or "Retail" -- FIXME: distinguish SoD and Era somehow (but the field is unused right now anyways)
end

local deducedPlayer, instanceInfo, encounterInfo, gameVersion = getMetadataFromLog()
playerName = playerName or deducedPlayer

local function getLog()
	local resultLog, resultPlayers = {}, {}
	local timeOffset
	local totalTime = 0
	local anon = anonymizer:New(log.total, firstLog, lastLog, playerName, args["keep-names"])
	for i = firstLog, lastLog do
		local line = log.total[i]
		local time, event, params = line:match("^<([%d.]+) [^>]+> %[([^%]]*)%] (.*)")
		time = tonumber(time) or error("unparseable timestamp in " .. line)
		totalTime = time
		if not tonumber(time) or not event or not params then
			error("unparseable line" .. line)
		end
		timeOffset = timeOffset or time
		time = time - timeOffset
		local testEvent = transcribeEvent(event, params, anon)
		if testEvent then
			resultLog[#resultLog + 1] = ("{%.2f, %s}"):format(time, table.concat(testEvent, ", "))
		end
	end
	local sortedRoles = {}
	local maxNameLen = 0
	for _, v in pairs(anon.roles) do
		sortedRoles[#sortedRoles + 1] = v
		-- FIXME: doesn't handle UTF-8 for the non-anon case
		maxNameLen = math.max(maxNameLen, #v.anonName)
	end
	table.sort(sortedRoles, function(e1, e2)
		if e1.role == e2.role then
			local perRoleId1 = tonumber(e1.anonName:match("(%d+)"))
			local perRoleId2 = tonumber(e2.anonName:match("(%d+)"))
			if perRoleId1 and perRoleId2 then
				return perRoleId1 < perRoleId2
			else -- for the non-anonymized case
				return e1.anonName < e2.anonName
			end
		else
			return e1.role > e2.role -- alphabetical role sort happens to be Unknown > Tank > Healer > Dps which is what we want :)
		end
	end)
	for _, roleInfo in ipairs(sortedRoles) do
		resultPlayers[#resultPlayers + 1] = roleInfo:PrettyTableString(maxNameLen, args["verbose-roles"])
	end
	logInfo("Parsed %d lines into %d lines (%.1f%% filtered)", lastLog - firstLog + 1, #resultLog, (1 - #resultLog / (lastLog - firstLog + 1)) * 100)
	logInfo("%.1f seconds total, %.0f entries/second", totalTime, #resultLog / totalTime)
	local resultStr = ""
	resultStr = resultStr .. "players = {\n\t\t"
	resultStr = resultStr ..  table.concat(resultPlayers, ",\n\t\t")
	resultStr = resultStr .. "\n\t},\n"
	resultStr = resultStr .. "\tperspective = \"" .. anon:ScrubName(playerName) .. "\",\n"
	resultStr = resultStr .. "\tlog = {\n\t\t"
	resultStr = resultStr ..  table.concat(resultLog, ",\n\t\t")
	resultStr = resultStr ..  "\n\t}"
	anon:CheckForLeaks(resultStr, args["ignore-leaks"])
	return resultStr
end

local template = [[
DBM.Test:DefineTest{
	name = %s,
	gameVersion = %s,
	addon = %s,
	mod = %s,
	instanceInfo = %s,
	%s,
}]]

local function guessMod()
	if not encounterInfo.name then return "" end
	return encounterInfo.name:gsub("%s*", ""):gsub("'", "")
end

-- TODO: all of these guessing functions could be much smarter, but I'm adding stuff as I go
local function guessTestName()
	if not encounterInfo.name then return "" end
	local difficulty = ""
	if instanceInfo.instanceID == 409 and instanceInfo.difficultyModifier then -- MC heat levels
		difficulty = "Heat-" .. instanceInfo.difficultyModifier .. "/"
	end
	local name = guessMod() .. "/" .. difficulty .. (encounterInfo.kill and "Kill" or "Wipe")
	if args.prefix then
		return args.prefix:gsub("/$", "") .. "/" .. name
	else
		logInfo("Use --prefix to provide a prefix for test name")
		return name
	end
end

local function guessAddon()
	if gameVersion == "SeasonOfDiscovery" then
		if instanceInfo.instanceType == "raid" then
			-- Onyxia and the outdoor bosses are for 40 players, but luckily Onyxia uses a different difficulty ID
			return instanceInfo.maxPlayers == 40 and instanceInfo.difficultyID == 9 and "DBM-Azeroth"
				or "DBM-Raids-Vanilla"
		elseif instanceInfo.instanceType == "party" then -- UBRS & co also return party here
			return "DBM-Party-Vanilla"
		end
	end
	return ""
end

local function generateTest()
	local str = template:format(
		literal(guessTestName()), literal(gameVersion), literal(guessAddon()), literal(guessMod()),
		getInstanceInfo(instanceInfo),
		getLog()
	)
	return str
end

local function generateLogOnly()
	return ("\t%s\n}\n"):format(getLog())
end

if args.noheader or args["no-header"] then
	print(generateLogOnly())
else
	print(generateTest())
end

if next(seenFriendlyCids) then
	logInfo("Potentially ignoreable creature IDs (healed by players):")
	for cid, name in pairs(seenFriendlyCids) do
		logInfo(cid .. ", -- " .. name)
	end
end
