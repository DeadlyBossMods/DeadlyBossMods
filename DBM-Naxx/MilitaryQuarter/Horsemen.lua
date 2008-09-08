local mod = DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30549)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnMarkSoon			= mod:NewAnnounce("WarningMarkSoon", 1, 28835)
local warnMarkNow			= mod:NewAnnounce("WarningMarkNow", 2, 28835)
local specWarnMarkOnPlayer	= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer")

local timerMark				= mod:NewTimer(12, "TimerMark", 28835)

local markCounter = 0

function mod:OnCombatStart(delay)
	markCounter = 0
	timerMark:Start(17, markCounter + 1)
	warnMarkSoon:Schedule(13, markCounter + 1)
end

local markSpam = 0
function mod:SPELL_CAST_SUCCESS(args)
	if (args.spellId == 28832
	or args.spellId == 28833
	or args.spellId == 28834
	or args.spellId == 28835) and (GetTime() - markSpam) > 5 then
		markSpam = GetTime()
		markCounter = markCounter + 1
		warnMarkNow:Show(markCounter)
		warnMarkSoon:Schedule(8, markCounter + 1)
		timerMark:Start(nil, markCounter + 1)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if (args.spellId == 28832
	or args.spellId == 28833
	or args.spellId == 28834
	or args.spellId == 28835) and args.destName == UnitName("player") then
		if args.amount >= 4 then
			specWarnMarkOnPlayer:Show(args.spellName, args.amount)
		end
	end
end

