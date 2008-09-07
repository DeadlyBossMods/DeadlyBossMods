local mod = DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30549)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnMarkSoon	= mod:NewAnnounce("WarningMarkSoon", 1, 28835)
local warnMarkNow	= mod:NewAnnounce("WarningMarkNow", 2, 28835)

local timerMark		= mod:NewTimer(12, "TimerMark", 28835)

local markCounter = 0

function mod:OnCombatStart(delay)
	markCounter = 0
	timerMark:Start(30, markCounter + 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 28832 then
		markCounter = markCounter + 1
		warnMarkNow:Show(markCounter)
		warnMarkSoon:Schedule(8, markCounter + 1)
		timerMark:Start(nil, markCounter + 1)
	end
end
