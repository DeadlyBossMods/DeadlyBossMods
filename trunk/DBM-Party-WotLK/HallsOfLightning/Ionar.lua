local mod = DBM:NewMod("Ionar", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28546)
mod:SetZone()

mod:RegisterCombat("combat")

local warningOverload	= mod:NewAnnounce("WarningOverload", 3, 52658)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52658 or args.spellId == 59796 then
		warningOverload:Show(args.destName)
	end
end