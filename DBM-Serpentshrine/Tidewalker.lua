local Tidewalker = DBM:NewBossMod("Tidewalker", DBM_TIDEWALKER_NAME, DBM_TIDEWALKER_DESCRIPTION, DBM_COILFANG, DBM_SERPENT_TAB, 3);

Tidewalker.Version		= "1.0";
Tidewalker.Author		= "Tandanu";
Tidewalker.GraveTargets	= {};
Tidewalker.GraveCounter	= 0;
Tidewalker.MinVersionToSync  = 2.51;

Tidewalker:RegisterCombat("YELL", DBM_TIDEWALKER_YELL_PULL);

Tidewalker:AddOption("Murlocs", true, DBM_TIDEWALKER_OPTION_1);
Tidewalker:AddOption("Grave", false, DBM_TIDEWALKER_OPTION_2);

Tidewalker:AddBarOption("Murlocs")
Tidewalker:AddBarOption("Watery Grave")

Tidewalker:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED" 
);

function Tidewalker:OnCombatStart(delay)
	self.GraveTargets	= {};
	self.GraveCounter	= 0;
	
	self:StartStatusBarTimer(42 - delay, "Murlocs", "Interface\\Icons\\INV_Misc_MonsterHead_02");
	self:ScheduleSelf(35 - delay, "MurlocWarn");
end

function Tidewalker:OnCombatEnd()
	self.GraveTargets	= {};
	self.GraveCounter	= 0;
end

function Tidewalker:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 37850
		or arg1.spellId == 38023
		or arg1.spellId == 38024
		or arg1.spellId == 38025
		or arg1.spellId == 38049 then -- ???
			self:SendSync(tostring(arg1.destName))
		end
		
	elseif event == "GraveCheck" then
		if self.Options.Grave and self.GraveCounter > 0 and self.GraveCounter < 4 then
			local targetString = "";
			if self.GraveCounter == 1 then
				targetString = ">"..self.GraveTargets[1].."<";
			elseif self.GraveCounter == 2 then
				targetString = ">"..self.GraveTargets[1].."< "..DBM_AND.." >"..self.GraveTargets[2].."<";
			elseif self.GraveCounter == 3 then
				targetString = ">"..self.GraveTargets[1].."<, >"..self.GraveTargets[2].."< "..DBM_AND.." >"..self.GraveTargets[3].."<";
			end
			self:Announce(string.format(DBM_TIDEWALKER_WARN_GRAVE, targetString), 2);
		end
		self.GraveCounter = 0;
		self.GraveTargets = {};
		
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_TIDEWALKER_EMOTE_MURLOCS then
			if self.Options.Murlocs then
				self:Announce(DBM_TIDEWALKER_WARN_MURLOCS, 3);
			end
			self:StartStatusBarTimer(50, "Murlocs", "Interface\\Icons\\INV_Misc_MonsterHead_02");
			self:UnScheduleSelf("MurlocWarn");
			self:ScheduleSelf(45, "MurlocWarn");
		elseif arg1 == DBM_TIDEWALKER_EMOTE_GRAVE then
			self:StartStatusBarTimer(30, "Watery Grave", "Interface\\Icons\\Spell_Shadow_DemonBreath");
		elseif arg1 == DBM_TIDEWALKER_EMOTE_GLOBES then
			self:Announce(DBM_TIDEWALKER_WARN_GLOBES, 3);
		end
		
	elseif event == "MurlocWarn" then
		if self.Options.Murlocs then
			self:Announce(DBM_TIDEWALKER_WARN_MURLOCS_SOON, 1);
		end
	end
end

function Tidewalker:OnSync(msg)
	if msg then
		table.insert(self.GraveTargets, msg);
		self.GraveCounter = self.GraveCounter + 1;
		if self.GraveCounter == 4 then
			if self.Options.Grave then
				local targetString = ">"..self.GraveTargets[1].."<, >"..self.GraveTargets[2].."<, >"..self.GraveTargets[3].."< "..DBM_AND.." >"..self.GraveTargets[4].."<";
				self:Announce(string.format(DBM_TIDEWALKER_WARN_GRAVE, targetString), 2);
			end
			self.GraveCounter = 0;
			self.GraveTargets = {};
		else
			self:ScheduleSelf(1, "GraveCheck"); --if we miss an event...
		end
	end
end