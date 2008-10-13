local Kael = DBM:NewBossMod("KaelThas", DBM_KAEL_NAME, DBM_KAEL_DESCRIPTION, DBM_TEMPEST_KEEP, DBM_EYE_TAB, 4);

Kael.Version	= "1.3";
Kael.Author		= "Tandanu";

local lastConflag 		= 0;
local MCTargets			= {};
local MCIcons			= {
	[1]	= false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false
};
local weaponFrame		= false;
local phase2			= false;
local phase5			= false;
local weaponHealth		= {
	[1] = 100,
	[2] = 100,
	[3] = 100,
	[4] = 100,
	[5] = 100,
	[6] = 100,
	[7] = 100
};
local addFrame		= false;
local addHealth		= {
	[1] = 100,
	[2] = 100,
	[3] = 100,
	[4] = 100,
};
local lastEgg		= 0;
local gravityLapse	= false;
local phase = 1

Kael:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_MISSED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
);

Kael:AddOption("WarnPhase", true, DBM_KAEL_OPTION_PHASE);
Kael:AddOption("ThalaIcon", true, DBM_KAEL_OPTION_ICON_P1);
Kael:AddOption("ThalaWhisper", true, DBM_KAEL_OPTION_WHISPER_P1);
Kael:AddOption("RangeCheck", true, DBM_KAEL_OPTION_RANGECHECK);
Kael:AddOption("WarnConflag", true, DBM_KAEL_OPTION_CONFLAG);
Kael:AddOption("WarnConflag2", false, DBM_KAEL_OPTION_CONFLAG2);
Kael:AddOption("TimerConflag2", false, DBM_KAEL_OPTION_CONFLAGTIMER2);
Kael:AddOption("WarnFear", true, DBM_KAEL_OPTION_FEAR);
Kael:AddOption("WarnFearSoon", true, DBM_KAEL_OPTION_FEARSOON);
Kael:AddOption("WarnToy", true, DBM_KAEL_OPTION_TOY);
--Kael:AddOption("ShowFrame", true, DBM_KAEL_OPTION_FRAME);
--Kael:AddOption("ShowAddFrame", true, DBM_KAEL_OPTION_ADDFRAME);
Kael:AddOption("WarnPyro", false, DBM_KAEL_OPTION_PYRO);
Kael:AddOption("WarnBarrier", true, DBM_KAEL_OPTION_BARRIER);
Kael:AddOption("WarnBarrier2", false, DBM_KAEL_OPTION_BARRIER2);
Kael:AddOption("WarnPhoenix", true, DBM_KAEL_OPTION_PHOENIX);
Kael:AddOption("WarnMC", true, DBM_KAEL_OPTION_WARNMC);
Kael:AddOption("IconMC", true, DBM_KAEL_OPTION_ICONMC);
Kael:AddOption("WarnGravity", true, DBM_KAEL_OPTION_GRAVITY);

Kael:AddBarOption("Thaladred")
Kael:AddBarOption("Lord Sanguinar")
Kael:AddBarOption("Capernian")
Kael:AddBarOption("Telonicus")
Kael:AddBarOption("Gaze Cooldown")
Kael:AddBarOption("Next Fear")
Kael:AddBarOption("Fear")
Kael:AddBarOption("Conflagration: (.*)")
Kael:AddBarOption("Remote Toy: (.*)")
Kael:AddBarOption("Phase 3")
Kael:AddBarOption("Phase 4")
Kael:AddBarOption("Next Shock Barrier")
Kael:AddBarOption("Shock Barrier")
Kael:AddBarOption("Phoenix")
Kael:AddBarOption("Rebirth")
Kael:AddBarOption("Pyroblast")
Kael:AddBarOption("Gravity Lapse")
Kael:AddBarOption("Next Gravity Lapse")

Kael:SetCreatureID(19622)
Kael:RegisterCombat("yell", DBM_KAEL_YELL_PHASE1)
Kael:SetMinCombatTime(60)

function Kael:OnCombatStart(delay)
	phase = 1
	if self.Options.WarnPhase then
		self:Announce(DBM_KAEL_WARN_PHASE1, 1);
	end
	self:StartStatusBarTimer(32 - delay, "Thaladred", "Interface\\Icons\\Spell_Nature_WispSplode");
	MCTargets = {};
	MCIcons = {
		[1]	= false,
		[2] = false,
		[3] = false,
		[4] = false,
		[5] = false,
		[6] = false,
		[7] = false,
		[8] = false
	};
	phase2 = false;
	phase5 = false;
	weaponHealth = {
		[1] = 100,
		[2] = 100,
		[3] = 100,
		[4] = 100,
		[5] = 100,
		[6] = 100,
		[7] = 100
	};
	addHealth = {
		[1] = 100,
		[2] = 100,
		[3] = 100,
		[4] = 100,
	};
