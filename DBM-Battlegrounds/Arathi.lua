-- 31/7/2007 2.1: added "Bases to win" frame by Diablohu

local Arathi = DBM:NewBossMod("Arathi", DBM_ARATHI, DBM_BGMOD_LANG["AB_DESCRIPTION"], DBM_OTHER, "Battlegrounds", 2);

Arathi.Version = "2.1";
Arathi.Author = "LeoLeal, Nitram, Tandanu";
Arathi.ExtraGUITab	= "BC Battlegrounds";
Arathi.MinRevision = 862;

Arathi:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
);
	

Arathi.ResPerSec = {
	[0] = 0,
	[1] = 10/12,
	[2] = 10/9,
	[3] = 10/6,
	[4] = 10/3,
	[5] = 30,
};

Arathi.LastTick = {
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
};

Arathi.DropdownMenu = { --I don't use :AddOption() here, because I want to use the battleground boss mod's options table
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ShowInviteTimer", 
		text = DBM_BGMOD_LANG.SHOW_INV_TIMER, 
		func = function() DBM.AddOns.Battlegrounds.Options.ShowInviteTimer = not DBM.AddOns.Battlegrounds.Options.ShowInviteTimer; end, 
	},
	
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ColorByClass", 
		text = DBM_BGMOD_LANG.COLOR_BY_CLASS, 
		func = function() DBM.AddOns.Battlegrounds.Options.ColorByClass = not DBM.AddOns.Battlegrounds.Options.ColorByClass; end, 
	},
	
	{
		variable = "DBM.AddOns.Battlegrounds.Options.AutoSpirit", 
		text = DBM_BGMOD_OPTION_AUTOSPIRIT, 
		func = function() DBM.AddOns.Battlegrounds.Options.AutoSpirit = not DBM.AddOns.Battlegrounds.Options.AutoSpirit end, 
	},
};

Arathi:AddOption("ShowAbFrame", true, DBM_BGMOD_LANG.AB_INFOFRAME_INFO, function()
	Arathi.Options.ShowAbFrame = not Arathi.Options.ShowAbFrame;
	if Arathi.Options.ShowAbFrame and GetRealZoneText() == DBM_ARATHI then
		Arathi:ShowEstimatedPoints();
		Arathi:OnEvent("UpdateTimer");
	else
		Arathi:HideEstimatedPoints();
	end
end);

Arathi:AddOption("ShowAbBasesToWin", false, DBM_BGMOD_LANG.AB_BASESTOWIN_INFO, function()
	Arathi.Options.ShowAbBasesToWin = not Arathi.Options.ShowAbBasesToWin;
	if Arathi.Options.ShowAbFrame and GetRealZoneText() == DBM_ARATHI then
		Arathi:ShowBasesToWin();
		Arathi:OnEvent("UpdateTimer");
	else
		Arathi:HideBasesToWin();
	end
end);


function Arathi:GetScore()
	if GetRealZoneText() == DBM_ARATHI then
		local _, _, mAllyInfo	= GetWorldStateUIInfo(1);
		local _, _, mHordeInfo	= GetWorldStateUIInfo(2);
		if not mAllyInfo or not mHordeInfo then
			return false;
		end

		local _, _, AllyBases, AllyScore	= string.find(mAllyInfo, DBM_BGMOD_LANG.AB_SCOREEXP);
		local _, _, HordeBases, HordeScore	= string.find(mHordeInfo, DBM_BGMOD_LANG.AB_SCOREEXP);
		AllyBases	= tonumber(AllyBases);
		AllyScore	= tonumber(AllyScore);
		HordeBases	= tonumber(HordeBases);
		HordeScore	= tonumber(HordeScore);
		if not AllyBases or not AllyScore or not HordeBases or not HordeScore then
			return false;
		end
	
		return true, AllyBases, AllyScore, HordeBases, HordeScore;
	else
		return false;
	end
end

