local Kazrogal = DBM:NewBossMod("Kazrogal", DBM_KAZROGAL_NAME, DBM_KAZROGAL_DESCRIPTION, DBM_MOUNT_HYJAL, DBM_HYJAL_TAB, 3);

Kazrogal.Version	= "1.0";
Kazrogal.Author		= "Tandanu";

local counter = 0;

Kazrogal:SetCreatureID(17888)
Kazrogal:RegisterCombat("yell", DBM_KAZROGAL_YELL_PULL)
Kazrogal:SetMinCombatTime(80)

Kazrogal:RegisterEvents(
	"SPELL_AURA_APPLIED"
);

function Kazrogal:OnCombatStart()
	counter = 0;
end

function Kazrogal:OnEvent(event, args)
	if event == "SPELL_AURA_APPLIED" then
		if args.spellId == 31447 then
			self:SendSync("Debuff")
		end	
	end
end

function Kazrogal:OnSync(msg)
	if msg == "Debuff" then
		counter = counter + 1;
		self:Announce(DBM_KAZROGAL_WARN_MARK:format(counter), 2); -- timer?
	end
end