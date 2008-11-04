local EyeOfTheStorm = DBM:NewBossMod("EyeOfTheStorm", DBM_EOTS_NAME, DBM_EOTS_DESCRIPTION, DBM_OTHER, "BC Battlegrounds", 4);

EyeOfTheStorm.Version		= "1.0";
EyeOfTheStorm.Author		= "Tandanu";
EyeOfTheStorm.MinRevision	= 862;

EyeOfTheStorm:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
);


EyeOfTheStorm.ResPerSec = {
	[0] = 0,
	[1] = 0.5,
	[2] = 1,
	[3] = 2.5,
	[4] = 5,
};

EyeOfTheStorm.LastTick = {
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

EyeOfTheStorm.DropdownMenu = { --I don't use :AddOption() here, because I want to use the battleground boss mod's options table
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

EyeOfTheStorm:AddOption("ShowPointFrame", true, DBM_BGMOD_LANG.AB_INFOFRAME_INFO, function()
	DBM:GetMod("EyeOfTheStorm").Options.ShowPointFrame = not DBM:GetMod("EyeOfTheStorm").Options.ShowPointFrame;
	if DBM:GetMod("EyeOfTheStorm").Options.ShowPointFrame and GetRealZoneText() == DBM_EYEOFTHESTORM then
		DBM:GetMod("EyeOfTheStorm"):ShowEstimatedPoints();
		DBM:GetMod("EyeOfTheStorm"):OnEvent("UpdateTimer");
	else
		DBM:GetMod("EyeOfTheStorm"):HideEstimatedPoints();
	end
end);

function EyeOfTheStorm:UpdateFlagDisplay()
	if self.ScoreFrame1Text and self.ScoreFrame2Text then
		
		local newText;
		local oldText = self.ScoreFrame1Text:GetText();
		if self.AllyFlag then
			if not oldText or oldText == "" then
				newText = "Flag: "..self.AllyFlag;
			else
				newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)  "..DBM_EOTS_FLAG..": "..self.AllyFlag);
			end
		elseif oldText and oldText ~= "" then
			newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)");
		end
		self.ScoreFrame1Text:SetText(newText);
		
		newText = nil;
		oldText = self.ScoreFrame2Text:GetText();
		if self.HordeFlag then
			if not oldText or oldText == "" then
				newText = "Flag: "..self.HordeFlag;
			else
				newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)  "..DBM_EOTS_FLAG..": "..self.HordeFlag);
			end
		elseif oldText and oldText ~= "" then
			newText = string.gsub(oldText, "%((%d+)%).*", "%(%1%)");
		end
		self.ScoreFrame2Text:SetText(newText);
		
	end
end

function EyeOfTheStorm:GetScore()
	if GetRealZoneText() == DBM_EYEOFTHESTORM then
		local _, _, mAllyInfo	= GetWorldStateUIInfo(2);
		local _, _, mHordeInfo	= GetWorldStateUIInfo(3);
		if not mAllyInfo or not mHordeInfo then
			return false;
		end

		local _, _, AllyBases, AllyScore	= string.find(mAllyInfo, DBM_EOTS_POINTS);
		local _, _, HordeBases, HordeScore	= string.find(mHordeInfo, DBM_EOTS_POINTS);
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

function EyeOfTheStorm:ShowEstimatedPoints()
	if AlwaysUpFrame1Text and AlwaysUpFrame2Text then
		if not self.ScoreFrame1 then
			self.ScoreFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1);
			self.ScoreFrame1:SetHeight(10);
			self.ScoreFrame1:SetWidth(200);
			self.ScoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1Text", "RIGHT", 4, 0)
			self.ScoreFrame1Text = self.ScoreFrame1:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.ScoreFrame1Text:SetAllPoints(self.ScoreFrame1);
			self.ScoreFrame1Text:SetJustifyH("LEFT");
		end
		if not self.ScoreFrame2 then
			self.ScoreFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2);
			self.ScoreFrame2:SetHeight(10);
			self.ScoreFrame2:SetWidth(200);
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

function EyeOfTheStorm:HideEstimatedPoints()
	if self.ScoreFrame1 and self.ScoreFrame2 then
		self.ScoreFrame1:Hide();
		self.ScoreFrame1Text:SetText("");
		self.ScoreFrame2:Hide();
		self.ScoreFrame2Text:SetText("");
	end
end

function EyeOfTheStorm:OnUpdate(elapsed)
	if GetRealZoneText() == DBM_EYEOFTHESTORM then
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
	else
		self:EndStatusBarTimer("Alliance wins in", true);
		self:EndStatusBarTimer("Horde wins in", true);
	end
end

