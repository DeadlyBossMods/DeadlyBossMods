local Kazzak = DBM:NewBossMod("Kazzak", DBM_KAZZAK_NAME, DBM_KAZZAK_DESCRIPTION, DBM_HELLFIRE, DBMGUI_TAB_OTHER_BC, 4);

Kazzak.Version			= "1.0";
Kazzak.Author			= "Tandanu";
Kazzak.LastPull			= 0;
Kazzak.MinVersionToSync	= "2.70";

Kazzak:RegisterCombat("COMBAT", 2);

Kazzak:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_EMOTE"
);

Kazzak:AddOption("EnrageWarn", true, DBM_KAZZAK_OPTION_1);
Kazzak:AddOption("TwistedWarn", true, DBM_KAZZAK_OPTION_2);
Kazzak:AddOption("MarkWarn", true, DBM_KAZZAK_OPTION_3);
Kazzak:AddOption("Icon", true, DBM_KAZZAK_OPTION_4);
Kazzak:AddOption("Whisper", false, DBM_KAZZAK_OPTION_5);

Kazzak:AddBarOption("Enrage")
Kazzak:AddBarOption("Mark of Kazzak")

function Kazzak:OnCombatStart(delay) -- I don't want to use the yell for start detection because this would trigger the boss mod every time someone pulls Kazzak while you are in hellfire peninsula
	if (GetTime() - self.LastPull) < 20 then
		delay = GetTime() - self.LastPull; -- use more accurate delay if possible
	end
	local enrageTimer = 56;
	self:StartStatusBarTimer(enrageTimer - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy"); -- ?
	self:ScheduleSelf(enrageTimer - 45 - delay, "EnrageWarn", 45);
	self:ScheduleSelf(enrageTimer - 30 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(enrageTimer - 15 - delay, "EnrageWarn", 15);
	self:ScheduleSelf(enrageTimer - 5 - delay, "EnrageWarn", 5);
end

function Kazzak:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 21063 then
			if self.Options.TwistedWarn then
				self:Announce(string.format(DBM_KAZZAK_TWISTED_WARN, tostring(arg1.destName)))
			end
			
		elseif arg1.spellId == 32960 then
			local target = tostring(arg1.destName)
			if target == UnitName("player") then
				self:AddSpecialWarning(DBM_KAZZAK_MARK_SPEC_WARN);
				self:StartStatusBarTimer(8, "Mark of Kazzak", "Interface\\Icons\\Spell_Shadow_AntiShadow", true);
			elseif self.Options.Whisper and target then
				self:SendHiddenWhisper(DBM_KAZZAK_MARK_SPEC_WARN, target);
			end
			if target and self.Options.MarkWarn then
				self:Announce(string.format(DBM_KAZZAK_MARK_WARN, target))
			end
			if target and self.Options.Icon then
				self:SetIcon(target, 8);
			end
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_KAZZAK_YELL_PULL or arg1 == DBM_KAZZAK_YELL_PULL2 then
			self.LastPull = GetTime();
		end
		
	elseif event == "CHAT_MSG_MONSTER_EMOTE" then
		if arg1 == DBM_KAZZAK_EMOTE_ENRAGE and arg2 == DBM_KAZZAK_NAME then
			if self.Options.EnrageWarn then
				self:Announce(DBM_KAZZAK_WARN_ENRAGE);
			end
			self:ScheduleSelf(6, "NextEnrage");
		end
		
	elseif event == "EnrageWarn" and arg1 then
		if self.Options.EnrageWarn then
			if arg1 == 5 then
				self:Announce(DBM_KAZZAK_SUP_SOON);
			else
				self:Announce(string.format(DBM_KAZZAK_SUP_SEC, arg1));
			end
		end
	
	elseif event == "NextEnrage" then
		self:StartStatusBarTimer(54, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
		self:ScheduleSelf(9, "EnrageWarn", 45);
		self:ScheduleSelf(24, "EnrageWarn", 30);
		self:ScheduleSelf(39, "EnrageWarn", 15);
		self:ScheduleSelf(49, "EnrageWarn", 5);
	end
end