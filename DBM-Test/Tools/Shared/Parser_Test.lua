package.path = package.path .. ";../?.lua"
require "CLI.Environment"
local parser = require "Parser"

local function typedToString(str)
	if type(str) == "string" then
		return string.format("%q", str)
	else
		return tostring(str)
	end
end

local function tableEquals(got, want, path, depth)
	path = path or ""
	depth = depth or 1
	for k, v in pairs(got) do
		if type(v) == "table" and type(want[k]) == "table" then
			tableEquals(v, want[k], path .. tostring(k) .. ".", depth + 1)
		elseif want[k] ~= v then
			error("diff at " .. path .. tostring(k) .. ": got " .. typedToString(v) .. ", want: " .. typedToString(want[k]), depth + 2)
		end
	end
	for k, v in pairs(want) do
		if got[k] == nil then
			error("diff at " .. path .. tostring(k) .. ": got " .. typedToString(got[k]) .. ", want: " .. typedToString(v), depth + 1)
		end
	end
end

local function eval(code)
	if _VERSION ~= "Lua 5.1" then error("requires Lua 5.1") end -- TODO: support others (env in loadstring instead of setfenv)
	local res = {}
	local chunk = assert(loadstring(code))
	setfenv(chunk, res)
	chunk()
	return res
end

local function test(code, want)
	if type(want) == "string" and want:match("^error:") then
		local _, err = pcall(parser.ParseLua, parser, code)
		if not err:find(want, 0, true) then
			error("got error \"" .. tostring(err) .. "\" which doesn't match expected error \"" .. tostring(want) .. "\"", 2)
		end
	else
		want = want or eval(code)
		local got = parser:ParseLua(code)
		if type(want) == "function" then
			want(got)
		else
			tableEquals(got, want)
		end
	end
end

test[[str = "foo"]]
test[[str = 'bar']]
test[[str = "\""]]
test[[str = "\\\\\"\\"]]
test[[str = '\\\'']]
test[[str = "\a\b\f\n\r\t\v"]]
test[[str = "\0foo"]]
test[[str = "\128\64\255\1"]]
test[[str = "\w"]]

test("str = [[]]", "error: multi-line style strings aren't supported")
test("str = '", "error: unterminated string")

-- FIXME: actually invalid Lua but our parser accepts it
test([[
str = "foo
bar"
]],
	{str = "foo\nbar"}
)

test"num = 1"
test"num = -1"
test"num = -1.5"
test"num = .25"
test"num = -.25"
test"num = 0x8"
test"num = 08"
test"num = 1e5"
test"num = -1.5e5"
test"num = -.5e5"
test"num = -0x5e2"

test"bool = true"
test"bool = false"

test"v = nil"
test"v = 5 v=nil"
test"v = 5 v = nil v = 6"

test"tbl = {}"
test"tbl = {x = 5}"
test"tbl = {x = {y = 'bar'}}"
test"tbl = {1, 2, 3}"
test"tbl = {nil, 1, 5}"
test"tbl = {x = 5, nil, {}, foo = 'bar'}"
test"tbl = {{{{{}},{}}}}"
test"tbl = {[5] = 5}"
test"tbl = {[true] = true, [false] = false}"
test[[tbl = {["string"] = "bar"}]]
test("tbl = {[{2}] = {5}}", function(got)
	assert(next(got.tbl)[1] == 2)
	assert(got.tbl[next(got.tbl)][1] == 5)
end)
test("tbl = {someIdentifier}", "error: unsupported value")
test[[
tbl1     =  {
   x        = {foo   =   "bar",    5},
}
tbl2={foo=5,{--asdf

x={123   , 900,[  5   ]=nil,} -- comment

},"",x=7}
tbl3 ={[     5] = 7}
]]

test"x = 1 -- x=5"
test"x = 1 -- x=5\nx=4"
test("x = 1 --[[ x=5\nx=4]]", "error: comments in multi-line style")
test"x = '--'"
test"x = '--x = 5' --x=2"
test[[
x=1--foo
y="--foo --bar baz" -- foo
z=5
z="6" -- "z=5--"
]]
