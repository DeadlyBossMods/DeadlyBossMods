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
	"SPELL_CAST_START 217966 217986 217893",
	"SPELL_CAST_SUCCESS 217877",
	"SPELL_AURA_APPLIED 217563 217877 217831 217834",
	"SPELL_AURA_REMOVED 217877",
	"SPELL_PERIODIC_DAMAGE 217907",
	"SPELL_PERIODIC_MISSED 217907",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, promote howling gale to special warn if it is at all threatening
local warnAncientRageFire		= mod:NewSpellAnnounce(217563, 2)
local warnBurningBomb			= mod:NewSpellAnnounce(217877, 3)
local warnAncientRageFrost		= mod:NewSpellAnnounce(217831, 2)
local warnHowlingGale			= mod:NewSpellAnnounce(217966, 2)
local warnIcyComet				= mod:NewSpellAnnounce(217919, 2)
local warnAncientRageArcane		= mod:NewTargetAnnounce(217834, 2)

local specBurningBomb			= mod:NewSpecialWarningYou(217877, nil, nil, nil, 1, 2)--You warning because you don't have to run out unless healer is afk. However still warn in case they are
local yellBurningBomb			= mod:NewFadesYell(217877)
local specWrathfulFlames		= mod:NewSpecialWarningDodge(217893, nil, nil, nil, 1, 2)
local specWrathfulFlamesGTFO	= mod:NewSpecialWarningMove(217907, nil, nil, nil, 1, 2)
local specArcaneDesolation		= mod:NewSpecialWarningSpell(217986, nil, nil, nil, 2, 2)

local timerBurningBombCD		= mod:NewCDTimer(13.4, 217877, nil, nil, nil, 3)
local timerWrathfulFlamesCD		= mod:NewCDTimer(13.4, 217907, nil, nil, nil, 2)
local timerHowlingGaleCD		= mod:NewCDTimer(13.8, 217966, nil, nil, nil, 2)
local timerArcaneDesolationCD	= mod:NewCDTimer(12.2, 217986, nil, nil, nil, 2)

local voiceBurningBomb			= mod:NewVoice(217877)--targetyou
local voiceWrathfulFlames		= mod:NewVoice(217907)--watchstep/runaway
local voiceArcaneDesolation		= mod:NewVoice(217986)--carefly

mod:AddReadyCheckOption(43193, false)
mod:AddRangeFrameOption(10, 217877)

mod.vb.specialCast = 0

function mod:OnCombatStart(delay, yellTriggered)
	self.vb.specialCast = 0
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
		self.vb.specialCast = self.vb.specialCast + 1
		warnHowlingGale:Show()
		if self.vb.specialCast == 1 then
			timerHowlingGaleCD:Start()
		end
	elseif spellId == 217986 then
		self.vb.specialCast = self.vb.specialCast + 1
		specArcaneDesolation:Show()
		voiceArcaneDesolation:Play("carefly")
		if self.vb.specialCast == 1 then
			timerArcaneDesolationCD:Start()
		end
	elseif spellId == 217893 then
		specWrathfulFlames:Show()
		voiceWrathfulFlames:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 217877 then
		self.vb.specialCast = self.vb.specialCast + 1
		if self.vb.specialCast == 1 then
			timerBurningBombCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 217877 then
		warnBurningBomb:CombinedShow(0.3, args.destName)
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
	if spellId == 217907 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWrathfulFlamesGTFO:Show()
		voiceWrathfulFlames:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 217563 and self:AntiSpam(4, 1) then---Fire Phase
		self.vb.specialCast = 0
		warnAncientRageFire:Show()
		timerWrathfulFlamesCD:Start(7.4)
	elseif spellId == 217831 and self:AntiSpam(4, 2) then--Frost Phase
		self.vb.specialCast = 0
		warnAncientRageFrost:Show()
	elseif spellId == 217834 and self:AntiSpam(4, 3) then--Arcane Phase
		self.vb.specialCast = 0
		warnAncientRageArcane:Show()
	elseif spellId == 217919 and self:AntiSpam(4, 4) then--Icy Comet
		warnIcyComet:Show()
	end
end