end

function Kael:OnCombatEnd()
	if self.Options.RangeCheck then
		DBM_Gui_DistanceFrame_Hide();
	end
	if weaponFrame then
		weaponFrame:Hide();
	end
	if addFrame then
		addFrame:Hide();
	end
	phase = 1
end

function Kael:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_EMOTE" and arg1 then
		local _, _, target = arg1:find(DBM_KAEL_EMOTE_THALADRED_TARGET);
		if target then
			self:SendSync("ThalaTarget"..target);
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_KAEL_YELL_PHASE2 then
			self:SendSync("Phase2");
		elseif arg1 == DBM_KAEL_YELL_PHASE3 then
			self:SendSync("Phase3");
		elseif arg1 == DBM_KAEL_YELL_PHASE4 then
			self:SendSync("Phase4");
		elseif arg1 == DBM_KAEL_YELL_PHASE5 then
			self:SendSync("Phase5");
		elseif arg1 == DBM_KAEL_YELL_CAPERNIAN_DOWN then
			if self.Options.RangeCheck then
				DBM_Gui_DistanceFrame_Hide();
			end
		elseif arg1 == DBM_KAEL_YELL_PHASE1_SANGUINAR then
			self:Announce(DBM_KAEL_WARN_INC:format(DBM_KAEL_SANGUINAR), 1);
			self:StartStatusBarTimer(12.5, "Lord Sanguinar", "Interface\\Icons\\Spell_Nature_WispSplode");
		elseif arg1 == DBM_KAEL_YELL_PHASE1_CAPERNIAN then
			self:Announce(DBM_KAEL_WARN_INC:format(DBM_KAEL_CAPERNIAN), 1);
			self:StartStatusBarTimer(7, "Capernian", "Interface\\Icons\\Spell_Nature_WispSplode");
			self:EndStatusBarTimer("Next Fear");
			self:UnScheduleSelf("FearSoon");
			if self.Options.RangeCheck then
				DBM_Gui_DistanceFrame_Show();
			end
		elseif arg1 == DBM_KAEL_YELL_PHASE1_TELONICUS then
			self:Announce(DBM_KAEL_WARN_INC:format(DBM_KAEL_TELONICUS), 1);
			self:StartStatusBarTimer(8.4, "Telonicus", "Interface\\Icons\\Spell_Nature_WispSplode");
			if self.Options.RangeCheck then
				DBM_Gui_DistanceFrame_Hide();
			end
		elseif arg1 == DBM_KAEL_YELL_GRAVITY_LAPSE or arg1 == DBM_KAEL_YELL_GRAVITY_LAPSE2 then
			self:SendSync("GravityLapse");
		end
	elseif event == "SPELL_CAST_START" and arg1 then
		if arg1.spellId == 39427 then -- ?
			self:SendSync("CastFear")
		elseif arg1.spellId == 36819 then
			self:SendSync("Pyroblast")
		end
	elseif event == "SPELL_MISSED" then
		if arg1.spellId == 39427 then -- ?
			self:SendSync("Fear")
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 39427 then -- ?
			self:SendSync("Fear");
		elseif arg1.spellId == 37018 then -- ?
			self:SendSync("Conflag"..tostring(arg1.destName))
		elseif arg1.spellId == 36797 then
			self:SendSync("MC"..tostring(arg1.destName))
		elseif arg1.spellId == 37027 then
			self:SendSync("Toy"..tostring(arg1.destName))
		elseif arg1.spellId == 36815 then
			self:SendSync("Barrier");
		end
	elseif event == "SPELL_AURA_REMOVED" then
		if arg1.spellId == 36815 then
			self:SendSync("BarrierDown")
		elseif arg1.spellId == 36797 then
			self:SendSync("BrokeMC"..tostring(arg1.destName))
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 36723 then
			self:SendSync("Phoenix")
		end
	elseif event == "FearSoon" then
		if self.Options.WarnFearSoon then
			self:Announce(DBM_KAEL_WARN_FEAR_SOON, 2);
		end
	elseif event == "WarnPhase3" then
		if self.Options.WarnPhase then
			self:Announce(DBM_KAEL_WARN_PHASE3, 1);
		end
	elseif event == "Phase3" then
		self:StartStatusBarTimer(173, "Phase 4", "Interface\\Icons\\Spell_Shadow_BloodBoil");
		if self.Options.RangeCheck then
			DBM_Gui_DistanceFrame_Show();
		end
	elseif event == "BarrierWarn" then
		if self.Options.WarnBarrier and (not phase5 or self.Options.WarnBarrier2) then
			self:Announce(DBM_KAEL_WARN_BARRIER_SOON, 2);
		end
	elseif event == "AnnounceMCTargets" then
		if self.Options.WarnMC then
			local targetString = "";
			for i, v in ipairs(MCTargets) do
				targetString = targetString..">"..v.."<, ";
			end
			if targetString ~= "" then
				self:Announce(DBM_KAEL_WARN_MC_TARGETS:format(targetString:sub(0, -3)), 1);
			end
		end
		MCTargets = {};
	elseif event == "ClearIcon" and arg1 then
		MCIcons[arg1] = false;
	elseif event == "GravityLapseEnd" then
		gravityLapse = false;
		self:ScheduleSelf(55, "GravityWarn");
		self:StartStatusBarTimer(60, "Next Gravity Lapse", "Interface\\Icons\\Spell_Magic_FeatherFall");
	elseif event == "GravityWarn" and self.Options.WarnGravity then
		self:Announce(DBM_KAEL_GRAVITY_SOON, 2);
	elseif event == "GravityEndWarn" and self.Options.WarnGravity then
		self:Announce(DBM_KAEL_GRAVITY_END_SOON, 3);
	end
