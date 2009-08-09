
local IsleOfConquest = DBM:NewMod("IsleOfConquest", "DBM-Battlegrounds")
local L = IsleOfConquest:GetLocalizedStrings()

IsleOfConquest:RemoveOption("HealthFrame")

IsleOfConquest:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA", 	-- Required for BG start
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL"
)

local allyTowerIcon = "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\GuardTower"
local allyColor = { r = 0,	g = 0,	b = 1 }
local hordeTowerIcon = "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\OrcTower"
local hordeColor = { r = 1,	g = 0,	b = 0 }

local startTimer = IsleOfConquest:NewTimer(62, "TimerStart")
local POITimer = IsleOfConquest:NewTimer(61, "TimerPOI")	-- point of interrest 

local function isinargs(val, ...)	-- search for val in all args (...)
		for i=1, select("#", ...), 1 do
			local v = select(i,  ...)
			if v == val then
					return true
			end
		end
		return false
end

local poi = {}
local function is_poi(id)
	return (id >= 16 and id <= 20) 		-- Quarry
		or (id >= 135 and id <= 139)	-- Workshop
		or (id >= 140 and id <= 144)	-- Hangar
		or (id >= 145 and id <= 149)	-- Docks
		or (id >= 150 and id <= 154)	-- Refinerie
		or (id >= 9 and id <= 12)		-- Keep
end
local function poi_state(id)
	if isinargs(id, 18, 136, 141, 146, 151) then		return 1		-- allianz
	elseif isinargs(id, 20, 138, 143, 148, 153) then 	return 2		-- horde
	elseif isinargs(id, 17, 137, 142, 147, 152) then	return 3		-- if poi_state(id) == 3 then --- alliance takes from horde
	elseif isinargs(id, 19, 139, 144, 149, 154) then	return 4		-- if poi_state(id) == 4 then --- horde takes from alliance
	elseif isinargs(id, 16, 135, 140, 145, 150) then	return 5		-- if poi_state(id) == 5 then --- untaken
	else return 0
	end
end

-- 
-- 16 Quarry - Uncontrolled
-- 17 Quarry - In Conflict (to Alliance)
-- 18 Quarry - Alliance Controlled
-- 19 Quarry - In Conflict (to Horde)
-- 20 Quarry - Horde Controlled
--
-- 135 Workshop - Uncontrolled
-- 136 Workshop - Allianz
-- 137 Workshop - In Conflict (to Alliance)
-- 138 Workshop - Horde Controlled
-- 139 Workshop - In Conflict (to Horde)
--
-- 140 Hangar - Uncontrolled
-- 141 Hangar - Allianz
-- 142 Hangar - In Conflict (to Alliance)
-- 143 Hangar - Horde Controlled
-- 144 Hangar - In Conflict (to Horde)
--
-- 145 Docks - Uncontrolled
-- 146 Docks - Allianz
-- 147 Docks - In Conflict (to Alliance)
-- 148 Docks - Horde
-- 149 Docks - In Conflict (to Horde)
--
-- 150 Refinerie - Uncontrolled
-- 151 Refinerie - Allianz
-- 152 Refiniere - In Conflict (to Alliance)
-- 153 Refinerie - Horde Controlled
-- 154 Refinerie - In Conflict (to Horde)
--
--
-- 77 Horde Gate - OK
-- 78 - i think its at half hp
-- 79 Horde Gate - Destroyed
--
-- 80 Allianz Gate - OK
-- 81 - i think its at half hp
-- 82 Allianz Gate - Destroyed
--
-- 9 Keep - In Conflict (to Allianz)
-- 10 Keep - Horde Controlled 
-- 11 Keep - Allianz
-- 12 Keep - In Conflict (to Horde)
--


local bgzone = false
do
	local function IOC_Initialize()
		if select(2, IsInInstance()) == "pvp" and GetRealZoneText() == L.ZoneName then
			bgzone = true
			for i=1, GetNumMapLandmarks(), 1 do
				local name, _, textureIndex = GetMapLandmarkInfo(i)
				if name and textureIndex then
					if is_poi(textureIndex) then
						poi[i] = textureIndex
					end
				end
			end

		elseif bgzone then
			bgzone = false
		end
	end
	IsleOfConquest.OnInitialize = IOC_Initialize
	IsleOfConquest.ZONE_CHANGED_NEW_AREA = IOC_Initialize
end

local schedule_check

function IsleOfConquest:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if not bgzone then return end
	if arg1 == L.BgStart60 then
		startTimer:Start()
	elseif arg1 == L.BgStart30  then		
		startTimer:Update(31, 62)
	end
	schedule_check(self)
end

local function check_for_updates()
	if not bgzone then return end
	for k,v in pairs(poi) do
		local name, _, textureIndex = GetMapLandmarkInfo(k)
		if name and textureIndex then
			if poi_state(v) <= 2 and poi_state(textureIndex) > 2 then
				-- poi is now in conflict, we have to start a bar :)
				POITimer:Start(nil, name)

				if poi_state(textureIndex) == 3 then
					POITimer:SetColor(allyColor, name)
				else
					POITimer:SetColor(hordeColor, name)
				end
				
			elseif poi_state(textureIndex) <= 2 then
				-- poi is now longer under conflict, remove the bars
				POITimer:Stop(name)
			end
			poi[k] = textureIndex
		end		 
	end
end

function schedule_check(self)
	self:Schedule(1, check_for_updates)
end


IsleOfConquest.CHAT_MSG_MONSTER_YELL = schedule_check
IsleOfConquest.CHAT_MSG_BG_SYSTEM_ALLIANCE = schedule_check
IsleOfConquest.CHAT_MSG_BG_SYSTEM_HORDE = schedule_check