function EyeOfTheStorm:OnEvent(event)
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() == DBM_EYEOFTHESTORM and self.Options.ShowPointFrame then
		self:ShowEstimatedPoints();
		
	elseif (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() ~= DBM_EYEOFTHESTORM then
		self:HideEstimatedPoints();
		
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then --speed boots
		if arg1 and string.find(arg1, DBM_BGMOD_LANG.WSG_BOOTS_EXPR) then
			self:StartStatusBarTimer(10, "Speed Boots", "Interface\\Icons\\Spell_Fire_BurningSpeed", true); --respawn time varies, ~3 minutes
		end
	
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then --"game starts in.." timers
		if string.find(arg1, DBM_EOTS_BEGINS_60) then
			self:SendSync("Start60")
		elseif arg1 == DBM_EOTS_BEGINS_30 then		
			self:SendSync("Start30")
		elseif string.find(arg1, DBM_EOTS_FLAG_RESET) then
			self.AllyFlag = nil;
			self.HordeFlag = nil;
			self:UpdateFlagDisplay();
		end
	
	elseif event == "UpdateTimer" then
		local AllyTime = ((2000 - self.LastTick.Alliance.Score) / self.ResPerSec[self.LastTick.Alliance.Bases]) - (GetTime() - self.LastTick.Time); -- possible division through zero, but Lua does not complain about this...1/0 = 1.#INF
		local HordeTime = ((2000 - self.LastTick.Horde.Score) / self.ResPerSec[self.LastTick.Horde.Bases]) - (GetTime() - self.LastTick.Time);
		if AllyTime > 5000 then		AllyTime = 5000; end
		if HordeTime > 5000 then	HordeTime = 5000; end
		
		self.LastTick.LastAllyCount	= self.LastTick.Alliance.Bases; 
		self.LastTick.LastHordeCount = self.LastTick.Horde.Bases;
		
		if self:GetStatusBarTimerTimeLeft("Alliance wins in") and self:GetStatusBarTimerTimeLeft("Horde wins in") then -- should never happen
			self:EndStatusBarTimer("Alliance wins in", true);
			self:EndStatusBarTimer("Horde wins in", true);
		end		
		
		if AllyTime == HordeTime then -- draw
			self:EndStatusBarTimer("Alliance wins in", true);
			self:EndStatusBarTimer("Horde wins in", true);
			self.ScoreFrame1Text:SetText("");
			self.ScoreFrame2Text:SetText("");
			
		elseif AllyTime > HordeTime then -- Horde wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local AllyPoints = math.floor((HordeTime * self.ResPerSec[self.LastTick.Alliance.Bases]) + self.LastTick.Alliance.Score);
				self.ScoreFrame1Text:SetText("("..AllyPoints..")");
				self.ScoreFrame2Text:SetText("(2000)");
				self:UpdateFlagDisplay();
			end
			
			if self:GetStatusBarTimerTimeLeft("Alliance wins in") then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("Alliance wins in");
				self:UpdateStatusBarTimer("Alliance wins in", nil, (timeElapsed + HordeTime), "Horde wins in", "Interface\\Icons\\INV_BannerPVP_01.blp", true);
			elseif( self:GetStatusBarTimerTimeLeft("Horde wins in") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("Horde wins in");
				self:UpdateStatusBarTimer("Horde wins in", nil, (timeElapsed + HordeTime), nil, nil, true);
			else
				self:StartStatusBarTimer(HordeTime, "Horde wins in", "Interface\\Icons\\INV_BannerPVP_01.blp", true);
			end
			
		elseif HordeTime > AllyTime then -- Alliance wins
			if self.ScoreFrame1Text and self.ScoreFrame2Text then
				local HordePoints = math.floor((AllyTime * self.ResPerSec[self.LastTick.Horde.Bases]) + self.LastTick.Horde.Score);
				self.ScoreFrame2Text:SetText("("..HordePoints..")");
				self.ScoreFrame1Text:SetText("(2000)");
				self:UpdateFlagDisplay();
			end
			
			if( self:GetStatusBarTimerTimeLeft("Horde wins in") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("Horde wins in");
				self:UpdateStatusBarTimer("Horde wins in", nil, (timeElapsed + AllyTime), "Alliance wins in", "Interface\\Icons\\INV_BannerPVP_02.blp", true);
			
			elseif( self:GetStatusBarTimerTimeLeft("Alliance wins in") ) then
				local timeLeft, timeElapsed = self:GetStatusBarTimerTimeLeft("Alliance wins in");
				self:UpdateStatusBarTimer("Alliance wins in", nil, (timeElapsed + AllyTime), nil, nil, true);
			else
				self:StartStatusBarTimer(AllyTime, "Alliance wins in", "Interface\\Icons\\INV_BannerPVP_02.blp", true);
			end
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" and arg1 then
		if string.find(arg1, DBM_EOTS_FLAG_TAKEN) then
			local _, _, name = string.find(arg1, DBM_EOTS_FLAG_TAKEN);
			if name and event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
				self.AllyFlag = name;
				self.HordeFlag = nil;
				self:UpdateFlagDisplay();
			elseif name and event == "CHAT_MSG_BG_SYSTEM_HORDE" then
				self.AllyFlag = nil;
				self.HordeFlag = name;				
				self:UpdateFlagDisplay();
			end
		elseif string.find(arg1, DBM_EOTS_FLAG_DROPPED) then
			self.AllyFlag = nil;
			self.HordeFlag = nil;
			self:UpdateFlagDisplay();
			
		elseif string.find(arg1, DBM_EOTS_FLAG_CAPTURED) then
			self:StartStatusBarTimer(9, "Flag respawn", "Interface\\Icons\\INV_Banner_02", true)
			self:ScheduleSelf(3.5, "UpdateTimer"); -- it takes a few seconds until you get the credits for capturing the flag
			self.AllyFlag = nil;
			self.HordeFlag = nil;
			self:UpdateFlagDisplay();
		end
	end
end

function EyeOfTheStorm:OnSync(msg)
	if msg == "Start60" then
		self:StartStatusBarTimer(62, "Begins")
	elseif msg == "Start30" then
		if not self:GetStatusBarTimerTimeLeft("Begins") then
			self:StartStatusBarTimer(62, "Begins")
		end
		self:UpdateStatusBarTimer("Begins", 31, 62)
	end
end
