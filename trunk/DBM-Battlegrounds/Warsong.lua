-- 8/1/2007: Set name color of flag carrier to his class color by Diablohu.
-- 31/7/2007 2.1: The function that targeting the flag carrier finally completed by Diablohu. Special thanks to Са°ЧТВ.

local Warsong = DBM:NewBossMod("Warsong", DBM_WARSONG, DBM_BGMOD_LANG["WS_DESCRIPTION"], DBM_OTHER, "Battlegrounds", 5);

Warsong.Version = "2.1";
Warsong.Author = "LeoLeal, Nitram, Tandanu";
Warsong.ExtraGUITab	= "BC Battlegrounds";
Warsong.MinRevision = 862;

Warsong.FlagCarrier = {
		[1] = nil,
		[2] = nil
	}

Warsong:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
	"UPDATE_BATTLEFIELD_SCORE"
);

Warsong.DropdownMenu = { --I don't use :AddOption() here, because I want to use the battleground boss mod's options table
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

Warsong:AddOption("ShowFlagCarrier", true, DBM_BGMOD_LANG.WSG_INFOFRAME_INFO, function()
	DBM:GetMod("Warsong").Options.ShowFlagCarrier = not DBM:GetMod("Warsong").Options.ShowFlagCarrier;
	if DBM:GetMod("Warsong").Options.ShowFlagCarrier and GetRealZoneText() == DBM_WARSONG then
		DBM:GetMod("Warsong"):HideFlagCarrier();
	else
		DBM:GetMod("Warsong"):HideFlagCarrier();
	end	
end);

Warsong:AddOption("ShowFlagCarrierErrorNote", false, DBM_BGMOD_LANG.WSG_INFOFRAME_ERRORINFO, function()
	DBM:GetMod("Warsong").Options.ShowFlagCarrierErrorNote = not DBM:GetMod("Warsong").Options.ShowFlagCarrierErrorNote;
end);

function Warsong:ShowFlagCarrier()
	if AlwaysUpFrame1DynamicIconButton and AlwaysUpFrame2DynamicIconButton then
		if not self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1DynamicIconButton);
			self.FlagCarrierFrame1:SetHeight(10);
			self.FlagCarrierFrame1:SetWidth(100);
			self.FlagCarrierFrame1:SetPoint("LEFT", "AlwaysUpFrame1DynamicIconButton", "RIGHT", 4, 0);
			self.FlagCarrierFrame1Text = self.FlagCarrierFrame1:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.FlagCarrierFrame1Text:SetAllPoints(self.FlagCarrierFrame1);
			self.FlagCarrierFrame1Text:SetJustifyH("LEFT");
		end
		if not self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2DynamicIconButton);
			self.FlagCarrierFrame2:SetHeight(10);
			self.FlagCarrierFrame2:SetWidth(100);
			self.FlagCarrierFrame2:SetPoint("LEFT", "AlwaysUpFrame2DynamicIconButton", "RIGHT", 4, 0)
			self.FlagCarrierFrame2Text= self.FlagCarrierFrame2:CreateFontString(nil, nil, "GameFontNormalSmall");
			self.FlagCarrierFrame2Text:SetAllPoints(self.FlagCarrierFrame2);
			self.FlagCarrierFrame2Text:SetJustifyH("LEFT");
		end
		self.FlagCarrierFrame1:Show();		
		self.FlagCarrierFrame2:Show();
	end
end

function Warsong:CreatFlagCarrierButton()
		if not self.FlagCarrierFrame1Button then
			self.FlagCarrierFrame1Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate");
			self.FlagCarrierFrame1Button:SetHeight(15);
			self.FlagCarrierFrame1Button:SetWidth(150);
			self.FlagCarrierFrame1Button:SetPoint("LEFT", "AlwaysUpFrame1", "RIGHT", 28, 4);
		end
		if not self.FlagCarrierFrame2Button then
			self.FlagCarrierFrame2Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate");
			self.FlagCarrierFrame2Button:SetHeight(15);
			self.FlagCarrierFrame2Button:SetWidth(150);
			self.FlagCarrierFrame2Button:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 28, 4);
		end
		self.FlagCarrierFrame1Button:Show();		
		self.FlagCarrierFrame2Button:Show();
