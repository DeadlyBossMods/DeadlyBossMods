-- Twin Peaks mod v1.0
--
-- Thanks to Samira (EU-Thrall)


local TwinPeaks		= DBM:NewMod("z726", "DBM-PvP", 2)
local L			= TwinPeaks:GetLocalizedStrings()

TwinPeaks:RemoveOption("HealthFrame")
TwinPeaks:RemoveOption("SpeedKillTimer")
TwinPeaks:SetZone(DBM_DISABLE_ZONE_DETECTION)

TwinPeaks:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

local bgzone = false
local FlagCarrier = {
	[1] = nil,
	[2] = nil
}

--local startTimer 	= TwinPeaks:NewTimer(62, "TimerStart", 2457)
local flagTimer 	= TwinPeaks:NewTimer(23, "TimerFlag", "Interface\\Icons\\INV_Banner_02")
local vulnerableTimer	= TwinPeaks:NewNextTimer(60, 46392)

TwinPeaks:AddBoolOption("ShowFlagCarrier", true, nil, function()
	if TwinPeaks.Options.ShowFlagCarrier and bgzone then
		TwinPeaks:ShowFlagCarrier()
	else
		TwinPeaks:HideFlagCarrier()
	end	
end)
TwinPeaks:AddBoolOption("ShowFlagCarrierErrorNote", false)

do
	local function TwinPeaks_Initialize()
		if select(2, IsInInstance()) == "pvp" and GetCurrentMapAreaID() == 626 then
			bgzone = true
			TwinPeaks:RegisterShortTermEvents(
				"PLAYER_REGEN_ENABLED",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"UPDATE_BATTLEFIELD_SCORE"
			)
			if TwinPeaks.Options.ShowFlagCarrier then
				TwinPeaks:ShowFlagCarrier()
				TwinPeaks:CreateFlagCarrierButton()
				TwinPeaks.FlagCarrierFrame1Text:SetText("")
				TwinPeaks.FlagCarrierFrame2Text:SetText("")
			end

			FlagCarrier[1] = nil
			FlagCarrier[2] = nil

		elseif bgzone then
			bgzone = false
			TwinPeaks:UnregisterShortTermEvents()
			if TwinPeaks.Options.ShowFlagCarrier then
				TwinPeaks:HideFlagCarrier()
			end
		end
	end
	TwinPeaks.OnInitialize = TwinPeaks_Initialize
	TwinPeaks.ZONE_CHANGED_NEW_AREA = TwinPeaks_Initialize
end

function TwinPeaks:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if msg == L.Vulnerable1 or msg == L.Vulnerable2 or msg:find(L.Vulnerable1) or msg:find(L.Vulnerable2) then
		vulnerableTimer:Start()
	end
end


function TwinPeaks:ShowFlagCarrier()
	if not TwinPeaks.Options.ShowFlagCarrier then return end
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

function TwinPeaks:CreateFlagCarrierButton()
	if not TwinPeaks.Options.ShowFlagCarrier then return end
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

function TwinPeaks:HideFlagCarrier()
	if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
		self.FlagCarrierFrame1:Hide()
		self.FlagCarrierFrame2:Hide()
		FlagCarrier[1] = nil
		FlagCarrier[2] = nil
	end
end

function TwinPeaks:CheckFlagCarrier()
	if not UnitAffectingCombat("player") then
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
	function TwinPeaks:ColorFlagCarrier(carrier)
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
	
	function TwinPeaks:UPDATE_BATTLEFIELD_SCORE()
		if lastCarrier then
			self:ColorFlagCarrier(lastCarrier)
			lastCarrier = nil
		end
	end
end

function TwinPeaks:PLAYER_REGEN_ENABLED()
	if bgzone then
		self:CheckFlagCarrier()
	end
end

do
	local function updateflagcarrier(self, event, arg1)
		if not self.Options.ShowFlagCarrier then return end
		if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
			if string.match(arg1, L.ExprFlagPickUp) then
				local sArg1, sArg2 =  string.match(arg1, L.ExprFlagPickUp)
				local mSide, mNick, nickLong
				if( GetLocale() == "deDE") then
					mSide = sArg2
					mNick = sArg1
				else
					mSide = sArg1
					mNick = sArg2
				end
				if GetLocale() == "koKR" then
					mSide = sArg2
					mNick = sArg1
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
	function TwinPeaks:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_ALLIANCE", ...)
	end
	function TwinPeaks:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_HORDE", ...)
	end
	function TwinPeaks:CHAT_MSG_RAID_BOSS_EMOTE(...)
		updateflagcarrier(self, "CHAT_MSG_RAID_BOSS_EMOTE", ...)
	end
end
