local Malacrass = DBM:NewBossMod("Malacrass", DBM_MALACRASS_NAME, DBM_MALACRASS_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 5)

Malacrass.Version	= "1.1"
Malacrass.Author	= "Tandanu"
Malacrass.MinRevision = 820

Malacrass:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

Malacrass:SetCreatureID(24239)
Malacrass:RegisterCombat("yell", DBM_MALACRASS_YELL_PULL)

Malacrass:AddBarOption("Next Spirit Bolts")
Malacrass:AddBarOption("Spirit Bolts")
Malacrass:AddBarOption("Siphon Soul: (.*)")

function Malacrass:OnEvent(event, args)
	if event == "SPELL_AURA_APPLIED" then
		if args.spellId == DBM_MALACRASS_SPELLID_SIPHON then
			self:SendSync("Siphon"..tostring(args.destName))
		end
	elseif event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_MALACRASS_YELL_BOLTS then
			self:SendSync("Bolts")
		end
	end
end

function Malacrass:OnSync(msg)
	if msg:sub(0, 6) == "Siphon" then
		msg = msg:sub(7)
		self:Announce(DBM_MALACRASS_WARN_SIPHON:format(msg), 2)
		local class
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i) == msg then
				_, class = UnitClass("raid"..i)
				break
			end
		end
		if not class then
			class = msg
		else
			class = class:sub(0, 1):upper()..class:sub(2):lower()
		end
		self:StartStatusBarTimer(30, "Siphon Soul: "..class, "Interface\\Icons\\Spell_Shadow_SoulLeech_2")
	elseif msg == "Bolts" then
		self:StartStatusBarTimer(40, "Next Spirit Bolts", "Interface\\Icons\\Spell_Shadow_ShadowBolt")
		self:StartStatusBarTimer(10, "Spirit Bolts", "Interface\\Icons\\Spell_Shadow_ShadowBolt")
		self:Announce(DBM_MALACRASS_WARN_BOLTS, 3)
		self:ScheduleAnnounce(35, DBM_MALACRASS_WARN_BOLTS_SOON, 1)
	end
end
