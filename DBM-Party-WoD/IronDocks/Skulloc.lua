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
	"UNIT_SPELLCAST_INTERRUPTED boss1",
	"UNIT_DIED"
)

--TODO, verify gron smash numbers and see if it is time based or damage based.
local warnRapidFire			= mod:NewTargetAnnounce(168398, 3)
local warnGronSmash			= mod:NewSpellAnnounce(168227, 3)
local warnCannonBarrage		= mod:NewSpellAnnounce(168929, 4)
local warnBackdraft			= mod:NewCastAnnounce(169129, 4)

local specWarnRapidFire		= mod:NewSpecialWarningMoveAway(168398)
local yellRapidFire			= mod:NewYell(168398)
local specWarnGronSmash		= mod:NewSpecialWarningSpell(168227, nil, nil, nil, 2)
local specWarnCannonBarrage	= mod:NewSpecialWarningSpell(168929, nil, nil, nil, 3)--Use the one time cast trigger instead of drycode when relogging
local specWarnCannonBarrageE= mod:NewSpecialWarningEnd(168929)

local timerRapidFireCD		= mod:NewNextTimer(12, 168398)
local timerRapidFire		= mod:NewBuffFadesTimer(5, 168398)
local timerGronSmashCD		= mod:NewCDTimer(70, 168227)--Timer is too variable, which is why i never enabled. every time i kill boss it's diff. today 2nd gron smash happened at 49 seconds, 21 seconds sooner than this timer

local voiceRapidFire		= mod:NewVoice(168398)
local voiceCannonBarrage	= mod:NewVoice(168929)

mod.vb.flameCast = false

function mod:OnCombatStart(delay)
	self.vb.flameCast = false
	timerGronSmashCD:Start(30-delay)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:AddBoss(83613)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 168398 then
		warnRapidFire:Show(args.destName)
		timerRapidFireCD:Start()
		if args:IsPlayer() then
			specWarnRapidFire:Show()
			yellRapidFire:Yell()
			timerRapidFire:Start()
			voiceRapidFire:Play("runout")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168227 then
		timerRapidFireCD:Cancel()
		warnGronSmash:Show()
		specWarnGronSmash:Show()
--		timerGronSmashCD:Start()
		self.vb.flameCast = false
	elseif spellId == 168929 then
		warnCannonBarrage:Show()
		specWarnCannonBarrage:Show()
		voiceCannonBarrage:Play("findshelter")
	elseif spellId == 169129 and not self.vb.flameCast then
		self.vb.flameCast = true
		warnBackdraft:Show()
	end
end

--Not completely reliable. if you reach him between barrages, before he casts a new one, you won't interrupt any cast and get no event for it.
function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, _, spellId)
	if spellId == 168929 then
		specWarnCannonBarrageE:Show()
	end
end

function mod:UNIT_DIED(args)
	if not DBM.BossHealth:IsShown() then return end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 83613 then
		DBM.BossHealth:RemoveBoss(83613)
		DBM.BossHealth:AddBoss(83616)
	elseif cid == 83616 then
		DBM.BossHealth:RemoveBoss(83616)
	end
end
