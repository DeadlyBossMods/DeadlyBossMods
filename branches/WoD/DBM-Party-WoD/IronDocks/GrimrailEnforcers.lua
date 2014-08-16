local mod	= DBM:NewMod(1236, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(80805, 80816, 80808)
mod:SetEncounterID(1748)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 163689",
	"SPELL_AURA_REMOVED 163689"
)


local warnSanguineSphere		= mod:NewTargetAnnounce(163689, 3)

local specWarnSanguineSphere	= mod:NewSpecialWarningReflect(163689)

local timerSanguineSphere        	= mod:NewTargetTimer(15, 163689)


function mod:OnCombatStart(delay)

end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 163689 then
		warnSanguineSphere:Show(args.destName)
		specWarnSanguineSphere:Show(args.destName)
		timerSanguineSphere:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 163689 then
		timerSanguineSphere:Cancel(args.destName)
	end
end
