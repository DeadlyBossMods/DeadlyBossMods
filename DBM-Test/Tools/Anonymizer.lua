---@class Anonymizer
local anonymizer = {}
anonymizer.__index = anonymizer

local scrubbers = {}

scrubbers["Cast"] = function(self, guid)
	local spawnId = guid:match("%-(%x*)$")
	spawnId = self.spawnIds[spawnId] or 0
	return guid:gsub("Cast%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)%-(%x*)", "Cast-%1-1000-%2-2000-%3-" .. ("%010X"):format(spawnId))
end

scrubbers["Player"] = function(self, guid)
	return ("Player-1000-%08X"):format(self.playerGuids[guid])
end

scrubbers["Pet"] = function(self, guid)
	local subType, instanceId, id = guid:match("Pet%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)")
	return ("Pet-%s-1000-%s-2000-%s-%010X"):format(subType, instanceId, id, self.petGuids[guid])
end

local npcScrubber = function(self, guid)
	local guidType, subType, instanceId, id, spawnId = guid:match("([^-]*)%-(%d*)%-%d*%-(%d*)%-%d*%-(%d*)%-(%x*)")
	return ("%s-%s-1000-%s-2000-%s-%010X"):format(guidType, subType, instanceId, id, self.spawnIds[spawnId] or 0)
end
scrubbers["Creature"] = npcScrubber
scrubbers["Vehicle"] = npcScrubber
scrubbers["GameObject"] = npcScrubber


function anonymizer:ScrubGUID(guid)
	local guidType = guid:match("([^-]*)%-")
	if not scrubbers[guidType] then
		error("no scrubber for guid " .. guid)
	end
	return scrubbers[guidType](self, guid)
end

function anonymizer:AnonNameFromGuid(guid)
	if self.playerGuids[guid] then
		return "Player" .. self.playerGuids[guid]
	elseif self.petGuids[guid] then
		return "Pet" .. self.petGuids[guid]
	end
end

function anonymizer:ScrubName(name, guid)
	return guid and self:AnonNameFromGuid(guid) or self.nonPlayerNames[name] or self.playerNames[name] or self.petNames[name]
end

function anonymizer:ScrubTarget(name)
	if name == "??" then
		return name
	end
	return self.nonPlayerNames[name] or self.playerNames[name] or self.petNames[name]
end

-- Technically this is a pseudonymizer, not an anonymizer, but that's what we want
function anonymizer:New(logEntries, first, last)
	local playerGuids, playerNames = {}, {}
	local petGuids, petNames = {}, {}
	local spawnIds = {}
	local nonPlayerNames = {}
	for i = first, last do -- do we want to use the entire log or just the segment we are looking at? probably saver to restrict to the segment
		local line = logEntries[i]
		-- Collect all player GUIDs and names
		for guid, name in line:gmatch("(Player%-%d*%-%x*)#([^#]*)") do
			playerGuids[guid] = name
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
	-- Anyhow, in a full "playground" UI we would also have some auto-detection who roles, so let's use simple IDs for now
	for i, v in ipairs(sortedIds(playerGuids)) do
		playerNames[playerGuids[v]] = "Player" .. i
		playerGuids[v] = i
	end
	for i, v in ipairs(sortedIds(petGuids)) do
		petNames[petGuids[v]] = "Pet" .. i
		petGuids[v] = i
	end
	---@class Anonymizer
	local obj = {
		playerGuids = playerGuids, playerNames = playerNames,
		petGuids = petGuids, petNames = petNames,
		spawnIds = spawnIds,
		nonPlayerNames = nonPlayerNames
	}
	return setmetatable(obj, anonymizer)
end

function anonymizer:RealPlayerGuidByName(name)
	-- FIXME: this is somewhat ugly, only used to get the real GUID of the recording player though
	local id = self.playerNames[name]
	for guid, v in pairs(self.playerGuids) do
		if "Player" .. v == id then
			return guid
		end
	end
end

return anonymizer
