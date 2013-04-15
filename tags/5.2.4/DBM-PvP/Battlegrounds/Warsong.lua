-- Warsong mod v3.0
-- rewrite by Nitram and Tandanu
--
-- thanks to LeoLeal, DiabloHu and Са°ЧТВ


local Warsong	= DBM:NewMod("z489", "DBM-PvP", 2)
local L			= Warsong:GetLocalizedStrings()

Warsong:RemoveOption("HealthFrame")
Warsong:RemoveOption("SpeedKillTimer")
Warsong:SetZone(DBM_DISABLE_ZONE_DETECTION)

local bgzone = false
local FlagCarrier = {
	[1] = nil,
	[2] = nil
}
Warsong:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_BATTLEFIELD_SCORE"
)

--local startTimer = Warsong:NewTimer(62, "TimerStart", 2457)
local flagTimer = Warsong:NewTimer(23, "TimerFlag", "Interface\\Icons\\INV_Banner_02")
local vulnerableTimer	= Warsong:NewNextTimer(60, 46392)

Warsong:AddBoolOption("ShowFlagCarrier", true, nil, function()
	if Warsong.Options.ShowFlagCarrier and bgzone then
		Warsong:ShowFlagCarrier()
		Warsong:CreateFlagCarrierButton()
	else
		Warsong:HideFlagCarrier()
	end	
end)
Warsong:AddBoolOption("ShowFlagCarrierErrorNote", false)

do
	local function WSG_Initialize()
		if select(2, IsInInstance()) == "pvp" and GetCurrentMapAreaID() == 443 then
			bgzone = true
			if Warsong.Options.ShowFlagCarrier then
				Warsong:ShowFlagCarrier()
				Warsong:CreateFlagCarrierButton()
				Warsong.FlagCarrierFrame1Text:SetText("")
				Warsong.FlagCarrierFrame2Text:SetText("")
			end

			FlagCarrier[1] = nil
			FlagCarrier[2] = nil

		elseif bgzone then
			bgzone = false
			if Warsong.Options.ShowFlagCarrier then
				Warsong:HideFlagCarrier()
			end
		end
	end
	Warsong.OnInitialize = WSG_Initialize
	Warsong.ZONE_CHANGED_NEW_AREA = WSG_Initialize
end

function Warsong:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if msg == L.Vulnerable1 or msg == L.Vulnerable2 or msg:find(L.Vulnerable1) or msg:find(L.Vulnerable2) then
		vulnerableTimer:Start()
	end
end


function Warsong:ShowFlagCarrier()
	if not Warsong.Options.ShowFlagCarrier then return end
	if AlwaysUpFrame3DynamicIconButton and AlwaysUpFrame3DynamicIconButton then
		if not self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame2DynamicIconButton)
			self.FlagCarrierFrame1:SetHeight(10)
			self.FlagCarrierFrame1:SetWidth(100)
			self.FlagCarrierFrame1:SetPoint("LEFT", "AlwaysUpFrame2DynamicIconButton", "RIGHT", 4, 0)
			self.FlagCarrierFrame1Text = self.FlagCarrierFrame1:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.FlagCarrierFrame1Text:SetAllPoints(self.FlagCarrierFrame1)
			self.FlagCarrierFrame1Text:SetJustifyH("LEFT")
		end
		if not self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame3DynamicIconButton)
			self.FlagCarrierFrame2:SetHeight(10)
			self.FlagCarrierFrame2:SetWidth(100)
			self.FlagCarrierFrame2:SetPoint("LEFT", "AlwaysUpFrame3DynamicIconButton", "RIGHT", 4, 0)
			self.FlagCarrierFrame2Text= self.FlagCarrierFrame2:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.FlagCarrierFrame2Text:SetAllPoints(self.FlagCarrierFrame2)
			self.FlagCarrierFrame2Text:SetJustifyH("LEFT")
		end
		self.FlagCarrierFrame1:Show()		
		self.FlagCarrierFrame2:Show()
	end
end

function Warsong:CreateFlagCarrierButton()
	if not Warsong.Options.ShowFlagCarrier then return end
	if not self.FlagCarrierFrame1Button then
		self.FlagCarrierFrame1Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame1Button:SetHeight(15)
		self.FlagCarrierFrame1Button:SetWidth(150)
		self.FlagCarrierFrame1Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame1Button:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 28, 4)
	end
	if not self.FlagCarrierFrame2Button then
		self.FlagCarrierFrame2Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame2Button:SetHeight(15)
		self.FlagCarrierFrame2Button:SetWidth(150)
		self.FlagCarrierFrame2Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame2Button:SetPoint("LEFT", "AlwaysUpFrame3", "RIGHT", 28, 4)
	end
	self.FlagCarrierFrame1Button:Show()		
	self.FlagCarrierFrame2Button:Show()
end

function Warsong:HideFlagCarrier()
	if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
		self.FlagCarrierFrame1:Hide()
		self.FlagCarrierFrame2:Hide()
		FlagCarrier[1] = nil
		FlagCarrier[2] = nil
	end
