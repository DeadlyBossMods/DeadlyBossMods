local Nalorakk = DBM:NewBossMod("Nalorakk", DBM_NALO_NAME, DBM_NALO_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 1);

Nalorakk.Version	= "1.0";
Nalorakk.Author		= "Tandanu";

Nalorakk:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED"
)

Nalorakk:SetCreatureID(23576)
Nalorakk:RegisterCombat("yell", DBM_NALO_YELL_PULL)

Nalorakk:AddOption("PrePhaseWarn", true, DBM_NALO_OPTION_PHASEPRE)
Nalorakk:AddOption("SilenceWarn", true, DBM_NALO_OPTION_SILENCE)

Nalorakk:AddBarOption("Bear Form")
Nalorakk:AddBarOption("Normal Form")


function Nalorakk:OnCombatStart()
-- ??
--[[self:StartStatusBarTimer(600, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(300, DBM_GENERIC_ENRAGE_WARN:format(5, DBM_MIN), 1)
	self:ScheduleAnnounce(420, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(540, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(570, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(590, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)]]--
	
	self:StartStatusBarTimer(45, "Bear Form", "Interface\\Icons\\Ability_Hunter_Pet_Bear")
	self:ScheduleAnnounce(40, DBM_NALO_WARN_BEAR_SOON, 1)
end

function Nalorakk:OnEvent(event, args)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_NALO_YELL_NORMAL then
			self:Announce(DBM_NALO_WARN_NORMAL, 3)
			self:StartStatusBarTimer(45, "Bear Form", "Interface\\Icons\\Ability_Hunter_Pet_Bear")
			if self.Options.PrePhaseWarn then
				self:ScheduleAnnounce(40, DBM_NALO_WARN_BEAR_SOON, 1)
			end
		elseif arg1 == DBM_NALO_YELL_BEAR then
			self:Announce(DBM_NALO_WARN_BEAR, 3)
			self:StartStatusBarTimer(30, "Normal Form", "Interface\\Icons\\Ability_Racial_BearForm")
			if self.Options.PrePhaseWarn then
				self:ScheduleAnnounce(25, DBM_NALO_WARN_NORMAL_SOON, 1)
			end
		end
	elseif event == "SPELL_AURA_APPLIED" and self.Options.SilenceWarn then
		if args.spellId == DBM_NALO_SPELLID_SILENCE then
			self:Announce(DBM_NALO_WARN_SILENCE, 2)
		end
	end
end
