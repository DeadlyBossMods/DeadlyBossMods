local Aran = DBM:NewBossMod("Aran", DBM_ARAN_NAME, DBM_ARAN_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 10);
--Edit by Nightkiller@¤é¸¨ªh¿A(kc10577@¤Ú«¢;Azael)
Aran.Version		= "1.0";
Aran.Author			= "Tandanu";

Aran:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL"
);

Aran:RegisterCombat("COMBAT");

Aran:AddBarOption("Flame Wreath Cast")
Aran:AddBarOption("Flame Wreath")
Aran:AddBarOption("Arcane Explosion")
Aran:AddBarOption("Blizzard")
Aran:AddBarOption("Elementals despawn in")

function Aran:OnEvent(event, arg1)
	if event == "SPELL_CAST_START" then
		if arg1.spellId == 30004 then
			self:Announce(DBM_ARAN_WREATH_WARN, 2);
			self:StartStatusBarTimer(5, "Flame Wreath Cast", "Interface\\Icons\\Spell_Holy_InnerFire");
			self:ScheduleSelf(5, "FlameWreath");
		elseif arg1.spellId == 29973 then
			self:Announce(DBM_ARAN_AE_WARN, 2);
			self:StartStatusBarTimer(10, "Arcane Explosion", "Interface\\Icons\\Spell_Nature_WispSplode");
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_MONSTER_SAY" then
		if arg1 == DBM_ARAN_YELL_BLIZZ1 or arg1 == DBM_ARAN_YELL_BLIZZ2 then
			self:Announce(DBM_ARAN_BLIZZ_WARN, 2);
			self:StartStatusBarTimer(3.7, "Blizzard", "Interface\\Icons\\Spell_Frost_IceStorm");
			self:ScheduleSelf(3.7, "Blizzard");
		elseif arg1 == DBM_ARAN_YELL_ADDS then
			self:Announce(DBM_ARAN_ADDS_WARN, 3);
			self:StartStatusBarTimer(90, "Elementals despawn in", "Interface\\Icons\\Spell_Frost_SummonWaterElemental");
		end
		
	elseif event == "FlameWreath" then
		self:AddSpecialWarning(DBM_ARAN_DO_NOT_MOVE);
		self:Announce(DBM_ARAN_DO_NOT_MOVE, 1);
		self:StartStatusBarTimer(20.5, "Flame Wreath", "Interface\\Icons\\Spell_Holy_InnerFire");
		
	elseif event == "Blizzard" then
		self:StartStatusBarTimer(40, "Blizzard", "Interface\\Icons\\Spell_Frost_IceStorm");
	end
end