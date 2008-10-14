local Mag = DBM:NewBossMod("Magtheridon", DBM_MAG_NAME, DBM_MAG_DESCRIPTION, DBM_MAGS_LAIR, DBMGUI_TAB_OTHER_BC, 3);

Mag.Version		= "1.0";
Mag.Author		= "Tandanu";

Mag:RegisterCombat("EMOTE", DBM_MAG_EMOTE_PULL);

Mag:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

Mag:AddOption("WarnInfernal", true, DBM_MAG_OPTION_1);
Mag:AddOption("WarnHeal", true, DBM_MAG_OPTION_2);
Mag:AddOption("WarnNova", true, DBM_MAG_OPTION_3);

Mag:AddBarOption("Phase 2")
Mag:AddBarOption("Heal")
Mag:AddBarOption("Blast Nova")

function Mag:OnCombatStart(delay)
	self:StartStatusBarTimer(120 - delay, "Phase 2", "Interface\\Icons\\INV_Weapon_Halberd16");
	self:ScheduleSelf(60, "Phase2Warn", 60);
	self:ScheduleSelf(90, "Phase2Warn", 30);
	self:ScheduleSelf(110, "Phase2Warn", 10);
end

function Mag:OnEvent(event, arg1)
	if event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 30511 and self.Options.WarnInfernal then
			self:Announce(DBM_MAG_WARN_INFERNAL, 2);
		end
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 30528 then
			if self.Options.WarnHeal then
				self:Announce(DBM_MAG_WARN_HEAL, 1);
			end
			self:StartStatusBarTimer(2, "Heal", "Interface\\Icons\\Spell_Shadow_ChillTouch");
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 and string.find(arg1, DBM_MAG_YELL_PHASE2) then -- to support stupid german localization :(
			self:Announce(DBM_MAG_WARN_P2, 3);
			self:StartStatusBarTimer(54, "Blast Nova", "Interface\\Icons\\Spell_Fire_SealOfFire");
			self:ScheduleSelf(48, "NovaWarn");
		end
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_MAG_EMOTE_NOVA then
			if self.Options.WarnNova then
				self:Announce(DBM_MAG_WARN_NOVA_NOW, 3)
			end
			self:StartStatusBarTimer(54, "Blast Nova", "Interface\\Icons\\Spell_Fire_SealOfFire");
			self:ScheduleSelf(48, "NovaWarn");
		end
	elseif event == "Phase2Warn" and arg1 then
		self:Announce(string.format(DBM_MAG_PHASE2_WARN, arg1), 2);
	elseif event == "NovaWarn" and self.Options.WarnNova then
		self:Announce(DBM_MAG_WARN_NOVA_SOON, 2);
	end
end