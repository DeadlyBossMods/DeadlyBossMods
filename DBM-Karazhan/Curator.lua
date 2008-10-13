local Curator = DBM:NewBossMod("Curator", DBM_CURA_NAME, DBM_CURA_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 8);

Curator.Version			= "1.0";
Curator.Author			= "Tandanu";

Curator:RegisterEvents("CHAT_MSG_MONSTER_YELL");

Curator:RegisterCombat("YELL", DBM_CURA_YELL_PULL);

Curator:AddBarOption("Evocation")
Curator:AddBarOption("Next Evocation")

Curator:AddOption("RangeCheck", true, DBM_MOV_OPTION_1, function()
	DBM:GetMod("Curator").Options.RangeCheck = not DBM:GetMod("Curator").Options.RangeCheck;
	
	if DBM:GetMod("Curator").Options.RangeCheck and DBM:GetMod("Curator").InCombat then
		DBM_Gui_DistanceFrame_Show();
	elseif not DBM:GetMod("Curator").Options.RangeCheck and DBM:GetMod("Curator").InCombat then
		DBM_Gui_DistanceFrame_Hide();
	end
end);

function Curator:OnCombatStart()
	self:StartStatusBarTimer(109, "Next Evocation", "Interface\\Icons\\Spell_Nature_Purge");
	self:ScheduleSelf(106, "EvoWarn", "soon");
	self:ScheduleAnnounce(49, DBM_CURA_EVO_1MIN, 1)
	
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Show();
	end
end

function Curator:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
end

function Curator:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_CURA_YELL_OOM then
			self:StartStatusBarTimer(115, "Next Evocation", "Interface\\Icons\\Spell_Nature_Purge");
			self:StartStatusBarTimer(20, "Evocation", "Interface\\Icons\\Spell_Nature_Purge");
			self:Announce(DBM_CURA_EVO_NOW, 3);
			self:ScheduleAnnounce(55, DBM_CURA_EVO_1MIN, 1)
			self:UnScheduleSelf("EvoWarn", "soon");
			self:ScheduleSelf(112, "EvoWarn", "soon");
		end
		
	elseif event == "EvoWarn" then
		self:Announce(DBM_CURA_EVO_SOON, 2);
		
	end
end