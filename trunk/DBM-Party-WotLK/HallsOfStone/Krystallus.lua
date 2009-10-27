local mod = DBM:NewMod("Krystallus", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27977)
mod:SetZone()

mod:RegisterCombat("combat")

local warningShatter	= mod:NewSpellAnnounce(50810, 3)
local timerShatterCD	= mod:NewCDTimer(25, 50810)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50833 then
		warningShatter:Show(GetSpellInfo(50810))	-- Shatter warning when Ground Slam is cast
		timerShatterCD:Start(GetSpellInfo(50810))
	end
end