local Arathi	= DBM:NewMod("z529", "DBM-PvP", 2)
local L			= Arathi:GetLocalizedStrings()

Arathi:SetZone(DBM_DISABLE_ZONE_DETECTION)

Arathi:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

local winTimer 		= Arathi:NewTimer(30, "TimerWin", "Interface\\Icons\\INV_Misc_PocketWatch_01")
local capTimer 		= Arathi:NewTimer(63, "TimerCap", "Interface\\Icons\\Spell_Misc_HellifrePVPHonorHoldFavor")

local bgzone = false
Arathi:AddBoolOption("ShowAbEstimatedPoints", true, nil, function()
	if Arathi.Options.ShowAbEstimatedPoints and bgzone then
		Arathi:ShowEstimatedPoints()
	else
		Arathi:HideEstimatedPoints()
	end
end)
Arathi:AddBoolOption("ShowAbBasesToWin", false, nil, function()
	if Arathi.Options.ShowAbBasesToWin and bgzone then
		Arathi:ShowBasesToWin()
	else
		Arathi:HideBasesToWin()
	end
end)

Arathi:RemoveOption("HealthFrame")
Arathi:RemoveOption("SpeedKillTimer")

local ResPerSec = {
	[0] = 1e-300, -- work-around for the divions by zero foo (no, using DOUBLE_MIN is not possible here as it would overflow to infinity which is also an exception)
	[1] = 10/12,
	[2] = 10/9,
	[3] = 10/6,
	[4] = 10/3,
	[5] = 30,
}

local allyColor = {
	r = 0,
	g = 0,
	b = 1,
}
local hordeColor = {
	r = 1,
	g = 0,
	b = 0,
}

local objectives = {
	Farm = 0,
	GoldMine = 0,
	LumberMill = 0,
	Stables = 0,
	Blacksmith = 0,
}
local function getObjectiveType(id)
	if id >=16 and id <=20 then 
		return "GoldMine"
	elseif id >= 21 and id <= 25 then 
		return "LumberMill"
	elseif id >= 26 and id <= 30 then 
		return "Blacksmith"
	elseif id >= 31 and id <= 35 then 
		return "Farm"
	elseif id >= 36 and id <= 40 then 
		return "Stables"
	else 
		return false
	end
end
local function getObjectiveState(id)
	if id == 16 or id == 21 or id == 26 or id == 31 or id == 36 then
		return -1 	-- Neutral
	elseif id == 18 or id == 23 or id == 28 or id == 33 or id == 38 then	
		return 1 	-- Alliance controlled
	elseif id == 20 or id == 25 or id == 30 or id == 35 or id == 40 then
		return 2 	-- Horde controlled
	elseif id == 17 or id == 22 or id == 27 or id == 32 or id == 37 then
		return 3 	-- Alliance assaulted
	elseif id == 19 or id == 24 or id == 29 or id == 34 or id == 39 then
		return 4 	-- Horde assaulted
	else 
		return false
	end
end

local function get_basecount()
	local alliance = 0 
	local horde = 0
	for k,v in pairs(objectives) do
		if v == 18 or v == 23 or v == 28 or v == 33 or v == 38 then 
			alliance = alliance + 1
		elseif v == 20 or v == 25 or v == 30 or v == 35 or v == 40 then 
			horde = horde + 1
		end
	end
	return alliance, horde
end
local function get_score()
	if not bgzone then return 0,0 end
	local AllyScore		= tonumber(string.match((select(4, GetWorldStateUIInfo(1)) or ""), L.ScoreExpr)) or 0
	local HordeScore	= tonumber(string.match((select(4, GetWorldStateUIInfo(2)) or ""), L.ScoreExpr)) or 0
	return AllyScore, HordeScore
end

local get_gametime
local update_gametime
do
	local gametime = 0
	function update_gametime()
		gametime = time()
	end
	function get_gametime()
		local systime = GetBattlefieldInstanceRunTime()
		if systime > 0 then
			return systime / 1000
		else
			return time() - gametime
		end
	end
end

