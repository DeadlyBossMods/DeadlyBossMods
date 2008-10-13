local Hydross = DBM:NewBossMod("Hydross", DBM_HYDROSS_NAME, DBM_HYDROSS_DESCRIPTION, DBM_COILFANG, DBM_SERPENT_TAB, 1);

Hydross.Version		= "1.0";
Hydross.Author		= "Tandanu";
Hydross.LastMark	= 0;
Hydross.Marks		= 0;
Hydross.Phase		= "frost";
Hydross.TombSpam	= 0;

Hydross:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
);


Hydross:SetCreatureID(21216)
Hydross:RegisterCombat("yell", DBM_HYDROSS_YELL_PULL)

Hydross:AddOption("RangeCheck", true, DBM_HYDROSS_OPTION_1);
Hydross:AddOption("Marks", true, DBM_HYDROSS_OPTION_2);
Hydross:AddOption("MarkPreWarn", false, DBM_HYDROSS_OPTION_3);
Hydross:AddOption("Phases", true, DBM_HYDROSS_OPTION_4);
Hydross:AddOption("WaterTomb", true, DBM_HYDROSS_OPTION_5);

Hydross:AddBarOption("Enrage")
Hydross:AddBarOption("Water Tomb")
Hydross:AddBarOption("Mark of Corruption #(%d+)", true, DBM_HYDROSS_OPTION_NATURE)
Hydross:AddBarOption("Mark of Hydross #(%d+)", true, DBM_HYDROSS_OPTION_FROST)

function Hydross:OnCombatStart(delay)
	self.Marks = 0;
	self.Phase = "frost";
	self:ScheduleSelf(11 - delay, "MarkWarning");
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:StartStatusBarTimer(16 - delay, "Mark of Hydross #"..(self.Marks + 1), "Interface\\Icons\\Spell_Frost_FrozenCore");
	
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Hydross:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Hydross:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if (GetTime() - self.LastMark) > 7 and 
		(arg1.spellId == 38215 or
		arg1.spellId == 38216 or
		arg1.spellId == 38217 or
		arg1.spellId == 38218 or
		arg1.spellId == 38231 or
		arg1.spellId == 40584) then
			local timer = 15;
			self.LastMark = GetTime();
			if self.Phase == "nature" then
				self.Phase = "frost";
				self.Marks = 0;
			end
			self.Marks = self.Marks + 1;
			
			if self.Options.Marks then
				self:Announce(string.format(DBM_HYDROSS_FROST_MARK_NOW, self.Marks), 1);
			end
			
			if self.Marks == 1 then
				timer = 14.4;
			elseif self.Marks == 2 then
				timer = 15.6;
			elseif self.Marks == 3 then
				timer = 14.5;
			elseif self.Marks == 4 then
				timer = 14;
			elseif self.Marks == 5 then
				timer = 14;
			else
				timer = nil;
			end
			for i = 1, 7 do
				self:EndStatusBarTimer("Mark of Hydross #"..i);
				self:EndStatusBarTimer("Mark of Corruption #"..i);
			end
			if timer then
				self:ScheduleSelf(timer - 5, "MarkWarning");
				self:StartStatusBarTimer(timer, "Mark of Hydross #"..(self.Marks + 1), "Interface\\Icons\\Spell_Frost_FrozenCore");
			end
		
		elseif (GetTime() - self.LastMark) > 7 and 
		(arg1.spellId == 38219 or
		arg1.spellId == 38220 or
		arg1.spellId == 38221 or
		arg1.spellId == 38222 or
		arg1.spellId == 38230 or
		arg1.spellId == 40583) then
			local timer = 15;
			self.LastMark = GetTime();			
			if self.Phase == "frost" then
				self.Phase = "nature";
				self.Marks = 0;
			end
			self.Marks = self.Marks + 1;
			
			if self.Options.Marks then
				self:Announce(string.format(DBM_HYDROSS_NATURE_MARK_NOW, self.Marks), 2);
			end
			
			if self.Marks == 1 then
				timer = 14.8;
			elseif self.Marks == 2 then
				timer = 15.6;
			elseif self.Marks == 3 then
				timer = 14.5;
			elseif self.Marks == 4 then
				timer = 14;
			elseif self.Marks == 5 then
				timer = 14;
			else
				timer = nil;
			end

			for i = 1, 7 do
				self:EndStatusBarTimer("Mark of Hydross #"..i);
				self:EndStatusBarTimer("Mark of Corruption #"..i);
			end
			if timer then
				self:StartStatusBarTimer(timer, "Mark of Corruption #"..(self.Marks + 1), "Interface\\Icons\\Spell_Nature_ElementalShields");			
				self:ScheduleSelf(timer - 5, "MarkWarning");
			end
		elseif arg1.spellId == 38235 and self.TombSpam < 5 then
			local target = arg1.destName
			if target == UnitName("player") then
				self:StartStatusBarTimer(5, "Water Tomb", "Interface\\Icons\\Spell_Frost_ManaRecharge", true);
			end
			if target then
				if self.Options.WaterTomb then
					self:Announce(string.format(DBM_HYDROSS_TOMB_WARN, target), 2);
					self.TombSpam = self.TombSpam + 1;
					self:ScheduleSelf(3, "ResetTombSpamVar");
				end
			end
		end
	elseif event == "ResetTombSpamVar" then
		self.TombSpam = 0;
	elseif event == "MarkWarning" and self.Options.Marks then
		if self.Options.MarkPreWarn or self.Marks >= 4 then
			if self.Phase == "frost" then
				self:Announce(string.format(DBM_HYDROSS_FROST_SOON, (self.Marks + 1)), 1);
			elseif self.Phase == "nature" then
				self:Announce(string.format(DBM_HYDROSS_NATURE_SOON, (self.Marks + 1)), 1);
			end
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_HYDROSS_YELL_NATURE then
			self:UnScheduleSelf();
			for i = 1, 7 do
				self:EndStatusBarTimer("Mark of Hydross #"..i);
				self:EndStatusBarTimer("Mark of Corruption #"..i);
			end
			
			if self.Options.Phases then
				self:Announce(DBM_HYDROSS_NATURE_PHASE, 3);
			end
			self.Marks = 0;
			self.Phase = "nature";
			self:ScheduleSelf(11, "MarkWarning");
			self:StartStatusBarTimer(16, "Mark of Corruption #"..(self.Marks + 1), "Interface\\Icons\\Spell_Nature_ElementalShields");
		elseif arg1 == DBM_HYDROSS_YELL_FROST then
			self:UnScheduleSelf();
			for i = 1, 7 do
				self:EndStatusBarTimer("Mark of Hydross #"..i);
				self:EndStatusBarTimer("Mark of Corruption #"..i);
			end
			
			if self.Options.Phases then
				self:Announce(DBM_HYDROSS_FROST_PHASE, 3);
			end
			self.Marks = 0;
			self.Phase = "frost";
			self:ScheduleSelf(11, "MarkWarning");
			self:StartStatusBarTimer(16, "Mark of Hydross #"..(self.Marks + 1), "Interface\\Icons\\Spell_Frost_FrozenCore");
		end
	end
end

