---@class RoleGuesser
local roleGuesser = {}
local mt = {__index = roleGuesser}

function roleGuesser:New(recordingPlayer)
	---@class RoleGuesser
	local obj = {
		---@type table<string, RoleGuesserPlayerStats>
		players = {},
		recordingPlayer = recordingPlayer
	}
	return setmetatable(obj, mt)
end

---@class RoleGuesserPlayerStats
local roleGuesserPlayerStats = {}
local roleGuesserPlayerStatsMt = {__index = roleGuesserPlayerStats}

function roleGuesser:initPlayerStats(name)
	---@class RoleGuesserPlayerStats
	local obj = {
		heal = 0,
		damage = 0,
		tanking = 0,
		healed = 0,
		role = "Unknown", ---@type "Unknown"|"Healer"|"Tank"|"Dps"
		realName = name or "Unknown",
		anonName = nil, ---@type string
		anonGuid = nil, ---@type string
		originalLogRecorder = self.recordingPlayer == name
	}
	return setmetatable(obj, roleGuesserPlayerStatsMt)
end

function roleGuesserPlayerStats:Anonymize(name, guid)
	self.anonName = name
	self.anonGuid = guid
end

function roleGuesserPlayerStats:PrettyTableString(maxNameLen)
	local extraInfo = ""
	if self.realName == self.anonName then
		extraInfo = (", role = %q"):format(self.role)
	end
	if self.originalLogRecorder then
		extraInfo = extraInfo .. ", logRecorder = true"
	end
	if self.heal > 0.3 and self.role ~= "Healer"
	or self.damage > 0.3 and self.role ~= "Dps" and (self.role ~= "Tank" or self.damage > 0.7)
	or (self.tanking > 0.3 or self.healed > 0.3) and self.role ~= "Tank" then
		extraInfo = extraInfo .. (", healer = %.2f, tank = %.2f, dps = %.2f"):format(self.heal, math.max(self.tanking, self.healed), self.damage)
	end
	return ("{%q,%s %q%s}"):format(self.anonName, (" "):rep((maxNameLen or 0) - #self.anonName), self.anonGuid, extraInfo)
end

function roleGuesser:HandleCombatLog(line)
	-- TODO: why is parsing not handled in one central place?
	local args = line:match("%[CLEU%] (.*)")
	local params = {}
	local i = 1
	for param in args:gmatch("([^#]*)") do
		local val
		if param == "nil" then
			val = nil
		elseif param == "true" then
			val = true
		elseif param == "false" then
			val = false
		elseif tostring(tonumber(param)) == param then
			val = tonumber(param)
		else
			val = param
		end
		if i == 2 and type(val) == "number" then
			-- srcFlags, optional in logs, ignore
		else
			params[i] = val
			i = i + 1
		end
	end
	local event, srcGuid, srcName, dstGuid, dstName, spellId, spellName, amount, overkill = table.unpack(params, 1, i)
	srcName = srcName and srcName:gsub("([^%(]*)(%([%d.%%-]*)%)", "%1") -- Strip health/power info
	dstName = type(dstName) == "string" and dstName:gsub("([^%(]*)(%([%d.%%-]*)%)", "%1") -- Strip health/power info
	if event == "SWING_DAMAGE" then
		amount = spellId
		overkill = spellName
	end
	local srcPlayer = srcGuid and srcGuid:match("^Player")
	local dstPlayer = dstGuid and dstGuid:match("^Player")
	if srcPlayer then
		self.players[srcGuid] = self.players[srcGuid] or self:initPlayerStats(srcName)
		srcPlayer = self.players[srcGuid]
	end
	if dstPlayer then
		self.players[dstGuid] = self.players[dstGuid] or self:initPlayerStats(dstName)
		dstPlayer = self.players[dstGuid]
	end
	-- Healers are those who heal other players
	if srcPlayer and dstPlayer and (event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL") and srcGuid ~= dstGuid then
		srcPlayer.heal = srcPlayer.heal + (amount or 0) + (overkill or 0)
		dstPlayer.healed = dstPlayer.healed + (amount or 0) + (overkill or 0)
	end
	-- Distinguishing ranged and melee dps would be nice, but we don't have swing_damage
	if srcPlayer and (event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_DAMAGE[CONDENSED]" or event == "SPELL_PERIODIC_DAMAGE[CONDENSED]") then
		-- we don't even have damage amount, so best we can do is counting hits as 1 and periodic damage as 0.1
		srcPlayer.damage = srcPlayer.damage + (event:match("CONDENSED") and tonumber(dstGuid:match("^(%d+)")) or 1) / (event:match("PERIOIDIC") and 10 or 1)
	end
	-- Tanks are those who get hit by the boss or receive healing (handled above)
	if dstPlayer and event == "SWING_DAMAGE" then
		dstPlayer.tanking = dstPlayer.tanking + (amount or 0) + (overkill or 0)
	end
end

function roleGuesser:GetPlayerInfo()
	if self.processedRoles then return self.processedRoles end
	local maxVals = self:initPlayerStats()
	for _, v in pairs(self.players) do
		maxVals.heal = math.max(maxVals.heal, v.heal)
		maxVals.damage = math.max(maxVals.damage, v.damage)
		maxVals.tanking = math.max(maxVals.tanking, v.tanking)
		maxVals.healed = math.max(maxVals.healed, v.healed)
	end
	for _, v in pairs(self.players) do
		v.heal = v.heal / maxVals.heal
		v.damage = v.damage / maxVals.damage
		v.tanking = v.tanking / maxVals.tanking
		v.healed = v.healed / maxVals.healed
		-- Some heuristics based on wild guesses, this doesn't need to be 100% accurate, just make a somewhat reasonable guess
		if v.heal >= 0.5 or v.heal >= 0.1 and v.damage < v.heal and v.tanking < 0.2 then
			v.role = "Healer"
		elseif v.tanking >= 0.5 or v.healed >= 0.6 then
			v.role = "Tank"
		else
			v.role = "Dps"
		end
	end
	self.processedRoles = self.players
	return self.processedRoles
end

return roleGuesser

