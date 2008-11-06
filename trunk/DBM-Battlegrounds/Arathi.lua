-- 31/7/2007 2.1: added "Bases to win" frame by Diablohu

local Arathi = DBM:NewMod("Arathi", "DBM-Battlegrounds")


Arathi:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
)
	

Arathi.ResPerSec = {
	[0] = 0,
	[1] = 10/12,
	[2] = 10/9,
	[3] = 10/6,
	[4] = 10/3,
	[5] = 30,
}

local lastTick = {
	LastAllyCount	= 0,
	LastHordeCount	= 0,
	Time = 0,
	Alliance = {
		Score	= 0,
		Time	= 0,
		Bases	= 0,
	},
	Horde = {
		Score	= 0,
		Time	= 0,
		Bases	= 0,
	},
}

Arathi:AddBoolOption("ShowAbFrame", true, "general", function()
	if Arathi.Options.ShowAbFrame and GetRealZoneText() == DBM_BGMOD_LANG["AB_ZONE"] then
		Arathi:ShowEstimatedPoints()
		Arathi:UpdateTimer()
	else
		Arathi:HideEstimatedPoints()
	end
end)

Arathi:AddBoolOption("ShowAbBasesToWin", false, "general", function()
	if Arathi.Options.ShowAbFrame and GetRealZoneText() == DBM_BGMOD_LANG["AB_ZONE"] then
		Arathi:ShowBasesToWin()
		Arathi:UpdateTimer()
	else
		Arathi:HideBasesToWin()
	end
end)

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

local startTimer = Arathi:NewTimer(62, "TimerStart")
local winTimer = Arathi:NewTimer(30, "TimerWin")
local capTimer = Arathi:NewTimer(64, "TimerCap")

function Arathi:GetScore()
	if GetRealZoneText() == DBM_BGMOD_LANG["AB_ZONE"] then
		local _, _, mAllyInfo	= GetWorldStateUIInfo(1)
		local _, _, mHordeInfo	= GetWorldStateUIInfo(2)
		if not mAllyInfo or not mHordeInfo then
			return false
		end

		local _, _, AllyBases, AllyScore	= string.find(mAllyInfo, DBM_BGMOD_LANG.AB_SCOREEXP)
		local _, _, HordeBases, HordeScore	= string.find(mHordeInfo, DBM_BGMOD_LANG.AB_SCOREEXP)
		AllyBases	= tonumber(AllyBases)
		AllyScore	= tonumber(AllyScore)
		HordeBases	= tonumber(HordeBases)
		HordeScore	= tonumber(HordeScore)
		if not AllyBases or not AllyScore or not HordeBases or not HordeScore then
			return false
		end
	
		return true, AllyBases, AllyScore, HordeBases, HordeScore
	else
		return false
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

Arathi:RegisterOnUpdateHandler(function(self, elapsed)
	if GetRealZoneText() == DBM_BGMOD_LANG["AB_ZONE"] then
		local mOk, AllyBases, AllyScore, HordeBases, HordeScore = self:GetScore()
		if not mOk then
			return
		end
		
		lastTick.Alliance.Score = AllyScore
		lastTick.Alliance.Bases = AllyBases
		
		lastTick.Horde.Score = HordeScore
		lastTick.Horde.Bases = HordeBases
		
		lastTick.Time = GetTime()
		
		if lastTick.Alliance.Score < 2000 
		and lastTick.Horde.Score < 2000
		and (lastTick.Alliance.Score + lastTick.Horde.Score) > 0
		and (lastTick.Alliance.Bases + lastTick.Horde.Bases) > 0
		and (lastTick.LastAllyCount ~= lastTick.Alliance.Bases or lastTick.LastHordeCount ~= lastTick.Horde.Bases) then
			self:UpdateTimer()
		end

		if self.Options.ShowAbBasesToWin then
			local FriendlyLast, EnemyLast, FriendlyBases, EnemyBases, baseLowest;
			if( UnitFactionGroup( "player" ) == "Alliance" ) then
				FriendlyLast = lastTick.Alliance.Score
				EnemyLast = lastTick.Horde.Score
				FriendlyBases = lastTick.Alliance.Bases
				EnemyBases = lastTick.Horde.Bases
			else
				FriendlyLast = lastTick.Horde.Score
				EnemyLast = lastTick.Alliance.Score
				FriendlyBases = lastTick.Horde.Bases
				EnemyBases = lastTick.Alliance.Bases
			end
			if ((2000 - FriendlyLast) / self.ResPerSec[FriendlyBases]) > ((2000 - EnemyLast) / self.ResPerSec[EnemyBases]) then
				for i=1, 5 do
					local EnemyTime = (2000 - EnemyLast) / self.ResPerSec[ 5 - i ]
					local FriendlyTime = (2000 - FriendlyLast) / self.ResPerSec[ i ]
					if( FriendlyTime < EnemyTime ) then
						baseLowest = FriendlyTime
					else
						baseLowest = EnemyTime
					end
					
					local EnemyFinal = math.floor( ( EnemyLast + math.floor( baseLowest * self.ResPerSec[ 5 - i ] + 0.5 ) ) / 10 ) * 10
					local FriendlyFinal = math.floor( ( FriendlyLast + math.floor( baseLowest * self.ResPerSec[ i ] + 0.5 ) ) / 10 ) * 10
					if( FriendlyFinal >= 2000 and EnemyFinal < 2000 ) then
						self.ScoreFrameToWinText:SetText(DBM_BGMOD_LANG.AB_BASESTOWIN_TEXT..i)
						break
					end
				end
			else
				self.ScoreFrameToWinText:SetText("")
			end
		end
	else --not in Arathi, end timers
		-- todo
	end
end, 0.5)

