---@class Anonymizer
local anonymizer = DBM.Test.CreateSharedModule("Anonymizer")

local roleGuesser = require "RoleGuesser"


anonymizer.__index = anonymizer

local scrubbers = {}

scrubbers["Cast"] = function(self, guid)
	local spawnId = guid:match("%-(%x*)$")
	spawnId = self.spawnIds[spawnId] or 0
	return guid:gsub("Cast%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)%-(%x*)", "Cast-%1-1-%2-2-%3-" .. ("%010X"):format(spawnId))
end

scrubbers["Player"] = function(self, guid)
	return self.playerGuids[guid]
end

scrubbers["Pet"] = function(self, guid)
	local subType, instanceId, id = guid:match("Pet%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)")
	return ("Pet-%s-1-%s-1-%s-%010d"):format(subType, instanceId, id, self.petGuids[guid])
end

local npcScrubber = function(self, guid)
	local guidType, subType, instanceId, id, spawnId = guid:match("([^-]*)%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)%-(%x*)")
	return ("%s-%s-1-%s-1-%s-%010X"):format(guidType, subType, instanceId, id, self.spawnIds[spawnId] or 0)
end
scrubbers["Creature"] = npcScrubber
scrubbers["Vehicle"] = npcScrubber
scrubbers["GameObject"] = npcScrubber

-- All scrubbers return nil when they can't find the name or id - this is on purpose, I want it to fail loud if it can't scrub something.
-- If there is something where a pass-through is okay the caller needs to make it explicit

function anonymizer:ScrubGUID(guid)
	if guid == "nil" then return guid end
	local guidType = guid:match("([^-]*)%-")
	if not scrubbers[guidType] then
		error("no scrubber for guid " .. guid)
	end
	return scrubbers[guidType](self, guid)
end

function anonymizer:AnonNameFromGuid(guid)
	if self.playerNamesByGuid[guid] then
		return self.playerNamesByGuid[guid]
	elseif self.petGuids[guid] then
		return "Pet" .. self.petGuids[guid]
	end
end

function anonymizer:ScrubName(name, guid)
	local strippedName = name:match("([^-]*)%-")
	return guid and self:AnonNameFromGuid(guid)
		or self.nonPlayerNames[name]
		or self.playerNames[name]
		-- playerServers will be set if this is indeed someone frome another server, checking it avoids bugs with non-players with dashes in the name
		or strippedName and self.playerServers[strippedName] and self.playerNames[strippedName]
		or self.petNames[name]
		or name
end

function anonymizer:ScrubPetName(name)
	return not self.nonPlayerNames[name] and self.petNames[name] or name
end

function anonymizer:ScrubTarget(name)
	if name == "??" then
		return name
	end
	local strippedName = name:match("([^-]*)%-")
	if not self.nonPlayerNames[name] and strippedName and self.playerNames[strippedName] then
		name = strippedName
	end
	-- Some fights have dummy targets/controllers that only show up in this event, so we haven't seen them. Best guess: something that contains at least 3 spaces is probably not to be anonymized
	return self.nonPlayerNames[name] or self.playerNames[name] or self.petNames[name] or name
end

local seenChatMsgTranslations = {}

function anonymizer:ScrubChatMessage(msg, name)
	-- Most CHAT_MSG_* things contain the name of a the affected target which makes scrubbing easy
	-- However, RAID_BOSS_EMOTE (without CHAT_MSG_ prefix) does not contain this. Luckily it always seems to fire immediately after
	-- the CHAT_MSG variant, so we just learn the translation there and cache it, works well enough.
	if seenChatMsgTranslations[msg] then
		return seenChatMsgTranslations[msg]
	end
	if not name then
		return msg
	end
	local strippedName = name:match("([^-]*)%-") or name
	local anonName = self:ScrubName(name)
	if not anonName or anonName == name then -- target is sometimes a random dummy unit/controller
		return msg
	end
	local result = msg:gsub(name:gsub("%-", "%%-"), anonName):gsub(strippedName, name)
	seenChatMsgTranslations[msg] = result
	return result
