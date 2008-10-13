local Lurker = DBM:NewBossMod("LurkerBelow", DBM_LURKER_NAME, DBM_LURKER_DESCRIPTION, DBM_COILFANG, DBM_SERPENT_TAB, 2);

Lurker.Version		= "2.2";
Lurker.Author		= "Tandanu";
Lurker.MinVersionToSync = 2.7

Lurker.SubmergeWarning = false; -- to prevent spam after a wipe
Lurker.Submerged	= false;

Lurker:SetCreatureID(21217)
Lurker:RegisterCombat("combat")

Lurker:AddOption("WhirlWarn", true, DBM_LURKER_OPTION_WHIRL);
Lurker:AddOption("WhirlSoonWarn", true, DBM_LURKER_OPTION_WHIRLSOON);
Lurker:AddOption("SpoutWarn", true, DBM_LURKER_OPTION_SPOUT);

Lurker:AddBarOption("Submerge")
Lurker:AddBarOption("Emerge")
Lurker:AddBarOption("Spout")
Lurker:AddBarOption("Next Spout")
Lurker:AddBarOption("Whirl")

Lurker:RegisterEvents(
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE"
);

function Lurker:OnCombatStart(delay)
	self:StartStatusBarTimer(90, "Submerge", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendBurrow");
	self:ScheduleSelf(60 - delay, "SubmergeWarning", 30);
	self:ScheduleSelf(75 - delay, "SubmergeWarning", 15);
	self:ScheduleSelf(85 - delay, "SubmergeWarning", 5);
	
	self:StartStatusBarTimer(42 - delay, "Spout", "Interface\\Icons\\Spell_Frost_ChillingBlast");
	self:ScheduleSelf(37 - delay, "SpoutWarning");

	self:StartStatusBarTimer(18 - delay, "Whirl", "Interface\\Icons\\Ability_Whirlwind");
	self:ScheduleSelf(14 - delay, "WhirlWarning");

	self.SubmergeWarning = false;
	self:ScheduleSelf(20, "CheckBack");
	
	self.Submerged = false;
end

function Lurker:OnEvent(event, arg1)
	if event == "SPELL_DAMAGE" and arg1.spellId == 37363 then
		self:SendSync("Whirl");
		
	elseif event == "CHAT_MSG_RAID_BOSS_EMOTE" then
		if arg1 == DBM_LURKER_EMOTE_SPOUT then
			if self.Options.SpoutWarn then
				self:Announce(DBM_LURKER_WARN_SPOUT, 3);
			end
			
			self:ScheduleSelf(22, "NextSpout");
			self:EndStatusBarTimer("Whirl");
			self:StartStatusBarTimer(22, "Spout", "Interface\\Icons\\Spell_Frost_ChillingBlast");
			self:UnScheduleSelf("WhirlWarning");
			self:UnScheduleSelf("SpoutWarning");
		end
		
	elseif event == "SpoutWarning" and self.Options.SpoutWarn then
		self:Announce(DBM_LURKER_WARN_SPOUT_SOON, 2);
		
	elseif event == "NextSpout" then
		self:StartStatusBarTimer(32, "Next Spout", "Interface\\Icons\\Spell_Frost_ChillingBlast");
		self:ScheduleSelf(27, "SpoutWarning");
		
	elseif event == "Submerge" then
		self.Submerged = true;
		self:Announce(DBM_LURKER_WARN_SUBMERGE, 2);
		self:UnScheduleSelf("SpoutWarning");
		self:UnScheduleSelf("WhirlWarning");
		self:UnScheduleSelf("NextSpout");
		self:EndStatusBarTimer("Spout");
		self:EndStatusBarTimer("Submerge");
		self:EndStatusBarTimer("Whirl");
		self:EndStatusBarTimer("Next Spout");
		self:StartStatusBarTimer(60, "Emerge", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendUnBurrow");
		
	elseif event == "Emerge" then
		self.Submerged = false;
		self:Announce(DBM_LURKER_WARN_EMERGE, 3);
		self:StartStatusBarTimer(90, "Submerge", "Interface\\AddOns\\DBM_API\\Textures\\CryptFiendBurrow");
		self:EndStatusBarTimer("Emerge");
		self:ScheduleSelf(60, "SubmergeWarning", 30);
		self:ScheduleSelf(75, "SubmergeWarning", 15);
		self:ScheduleSelf(85, "SubmergeWarning", 5);
		
	elseif event == "CheckBack" then
		local foundIt;
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == DBM_LURKER_NAME then
				foundIt = true;
			end
		end
		if foundIt then
			self.SubmergeWarning = true;
		end
		
	elseif event == "SubmergeWarning" then
		if type(arg1) == "number" then
			self:Announce(string.format(DBM_LURKER_WARN_SUBMERGE_SOON, arg1), 1);
		end
	elseif event == "WhirlWarning" then
		if self.Options.WhirlSoonWarn then
			self:Announce(DBM_LURKER_WARN_WHIRL_SOON, 1);
		end
	end
end

function Lurker:OnUpdate(elapsed)
	if self.InCombat then
		
		local foundIt;
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == DBM_LURKER_NAME then
				foundIt = true;
				break;
			end
		end
		
		if not foundIt and self.SubmergeWarning then
			self:OnEvent("Submerge");
			self.SubmergeWarning = false;
		elseif foundIt and self.Submerged then
			self:OnEvent("Emerge");
			self:Schedule(10, function() DBM:GetMod("LurkerBelow").SubmergeWarning = true; end);
		end

	end
end


function Lurker:OnSync(msg)
	if msg == "Whirl" then
		self:StartStatusBarTimer(17.5, "Whirl", "Interface\\Icons\\Ability_Whirlwind");
		self:ScheduleSelf(13.5, "WhirlWarning");
		if self.Options.WhirlWarn then
			self:Announce(DBM_LURKER_WARN_WHIRL, 2);
		end
	end
end
