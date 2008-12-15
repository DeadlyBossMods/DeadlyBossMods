local mod = DBM:NewMod("ChronoLordEpoch", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26532)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warningTime 	= mod:NewAnnounce("WarningTime", 3, 58848)
local warningCurse 	= mod:NewAnnounce("WarningCurse", 2, 52772)
local timerCurse	= mod:NewTimer(10, "TimerCurse", 52772)
local timerTimeCD	= mod:NewTimer(25, "TimerTimeCD", 58848)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 58848 then
		warningTime:Show(args.spellName)
		timerTimeCD:Start(args.spellName)
	elseif args.spellId == 52766 then
		warningTime:Show(args.spellName)
		timerTimeCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52772 then
		warningCurse:Show(args.spellName, args.destName)
		timerCurse:Start(args.spellName, args.destName)
	end
end