---@class DBMTestTranscriptorParser
local transcriptorParser = DBM.Test.CreateSharedModule("ParseTranscriptor")

local anonymizer			= require "Anonymizer"
local parser				= require "Parser"
local filter    			= require "Data.Transcriptor-Filter"
local instanceInfoGuesser	= require "InstanceInfoGuesser"

---@class DBMTest
local test = DBM.Test
test.TranscriptorParser = transcriptorParser

local select = select -- Usually I'm not a fan of these local caches, but this one is literally called millions of times
local time = time or os.time
local unpack = unpack or table.unpack

local function yield()
	local cr, main = coroutine.running()
	if cr and not main then
		coroutine.yield()
	end
end

local mt = {__index = transcriptorParser}
function transcriptorParser:New(data)
	---@class DBMTestTranscriptorParser
	local obj = {
		data = data and parser:ParseLua(data) or TranscriptDB
	}
	if type(obj.data) ~= "table" then
		error("could not find Transcriptor entry, check that the imported log is a valid Transcriptor log including the `TranscriptDB =` statement at the beginning")
	end
	if obj.data.TranscriptDB then
		obj.data = obj.data.TranscriptDB
	end
	return setmetatable(obj, mt)
end

local function findFrameBoundaries(lines, offset)
	-- There is sometimes relevant stuff that is triggered by ENCOUNTER_START which is not guaranteed to be after this log entry
	-- So we include the whole frame, note that timestamps across a frame are guaranteed to be identical
	local frameTimestamp = lines[offset]:match("^(<[%d*.]*) ")
	local firstEntry, lastEntry
	-- TODO: this is O(n^2) and adds ~0.5 seconds on a full MC log that is in a single Transcriptor entry
	for i = 1, #lines do
		local prevLastEntry = lastEntry
		if lines[i]:sub(1, #frameTimestamp) == frameTimestamp then
			if not firstEntry then
				firstEntry = i
			end
			lastEntry = i
		end
		if lastEntry and prevLastEntry == lastEntry then
			return firstEntry, lastEntry
		end
	end
	return offset, offset
end

local function parseEncounterEvent(line)
	local id, name, difficulty, groupSize, success = line:match("%[ENCOUNTER_[SE][TN][AD]%w*%] (%d+)#([^#]+)#(%d+)#(%d+)#?(%d*)")
	if not id then
		return
	end
	id, difficulty, groupSize = tonumber(id), tonumber(difficulty), tonumber(groupSize)
	success = success == "1"
	return id, name, difficulty, groupSize, success, line:match("%[ENCOUNTER_START%]")
end

local function timeFromLine(line)
	return tonumber(line:match("<([%d.]*)")) or 0
end

---@return DBMTranscriptorParserEncounterInfo[]
local function getEncounters(lines)
	local encounters = {} ---@type DBMTranscriptorParserEncounterInfo[]
	local lastEncounterStarts = {}
	local lastEncounterEndEvent = 0
	local lastEncounterIsInProgressEnd
	for i, v in ipairs(lines) do
		local id, name, difficulty, groupSize, success, isStart = parseEncounterEvent(v)
		if id then
			---@class DBMTranscriptorParserEncounterInfo
			local entry = {
				startOffset = i, id = id, name = name, difficulty = difficulty, groupSize = groupSize, success = success,
				endOffset = nil, ---@type number
				startTime = nil, ---@type number
				endTime = nil ---@type number
			}
			if isStart then
				encounters[#encounters + 1] = entry
				lastEncounterStarts[id] = entry
			else
				local startEntry = lastEncounterStarts[id]
				if not startEntry then
					-- Just use whole log or last ENCOUNTER_END event if we don't have a start event, the common case is that the start is just missing, so whole log is what we want
					entry.startOffset = lastEncounterEndEvent + 1
					encounters[#encounters + 1] = entry
				end
				startEntry.endOffset = i
				startEntry.success = success
				lastEncounterEndEvent = i
			end
		end
		if v:find("%[IsEncounterInProgress%(%)%] false") then
			lastEncounterIsInProgressEnd = i
		end
	end
	for _, v in ipairs(encounters) do
		yield()
		if not v.endOffset then
			v.endOffset = lastEncounterIsInProgressEnd or #lines
		end
		v.startOffset = findFrameBoundaries(lines, v.startOffset)
		v.endOffset = select(2, findFrameBoundaries(lines, v.endOffset))
		v.startTime = timeFromLine(lines[v.startOffset])
		v.endTime = timeFromLine(lines[v.endOffset])
	end
	for i = #encounters, 1, -1 do
		local v = encounters[i]
		-- Filter out obviously buggy or empty encounters, e.g., SoD Vaelastrasz triggering ENCOUNTER_START for every single raid member
		if v.endTime - v.startTime < 1 then
			table.remove(encounters, i)
		end
	end
	return encounters
end

---@return DBMTranscriptorParserLogInfo
local function getLogInfo(name, log)
	local year, month, day, hour, min, sec = name:match("%[(%d*)%-(%d*)%-(%d*)%]@%[(%d*):(%d*):(%d*)%]")
	local timestamp = year and time({
		year = year, month = month, day = day, hour = hour, min = min, sec = sec
	}) or 0 -- json logs have the name only in the file name which (at least in WoW) isn't available
	---@class DBMTranscriptorParserLogInfo
	local obj = {
		name = name,
		timestamp = timestamp,
		encounters = getEncounters(log.total),
		lines = log.total,
		startTime = timeFromLine(log.total[1]),
		endTime = timeFromLine(log.total[#log.total]),
	}
	return obj
end

---@return DBMTranscriptorParserLogInfo[]
function transcriptorParser:GetLogs()
	local logs = {}
	for k, v in pairs(self.data) do
		if #v.total > 0 then
			logs[#logs + 1] = getLogInfo(k, v)
		end
	end
	table.sort(logs, function(e1, e2) return e1.timestamp < e2.timestamp end)
	return logs
end

---@class DBMTranscriptorParserTestGenerator
local testGenerator = {}
local testGeneratorMt = {__index = testGenerator}

---@return DBMTranscriptorParserTestGenerator
function transcriptorParser:NewTestGenerator(log, firstLine, lastLine, prefix, noAnonymize, noAnonValidation, verboseRoles)
	---@class DBMTranscriptorParserTestGenerator
	local obj = setmetatable({
		log = log, ---@type DBMTranscriptorParserLogInfo
		firstLine = firstLine,
		lastLine = lastLine,
		prefix = prefix,
		stats = {
			parsedLines = 0, outputLines = 0, logTime = 0
		},
		testDefinition = nil, ---@type TestDefinition?
		anonymize = not noAnonymize,
		validateAnonymizer = not noAnonValidation,
		verboseRoles = verboseRoles,
		cache = {}
	}, testGeneratorMt)
	obj:parseMetadata()
	return obj
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

local formatMetatables = {}
local function format(fmt, data)
	local metatable = formatMetatables[fmt]
	if not metatable then
		formatMetatables[fmt] = {
			__tostring = function(self)
				return fmt:format(self.value)
			end
		}
		return format(fmt, data)
	end
	return setmetatable({value = data}, metatable)
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
local function instanceInfoLiteral(info)
	return ("{name = %s, instanceType = %s, difficultyID = %s, difficultyName = %s, difficultyModifier = %s, maxPlayers = %s, dynamicDifficulty = %s, isDynamic = %s, instanceID = %s, instanceGroupSize = %s, lfgDungeonID = %s}"):format(
		literals(info.name, info.instanceType, info.difficultyID, info.difficultyName, info.difficultyModifier, info.maxPlayers, info.dynamicDifficulty, info.isDynamic, info.instanceID, info.instanceGroupSize, info.lfgDungeonID)
	)
end

local function stripHealthInfo(name)
	return name:gsub("%([^)]+%%%)$", "")
end

local function transcribeUnitSpellEvent(event, params, anon)
	if params:match("^PLAYER_SPELL") then
		return
	end
	-- Transcriptor has some useful extra data that we can use to reconstruct unit targets, health and power
	local unitName, unitHp, unitPower, unitTarget, unit, guid, spellId = params:match("(.*)%(([%d.-]*)%%%-([%d.-]*)%%%){Target:([^}]*)} .* %[%[([^:]+):([^:]+):([^%]]+)%]%]")
	-- This should not be necessary because PLAYER_SPELLS are filtered above, yet I've got a log where this shows up with the player somehow on an arena unit ID in a raid (???)
	unitName = anon:ScrubName(unitName)
	guid = anon:ScrubGUID(guid)
	unitTarget = anon:ScrubTarget(unitTarget)
	unitHp = tonumber(unitHp) or 0
	unitPower = tonumber(unitPower) or 0
	-- Fun Lua 5.1/5.4 diff: tostring(tonumber("100.0")) yields 100 on Lua 5.1 and 100.0 on Lua 5.4 because of int vs. number type
	return literalsTable(event, unit, guid, tonumber(spellId), unitName, format("%.1f", unitHp), format("%.1f", unitPower), unitTarget)
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

-- FIXME: these two vars should be moved inside an object
local flagWarningShown
local seenFriendlyCids = {}

local function transcribeCleu(rawParams, anon)
	local params = {}
	local i = 1 -- to handle nil
	local offset = 1
	while true do -- This looks like gmatch could do the job, but it's subtly different between Lua 5.1 and 5.4 when it comes to handling empty matches at the end of the string
		local matchStart, matchEnd, param = rawParams:find("([^#]*)#?", offset)
		if not matchStart or matchEnd < matchStart then
			break
		end
		offset = matchEnd + 1
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
				-- TODO: this warning is not particularly useful because I have exactly 0 examples where this matters and the option keeps disabling itself anyways
				--logInfo("Note: log doesn't contain flags, /getspells logflags to log flags in Transcriptor. Results for mods relying heavily on flags may be inaccurate, but usually this is not a problem.")
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
	if event:match("^DBM_") or event:match("^NAME_PLATE_UNIT_") or event:match("BigWigs_") or event == "Echo_Log" or event == "ARENA_OPPONENT_UPDATE" or event == "PLAYER_INFO" then
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
			-- FIXME: do we care about this warning?
			--logInfo("Unhandled CHAT_MSG_ADDON log message " .. params)
		end
	end
	-- TODO: UNIT_AURA?
	-- Generic event
	local result = {literal(event)}
	local offset = 1
	while true do -- This looks like gmatch could do the job, but it's subtly different between Lua 5.1 and 5.4 when it comes to handling empty matches at the end of the string
		local matchStart, matchEnd, param = params:find("([^#]*)#?", offset)
		if not matchStart or matchEnd < matchStart then
			break
		end
		offset = matchEnd + 1
		result[#result + 1] = literal(guessType(param))
	end
	return result
end

-- TODO: this relies a lot on DBM debug logs -- we could try to make some more educated guesses if we don't have these
function testGenerator:parseMetadata()
	local player
	local instanceInfo = {} ---@type DBMInstanceInfo
	local encounterInfo = {}
	local zoneId
	for i, line in ipairs(self.log.lines) do
		-- Only grab instance and encounter info from within relevant log area
		if i >= self.firstLine and i <= self.lastLine then
			if not zoneId and (line:match("Creature%-%d%-%d*%-(%d*)") or line:match("Vehicle%-%d%-%d*%-(%d*)")) then
				zoneId = tonumber(line:match("Creature%-%d%-%d*%-(%d*)") or line:match("Vehicle%-%d%-%d*%-(%d*)"))
			elseif line:match("GetInstanceInfo%(%) =") then
				---@diagnostic disable-next-line: assign-type-mismatch
				instanceInfo.name, instanceInfo.instanceType, instanceInfo.difficultyID, instanceInfo.difficultyName, instanceInfo.maxPlayers, instanceInfo.dynamicDifficulty, instanceInfo.isDynamic, instanceInfo.instanceID, instanceInfo.instanceGroupSize, instanceInfo.lfgDungeonID
				= guessTypes(line:match(
					"%[DBM_Debug%] GetInstanceInfo%(%) = ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^,]+), ([^#]+)"
				))
			elseif line:match("DBM:GetCurrentInstanceDifficulty%(%) = [^,]*,[^,]*,[^,]*,[^,]*, (%d*)") then -- Difficulty modifiers
				local modifier = line:match(" = [^,]*,[^,]*,[^,]*,[^,]*, (%d*)")
				instanceInfo.difficultyModifier = tonumber(modifier) or 0
			elseif line:match("%[ENCOUNTER_[SE][TN][AD]") then
				local id, name, difficulty, groupSize, success, isStart = parseEncounterEvent(line)
				if not encounterInfo.id or id == encounterInfo.id then -- multiple different encounters in one log? you'll have to edit this field by hand
					encounterInfo.id = id
					encounterInfo.name = name
					encounterInfo.difficulty = difficulty
					encounterInfo.groupSize = groupSize
					if not isStart then
						encounterInfo.kill = success
					end
				end
			end
		end
		-- But we can grab the recording player id from anywhere
		if not player then
			player = line:match("%[UNIT_SPELLCAST_SUCCEEDED%] PLAYER_SPELL{([^}]+)} %-.*%- %[%[player:Cast%-")
		end
		if player and i > self.lastLine then break end
		if i % 10000 == 0 then
			yield()
		end
	end
	 -- FIXME: distinguish SoD and Era somehow (but the field is unused right now anyways)
	local majorVersion = tonumber(self.log.name:match("Version: (%d*)."))
	local gameVersion = not majorVersion and "Any"
		or majorVersion <= 2 and "SeasonOfDiscovery"
		or majorVersion >= 3 and majorVersion < 11 and "Classic"
		or "Retail"
	if not instanceInfo.name and zoneId then
		local oldModifier = instanceInfo.difficultyModifier
		instanceInfo = instanceInfoGuesser:GuessFromZoneId(zoneId, gameVersion) or instanceInfo
		if encounterInfo then
			instanceInfoGuesser:SetDifficulty(instanceInfo, encounterInfo.difficulty, encounterInfo.groupSize)
		end
		encounterInfo.difficultyModifier = encounterInfo.difficultyModifier or oldModifier
	end
	if not player then
		if UnitName then
			player = UnitName("player")
		else
			error("could not deduce who created the log, please cast at least one spell while logging")
		end
	end
	self.metadata = {
		player = player,
		instanceInfo = instanceInfo,
		encounterInfo = encounterInfo,
		gameVersion = gameVersion
	}
end

function testGenerator:guessMod()
	local encounterName = self.metadata.encounterInfo.name
	if not encounterName then return "" end
	encounterName = encounterName:gsub(" the .*", "")
	encounterName = encounterName:gsub(", .*", "")
	encounterName = encounterName:gsub("^The", "")
	return encounterName:gsub("%s*", ""):gsub("'", "")
end

-- TODO: all of these guessing functions could be much smarter, but I'm adding stuff as I go
function testGenerator:guessTestName()
	if not self.metadata.encounterInfo.name then return "" end
	local difficulty = ""
	if self.metadata.instanceInfo.instanceID == 409 and self.metadata.instanceInfo.difficultyModifier then -- MC heat levels
		difficulty = "Heat-" .. self.metadata.instanceInfo.difficultyModifier .. "/"
	elseif self.metadata.instanceInfo.difficultyName then
		difficulty = self.metadata.instanceInfo.difficultyName .. "/"
	end
	local name = self:guessMod() .. "/" .. difficulty .. (self.metadata.encounterInfo.kill and "Kill" or "Wipe")
	if self.prefix then
		return self.prefix:gsub("/$", "") .. "/" .. name
	else
		return name
	end
end

function testGenerator:guessAddon()
	if self.metadata.gameVersion == "SeasonOfDiscovery" then
		local instanceInfo = self.metadata.instanceInfo
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


local headerTemplate = [[
DBM.Test:DefineTest{
	name = %s,
	gameVersion = %s,
	addon = %s,
	mod = %s,
	instanceInfo = %s,]]

function testGenerator:GetHeaderString()
	local def = self:GetTestDefinition()
	return headerTemplate:format(
		literal(def.name), literal(def.gameVersion), literal(def.addon), literal(def.mod),
		instanceInfoLiteral(def.instanceInfo)
	)
end

function testGenerator:GetPlayersString()
	local _, players = self:GetLogAndPlayers()
	return players
end

function testGenerator:GetLogString()
	local log = self:GetLogAndPlayers()
	return log
end

function testGenerator:GetTestDefinition()
	if self.cache.testDefinition then
		return self.cache.testDefinition
	end
	local _, _, resultLog, resultPlayers = self:GetLogAndPlayers()
	 ---@type TestDefinition
	 self.cache.testDefinition = {
		name = self:guessTestName(),
		gameVersion = self.metadata.gameVersion,
		addon = self:guessAddon(),
		mod = self:guessMod(),
		instanceInfo = self.metadata.instanceInfo,
		perspective = self.metadata.player,
		players = resultPlayers,
		log = resultLog,
	}
	return self:GetTestDefinition()
end

local function unstringify(arg, ...)
	if select("#", ...) == 0 then
		if type(arg) == "string" then
			return arg:sub(
				arg:sub(1, 1) == "\"" and 2 or 1,
				arg:sub(-1, -1) == "\"" and -2 or nil
			)
		else
			return arg
		end
	else
		return unstringify(arg), unstringify(...)
	end
end

function testGenerator:GetLogAndPlayers()
	if self.cache.combinedLog then
		return self.cache.combinedLog, self.cache.combinedPlayers, self.cache.resultLog, self.cache.resultPlayers
	end
	local resultLog, resultLogStr, resultPlayers, resultPlayersStr = {}, {}, {}, {}
	local timeOffset
	local totalTime = 0
	local anon = anonymizer:New(self.log.lines, self.firstLine, self.lastLine, self.metadata.player, not self.anonymize)
	for i = self.firstLine, self.lastLine do
		local line = self.log.lines[i]
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
			-- Unfortunately transcribeEvent already stringifies everything because everything was written with generating code in mind
			-- But for live imports we obviously want non-stringified versions
			-- TODO: Clean this up. we properly might want to transcibe imports into strings first and then parse them again,
			--       that may sound stupid but would be encessary for persistently saved logs anyways. We probably want a real
			--       parser for Lua table expressions to do this (just loadstring() risks constant table size limits)
			resultLog[#resultLog + 1] = {time, unstringify(guessTypes(unpack(testEvent)))}
			resultLogStr[#resultLogStr + 1] = ("{%.2f, %s}"):format(time, table.concat(testEvent, ", "))
		end
		if i % 10000 == 0 then
			yield()
		end
	end
	local sortedRoles = {}
	local maxNameLen = 0
	for _, v in pairs(anon.roles) do
		sortedRoles[#sortedRoles + 1] = v
		-- FIXME: doesn't handle UTF-8 for the non-anon case, but doesn't really matter, it's just for nice formatting of the plyaer table
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
		resultPlayers[#resultPlayers + 1] = roleInfo:GetTestDefinition(self.verboseRoles)
		resultPlayersStr[#resultPlayersStr + 1] = roleInfo:PrettyTableString(maxNameLen, self.verboseRoles)
	end
	self.stats.parsedLines = self.lastLine - self.firstLine + 1
	self.stats.outputLines = #resultLog
	self.stats.logTime = totalTime
	self.metadata.player = anon:ScrubName(self.metadata.player)
	local combinedPlayers = ""
	combinedPlayers = combinedPlayers .. "\tplayers = {\n\t\t"
	combinedPlayers = combinedPlayers ..  table.concat(resultPlayersStr, ",\n\t\t")
	combinedPlayers = combinedPlayers .. "\n\t},\n"
	combinedPlayers = combinedPlayers .. "\tperspective = \"" .. self.metadata.player .. "\","
	local combinedLog = ""
	combinedLog = combinedLog .. "\tlog = {\n\t\t"
	combinedLog = combinedLog ..  table.concat(resultLogStr, ",\n\t\t")
	combinedLog = combinedLog ..  "\n\t},"
	if self.validateAnonymizer and self.anonymize then
		anon:CheckForLeaks(combinedLog)
	end
	self.cache.combinedLog, self.cache.combinedPlayers, self.cache.resultLog, self.cache.resultPlayers = combinedLog, combinedPlayers, resultLog, resultPlayers
	return self:GetLogAndPlayers()
end

function testGenerator:GetIgnoreCandidates()
	return seenFriendlyCids
end

return transcriptorParser
