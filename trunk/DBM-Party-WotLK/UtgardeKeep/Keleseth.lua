local mod = DBM:NewMod("Keleseth", "DBM-Party-WotLK", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23953)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningTomb	= mod:NewAnnounce("WarningTomb", 4, 48400)

local timerTomb		= mod:NewTimer(10, "TimerTomb", 48400)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48400 then
		warningTomb:Show(tostring(args.destName))
		timerTomb:Start(tostring(args.destName))
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48400 then
		timerTomb:Cancel()
	end
end