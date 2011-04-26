local IsleOfConquest	= DBM:NewMod("IsleofConquest", "DBM-PvP", 2)
local L					= IsleOfConquest:GetLocalizedStrings()

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

IsleOfConquest:RemoveOption("HealthFrame")
IsleOfConquest:RemoveOption("SpeedKillTimer")

local warnSiegeEngine 		= IsleOfConquest:NewAnnounce("WarnSiegeEngine", 3)
local warnSiegeEngineSoon 	= IsleOfConquest:NewAnnounce("WarnSiegeEngineSoon", 2) 

local startTimer 		= IsleOfConquest:NewTimer(62, "TimerStart", 2457)
local POITimer 			= IsleOfConquest:NewTimer(61, "TimerPOI", "Interface\\Icons\\Spell_Misc_HellifrePVPHonorHoldFavor")	-- point of interest
local timerSiegeEngine 	= IsleOfConquest:NewTimer(180, "TimerSiegeEngine", 15048)

local allyTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\GuardTower"
local allyColor = {r = 0, g = 0, b = 1}
local hordeTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\OrcTower"
local hordeColor = {r = 1, g = 0, b = 0}

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
	if isInArgs(id, 16, 135, 140, 145, 150) then		return -1		-- Neutral
	elseif isInArgs(id, 18, 136, 141, 146, 151) then	return 1		-- Alliance controlled
	elseif isInArgs(id, 20, 138, 143, 148, 153) then 	return 2		-- Horde controlled
	elseif isInArgs(id, 17, 137, 142, 147, 152) then	return 3		-- Alliance assaulted
	elseif isInArgs(id, 19, 139, 144, 149, 154) then	return 4		-- Horde assaulted
	else return false
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

do
	local function checkForUpdates()
		if not bgzone then return end
		for k,v in pairs(poi) do
			local name, _, textureIndex = GetMapLandmarkInfo(k)
			if name and textureIndex then
				local curState = getPoiState(textureIndex)
				if curState and getPoiState(v) ~= curState then
					POITimer:Stop(name)
					if curState > 2 then
						POITimer:Start(nil, name)
						if curState == 3 then
							POITimer:SetColor(allyColor, name)
							POITimer:UpdateIcon(allyTowerIcon, name)
						else
							POITimer:SetColor(hordeColor, name)
							POITimer:UpdateIcon(hordeTowerIcon, name)
						end
					end
					if k == 13 then 	-- Workshop is attacked, Siege Engine building is cancelled
						timerSiegeEngine:Cancel()
						warnSiegeEngineSoon:Cancel()
					end
				end
				poi[k] = textureIndex
			end		 
		end
	end

	function scheduleCheck(self)
		self:Schedule(1, checkForUpdates)
	end

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
	
	IsleOfConquest.CHAT_MSG_BG_SYSTEM_ALLIANCE = scheduleCheck
	IsleOfConquest.CHAT_MSG_BG_SYSTEM_HORDE = scheduleCheck
	IsleOfConquest.CHAT_MSG_RAID_BOSS_EMOTE = scheduleCheck
end

function IsleOfConquest:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34476 then
		self:SendSync("SEBroken", "Alliance")
	elseif cid == 35069 then
		self:SendSync("SEBroken", "Horde")	
	end
end

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
