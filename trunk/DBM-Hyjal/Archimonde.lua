local Archimonde = DBM:NewBossMod("Archimonde", DBM_ARCHIMONDE_NAME, DBM_ARCHIMONDE_DESCRIPTION, DBM_MOUNT_HYJAL, DBM_HYJAL_TAB, 5);

Archimonde.Version	= "1.0";
Archimonde.Author	= "Tandanu";

Archimonde:SetCreatureID(17968)
Archimonde:RegisterCombat("yell", DBM_ARCHIMONDE_YELL_PULL)

Archimonde:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
);

Archimonde:AddOption("Grip", true, DBM_ARCHIMONDE_OPTION_GRIP)
Archimonde:AddOption("Burst", false, DBM_ARCHIMONDE_OPTION_BURST)
Archimonde:AddOption("BurstIcon", true, DBM_ARCHIMONDE_OPTION_BURSTICON)
Archimonde:AddOption("BurstSay", true, DBM_ARCHIMONDE_OPTION_BURSTSAY)
Archimonde:AddOption("BurstSpecWarn", true, DBM_ARCHIMONDE_OPTION_BURSTSPECWARN)

Archimonde:AddBarOption("Enrage")
Archimonde:AddBarOption("Fear")

function Archimonde:OnCombatStart(delay)
	self:StartStatusBarTimer(600 - delay, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
	self:ScheduleSelf(300 - delay, "EnrageWarn", 300);
	self:ScheduleSelf(480 - delay, "EnrageWarn", 120);
	self:ScheduleSelf(540 - delay, "EnrageWarn", 60);
	self:ScheduleSelf(570 - delay, "EnrageWarn", 30);
	self:ScheduleSelf(590 - delay, "EnrageWarn", 10);
	
	self:StartStatusBarTimer(40 - delay, "Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream")
	self:ScheduleSelf(37 - delay, "FearWarn")
end

function Archimonde:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 31972 then
			self:SendSync("Grip"..tostring(arg1.destName))
		end
	elseif event == "SPELL_CAST_START" then
		if arg1.spellId == 31970 then -- this spell is the only "Fear" that afflicts multiple targets with 1.5 sec cast time 
			self:SendSync("Fear")
		elseif arg1.spellId == 32014 then
			self:SendSync("Burst")
		end
	elseif event == "EnrageWarn" and type(arg1) == "number" then
		if arg1 >= 60 then
			self:Announce(string.format(DBM_ARCHIMONDE_WARN_ENRAGE, (arg1/60), DBM_MIN), 1);
		else
			self:Announce(string.format(DBM_ARCHIMONDE_WARN_ENRAGE, arg1, DBM_SEC), 3);
		end
	elseif event == "FearWarn" then
		self:Announce(DBM_ARCHIMONDE_WARN_FEARSOON, 2)
	elseif event == "CheckTarget" then
		local target
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == DBM_ARCHIMONDE_NAME then
				target = UnitName( "raid"..i.."targettarget")
				break
			end
		end
		if target then
			if self.Options.Burst then
				self:Announce(DBM_ARCHIMONDE_WARN_BURST:format(target), 1)
			end
			if self.Options.BurstIcon then
				self:SetIcon(target, 5)
			end
			if target == UnitName("player") then
				if self.Options.BurstSay then
					SendChatMessage(DBM_ARCHIMONDE_WARN_BURST_ME)
				end
				if self.Options.BurstSpecWarn then
					self:AddSpecialWarning(DBM_ARCHIMONDE_SPECWARN_BURST)
				end
			end
		end
	end
end

function Archimonde:OnSync(msg)
	if msg:sub(0, 4) == "Grip" and self.Options.Grip then
		msg = msg:sub(5)
		self:Announce(DBM_ARCHIMONDE_WARN_GRIP:format(msg), 2);
	elseif msg == "Fear" then
		self:Announce(DBM_ARCHIMONDE_WARN_FEAR, 3)
		self:StartStatusBarTimer(41, "Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream")
		self:ScheduleSelf(37, "FearWarn")
	elseif msg == "Burst" then
		self:ScheduleSelf(0.2, "CheckTarget")
	end
end