end

function Warsong:HideFlagCarrier()
	if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
		self.FlagCarrierFrame1:Hide();
		self.FlagCarrierFrame2:Hide();
		DBM.AddOns.Warsong.FlagCarrier[1] = nil;
		DBM.AddOns.Warsong.FlagCarrier[2] = nil;
	end
end

function Warsong:CheckFlagCarrier()
	if not UnitAffectingCombat("player") then
		if DBM.AddOns.Warsong.FlagCarrier[1] and self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1Button:SetAttribute( "type", "macro" );
			self.FlagCarrierFrame1Button:SetAttribute( "macrotext", "/target " .. DBM.AddOns.Warsong.FlagCarrier[1] );
		end
		if DBM.AddOns.Warsong.FlagCarrier[2] and self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2Button:SetAttribute( "type", "macro" );
			self.FlagCarrierFrame2Button:SetAttribute( "macrotext", "/target " .. DBM.AddOns.Warsong.FlagCarrier[2] );
		end
	end
end

local lastCarrier
function Warsong:ColorFlagCarrier(carrier)
	local found = false
	for i = 1, GetNumBattlefieldScores() do
		local name, _, _, _, _, faction, _, _, class = GetBattlefieldScore( i )
 		if (name and class and DBM:GetMod("Battlegrounds").ClassColors[class]) then
			if( string.match( name, "-" ) ) then
				_, _, name = string.find(name, "([^%-]+)%-.+")
			end
			if name == carrier then
				if faction == 0 then
					self.FlagCarrierFrame2Text:SetTextColor(DBM:GetMod("Battlegrounds").ClassColors[class].r, DBM:GetMod("Battlegrounds").ClassColors[class].g, DBM:GetMod("Battlegrounds").ClassColors[class].b)
				elseif faction == 1 then
					self.FlagCarrierFrame1Text:SetTextColor(DBM:GetMod("Battlegrounds").ClassColors[class].r, DBM:GetMod("Battlegrounds").ClassColors[class].g, DBM:GetMod("Battlegrounds").ClassColors[class].b)
				end
				found = true
			end
		end
	end
	if not found then
		RequestBattlefieldScoreData()
		lastCarrier = carrier
	end
end

