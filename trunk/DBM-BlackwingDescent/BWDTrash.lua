local mod	= DBM:NewMod("BWDTrash", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBPGreen			= mod:NewTargetAnnounce(80369, 3)--This is the one that allows them to stun entire raid for 6 seconds cast by dogs.
local warnEnrage			= mod:NewTargetAnnounce(80084, 3)--This is enrage effect for Maimgor drake in front of maloriaks area.
local warnSacrifice			= mod:NewTargetAnnounce(80727, 2)--Sacrifice used by spirits before atramedes
local warnWhirlwind			= mod:NewTargetAnnounce(80652, 2)--Whirlwind used by spirits before atramedes

local timerSacrifice		= mod:NewTargetTimer(20, 80727)
local timerWhirlwind		= mod:NewTargetTimer(5, 80652)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71127) then
		warnBPGreen:Show(args.destName)
	elseif args:IsSpellID(71127) then--I will have to log this trash to verify this spell event.
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	elseif args:IsSpellID(80084) then
		warnEnrage:Show(args.destName)
	elseif args:IsSpellID(80652) then--I will have to log this trash to verify this spell event.
		warnWhirlwind:Show(args.destName)
		timerWhirlwind:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(71159) then
		timerSacrifice:Cancel(args.destName)
	elseif args:IsSpellID(80652) then
		timerWhirlwind:Cancel(args.destName)
	end
end
