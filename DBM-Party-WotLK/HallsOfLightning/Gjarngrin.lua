local mod = DBM:NewMod("Gjarngrin", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28586)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningWhirlwind = mod:NewAnnounce("WarningWhirlwind", 3, 52027)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52027 or args.spellId == 52028 then
		warningWhirlwind:Show()
	end
end