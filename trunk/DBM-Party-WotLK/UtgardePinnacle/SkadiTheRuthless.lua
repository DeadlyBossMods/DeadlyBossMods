local mod = DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(26693)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningWhirlwind		= mod:NewAnnounce("WarningWhirlwind", 3, 59322)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 59322 then
		warningWhirlwind:Show()
	end
end