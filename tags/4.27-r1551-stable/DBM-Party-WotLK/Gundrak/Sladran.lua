local mod = DBM:NewMod("Sladran", "DBM-Party-WotLK", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29304)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningNova	= mod:NewAnnounce("WarningNova", 3, 55081)
local timerNovaCD	= mod:NewTimer(24, "TimerNovaCD", 55081)

function mod:SPELL_CAST_START(args)
	if args.spellId == 55081 or args.spellId == 59842 then
		warningNova:Show(args.spellName)
		timerNovaCD:Start(args.spellName)
	end
end