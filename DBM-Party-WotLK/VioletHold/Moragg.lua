local mod = DBM:NewMod("Moragg", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29316)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningLink 	= mod:NewAnnounce("WarningLink", 2, 54396)
local timerLink		= mod:NewTimer(12, "TimerLink", 54396)
local timerLinkCD	= mod:NewTimer(45, "TimerLinkCD", 54396)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 54396 then
		warningLink:Show(args.spellName, args.destName)
		timerLink:Start(args.spellName, args.destName)
		timerLinkCD:Cancel()
		timerLinkCD:Start(args.spellName)
	end
end