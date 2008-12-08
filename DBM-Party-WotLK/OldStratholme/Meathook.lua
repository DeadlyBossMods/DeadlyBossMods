local mod = DBM:NewMod("Meathook", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26529)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warningChains	= mod:NewAnnounce("WarningChains", 4, 52696)
local timerChains	= mod:NewTimer(5, "TimerChains", 52696)
local timerChainsCD	= mod:NewTimer(15, "TimerChainsCD", 52696)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 52696 or args.spellId == 58823 then
		warningChains:Show(args.spellName, args.destName)
		timerChains:Start(args.spellName, args.destName)
		timerChainsCD:Start(args.spellName)
	end
end