end

-- Technically this is a pseudonymizer, not an anonymizer, but that's what we want
function anonymizer:New(logEntries, first, last, recordingPlayer, keepPlayerNamesAndGuids)
	local playerGuids, playerNames, playerNamesByGuid, playerServers, realPlayerNames = {}, {}, {}, {}, {}
	local petGuids, petNames = {}, {}
	local spawnIds = {}
	local nonPlayerNames = {}
	local roles = roleGuesser:New(recordingPlayer)
	local offset = 1
	while logEntries[offset]:match("%[PLAYER_INFO%]") do -- PLAYER_INFO is only at the start of the log
		local class, realGuid = logEntries[offset]:match("%[PLAYER_INFO%] [^#]*#([^#]*)#([^#]*)")
		roles:SetPlayerClass(realGuid, class)
		offset = offset + 1
	end
	for i = first, last do -- do we want to use the entire log or just the segment we are looking at? probably safer to restrict to the segment
		local line = logEntries[i]
		if line:match("%[CLEU%]") then
			roles:HandleCombatLog(line)
		end
		-- Collect all player GUIDs and names
		for guid, name in line:gmatch("(Player%-%d*%-%x*)#([^#]*)") do
			name = name:gsub("([^%(]*)(%([%d.%%-]*)%)", "%1") -- Strip health/power info
			-- (Mostly) ignore server names as not every event will include it, if we ever get a log with conflicting names then maybe we can handle this
			local strippedName, server = name:match("([^-]*)%-(.*)")
			playerGuids[guid] = strippedName or name
			realPlayerNames[guid] = strippedName or name
			if strippedName then
				if playerServers[strippedName] and playerServers[strippedName] ~= server then
					error("Player name conflict: " .. name .. " vs " .. strippedName .. "-" .. playerServers[strippedName])
				end
				playerServers[strippedName] = server
			end
		end
		for guid, name in line:gmatch("(Pet%-%d*%-%d*-%d*-%d*-%d*-%x*)#([^#]*)") do
			petGuids[guid] = name
		end
		-- Learn names of things that we do not want to translate in an ambiguous contexts where we don't know the type or guid (e.g., targets)
		-- And if some player has the same name as a creature: uh, bad luck?
		for name in line:gmatch("Creature%-%d*%-%d*-%d*-%d*-%d*-%x*#([^#]*)") do
			nonPlayerNames[name] = name
		end
		for name in line:gmatch("GameObject%-%d*%-%d*-%d*-%d*-%d*-%x*#([^#]*)") do
			nonPlayerNames[name] = name
		end
		for name in line:gmatch("Vehicle%-%d*%-%d*-%d*-%d*-%d*-%x*#([^#]*)") do
			nonPlayerNames[name] = name
		end
		-- For everything else the name can be kept, but let's anonymize spawn counters (we can't just drop them, they can be important to distinguish multiple mobs)
		for id in line:gmatch("BattlePet%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("BNetAccount%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("Cast%-%d*%-%d*%-%d*%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("ClientActor%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("Creature%-%d*%-%d*%-%d*%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("GameObject%-%d*%-%d*%-%d*%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("Vehicle%-%d*%-%d*%-%d*%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("Item%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
		for id in line:gmatch("Vignette%-%d*%-%d*%-%d*%-%d*%-%d*%-(%x*)") do spawnIds[id] = true end
	end
	 -- Handle weird local logs where you are not part of the log that are imported in the game (these fail earlier in metadata guessing for the CLI case)
	if UnitName and UnitGUID and (not playerGuids[UnitGUID("player")] or playerGuids[UnitGUID("player")] == "nil") then
		playerGuids[UnitGUID("player")] = UnitName("player")
		realPlayerNames[UnitGUID("player")] = UnitName("player")
	end
	local playerInfo = roles:GetPlayerInfo()
	local function sortedIds(ids)
		local sorted = {}
		for k in pairs(ids) do
			sorted[#sorted + 1] = k
		end
		table.sort(sorted)
		return sorted
	end
	for i, v in ipairs(sortedIds(spawnIds)) do
		spawnIds[v] = i
	end
	-- Is there value in recognizing a player across different tests? We could do something with hashing to avoid large changes if only a few players change?
	-- Role detection/guessing is probably good enough to re-identify important players (tanks, healers)
	local perRoleIds = {
		Healer = 1, Tank = 1, Dps = 1, Unknown = 1
	}
	for i, realGuid in ipairs(sortedIds(playerGuids)) do
		local roleInfo = playerInfo[realGuid] or roleGuesser:NewUnknownPlayer(realGuid)
		local name = keepPlayerNamesAndGuids and realPlayerNames[realGuid] or roleInfo.role .. perRoleIds[roleInfo.role]
		playerNames[playerGuids[realGuid]] = name
		playerNamesByGuid[realGuid] = name
		local anonGuid = keepPlayerNamesAndGuids and realGuid or ("Player-1-%08d"):format(i) -- Using %d instead of %X on purpose to make it more human readable
		roleInfo:Anonymize(name, anonGuid)
		perRoleIds[roleInfo.role] = perRoleIds[roleInfo.role] + 1
		playerGuids[realGuid] = anonGuid
	end
	for i, v in ipairs(sortedIds(petGuids)) do
		petNames[petGuids[v]] = "Pet" .. i
		petGuids[v] = i
	end
	---@class Anonymizer
	local obj = {
		roles = playerInfo,
		playerGuids = playerGuids, playerNames = playerNames, playerNamesByGuid = playerNamesByGuid, playerServers = playerServers,
		petGuids = petGuids, petNames = petNames,
		spawnIds = spawnIds,
		nonPlayerNames = nonPlayerNames
	}
	return setmetatable(obj, anonymizer)
end


local function failOnLeakedString(badString, ignoreErrors)
	-- (not called from WoW, so these functions are fine to use here)
	io.stderr:write(("Detected leak in anonymizer, string %q looks non-anonymized\n"):format(badString))
	if not ignoreErrors then
		io.stderr:write("use --ignore-leaks to ignore this\n")
		os.exit(1)
	end
end

local function checkLeakedString(output, str, ignoreErrors)
	if output:find(str, 0, true) then
		failOnLeakedString(str, ignoreErrors)
	end
end

-- Search for a GUID containing a server ID, these should be set to 1 by the anonymizer
local function checkLeakedGuid(output, pattern, ignoreErrors)
	local prefix, serverId = output:match(pattern)
	if serverId and serverId ~= "1" then
		failOnLeakedString(prefix .. serverId, ignoreErrors)
	end
end

function anonymizer:CheckForLeaks(output, ignoreErrors)
	for _, v in pairs(self.roles) do
		if v.realName ~= v.anonName then
			checkLeakedString(output, v.realName, ignoreErrors)
		end
	end
	checkLeakedGuid(output, "(Creature%-%d*%-)(%d*)", ignoreErrors)
	checkLeakedGuid(output, "(Pet%-%d*%-)(%d*)", ignoreErrors)
	checkLeakedGuid(output, "(GameObject%-%d*%-)(%d*)", ignoreErrors)
	checkLeakedGuid(output, "(Vehicle%-%d*%-)(%d*)", ignoreErrors)
	checkLeakedGuid(output, "(Cast%-%d*%-)(%d*)", ignoreErrors)
	-- GUID types not yet supported, they should never show up in the output until we support them above
	checkLeakedString(output, "BattlePet-", ignoreErrors)
	checkLeakedString(output, "BNetAccount-", ignoreErrors)
	checkLeakedString(output, "ClientActor-", ignoreErrors)
	checkLeakedString(output, "Item-", ignoreErrors)
	checkLeakedString(output, "Vignette-", ignoreErrors)
end

return anonymizer
