local mod = DBM:NewMod("SjonnirTheIronshaper", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27978)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCharge	= mod:NewAnnounce("WarningCharge", 3, 50834)
local warningRing	= mod:NewAnnounce("WarningRing", 3, 50840)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59849 or args.spellId == 50840 then
		warningRing:Show()
	elseif args.spellId == 50834 then
		warningCharge:Show(args.destName)
	end
end