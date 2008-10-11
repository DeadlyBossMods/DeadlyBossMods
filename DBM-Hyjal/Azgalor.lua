local Azgalor = DBM:NewBossMod("Azgalor", DBM_AZGALOR_NAME, DBM_AZGALOR_DESCRIPTION, DBM_MOUNT_HYJAL, DBM_HYJAL_TAB, 4);

Azgalor.Version	= "1.0";
Azgalor.Author	= "Tandanu";

Azgalor:SetCreatureID(17842)
Azgalor:RegisterCombat("yell", DBM_AZGALOR_YELL_PULL)
Azgalor:SetMinCombatTime(130)

Azgalor:AddOption("WarnSilence", true, DBM_AZGALOR_OPTION_SILENCE);
Azgalor:AddOption("DoomIcon", true, DBM_AZGALOR_OPTION_ICON);

Azgalor:AddBarOption("Doom: (.*)")
Azgalor:AddBarOption("Silence")

Azgalor:RegisterEvents(
	"SPELL_AURA_APPLIED"
);

function Azgalor:OnEvent(event, arg1)
	if event == "SPELL_AURA_APPLIED" then
		if arg1.spellId == 31347 then
			local target = tostring(arg1.destName)
			if target == UnitName("player") then
				self:AddSpecialWarning(DBM_AZGALOR_SPECWARN_DOOM_YOU);
			end
			self:SendSync("Doom"..target);
		elseif arg1.spellId == 31344 then
			self:SendSync("Silence");
		end
	elseif event == "SilenceWarn" then
		if self.Options.WarnSilence then
			self:Announce(DBM_AZGALOR_WARN_SILENCESOON, 1);
		end
	end
end

function Azgalor:OnSync(msg)
	if msg:sub(0, 4) == "Doom" then
		msg = msg:sub(5);
		self:Announce(DBM_AZGALOR_WARN_DOOM:format(msg), 4);
		if self.Options.DoomIcon then
			self:SetIcon(msg, 20);
		end
		self:StartStatusBarTimer(20, "Doom: "..msg, "Interface\\Icons\\Spell_Shadow_AuraOfDarkness");
	elseif msg == "Silence" then
		if self.Options.WarnSilence then
			self:Announce(DBM_AZGALOR_WARN_SILENCE, 2);
		end
		self:StartStatusBarTimer(19, "Silence", "Interface\\Icons\\Spell_Holy_Silence");
		self:UnScheduleSelf("SilenceWarn")
		self:ScheduleSelf(16, "SilenceWarn")
	end
end