function Arathi:ShowEstimatedPoints()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrame1 then
			self.ScoreFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1);
			self.ScoreFrame1:SetHeight(10);
			self.ScoreFrame1:SetWidth(100);
			self.ScoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
			self.ScoreFrame1Text = self.ScoreFrame1:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.ScoreFrame1Text:SetAllPoints(self.ScoreFrame1);
			self.ScoreFrame1Text:SetJustifyH("LEFT");
		end
		if not self.ScoreFrame2 then
			self.ScoreFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2);
			self.ScoreFrame2:SetHeight(10);
			self.ScoreFrame2:SetWidth(100);
			self.ScoreFrame2:SetPoint("LEFT", "AlwaysUpFrame2Text", "RIGHT", 4, 0)
			self.ScoreFrame2Text= self.ScoreFrame2:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.ScoreFrame2Text:SetAllPoints(self.ScoreFrame2);
			self.ScoreFrame2Text:SetJustifyH("LEFT");
		end
		self.ScoreFrame1Text:SetText("");
		self.ScoreFrame1:Show();
		self.ScoreFrame2Text:SetText("");
		self.ScoreFrame2:Show();
	end
end

function Arathi:ShowBasesToWin()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrameToWin then
			self.ScoreFrameToWin = CreateFrame("Frame", nil, AlwaysUpFrame2);
			self.ScoreFrameToWin:SetHeight(10);
			self.ScoreFrameToWin:SetWidth(200);
			self.ScoreFrameToWin:SetPoint("TOPLEFT", "AlwaysUpFrame2", "BOTTOMLEFT", 22, 2)
			self.ScoreFrameToWinText= self.ScoreFrameToWin:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.ScoreFrameToWinText:SetAllPoints(self.ScoreFrameToWin);
			self.ScoreFrameToWinText:SetJustifyH("LEFT");
		end
		self.ScoreFrameToWinText:SetText("");
		self.ScoreFrameToWin:Show();
	end
end

function Arathi:HideEstimatedPoints()
	if self.ScoreFrame1 and self.ScoreFrame2 then
		self.ScoreFrame1:Hide();
		self.ScoreFrame1Text:SetText("");
		self.ScoreFrame2:Hide();
		self.ScoreFrame2Text:SetText("");
	end
end

function Arathi:HideBasesToWin()
	if self.ScoreFrameToWin then
		self.ScoreFrameToWin:Hide();
		self.ScoreFrameToWinText:SetText("");
	end
end

function Arathi:OnUpdate()
	if GetRealZoneText() == DBM_ARATHI then
		local mOk, AllyBases, AllyScore, HordeBases, HordeScore = self:GetScore();
		if not mOk then
			return;
		end
		
		self.LastTick.Alliance.Score = AllyScore;
		self.LastTick.Alliance.Bases = AllyBases;
		
		self.LastTick.Horde.Score = HordeScore;
		self.LastTick.Horde.Bases = HordeBases;
		
		self.LastTick.Time = GetTime(); --needed if the UpdateTimer event is not called by this function
		
		if self.LastTick.Alliance.Score < 2000 
		and self.LastTick.Horde.Score < 2000
		and (self.LastTick.Alliance.Score + self.LastTick.Horde.Score) > 0
		and (self.LastTick.Alliance.Bases + self.LastTick.Horde.Bases) > 0
		and (self.LastTick.LastAllyCount ~= self.LastTick.Alliance.Bases or self.LastTick.LastHordeCount ~= self.LastTick.Horde.Bases) then
			self:OnEvent("UpdateTimer");
		end

		if DBM:GetMod("Arathi").Options.ShowAbBasesToWin then
			local FriendlyLast, EnemyLast, FriendlyBases, EnemyBases, baseLowest;
			if( UnitFactionGroup( "player" ) == "Alliance" ) then
				FriendlyLast = self.LastTick.Alliance.Score;
				EnemyLast = self.LastTick.Horde.Score;
				FriendlyBases = self.LastTick.Alliance.Bases;
				EnemyBases = self.LastTick.Horde.Bases;
			else
				FriendlyLast = self.LastTick.Horde.Score;
				EnemyLast = self.LastTick.Alliance.Score;
				FriendlyBases = self.LastTick.Horde.Bases;
				EnemyBases = self.LastTick.Alliance.Bases;
			end
			if ((2000 - FriendlyLast) / self.ResPerSec[FriendlyBases]) > ((2000 - EnemyLast) / self.ResPerSec[EnemyBases]) then
				for i=1, 5 do
					local EnemyTime = (2000 - EnemyLast) / self.ResPerSec[ 5 - i ];
					local FriendlyTime = (2000 - FriendlyLast) / self.ResPerSec[ i ];
					if( FriendlyTime < EnemyTime ) then
						baseLowest = FriendlyTime;
					else
						baseLowest = EnemyTime;
					end
					
					local EnemyFinal = math.floor( ( EnemyLast + math.floor( baseLowest * self.ResPerSec[ 5 - i ] + 0.5 ) ) / 10 ) * 10;
					local FriendlyFinal = math.floor( ( FriendlyLast + math.floor( baseLowest * self.ResPerSec[ i ] + 0.5 ) ) / 10 ) * 10;
					if( FriendlyFinal >= 2000 and EnemyFinal < 2000 ) then
						self.ScoreFrameToWinText:SetText(DBM_BGMOD_LANG.AB_BASESTOWIN_TEXT..i);
						break;
					end
				end
			else
				self.ScoreFrameToWinText:SetText("");
			end
		end
	else --not in Arathi, end timers
		self:EndStatusBarTimer("AB_WINALLY", true);
		self:EndStatusBarTimer("AB_WINHORDE", true);
	end
