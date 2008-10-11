local MHT = DBM:NewBossMod("MHT", DBM_MHT_NAME, DBM_MHT_DESCRIPTION, DBM_HYJAL, DBM_HYJAL_TAB, 0);

local lastwave = 0;
local boss = 0;

MHT.Version = "1.6.2";
MHT.Author = "Arta, kc10577";

MHT:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
	"UNIT_DIED",
	"SPELL_AURA_APPLIED"
);

MHT:AddOption("Mobs", false, DBM_MHT_DESCRIPTION1);
MHT:AddOption("Ghoul", false, DBM_MHT_DESCRIPTION2);

MHT:AddBarOption("Next Wave");

function MHT:OnEvent(event, arg1)
	if (event == "GOSSIP_SHOW" or event=="QUEST_PROGRESS") and GetRealZoneText() == DBM_MOUNT_HYJAL then
		local target = UnitName("target");
		if target == DBM_MHT_THRALL or target == DBM_MHT_JAINA then
			local Selection = GetGossipOptions();
			if Selection == DBM_MHT_RAGE_MSG then
				self:SendSync("Winterchill");
			elseif Selection == DBM_MHT_ANETHERON_MSG then
				self:SendSync("Anetheron");
			elseif Selection == DBM_MHT_KAZROGAL_MSG then
				self:SendSync("Kazrogal");
			elseif Selection == DBM_MHT_AZGALOR_MSG then
				self:SendSync("Azgalor");
			end
		end
	elseif event == "UPDATE_WORLD_STATES" then
		local text = select(3, GetWorldStateUIInfo(3));
		if not text then return	end
		local _, _, currentwave = string.find(text, DBM_MHT_WAVE_CHECK);
		if not currentwave then
			currentwave = 0;
		end
		self:SendSync("NewWave"..currentwave);
	elseif event == "UNIT_DIED" then
		local target = tostring(arg1.destName)
		if target == DBM_MHT_THRALL or target == DBM_MHT_JAINA then
			self:SendSync("reset");
		elseif target == DBM_RAGE_NAME then
			self:SendSync("Winterchill");
		elseif target == DBM_ANETHERON_NAME then
			self:SendSync("Kazrogal");
		elseif target == DBM_KAZROGAL_NAME then
			self:SendSync("Azgalor");
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 31538 then
			self:SendSync("Cannibalize");
		end
	elseif event == "WaveSoon" then
		if lastwave == 8 then
			self:Announce(DBM_MHT_BOSS_SOON, 3);
		else
			self:Announce(DBM_MHT_WAVE_SOON, 3);
		end
	end
		
end

