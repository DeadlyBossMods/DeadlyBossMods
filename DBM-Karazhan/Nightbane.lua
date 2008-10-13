local Nightbane = DBM:NewBossMod("Nightbane", DBM_NB_NAME, DBM_NB_DESCRIPTION, DBM_KARAZHAN, DBM_KARAZHAN_TAB, 13);
--Edit by Nightkiller@¤é¸¨ªh¿A(kc10577@¤Ú«¢;Azael)
Nightbane.Version			= "1.2";
Nightbane.Author			= "Tandanu";
Nightbane.BoneRain			= 0;
Nightbane.LastYell			= 0;
Nightbane.LastSmokeTarget	= nil;

Nightbane:RegisterCombat("YELL", DBM_NB_YELL_PULL);

Nightbane:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_EMOTE",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
);


Nightbane:AddOption("CharredEarth", true, DBM_NB_OPTION_1);
Nightbane:AddOption("Ash", false, DBM_NB_OPTION_2);
Nightbane:AddOption("BoneRain", true, DBM_NB_OPTION_3);
-- Nightbane:AddOption("Icon", true, DBM_NB_OPTION_ICON);
-- Nightbane:AddOption("SmokingBlast", false, DBM_NB_OPTION_4); -- no longer needed since the hotfix/nerf
-- Nightbane:AddOption("SmokingSpecWarn", false, DBM_NB_OPTION_5);

Nightbane:AddBarOption("Nightbane")
Nightbane:AddBarOption("Air Phase")
Nightbane:AddBarOption("Next Fear")
Nightbane:AddBarOption("Fear")

function Nightbane:OnEvent(event, arg1)
	if event == "CHAT_MSG_MONSTER_EMOTE" then
		if arg1 == DBM_NB_EMOTE_PULL then
			self:StartStatusBarTimer(34, "Nightbane", "Interface\\Icons\\Ability_Mount_Undeadhorse");
		end
		
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 36922 then -- 3/26 22:16:44.062  SPELL_CAST_START,0xF13000434900162B,"Nightbane",0x10a48,0x0000000000000000,nil,0x80000000,36922,"Bellowing Roar",0x1
			self:StartStatusBarTimer(31.5, "Next Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
			self:StartStatusBarTimer(1.5, "Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
			self:Announce(DBM_NB_FEAR_WARN, 3);
			self:ScheduleSelf(31, "FearWarn");
		end
		
	elseif event == "FearWarn" then
		self:Announce(DBM_NB_FEAR_SOON_WARN, 2);
		
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_NB_YELL_AIR then
			self.LastSmokeTarget = nil;
			self:Announce(DBM_NB_AIR_WARN, 1);
			self:ScheduleSelf(47, "DownFIRSTWarn");
			self:ScheduleSelf(54, "DownSECWarn");
			self:StartStatusBarTimer(57, "Air Phase", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendBurrow");
		elseif (arg1 == DBM_NB_YELL_GROUND or arg1 == DBM_NB_YELL_GROUND2) and ((GetTime() - self.LastYell) > 45) then -- he sometimes yells twice...(but seems to be fixed? not sure)
			self.LastYell = GetTime();
			self:ScheduleSelf(3, "UpdateAirTimer");
		end
	elseif event == "UpdateAirTimer" then --stupid bug in old versions and MinVerToSync does not work with UpdateStatusBarTimer -_-
		self:UpdateStatusBarTimer("Air Phase", 43, 57);
		
	elseif event == "DownFIRSTWarn" then
		self:Announce(DBM_NB_DOWN_WARN, 2);
		
	elseif event == "DownSECWarn" then
		self:Announce(DBM_NB_DOWN_WARN2, 1);
		
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 30129 and arg1.destName == UnitName("player") and self.Options.CharredEarth then -- 3/26 22:16:19.140  SPELL_AURA_APPLIED,0x0000000000000000,nil,0x80000000,0x0000000000851BBA,"Aurak",0x511,30129,"Charred Earth",0x1,DEBUFF
			self:AddSpecialWarning(DBM_NB_EARTH_WARN); -- should work?
		elseif arg1.spellId == 37098 and self.Options.BoneRain and (GetTime() - self.BoneRain) > 60 then
			self.BoneRain = GetTime();
			self:Announce(DBM_NB_BONES_WARN, 2);
		elseif arg1.spellId == 30130 and self.Options.Ash then
			self:Announce(string.format(DBM_NB_ASH_WARN, tostring(arg1.destName)), 2);
		end
	end
end
