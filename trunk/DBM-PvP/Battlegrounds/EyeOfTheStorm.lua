-- EyeOfTheStorm mod v3.0
-- rewrite by Nitram and Tandanu
--
-- thanks DiabloHu

local EyeOfTheStorm	= DBM:NewMod("z566", "DBM-PvP", 2)
local L				= EyeOfTheStorm:GetLocalizedStrings()

EyeOfTheStorm:RemoveOption("HealthFrame")
EyeOfTheStorm:RemoveOption("SpeedKillTimer")
EyeOfTheStorm:SetZone(DBM_DISABLE_ZONE_DETECTION)

EyeOfTheStorm:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

local bgzone = false
local ResPerSec = {
	[0] = 1e-300, -- blah
	[1] = 0.5,
	[2] = 1,
	[3] = 2.5,
	[4] = 5,
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

EyeOfTheStorm:AddBoolOption("ShowPointFrame", true, nil, function()
	if EyeOfTheStorm.Options.ShowPointFrame and bgzone then
		EyeOfTheStorm:ShowEstimatedPoints()
	else
		EyeOfTheStorm:HideEstimatedPoints()
	end
end)

local winTimer = EyeOfTheStorm:NewTimer(30, "TimerWin", "Interface\\Icons\\INV_Misc_PocketWatch_01")
local flagTimer = EyeOfTheStorm:NewTimer(7, "TimerFlag", "Interface\\Icons\\INV_Banner_02")

local objectives = {
	[1] = 6,	-- Blood Elf
	[2] = 6,	-- Draenai
	[3] = 6,	-- Fel Reaver
	[4] = 6,	-- Mage
	[5] = 45	-- Flag
}

local function isFlag(id)
	return id == 45 or id == 44 or id ==43
end

local function isTower(id)
	return id == 6 or id == 10 or id == 11
end

local function getBasecount()
	local alliance = 0 
	local horde = 0
	for k,v in pairs(objectives) do
		if v == 11 then 
			alliance = alliance + 1
		elseif v == 10 then 
			horde = horde + 1
		end
	end
	return alliance, horde
end

local function getScore()
	if not bgzone then
		return 0, 0
	end
	local allyScore	= tonumber(string.match((select(4, GetWorldStateUIInfo(2)) or ""), L.ScoreExpr)) or 0
	local hordeScore = tonumber(string.match((select(4, GetWorldStateUIInfo(3)) or ""), L.ScoreExpr)) or 0
	return allyScore, hordeScore
end


local getGametime
local updateGametime
do
	local gametime = 0
	function updateGametime()
		gametime = time()
	end
	function getGametime()
		local systime = GetBattlefieldInstanceRunTime()
		if systime > 0 then
			return systime / 1000
		else
			return time() - gametime
		end
	end
end

do
	local function initialize()
		if DBM:GetCurrentArea() == 482 then
			bgzone = true
			EyeOfTheStorm:RegisterShortTermEvents(
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"UPDATE_WORLD_STATES"
			)
			updateGametime()
			for i=1, GetNumMapLandmarks(), 1 do
				local name, _, textureIndex = GetMapLandmarkInfo(i)
				if name and textureIndex then
					if isTower(textureIndex) or isFlag(textureIndex) then
						objectives[i] = textureIndex
					end
				end
			end
			if EyeOfTheStorm.Options.ShowPointFrame then
				EyeOfTheStorm:ShowEstimatedPoints()
			end

		elseif bgzone then
			bgzone = false
			EyeOfTheStorm:UnregisterShortTermEvents()
			if EyeOfTheStorm.Options.ShowPointFrame then
				EyeOfTheStorm:HideEstimatedPoints()
			end
		end
	end
	EyeOfTheStorm.OnInitialize = EyeOfTheStorm:Schedule(3, initialize)
	EyeOfTheStorm.ZONE_CHANGED_NEW_AREA = EyeOfTheStorm:Schedule(3, initialize)
end

do
	local function checkForUpdates()
		if not bgzone then
			return
		end
		for i = 1, GetNumMapLandmarks() do
			local name, _, textureIndex = GetMapLandmarkInfo(i)
			if name and textureIndex then
				if isTower(textureIndex) or isFlag(textureIndex) then
					objectives[i] = textureIndex
				end
			end
		end
		EyeOfTheStorm:UPDATE_WORLD_STATES()
	end
	
	local function scheduleCheck(self)
		self:Schedule(1, checkForUpdates)
	end

	function EyeOfTheStorm:CHAT_MSG_BG_SYSTEM_ALLIANCE(arg1)
		if EyeOfTheStorm.Options.ShowPointFrame then
			if string.match(arg1, L.FlagTaken) then
				local name = string.match(arg1, L.FlagTaken)
				if name then
					self.AllyFlag = name
					self.HordeFlag = nil
					self:UpdateFlagDisplay()
				end
	
			elseif string.match(arg1, L.FlagDropped) then
				self.AllyFlag = nil
				self.HordeFlag = nil
				self:UpdateFlagDisplay()
	
			elseif string.match(arg1, L.FlagCaptured) then
				flagTimer:Start()
				self.AllyFlag = nil
				self.HordeFlag = nil
				self:UpdateFlagDisplay()
			end
		end
		scheduleCheck(self)
	end

	function EyeOfTheStorm:CHAT_MSG_BG_SYSTEM_HORDE(arg1)
		if EyeOfTheStorm.Options.ShowPointFrame then
			if string.match(arg1, L.FlagTaken) then
				local name = string.match(arg1, L.FlagTaken)
				if name then
					self.AllyFlag = nil
					self.HordeFlag = name
					self:UpdateFlagDisplay()
				end
	
			elseif string.match(arg1, L.FlagDropped) then
				self.AllyFlag = nil
				self.HordeFlag = nil
				self:UpdateFlagDisplay()
	
			elseif string.match(arg1, L.FlagCaptured) then
				flagTimer:Start()
				self.AllyFlag = nil
				self.HordeFlag = nil
				self:UpdateFlagDisplay()
			end
		end
		scheduleCheck(self)
	end

	function EyeOfTheStorm:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
		if not bgzone then
			return
		end

		if string.match(arg1, L.FlagReset) then
			EyeOfTheStorm.AllyFlag = nil
			EyeOfTheStorm.HordeFlag = nil
			EyeOfTheStorm:UpdateFlagDisplay()
		end
		scheduleCheck(self)
	end	
end


function EyeOfTheStorm:UPDATE_WORLD_STATES()
	if not bgzone then return end

	local last_alliance_bases, last_horde_bases = getBasecount()
	local last_alliance_score, last_horde_score = getScore()

	-- calculate new times
	local AllyTime = (1600 - last_alliance_score) / ResPerSec[last_alliance_bases]
	local HordeTime = (1600 - last_horde_score) / ResPerSec[last_horde_bases]
	
	if AllyTime > 5000 then		AllyTime = 5000 end
	if HordeTime > 5000 then	HordeTime = 5000 end

	if AllyTime == HordeTime then
		winTimer:Stop()
		if self.ScoreFrame1Text then
			self.ScoreFrame1Text:SetText("")
			self.ScoreFrame2Text:SetText("")
		end
		
	elseif AllyTime > HordeTime then -- Horde wins
		winTimer:Update(getGametime(), getGametime()+HordeTime)
		winTimer:DisableEnlarge()
		winTimer:UpdateName(L.WinBarText:format(L.Horde or FACTION_HORDE))
		winTimer:SetColor(hordeColor)

		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local AllyPoints = math.floor((HordeTime * ResPerSec[last_alliance_bases]) + last_alliance_score)
			self.ScoreFrame1Text:SetText("("..AllyPoints..")")
			self.ScoreFrame2Text:SetText("(1600)")
			self:UpdateFlagDisplay()
		end

	elseif HordeTime > AllyTime then -- Alliance wins
		winTimer:Update(getGametime(), getGametime()+AllyTime)
		winTimer:DisableEnlarge()
		winTimer:UpdateName(L.WinBarText:format(L.Alliance or FACTION_ALLIANCE))
		winTimer:SetColor(allyColor)

		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local HordePoints = math.floor((HordeTime * ResPerSec[last_horde_bases]) + last_horde_score)
			self.ScoreFrame1Text:SetText("(1600)")
			self.ScoreFrame2Text:SetText("("..HordePoints..")")
			self:UpdateFlagDisplay()
		end		
	end
end

function EyeOfTheStorm:UpdateFlagDisplay()
	if self.ScoreFrame1Text and self.ScoreFrame2Text then
		
		local newText
		local oldText = self.ScoreFrame1Text:GetText()
		if self.AllyFlag then
			if not oldText or oldText == "" then
				newText = "Flag: "..self.AllyFlag
			else
				newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)  "..L.Flag..": "..self.AllyFlag)
			end
		elseif oldText and oldText ~= "" then
			newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)")
		end
		self.ScoreFrame1Text:SetText(newText)
		
		newText = nil
		oldText = self.ScoreFrame2Text:GetText()
		if self.HordeFlag then
			if not oldText or oldText == "" then
				newText = "Flag: "..self.HordeFlag
			else
				newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)  "..L.Flag..": "..self.HordeFlag)
			end
		elseif oldText and oldText ~= "" then
			newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)")
		end
		self.ScoreFrame2Text:SetText(newText)
		
	end
end

function EyeOfTheStorm:ShowEstimatedPoints()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrame1 then
			self.ScoreFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1)
			self.ScoreFrame1:SetHeight(10)
			self.ScoreFrame1:SetWidth(200)
			self.ScoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
			self.ScoreFrame1Text = self.ScoreFrame1:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.ScoreFrame1Text:SetAllPoints(self.ScoreFrame1)
			self.ScoreFrame1Text:SetJustifyH("LEFT")
		end
		if not self.ScoreFrame2 then
			self.ScoreFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2)
			self.ScoreFrame2:SetHeight(10)
			self.ScoreFrame2:SetWidth(200)
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

function EyeOfTheStorm:HideEstimatedPoints()
	if self.ScoreFrame1 and self.ScoreFrame2 then
		self.ScoreFrame1:Hide()
		self.ScoreFrame1Text:SetText("")
		self.ScoreFrame2:Hide()
		self.ScoreFrame2Text:SetText("")
	end
end
