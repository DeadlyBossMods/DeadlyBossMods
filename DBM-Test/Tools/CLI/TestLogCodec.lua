-- CLI-only CBOR encoder for test logs. WoW uses C_EncodingUtil; this module is never loaded by an addon TOC.
-- Numeric keys are encoded as a map so missing values within combat-log events retain their indices.
local codec = {}

local function header(major, count)
	if count < 24 then
		return string.char(major * 32 + count)
	elseif count < 256 then
		return string.char(major * 32 + 24, count)
	elseif count < 65536 then
		return string.char(major * 32 + 25) .. string.pack(">I2", count)
	elseif count < 4294967296 then
		return string.char(major * 32 + 26) .. string.pack(">I4", count)
	end
	return string.char(major * 32 + 27) .. string.pack(">I8", count)
end

local function encode(value, chunks)
	local kind = type(value)
	if kind == "string" then
		-- Blizzard serializes Lua strings as CBOR byte strings, even when they contain UTF-8.
		chunks[#chunks + 1] = header(2, #value)
		chunks[#chunks + 1] = value
	elseif kind == "boolean" then
		chunks[#chunks + 1] = value and "\245" or "\244"
	elseif kind == "number" then
		if value % 1 == 0 and math.abs(value) < 9007199254740992 then
			chunks[#chunks + 1] = value >= 0 and header(0, value) or header(1, -1 - value)
		else
			chunks[#chunks + 1] = "\251" .. string.pack(">d", value)
		end
	elseif kind == "table" then
		local keys = {}
		for key in pairs(value) do
			assert(type(key) == "number" and key > 0 and key % 1 == 0, "test logs require positive integer keys")
			keys[#keys + 1] = key
		end
		table.sort(keys)
		chunks[#chunks + 1] = header(5, #keys)
		for _, key in ipairs(keys) do
			encode(key, chunks)
			encode(value[key], chunks)
		end
	else
		error("unsupported test-log value: " .. kind)
	end
end

function codec.Encode(log)
	local chunks = {}
	encode(log, chunks)
	return table.concat(chunks)
end

return codec
