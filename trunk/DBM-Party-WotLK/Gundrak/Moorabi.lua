local mod = DBM:NewMod("Moorabi", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29305)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningTransform	= mod:NewAnnounce("WarningTransform", 3, 55098)

function mod:SPELL_CAST_START(args)
	if args.spellId == 55098 then
		warningTransform:Show(args.spellName)
	end
end