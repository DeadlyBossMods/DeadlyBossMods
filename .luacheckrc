---@diagnostic disable: lowercase-global
std = "lua51"
max_line_length = false
exclude_files = {
	"**/Libs/**/*.lua",
	".luacheckrc",
	"DBM-Test/Public/Callbacks.lua", -- @meta LuaLS file triggers false positives
	"DBM-Test/Tools/Shared/Data/*.lua", -- Yes, I know, there are duplicate entries, but that's fine, see comment in file
	"DBM-Test/Tools/Shared/Parser.lua", -- Too many shadowing warnings that don't add much value
}
ignore = {
	"1..", -- Everything related to globals, the LuaLS check is better because it doesn't require us to define every single API functions
	"211", -- Unused local variable
	"211/L", -- Unused local variable "L"
	"211/CL", -- Unused local variable "CL"
	"212", -- Unused argument
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
--    "431", -- shadowing upvalue
	"542", -- An empty if branch
}
