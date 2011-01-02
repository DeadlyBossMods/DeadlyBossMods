local IsleOfConquest	= DBM:NewMod("IsleofConquest", "DBM-PvP", 2)
local L					= IsleOfConquest:GetLocalizedStrings()

IsleOfConquest:RemoveOption("HealthFrame")
IsleOfConquest:RemoveOption("SpeedKillTimer")
IsleOfConquest:SetZone(DBM_DISABLE_ZONE_DETECTION)

IsleOfConquest:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA", 	-- Required for BG start
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local allyTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\GuardTower"
local allyColor = {r = 0, g = 0, b = 1}
local hordeTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\OrcTower"
local hordeColor = {r = 1, g = 0, b = 0}

local warnSiegeEngine = IsleOfConquest:NewAnnounce("WarnSiegeEngine", 3)
local warnSiegeEngineSoon = IsleOfConquest:NewAnnounce("WarnSiegeEngineSoon", 2) 

local startTimer = IsleOfConquest:NewTimer(62, "TimerStart")
local POITimer = IsleOfConquest:NewTimer(61, "TimerPOI")	-- point of interest
local timerSiegeEngine = IsleOfConquest:NewTimer(180, "TimerSiegeEngine")


local function isInArgs(val, ...)	-- search for val in all args (...)
	for i=1, select("#", ...), 1 do
		local v = select(i,  ...)
		if v == val then
			return true
		end
	end
	return false
end

local poi = {}
local function isPoi(id)
	return (id >= 16 and id <= 20) 		-- Quarry
		or (id >= 135 and id <= 139)	-- Workshop
		or (id >= 140 and id <= 144)	-- Hangar
		or (id >= 145 and id <= 149)	-- Docks
		or (id >= 150 and id <= 154)	-- Refinerie
		or (id >= 9 and id <= 12)		-- Keep
end
function getPoiState(id)
	if isInArgs(id, 18, 136, 141, 146, 151) then		return 1		-- alliance
	elseif isInArgs(id, 20, 138, 143, 148, 153) then 	return 2		-- horde
	elseif isInArgs(id, 16, 135, 140, 145, 150) then	return 3		-- if getPoiState(id) == 3 then --- untaken
	elseif isInArgs(id, 17, 137, 142, 147, 152) then	return 4		-- if getPoiState(id) == 4 then --- alliance takes
	elseif isInArgs(id, 19, 139, 144, 149, 154) then	return 5		-- if getPoiState(id) == 5 then --- horde takes
	else return 0
	end
end


local bgzone = false
do
	local function initialize(self)
		if select(2, IsInInstance()) == "pvp" and GetCurrentMapAreaID() == 540 then
			bgzone = true
			for i=1, GetNumMapLandmarks(), 1 do
				local name, _, textureIndex = GetMapLandmarkInfo(i)
				if name and textureIndex then
					if isPoi(textureIndex) then
						poi[i] = textureIndex
					end
				end
			end
		elseif bgzone then
			self:Stop()
			bgzone = false
		end
	end
	
	IsleOfConquest.OnInitialize = initialize
	IsleOfConquest.ZONE_CHANGED_NEW_AREA = initialize
end

local scheduleCheck

function IsleOfConquest:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if not bgzone then return end
	if arg1 == L.BgStart60 then
		startTimer:Start()
	elseif arg1 == L.BgStart30  then		
		startTimer:Update(31, 62)
	elseif arg1 == L.BgStart15 then
		startTimer:Update(47, 62)
	end
	scheduleCheck(self)
end

local function checkForUpdates()
	if not bgzone then return end
	for k,v in pairs(poi) do
		local name, _, textureIndex = GetMapLandmarkInfo(k)
		if name and textureIndex then
			--      new state       vs     old state
			if getPoiState(v) <= 3 and getPoiState(textureIndex) > 3 then
				-- poi is now in conflict, we have to start a bar :)
				POITimer:Start(nil, name)
				if k == 13 then			-- Workshop is under attack, Siege Engine building is cancelled
					timerSiegeEngine:Cancel()
					warnSiegeEngineSoon:Cancel()
				end
				if getPoiState(textureIndex) == 4 then		-- alliance takes
					POITimer:SetColor(allyColor, name)
					POITimer:UpdateIcon(allyTowerIcon, name)
				else
					POITimer:SetColor(hordeColor, name)
					POITimer:UpdateIcon(hordeTowerIcon, name)
				end
			elseif getPoiState(textureIndex) <= 2 then
				-- poi is now longer in conflict, remove the bars
				POITimer:Stop(name)
			end
			poi[k] = textureIndex
		end		 
	end
end

function scheduleCheck(self)
	self:Schedule(1, checkForUpdates)
end

function IsleOfConquest:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.GoblinStartAlliance or msg == L.GoblinBrokenAlliance or msg:find(L.GoblinStartAlliance) or msg:find(L.GoblinBrokenAlliance) then
		self:SendSync("SEStart", "Alliance")
	elseif msg == L.GoblinStartHorde or msg == L.GoblinBrokenHorde or msg:find(L.GoblinStartHorde) or msg:find(L.GoblinBrokenHorde) then
		self:SendSync("SEStart", "Horde")
	elseif msg == L.GoblinHalfwayAlliance or msg:find(L.GoblinHalfwayAlliance) then
		self:SendSync("SEHalfway", "Alliance")
	elseif msg == L.GoblinHalfwayHorde or msg:find(L.GoblinHalfwayHorde) then
		self:SendSync("SEHalfway", "Horde")
	elseif msg == L.GoblinFinishedAlliance or msg:find(L.GoblinFinishedAlliance) then
		self:SendSync("SEFinish", "Alliance")
	elseif msg == L.GoblinFinishedHorde or msg:find(L.GoblinFinishedHorde) then
		self:SendSync("SEFinish", "Horde")
	else
		checkForUpdates()
	end
end

function IsleOfConquest:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34476 then
		self:SendSync("SEBroken", "Alliance")
	elseif cid == 35069 then
		self:SendSync("SEBroken", "Horde")	
	end
end

IsleOfConquest.CHAT_MSG_BG_SYSTEM_ALLIANCE = scheduleCheck
IsleOfConquest.CHAT_MSG_BG_SYSTEM_HORDE = scheduleCheck
IsleOfConquest.CHAT_MSG_RAID_BOSS_EMOTE = scheduleCheck

function IsleOfConquest:OnSync(msg, arg)
	if msg == "SEStart" then
		timerSiegeEngine:Start(178)
		warnSiegeEngineSoon:Schedule(168)
		if arg == "Alliance" then
			timerSiegeEngine:SetColor(allyColor)
		elseif arg == "Horde" then
			timerSiegeEngine:SetColor(hordeColor)
		end
	elseif msg == "SEHalfway" then
		warnSiegeEngineSoon:Cancel()
		timerSiegeEngine:Start(89)
		warnSiegeEngineSoon:Schedule(79)
		if arg == "Alliance" then
			timerSiegeEngine:SetColor(allyColor)
		elseif arg == "Horde" then
			timerSiegeEngine:SetColor(hordeColor)
		end
	elseif msg == "SEFinish" then
		warnSiegeEngineSoon:Cancel()
		timerSiegeEngine:Cancel()
		warnSiegeEngine:Show()
	end
end


