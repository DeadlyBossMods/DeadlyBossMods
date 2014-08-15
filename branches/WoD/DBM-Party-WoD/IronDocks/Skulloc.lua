local mod	= DBM:NewMod(1238, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83612)
mod:SetEncounterID(1754)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 168398",
	"SPELL_CAST_START 168929 168227",
	"UNIT_SPELLCAST_CHANNEL_STOP"
)

--TODO, verify gron smash numbers and see if it is time based or damage based.
local warnRapidFire			= mod:NewTargetAnnounce(168398, 3)
local warnGronSmash			= mod:NewSpellAnnounce(168227, 3)
local warnCannonBarrage		= mod:NewSpellAnnounce(168929, 4)

local specWarnRapidFire		= mod:NewSpecialWarningMoveAway(168398)
local yellRapidFire			= mod:NewYell(168398)
local specWarnGronSmash		= mod:NewSpecialWarningSpell(168227, nil, nil, nil, 2)
local specWarnCannonBarrage	= mod:NewSpecialWarningSpell(168929, nil, nil, nil, 3)--Use the one time cast trigger instead of drycode when relogging
local specWarnCannonBarrageE= mod:NewSpecialWarningEnd(168929)

local timerRapidFireCD		= mod:NewNextTimer(12, 168398)
--local timerGronSmashCD	= mod:NewCDTimer(67, 168227)--Not wave timers in traditional sense. They are non stop, this is for when he activates certain mob types.

function mod:OnCombatStart(delay)
--	timerGronSmashCD:Start(32-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 168398 then
		warnRapidFire:Show(args.destname)
		timerRapidFireCD:Start()
		if args:IsPlayer() then
			specWarnRapidFire:Show()
			yellRapidFire:Yell()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 168227 then
		timerRapidFireCD:Cancel()
		warnGronSmash:Show()
		specWarnGronSmash:Show()
		--timerGronSmashCD:Start()
	elseif args.spellId == 168929 then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
	end
end

--Not completely reliable. if you reach him between barrages, before he casts a new one, you won't interrupt any cast and get no event for it.
function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, _, spellId)
	if spellId == 168929 then
		specWarnCannonBarrageE:Show()
	end
end
