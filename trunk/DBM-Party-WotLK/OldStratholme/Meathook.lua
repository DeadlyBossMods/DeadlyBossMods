local mod = DBM:NewMod("Meathook", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26529)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warningChains	= mod:NewAnnounce("WarningChains", 4, 52969)
local timerChains	= mod:NewTimer(5, "TimerChains", 52969)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 52969 then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
	end
end