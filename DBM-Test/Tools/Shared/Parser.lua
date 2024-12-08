local parser = DBM.Test.CreateSharedModule("Parser")

local function syntaxError(message, code, pos, level)
	-- pos itself is useless for errors because it's post comment stripping
	error("parse error: " .. message .. " while trying to parse \"" .. code:sub(pos, pos + 30) .. "\"", 1 + (level or 1))
end

-- FIXME: probably a bad idea to do comment stripping as preprocessing because Lua comments are actually pretty damn complex at least if we want multi-line strings and comments
local function stripComments(code)
	local result = {}
	local offset = 1
	-- it's easier to just do this line-by-line, but doing so decreases total parser performance by ~80%
	while true do
		local commentStart = code:find("--", offset, true)
		if not commentStart then
			if offset < #code then
				result[#result + 1] = code:sub(offset)
			end
			break
		end
		local oldOffset = offset
		offset = commentStart + 2
		if code:match("^%[=*%[", offset) then
			syntaxError("comments in multi-line style (--[[]]) aren't supported", code, commentStart)
		end
		local lineStart = 0
		local lineEnd = 0
		while code:byte(offset - lineStart, offset - lineStart) ~= 10 and offset - lineStart >= 1 do
			lineStart = lineStart + 1
		end
		while code:byte(offset + lineEnd, offset + lineEnd) ~= 10 and offset + lineEnd < #code do
			lineEnd = lineEnd + 1
		end
		local line = code:sub(offset - lineStart, offset + lineEnd)
		commentStart = commentStart - (offset - lineStart)
		if offset - lineStart == 0 then
			commentStart = commentStart -1
		end
		result[#result + 1] = code:sub(oldOffset, offset - lineStart)
		offset = offset + lineEnd
		if line:sub(commentStart + 3):match("[\"']") then
			commentStart = nil
			local inString = nil
			local escapeCount, commentCount = 0, 0
			for i = 1, #line do
				local char = line:sub(i, i)
				if not inString and (char == "\"" or char == "'") then
					inString = char
				elseif not inString and char == "-" then
					if commentCount == 1 then
						commentStart = i - 2
						break
					else
						commentCount = 1
					end
				elseif inString and char == "\\" then
					escapeCount = escapeCount + 1
				elseif inString and char == inString then
					if escapeCount % 2 == 0 then
						inString = false
						commentCount = 0
					else
						escapeCount = 0
					end
				else
					escapeCount, commentCount = 0, 0
				end
			end
		end
		result[#result + 1] = line:sub(1, commentStart and commentStart or #line)
	end
	return table.concat(result, "")
end

local function expectChar(code, pos, expected)
	local _, newPos, actual = code:find("%s*(.)%s*", pos) -- TODO: whitespace handling is a mess, consider doing proper tokenization prior to parsing
	if actual ~= expected then
		syntaxError("expected " .. expected .. ", got " .. (actual or "<EOF>"), code, pos)
	end
	return newPos + 1
end

local function consumeOptional(code, pos, expected)
	local _, newPos, actual = code:find("%s*(.)%s*", pos)
	if actual == expected then
		return newPos + 1
	else
		return pos
	end
end

local function consumeChar(code, pos)
	local _, pos = code:find("%s*(.)", pos)
	return pos + 1
end

local function peekChar(code, pos)
	return code:match("%s*(.)", pos)
end

local function parseIdentifier(code, pos)
	local _, newPos, identifier = code:find("^%s*([_%a][_%w]*)", pos)
	if not newPos then
		syntaxError("expected <identifier>, got <EOF>", code, pos)
	end
	return newPos + 1, identifier
end

local function parseNumber(code, pos)
	local _, pos, value = code:find("^%s*([-.ex%x]*)%s*", pos)
	value = tonumber(value)
	if not tonumber(value) then
		syntaxError("invalid number " .. tostring(value), code, pos)
	end
	return pos + 1, value
end

local function parseBool(code, pos)
	local _, pos, value = code:find("^%s*([%a]*)%s*", pos)
	if value == "true" then
		value = true
	elseif value == "false" then
		value = false
	else
		syntaxError("invalid assignment")
	end
	return pos + 1, value
end

local function parseNil(code, pos)
	local _, pos, value = code:find("^%s*(nil)%s*", pos)
	if not pos then
		syntaxError("invalid assignment")
	end
	return pos + 1, nil
end

local validEscapes = {
	["\\a"] = "\a", ["\\b"] = "\b", ["\\f"] = "\f", ["\\n"] = "\n", ["\\r"] = "\r", ["\\t"] = "\t", ["\\v"] = "\v", ["\\\\"] = "\\" ,["\\\""] = "\"", ["\\'"] = "'",
	["\\\n"] = "\n", ["\\\r"] = "" -- \r is probably followed by a \n anyways, so good enough to just strip it, also, who uses multi-line strings like this anyways?
}
local function unescapeString(str)
	if str:find("\\", nil, true) then -- This check increases performance by 105% because escapes are very rare and str:gsub() seems to be very expensive
		return str
			:gsub("\\(%d%d?%d?)", function(match) return string.char(tonumber(match) or 0) end)
			:gsub("\\.", function(match) return validEscapes[match] or match:sub(2) end)
	else
		return str
	end
end

local function parseString(code, pos)
	local delimiter = code:sub(pos, pos)
	local strStart = pos
	while true do
		local _, nextDelimPos = code:find(delimiter, pos + 1)
		if not nextDelimPos then
			syntaxError("unterminated string", code, strStart)
		end
		local escapes = 0
		while code:sub(nextDelimPos - escapes - 1, nextDelimPos - escapes - 1) == "\\" and nextDelimPos - escapes > strStart do
			escapes = escapes + 1
		end
		if escapes % 2 == 0 then
			return nextDelimPos + 1, unescapeString(code:sub(strStart + 1, nextDelimPos - 1))
		else
			pos = nextDelimPos
		end
	end
end


local parseValue

local function parseAssignment(code, pos)
	local pos, identifier = parseIdentifier(code, pos)
	pos = expectChar(code, pos, "=")
	local pos, value = parseValue(code, pos)
	return pos, identifier, value
end

local function parseTableEntry(code, pos)
	local nextChar = peekChar(code, pos)
	if nextChar == "[" then
		pos = consumeChar(code, pos)
		local pos, key = parseValue(code, pos)
		pos = expectChar(code, pos, "]")
		pos = expectChar(code, pos, "=")
		local pos, value = parseValue(code, pos)
		pos = consumeOptional(code, pos, ",")
		return pos, key, value
	elseif nextChar == "}" then
		pos = consumeChar(code, pos)
		return pos, nil, nil, true
	elseif nextChar == "\"" or nextChar == "'" then -- Optimization to not use the assignment checking regex for the common "list of strings" case
		local pos, value = parseValue(code, pos)
		pos = consumeOptional(code, pos, ",")
		return pos, nil, value
	elseif code:find("^%s*([_%a][_%w]*%s*=)", pos) then
		local pos, key, value = parseAssignment(code, pos)
		pos = consumeOptional(code, pos, ",")
		return pos, key, value
	else
		local pos, value = parseValue(code, pos)
		pos = consumeOptional(code, pos, ",")
		return pos, nil, value
	end
end

local function parseTable(code, pos)
	local result = {}
	pos = expectChar(code, pos, "{")
	local key, value, endOfTable
	local arrayIndex = 1
	while true do
		pos, key, value, endOfTable = parseTableEntry(code, pos)
		if endOfTable then
			break
		end
		if key == nil then
			key = arrayIndex
			arrayIndex = arrayIndex + 1
		end
		if key then
			result[key] = value
		end
	end
	return pos, result
end

local yieldCounter = 0
function parseValue(code, pos)
	yieldCounter = yieldCounter + 1
	-- A large log contains ~500k values and takes ~1 second to parse
	-- Example: full molten core run is 640k strings in 100MiB and takes ~1.25s
	-- ~25k will yield ~20 times per second
	if yieldCounter == 25000 then
		yieldCounter = 0
		local cr, main = coroutine.running()
		if cr and not main then
			coroutine.yield()
		end
	end
	local nextChar = peekChar(code, pos)
	if not nextChar then
		syntaxError("expected <value>, got <EOF>", code, pos)
	elseif nextChar == "{" then
		return parseTable(code, pos)
	elseif nextChar == "t" or nextChar == "f" then
		return parseBool(code, pos)
	elseif nextChar:match("%d") or nextChar == "." or nextChar == "-" then
		return parseNumber(code, pos)
	elseif nextChar == "\"" or nextChar == "'" then
		return parseString(code, pos)
	elseif nextChar == "n" then
		return parseNil(code, pos)
	elseif nextChar == "[" then
		syntaxError("multi-line style strings aren't supported", code, pos)
	else
		syntaxError("unsupported value", code, pos)
	end
end

local function parseChunk(code, pos)
	local env = {}
	while pos < #code and not code:match("^%s*$", pos) do
		local identifier, value
		pos, identifier, value = parseAssignment(code, pos)
		env[identifier] = value
	end
	return env
end

-- Converts a JSON table into a Lua assignment, this is highly specific to some TWW beta logs we got in json format
-- So far this code doesn't have any dependencies, I don't feel like pulling in one just to read json, so this hack is the best I can do
local function convertJsonToLuaIfNecessary(code)
	if not code:match("\"total\"%s*:%s*%[") then
		return code
	end
	local lines = {}
	for line in code:gmatch("([^\n]*)\n?") do
		line = line:gsub("^(%s*)\"(.-)\": [%[{]%s*$", "%1[\"%2\"] = {")
		line = line:gsub("^(%s*)\"([^\"]+)\":", "%1[\"%2\"] = ")
		line = line:gsub("^(%s*)],?(%s*)$", "%1},%2")
		-- TODO: properly support \u escapes, but what is this even? UTF-16?
		-- But it doesn't matter if the log gets anonymized, and these weird json exports we get all end up being anonymized anyways
		line = line:gsub("\\u(%x%x%x)", "U%1")
		line = line:gsub("\\\\", "\\")
		lines[#lines + 1] = line
	end
	return "TranscriptDB = {jsonLog = " .. table.concat(lines, "\n") .. "}"
end

-- Simple recursive descent parser for Lua tables to avoid Lua 5.1 constant limits
-- This is in no way a complete or correct parser for Lua tables, just something that happens to work for what WoW generates as saved variables (Transcriptor logs etc)
-- Specifically it doesn't handle multi-line comments and multi-line strings correctly as they are pretty complex.
function parser:ParseLua(code)
	code = convertJsonToLuaIfNecessary(code)
	code = stripComments(code)
	local pos = 1
	return parseChunk(code, pos)
end

return parser
