local mod	= DBM:NewMod(658, "DBM-Party-MoP", 1, 313)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56732)
mod:SetEncounterID(1416)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

local warnDragonStrike			= mod:NewSpellAnnounce(106823, 2)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnJadeDragonStrike		= mod:NewSpellAnnounce(106841, 3)
local warnPhase3				= mod:NewPhaseAnnounce(3)

local specWarnJadeDragonWave	= mod:NewSpecialWarningMove(118540)
local specWarnJadeFire			= mod:NewSpecialWarningMove(107110)

local timerDragonStrikeCD		= mod:NewNextTimer(10.5, 106823)
local timerJadeDragonStrikeCD	= mod:NewNextTimer(10.5, 106841)
local timerJadeFireCD			= mod:NewNextTimer(3.5, 107045)

function mod:OnCombatStart(delay)
--	timerDragonStrikeCD:Start(-delay)--Unknown, tank pulled before i could start a log to get an accurate first timer.
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 106823 then--Phase 1 dragonstrike
		warnDragonStrike:Show()
		timerDragonStrikeCD:Start()
	elseif args.spellId == 106841 then--phase 2 dragonstrike
		warnJadeDragonStrike:Show()
		timerJadeDragonStrikeCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 106797 then--Jade Essence removed, (Phase 3 trigger)
		warnPhase3:Show()
		timerJadeDragonStrikeCD:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 106797 then--Jade Essence (Phase 2 trigger)
		warnPhase2:Show()
		timerDragonStrikeCD:Cancel()
	elseif args.spellId == 107045 then
		timerJadeFireCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 107110 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnJadeFire:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 118540 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnJadeFire:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56762 then--Fight ends when Yu'lon dies.
		DBM:EndCombat(self)
	end
end