end

function Kael:OnSync(msg)
	if msg:sub(0, 11) == "ThalaTarget" then
		msg = msg:sub(12);
		if msg then
			if msg == UnitName("player") then
				self:AddSpecialWarning(DBM_KAEL_SPECWARN_THALADRED_TARGET);
			end
			self:Announce(DBM_KAEL_WARN_THALADRED_TARGET:format(msg), 2);
			if self.Options.ThalaIcon then
				self:SetIcon(msg, 15);
			end
			if self.Options.ThalaWhisper and self.Options.Announce and DBM.Rank >= 1 then
				self:SendHiddenWhisper(DBM_KAEL_WHISPER_THALADRED_TARGET, msg);
			end
			self:StartStatusBarTimer(8.5, "Gaze Cooldown", "Interface\\Icons\\Spell_Fire_BurningSpeed");
		end
	elseif msg:sub(0, 7) == "Conflag" and (GetTime() - lastConflag) > 5 then -- spam protection....
		msg = msg:sub(8);
		if msg then
			lastConflag = GetTime();
			if (self.Options.WarnConflag and not phase2) or (self.Options.WarnConflag2 and self.Options.WarnConflag and phase2) then
				self:Announce(DBM_KAEL_WARN_CONFLAGRATION:format(msg), 1);
			end
			if phase2 and self.Options.TimerConflag2 then
				self:StartStatusBarTimer(9.5, "Conflagration: "..msg, "Interface\\Icons\\Spell_Fire_Incinerate", true);
			elseif not phase2 then
				self:StartStatusBarTimer(9.5, "Conflagration: "..msg, "Interface\\Icons\\Spell_Fire_Incinerate");
			end
		end
	elseif msg:sub(0, 3) == "Toy" and not phase2 then
		msg = msg:sub(4);
		if msg then
			if self.Options.WarnToy then				
				self:Announce(DBM_KAEL_WARN_REMOTETOY:format(msg), 1);
			end
			self:StartStatusBarTimer(60, "Remote Toy: "..msg, "Interface\\Icons\\INV_Misc_Urn_01");
		end
	elseif msg == "Phase2" then
		phase = 2
		phase2 = true;
		if self.Options.WarnPhase then
			self:Announce(DBM_KAEL_WARN_PHASE2, 1);
		end
		self:StartStatusBarTimer(105, "Phase 3", "Interface\\Icons\\Spell_Shadow_AnimateDead");
		self:ScheduleSelf(105, "WarnPhase3");
		if self.Options.ShowFrame and DBMGui and DBMGui.CreateInfoFrame then
			if weaponFrame then
				weaponHealth = {
					[1] = 100,
					[2] = 100,
					[3] = 100,
					[4] = 100,
					[5] = 100,
					[6] = 100,
					[7] = 100
				};
				self:UpdateHealth();
				weaponFrame:Show();
			else
				weaponFrame = DBMGui:CreateInfoFrame(DBM_KAEL_INFOFRAME_TITLE);
				if (not weaponFrame) then 