do
	local function AB_Initialize()
		if DBM:GetCurrentArea() == 529 then
			bgzone = true
			Arathi:RegisterShortTermEvents(
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"UPDATE_WORLD_STATES"
			)
			update_gametime()
			for i=1, GetNumMapLandmarks(), 1 do
				local name, _, textureIndex = GetMapLandmarkInfo(i)
				if name and textureIndex then
					local type = getObjectiveType(textureIndex)
					if type then
						objectives[type] = textureIndex
					end
				end
			end

			if Arathi.Options.ShowAbEstimatedPoints then
				Arathi:ShowEstimatedPoints()
			end
			if Arathi.Options.ShowAbBasesToWin then
				Arathi:ShowBasesToWin()
			end

		elseif bgzone then
			bgzone = false
			Arathi:UnregisterShortTermEvents()

			if Arathi.Options.ShowAbEstimatedPoints then
				Arathi:HideEstimatedPoints()
			end
			if Arathi.Options.ShowAbBasesToWin then
				Arathi:HideBasesToWin()
			end
		end
	end
	Arathi.OnInitialize = AB_Initialize
	function Arathi:ZONE_CHANGED_NEW_AREA()
		self:Schedule(1, AB_Initialize)
	end
end

do
	local function check_for_updates()
		if not bgzone then return end
		for i=1, GetNumMapLandmarks(), 1 do
			local name, _, textureIndex = GetMapLandmarkInfo(i)
			if name and textureIndex then
				local type = getObjectiveType(textureIndex)		-- name of the objective without spaces
				local state = getObjectiveState(textureIndex)	-- state of the objective
				if type and state and textureIndex ~= objectives[type] then
					capTimer:Stop(name)
					if state > 2 then
						capTimer:Start(nil, name)
						if state == 3 then
							capTimer:SetColor(allyColor, name)
							capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02.blp", name)
						else
							capTimer:SetColor(hordeColor, name)
							capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01.blp", name)
						end	
					end
					objectives[type] = textureIndex
				end
			end
		end
	end

	local function schedule_check(self)
		self:Schedule(1, check_for_updates)
	end

	Arathi.CHAT_MSG_BG_SYSTEM_ALLIANCE = schedule_check
	Arathi.CHAT_MSG_BG_SYSTEM_HORDE = schedule_check
	Arathi.CHAT_MSG_RAID_BOSS_EMOTE = schedule_check
	Arathi.CHAT_MSG_BG_SYSTEM_NEUTRAL = schedule_check
end

do
	local winner_is = 0		-- 0 = nobody  1 = alliance  2 = horde
	local last_horde_score = 0 
	local last_alliance_score = 0
	local last_horde_bases = 0
	local last_alliance_bases = 0

	function Arathi:UPDATE_WORLD_STATES()
		if not bgzone then return end

		local AllyBases, HordeBases = get_basecount()
		local AllyScore, HordeScore = get_score()
		local callupdate = false

		if AllyScore ~= last_alliance_score then
			last_alliance_score = AllyScore
			if winner_is == 1 then 
				callupdate = true
			end
		elseif HordeScore ~= last_horde_score then
			last_horde_score = HordeScore
			if winner_is == 2 then 
				callupdate = true
			end
		end
		if last_alliance_bases ~= AllyBases then
			last_alliance_bases = AllyBases
			callupdate = true
		end
		if last_horde_bases ~= HordeBases then 
			last_horde_bases = HordeBases
			callupdate = true
		end

		if callupdate or winner_is == 0 then
			self:UpdateWinTimer()
		end
	end
	function Arathi:UpdateWinTimer()
		local AllyTime = (1600 - last_alliance_score) / ResPerSec[last_alliance_bases]
		local HordeTime = (1600 - last_horde_score) / ResPerSec[last_horde_bases]

		if AllyTime > 5000 then		AllyTime = 5000 end
		if HordeTime > 5000 then	HordeTime = 5000 end

		if AllyTime == HordeTime then
			winner_is = 0 
			winTimer:Stop()
			if self.ScoreFrame1Text then
				self.ScoreFrame1Text:SetText("")
				self.ScoreFrame2Text:SetText("")
			end

		elseif AllyTime > HordeTime then -- Horde wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local AllyPoints = math.floor(math.floor(((HordeTime * ResPerSec[last_alliance_bases]) + last_alliance_score) / 10) * 10)
				self.ScoreFrame1Text:SetText("("..AllyPoints..")")
				self.ScoreFrame2Text:SetText("(1600)")
			end

			winner_is = 2
			winTimer:Update(get_gametime(), get_gametime()+HordeTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(L.Horde or FACTION_HORDE))
			winTimer:SetColor(hordeColor)
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01.blp")

		elseif HordeTime > AllyTime then -- Alliance wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local HordePoints = math.floor(math.floor(((AllyTime * ResPerSec[last_horde_bases]) + last_horde_score) / 10) * 10)
				self.ScoreFrame2Text:SetText("("..HordePoints..")")
				self.ScoreFrame1Text:SetText("(1600)")		
			end

			winner_is = 1
			winTimer:Update(get_gametime(), get_gametime()+AllyTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(L.Alliance or FACTION_ALLIANCE))
			winTimer:SetColor(allyColor)
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02.blp")
		end

		if self.Options.ShowAbBasesToWin then
			local FriendlyLast, EnemyLast, FriendlyBases, EnemyBases, baseLowest
			if( UnitFactionGroup("player") == "Alliance" ) then
				FriendlyLast = last_alliance_score
				EnemyLast = last_horde_score
				FriendlyBases = last_alliance_bases
				EnemyBases = last_horde_bases
			else
				FriendlyLast = last_horde_score
				EnemyLast = last_alliance_score
				FriendlyBases = last_horde_bases
				EnemyBases = last_alliance_bases
			end
			if ((1600 - FriendlyLast) / ResPerSec[FriendlyBases]) > ((1600 - EnemyLast) / ResPerSec[EnemyBases]) then
				for i=1, 5 do
					local EnemyTime = (1600 - EnemyLast) / ResPerSec[ 5 - i ]
					local FriendlyTime = (1600 - FriendlyLast) / ResPerSec[ i ]
					if( FriendlyTime < EnemyTime ) then
						baseLowest = FriendlyTime
					else
						baseLowest = EnemyTime
					end
					
					local EnemyFinal = math.floor( ( EnemyLast + math.floor( baseLowest * ResPerSec[ 5 - i ] + 0.5 ) ) / 10 ) * 10
					local FriendlyFinal = math.floor( ( FriendlyLast + math.floor( baseLowest * ResPerSec[ i ] + 0.5 ) ) / 10 ) * 10
					if( FriendlyFinal >= 1600 and EnemyFinal < 1600 ) then
						self.ScoreFrameToWinText:SetText(L.BasesToWin:format(i))
						break
					end
				end
			else
				self.ScoreFrameToWinText:SetText("")
			end
		end
		
	end
