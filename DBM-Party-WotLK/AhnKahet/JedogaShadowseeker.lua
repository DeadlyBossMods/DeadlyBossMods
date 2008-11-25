local mod = DBM:NewMod("JedogaShadowseeker", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29310)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warningThundershock	= mod:NewAnnounce("WarningThundershock", 3, 56926)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 56926 or args.spellId == 60029 then
		warningThundershock:Show()
	end
end