function Arathi:ZONE_CHANGED_NEW_AREA(arg1)
	if GetRealZoneText() == DBM_BGMOD_LANG["AB_ZONE"] and self.Options.ShowAbFrame then
		self:ShowEstimatedPoints()
		self:ShowBasesToWin()
	elseif GetRealZoneText() ~= DBM_BGMOD_LANG["AB_ZONE"] then
		self:HideEstimatedPoints()
		self:HideBasesToWin()
	end
end
Arathi.PLAYER_ENTER_WORLD = Arathi.ZONE_CHANGED_NEW_AREA

function Arathi:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if arg1 == DBM_BGMOD_LANG.AB_START60SEC then
		self:SendSync("Start60")
	elseif arg1 == DBM_BGMOD_LANG.AB_START30SEC then		
		self:SendSync("Start30")
	end
end

	
function Arathi:UpdateTimer(arg1)
	local AllyTime = ((2000 - lastTick.Alliance.Score) / self.ResPerSec[lastTick.Alliance.Bases]) - (GetTime() - lastTick.Time) -- possible division through zero, but that's no problem: 1/0 = 1.#INF and these timers are capped @ 5000
	local HordeTime = ((2000 - lastTick.Horde.Score) / self.ResPerSec[lastTick.Horde.Bases]) - (GetTime() - lastTick.Time)
	if AllyTime > 5000 then		AllyTime = 5000 end
	if HordeTime > 5000 then	HordeTime = 5000 end
	
	lastTick.LastAllyCount	= lastTick.Alliance.Bases;
	lastTick.LastHordeCount = lastTick.Horde.Bases
	
	if winTimer:GetTime(DBM_BGMOD_LANG["ALLIANCE"]) ~= 0 and winTimer:GetTime(DBM_BGMOD_LANG["HORDE"]) ~= 0 then
		winTimer:Stop()
	end		
	
	if AllyTime == HordeTime then -- draw
		winTimer:Stop()
		self.ScoreFrame1Text:SetText("")
		self.ScoreFrame2Text:SetText("")
	
	elseif AllyTime > HordeTime then -- Horde wins
		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local AllyPoints = math.floor(math.floor(((HordeTime * self.ResPerSec[lastTick.Alliance.Bases]) + lastTick.Alliance.Score) / 10) * 10)
			self.ScoreFrame1Text:SetText("("..AllyPoints..")")
			self.ScoreFrame2Text:SetText("(2000)")
		end
		
		if winTimer:GetTime(DBM_BGMOD_LANG["ALLIANCE"]) ~= 0 then
			winTimer:Stop()
			winTimer:Start(HordeTime, DBM_BGMOD_LANG["HORDE"])
			winTimer:SetColor(hordeColor)
			winTimer:UpdateIcon() -- TODO: ICON

		elseif winTimer:GetTime(DBM_BGMOD_LANG["HORDE"]) ~= 0 then
			local timeLeft, timeElapsed = winTimer:GetTime(DBM_BGMOD_LANG["HORDE"])
			winTimer:Update(0, (timeElapsed + HordeTime))

		else
			winTimer:Start(HordeTime, DBM_BGMOD_LANG["HORDE"])
		end
		
	elseif HordeTime > AllyTime then -- Alliance wins
		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local HordePoints = math.floor(math.floor(((AllyTime * self.ResPerSec[lastTick.Horde.Bases]) + lastTick.Horde.Score) / 10) * 10)
			self.ScoreFrame2Text:SetText("("..HordePoints..")")
			self.ScoreFrame1Text:SetText("(2000)")		
		end
		
		if( winTimer:GetTime("AB_WINHORDE") ) then
			winTimer:Stop()
			winTimer:Start(AllyTime, DBM_BGMOD_LANG["ALLIANCE"])
			winTimer:SetColor(hordeColor)
			winTimer:UpdateIcon() -- TODO: ICON

		elseif( winTimer:GetTime("AB_WINALLY") ) then
			local timeLeft, timeElapsed = winTimer:GetTime(DBM_BGMOD_LANG["ALLIANCE"])
			winTimer:Update(0, (timeElapsed + AllyTime))
		else
			winTimer:Start(HordeTime, DBM_BGMOD_LANG["ALLIANCE"])
		end
	end