function Warsong:OnEvent()
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() == DBM_WARSONG and self.Options.ShowFlagCarrier then
		self:ShowFlagCarrier();
		self:CreatFlagCarrierButton();
		self.FlagCarrierFrame1Text:SetText("");
		self.FlagCarrierFrame2Text:SetText("");
		DBM.AddOns.Warsong.FlagCarrier[1] = nil;
		DBM.AddOns.Warsong.FlagCarrier[2] = nil;
		
	elseif event == "UPDATE_BATTLEFIELD_SCORE" and lastCarrier then
		self:ColorFlagCarrier(lastCarrier)
		lastCarrier = nil
	elseif (event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") and GetRealZoneText() ~= DBM_WARSONG then
		self:HideFlagCarrier();	
		
	elseif event == "PLAYER_REGEN_ENABLED" and GetRealZoneText() == DBM_WARSONG then
		self:CheckFlagCarrier();
		
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then --speed boots
		if arg1 and string.find(arg1, DBM_BGMOD_LANG.WSG_BOOTS_EXPR) then
			self:StartStatusBarTimer(10, "Speed Boots", "Interface\\Icons\\Spell_Fire_BurningSpeed", true); --respawn time varies, ~3 minutes
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then --"game starts in.." timers
		if arg1 == DBM_BGMOD_LANG.WSG_START60SEC then
			self:SendSync("Start60")
		elseif arg1 == DBM_BGMOD_LANG.WSG_START30SEC then
			self:SendSync("Start30")
		end
	
	elseif (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE") and self.Options.ShowFlagCarrier then
		if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
			if string.find(arg1, DBM_BGMOD_LANG.WSG_FLAG_PICKUP) then
				local _, _, sArg1, sArg2 =  string.find(arg1, DBM_BGMOD_LANG.WSG_FLAG_PICKUP);
				local mSide, mNick;
				if( GetLocale() == "deDE") then
					mSide = sArg2; mNick = sArg1;
				else
					mSide = sArg1; mNick = sArg2;
				end
				
				if mSide == DBM_BGMOD_LANG.ALLIANCE then
					DBM.AddOns.Warsong.FlagCarrier[2] = mNick;
					self.FlagCarrierFrame2Text:SetText(mNick);
					self.FlagCarrierFrame2:Show();
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							DBM.AddMsg(DBM_BGMOD_LANG.WSG_INFOFRAME_ERRORTEXT)
						end
					end
					self.FlagCarrierFrame2Button:SetAttribute( "type", "macro" );
					self.FlagCarrierFrame2Button:SetAttribute( "macrotext", "/target " .. mNick );
				elseif mSide == DBM_BGMOD_LANG.HORDE then
					DBM.AddOns.Warsong.FlagCarrier[1] = mNick;
					self.FlagCarrierFrame1Text:SetText(mNick);
					self.FlagCarrierFrame1:Show();
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							DBM.AddMsg(DBM_BGMOD_LANG.WSG_INFOFRAME_ERRORTEXT)
						end
					end
					self.FlagCarrierFrame1Button:SetAttribute( "type", "macro" );
					self.FlagCarrierFrame1Button:SetAttribute( "macrotext", "/target " .. mNick );
				end
				
			elseif string.find(arg1, DBM_BGMOD_LANG.WSG_FLAG_RETURN) then
				if( GetLocale() == "ruRU") then
					local _, _, mNick, mSide =  string.find(arg1, DBM_BGMOD_LANG.WSG_FLAG_RETURN);
				else
					local _, _, mSide, mNick =  string.find(arg1, DBM_BGMOD_LANG.WSG_FLAG_RETURN);
				end
				
				if mSide == DBM_BGMOD_LANG.ALLIANCE then
					self.FlagCarrierFrame2:Hide();
					DBM.AddOns.Warsong.FlagCarrier[2] = nil;
				elseif mSide == DBM_BGMOD_LANG.HORDE then
					self.FlagCarrierFrame1:Hide();
					DBM.AddOns.Warsong.FlagCarrier[1] = nil;
				end
				
			elseif string.find(arg1, DBM_BGMOD_LANG.WSG_HASCAPTURED) then
				local oldFlashColor = DBM.Options.FlashColor;
				
				if event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
					DBM.Options.FlashColor = "blue";
				elseif event == "CHAT_MSG_BG_SYSTEM_HORDE" then
					DBM.Options.FlashColor = "red";
				end
				
				self:AddSpecialWarning("", true);
				DBM.Options.FlashColor = oldFlashColor;
				self:StartStatusBarTimer(23, "Flag respawn", nil, true);
				
				self.FlagCarrierFrame2:Hide();
				DBM.AddOns.Warsong.FlagCarrier[2] = nil;
				self.FlagCarrierFrame1:Hide();
				DBM.AddOns.Warsong.FlagCarrier[1] = nil;
			end
		end
	end
end

function Warsong:OnSync(msg)
	if msg == "Start60" then
		self:StartStatusBarTimer(62, "Begins")
	elseif msg == "Start30" then
		if not self:GetStatusBarTimerTimeLeft("Begins") then
			self:StartStatusBarTimer(62, "Begins")
		end
		self:UpdateStatusBarTimer("Begins", 31, 62)
	end
end