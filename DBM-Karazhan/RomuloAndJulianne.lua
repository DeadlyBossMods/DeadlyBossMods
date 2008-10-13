local RaJ = DBM:NewBossMod("RomuloAndJulianne", DBM_RJ_NAME, DBM_RJ_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 6);
--Edit by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
RaJ.Version			= "1.1";
RaJ.Author			= "Tandanu";

RaJ:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START"
);

RaJ:RegisterCombat("COMBAT", 5, DBM_RJ_JULIANNE, DBM_RJ_NAME, {DBM_RJ_ROMULO, DBM_RJ_JULIANNE}, 20);

RaJ:AddOption("WarnHeal", true, DBM_RJ_OPTION_1);
RaJ:AddOption("PosionWarn", true, DBM_RJ_OPTION_2);

RaJ:AddBarOption("Heal")

function RaJ:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 30841 then
			self:Announce(DBM_RJ_DARING_WARN, 2);
		elseif arg1.spellId == 30887 then
			self:Announce(DBM_RJ_DEVOTION_WARN, 2);
		elseif arg1.spellId == 30822 or arg1.spellId == 30830 then
			if target and self.Options.PosionWarn then
				self:Announce(string.format(DBM_RJ_POISON_WARN, tostring(arg1.destName)), 2);
			end
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_RJ_PHASE2_YELL then
			self:ScheduleSelf(3, "SetPhase");
		end
	elseif event == "SetPhase" then
		self.Phase = 2; --needed for combat end detection, because the "xyz dies." event is fired when you kill one of them in phase 1.
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 30878 and self.Options.WarnHeal then
			self:Announce(DBM_RJ_HEAL_WARN);
			self:StartStatusBarTimer(2, "Heal", "Interface\\Icons\\Spell_Holy_Heal");
		end
	end
end

function RaJ:OnCombatStart()
	self.Phase = 0;
end

function RaJ:OnCombatEnd()
	self.Phase = 0;
end
