local mod = DBM:NewMod("ConstructorAndController", "DBM-Party-WotLK", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(24201)
mod:SetZone()

mod:RegisterCombat("combat", 24000, 24201)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningEnfeeble	= mod:NewAnnounce("WarningEnfeeble", 4, 43650)
local timerEnfeeble	= mod:NewTimer(6, "TimerEnfeeble", 43650)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 43650 then
		warningEnfeeble:Show(tostring(args.destName))
		timerEnfeeble:Start(tostring(args.destName))
	end
end