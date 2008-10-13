local VoidReaver = DBM:NewBossMod("VoidReaver", DBM_VOIDREAVER_NAME, DBM_VOIDREAVER_DESCRIPTION, DBM_TEMPEST_KEEP, DBM_EYE_TAB, 2);

VoidReaver.Version		= "1.0";
VoidReaver.Author		= "Tandanu";

local lastTarget = nil;

VoidReaver:RegisterEvents(
	"UNIT_SPELLCAST_CHANNEL_START",
	"SPELL_CAST_SUCCESS"
);

VoidReaver:SetCreatureID(19516)
VoidReaver:RegisterCombat("combat")

VoidReaver:AddOption("WarnOrb", false, DBM_VOIDREAVER_OPTION_WARN_ORB);
VoidReaver:AddOption("YellOrb", true, DBM_VOIDREAVER_OPTION_YELL_ORB);
VoidReaver:AddOption("SoundWarning", false, DBM_VOIDREAVER_OPTION_SOUND);
VoidReaver:AddOption("IconOrb", false, DBM_VOIDREAVER_OPTION_ORB_ICON);
VoidReaver:AddOption("WarnPounding", true, DBM_VOIDREAVER_OPTION_WARN_POUNDING);
VoidReaver:AddOption("WarnPoundingSoon", true, DBM_VOIDREAVER_OPTION_WARN_POUNDINGSOON);

VoidReaver:AddBarOption("Enrage")
VoidReaver:AddBarOption("Next Pounding")
VoidReaver:AddBarOption("Pounding")

function VoidReaver:OnCombatStart(delay)

	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:ScheduleSelf(300 - delay, "EnrageWarn", 300);
	self:ScheduleSelf(480 - delay, "EnrageWarn", 120);
	self:ScheduleSelf(540 - delay, "EnrageWarn", 60);
	self:ScheduleSelf(570 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(590 - delay, "EnrageWarn", 10);
	
	self:StartStatusBarTimer(13 - delay, "Next Pounding", "Interface\\Icons\\Ability_ThunderClap");
	self:ScheduleSelf(8 - delay, "PoundingWarn");
end

function VoidReaver:OnEvent(event, arg1)
	if event == "UNIT_SPELLCAST_CHANNEL_START" and type(arg1) == "string" and UnitName(arg1) == DBM_VOIDREAVER_NAME then
		if UnitChannelInfo(arg1) == DBM_VOIDREAVER_POUNDING then
			self:SendSync("Pounding");
		end
		
	elseif event == "PoundingWarn" then
		if self.Options.WarnPoundingSoon then
			self:Announce(DBM_VOIDREAVER_WARN_POUNDING_SOON, 2);
		end
		
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_VOIDREAVER_WARN_ENRAGE, (arg1/60), DBM_MIN), 1);
		else
			self:Announce(string.format(DBM_VOIDREAVER_WARN_ENRAGE, arg1, DBM_SEC), 3);
		end
	elseif event == "SPELL_CAST_SUCCESS" then
		if arg1.spellId == 34172 then
			self:OnArcaneOrb(arg1.destName)
		end
	end
end



function VoidReaver:OnArcaneOrb(target)
	if type(target) ~= "string" or string.find(target, " ") then -- to filter out "Arcane Orb Target"....(wtf?)
		return;
	end
	
	
	if target == UnitName("player") then
		if self.Options.YellOrb then
			SendChatMessage(DBM_VOIDREAVER_YELL_ORB, "SAY");
		end
		self:AddSpecialWarning(DBM_VOIDREAVER_SPECWARN_ORB);
		if self.Options.SoundWarning then
			PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav"); 
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav");
		end 
	end
	

	if self.Options.IconOrb then
		self:SetIcon(target)
	end
	
	if self.Options.WarnOrb then
		self:Announce(string.format(DBM_VOIDREAVER_WARN_ORB, target), 1)
	end
end

function VoidReaver:OnSync(msg)
	if msg == "Pounding" then
		self:StartStatusBarTimer(14, "Next Pounding", "Interface\\Icons\\Ability_ThunderClap");
		self:StartStatusBarTimer(3, "Pounding", "Interface\\Icons\\Ability_ThunderClap");
		self:ScheduleSelf(9, "PoundingWarn");
		if self.Options.WarnPounding then
			self:Announce(DBM_VOIDREAVER_WARN_POUNDING, 3);
		end
	end
end
