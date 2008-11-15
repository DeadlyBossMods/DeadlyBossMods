local mod = DBM:NewMod("MalGanis", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26533)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningSleep	= mod:NewAnnounce("WarningSleep", 3, 52721)
local timerSleep	= mod:NewTimer(10, "TimerSleep", 52721)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52721 then
		warningSleep:Show(args.destName)
		timerSleep:Start(nil, tostring(args.destName))
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 52721 then
		timerSleep:Cancel()
	end
end