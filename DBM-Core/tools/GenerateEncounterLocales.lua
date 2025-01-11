local lfs = require "lfs"

local product = "wow_classic_era_ptr"
local languages = {
	"enUS", "deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW",
	-- "itIT", -- not actually a thing for classic
}

local root = ...
if not root or not lfs.attributes(root) or lfs.attributes(root).mode ~= "directory" then
	error("usage: GenerateEncounterLocales.lua <addon dir>")
end

local foundToc

for entry in lfs.dir(root) do
	if entry:match("%.toc$") then
		foundToc = true
		break
	end
end

-- Just preventing you from accidentally scanning your whole filesystem or something
if not foundToc then
	error(root .. " does not contain a .toc file")
end

local function findEncounterIds(dir, result)
	result = result or {}
	for entry in lfs.dir(dir) do
		local path = dir .. "/" .. entry
		local attrs = lfs.attributes(path)
		if entry ~= "." and entry ~= ".." and attrs and attrs.mode == "directory" then
			findEncounterIds(path, result)
		elseif entry:match("%.[lL][uU][aA]$") and attrs.mode == "file" then
			local f, err = io.open(path)
			if not f then error(err) end
			local contents = f:read("*a")
			f:close()
			local encounterId = tonumber(contents:match("SetEncounterID%s*%(%s*(%d*)"))
			if encounterId then
				result[encounterId] = true
			end
		end
	end
	return result
end

local ids = findEncounterIds(root)

local encounterNames = {}
for _, lang in ipairs(languages) do
	encounterNames[lang] = {}
	local url = ("https://wago.tools/db2/DungeonEncounter/csv?product=%s&locale=%s"):format(product, lang)
	local curl, err = io.popen("curl '" .. url.. "'")
	if not curl then
		error(err)
	end
	local _ = curl:read("*l")
	-- The CSV encoding is a bit cursed, examples:
	-- """Captain"" Cookie",2973,36,1,4000,5556,5,4,0,-1
	-- "Corla, Herald of Twilight",1038,645,0,-2000,5112,2,4,0,-1
	-- Cho'gall,1029,671,0,2500,5494,1,11,0,-1
	-- We only need the first two colums, we only need to parse exactly this, so this hack is good enough:
	for line in curl:lines() do
		local name, id
		if line:sub(1, 1) == "\"" then
			local nameEnd, _
			nameEnd, _, id = line:find("\",(%d+),")
			name = line:sub(2, nameEnd - 1)
			name = name:gsub("\"\"", "\"")
			-- Some russian names also have extra quotes, that is probably just a bug in the data, e.g.
			-- """Толпогон 9-60""",2771,90,201,3000,24507,3,0,0,-1
			if name:match("^\".*\"$") then
				name = name:sub(2, -2)
			end
		else
			name, id = line:match("([^,]*),(%d+)")
		end
		id = tonumber(id)
		if not id or not name then
			io.stderr:write("Could not parse CSV line ", line, "\n")
		else
			table.insert(encounterNames[lang], {name = name, id = id})
		end
	end
	table.sort(encounterNames[lang], function(e1, e2) return e1.id < e2.id end)
	curl:close()
end

print[[
-- This file is auto-generated, do not edit by hand.
-- Run `DBM-Core/Tools/GenerateEncounterLocales.lua <path to this addon>` to re-generate it with latest data from wago.tools

if not DBM.RegisterGeneratedLocales then -- Check for old Core version, to be removed later
	return
end
]]

for _, lang in ipairs(languages) do
	print("if GetLocale() == \"" .. lang .. "\" then")
	print("\tDBM:RegisterGeneratedLocales(\"encounter\", {")
	for _, encounterInfo in ipairs(encounterNames[lang]) do
		if ids[encounterInfo.id] then
			print(("\t\t[%d] = %q,"):format(encounterInfo.id, encounterInfo.name))
		end
	end
	print("\t})")
	print("end")
end
