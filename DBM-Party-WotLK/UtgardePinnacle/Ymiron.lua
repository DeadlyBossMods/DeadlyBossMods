local mod = DBM:NewMod("Ymiron", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26861)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningBane	= mod:NewSpellAnnounce(48294, 3)

function mod:APELL_AURA_APPLIED(args)
	if args.spellId == 48294 then
		warningBane:Show()
	end
end