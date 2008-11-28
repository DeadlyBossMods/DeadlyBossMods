local mod = DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26693)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningPoison		= mod:NewAnnounce("WarningPoison", 2, 59331)
local warningWhirlwind		= mod:NewAnnounce("WarningWhirlwind", 3, 59332)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59332 or args.spellId == 50228 then
		warningWhirlwind:Show()
	elseif args.spellId == 59331 or args.spellId == 50255 then
		warningPoison:Show(args.destName)
	end
end