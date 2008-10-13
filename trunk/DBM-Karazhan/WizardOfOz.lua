local Oz = DBM:NewBossMod("Oz", DBM_OZ_NAME, DBM_OZ_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 7);

Oz.Version			= "1.0";
Oz.Author			= "Tandanu";

Oz:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START"
);

Oz:RegisterCombat("YELL", DBM_OZ_YELL_DOROTHEE, nil, nil, DBM_OZ_CRONE_NAME, 25);

Oz:AddOption("RangeCheck", true, DBM_OZ_OPTION_1);

Oz:AddBarOption("Roar")
Oz:AddBarOption("Strawman")
Oz:AddBarOption("Tinhead")
Oz:AddBarOption("Tito")

function Oz:OnCombatStart(delay)
	self:StartStatusBarTimer(14.5 - delay, "Roar", "Interface\\Icons\\Ability_Druid_ChallangingRoar");
	self:StartStatusBarTimer(24 - delay, "Strawman", "Interface\\Icons\\INV_Helmet_34");
	self:StartStatusBarTimer(33 - delay, "Tinhead", "Interface\\Icons\\INV_Helmet_02");
	self:StartStatusBarTimer(47.5 - delay, "Tito", "Interface\\Icons\\Ability_Mount_WhiteDireWolf");
end

function Oz:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Oz:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_OZ_YELL_ROAR then
			self:Announce(DBM_OZ_WARN_ROAR, 2);
		elseif arg1 == DBM_OZ_YELL_STRAWMAN then
			self:Announce(DBM_OZ_WARN_STRAWMAN, 2);
		elseif arg1 == DBM_OZ_YELL_TINHEAD then
			self:Announce(DBM_OZ_WARN_TINHEAD, 2);
		elseif arg1 == DBM_OZ_YELL_CRONE then
			self:Announce(DBM_OZ_WARN_CRONE, 3);
			if self.Options.RangeCheck then
				DBM_Gui_DistanceFrame_Show();
			end
		end
		
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 31014 then
			if not self:GetStatusBarTimerTimeLeft("Tito") then
				self:StartStatusBarTimer(47.5, "Tito", "Interface\\Icons\\Ability_Mount_WhiteDireWolf");
			end
			self:UpdateStatusBarTimer("Tito", 46.5, 47.5);
			
			self:Announce(DBM_OZ_WARN_TITO, 2);
		end
	end
end
