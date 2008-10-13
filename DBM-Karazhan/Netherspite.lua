local Netherspite = DBM:NewBossMod("Netherspite", DBM_NS_NAME, DBM_NS_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 11);

Netherspite.Version			= "1.1";
Netherspite.Author			= "Tandanu";
Netherspite.Phase			= 1;


Netherspite:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE"
);

Netherspite:RegisterCombat("COMBAT");

Netherspite:AddOption("PhaseWarn", true, DBM_NS_OPTION_1);
Netherspite:AddOption("PhasePreWarn", true, DBM_NS_OPTION_2);
Netherspite:AddOption("VoidWarn", true, DBM_NS_OPTION_3);
Netherspite:AddOption("BreathWarn", true, DBM_NS_OPTION_4);

Netherspite:AddBarOption("Enrage")
Netherspite:AddBarOption("Banish Phase")
Netherspite:AddBarOption("Portal Phase")
Netherspite:AddBarOption("Netherbreath")

function Netherspite:OnCombatStart(delay)
	self.Phase = 1;
	self:StartStatusBarTimer(62 - delay, "Portal Phase", "Interface\\Icons\\Spell_Arcane_PortalIronForge");
	self:ScheduleSelf(57 - delay, "PhaseWarning", 2);
	
	self:StartStatusBarTimer(540 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:ScheduleSelf(240 - delay, "EnrageWarn", 300);
	self:ScheduleSelf(420 - delay, "EnrageWarn", 120);
	self:ScheduleSelf(480 - delay, "EnrageWarn", 60);
	self:ScheduleSelf(510 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(530 - delay, "EnrageWarn", 10);
end

function Netherspite:OnCombatEnd()
	self.Phase = 1;
end

function Netherspite:OnEvent(event, arg1)
	if event == "SPELL_CAST_START" then
		if arg1.spellId == 38523 then -- ???
			if self.Options.BreathWarn then
				self:Announce(DBM_NS_WARN_BREATH, 2);
			end
			self:StartStatusBarTimer(2.5, "Netherbreath", "Interface\\Icons\\Spell_Arcane_MassDispel");
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 37014 or arg1.spellId == 37063 then -- ??
			if self.Options.VoidWarn then
				self:Announce(DBM_NS_WARN_VOID_ZONE, 1);
			end
		end
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_NS_EMOTE_PHASE_2 then
			self.Phase = 2;
			self:EndStatusBarTimer("Portal Phase");
			self:StartStatusBarTimer(31, "Banish Phase", "Interface\\Icons\\Spell_Shadow_Cripple");
			self:ScheduleSelf(26, "PhaseWarning", 1);
			
			if self.Options.PhaseWarn then
				self:Announce(DBM_NS_WARN_BANISH, 3);
			end
		elseif arg1 == DBM_NS_EMOTE_PHASE_1 then
			self.Phase = 1;
			self:EndStatusBarTimer("Banish Phase");
			self:StartStatusBarTimer(61.5, "Portal Phase", "Interface\\Icons\\Spell_Arcane_PortalIronForge");
			self:ScheduleSelf(56.5, "PhaseWarning", 2);
			
			if self.Options.PhaseWarn then
				self:Announce(DBM_NS_WARN_PORTAL, 3);
			end
		end
	elseif event == "PhaseWarning" and arg1 and self.Options.PhasePreWarn then
		if arg1 == 1 then
			self:Announce(DBM_NS_WARN_PORTAL_SOON, 2);
		elseif arg1 == 2 then
			self:Announce(DBM_NS_WARN_BANISH_SOON, 2);
		end
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_NS_WARN_ENRAGE, (arg1/60), DBM_MIN), 1)
		else
			self:Announce(string.format(DBM_NS_WARN_ENRAGE, arg1, DBM_SEC), 3)
		end
	end
end