function MHT:OnSync(msg)
	if msg:sub(0, 7) == "NewWave" then
		local timer = 0;
		local wave = string.sub(msg, 8, 8);
		wave = tonumber(wave);
		if not wave then return end
		   	lastwave = tonumber(lastwave);
		if wave > lastwave then
			if not MHT.Options.Mobs then
				self:Announce(DBM_MHT_WAVE_NOW, 4);
			end
			self:UnScheduleSelf("WaveSoon");
			if boss == 1 or boss == 2 then	
				timer = 125;
				if wave == 8 then
					timer = 140;
				end
				if MHT.Options.Mobs and boss == 1 then
					if wave == 1 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING1, wave, 10, DBM_MHT_GHOUL), 1);
					elseif wave == 2 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 10, DBM_MHT_GHOUL, 2, DBM_MHT_FIEND), 1);
					elseif wave == 3 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 6, DBM_MHT_GHOUL, 6, DBM_MHT_FIEND), 1);
					elseif wave == 4 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_GHOUL, 4, DBM_MHT_FIEND, 2, DBM_MHT_NECROMANCER), 1);
					elseif wave == 5 then				
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 2, DBM_MHT_GHOUL, 6, DBM_MHT_FIEND, 4, DBM_MHT_NECROMANCER), 1);
					elseif wave == 6 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 6, DBM_MHT_GHOUL, 6, DBM_MHT_ABOMINATION), 1);
					elseif wave == 7 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 4, DBM_MHT_GHOUL, 4, DBM_MHT_ABOMINATION, 4, DBM_MHT_NECROMANCER), 1);
					elseif wave == 8 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING4, wave, 6, DBM_MHT_GHOUL, 4, DBM_MHT_FIEND, 2, DBM_MHT_ABOMINATION, 2, DBM_MHT_NECROMANCER), 1);
					end
				elseif MHT.Options.Mobs and boss == 2 then
					if wave == 1 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING1, wave, 10, DBM_MHT_GHOUL), 1);
					elseif wave == 2 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 8, DBM_MHT_GHOUL, 4, DBM_MHT_ABOMINATION), 1);
					elseif wave == 3 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 4, DBM_MHT_GHOUL, 4, DBM_MHT_FIEND, 4, DBM_MHT_NECROMANCER), 1);
					elseif wave == 4 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_FIEND, 4, DBM_MHT_NECROMANCER, 2, DBM_MHT_BANSHEE), 1);
					elseif wave == 5 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_GHOUL, 4, DBM_MHT_BANSHEE, 2, DBM_MHT_NECROMANCER), 1);
					elseif wave == 6 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_GHOUL, 2, DBM_MHT_ABOMINATION, 4, DBM_MHT_NECROMANCER), 1);
					elseif wave == 7 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING4, wave, 2, DBM_MHT_GHOUL, 4, DBM_MHT_FIEND, 4, DBM_MHT_ABOMINATION, 2, DBM_MHT_BANSHEE), 1);
					elseif wave == 8 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING5, wave, 3, DBM_MHT_GHOUL, 3, DBM_MHT_FIEND, 4, DBM_MHT_ABOMINATION, 2, DBM_MHT_NECROMANCER, 2, DBM_MHT_BANSHEE), 1);
					end
				end
			elseif boss == 3 or boss == 4 then
				timer = 135;
				if wave == 2 or wave == 4 then
					timer = 165;
				elseif wave == 3 then
					timer = 160;
				elseif wave == 7 then
					timer = 195;
				elseif wave == 8 then
					timer = 225;
				end
				if MHT.Options.Mobs and boss == 3 then
					if wave == 1 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING4, wave, 4, DBM_MHT_GHOUL, 4, DBM_MHT_ABOMINATION, 2, DBM_MHT_NECROMANCER, 2, DBM_MHT_BANSHEE), 1); 
					elseif wave == 2 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 4, DBM_MHT_GHOUL, 10, DBM_MHT_GARGOYLE), 1); 
					elseif wave == 3 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_GHOUL, 6, DBM_MHT_FIEND, 2, DBM_MHT_NECROMANCER), 1);  
					elseif wave == 4 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_FIEND, 2, DBM_MHT_NECROMANCER, 6, DBM_MHT_GARGOYLE), 1); 
					elseif wave == 5 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 4, DBM_MHT_GHOUL, 6, DBM_MHT_ABOMINATION, 4, DBM_MHT_NECROMANCER), 1); 
					elseif wave == 6 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 8, DBM_MHT_GARGOYLE, 1, DBM_MHT_WYRM), 1); 
					elseif wave == 7 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 6, DBM_MHT_GHOUL, 4, DBM_MHT_ABOMINATION, 1, DBM_MHT_WYRM), 1); 
					elseif wave == 8 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING5, wave, 6, DBM_MHT_GHOUL, 2, DBM_MHT_FIEND, 4, DBM_MHT_ABOMINATION, 2, DBM_MHT_NECROMANCER, 2, DBM_MHT_BANSHEE), 1); 
					end
				elseif MHT.Options.Mobs and boss == 4 then
					if wave == 1 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 6, DBM_MHT_ABOMINATION, 6, DBM_MHT_NECROMANCER), 1);
					elseif wave == 2 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 5, DBM_MHT_GHOUL, 8, DBM_MHT_GARGOYLE, 1, DBM_MHT_WYRM), 1);
					elseif wave == 3 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 4, DBM_MHT_GHOUL, 8, DBM_MHT_INFERNAL), 1);
					elseif wave == 4 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 8, DBM_MHT_STALKER, 6, DBM_MHT_INFERNAL), 1);
					elseif wave == 5 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING3, wave, 4, DBM_MHT_ABOMINATION, 4, DBM_MHT_NECROMANCER, 6, DBM_MHT_STALKER), 1);
					elseif wave == 6 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING2, wave, 6, DBM_MHT_NECROMANCER, 6, DBM_MHT_BANSHEE), 1);
					elseif wave == 7 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING4, wave, 2, DBM_MHT_GHOUL, 2, DBM_MHT_FIEND, 2, DBM_MHT_STALKER, 8, DBM_MHT_INFERNAL), 1);
					elseif wave == 8 then
						self:Announce(string.format(DBM_MHT_WAVE_INC_WARNING5, wave, 4, DBM_MHT_ABOMINATION, 4, DBM_MHT_FIEND, 2, DBM_MHT_NECROMANCER, 4, DBM_MHT_STALKER, 2, DBM_MHT_BANSHEE), 1);
					end
				end
			end
			self:StartStatusBarTimer(timer, "Next Wave");
			self:ScheduleSelf(timer-10, "WaveSoon");
			lastwave = wave;
		elseif lastwave > wave then
			if lastwave == 8 then
				self:Announce(DBM_MHT_BOSS_NOW, 4);
			end
			self:UnScheduleSelf("WaveSoon");
			self:EndStatusBarTimer("Next Wave");
			lastwave = wave;
		end
	elseif msg == "Cannibalize" and MHT.Options.Ghoul then
		self:Announce(DBM_MHT_WARN_GHOUL,2);
	elseif msg == "Winterchill" then
		boss = 1;
	elseif msg == "Anetheron" then
		boss = 2;
	elseif msg == "Kazrogal" then
		boss = 3;
	elseif msg == "Azgalor" then
		boss = 4;
	elseif msg == "reset" then
		lastwave = 0;
	end
end