--					self:AddMsg("Error while creating frame: Not supported in DBMv4");
					return;
				end
				for i = 1, 7 do
					weaponFrame["Bar"..i] = weaponFrame:CreateStatusBar(0, 100, 100, nil, DBM_KAEL_WEAPONS_NAMES[i], "100%");
				end
			end
		end
	elseif msg == "Phase3" then
		phase = 3
		self:ScheduleSelf(10, "Phase3");
		if self.Options.ShowAddFrame and DBMGui and DBMGui.CreateInfoFrame then
			if addFrame then
				addHealth = {
					[1] = 100,
					[2] = 100,
					[3] = 100,
					[4] = 100,
				};
				self:UpdateHealth();
				addFrame:Show();
			else
				addFrame = DBMGui:CreateInfoFrame(DBM_KAEL_INFOFRAME_ADDS_TITLE);
				if (not addFrame) then 
					return;
				end
				for i = 1, 4 do
					addFrame["Bar"..i] = addFrame:CreateStatusBar(0, 100, 100, nil, DBM_KAEL_ADVISORS_NAMES[i], "100%");
				end
			end
		end
	elseif msg == "Phase4" then
		phase = 4
		phase5 = false;
		if self.Options.WarnPhase then
			self:Announce(DBM_KAEL_WARN_PHASE4, 1);
		end
		self:ScheduleSelf(55, "BarrierWarn");
		self:StartStatusBarTimer(60, "Next Shock Barrier", "Interface\\Icons\\Spell_Nature_LightningShield");
		self:StartStatusBarTimer(50, "Phoenix", "Interface\\Icons\\Spell_FireResistanceTotem_01");
	elseif msg == "Phase5" then
		phase = 5
		phase5 = true;
		if self.Options.WarnPhase then
			self:Announce(DBM_KAEL_WARN_PHASE5, 1);
		end
		gravityLapse = false;
		self:ScheduleSelf(53, "GravityWarn");
		self:StartStatusBarTimer(58, "Next Gravity Lapse", "Interface\\Icons\\Spell_Magic_FeatherFall");
		
	elseif msg == "CastFear" then
		if self.Options.WarnFear then
			self:Announce(DBM_KAEL_WARN_FEAR, 2);
		end
		self:UnScheduleSelf("FearSoon");
		self:StartStatusBarTimer(31, "Next Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
		self:ScheduleSelf(28, "FearSoon");
		self:StartStatusBarTimer(1.5, "Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
	elseif msg == "Fear" then
		if not self:GetStatusBarTimerTimeLeft("Next Fear") then
			self:StartStatusBarTimer(29.5, "Next Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
		end
		if not self:GetSelfScheduleTimeLeft("FearSoon") then
			self:ScheduleSelf(26.5, "FearSoon");
		end
	elseif msg == "Pyroblast" then
		if self.Options.WarnPyro then
			self:Announce(DBM_KAEL_WARN_PYRO, 2);
		end
		self:StartStatusBarTimer(4, "Pyroblast", "Interface\\Icons\\Spell_Fire_Fireball02");
	elseif msg == "Barrier" then
		if self.Options.WarnBarrier and (not phase5 or self.Options.WarnBarrier2) then
			self:Announce(DBM_KAEL_WARN_BARRIER_NOW, 3);
		end
		if not phase5 then
			self:ScheduleSelf(55, "BarrierWarn");
			self:StartStatusBarTimer(60, "Next Shock Barrier", "Interface\\Icons\\Spell_Nature_LightningShield");
		end
		self:StartStatusBarTimer(10, "Shock Barrier", "Interface\\Icons\\Spell_Nature_LightningShield");
	elseif msg == "BarrierDown" then
		if self.Options.WarnBarrier and (not phase5 or self.Options.WarnBarrier2) then
			self:Announce(DBM_KAEL_WARN_BARRIER_DOWN, 3);
		end
	elseif msg == "Phoenix" then
		if self.Options.WarnPhoenix then
			self:Announce(DBM_KAEL_WARN_PHOENIX, 2);
		end
	elseif msg:sub(0, 2) == "MC" then
		msg = msg:sub(3);
		if msg then
			table.insert(MCTargets, msg);
			if #MCTargets >= 3 then
				self:UnScheduleSelf("AnnounceMCTargets");
				self:OnEvent("AnnounceMCTargets");
			end
			self:UnScheduleSelf("AnnounceMCTargets");
			self:ScheduleSelf(1, "AnnounceMCTargets");
			
			local iconID = 0;
			for i = 8, 1, -1 do
				if not MCIcons[i] then
					iconID = i;
					MCIcons[i] = msg;
					break;
				end
			end
			if self.Options.IconMC and iconID ~= 0 and self.Options.Announce and DBM.Rank >= 1 then
				self:SetIcon(msg, 25, iconID);
				self:ScheduleSelf(25, "ClearIcon", iconID);
			end

		end
	elseif msg:sub(0, 7) == "BrokeMC" then
		msg = msg:sub(8);
		if msg then
			for i, v in pairs(MCIcons) do
				if v == msg then
					self:OnEvent("ClearIcon", i);
					break;
				end
			end
		end
	elseif msg == "Egg" and not gravityLapse then
		self:Announce(DBM_KAEL_WARN_REBIRTH, 3);
		self:StartStatusBarTimer(15, "Rebirth", "Interface\\Icons\\INV_Relics_TotemofRebirth");
	elseif msg == "GravityLapse" then
		gravityLapse = true;
		if self.Options.WarnGravity then
			self:Announce(DBM_KAEL_WARN_GRAVITY_LAPSE, 3);
		end
		self:StartStatusBarTimer(32.5, "Gravity Lapse", "Interface\\Icons\\Spell_Magic_FeatherFall");
		self:ScheduleSelf(32.5, "GravityLapseEnd");
		self:ScheduleSelf(27.5, "GravityEndWarn");
	end
end

function Kael:GetBossHP()
	if phase <= 3 then
		return DBM_GENERIC_PHASE_MSG:format(phase)
	end
end

function Kael:UpdateHealth()
	if weaponFrame then
		for i = 1, 7 do
			weaponFrame["Bar"..i]:SetValue(weaponHealth[i]);
			
			if weaponHealth[i] > 50 then
				weaponFrame["Bar"..i]:GetObject():SetStatusBarColor(0, 1, 0);
			elseif weaponHealth[i] > 20 then
				weaponFrame["Bar"..i]:GetObject():SetStatusBarColor(1, 0.6, 0);
			else
				weaponFrame["Bar"..i]:GetObject():SetStatusBarColor(1, 0, 0);
			end
			
			if weaponHealth[i] > 0 then
				getglobal(weaponFrame["Bar"..i]:GetObject():GetName().."RightText"):SetText(weaponHealth[i].."%");
			else
				getglobal(weaponFrame["Bar"..i]:GetObject():GetName().."RightText"):SetText(DBM_DEAD:lower());
			end
		end
	end
	
	if addFrame then
		for i = 1, 4 do
			addFrame["Bar"..i]:SetValue(addHealth[i]);
			
			if addHealth[i] > 50 then
				addFrame["Bar"..i]:GetObject():SetStatusBarColor(0, 1, 0);
			elseif addHealth[i] > 20 then
				addFrame["Bar"..i]:GetObject():SetStatusBarColor(1, 0.6, 0);
			else
				addFrame["Bar"..i]:GetObject():SetStatusBarColor(1, 0, 0);
			end
			
			if addHealth[i] > 0 then
				getglobal(addFrame["Bar"..i]:GetObject():GetName().."RightText"):SetText(addHealth[i].."%");
			else
				getglobal(addFrame["Bar"..i]:GetObject():GetName().."RightText"):SetText(DBM_DEAD:lower());
			end
		end
	end
end

Kael.UpdateInterval = 0.2;
function Kael:OnUpdate(elapsed)
	if phase2 then
		local egg = false;
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") then
				if DBM_KAEL_WEAPONS[UnitName("raid"..i.."target")] then
					weaponHealth[DBM_KAEL_WEAPONS[UnitName("raid"..i.."target")]] = UnitHealth("raid"..i.."target");
				elseif DBM_KAEL_ADVISORS[UnitName("raid"..i.."target")] then
					addHealth[DBM_KAEL_ADVISORS[UnitName("raid"..i.."target")]] = UnitHealth("raid"..i.."target");
				elseif UnitName("raid"..i.."target") == DBM_KAEL_EGG then
					egg = UnitHealth("raid"..i.."target");
				end
			end
		end
		self:UpdateHealth();

		local weaponsDown = true;
		for i = 1, 7 do
			if weaponHealth[i] > 0 then
				weaponsDown = false;
			end
		end
		if weaponsDown and weaponFrame then
			weaponFrame:Hide();
		end
		
		local addsDown = true;
		for i = 1, 4 do
			if addHealth and addHealth[i] > 0 then
				addsDown = false;
			end
		end
		if addsDown and addFrame then
			addFrame:Hide();
		end
		
		if egg and egg > 95 and (GetTime() - lastEgg) > 7.5 then
			lastEgg = GetTime();
			self:SendSync("Egg");
		end	
	end
end
