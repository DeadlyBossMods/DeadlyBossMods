local mod = DBM:NewMod("Meathook", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26529)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warningChains	= mod:NewTargetAnnounce(52696, 4)
local timerChains	= mod:NewTargetTimer(5, 52696)
local timerChainsCD	= mod:NewCDTimer(15, 52696)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 52696 or args.spellId == 58823 then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
		timerChainsCD:Start()
	end
end