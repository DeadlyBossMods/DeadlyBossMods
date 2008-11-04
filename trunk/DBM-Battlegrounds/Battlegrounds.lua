-- Battleground mod v2.0
-- rewrite by Tandanu
-- this file is for events that are needed for all battlegrounds and stuff like the invite timer, etc.
--
-- thanks to LeoLeal and DiabloHu

local Battlegrounds = DBM:NewBossMod("Battlegrounds", "Battlegrounds", DBM_NO_GUI_TAB, DBM_OTHER, DBM_NO_GUI_TAB, 0);

Battlegrounds.Version			= "2.0";
Battlegrounds.Author			= "Tandanu";
Battlegrounds.MinVersionToSync	= 2.31;

Battlegrounds.Options.ColorByClass		= true; --I don't use :AddOption() here, because we don't have a GUI for this part of the BG mod, the other BG mods will access this options
Battlegrounds.Options.ShowInviteTimer	= true;
Battlegrounds.Options.AutoSpirit		= false;

Battlegrounds:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_DEAD"
);

function Battlegrounds:OnEvent()
	if event == "ZONE_CHANGED_NEW_AREA"	or event == "PLAYER_ENTERING_WORLD" then --end timers when leaving the BG and request versions from other DBM clients
		if GetRealZoneText() == DBM_ALTERAC or
		GetRealZoneText() == DBM_ARATHI or
		GetRealZoneText() == DBM_WARSONG or
		GetRealZoneText() == DBM_EYEOFTHESTORM then
			DBM.AddSyncMessage("HI!", true); -- needed because DBM would not request a new version if you are already in a raid group
			if not DBM.FunctionIsScheduled(DBM.RequestBars) then				
				DBM.Schedule(5, DBM.RequestBars);
			end
		end
		
		for index, value in pairs(DBM.StatusBarData) do --end all timers when leaving/entering a BG
			if value.bossModID == "Battlegrounds"
			or value.bossModID == "Alterac"
			or value.bossModID == "Arathi"
			or value.bossModID == "Warsong"
			or value.bossModID == "EyeOfTheStorm" then
				self:EndStatusBarTimer(index, true);
			end
		end
		
		self:UnScheduleSelf();
		if DBM:GetMod("Alterac") then DBM:GetMod("Alterac"):UnScheduleSelf(); end
		if DBM:GetMod("Arathi") then DBM:GetMod("Arathi"):UnScheduleSelf();	end
		if DBM:GetMod("Warsong") then DBM:GetMod("Warsong"):UnScheduleSelf(); end
		if DBM:GetMod("EyeOfTheStorm") then DBM:GetMod("EyeOfTheStorm"):UnScheduleSelf(); end
	elseif event == "PLAYER_DEAD" then
		if (GetRealZoneText() == DBM_ALTERAC
		or GetRealZoneText() == DBM_ARATHI
		or GetRealZoneText() == DBM_WARSONG
		or GetRealZoneText() == DBM_EYEOFTHESTORM)
		and not HasSoulstone()
		and self.Options.AutoSpirit then
			RepopMe()
		end
	end
end

function Battlegrounds:OnUpdate() --invite timer
	if self.Options.ShowInviteTimer and MAX_BATTLEFIELD_QUEUES and PVP_TEAMSIZE then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, mapName, instanceID, _, _, teamSize = GetBattlefieldStatus(i);
			if (mapName and (instanceID ~= 0)) then
				mapName = mapName.." "..instanceID;
				if (teamSize ~= 0) then
					mapName = mapName.." "..format(PVP_TEAMSIZE, tostring(teamSize), tostring(teamSize));
				end
			end
			if status == "confirm" then
				if not self:GetStatusBarTimerTimeLeft(mapName) and not DBMStatusBars_GetImportantBar(mapName) then
					self:StartStatusBarTimer(GetBattlefieldPortExpiration(i)/1000, mapName, nil, true);
				end
			end
		end
	end
end

Battlegrounds.ClassColors = {
	[DBM_HUNTER] = { r = 0.67, g = 0.83, b = 0.45 },
	[DBM_WARLOCK] = { r = 0.58, g = 0.51, b = 0.79 },
	[DBM_PRIEST] = { r = 1.0, g = 1.0, b = 1.0 },
	[DBM_PALADIN] = { r = 0.96, g = 0.55, b = 0.73 },
	[DBM_MAGE] = { r = 0.41, g = 0.8, b = 0.94 },
	[DBM_ROGUE] = { r = 1.0, g = 0.96, b = 0.41 },
	[DBM_DRUID] = { r = 1.0, g = 0.49, b = 0.04 },
	[DBM_SHAMAN] = { r = 0.14, g = 0.35, b = 1.0 },
	[DBM_WARRIOR] = { r = 0.78, g = 0.61, b = 0.43 }
};


hooksecurefunc("WorldStateScoreFrame_Update", function() --re-color the players in the score frame
	if not DBM:GetMod("Battlegrounds").Options.ColorByClass then
		return;
	end
	
	local isArena = IsActiveBattlefieldArena();
	local i = 1;
	for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
		local index = (FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) or 0) + i;
		
		local name, _, _, _, _, faction, _, _, class = GetBattlefieldScore(index);
		if (name ~= UnitName("player")) and class and Battlegrounds.ClassColors[class] and getglobal("WorldStateScoreButton"..i.."NameText") then
			getglobal("WorldStateScoreButton"..i.."NameText"):SetTextColor(Battlegrounds.ClassColors[class].r, Battlegrounds.ClassColors[class].g, Battlegrounds.ClassColors[class].b);
			local playerName = getglobal("WorldStateScoreButton"..i.."NameText"):GetText();
			if playerName then
				local _, _, playerName, playerServer = string.find(playerName, "([^%-]+)%-(.+)");
				if playerServer and playerName then
					if faction == 0 then
						if isArena then --green team
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cff19ff19"..playerServer.."|r");
						else --horde
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cffff1919"..playerServer.."|r");
						end
					else
						if isArena then --golden team
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cffffd100"..playerServer.."|r");
						else --alliance
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cff00adf0"..playerServer.."|r");
						end
					end
				end
			end
		end
		i = i + 1;
	end
end);