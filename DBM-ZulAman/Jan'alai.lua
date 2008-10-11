local Jan = DBM:NewBossMod("Janalai", DBM_JANALAI_NAME, DBM_JANALAI_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 3);

Jan.Version	= "1.0";
Jan.Author	= "Tandanu";

Jan:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
--	"UNIT_SPELLCAST_START"
)

Jan:AddBarOption("Enrage")
Jan:AddBarOption("Hatcher")
Jan:AddBarOption("Explosion")

Jan:SetCreatureID(23578)
Jan:RegisterCombat("yell", DBM_JANALAI_YELL_PULL)

function Jan:OnCombatStart()
	self:StartStatusBarTimer(300, "Enrage", "Interface\\Icons\\Spell_Shadow_UnholyFrenzy") 
	self:ScheduleAnnounce(120, DBM_GENERIC_ENRAGE_WARN:format(3, DBM_MIN), 1)
	self:ScheduleAnnounce(240, DBM_GENERIC_ENRAGE_WARN:format(1, DBM_MIN), 2)
	self:ScheduleAnnounce(270, DBM_GENERIC_ENRAGE_WARN:format(30, DBM_SEC), 3)
	self:ScheduleAnnounce(290, DBM_GENERIC_ENRAGE_WARN:format(10, DBM_SEC), 4)

	self:Announce(DBM_JANALAI_WARN_HATCHER_SOON, 1)
	self:StartStatusBarTimer(10, "Hatcher", "Interface\\Icons\\INV_Misc_Head_Troll_01")
end

function Jan:OnEvent(event)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_JANALAI_YELL_EXPLOSION then
			self:Announce(DBM_JANALAI_WARN_EXPLOSION, 3)
			self:StartStatusBarTimer(11.4, "Explosion", "Interface\\Icons\\Spell_Shadow_MindBomb")
			self:ScheduleAnnounce(10.4, DBM_JANALAI_WARN_EXPLOSION_INC, 4)
		elseif arg1 == DBM_JANALAI_YELL_HATCHER then
			self:Announce(DBM_JANALAI_WARN_HATCHER, 2)
			self:ScheduleAnnounce(80, DBM_JANALAI_WARN_HATCHER_SOON, 1)
			self:StartStatusBarTimer(90, "Hatcher", "Interface\\Icons\\INV_Misc_Head_Troll_01")
		end		
--	elseif event == "UNIT_SPELLCAST_START" then -- doesn't work + useless!
--		self:AddMsg(arg1, arg2)
--		self:AddMsg(UnitName(arg1.."target"))
	end
end