end

function Warsong:CheckFlagCarrier()
	if not UnitAffectingCombat("player") then
		if not self.FlagCarrierFrame1Button or not self.FlagCarrierFrame2Button then
			self:CreateFlagCarrierButton()
		end
		if FlagCarrier[1] and self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[1])
		end
		if FlagCarrier[2] and self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[2])
		end
	end
end

do
	local lastCarrier
	function Warsong:ColorFlagCarrier(carrier)
		local found = false
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, _, _, classToken = GetBattlefieldScore(i)
	 		if (name and faction and classToken and RAID_CLASS_COLORS[classToken]) then
				if string.match( name, "-" )  then
					name = string.match(name, "([^%-]+)%-.+")
				end
				if name == carrier then
					if faction == 0 then
						self.FlagCarrierFrame2Text:SetTextColor(RAID_CLASS_COLORS[classToken].r, 
											RAID_CLASS_COLORS[classToken].g, 
											RAID_CLASS_COLORS[classToken].b)
					elseif faction == 1 then
						self.FlagCarrierFrame1Text:SetTextColor(RAID_CLASS_COLORS[classToken].r, 
											RAID_CLASS_COLORS[classToken].g, 
											RAID_CLASS_COLORS[classToken].b)
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
	
	function Warsong:UPDATE_BATTLEFIELD_SCORE()
		if lastCarrier then
			self:ColorFlagCarrier(lastCarrier)
			lastCarrier = nil
		end
	end
end

function Warsong:PLAYER_REGEN_ENABLED()
	if bgzone then
		self:CheckFlagCarrier()
	end
end

do
	local function updateflagcarrier(self, event, arg1)
		if not self.Options.ShowFlagCarrier then return end
		if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
			if string.match(arg1, L.ExprFlagPickUp) or (GetLocale() ~= "ruRU" and string.match(arg1, L.ExprFlagPickUp2)) then
				local sArg1, sArg2
				local mSide, mNick, nickLong
				if ( GetLocale() == "ruRU" and string.match(arg1, L.ExprFlagPickUp2) ) then
					sArg2, sArg1 =  string.match(arg1, L.ExprFlagPickUp2)
				else
					sArg1, sArg2 =  string.match(arg1, L.ExprFlagPickUp)
				end
				if GetLocale() == "deDE" or GetLocale() == "koKR" or GetLocale() == "ptBR" then
					mSide = sArg2
					mNick = sArg1
				else
					mSide = sArg1
					mNick = sArg2
				end
                for i = 1, GetNumBattlefieldScores() do
					local name = GetBattlefieldScore(i)
					-- check if the player is really the player we are looking for (include the "-" separator in the check to avoid players with matching prefixes)
					if name and name:sub(0, mNick:len() + 1) == mNick .. "-"  then
						nickLong = name
						break
					end
				end
				if not nickLong then
					nickLong = mNick
				end
				
				if mSide == L.Alliance then
					FlagCarrier[2] = nickLong
					self.FlagCarrierFrame2Text:SetText(mNick)
					self.FlagCarrierFrame2:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame2Button:SetAttribute( "macrotext", "/targetexact " .. nickLong )
					end					

				elseif mSide == L.Horde then
					FlagCarrier[1] = nickLong
					self.FlagCarrierFrame1Text:SetText(mNick)
					self.FlagCarrierFrame1:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame1Button:SetAttribute( "macrotext", "/targetexact " .. nickLong )
					end
				end

				if FlagCarrier[1] and FlagCarrier[2] and not vulnerableTimer:IsStarted() then
					vulnerableTimer:Start(180)
				end
				
			elseif string.match(arg1, L.ExprFlagReturn) then
				local _, mSide
				if( GetLocale() == "ruRU") then
					_, _, _, mSide =  string.find(arg1, L.ExprFlagReturn)
				else
					_, _, mSide =  string.find(arg1, L.ExprFlagReturn)
				end
				
				if mSide == L.Alliance then
					self.FlagCarrierFrame2:Hide()
					FlagCarrier[2] = nil

				elseif mSide == L.Horde then
					self.FlagCarrierFrame1:Hide()
					FlagCarrier[1] = nil
				end
			end
		end
		if string.match(arg1, L.ExprFlagCaptured) then
			flagTimer:Start()
			vulnerableTimer:Cancel()
			if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
				self.FlagCarrierFrame1:Hide()
				self.FlagCarrierFrame2:Hide()
				FlagCarrier[1] = nil
				FlagCarrier[2] = nil
			end
		end
	end
	function Warsong:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_ALLIANCE", ...)
	end
	function Warsong:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_HORDE", ...)
	end
	function Warsong:CHAT_MSG_RAID_BOSS_EMOTE(...)
		updateflagcarrier(self, "CHAT_MSG_RAID_BOSS_EMOTE", ...)
	end
end



