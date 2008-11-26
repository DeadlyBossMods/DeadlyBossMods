local mod = DBM:NewMod("Sladran", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29304)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warningNova	= mod:NewAnnounce("WarningNova", 3, 55081)
local warningBite	= mod:NewAnnounce("WarningBite", 2, 48287)

function mod:SPELL_CAST_START(args)
	if args.spellId == 55081 or args.spellId == 59842 then
		warningNova:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48287 or args.spellId == 59840 then
		warningBite:Show(args.destName)
	end
end