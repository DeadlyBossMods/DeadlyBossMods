-- Run from DBM-Test/Tools with Lua 5.3 or newer: lua CLI/TestLogCodec_Test.lua
local codec = require "CLI.TestLogCodec"

local function hex(bytes)
	return (bytes:gsub(".", function(byte)
		return ("%02x"):format(byte:byte())
	end))
end

local function check(value, expected)
	local got = codec.Encode(value)
	assert(got == expected, ("expected %s, got %s"):format(hex(expected), hex(got)))
end

local function checkNumbers()
	check(23, string.char(0x17))
	check(24, string.char(0x18, 24))
	check(256, string.char(0x19, 1, 0))
	check(65536, string.char(0x1a, 0, 1, 0, 0))
	check(4294967296, string.char(0x1b, 0, 0, 0, 1, 0, 0, 0, 0))
	check(-1, string.char(0x20))
	check(1.25, string.char(0xfb, 0x3f, 0xf4, 0, 0, 0, 0, 0, 0))
	check(-0.5, string.char(0xfb, 0xbf, 0xe0, 0, 0, 0, 0, 0, 0))
	check(1 / 3, string.char(0xfb, 0x3f, 0xd5, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55))
	check(2^-1022, string.char(0xfb, 0, 0x10, 0, 0, 0, 0, 0, 0))
	check(2^-1074, string.char(0xfb, 0, 0, 0, 0, 0, 0, 0, 1))
	check(2^53, string.char(0xfb, 0x43, 0x40, 0, 0, 0, 0, 0, 0))
	check(math.huge, string.char(0xfb, 0x7f, 0xf0, 0, 0, 0, 0, 0, 0))
end

checkNumbers()
check("é", string.char(0x42, 0xc3, 0xa9))
check(string.rep("x", 65536), string.char(0x5a, 0, 1, 0, 0) .. string.rep("x", 65536))
check({[1] = 1.25, [3] = false}, string.char(0xa2, 1, 0xfb, 0x3f, 0xf4, 0, 0, 0, 0, 0, 0, 3, 0xf4))

print("TestLogCodec passed")