end

function Arathi:OnEvent(event)
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() == DBM_ARATHI and self.Options.ShowAbFrame then
		self:ShowEstimatedPoints();
		self:ShowBasesToWin();
		
	elseif (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() ~= DBM_ARATHI then
		self:HideEstimatedPoints();
		self:HideBasesToWin();
		
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then --speed boots
		if arg1 and string.find(arg1, DBM_BGMOD_LANG.WSG_BOOTS_EXPR) then
			self:StartStatusBarTimer(10, "Speed Boots", "Interface\\Icons\\Spell_Fire_BurningSpeed", true); --respawn time varies, ~3 minutes
		end
	
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then --"game starts in.." timers
		if arg1 == DBM_BGMOD_LANG.AB_START60SEC then
			self:SendSync("Start60")
		elseif arg1 == DBM_BGMOD_LANG.AB_START30SEC then		
			self:SendSync("Start30")
		end
	
	elseif event == "UpdateTimer" then
		--DBM:GetMod("Arathi"):EstimateBases();

		local AllyTime = ((2000 - self.LastTick.Alliance.Score) / self.ResPerSec[self.LastTick.Alliance.Bases]) - (GetTime() - self.LastTick.Time); -- possible division through zero, but Lua does not complain about this...1/0 = 1.#INF
		local HordeTime = ((2000 - self.LastTick.Horde.Score) / self.ResPerSec[self.LastTick.Horde.Bases]) - (GetTime() - self.LastTick.Time);
		if AllyTime > 5000 then		AllyTime = 5000; end
		if HordeTime > 5000 then	HordeTime = 5000; end
		
		self.LastTick.LastAllyCount	= self.LastTick.Alliance.Bases; 
		self.LastTick.LastHordeCount = self.LastTick.Horde.Bases;
		
		if self:GetStatusBarTimerTimeLeft("AB_WINALLY") and self:GetStatusBarTimerTimeLeft("AB_WINHORDE") then -- should never happen
			self:EndStatusBarTimer("AB_WINALLY", true);
			self:EndStatusBarTimer("AB_WINHORDE", true);
		end		
		
		if AllyTime == HordeTime then -- draw
			self:EndStatusBarTimer("AB_WINALLY", true);
			self:EndStatusBarTimer("AB_WINHORDE", true);
			self.ScoreFrame1Text:SetText("");
			self.ScoreFrame2Text:SetText("");
		
		elseif AllyTime > HordeTime then -- Horde wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local AllyPoints = math.floor(math.floor(((HordeTime * self.ResPerSec[self.LastTick.Alliance.Bases]) + self.LastTick.Alliance.Score) / 10) * 10);
				self.ScoreFrame1Text:SetText("("..AllyPoints..")");
				self.ScoreFrame2Text:SetText("(2000)");
			end
			
			if self:GetStatusBarTimerTimeLeft("AB_WINALLY") then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("AB_WINALLY");
				self:UpdateStatusBarTimer("AB_WINALLY", nil, (timeElapsed + HordeTime), "AB_WINHORDE", "Interface\\Icons\\INV_BannerPVP_01.blp", true);
			elseif( self:GetStatusBarTimerTimeLeft("AB_WINHORDE") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("AB_WINHORDE");
				self:UpdateStatusBarTimer("AB_WINHORDE", nil, (timeElapsed + HordeTime), nil, nil, true);
			else
				self:StartStatusBarTimer(HordeTime, "AB_WINHORDE", "Interface\\Icons\\INV_BannerPVP_01.blp", true);
			end
			
		elseif HordeTime > AllyTime then -- Alliance wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local HordePoints = math.floor(math.floor(((AllyTime * self.ResPerSec[self.LastTick.Horde.Bases]) + self.LastTick.Horde.Score) / 10) * 10);
				self.ScoreFrame2Text:SetText("("..HordePoints..")");
				self.ScoreFrame1Text:SetText("(2000)");						
			end
			
			if( self:GetStatusBarTimerTimeLeft("AB_WINHORDE") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("AB_WINHORDE");
				self:UpdateStatusBarTimer("AB_WINHORDE", nil, (timeElapsed + AllyTime), "AB_WINALLY", "Interface\\Icons\\INV_BannerPVP_02.blp", true);
			
			elseif( self:GetStatusBarTimerTimeLeft("AB_WINALLY") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("AB_WINALLY");
				self:UpdateStatusBarTimer("AB_WINALLY", nil, (timeElapsed + AllyTime), nil, nil, true);
			else
				self:StartStatusBarTimer(AllyTime, "AB_WINALLY", "Interface\\Icons\\INV_BannerPVP_02.blp", true);
			end
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
		for index, value in ipairs(DBM_BGMOD_LANG.AB_TARGETS) do
			if string.find(arg1, value) then
				if string.find(arg1, DBM_BGMOD_LANG.AB_HASASSAULTED) or string.find(arg1, DBM_BGMOD_LANG.AB_CLAIMSTHE) then
					self:SendSync("CA"..index)
					
				elseif string.find(arg1, DBM_BGMOD_LANG.AB_HASDEFENDEDTHE) or string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
					if string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
						if DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE and DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index] then
							self:Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index]));
						else
							self:Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, DBM.Capitalize(DBM_BGMOD_LANG.AB_TARGETS[index])));
						end
						local oldFlashColor = DBM.Options.FlashColor;
						DBM.Options.FlashColor = "blue";
						self:AddSpecialWarning("", true);
						DBM.Options.FlashColor = oldFlashColor;
					end
					self:SendSync("DT"..index)
				end
			end
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_HORDE" then
		for index, value in ipairs(DBM_BGMOD_LANG.AB_TARGETS) do
			if string.find(arg1, value) then
				if string.find(arg1, DBM_BGMOD_LANG.AB_HASASSAULTED) or string.find(arg1, DBM_BGMOD_LANG.AB_CLAIMSTHE) then
					self:SendSync("CH"..index)
					
				elseif string.find(arg1, DBM_BGMOD_LANG.AB_HASDEFENDEDTHE) or string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
					if string.find(arg1, DBM_BGMOD_LANG.AB_HASTAKENTHE) then
						if DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE and DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index] then
							self:Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, DBM_BGMOD_LANG.AB_TARGETS_ANNOUNCE[index]));
						else
							self:Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, DBM.Capitalize(DBM_BGMOD_LANG.AB_TARGETS[index])));
						end
						local oldFlashColor = DBM.Options.FlashColor;
						DBM.Options.FlashColor = "red";
						self:AddSpecialWarning("", true);
						DBM.Options.FlashColor = oldFlashColor;
					end
					self:SendSync("DT"..index)
				end
			end
		end
	end
end

function Arathi:OnSync(msg)
	if msg == "Start60" then
		self:StartStatusBarTimer(62, "Begins")
	elseif msg == "Start30" then
		if not self:GetStatusBarTimerTimeLeft("Begins") then
			self:StartStatusBarTimer(62, "Begins")
		end
		self:UpdateStatusBarTimer("Begins", 31, 62)
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
