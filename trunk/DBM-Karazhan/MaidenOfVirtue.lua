local Maiden = DBM:NewBossMod("Maiden", DBM_MOV_NAME, DBM_MOV_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 3);

Maiden.Version		= "1.2";
Maiden.Author		= "Tandanu";
Maiden.MinVersionToSync = 2.7

Maiden:AddOption("HolyFireWarn", true, DBM_MOV_OPTION_2);
Maiden:AddOption("RangeCheck", true, DBM_MOV_OPTION_1, function()
	DBM:GetMod("Maiden").Options.RangeCheck = not DBM:GetMod("Maiden").Options.RangeCheck;
	
	if DBM:GetMod("Maiden").Options.RangeCheck and DBM:GetMod("Maiden").InCombat then
		DBM_Gui_DistanceFrame_Show();
	elseif not DBM:GetMod("Maiden").Options.RangeCheck and DBM:GetMod("Maiden").InCombat then
		DBM_Gui_DistanceFrame_Hide();
	end
end);

Maiden:AddBarOption("Repentance")
Maiden:AddBarOption("Next Repentance")

Maiden:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED"
);

Maiden:RegisterCombat("YELL", DBM_MOV_YELL_PULL);

function Maiden:OnCombatStart()
	self:EndStatusBarTimer("Repentance");
	self:StartStatusBarTimer(45, "Next Repentance", "Interface\\Icons\\Spell_Holy_PrayerOfHealing");
	self:ScheduleSelf(40, "RepWarning");
	
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Maiden:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Maiden:OnEvent(event, arg1)
	if event == "RepWarning" then
		self:Announce(DBM_MOV_WARN_REP_SOON, 1);
		
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 and (string.find(arg1, DBM_MOV_YELL_REP_1) or string.find(arg1, DBM_MOV_YELL_REP_2)) then
			self:SendSync("Rep");
		end
		
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 29522 then
			self:Announce(string.format(DBM_MOV_WARN_HOLYFIRE, tostring(arg1.destName)), 2);
		end
	end
end

function Maiden:OnSync(msg)
	if msg == "Rep" then
		self:Announce(DBM_MOV_WARN_REP, 3);
		self:EndStatusBarTimer("Next Repentance");
		self:UnScheduleSelf("RepWarning");
		self:StartStatusBarTimer(33, "Next Repentance", "Interface\\Icons\\Spell_Holy_PrayerOfHealing");
		self:StartStatusBarTimer(12, "Repentance", "Interface\\Icons\\Spell_Holy_PrayerOfHealing");
		self:ScheduleSelf(29, "RepWarning");
	end
end