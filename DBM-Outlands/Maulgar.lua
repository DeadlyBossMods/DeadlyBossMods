local Maulgar = DBM:NewBossMod("Maulgar", DBM_MAULGAR_NAME, DBM_MAULGAR_DESCRIPTION, DBM_GRUULS_LAIR, DBMGUI_TAB_OTHER_BC, 1);

Maulgar.Version			= "1.0";
Maulgar.Author			= "Tandanu";
Maulgar.LastSpellShield = 0;

Maulgar:SetCreatureID(18831)
Maulgar:RegisterCombat("combat")

Maulgar:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
);

Maulgar:AddOption("WarnPWS",			true,	DBM_MAULGAR_OPTION_1);
Maulgar:AddOption("WarnSpellShield",	true,	DBM_MAULGAR_OPTION_2);
Maulgar:AddOption("WarnPoH",			false,	DBM_MAULGAR_OPTION_3);
Maulgar:AddOption("WarnHeal",			false,	DBM_MAULGAR_OPTION_4);
Maulgar:AddOption("WarnWW",				true,	DBM_MAULGAR_OPTION_5);
Maulgar:AddOption("WarnSmash",			false,	DBM_MAULGAR_OPTION_6);
Maulgar:AddOption("WarnFelhunter",		true,	DBM_MAULGAR_OPTION_7);

Maulgar:AddBarOption("Next Whirlwind")
Maulgar:AddBarOption("Whirlwind")
Maulgar:AddBarOption("Prayer of Healing")
Maulgar:AddBarOption("Heal")
Maulgar:AddBarOption("Felhunter")
Maulgar:AddBarOption("Arcing Smash")
Maulgar:AddBarOption("Spell Shield: (.*)")

function Maulgar:OnCombatStart(delay)
	self:StartStatusBarTimer(58 - delay, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
	self:ScheduleSelf(54 - delay, "WhirlwindWarning");
end

function Maulgar:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 33147 and self.Options.WarnPWS then
			self:Announce(DBM_MAULGAR_WARN_GPWS, 2);
		elseif arg1.spellId == 33054 then
			if bit.band(arg1.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == 0 then
				if self.Options.WarnSpellShield then
					self:Announce(DBM_MAULGAR_WARN_SHIELD, 3);
				end
				self.LastSpellShield = GetTime();
			else
				local buffTimer = 30 - (GetTime() - self.LastSpellShield);
				if buffTimer < 35 and buffTimer > 1 then
					self:StartStatusBarTimer(buffTimer, "Spell Shield: "..tostring(arg1.destName), "Interface\\Icons\\Spell_Arcane_ArcaneResilience");
				end
			end
		elseif arg1.spellId == 33238 then
			self:SendSync("WhirlWind")
		end
		
	elseif event == "WhirlwindWarning" then
		if self.Options.WarnWW then
			self:Announce(DBM_MAULGAR_WARN_WW_SOON, 2);
		end
		
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 33152 then
			if self.Options.WarnPoH then
				self:Announce(DBM_MAULGAR_WARN_POH, 1);
			end
			self:StartStatusBarTimer(4, "Prayer of Healing", "Interface\\Icons\\Spell_Holy_PrayerOfHealing02");
		elseif arg1.spellId == 33144 then
			if self.Options.WarnHeal then
				self:Announce(DBM_MAULGAR_WARN_HEAL, 2);
			end
			self:StartStatusBarTimer(2, "Heal", "Interface\\Icons\\Spell_Holy_Heal");
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 33131 then
			self:SendSync("Felhunter");
		end
	elseif event == "SPELL_DAMAGE" then
		if arg1.spellId == 38761 then
			self:SendSync("Arcing "..tostring(arg1.destName).." "..tostring(arg1.amount));
		end
	elseif event == "SPELL_MISSED" then
		if arg1.spellId == 38761 then
			self:SendSync("Arcing "..tostring(arg1.destName).." "..tostring(arg1.missType));
		end
	end
end

function Maulgar:OnSync(msg)
	if msg == "WhirlWind" then
		if self.Options.WarnWW then
			self:Announce(DBM_MAULGAR_WARN_WHIRLWIND, 3);
		end
		self:StartStatusBarTimer(55, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
		self:StartStatusBarTimer(15.2, "Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
		self:ScheduleSelf(51, "WhirlwindWarning");
	elseif msg == "Felhunter" then
		if self.Options.WarnFelhunter then
			self:Announce(DBM_MAULGAR_WARN_FELHUNTER, 2);
		end
		self:StartStatusBarTimer(48.5, "Felhunter", "Interface\\Icons\\Spell_Shadow_SummonFelHunter");
	elseif string.sub(msg, 1, 6) == "Arcing" then
		if self.Options.WarnSmash then
			local _, _, target, damage = string.find(msg, "Arcing ([^%s]+) (%w+)");			
			if target and damage then
				if string.find(damage, "MISS") then
					damage = DBM_MAULGAR_MISSED;
				elseif string.find(damage, "DODGE") then
					damage = DBM_MAULGAR_DODGED;
				elseif string.find(damage, "PARRY") then
					damage = DBM_MAULGAR_PARRIED;
				end
				self:Announce(string.format(DBM_MAULGAR_WARN_SMASH, target, damage), 1);
			end			
		end
		
		self:StartStatusBarTimer(10, "Arcing Smash", "Interface\\Icons\\Ability_Warrior_Cleave");
	end
end