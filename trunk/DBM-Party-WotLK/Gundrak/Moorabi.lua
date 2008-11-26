local mod = DBM:NewMod("Moorabi", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29305)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningMojo	= mod:NewAnnounce("WarningMojo", 3, 55163)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 55163 then
		warningMojo:Show()
	end
end