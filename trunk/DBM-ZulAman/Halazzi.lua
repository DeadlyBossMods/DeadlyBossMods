local Halazzi = DBM:NewBossMod("Halazzi", DBM_HALAZZI_NAME, DBM_HALAZZI_DESCRIPTION, DBM_ZULAMAN, DBM_ZULAMAN_TAB, 4);

Halazzi.Version	= "1.0";
Halazzi.Author	= "Tandanu";

Halazzi:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

Halazzi:SetCreatureID(23577)
Halazzi:RegisterCombat("yell", DBM_HALAZZI_YELL_PULL)

Halazzi:AddOption("Frenzy", true, DBM_HALAZZI_OPTION_FRENZY)
Halazzi:AddOption("Totem", true, DBM_HALAZZI_OPTION_TOTEM)

function Halazzi:OnEvent(event, args)
	if event == "CHAT_MSG_MONSTER_YELL" then
		if arg1 == DBM_HALAZZI_YELL_SPIRIT then
			self:Announce(DBM_HALAZZI_WARN_SPIRIT, 1)
		elseif arg1 == DBM_HALAZZI_YELL_SPIRIT_DESP then
			self:Announce(DBM_HALAZZI_WARN_SPIRIT_DESP, 1)
		end
	elseif event == "SPELL_CAST_START" then
		if args.spellId == DBM_HALAZZI_SPELLID_TOTEM and self.Options.Totem then
			self:Announce(DBM_HALAZZI_WARN_TOTEM, 2)
		end
	elseif event == "SPELL_AURA_APPLIED" then
		if args.spellName == DBM_HALAZZI_SPELL_FRENZY and args.destName == DBM_HALAZZI_NAME and self.Options.Frenzy then
			self:Announce(DBM_HALAZZI_WARN_FRENZY, 3)
		end
	end	
end
