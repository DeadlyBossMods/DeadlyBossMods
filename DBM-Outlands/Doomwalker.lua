local Doomwalker = DBM:NewBossMod("Doomwalker", DBM_DOOMW_NAME, DBM_DOOMW_DESCRIPTION, DBM_SHADOWMOON, DBMGUI_TAB_OTHER_BC, 5);

Doomwalker.Author		= "Tandanu";
Doomwalker.Version		= "1.0";
Doomwalker.LastQuake	= 0;
Doomwalker.LastCharge	= 0;

Doomwalker:RegisterCombat("COMBAT");

Doomwalker:AddOption("RangeCheck", true, DBM_DOOMW_OPTION_1, function() 
		DBM:GetMod("Doomwalker").Options.RangeCheck = not DBM:GetMod("Doomwalker").Options.RangeCheck;
		
		if DBM:GetMod("Doomwalker").Options.RangeCheck and DBM:GetMod("Doomwalker").InCombat then
			DBM_Gui_DistanceFrame_Show();
		elseif not DBM:GetMod("Doomwalker").Options.RangeCheck and DBM:GetMod("Doomwalker").InCombat then
			DBM_Gui_DistanceFrame_Hide();
		end
	end
);
Doomwalker:AddOption("QuakeWarn", true, DBM_DOOMW_OPTION_2);
Doomwalker:AddOption("ChargeWarn", true, DBM_DOOMW_OPTION_3);

Doomwalker:AddBarOption("Earthquake Cooldown")
Doomwalker:AddBarOption("Earthquake")
Doomwalker:AddBarOption("Overrun Cooldown")

Doomwalker:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_EMOTE"
);

function Doomwalker:OnCombatStart(delay)
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Doomwalker:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Doomwalker:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if (GetTime() - self.LastQuake) > 30 and arg1.spellId == 32686 then
			self.LastQuake = GetTime();
			
			if self.Options.QuakeWarn then
				self:Announce(DBM_DOOMW_QUAKE_WARN, 3);
			end
			self:StartStatusBarTimer(52, "Earthquake Cooldown", "Interface\\Icons\\Spell_Nature_Earthquake");
			self:StartStatusBarTimer(8, "Earthquake", "Interface\\Icons\\Spell_Nature_Earthquake");
			self:ScheduleSelf(52, "QuakeWarn");
		end
		
	elseif event == "QuakeWarn" and self.Options.QuakeWarn then
		self:Announce(DBM_DOOMW_QUAKE_SOON, 2);
	
	elseif event == "SPELL_CAST_START" then
		if (GetTime() - self.LastCharge) > 10 and arg1.spellId == 32637 then
			self.LastCharge = GetTime();
			if self.Options.ChargeWarn then
				self:Announce(DBM_DOOMW_CHARGE, 2);
			end
			
			self:StartStatusBarTimer(42, "Overrun Cooldown", "Interface\\Icons\\Ability_Warrior_Charge");
			self:ScheduleSelf(41, "ChargeWarn");
		end
		
	elseif event == "ChargeWarn" and self.Options.ChargeWarn then
		self:Announce(DBM_DOOMW_CHARGE_SOON, 1);
	elseif event == "CHAT_MSG_MONSTER_EMOTE" then
		if arg1 == DBM_DOOMW_EMOTE_ENRAGE then
			self:Announce(DBM_DOOMW_WARN_ENRAGE, 3);
		end
	end
end