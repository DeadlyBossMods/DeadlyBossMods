local BBW = DBM:NewBossMod("BigBadWolf", DBM_BBW_NAME, DBM_BBW_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 5);

BBW.Version			= "1.0";
BBW.Author			= "Tandanu";

BBW:RegisterEvents(
	"SPELL_AURA_APPLIED"
);

BBW:RegisterCombat("YELL", DBM_BBW_YELL_1);

BBW:AddOption("FearWarn", true, DBM_BBW_OPTION_1);
BBW:AddOption("Whisper", true, DBM_BBW_OPTION_2);

BBW:AddBarOption("Fear")
BBW:AddBarOption("Red Riding Hood")
BBW:AddBarOption("Next Red Riding Hood")

function BBW:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 30753 then
			local target = tostring(arg1.destName)
			if target == UnitName("player") then
				self:AddSpecialWarning(DBM_BBW_RUN_AWAY)
			end
			self:SendSync(target)		
		elseif arg1.spellId == 30752 then
			self:StartStatusBarTimer(24, "Fear", "Interface\\Icons\\Ability_Devour");
			if self.Options.FearWarn then
				self:Announce(DBM_BBW_FEAR_WARN, 2);
			end
			self:UnScheduleSelf("FearWarning", "soon");
			self:ScheduleSelf(23, "FearWarning", "soon");
		end
		
	elseif event == "ClearIcon" and arg1 then
		DBM.ClearIconByName(arg1);
		
	elseif event == "FearWarning" and arg1 == "soon" and self.Options.FearWarn then
		self:Announce(DBM_BBW_FEAR_SOON, 2);
	
	elseif event == "RRHSoonWarn" then
		self:Announce(DBM_BBW_RRH_SOON_WARN, 1);
	end
end

function BBW:OnSync(target)
	if target then
		if self.Options.Whisper and self.Options.Announce and DBM.Rank >= 1 then
			self:SendHiddenWhisper(DBM_BBW_RUN_AWAY_WHISP, target);			
		end
		self:EndStatusBarTimer("Next Red Riding Hood");
		self:StartStatusBarTimer(30, "Next Red Riding Hood", "Interface\\Icons\\INV_Helmet_28");
		self:StartStatusBarTimer(20, "Red Riding Hood", "Interface\\Icons\\INV_Helmet_28");
		self:Announce(string.format(DBM_BBW_RRH_WARN, target), 3);
		self:SetIcon(target, 20);
		self:ScheduleSelf(20, "ClearIcon", target);
		self:ScheduleSelf(27, "RRHSoonWarn");
	end
end
