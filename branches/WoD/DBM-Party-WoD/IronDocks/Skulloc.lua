local mod	= DBM:NewMod(1238, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(86233)
mod:SetEncounterID(1754)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 168398",
	"SPELL_CAST_START 168929"
)

local warnRapidFire			= mod:NewTargetAnnounce(168398, 3)
local warnCannonBarrage		= mod:NewSpellAnnounce(168929, 4)

local specWarnRapidFire		= mod:NewSpecialWarningMoveAway(168398)
local yellRapidFire			= mod:NewYell(168398)
local specWarnCannonBarrage	= mod:NewSpecialWarningSpell(168929, nil, nil, nil, 3)--Use the one time cast trigger instead of drycode when relogging

--local timerWaveCD				= mod:NewTimer(12, "TimerWave", 69076)--Not wave timers in traditional sense. They are non stop, this is for when he activates certain mob types.


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 168398 then
		warnRapidFire:Show(args.destname)
		if args:IsPlayer() then
			specWarnRapidFire:Show()
			yellRapidFire:Yell()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 168929 then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
	end
end
