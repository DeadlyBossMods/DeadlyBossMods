---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = DBM

DBM.fileBrowserData = DBM.fileBrowserData or {}
local folderCache = {}
local categoryCache = {}

---Returns a list of files in the specified folder
---@param path string Path to the folder
---@return table List of files in the folder, each with path and metadata
function DBM:getFolderFiles(path)
	if folderCache[path] then
		DBM:Debug("Returning cached files for path: " .. path, 1)
		return folderCache[path]
	end
	local meta = DBM.fileBrowserData[path]
	if not meta then
		DBM:Debug("Not a known path", 1)
		return {}
	end

	local files = {}

	for i = 1, meta.count, 1 do
		local file = {
			path = path .. "\\" .. (meta.files[i].fileName or meta.files[i].value),
			metadata = meta.files[i]
		}
		table.insert(files, file)
		DBM:Debug("Adding file:".. file.path.. " with metadata: " .. (tostring(file.metadata.text) or "nil"), 2)
	end
	folderCache[path] = files
	return files
end


---Returns a list of files with the specified category
---@param key string Metadata field to filter by (e.g., "category", "type")
---@param value string Value of the metadata field to filter by (e.g., "victory", "defeat")
---@return table files List of files with the specified category
function DBM:getFilesWithMetadata(key, value)
	categoryCache[key] = categoryCache[key] or {}
	if categoryCache[key][value] then
		DBM:Debug("Returning cached files for " .. key .. ": " .. value .. ": " .. #categoryCache[key][value], 1)
		return categoryCache[key][value]
	end

	local files = {}
	for path, _ in pairs(DBM.fileBrowserData) do
		local folderFiles = DBM:getFolderFiles(path)
		for _, file in ipairs(folderFiles) do
			table.insert(files, file)
		end
	end

	files = DBM:filterFilesByField(files, key, value)

	categoryCache[key][value] = files
	DBM:Debug("Returning files with '" .. key .. "': " .. #files, 1)
	return files
end


function DBM:filterFilesByField(files, key, value)
	local filteredFiles = {}
	for _, file in ipairs(files) do
		if file.metadata[key] and file.metadata[key] == value then
			table.insert(filteredFiles, file)
			DBM:Debug("Found file with " .. key .. ": " .. file.path, 2)
		end
	end
	return filteredFiles
end