end
		
function Arathi:CHAT_MSG_BG_SYSTEM_ALLIANCE(arg1)
	for index, value in ipairs(DBM_BGMOD_LANG.AB_TARGETS) do
		if string.find(arg1, value) then
			if string.find(arg1, DBM_BGMOD_LANG.AB_HASASSAULTED) or string.find(arg1, DBM_BGMOD_LANG.AB_CLAIMSTHE) then
				self:SendSync("CA", index)
			elseif string.find(arg1, DBM_BGMOD_LANG.AB_HASDEFENDEDTHE) or string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
--				if string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
--					if DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE and DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index] then
--						self:Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index]));
--					else
--						self:Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, DBM.Capitalize(DBM_BGMOD_LANG.AB_TARGETS[index])));
--					end
--					local oldFlashColor = DBM.Options.FlashColor;
--					DBM.Options.FlashColor = "blue";
--					self:AddSpecialWarning("", true);
--					DBM.Options.FlashColor = oldFlashColor;
--				end
				self:SendSync("DT", index)
			end
		end
	end
end
		
function Arathi:CHAT_MSG_BG_SYSTEM_HORDE(arg1)
	for index, value in ipairs(DBM_BGMOD_LANG.AB_TARGETS) do
		if string.find(arg1, value) then
			if string.find(arg1, DBM_BGMOD_LANG.AB_HASASSAULTED) or string.find(arg1, DBM_BGMOD_LANG.AB_CLAIMSTHE) then
				self:SendSync("CH", index)
			elseif string.find(arg1, DBM_BGMOD_LANG.AB_HASDEFENDEDTHE) or string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
--				if string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
--					if DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE and DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index] then
--						self:Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index]))
--					else
--						self:Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, DBM.Capitalize(DBM_BGMOD_LANG.AB_TARGETS[index])))
--					end
--					local oldFlashColor = DBM.Options.FlashColor
--					DBM.Options.FlashColor = "red"
--					self:AddSpecialWarning("", true)
--					DBM.Options.FlashColor = oldFlashColor
--				end
				self:SendSync("DT", index)
			end
		end
	end
end

function Arathi:OnSync(msg)
	if msg == "Start60" then
		startTimer:Start()
	elseif msg == "Start30" then
		if startTimer:GetTime() == 0 then
			startTimer:Start()
		end
		startTimer:Update(31, 62)
	elseif msg:sub(0, 2) == "CA" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AB_TARGETS"][msg] then
			self:EndStatusBarTimer(DBM.Capitalize(DBM_BGMOD_LANG["AB_TARGETS"][msg]), true)
			self:StartStatusBarTimer(64, DBM.Capitalize(DBM_BGMOD_LANG["AB_TARGETS"][msg]), "Interface\\Icons\\INV_BannerPVP_02.blp", true, nil, 0, 0, 1)
		end
	elseif msg:sub(0, 2) == "CH" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AB_TARGETS"][msg] then
			self:EndStatusBarTimer(DBM.Capitalize(DBM_BGMOD_LANG["AB_TARGETS"][msg]), true)
			self:StartStatusBarTimer(64, DBM.Capitalize(DBM_BGMOD_LANG["AB_TARGETS"][msg]), "Interface\\Icons\\INV_BannerPVP_01.blp", true, nil, 1, 0, 0)
		end
	elseif msg:sub(0, 2) == "DT" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AB_TARGETS"][msg] then
			self:EndStatusBarTimer(DBM.Capitalize(DBM_BGMOD_LANG["AB_TARGETS"][msg]), true)
		end
	end
end
