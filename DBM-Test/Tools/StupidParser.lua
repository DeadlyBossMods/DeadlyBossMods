local parser = {}

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
	end
	return offset, lines
end

-- Not a real parser, just something that turns Transcriptor saved variables into logs without running into Lua 5.1 size limits
function parser:ParseLua(code)
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
