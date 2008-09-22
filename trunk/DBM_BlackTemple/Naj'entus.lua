local Najentus = DBM:NewBossMod("Najentus", DBM_NAJENTUS_NAME, DBM_NAJENTUS_DESCRIPTION, DBM_BLACK_TEMPLE, DBM_BT_TAB, 1);

Najentus.Version	= "1.0";
Najentus.Author		= "Tandanu";

Najentus:RegisterCombat("YELL", DBM_NAJENTUS_YELL_PULL);

Najentus:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
);

Najentus:AddOption("RangeCheck", true, DBM_NAJENTUS_OPTION_RANGECHECK);
Najentus:AddOption("Icon", false, DBM_NAJENTUS_OPTION_ICON);
Najentus:AddOption("Frame", true, DBM_NAJENTUS_OPTION_FRAME);

Najentus:AddBarOption("Enrage")
Najentus:AddBarOption("Next Tidal Shield")

function Najentus:OnCombatStart(delay)	
	self:StartStatusBarTimer(480 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:ScheduleSelf(180 - delay, "EnrageWarn", 300);
	self:ScheduleSelf(360 - delay, "EnrageWarn", 120);
	self:ScheduleSelf(420 - delay, "EnrageWarn", 60);
	self:ScheduleSelf(450 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(470 - delay, "EnrageWarn", 10);	
	self:StartStatusBarTimer(60 - delay, "Next Tidal Shield", "Interface\\Icons\\Spell_Nature_CrystalBall");
	self:ScheduleSelf(57 - delay, "ShowFrame");
	self:ScheduleSelf(50 - delay, "ShieldWarn");
	
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Najentus:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
	self:HideFrame()
end

function Najentus:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 39837 then
			self:SendSync("Spine"..tostring(arg1.destName));
		elseif arg1.spellId == 39872 then
			self:SendSync("Shield")
		end
	elseif event == "SPELL_AURA_REMOVED" then
		if arg1.spellId == 39872 then
			self:SendSync("FadeShield");
		end
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_NAJENTUS_WARN_ENRAGE, (arg1/60), DBM_MIN), 1);
		else
			self:Announce(string.format(DBM_NAJENTUS_WARN_ENRAGE, arg1, DBM_SEC), 3);
		end
	elseif event == "ShieldWarn" then
		self:Announce(DBM_NAJENTUS_WARN_SHIELD_SOON, 1);
	elseif event == "ShowFrame" and self.Options.Frame then
		self:ShowFrame()
		self:ScheduleSelf(20, "HideFrame")
	elseif event == "HideFrame" then
		self:HideFrame()
	end
end

function Najentus:OnSync(msg)
	if msg:sub(0, 5) == "Spine" then
		msg = msg:sub(6);
		self:Announce(DBM_NAJENTUS_WARN_SPINE:format(msg), 2);
		if self.Options.Icon then
			self:SetIcon(msg, 15);
		end
	elseif msg == "Shield" then
		self:Announce(DBM_NAJENTUS_WARN_SHIELD, 3);
		self:ScheduleSelf(48, "ShieldWarn");
		self:ScheduleSelf(55, "ShowFrame")
		self:StartStatusBarTimer(58, "Next Tidal Shield", "Interface\\Icons\\Spell_Nature_CrystalBall");		
	elseif msg == "FadeShield" then
		self:OnEvent("HideFrame")
	end
end

function Najentus:CreateFrame()
	self.frame = DBMGui:CreateInfoFrame(DBM_NAJENTUS_FRAME_TITLE, DBM_NAJENTUS_FRAME_TEXT);
	if not self.frame then 
		self:AddMsg("Unknown error!");
		return false; 
	end

	self.frameP1 = self.frame:CreateTextField("");
	self.frameP2 = self.frame:CreateTextField("");
	self.frameP3 = self.frame:CreateTextField("");
	self.frameP4 = self.frame:CreateTextField("");
	self.frameP5 = self.frame:CreateTextField("");
end

function Najentus:ShowFrame()
	if GetRealZoneText() ~= DBM_BLACK_TEMPLE then return end
	if self.frame then
		self.frame:Show()
	else
		self:CreateFrame()
		self.frame:Show()
	end
end

function Najentus:HideFrame()
	if self.frame then
		self.frame:Hide()
	end
end

Najentus.UpdateInterval = 1/3
function Najentus:OnUpdate(elapsed)
	if self.frame and self.frame:GetObject():IsShown() then
		local x = 1;
		local shield;

		for i = 1, GetNumRaidMembers() do
			if x <= 5 and UnitHealth("raid"..i) and UnitHealth("raid"..i) <= 8500 and not UnitIsDeadOrGhost("raid"..i) then
				shield = ""
				if DBM.GetBuff("raid"..i, DBM_NAJENTUS_SPELL_PWS) or DBM.GetBuff("raid"..i, DBM_NAJENTUS_SPELL_FW) or DBM.GetBuff("raid"..i, DBM_NAJENTUS_SPELL_FB) then
					shield = " (shielded)"
				end
				self["frameP"..x]:SetText(UnitName("raid"..i)..":   -"..(8501 - UnitHealth("raid"..i))..shield);
				x = x + 1;
			end
		end

		if x < 5 then
			for i = x, 5  do
				self["frameP"..i]:SetText("");
			end
		end
	end
end
