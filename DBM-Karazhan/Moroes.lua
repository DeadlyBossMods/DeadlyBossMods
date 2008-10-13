local Moroes = DBM:NewBossMod("Moroes", DBM_MOROES_NAME, DBM_MOROES_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 2);

Moroes.Version			= "1.0";
Moroes.Author			= "Tandanu";
Moroes.LastVanish		= 0;

Moroes:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
);

Moroes:AddOption("VanishWarn", true, DBM_MOROES_OPTION_1);
Moroes:AddOption("VanishWarnFade", true, DBM_MOROES_OPTION_2);
Moroes:AddOption("VanishWarnSoon", true, DBM_MOROES_OPTION_3);
Moroes:AddOption("GarroteWarn", true, DBM_MOROES_OPTION_4);

Moroes:AddBarOption("Vanish")

Moroes:RegisterCombat("YELL", DBM_MOROES_YELL_START);

function Moroes:OnCombatStart(delay)
	self:StartStatusBarTimer(33, "Vanish", "Interface\\Icons\\Ability_Vanish");
	self:ScheduleSelf(33, "SoonWarning");
end

function Moroes:OnEvent(event, arg1)	
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 29448 then
			if self.Options.VanishWarn then
				self:Announce(DBM_MOROES_VANISH_WARN, 3);
			end
			self.LastVanish = GetTime();
		elseif arg1.spellId == 37066 and self.Options.GarroteWarn then
			self:Announce(string.format(DBM_MOROES_GARROTE_WARN, tostring(arg1.destName)), 2);
		end
	elseif event == "SPELL_AURA_REMOVED" then		
		if arg1.spellId == 29448 then
			if self.Options.VanishWarnFade then
				self:Announce(DBM_MOROES_VANISH_FADED, 3);
			end
			self:EndStatusBarTimer("Vanish");
			if (GetTime() - self.LastVanish) < 20 then
				self:StartStatusBarTimer(36.5 - (GetTime() - self.LastVanish), "Vanish", "Interface\\Icons\\Ability_Vanish");
				self:ScheduleSelf(31.5 - (GetTime() - self.LastVanish), "SoonWarning");
			end
		end
	
	elseif event == "SoonWarning" and self.Options.VanishWarnSoon then
		self:Announce(DBM_MOROES_VANISH_SOON, 2);
	end
end
