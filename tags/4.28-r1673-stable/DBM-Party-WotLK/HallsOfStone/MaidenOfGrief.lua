local mod = DBM:NewMod("MaidenOfGrief", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(27975)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warningWoe	= mod:NewAnnounce("WarningWoe", 2, 50761)
local warningSorrow	= mod:NewAnnounce("WarningSorrow", 1, 50760)
local warningStorm	= mod:NewAnnounce("WarningStorm", 3, 50752)

local timerWoe		= mod:NewTimer(10, "TimerWoe", 50761)
local timerSorrow	= mod:NewTimer(6, "TimerSorrow", 50760)
local timerStormCD	= mod:NewTimer(20, "TimerStormCD", 50752)
local timerSorrowCD	= mod:NewTimer(30, "TimerSorrowCD", 50760)
local timerAchieve			= mod:NewAchievementTimer(60, 1866, "TimerSpeedKill") 

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50760 or args.spellId == 59726 then
		timerSorrow:Start(args.spellName)
		warningSorrow:Show(args.spellName)
		timerSorrowCD:Start(args.spellName)
	elseif args.spellId == 50752 or args.spellId == 59772 then
		warningStorm:Show(args.spellName)
		timerStormCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 50761 or args.spellId == 59727 then
		warningWoe:Show(args.spellName, args.destName)
		timerWoe:Start(args.spellName, args.destName)
	end
end