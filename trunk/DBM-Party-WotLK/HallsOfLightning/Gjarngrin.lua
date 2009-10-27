local mod = DBM:NewMod("Gjarngrin", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28586)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningWhirlwind = mod:NewSpellAnnounce(52027, 3)

function mod:SPELL_CAST_START(args)
	if args.spellId == 52027 or args.spellId == 52028 then
		warningWhirlwind:Show(args.spellName)
	end
end