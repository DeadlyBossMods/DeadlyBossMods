local parser = DBM.Test.CreateSharedModule("StupidParser")

local function parseLogFrom(code, offset)
	local lines = {}
	local _
	_, offset = code:find("%[\"total\"%]%s*=%s*{", offset)
	local currentLogEnd = code:find("},", offset)
	if not offset or not currentLogEnd then
		return
	end
	while true do
		local _, lineEnd, line = code:find("\"(.-)\",", offset)
		if not lineEnd or lineEnd > currentLogEnd then
			break
		end
		offset = lineEnd
		lines[#lines + 1] = line
		if #lines % 10000 == 0 then -- Parser runs at ~300k lines per second on my machine
			local cr, main = coroutine.running()
			if cr and not main then
				coroutine.yield()
			end
		end
	end
	return offset, lines
end

local function convertJsonToLuaIfNecessary(code)
	if not code:match("\"total\"%s*:%s*%[") then
		return code
	end
	-- The secret TWW logs are split with some weird tool that outputs json
	-- So far this code doesn't have any dependencies, I don't feel like pulling in one just to read json, so this hack is the best I can do
	local lines = {}
	for line in code:gmatch("([^\n]*)\n?") do
		line = line:gsub("^(%s*)\"(.-)\": [%[{]%s*$", "%1[\"%2\"] = {")
		line = line:gsub("^(%s*)\"([^\"]+)\":", "%1[\"%2\"] = ")
		line = line:gsub("^(%s*)],?(%s*)$", "%1},%2")
		-- TODO: properly support \u escapes, but what is this even? UTF-16?
		-- But it doesn't matter if the log gets anonymized, and these weird json exports we get all end up being anonymized anyways
		line = line:gsub("\\u(%x%x%x)", "U%1")
		lines[#lines + 1] = line
	end
	return "TranscriptDB = {jsonLog = " .. table.concat(lines, "\n") .. "}"
end

-- Not a real parser, just something that turns Transcriptor saved variables into logs without running into Lua 5.1 size limits
function parser:ParseLua(code)
	code = convertJsonToLuaIfNecessary(code)
	local offset = 0 ---@type number?
	local result = {}
	while true do
		local _, normalLogOffset, normalLogName = code:find("(%[20%d%d%-%d%d?%-%d%d?%]@%[%d%d?:%d%d?:%d%d?%] %- Zone:%d* Difficulty:%d*,[^\"]*Version:[^\"]*)", offset)
		local _, jsonLogOffset, jsonName = code:find("(jsonLog) = ", offset)
		if not normalLogOffset and not jsonLogOffset then
			break
		end
		local name
		if jsonLogOffset and normalLogOffset and jsonLogOffset < normalLogOffset or not normalLogOffset then
			offset = jsonLogOffset
			name = jsonName
		else
			offset = normalLogOffset
			name = normalLogName
		end
		local lines
		offset, lines = parseLogFrom(code, offset)
		if not offset then
			break
		end
		result[name] = {total = lines}
	end
	return result
end

return parser