end

function Arathi:ShowEstimatedPoints()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrame1 then
			self.ScoreFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1)
			self.ScoreFrame1:SetHeight(10)
			self.ScoreFrame1:SetWidth(100)
			self.ScoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
			self.ScoreFrame1Text = self.ScoreFrame1:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.ScoreFrame1Text:SetAllPoints(self.ScoreFrame1)
			self.ScoreFrame1Text:SetJustifyH("LEFT")
		end
		if not self.ScoreFrame2 then
			self.ScoreFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2)
			self.ScoreFrame2:SetHeight(10)
			self.ScoreFrame2:SetWidth(100)
			self.ScoreFrame2:SetPoint("LEFT", "AlwaysUpFrame2Text", "RIGHT", 4, 0)
			self.ScoreFrame2Text= self.ScoreFrame2:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.ScoreFrame2Text:SetAllPoints(self.ScoreFrame2)
			self.ScoreFrame2Text:SetJustifyH("LEFT")
		end
		self.ScoreFrame1Text:SetText("")
		self.ScoreFrame1:Show()
		self.ScoreFrame2Text:SetText("")
		self.ScoreFrame2:Show()
	end
end

function Arathi:ShowBasesToWin()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrameToWin then
			self.ScoreFrameToWin = CreateFrame("Frame", nil, AlwaysUpFrame2)
			self.ScoreFrameToWin:SetHeight(10)
			self.ScoreFrameToWin:SetWidth(200)
			self.ScoreFrameToWin:SetPoint("TOPLEFT", "AlwaysUpFrame2", "BOTTOMLEFT", 22, 2)
			self.ScoreFrameToWinText= self.ScoreFrameToWin:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.ScoreFrameToWinText:SetAllPoints(self.ScoreFrameToWin)
			self.ScoreFrameToWinText:SetJustifyH("LEFT")
		end
		self.ScoreFrameToWinText:SetText("")
		self.ScoreFrameToWin:Show()
	end
end

function Arathi:HideEstimatedPoints()
	if self.ScoreFrame1 and self.ScoreFrame2 then
		self.ScoreFrame1:Hide()
		self.ScoreFrame1Text:SetText("")
		self.ScoreFrame2:Hide()
		self.ScoreFrame2Text:SetText("")
	end
end

function Arathi:HideBasesToWin()
	if self.ScoreFrameToWin then
		self.ScoreFrameToWin:Hide()
		self.ScoreFrameToWinText:SetText("")
	end
end
