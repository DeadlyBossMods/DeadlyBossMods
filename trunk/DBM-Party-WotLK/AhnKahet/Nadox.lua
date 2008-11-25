local mod = DBM:NewMod("Nadox", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29309)
mod:SetZone()

mod:RegisterCombat("combat")

local warningPlague	= mod:NewAnnounce("WarningPlague", 3, 56130)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 56130 or args.spellId == 59467 then
		warningPlague:Show(tostring(args.destName))
	end
end