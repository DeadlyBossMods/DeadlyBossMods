local Leotheras = DBM:NewBossMod("Leotheras", DBM_LEO_NAME, DBM_LEO_DESCRIPTION, DBM_COILFANG, DBM_SERPENT_TAB, 5);

Leotheras.Version			= "1.1";
Leotheras.Author			= "Tandanu";
Leotheras.Phase				= "normal";
Leotheras.WhirlSpam			= 0;
Leotheras.DemonSpam			= 0;
Leotheras.MinVersionToSync  = 2.70;

Leotheras:SetCreatureID(21215)
Leotheras:RegisterCombat("yell", DBM_LEO_YELL_PULL)

local demonTargets = {};

Leotheras:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED"
);

Leotheras:AddOption("WhirlWarn", true, DBM_LEO_OPTION_WHIRL);
Leotheras:AddOption("DemonWarn", true, DBM_LEO_OPTION_DEMON);
Leotheras:AddOption("WarnDemons", false, DBM_LEO_OPTION_DEMONWARN);

Leotheras:AddBarOption("Enrage")
Leotheras:AddBarOption("Demon Form")
Leotheras:AddBarOption("Normal Form")
Leotheras:AddBarOption("Next Whirlwind")
Leotheras:AddBarOption("Whirlwind")
Leotheras:AddBarOption("Inner Demons")

