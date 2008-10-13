local Fathomlord = DBM:NewBossMod("Fathomlord", DBM_FATHOMLORD_NAME, DBM_FATHOMLORD_DESCRIPTION, DBM_COILFANG, DBM_SERPENT_TAB, 4);

Fathomlord.Version		= "1.0";
Fathomlord.Author		= "Tandanu";

Fathomlord:SetCreatureID(21214)
Fathomlord:RegisterCombat("yell", DBM_FATHOMLORD_YELL_PULL)

Fathomlord:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
);

Fathomlord:AddOption("TidalTotem", true, DBM_FATHOMLORD_OPTION_TOTEM_1);
Fathomlord:AddOption("KaraTotem", true, DBM_FATHOMLORD_OPTION_TOTEM_2);
Fathomlord:AddOption("Heal", true, DBM_FATHOMLORD_OPTION_HEAL);

Fathomlord:AddBarOption("Enrage")
Fathomlord:AddBarOption("Healing Wave")

function Fathomlord:OnCombatStart(delay)
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
end

function Fathomlord:OnEvent(event, arg1)
	if event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 38236 and arg1.sourceName == DBM_FATHOMLORD_NAME then
			self:SendSync("KaraTotem")
		elseif arg1.spellId == 38236 then
			self:SendSync("TidalTotem")
		end
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 38330 then
			self:SendSync("Heal");
		end
	end
end

function Fathomlord:OnSync(msg)
	if msg == "TidalTotem" then
		if self.Options.TidalTotem then
			self:Announce(DBM_FATHOMLORD_SFTOTEM1_WARN);
		end
	elseif msg == "KaraTotem" then
		if self.Options.KaraTotem then
			self:Announce(DBM_FATHOMLORD_SFTOTEM2_WARN);
		end
	elseif msg == "Heal" then
		if self.Options.Heal then
			self:Announce(DBM_FATHOMLORD_HEAL_WARN);
		end
		self:StartStatusBarTimer(1, "Healing Wave", "Interface\\Icons\\Spell_Nature_MagicImmunity");
	end
end