---@class InstanceInfoGuesser
local instanceInfo = DBM.Test.CreateSharedModule("InstanceInfoGuesser")

local instanceData = require "Data.Instances"

local instanceTypes = {
	[0] = "none",
	[1] = "party",
	[2] = "raid",
	[3] = "pvp",
	[4] = "arena",
	[5] = "scenario",
	[6] = "unknown", -- Used by a single map: Void Zone: Arathi Highlands (2695)
}

local difficulties = require "Data.Difficulties"

local function tryGetDungeonInfo(zoneId, gameVersion)
	local info = instanceData[gameVersion]
	if not info then
		return
	end
	local obj = {}
	if info[zoneId] then
		-- Important to copy because instanceInfoByZoneId only has static data that gets enriched with dynamic data from the log later
		for k, v in pairs(info[zoneId]) do
			obj[k] = v
		end
	end
	obj.instanceID = zoneId
	obj.name = obj.name or GetRealZoneText and GetRealZoneText(zoneId) or "Unknown"
	obj.dynamicDifficulty = 0
	obj.isDynamic = false
	return obj, not not info[zoneId]
end

function instanceInfo:GuessFromZoneId(zoneId, gameVersion)
	if gameVersion == "Any" then
		if DBM and DBM.IsClassic then
			gameVersion = DBM:IsRetail() and "Retail"
				or DBM:IsCata() and "Classic"
				or DBM:IsSeasonal("SeasonOfDiscovery") and "SeasonOfDiscovery"
				or DBM:IsClassic() and "ClassicEra"
				or "Any"
		end
	end
	local obj, gotData = tryGetDungeonInfo(zoneId, gameVersion)
	if not gotData then -- fall back to just try versions in order of popularity
		obj, gotData = tryGetDungeonInfo(zoneId, "Retail")
		if not gotData then
			obj, gotData = tryGetDungeonInfo(zoneId, "ClassicEra")
		end
		if not gotData then
			obj = tryGetDungeonInfo(zoneId, "Classic")
		end
	end
	return obj
end

---@param info DBMInstanceInfo
function instanceInfo:SetDifficulty(info, difficulty, players)
	info.difficultyID = difficulty
	info.instanceGroupSize = players
	local difficultyInfo = difficulties[difficulty]
	if difficultyInfo then
		info.instanceType = instanceTypes[difficultyInfo.instanceTypeId] or info.instanceType
		info.difficultyName = difficultyInfo.difficultyName or info.difficultyName
		info.maxPlayers = difficultyInfo.maxPlayers or info.maxPlayers or players
	end
end

return instanceInfo