function Leotheras:OnCombatStart(delay)
	self.Phase = "normal";
	demonTargets = {};
	
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:ScheduleSelf(300 - delay, "EnrageWarn", 300);
	self:ScheduleSelf(480 - delay, "EnrageWarn", 120);
	self:ScheduleSelf(540 - delay, "EnrageWarn", 60);
	self:ScheduleSelf(570 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(590 - delay, "EnrageWarn", 10);
		
	self:ScheduleSelf(55, "PhaseWarn");
	self:StartStatusBarTimer(60, "Demon Form", "Interface\\Icons\\Spell_Shadow_Metamorphosis");
	
	self:StartStatusBarTimer(18, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
	self:ScheduleSelf(14, "WhirlWarn2");	
end

function Leotheras:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if string.find(arg1, DBM_LEO_YELL_DEMON) then
			self.Phase = "demon";
			
			self:Announce(DBM_LEO_WARN_DEMON_PHASE, 3);
			self:ScheduleSelf(55, "PhaseWarn");
			self:ScheduleSelf(60, "NormalForm");
			self:UnScheduleSelf("WhirlWarn");
			self:EndStatusBarTimer("Normal Form");
			self:EndStatusBarTimer("Demon Form");
			self:EndStatusBarTimer("Whirlwind");
			self:EndStatusBarTimer("Next Whirlwind");
			self:StartStatusBarTimer(60, "Normal Form", "Interface\\Icons\\INV_Weapon_ShortBlade_07");
--			self:StartStatusBarTimer(15, "Inner Demons in", "Interface\\Icons\\Spell_Shadow_ManaFeed"); -- seems to be on a random timer (but changed to a fixed timer in 2.1.0?)
--			self:ScheduleSelf(10, "DemonsSoon");

		elseif arg1 == DBM_LEO_YELL_SHADOW then
			self.Phase = "normal";
			self:Announce(DBM_LEO_WARN_SHADOW, 3);
			self:UnScheduleSelf("PhaseWarn");
			self:UnScheduleSelf("NormalForm");
			self:EndStatusBarTimer("Normal Form");
			self:EndStatusBarTimer("Demon Form");
			
			self:StartStatusBarTimer(22.5, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
			self:ScheduleSelf(18, "WhirlWarn2");
			
		elseif string.find(arg1, DBM_LEO_YELL_WHISPER) then
			if (GetTime() - self.DemonSpam) > 5 then
				if self.Options.DemonWarn then
					self:Announce(DBM_LEO_WARN_DEMONS_NOW, 2);
				end
				if not self:GetStatusBarTimerTimeLeft("Inner Demons") then
					self:StartStatusBarTimer(30, "Inner Demons", "Interface\\Icons\\Spell_Shadow_ManaFeed");
				end
			end
		end
		
	elseif event == "NormalForm" then
		self.Phase = "normal";
		
		self:Announce(DBM_LEO_WARN_NORMAL_PHASE, 3);
		self:ScheduleSelf(40, "PhaseWarn");
		self:EndStatusBarTimer("Normal Form");
		self:EndStatusBarTimer("Demon Form");
		self:StartStatusBarTimer(45, "Demon Form", "Interface\\Icons\\Spell_Shadow_Metamorphosis");
		
		self:StartStatusBarTimer(19, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
		
		self:ScheduleSelf(14, "WhirlWarn2");
		
	elseif event == "PhaseWarn" then
		if self.Phase == "normal" then
			self:Announce(DBM_LEO_WARN_DEMON_PHASE_SOON, 2);
		elseif self.Phase == "demon" then
			self:Announce(DBM_LEO_WARN_NORMAL_PHASE_SOON, 2);
		end
		
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 37640 then -- ?
			self:SendSync("GainWW");
		elseif arg1.spellId == 37676 then
			self:SendSync("Demon"..tostring(arg1.destName))
		end
		
	elseif event == "SPELL_AURA_REMOVED" then
		if arg1.spellId == 37640 then -- ?
			self:SendSync("FadeWW");
		end
	
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 37676 then
			self.DemonSpam = GetTime();
			if self.Options.DemonWarn then
				self:Announce(DBM_LEO_WARN_DEMONS_INC, 1);
			end
			self:StartStatusBarTimer(32.5, "Inner Demons", "Interface\\Icons\\Spell_Shadow_ManaFeed");
		end
		
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_LEO_WARN_ENRAGE, (arg1/60), DBM_MIN), 1);
		else
			self:Announce(string.format(DBM_LEO_WARN_ENRAGE, arg1, DBM_SEC), 3);
		end

	elseif event == "WhirlWarn" then
		if self.Options.WhirlWarn then
			self:Announce(DBM_LEO_WARN_WHIRL_SOON, 2);
		end
	elseif event == "WhirlWarn2" then
		if self.Options.WhirlWarn then
			self:Announce(DBM_LEO_WARN_WHIRL_SOON_2, 2);
		end
	elseif event == "WarnDemons" then
		if self.Options.WarnDemons then
			local targetString = "";
			for i, v in ipairs(demonTargets) do
				targetString = targetString..">"..v.."<, ";
			end
			self:Announce(DBM_LEO_WARN_DEMON_TARGETS:format(targetString:sub(0, -3)), 1);
		end
		demonTargets = {};
	end
end

function Leotheras:OnSync(msg)
	if msg == "GainWW" then
		if self.Options.WhirlWarn then
			self:Announce(DBM_LEO_WARN_WHIRL, 3);
		end
		self:EndStatusBarTimer("Next Whirlwind");
		self:StartStatusBarTimer(12, "Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
		self:ScheduleMethod(12, "SendSync", "FadeWW");
		
	elseif msg == "FadeWW" and self.Phase ~= "demon" then
		if self.Options.WhirlWarn then
			self:Announce(DBM_LEO_WARN_WHIRL_FADED, 2);
		end
		if not self:GetStatusBarTimerTimeLeft("Demon Form") or self:GetStatusBarTimerTimeLeft("Demon Form") > 18 then
			self:StartStatusBarTimer(20, "Next Whirlwind", "Interface\\Icons\\Ability_Whirlwind");
			self:ScheduleSelf(15, "WhirlWarn");
		end
	elseif msg:sub(0, 5) == "Demon" then
		msg = msg:sub(6);
		if msg then
			if self.Options.Announce and DBM.Rank >= 1 then
				self:SendHiddenWhisper(DBM_LEO_WHISPER_INNER_DEMON, msg);
			end
			if msg == UnitName("player") then
				self:AddSpecialWarning(DBM_LEO_SPECWARN_INNER_DEMON);
			end
			table.insert(demonTargets, msg);
			self:UnScheduleSelf("WarnDemons");
			self:ScheduleSelf(0.75, "WarnDemons");
		end
	end
end