local Kotmogu	= DBM:NewMod("Kotmogu", "DBM-PvP", 2)
local L			= Kotmogu:GetLocalizedStrings()

Kotmogu:SetZone(DBM_DISABLE_ZONE_DETECTION)

Kotmogu:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_WORLD_STATES"
)

local winTimer 		= Kotmogu:NewTimer(30, "TimerWin", "Interface\\Icons\\INV_Misc_PocketWatch_01")

local bgzone = false
local orbs = {}
Kotmogu:AddBoolOption("ShowKotmoguEstimatedPoints", true, nil, function()
	if Kotmogu.Options.ShowKotmoguEstimatedPoints and bgzone then
		Kotmogu:ShowEstimatedPoints()
	else
		Kotmogu:HideEstimatedPoints()
	end
end)
Kotmogu:AddBoolOption("ShowKotmoguOrbsToWin", false, nil, function()
	if Kotmogu.Options.ShowKotmoguOrbsToWin and bgzone then
		Kotmogu:ShowOrbsToWin()
	else
		Kotmogu:HideOrbsToWin()
	end
end)

Kotmogu:RemoveOption("HealthFrame")
Kotmogu:RemoveOption("SpeedKillTimer")

local ResPerSec = {
	[0] = 1e-300,
	[1] = 4.5/5,
	[2] = 9/5,
	[3] = 13.5/5,
	[4] = 18/5
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

local function AddOrb(color, name, faction)
	local exists = false
	for i,v in ipairs(orbs) do
		if v["color"] == color then
			exists = true
			v["name"] = name
			v["faction"] = faction
		end
	end
	if not exists then
		table.insert(orbs, {["color"] = color, ["name"] = name, ["faction"] = faction})
	end
end

local function RemoveOrb(color)
	for i,v in ipairs(orbs) do
		if v["color"] == color then
			table.remove(orbs, i)
			break
		end
	end
end

local function GetNumOrbs()
	local horde = 0
	local alliance = 0
	for i,v in ipairs(orbs) do
		if v["faction"] == "Alliance" then
			alliance = alliance + 1
		elseif v["faction"] == "Horde" then
			horde = horde + 1
		end
	end
	return alliance, horde, #orbs
end

local function GetScore()
	if not bgzone then return 0,0 end
	local alliance = tonumber(string.match((select(4, GetWorldStateUIInfo(1)) or ""), L.ScoreExpr)) or 0
	local horde = tonumber(string.match((select(4, GetWorldStateUIInfo(2)) or ""), L.ScoreExpr)) or 0
	return alliance, horde
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

function Kotmogu:OnInitialize()
	if select(2, IsInInstance()) == "pvp" and GetCurrentMapAreaID() == 856 then
		bgzone = true
		table.wipe(orbs)
		update_gametime()
		if Kotmogu.Options.ShowKotmoguEstimatedPoints then
			Kotmogu:ShowEstimatedPoints()
		end
		if Kotmogu.Options.ShowKotmoguOrbsToWin then
			Kotmogu:ShowOrbsToWin()
		end
	else
		bgzone = false
		table.wipe(orbs)
		winTimer:Stop()

		if Kotmogu.Options.ShowKotmoguEstimatedPoints then
			Kotmogu:HideEstimatedPoints()
		end
		if Kotmogu.Options.ShowKotmoguOrbsToWin then
			Kotmogu:HideOrbsToWin()
		end
	end
end
Kotmogu.ZONE_CHANGED_NEW_AREA = Kotmogu.OnInitialize

function Kotmogu:CHAT_MSG_BG_SYSTEM_ALLIANCE(msg)
	if not bgzone then return end
	local name, color = msg:match(L.OrbTaken)
	AddOrb(color, name, "Alliance")
end

function Kotmogu:CHAT_MSG_BG_SYSTEM_HORDE(msg)
	if not bgzone then return end
	local name, color = msg:match(L.OrbTaken)
	AddOrb(color, name, "Horde")
end

function Kotmogu:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if not bgzone then return end
	if msg==L.OrbReturn or msg:find(L.OrbReturn) then
		local color = msg:match(L.OrbReturn)
		RemoveOrb(color)
	end
end
Kotmogu.CHAT_MSG_RAID_BOSS_EMOTE = Kotmogu.CHAT_MSG_BG_SYSTEM_NEUTRAL


do
	local winner_is = 0		-- 0 = none, 1 = alliance, 2 = horde
	local last_horde_score = 0
	local last_alliance_score= 0
	local last_horde_orbs = 0
	local last_alliance_orbs= 0

	function Kotmogu:UPDATE_WORLD_STATES()
		if not bgzone then return end
	
		local AllyOrbs, HordeOrbs, TotalOrbs = GetNumOrbs()
		local AllyScore, HordeScore = GetScore()
		local callUpdate = false

		if AllyScore ~= last_alliance_score then
			last_alliance_score = AllyScore
			if winner_is == 1 then
				callUpdate = true
			end
		elseif HordeScore ~= last_horde_score then
			last_horde_score = HordeScore
			if winner_is == 2 then
				callUpdate = true
			end
		end

		if AllyOrbs ~= last_alliance_orbs then
			last_alliance_orbs= AllyOrbs
			callUpdate = true
		end

		if HordeOrbs ~= last_horde_orbs then
			last_horde_orbs = HordeOrbs
			callUpdate = true
		end

		if callUpdate or winner_is == 0 then
			self:UpdateWinTimer()
		end
		
	end

	function Kotmogu:UpdateWinTimer()
		local AllyTime = (1600 - last_alliance_score) / ResPerSec[last_alliance_orbs]
		local HordeTime = (1600 - last_horde_score) / ResPerSec[last_horde_orbs]
		
		if AllyTime > 5000 then AllyTime = 5000 end
		if HordeTime > 5000 then HordeTime = 5000 end
				
		if AllyTime == HordeTime then	-- no winner
			winner_is = 0
			winTimer:Stop()
			if self.ScoreFrame1Text then
				self.ScoreFrame1Text:SetText("")
				self.ScoreFrame2Text:SetText("")
			end
		
		elseif AllyTime > HordeTime then	-- Horde wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local AllyPoints = math.floor(math.floor(((HordeTime * ResPerSec[last_alliance_orbs]) + last_alliance_score) / 10) * 10)
				self.ScoreFrame1Text:SetText("("..AllyPoints..")")
				self.ScoreFrame2Text:SetText("(1600)")
			end

			winner_is = 2
			winTimer:Update(get_gametime(), get_gametime()+HordeTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(L.Horde))
			winTimer:SetColor(hordeColor)
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01.blp")

		elseif HordeTime > AllyTime then 	-- Alliance wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local HordePoints = math.floor(math.floor(((AllyTime * ResPerSec[last_horde_orbs]) + last_horde_score) / 10) * 10)
				self.ScoreFrame2Text:SetText("("..HordePoints..")")
				self.ScoreFrame1Text:SetText("(1600)")		
			end

			winner_is = 1
			winTimer:Update(get_gametime(), get_gametime()+AllyTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(L.Alliance))
			winTimer:SetColor(allyColor)
			winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02.blp")
		end

		if self.Options.ShowKotmoguOrbsToWin then
			local FriendlyLast, EnemyLast, FriendlyOrbs, EnemyOrbs, baseLowest
			if( UnitFactionGroup("player") == "Alliance" ) then
				FriendlyLast = last_alliance_score
				EnemyLast = last_horde_score
				FriendlyOrbs = last_alliance_orbs
				EnemyOrbs = last_horde_orbs
			else
				FriendlyLast = last_horde_score
				EnemyLast = last_alliance_score
				FriendlyOrbs = last_horde_orbs
				EnemyOrbs = last_alliance_orbs
			end
			if ((1600 - FriendlyLast) / ResPerSec[FriendlyOrbs]) > ((1600 - EnemyLast) / ResPerSec[EnemyOrbs]) then
				for i=1, 4 do
					local EnemyTime = (1600 - EnemyLast) / ResPerSec[ 4 - i ]
					local FriendlyTime = (1600 - FriendlyLast) / ResPerSec[ i ]
					if( FriendlyTime < EnemyTime ) then
						baseLowest = FriendlyTime
					else
						baseLowest = EnemyTime
					end
					
					local EnemyFinal = math.floor( ( EnemyLast + math.floor( baseLowest * ResPerSec[ 5 - i ] + 0.5 ) ) / 10 ) * 10
					local FriendlyFinal = math.floor( ( FriendlyLast + math.floor( baseLowest * ResPerSec[ i ] + 0.5 ) ) / 10 ) * 10
					if( FriendlyFinal >= 1600 and EnemyFinal < 1600 ) then
						self.ScoreFrameToWinText:SetText(L.OrbsToWin:format(i))
						break
					end
				end
			else
				self.ScoreFrameToWinText:SetText("")
			end
		end
	end
end

function Kotmogu:ShowEstimatedPoints()
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

function Kotmogu:ShowOrbsToWin()
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

function Kotmogu:HideEstimatedPoints()
	if self.ScoreFrame1 and self.ScoreFrame2 then
		self.ScoreFrame1:Hide()
		self.ScoreFrame1Text:SetText("")
		self.ScoreFrame2:Hide()
		self.ScoreFrame2Text:SetText("")
	end
end

function Kotmogu:HideOrbsToWin()
	if self.ScoreFrameToWin then
		self.ScoreFrameToWin:Hide()
		self.ScoreFrameToWinText:SetText("")
	end
end