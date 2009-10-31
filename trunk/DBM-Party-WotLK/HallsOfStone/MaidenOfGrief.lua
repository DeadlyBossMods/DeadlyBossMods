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

local warningWoe	= mod:NewTargetAnnounce(50761, 2)
local warningSorrow	= mod:NewSpellAnnounce(50760, 1)
local warningStorm	= mod:NewSpellAnnounce(50752, 3)

local timerWoe		= mod:NewTargetTimer(10, 50761)
local timerSorrow	= mod:NewBuffActiveTimer(6, 50760)
local timerStormCD	= mod:NewCDTimer(20, 50752)
local timerSorrowCD	= mod:NewCDTimer(30, 50760)
local timerAchieve	= mod:NewAchievementTimer(60, 1866, "TimerSpeedKill")

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50760 or args.spellId == 59726 then
		timerSorrow:Start()
		warningSorrow:Show()
		timerSorrowCD:Start()
	elseif args.spellId == 50752 or args.spellId == 59772 then
		warningStorm:Show()
		timerStormCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 50761 or args.spellId == 59727 then
		warningWoe:Show(args.destName)
		timerWoe:Start(args.destName)
	end
end