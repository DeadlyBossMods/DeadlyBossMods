local mod	= DBM:NewMod(1774, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(109331)
mod:SetEncounterID(1952)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 217966 217986",
	"SPELL_CAST_SUCCESS 217877",
	"SPELL_AURA_APPLIED 217563 217877 217831 217834",
	"SPELL_AURA_REMOVED 217877",
	"SPELL_PERIODIC_DAMAGE 217907",
	"SPELL_PERIODIC_MISSED 217907"
)

--TODO, cast id for icy commet. It's one of the scripts
--TODO< cast id for Arcanopulse. It's one of the scripts.
--TODO, promote howling gale to special warn if it is at all threatening
local warnAncientRageFire		= mod:NewTargetAnnounce(217563, 2)
local warnBurningBomb			= mod:NewTargetAnnounce(217877, 3)
local warnAncientRageFrost		= mod:NewTargetAnnounce(217831, 2)
local warnHowlingGale			= mod:NewSpellAnnounce(217966, 2)
local warnAncientRageArcane		= mod:NewTargetAnnounce(217834, 2)

local specBurningBomb			= mod:NewSpecialWarningYou(217877, nil, nil, nil, 1, 2)--You warning because you don't have to run out unless healer is afk. However still warn in case they are
local yellBurningBomb			= mod:NewFadesYell(217877)
local specBurningBombDispel		= mod:NewSpecialWarningDispel(217877, "Healer", nil, nil, 1, 2)
local specWrathfulFlamesGTFO	= mod:NewSpecialWarningMove(217907, nil, nil, nil, 1, 2)
local specArcaneDesolation		= mod:NewSpecialWarningSpell(217986, nil, nil, nil, 2, 2)

local timerBurningBombCD		= mod:NewAITimer(16, 217877, nil, nil, nil, 3)
local timerHowlingGaleCD		= mod:NewAITimer(16, 217966, nil, nil, nil, 2)
local timerArcaneDesolationCD	= mod:NewAITimer(16, 217986, nil, nil, nil, 2)

local voiceBurningBomb			= mod:NewVoice(217877)--targetyou/helpdispel
local voiceWrathfulFlames		= mod:NewVoice(217907)--runaway
local voiceArcaneDesolation		= mod:NewVoice(217986)--carefly

--mod:AddReadyCheckOption(37460, false)
mod:AddRangeFrameOption(10, 217877)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 217966 then
		warnHowlingGale:Show()
		timerHowlingGaleCD:Start()
	elseif spellId == 217986 then
		specArcaneDesolation:Show()
		voiceArcaneDesolation:Play("carefly")
		timerArcaneDesolationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 217877 then
		timerBurningBombCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 217563 then--Fire Phase
		warnAncientRageFire:Show(args.destName)
		timerHowlingGaleCD:Stop()
		timerArcaneDesolationCD:Stop()
		timerBurningBombCD:Start(1)
	elseif spellId == 217877 then
		if self.Options.SpecWarn217877dispel then
			specBurningBombDispel:CombinedShow(0.3, args.destName)
			if self:AntiSpam(3, 1) then
				voiceBurningBomb:Play("helpdispel")
			end
		else
			warnBurningBomb:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() then
			specBurningBomb:Show()
			voiceBurningBomb:Play("targetyou")
			yellBurningBomb:Schedule(7, 1)
			yellBurningBomb:Schedule(6, 2)
			yellBurningBomb:Schedule(5, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 217831 then--Frost Phase
		warnAncientRageFrost:Show(args.destName)
		timerBurningBombCD:Stop()
		timerArcaneDesolationCD:Stop()
		timerHowlingGaleCD:Start(1)
	elseif spellId == 217834 then--Arcane Phase
		warnAncientRageArcane:Show(args.destName)
		timerHowlingGaleCD:Stop()
		timerBurningBombCD:Stop()
		timerArcaneDesolationCD:Start(1)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 217877 then
		if args:IsPlayer() then
			yellBurningBomb:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 217907 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWrathfulFlamesGTFO:Show()
		voiceWrathfulFlames:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
