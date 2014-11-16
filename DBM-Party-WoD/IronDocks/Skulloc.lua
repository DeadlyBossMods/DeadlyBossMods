local mod	= DBM:NewMod(1238, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83612)
mod:SetEncounterID(1754)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 168398",
	"SPELL_CAST_START 168929 168227 169129",
	"UNIT_SPELLCAST_CHANNEL_STOP"
)

--TODO, verify gron smash numbers and see if it is time based or damage based.
--TODO, maybe check player map position and squelch backdraft warning if safe.
local warnRapidFire			= mod:NewTargetAnnounce(168398, 3)
local warnGronSmash			= mod:NewSpellAnnounce(168227, 3)
local warnCannonBarrage		= mod:NewSpellAnnounce(168929, 4)
local warnBackdraft			= mod:NewCastAnnounce(169129, 4)

local specWarnRapidFire		= mod:NewSpecialWarningMoveAway(168398)
local yellRapidFire			= mod:NewYell(168398)
local specWarnGronSmash		= mod:NewSpecialWarningSpell(168227, nil, nil, nil, 2)
local specWarnBackdraft		= mod:NewSpecialWarningSpell(169129)
local specWarnCannonBarrage	= mod:NewSpecialWarningSpell(168929, nil, nil, nil, 3)--Use the one time cast trigger instead of drycode when relogging
local specWarnCannonBarrageE= mod:NewSpecialWarningEnd(168929)

local timerRapidFireCD		= mod:NewNextTimer(12, 168398)
local timerGronSmashCD		= mod:NewCDTimer(67, 168227)--too variable, 58-71, I believe health based, except first, which always seems to be 30 seconds no matter what.
local timerBackdraft		= mod:NewCastTimer(3, 169129)

function mod:OnCombatStart(delay)
	timerGronSmashCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 168398 then
		warnRapidFire:Show(args.destName)
		timerRapidFireCD:Start()
		if args:IsPlayer() then
			specWarnRapidFire:Show()
			yellRapidFire:Yell()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168227 then
		timerRapidFireCD:Cancel()
		warnGronSmash:Show()
		specWarnGronSmash:Show()
		--timerGronSmashCD:Start()
	elseif spellId == 168929 then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
	elseif spellId == 169129 then
		warnBackdraft:Show()
		specWarnBackdraft:Show()
		timerBackdraft:Start()
	end
end

--Not completely reliable. if you reach him between barrages, before he casts a new one, you won't interrupt any cast and get no event for it.
function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, _, _, spellId)
	if spellId == 168929 then
		specWarnCannonBarrageE:Show()
	end
end
