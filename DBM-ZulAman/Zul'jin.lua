local ZulJin = DBM:NewBossMod("ZulJin", DBM_ZULJIN_NAME, DBM_ZULJIN_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 6);

ZulJin.Version	= "1.1";
ZulJin.Author	= "Tandanu";

ZulJin:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

ZulJin:SetCreatureID(23863)
ZulJin:RegisterCombat("yell", DBM_ZULJIN_YELL_PULL)

ZulJin:AddOption("WarnPara", true, DBM_ZULJIN_OPTION_PARA)
ZulJin:AddOption("WarnLynx", true, DBM_ZULJIN_OPTION_LYNX)

function ZulJin:OnCombatStart()
	self:Announce(DBM_ZULJIN_WARN_PHASE_1, 1)
end

function ZulJin:OnEvent(event, args)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_ZULJIN_WARN_PHASE_2 then
			self:Announce(DBM_ZULJIN_WARN_PHASE_2, 1)
		elseif arg1 == DBM_ZULJIN_WARN_PHASE_3 then
			self:Announce(DBM_ZULJIN_WARN_PHASE_3, 1)
		elseif arg1 == DBM_ZULJIN_WARN_PHASE_4 then
			self:Announce(DBM_ZULJIN_WARN_PHASE_4, 1)
		elseif arg1 == DBM_ZULJIN_WARN_PHASE_5 then
			self:Announce(DBM_ZULJIN_WARN_PHASE_5, 1)
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if args.spellId == DBM_ZULJIN_SPELLID_PARALYSIS then
			self:SendSync("Paralysis")
		elseif args.spellId == DBM_ZULJIN_SPELLID_LYNX then
			self:SendSync("Lynx"..tostring(args.destName))
		elseif args.spellId == DBM_ZULJIN_SPELLID_DOT then
			self:SendSync("Throw"..tostring(args.destName))
		end
	end
end

function ZulJin:OnSync(msg)
	if msg == "Paralysis" then
		if self.Options.WarnPara then
			self:Announce(DBM_ZULJIN_WARN_PARALYSIS, 2)
			self:ScheduleAnnounce(23, DBM_ZULJIN_WARN_PARALYSIS_SOON, 1)
		end
		self:StartStatusBarTimer(27, "Creeping Paralysis", "Interface\\Icons\\Spell_Nature_TimeStop")
	elseif msg:sub(0, 4) == "Lynx" then
		msg = msg:sub(5)
		if self.Options.WarnLynx then
			self:Announce(DBM_ZULJIN_WARN_LYNX:format(msg), 2)
		end
	elseif msg:sub(0, 5) == "Throw" then
		msg = msg:sub(6)
		self:Announce(DBM_ZULJIN_WARN_DOT:format(msg), 2)
	end
end
